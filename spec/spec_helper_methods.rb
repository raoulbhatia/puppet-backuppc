def os_specific_options(facts)
  case facts[:os]['family']
  when 'RedHat'
    { group_apache: 'apache', topdir: '/var/lib/BackupPC' }
  when 'Debian'
    { group_apache: 'www-data', topdir: '/var/lib/backuppc' }
  end
end
