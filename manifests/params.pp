# === Class: eclipse::params
#
# Params for installing Eclipse based on Operating System flavor
#
# Parameters:
#  - install_path: where the installed package should go
#  - desktop_file_path: if set this is the desktop file which will be modified to include a link to eclipse
#  - symlink_to: where to copy a symlink to
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class eclipse::params {
  case $::osfamily {
    'redhat': {
      #TODO: used the debian defaults -- verify in other flavors:
      $install_path      = '/usr/lib'
      $desktop_file_path = '/usr/share/applications'
      $symlink_to        = '/usr/bin'
    }
    'debian': {
      $install_path      = '/usr/lib'
      $desktop_file_path = '/usr/share/applications'
      $symlink_to        = '/usr/bin'
    }
    'Archlinux': {
      $install_path      = '/opt'
      $desktop_file_path = '/usr/share/applications'
      $symlink_to        = '/usr/bin'
    }
    default: {
      #TODO: used the debian defaults -- verify in other flavors:
      $install_path      = '/usr/lib'
      $desktop_file_path = '/usr/share/applications'
      $symlink_to        = '/usr/bin'
    }
  }

  $arch_suffix = $::architecture ? {
    /i.86/           => '',
    /(amd64|x86_64)/ => '-x86_64',
    default          => "-${::architecture}"
  }

  $toolkit_suffix = $::kernel ? {
  	'linux'   => '-linux-gtk',
  	'darwin'  => '-macosx-cocoa',
  	'windows' => '-win32'
  }

  $extension = $::kernel ? {
  	'windows' => 'zip',
  	default   => 'tar.gz'
  }

  $path = ['/usr/bin', '/usr/sbin', '/bin', '/sbin', '/etc']
  $tmp  = '/tmp'
}
