# Puppet script to configure custom header on Nginx

package { 'nginx':
  ensure => installed,
}

file { '/etc/nginx/sites-available/default':
  content => "# Add custom header\nadd_header X-Served-By $hostname;",
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure => running,
  enable => true,
}
