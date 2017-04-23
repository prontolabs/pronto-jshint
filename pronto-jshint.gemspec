# -*- encoding: utf-8 -*-
#
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'pronto/jshint/version'
require 'English'

Gem::Specification.new do |s|
  s.name = 'pronto-jshint'
  s.version = Pronto::JSHintVersion::VERSION
  s.platform = Gem::Platform::RUBY
  s.author = 'Mindaugas Mozūras'
  s.email = 'mindaugas.mozuras@gmail.com'
  s.homepage = 'http://github.com/mmozuras/pronto-jshint'
  s.summary = 'Pronto runner for JSHint, JavaScript code quality tool'

  s.licenses = ['MIT']
  s.required_ruby_version = '>= 2.0.0'
  s.rubygems_version = '1.8.23'

  s.files = `git ls-files`.split($RS).reject do |file|
    file =~ %r{^(?:
    spec/.*
    |Gemfile
    |Rakefile
    |\.rspec
    |\.gitignore
    |\.rubocop.yml
    |\.travis.yml
    )$}x
  end
  s.test_files = []
  s.extra_rdoc_files = ['LICENSE', 'README.md']
  s.require_paths = ['lib']

  s.add_dependency('pronto', '~> 0.9.0')
  s.add_dependency('jshintrb', '~> 0.3.0')
  s.add_development_dependency('rake', '~> 12.0')
  s.add_development_dependency('rspec', '~> 3.4')
  s.add_development_dependency('rspec-its', '~> 1.2')
end
