# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sidekiq/shutdown_cleanup/version'

Gem::Specification.new do |spec|
  spec.name          = 'sidekiq-shutdown_cleanup'
  spec.version       = Sidekiq::ShutdownCleanup::VERSION
  spec.authors       = ['Ibrahim Awwal']
  spec.email         = ['ibrahim.awwal@gmail.com']

  spec.summary       = %q{Sidekiq Shutdown Cleanup middleware}
  spec.description   = %q{Middleware for gracefully shutting down Sidekiq workers.}
  spec.homepage      = "https://github.com/gradescope/sidekiq-shutdown_cleanup"
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_runtime_dependency 'sidekiq', '>= 3.0'
end
