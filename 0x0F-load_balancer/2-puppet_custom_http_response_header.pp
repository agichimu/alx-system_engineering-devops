# This Puppet script configures a new Ubuntu machine
# to include a custom HTTP response header - X-Served-By

package { 'nginx':
  ensure => 'installed',
}

service { 'nginx':
  ensure  => 'running',
  enable  => true,
  require => Package['nginx'],
}

file { '/etc/nginx/sites-available/default':
  content => "server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html index.htm;

    server_name _;

    location / {
        try_files \$uri \$uri/ =404;
    }

    add_header X-Served-By \$hostname;
}\n",
  require => Service['nginx'],
}

service { 'nginx':
  ensure  => 'running',
  require => File['/etc/nginx/sites-available/default'],
}
