node 'appserver' {
  Exec {
  path => '/bin:/usr/bin:/sbin:/usr/sbin:...',
  }

  package { 'curl':
    ensure => 'installed',
    before => Exec['install script'],
  }

  exec { 'install script':
    command => 'curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -',
  }

  exec { 'apt-get-update':
  command     => '/usr/bin/apt-get update',
  refreshonly => true,
  }

  $packages = ["nodejs", "npm"]

  package { $packages:
    ensure => installed,
    require => Exec['apt-get-update', 'install script'],
  }

}

node 'dbserver' {

  exec { 'apt-get update':
    command => 'sudo apt-get update',
    path    => ['/bin', '/usr/bin'],
  }

  package { ['mysql-server']:
    ensure => present,
    require => Exec['apt-get update'],
  }

  service { 'mysql':
    ensure  => running,
    require => Package['mysql-server'],
  }
  
}
