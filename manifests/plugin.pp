
# Type: eclipse::plugin
#
# This type installs a Eclipse plugin via the p2 director of Eclipse
#
# Sample Usage:
#
#  eclipse::plugin::install::p2_director { 'org.eclipse.egit.feature.group': }
#
define eclipse::plugin (
  $iu         = $title,
  $ensure     = present,
  $repository = '',
  $target     = undef
) {

  $repository_url = $repository ? {
    ''      => $eclipse::repository,
    default => $repository
  }

  $target_opts = $target ? {
    undef   => undef,
    default => "-destination ${target}"
  }

  $eclipse_cmd = "/opt/eclipse/4.5/eclipse -application org.eclipse.equinox.p2.director ${target_opts} -noSplash"
  $check_cmd   = "${eclipse_cmd} -listInstalledRoots | egrep '^${iu}(/|$)'"

  case $ensure {
    present: {
      exec { "eclipse-p2-director: install ${title}":
        command => "${eclipse_cmd} -repository '${repository_url}' -installIU '${iu}'",
        unless  => $check_cmd
      }
    }
    default: {
      exec { "eclipse-p2-director: uninstall ${title}":
        command => "${eclipse_cmd} -uninstallIU '${iu}'",
        onlyif  => $check_cmd
      }
    }
  }
}
