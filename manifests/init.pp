# === Define: eclipse
#
# === Parameters
#
# arguments
#
define eclipse (
  $version           = $title,
  $default_version   = false,
  $package           = 'java',
  $release_name      = 'mars',
  $service_release   = '1',
  $mirror            = 'http://mirror.cc.columbia.edu/pub/software/eclipse',
  $set_default       = true,
  $wgettimeout       = 1800,
  $timeout           = 900,

  $install_path      = undef,
  $desktop_file_path = undef,
  $symlink_to        = undef,
) {

  include eclipse::params


  $_install_path      = $install_path ?  {
    undef   => $eclipse::params::install_path,
    default => $install_path
  }

  $_desktop_file_path = $desktop_file_path ? {
    undef   => $eclipse::params::desktop_file_path,
    default => $desktop_file_path
  }

  $_symlink_to        = $symlink_to ? {
    undef   => $eclipse::params::symlink_to,
    default => $symlink_to
  }

  $_arch_suffix       = $eclipse::params::arch_suffix
  $_toolkit_suffix    = $eclipse::params::toolkit_suffix
  $_extension         = $eclipse::params::extension

  $_installation_root = "${_install_path}/eclipse"
  $_installation_path = "${_installation_root}/${version}"
  $_application_path  = "${_installation_path}/eclipse"
  
  $_symlink_path      = $_symlink_to ? {
    undef   => undef,
    default => "${_symlink_to}/eclipse-${version}"
  }

  $_basename     = "eclipse-${package}-${release_name}-${service_release}${_toolkit_suffix}${_arch_suffix}"
  $_filename     = "${_basename}.${_extension}"
  $_url          = "${mirror}/technology/epp/downloads/release/${release_name}/${service_release}/${_filename}"
  $_extract_path = "${eclipse::params::tmp}/${_basename}"

  include archive

  if ! defined(File[$_installation_root]) {
    file { $_installation_root:
      ensure => directory
    }
  }

  file { $_extract_path:
    ensure => directory
  }

  archive { "${eclipse::params::tmp}/${_filename}":
    ensure        => present,
    extract       => true,
    extract_path  => $_extract_path,
    source        => $_url,
    creates       => $_installation_path,
    cleanup       => true,
    require       => File[$_extract_path]
  }

  file{ $_installation_path:
    source  => "${_extract_path}/eclipse",
    ensure  => directory,
    recurse => true,
    replace => false,
    require => Archive["${eclipse::params::tmp}/${_filename}"]
  }

  file{ $_application_path:
    ensure  => file,
    mode    => '0755',
    require => File[$_installation_path]
  }

  if $_symlink_path != undef {
    file { $_symlink_path:
      ensure  => link,
      target  => $_application_path,
      require => File[$_installation_path]
    }

    if $default_version and ! defined(Class['eclipse::default']) {
      class { 'eclipse::default':
        target            => $_symlink_path,
        desktop_file_path => $_desktop_file_path,
        symlink_to        => $_symlink_to,
        require           => File[$_symlink_path]
      }
    } else {
      fail("There is already a default version set for Eclipse IDE")
    }
  }

  if $_desktop_file_path != undef {
    file { "${_desktop_file_path}/eclipse-${version}.desktop":
      ensure  => $ensure,
      content => template('eclipse/eclipse.desktop.erb'),
      mode    => '0644',
      require => File[$_installation_path]
    }
  }
}
