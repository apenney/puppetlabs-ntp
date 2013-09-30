class ntp::params {

  # On virtual machines allow large clock skews.
  $panic = str2bool($::is_virtual) ? {
    true    => false,
    default => true,
  }
  $autoupdate        = lookup('ntp::autoupdate', 'Boolean')
  $config            = lookup('ntp::config', 'String')
  $config_template   = lookup('ntp::config_template', 'String')
  $driftfile         = lookup('ntp::driftfile', 'String')
  $keys_enable       = lookup('ntp::keys_enable', 'Boolean')
  $keys_file         = lookup('ntp::keys_file', 'String')
  $keys_controlkey   = lookup('ntp::control_key', 'String')
  $keys_requestkey   = lookup('ntp::keys_requestkey', 'String')
  
  # may want to use 'Array[String]' here
  $keys_trusted      = lookup('ntp::keys_trusted', 'Array')
  $package_ensure    = lookup('ntp::package_ensure', 'String')

  # may want to use 'Array[String]' here
  $package_name      = lookup('ntp::package_name', 'Array')
  $panic             = lookup('ntp::panic', 'Boolean', $ntp::params::panic)

  # may want to use 'Array[String]' here
  $preferred_servers = lookup('ntp::preferred_servers', 'Array')

  # may want to use 'Array[String]' here
  $restrict          = lookup('ntp::restrict', 'Array')

  # may want to use 'Array[String]' here
  $servers           = lookup('ntp::servers', 'Array')
  $service_enable    = lookup('ntp::service_enable', 'Boolean')
  $service_ensure    = lookup('ntp::service_ensure', 'String')
  $service_manage    = lookup('ntp::service_manage', 'Boolean')
  $service_name      = lookup('ntp::service_name', 'String')
  $supported         = lookup('ntp::supported', 'Boolean')

}
