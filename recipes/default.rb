#
# Cookbook Name:: CookbookPHPKata
# Recipe:: default
#
# Copyright (c) 2016 Mojility Inc, All Rights Reserved.

package 'php5-fpm'
package 'php5-mysql'
package 'phpunit'
package 'nginx'
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
