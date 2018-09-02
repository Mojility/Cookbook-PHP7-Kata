#
# Cookbook Name:: CookbookPHP7Kata
# Recipe:: default
#
# Copyright (c) 2016 Mojility Inc, All Rights Reserved.


apt_repository 'php7' do
  uri 'ppa:ondrej/php'
  distribution node['lsb']['codename']
end

apt_repository 'nginx-php' do
  uri 'ppa:nginx/stable'
  distribution node['lsb']['codename']
end

package 'php7.2'
package 'php7.2-mysql'
package 'php7.2-fpm'
package 'nginx'
package 'mysql-server'
package 'mysql-client'

bash 'phpunit' do
  cwd '/home/vagrant'
  code <<-EOH
  wget https://phar.phpunit.de/phpunit.phar
  chmod +x phpunit.phar
  sudo mv phpunit.phar /usr/local/bin/phpunit
  EOH
end

template '/etc/nginx/sites-available/default' do
  source 'nginx-default.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

service 'apache2' do
  action :disable
end

service 'nginx' do
  action :enable
  action :restart
end
