# @summary
#   OS dependent parameter defaults
#
# @api private
#
class ca_cert::params {
  case $facts['os']['family'] {
    'Debian': {
      $trusted_cert_dir  = '/usr/local/share/ca-certificates'
      $distrusted_cert_dir = undef
      $update_cmd        = 'update-ca-certificates'
      $cert_dir_group    = 'root'
      $cert_dir_mode     = '0755'
      $ca_file_group     = 'root'
      $ca_file_mode      = '0644'
      $ca_file_extension = 'crt'
      $package_name      = 'ca-certificates'
    }
    'RedHat': {
      $trusted_cert_dir    = '/etc/pki/ca-trust/source/anchors'
      $distrusted_cert_dir = '/etc/pki/ca-trust/source/blacklist'
      $update_cmd          = 'update-ca-trust extract'
      $cert_dir_group      = 'root'
      $cert_dir_mode       = '0755'
      $ca_file_group       = 'root'
      $ca_file_mode        = '0644'
      $ca_file_extension   = 'crt'
      $package_name        = 'ca-certificates'
    }
    'Archlinux': {
      $trusted_cert_dir    = '/etc/ca-certificates/trust-source/anchors/'
      $distrusted_cert_dir = '/etc/ca-certificates/trust-source/blacklist'
      $update_cmd          = 'trust extract-compat'
      $cert_dir_group      = 'root'
      $cert_dir_mode       = '0755'
      $ca_file_group       = 'root'
      $ca_file_mode        = '0644'
      $ca_file_extension   = 'crt'
      $package_name        = 'ca-certificates'
    }
    'Suse': {
      if $facts['os']['release']['major'] =~ /(10|11)/ {
        $trusted_cert_dir    = '/etc/ssl/certs'
        $distrusted_cert_dir = undef
        $update_cmd          = 'c_rehash'
        $ca_file_extension   = 'pem'
        $package_name        = 'openssl-certs'
      }
      elsif versioncmp($facts['os']['release']['major'], '12') >= 0 {
        $trusted_cert_dir    = '/etc/pki/trust/anchors'
        $distrusted_cert_dir = '/etc/pki/trust/blacklist'
        $update_cmd          = 'update-ca-certificates'
        $ca_file_extension   = 'crt'
        $package_name        = 'ca-certificates'
      }
      $cert_dir_group        = 'root'
      $cert_dir_mode         = '0755'
      $ca_file_group         = 'root'
      $ca_file_mode          = '0644'
    }
    default: {}
  }
}
