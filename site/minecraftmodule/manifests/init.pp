class minecraftmodule (
  $url = 'https://launcher.mojang.com/v1/objects/c8f83c5655308435b3dcf03c06d9fe8740a77469/server.jar',
  $install_dir = '/opt/minecraft'
  ) {
  file {$install_dir:
    ensure => directory,
  }
  file {"{$install_dir}/server.jar":
    ensure => file,
    source => $url,
    before => Service['minecraft'],
  }
  # package {'java-11-openjdk':
  #  ensure => present,
  #}
  java::adoptium { 'jdk17' :
    ensure  => 'present',
    version_major => '17',
    version_minor => '0',
    version_patch => '1',
    version_build => '12',
    basedir       => '/usr/lib/jvm',
    }
  file {"{$install_dir}/eula.txt":
    ensure => file,
    content => 'eula=true',
  }
  file {'/etc/systemd/system/minecraft.service':
    ensure => file,
    content => epp('minecraftmodule/minecraft.service', {
      install_dir => $install_dir,
    })
  }
  service {'minecraft':
    ensure => running,
    enable => true,
    require => [Package['java'],File["{$install_dir}/eula.txt"],File['/etc/systemd/system/minecraft.service']],
  }
  
}
