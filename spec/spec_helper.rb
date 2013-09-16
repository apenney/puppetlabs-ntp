require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-hiera-puppet'

fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))

shared_context "hiera" do
  let(:hiera_config) do
    { :hierarchy => [
        ['osfamily', '$osfamily', 'data/osfamily/$osfamily'],
        ['operatingsystem', '$operatingsystem', 'data/operatingsystem/$operatingsystem'],
        ['environment', '$environment', 'data/env/$environment'],
        ['common', 'true', 'data/common'],
        '%{fqdn}/%{calling_module}',
        '%{calling_module}'], }
  end
end
