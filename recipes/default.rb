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
package 'php7.2-curl'
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

bash 'composer' do
  cwd '/home/vagrant'
  code <<-EOH
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
  php composer-setup.php --install-dir=/usr/local/bin --filename=composer
  php -r "unlink('composer-setup.php');"
  EOH
end

template '/etc/nginx/sites-available/default' do
  source 'nginx-default.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

service 'apache2' do
  action :stop
  action :disable
end

service 'nginx' do
  action :enable
  action :restart
end
