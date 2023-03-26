include DbDumperSupport

namespace :db
  desc "Show the existing database backups"
  task :list => :environment do
      backup_dir = backup_directory
      puts "#{backup_dir}"
      exec "/bin/ls -lt #{backup_dir}"
  end
end