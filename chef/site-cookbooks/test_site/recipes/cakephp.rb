directory node[:test_site][:cake_source] + '/app/tmp' do
 owner "www-data"
 group "www-data"
 mode "0777"
end
directory node[:test_site][:cake_source] + '/app/tmp/cache' do
 owner "www-data"
 group "www-data"
 mode "0777"
end
directory node[:test_site][:cake_source] + '/app/tmp/cache' + '/models' do
 owner "www-data"
 group "www-data"
 mode "0777"
end
directory node[:test_site][:cake_source] + '/app/tmp/cache' + '/persistent' do
 owner "www-data"
 group "www-data"
 mode "0777"
end
directory node[:test_site][:cake_source] + '/app/tmp/cache' + '/views' do
 owner "www-data"
 group "www-data"
 mode "0777"
end
directory node[:test_site][:cake_source] + '/app/tmp/logs' do
 owner "www-data"
 group "www-data"
 mode "0777"
end
directory node[:test_site][:cake_source] + '/app/tmp/sessions'  do
 owner "www-data"
 group "www-data"
 mode "0777"
end
directory node[:test_site][:cake_source] + '/app/tmp/tests'  do
 owner "www-data"
 group "www-data"
 mode "0777"
end

# file node[:test_site][:cake_source] + '/app/Config/database.php' do
#   content IO.read(node[:test_site][:cake_source] + '/app/Config/database.php.default')
# end
template node[:test_site][:cake_source] + '/app/Config/database.php' do
  source 'cake_database.erb'
  owner "www-data"
  group "www-data"
  variables({
     :login    => node[:test_site][:app_name],
     :database => node[:test_site][:app_name],
     :password => node[:test_site][:db_password]
  })
end
# file node[:test_site][:cake_source] + '/app/Config/database.php.default' do
#   action :delete
# end
