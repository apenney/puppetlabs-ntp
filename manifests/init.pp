#
class ntp (
  $autoupdate        = lookup('ntp::autoupdate', 'Boolean'),
  $config            = lookup('ntp::config', 'String'),
  $config_template   = lookup('ntp::config_template', 'String'),
  $driftfile         = lookup('ntp::driftfile', 'String'),
  $keys_enable       = lookup('ntp::keys_enable', 'Boolean'),
  $keys_file         = lookup('ntp::keys_file', 'String'),
  $keys_controlkey   = lookup('ntp::control_key', 'String'),
  $keys_requestkey   = lookup('ntp::keys_requestkey', 'String'),
  $keys_trusted      = lookup('ntp::keys_trusted', 'Array'),
  $package_ensure    = lookup('ntp::package_ensure', 'String'),
  $package_name      = lookup('ntp::package_name', 'Array'),
  $panic             = lookup('ntp::panic', 'Boolean', $ntp::params::panic),
  $preferred_servers = lookup('ntp::preferred_servers', 'Array'),
  $restrict          = lookup('ntp::restrict', 'Array'),
  $servers           = lookup('ntp::servers', 'Array'),
  $service_enable    = lookup('ntp::service_enable', 'Boolean'),
  $service_ensure    = lookup('ntp::service_ensure', 'String'),
  $service_manage    = lookup('ntp::service_manage', 'Boolean'),
  $service_name      = lookup('ntp::service_name', 'String'),
  $supported         = lookup('ntp::supported', 'Boolean'),
) inherits ntp::params {

  validate_absolute_path($config)
  validate_absolute_path($driftfile)
  validate_re($keys_controlkey, ['^\d+$', ''])
  validate_re($keys_requestkey, ['^\d+$', ''])

  if $autoupdate {
    notice('autoupdate parameter has been deprecated and replaced with package_ensure.  Set this to latest for the same behavior as autoupdate => true.')
  }

  if ! $supported {
    fail("The ${module_name} module is not supported by the combination of osfamily: ${::osfamily} and operatingsystem: ${::operatingsystem}")
  }

  include '::ntp::install'
  include '::ntp::config'
  include '::ntp::service'

  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'ntp::begin': }
  anchor { 'ntp::end': }

  Anchor['ntp::begin'] -> Class['::ntp::install'] -> Class['::ntp::config']
    ~> Class['::ntp::service'] -> Anchor['ntp::end']

}
