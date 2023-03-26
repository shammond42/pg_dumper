# apt install postgresql-client
# apt-get -y install bash-completion wget
# wget --no-check-certificate --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
# echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
# apt-get update
# apt-get -y install postgresql-client-12
include DbDumperSupport

namespace :db do
    desc "Dumps the database to backups"
    task :dump => :environment do

        dump_fmt = 'p'      # 'c' or 'p', 't', 'd'
        dump_sfx = suffix_for_format dump_fmt
        backup_dir = backup_directory true
        cmd = nil
        with_config do |app, host, db, user, passw|
            file_name = Time.now.strftime("%Y%m%d%H%M%S") + "_" + db + '.' + dump_sfx
            # puts "app = #{app}"
            # puts "host = #{host}"
            # puts "db = #{db}"
            # puts "user = #{user}"
            # puts "Password = #{passw}"
            cmd = "PGPASSWORD=#{passw}  pg_dump -F #{dump_fmt} -v -U #{user} -h #{host} -d #{db} -f #{backup_dir}/#{file_name}"
        end
        puts cmd
        exec cmd
    end
end