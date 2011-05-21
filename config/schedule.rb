set :output, "/home/deploy/mom/current/log/cron_log.log"

every 15.minutes do
  db_config  = YAML.load_file("#{Dir.pwd}/config/database.yml")["production"]
  mom_config = YAML.load_file("#{Dir.pwd}/config/mom.yml")
  
  password = db_config["password"]
  host     = db_config["host"]
  username = db_config["username"]
  path     = mom_config["backup_path"]
  database = db_config["database"]
  
  command %{PGPASSWORD=#{password} pg_dump -i -h #{host} -U #{username} -F c } +
          %{-f "#{path}/`date \\+\\%m_\\%d_\\%Y_\\%H_\\%M`.backup" #{database}}
end