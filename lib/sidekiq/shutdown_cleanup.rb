require "sidekiq/shutdown_cleanup/version"
require "sidekiq/shutdown_cleanup/middleware"

Sidekiq.configure_server do |config|
  config.on(:shutdown) do
    # Installs a hook which allows the middleware to function
    Sidekiq::ShutdownCleanup::Middleware.shutdown!
  end
end
