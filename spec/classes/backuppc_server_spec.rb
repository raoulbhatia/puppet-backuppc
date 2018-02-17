require 'spec_helper'

describe 'backuppc::server' do
  describe 'On an unknown operating system' do
    let(:facts) { { 'os' => { 'family' => 'Unknown', 'name' => 'Unknown' } } }

    it { is_expected.to compile.and_raise_error(%r{is not supported by this module}) }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      let(:params) { { 'backuppc_password' => 'test_password' } }

      options = os_specific_options(facts)
      it { is_expected.to contain_class('backuppc::params') }
      it { is_expected.to contain_package(options[:package]) }
      it { is_expected.to compile.with_all_deps }
    end
  end
end
