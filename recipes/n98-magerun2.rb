#
# Cookbook Name:: magento-toolbox
# Recipe:: n98-magerun2
#
# Copyright 2016, Dhaval Patel
#
# Licensed under MIT:
# http://raw.github.com/r8/magento-toolbox/master/LICENSE.txt

include_recipe "php"

package "curl" do
  action :upgrade
end

command = "curl -L -o n98-magerun2.phar https://files.magerun.net/n98-magerun2.phar && chmod +x ./n98-magerun2.phar"

bash "download_n98-magerun2" do
  cwd "#{Chef::Config[:file_cache_path]}"
  code <<-EOH
    #{command}
  EOH
end

if node["n98-magerun2"]["install_globally"]
  bash "move_n98-magerun2" do
    cwd "#{Chef::Config[:file_cache_path]}"
    code <<-EOH
      sudo mv n98-magerun2.phar #{node["n98-magerun2"]["prefix"]}/bin/n98-magerun2
    EOH
  end
end