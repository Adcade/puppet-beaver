# == Class: beaver::package
#
# This class exists to coordinate all software package management related
# actions, functionality and logical units in a central place.
#
#
# === Parameters
#
# This class does not provide any parameters.
#
#
# === Examples
#
# This class may be imported by other classes to use its functionality:
#   class { 'beaver::package': }
#
# It is not intended to be used directly by external resources like node
# definitions or other modules.
#
#
# === Authors
#
# * Richard Pijnenburg <mailto:richard@ispavailability.com>
#
class beaver::package {

  #### Package management

  include python

#  # set params: in operation
#  if $beaver::ensure == 'present' {
#
#    # Check if we want to install a specific version or not
#    if $beaver::version == false {
#
#      $package_ensure = $beaver::autoupgrade ? {
#        true  => 'latest',
#        false => 'present',
#      }
#
#    } else {
#
#      # install specific version
#      $package_ensure = $beaver::version
#
#    }
#
#  # set params: removal
#  } else {
#    $package_ensure = 'purged'
#  }
#
#  # action
#  package { $beaver::params::package:
#    ensure   => $package_ensure,
#    provider => 'pip',
#    require  => Class['python'],
#  }

  $install_dir = "/tmp/beaver"

  vcsrepo { $install_dir:
    ensure   => present,
    provider => git,
    source   => "https://github.com/josegonzalez/beaver.git"
  } ->

  exec { "setup":
    path    => ["/usr/bin", "/bin", "/usr/local/bin"],
    pwd     => $install_dir,
    command => "python setup.py install",
    unless  => "test -f /usr/local/bin/beaver",
  }

}
