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
      context 'with defaults' do
        it { is_expected.to contain_class('backuppc::server') }
        it { is_expected.to contain_class('backuppc::params') }
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_package('backuppc') }
        it do
          is_expected.to contain_file('config_directory').with(
            ensure: 'directory',
            group: options[:group_apache],
          )
        end
        it do
          is_expected.to contain_file('config.pl').with(
            ensure: 'present',
            group: options[:group_apache],
            mode: '0640',
          )
        end
        it { is_expected.to contain_file('pc_directory_symlink').with_ensure('link') }
        it { is_expected.to contain_service('backuppc').with_ensure(true) }
        it { is_expected.to contain_file('topdir').with_ensure('directory') }
        it { is_expected.to contain_file('topdir_ssh').with_ensure('directory') }
        it { is_expected.to contain_file('apache_config').with_ensure('present') }
        it { is_expected.to contain_backuppc__server__user('backuppc').with_password('test_password') }
      end
    end
  end
end
