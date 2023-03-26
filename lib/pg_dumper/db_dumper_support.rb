module DbDumperSupport
  def suffix_for_format suffix
    case suffix
    when 'c' then 'dump'
    when 'p' then 'sql'
    when 't' then 'tar'
    when 'd' then 'dir'
    else nil
    end
end

def format_for_file file
    case file
    when /\.dump$/ then 'c'
    when /\.sql$/  then 'p'
    when /\.dir$/  then 'd'
    when /\.tar$/  then 't'
    else nil
    end
end

def backup_directory create=false
    backup_dir = "#{Rails.root}/db/backups"
    if create and not Dir.exists?(backup_dir)
      puts "Creating #{backup_dir} .."
      Dir.mkdir(backup_dir)
    end
    backup_dir
end

def with_config
    yield Rails.application.class.module_parent_name.underscore,
      ActiveRecord::Base.connection_db_config.host,
      ActiveRecord::Base.connection_db_config.database,
      ActiveRecord::Base.connection_db_config.configuration_hash[:username],
      ActiveRecord::Base.connection_db_config.configuration_hash[:password]
end
end