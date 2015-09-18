# === Class: eclipse::default
#
#
class eclipse::default (
  $target,
  $desktop_file_path,
  $symlink_to
) {
  file { "${symlink_to}/eclipse":
    ensure  => link,
    target  => $target,
    require => File[$target]
  }
}