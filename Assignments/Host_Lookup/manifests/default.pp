node server1.lan {
  exec { 'apt-get update':
    command => 'sudo apt-get update',
    path    => ['/bin', '/usr/bin'],
  }

  file {'/vagrant/hosts':
    ensure => file,
  }

  file {'/etc/hosts':
  ensure => link,
  force => true,
  target => '/vagrant/hosts'
  }

  if $networking[interfaces][eth1]==undef {
    $myip=$networking[ip]
  } else {
    $myip=$networking[interfaces][eth1][ip]
  }

  host{$hostname:
    ensure=>'present',
    target=>'/vagrant/hosts',
    ip=>$myip,
  }

}

node server2.lan {
  exec { 'apt-get update':
    command => 'sudo apt-get update',
    path    => ['/bin', '/usr/bin'],
  }

  file {'/vagrant/hosts':
    ensure => file,
  }

  file {'/etc/hosts':
  ensure => link,
  force => true,
  target => '/vagrant/hosts'
  }

  if $networking[interfaces][eth1]==undef {
    $myip=$networking[ip]
  } else {
    $myip=$networking[interfaces][eth1][ip]
  }

  host{$hostname:
    ensure=>'present',
    target=>'/vagrant/hosts',
    ip=>$myip,
  }
}
