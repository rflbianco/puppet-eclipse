$mars='4.5'

eclipse { $mars:
  default_version => true,
  install_path    => '/opt'
}


# eclipse::plugin { "org.eclipse.pde4eclipse${mars}":
#   iu         => 'org.eclipse.pde.feature.group',
#   ensure     => present,
#   repository => 'http://download.eclipse.org/releases/mars',
#   require    => Eclipse[$mars]
# }

# eclipse::plugin { "buildship4eclipse${mars}":
#   iu         => 'org.eclipse.buildship.feature.group',
#   ensure     => present,
#   repository => 'http://download.eclipse.org/releases/mars,http://download.eclipse.org/buildship/updates/e45/releases',
#   require    => Eclipse[$mars]
# }

# eclipse::plugin { "gwt4eclipse${mars}":
#   iu         => 'com.google.gwt.eclipse.sdkbundle.feature.feature.group',
#   ensure     => present,
#   repository => 'http://download.eclipse.org/releases/mars,https://dl.google.com/eclipse/plugin/4.4',
#   require    => Eclipse[$mars]
# }

# eclipse::plugin { "googleplugin4eclipse${mars}":
#   iu         => 'com.google.gdt.eclipse.suite.e44.feature.feature.group',
#   ensure     => present,
#   repository => 'http://download.eclipse.org/releases/mars,https://dl.google.com/eclipse/plugin/4.4',
#   require    => Eclipse[$mars]
# }
