node server1.lan {
  exec { 'apt-get update':
    command => 'sudo apt-get update',
    path    => ['/bin', '/usr/bin'],
  }

  exec {'rm hosts':
    path =>  [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    command => "rm -f /etc/hosts"
  }

  exec {'symbolic link':
    path =>  [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    command => "ln -s /vagrant/hosts /etc/hosts"
  }

  file {'/etc/hosts':
  ensure => file,
  target => '/vagrant/hosts'
  }

  exec {'write ip':
    provider => shell,
    #command => "echo ifconfig eth0 | grep inet | awk '{ print $2 }' | awk -F: '{print $2}' | head -1 >> /etc/hosts/server1",
    command => "echo hello >> /etc/hosts",
    path =>  [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
  }

#  exec {'write ip':
#    provider => shell,
#    #command => "echo ifconfig eth0 | grep inet | awk '{ print $2 }' | awk -F: '{print $2}' | head -1 >> /etc/hosts",
#    command => "echo ifconfig eth0 | grep inet | awk '{ print $2 }' >> /etc/hosts",
#    path =>  [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
#  }
  

}

node server2.lan {
  exec { 'apt-get update':
    command => 'sudo apt-get update',
    path    => ['/bin', '/usr/bin'],
  }

  exec {'rm hosts':
    path =>  [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    command => "rm -f /etc/hosts"
  }

  exec {'symbolic link':
    path =>  [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    command => "ln -s /vagrant/hosts /etc/hosts"
  }

  file {'/etc/hosts':
  ensure => file,
  target => '/vagrant/hosts'
}


#  exec {'write ip':
#    command => "echo ifconfig eth0 | grep inet | awk '{ print $2 }' | awk -F: '{print $2}' | head -1 >> file",
#    path => '/etc/hosts'
#  }

}
