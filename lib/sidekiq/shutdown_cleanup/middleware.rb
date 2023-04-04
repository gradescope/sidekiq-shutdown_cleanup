module Sidekiq
  module ShutdownCleanup
    # Middleware that facilitates shutting down Sidekiq workers cleanly
    class Middleware
      @@shutting_down = false

      def self.shutdown!
        @@shutting_down = true
        Sidekiq.logger.info 'Shutting down long running tasks'
      end

      def safe_execute(worker, args)
        thread = Thread.new do
          Rails.application.executor.wrap do
            yield
          end
        end
        # While the thread has not terminated
        while thread.status
          if @@shutting_down
            worker.logger.info 'Terminating worker prior to shutdown'
            start = Time.now
            thread.kill
            worker.shutdown_cleanup
            elapsed = Time.now - start
            worker.logger.info "Terminated worker cleanly in #{elapsed} seconds"
            worker.class.perform_async(*args)
          else
            sleep 2
          end
        end
      end

      def call(worker, item, queue, &block)
        if worker.respond_to? :shutdown_cleanup
          safe_execute(worker, item['args'], &block)
        else
          yield
        end
      end
    end
  end
end
