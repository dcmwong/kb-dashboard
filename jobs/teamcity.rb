require 'teamcity'

def update_build(build_type_id)
  build_info = {
    :name => "No build for #{build_type_id}",
    :project => "No project found",
    :status => "",
    :number => 0
  }

  build_type = TeamCity.buildtype(:id => build_type_id)
  unless build_type.nil?
    #puts "\nbuild: #{build_type}"

    build_type_obj_builds = TeamCity.builds(count: 1, :buildType => build_type_id)
    unless build_type_obj_builds.nil?
      last_build = build_type_obj_builds.first

      build_info['name'] = build_type.name
      build_info['project'] = build_type.projectName
      build_info['status'] = last_build.status
      build_info['number'] = last_build.number
    end
  end
  build_info
end

config_file = File.dirname(File.expand_path(__FILE__)) + '/../config/teamcity.yml'
config = YAML::load(File.open(config_file))

TeamCity.configure do |c|
  c.endpoint = ENV["TC_SERVER_URL"] || (raise "Please provide TC_SERVER_URL environment variable")
  c.http_user = ENV["TC_USER"] || (raise "Please provide TC_USER environment variable")
  c.http_password = ENV['TC_PASSWORD'] || (raise "Please provide TC_PASSWORD environment variable")
end

SCHEDULER.every '33s', :first_in => '1s' do
  if config['repositories'].nil?
    puts 'No TeamCity repositories found :('
  else
    config['repositories'].each do |data_id, build_type_id|
      send_event(data_id, { :item => update_build(build_type_id) })
    end
  end
end
