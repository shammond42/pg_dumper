include DbDumperSupport

namespace :db
  desc "Restores the database from a backup using PATTERN"
  task :restore, [:pat] => :environment do |task,args|
      if args.pat.present?
          cmd = nil
          with_config do |app, host, db, user, passwd|
              backup_dir = backup_directory
              files = Dir.glob("#{backup_dir}/*#{args.pat}*")
              case files.size
              when 0
                puts "No backups found for the pattern '#{args.pat}'"
              when 1
                file = files.first
                fmt = format_for_file file
                if fmt.nil?
                  puts "No recognized dump file suffix: #{file}"
                else
                  cmd = "pg_restore -F #{fmt} -v -c -C #{file}"
                end
              else
                puts "Too many files match the pattern '#{args.pat}':"
                puts ' ' + files.join("\n ")
                puts "Try a more specific pattern"
              end
          end
          unless cmd.nil?
            Rake::Task["db:drop"].invoke
            Rake::Task["db:create"].invoke
            puts cmd
            exec cmd
          end
      else
          puts 'Please pass a pattern to the task'
      end
  end
end