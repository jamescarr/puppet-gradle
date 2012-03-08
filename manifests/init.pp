# Class: gradle
#
# Requires: JDK 1.5
#
#
class gradle {
  include 'openjdk'

  $version = 'gradle-1.0-milestone-8a'
  
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
	require	=> Archive['gradle'],
  }

  file { '/etc/profile.d/gradle.sh':
	ensure	=> file,
	mode	=> 644,
	source	=> 'puppet:///modules/gradle/gradle.sh',
	owner	=> root, group	=> root,
  }
}