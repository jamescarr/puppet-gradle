# Class: gradle
#
# Requires: JDK 1.5
#
#
class gradle {
  include 'openjdk'

  $version = 'gradle-1.0-milestone-9'
  
  Exec {
	path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
  }

  archive { $version:
    ensure	=> present,
	url 	=> "http://downloads.gradle.org/distributions/$version-all.zip",
	checksum	=> false,
	src_target	=> '/tmp',
	target	=> '/usr/share',
	extension	=> 'zip',
  }
  
  file { '/usr/share/gradle':
    ensure	=> link,
	target	=> "/usr/share/$version",
	owner	=> root, group	=> root,
	require	=> Archive["$version"],
  }

  file { '/etc/profile.d/gradle.sh':
	ensure	=> file,
	mode	=> 644,
	source	=> 'puppet:///modules/gradle/gradle.sh',
	owner	=> root, group	=> root,
  }
  
  # Templates Plugin
  archive::download {"templates-1.2.jar":
    ensure => present,
    url => "https://launchpad.net/gradle-templates/trunk/1.2/+download/templates-1.2.jar",
    checksum => false,
    src_target => "/usr/share/gradle/lib/plugins",
    allow_insecure => false,
    require File['/usr/share/gradle'],
  }

  file { '/usr/share/gradle/init.d/templates.gradle':
    ensure => file,
    mode => 644,
    source => 'puppet:///modules/gradle/templates.gradle',
    owner => root, group => root,
    require File['/usr/share/gradle'],
  }
}