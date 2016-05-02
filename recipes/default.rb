#
# Cookbook Name:: CookbookPHPKata
# Recipe:: default
#
# Copyright (c) 2016 Mojility Inc, All Rights Reserved.


apt_repository 'php7' do
    uri          'ppa:ondrej/php'
    distribution node['lsb']['codename']
end

apt_repository 'nginx-php' do
    uri          'ppa:nginx/stable'
    distribution node['lsb']['codename']
end

package 'php7.0'
package 'php7.0-mysql'
package 'php7.0-fpm'
package 'nginx'
package 'phpunit'
package 'mysql-server'
package 'mysql-client'

template '/etc/nginx/sites-available/default' do
    source 'nginx-default.erb'
    owner 'root'
    group 'root'
    mode '0644'
end

service 'nginx' do
    action :restart
end
