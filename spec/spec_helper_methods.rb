def os_specific_options(facts)
  case facts[:os]['family']
  when 'RedHat'
    { package: 'BackupPC', service: 'backuppc', topdir: '/var/lib/BackupPC' }
  when 'Debian'
    { package: 'backuppc', service: 'backuppc', topdir: '/var/lib/backuppc' }
  end
end
