require 'rubygems'
require 'rake'

# Set up a test Pivotal project for the Cucumber tests to use
ENV['PIVOTAL_API_KEY'] = "" # your API key
ENV['PIVOTAL_TEST_PROJECT'] = "" # your test project ID (123456)
ENV['PIVOTAL_USER'] = "" # Your user name (Joe Smith)

$LOAD_PATH.unshift('lib')

task :default => [:spec, :features]

task :spec do
  begin
    require 'rspec/core/rake_task'
    RSpec::Core::RakeTask.new do |t|
      t.rspec_opts = ['--color']
    end
  rescue LoadError => e
    puts "RSpec not installed"
  end
end

task :features do
  begin
    require 'cucumber/rake/task'

    if [ENV['PIVOTAL_API_KEY'], ENV['PIVOTAL_TEST_PROJECT'], ENV['PIVOTAL_USER']].any? { |x| x.nil? || x.empty? }
      raise "ERROR: API key, test project, and user must be set in the Rakefile for the Cucumber tests to run"
    end

    Cucumber::Rake::Task.new(:features) do |t|
      t.cucumber_opts = "features --format pretty"
    end
  rescue LoadError => e
    puts "Cucumber not installed"
  end
end

