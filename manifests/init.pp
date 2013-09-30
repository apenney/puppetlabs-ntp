#
class ntp inherits ntp::params {

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
