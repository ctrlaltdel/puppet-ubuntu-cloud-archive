# == Class: ubuntu-cloud-archive
#
# This class configures the necessary apt sources for downloading packages from
# the Ubuntu Cloud Archive.
# https://wiki.ubuntu.com/ServerTeam/CloudArchive
#
# === Parameters
#
# Document parameters here.
#
# [*release*]
#   Name of the Openstack release you want to install. Required.
#
# === Variables
#
# === Examples
#
#  class { 'ubuntu-cloud-archive':
#    release => 'grizzly'
#  }
#
# === Authors
#
# François Deppierraz <francois.deppierraz@nimag.net>
#
# === Copyright
#
# Copyright 2013 François Deppierraz
#
class ubuntu-cloud-archive (
  $release
) {
  if ( $::operatingsystem != 'Ubuntu' ) {
    fail 'As you could have guessed from its name, this module works only on Ubuntu'
  }

  if ( $release != 'folsom' and $release != 'grizzly' ) {
    fail "Unknown release ${release}"
  }

  apt::source { "ubuntu-cloud-archive":
    location          => "http://ubuntu-cloud.archive.canonical.com/ubuntu",
    release           => "${lsbdistcodename}-updates/${release}",
    repos             => "main",
    required_packages => "ubuntu-cloud-keyring",
  }

}

class {'ubuntu-cloud-archive': stage => 'setup' }
