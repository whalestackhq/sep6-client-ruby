# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'sep6_client/config'

Gem::Specification.new do |s|
  s.name        = 'sep6_client'
  s.version     = Sep6Client::CLIENT_VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['COINQVEST LLC']
  s.email       = ['service@coinqvest.com']
  s.homepage    = 'https://www.coinqvest.com'
  s.summary     = %q{Ruby based Stellar SEP-6 Client by COINQVEST}
  s.licenses    = ['Apache-2.0']
  s.required_ruby_version = '>= 2.0.0'

  s.add_runtime_dependency 'rest-client', '~> 2.1', '>= 2.1.0'
  s.add_runtime_dependency 'json', '~> 2.3', '>= 2.3.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end