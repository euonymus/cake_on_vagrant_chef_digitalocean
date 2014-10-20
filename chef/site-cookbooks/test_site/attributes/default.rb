default[:test_site][:app_name]    = 'test_site'
default[:test_site][:server_name] = 'test_site.yourdomain.com'
default[:test_site][:www_root]    = "/var/www"
default[:test_site][:cache_root]  = "/var/cache"
default[:test_site][:log_root]    = "/var/log"
default[:test_site][:app_root]    = "#{node[:test_site][:www_root]}/#{node[:test_site][:app_name]}"

default[:test_site][:cake_source] = '/vagrant/src/cakephp-2.5.5'
default[:test_site][:cake_cache]  = "#{node[:test_site][:cache_root]}/#{node[:test_site][:app_name]}"
default[:test_site][:cake_log]    = "#{node[:test_site][:log_root]}/#{node[:test_site][:app_name]}"

# default[:test_site][:deploy_user] = 'vagrant'


# default[:test_site][:db_password] = 'anothersecurepassword'
# node.set_unless['mysql']['server_root_password'] = 'hoge'
default[:test_site][:secretpath] = "/vagrant/data_bag_key"


# look for secret in file pointed to by test_site attribute :secretpath
mysql_secret = Chef::EncryptedDataBagItem.load_secret("#{node[:test_site][:secretpath]}")
mysql_creds = Chef::EncryptedDataBagItem.load("passwords", "mysql", mysql_secret)
# if mysql_secret && mysql_passwords = mysql_creds[node.chef_environment] 
if mysql_secret && mysql_passwords = mysql_creds["prod"] 
  node.set_unless['mysql']['server_root_password'] = mysql_passwords['root']
  node.set_unless['mysql']['server_debian_password'] = mysql_passwords['debian']
  node.set_unless['mysql']['server_repl_password'] = mysql_passwords['repl']
  node.set_unless['test_site']['db_password'] = mysql_passwords['app']
end


