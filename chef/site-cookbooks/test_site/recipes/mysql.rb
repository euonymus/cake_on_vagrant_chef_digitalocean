include_recipe "database::mysql"


# This is used repeatedly, so we'll store it in a variable
mysql_connection_info = {
  host:     'localhost',
  username: 'root',
  password: node['mysql']['server_root_password']
}

# Ensure a database exists with the name of our app
mysql_database node[:test_site][:app_name] do
  connection mysql_connection_info
  action     :create
end

# Ensure a database user exists with the name of our app
mysql_database_user node[:test_site][:app_name] do
  connection mysql_connection_info
  password   node[:test_site][:db_password]
  action     :create
end

# Let this database user access this database
mysql_database_user node[:test_site][:app_name] do
  mysql_connection_info
  password      node[:test_site][:db_password]
  database_name node[:test_site][:app_name]
  host          'localhost'
  action        :grant
end


