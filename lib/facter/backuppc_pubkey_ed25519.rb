Facter.add('backuppc_pubkey_ed25519') do
  setcode do
    os_family   = Facter.value(:osfamily)
    sshkey_path ||= case Facter.value(:osfamily)
    when 'RedHat'
      '/var/lib/BackupPC/.ssh/id_ed25519.pub'
    when 'Debian'
      '/var/lib/backuppc/.ssh/id_ed25519.pub'
    end
    
    if File.exists?(sshkey_path)
      File.open(sshkey_path).read.split(' ')[1]
    end
  end
end
