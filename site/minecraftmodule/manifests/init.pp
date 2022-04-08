class minecraftmodule {
  file {'/opt/minecraft':
    ensure => directory,
  }
  file {'/opt/minecraft/server.jar':
    ensure => file,
    source => 'https://launcher.mojang.com/v1/objects/c8f83c5655308435b3dcf03c06d9fe8740a77469/server.jar',
  }
  # package {'java-11-openjdk':
  #  ensure => present,
  #}
  java::download { 'jdk-18':
    ensure  => 'present',
    java_se => 'jdk',
    url     => "https://download.java.net/openjdk/jdk18/ri/openjdk-18+36_linux-x64_bin.tar.gz",
  }
  file {'/opt/minecraft/eula.txt':
    ensure => file,
    content => 'eula=true',
  }
  file {'/etc/systemd/system/minecraft.service':
    ensure => file,
    source => 'puppet:///modules/minecraftmodule/minecraft.service',
  }
  service {'minecraft':
    ensure => running,
    enable => true,
  }
  
}
