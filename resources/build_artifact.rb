property :artifact_name, String, :name_attribute => true,
          :required => true
property :instance, String, :required => true
property :project_id, String, :required => true
property :build_id, Fixnum, :required => true
property :username, String, :required => true
property :access_token, String, :required => true
property :path, String, :required => true

default_action :download

action :download do
  require "net/http"
  require "uri"
  require "json"

  api_url = "https://#{instance}/defaultcollection/#{project_id}/_apis/build/builds/#{build_id}/artifacts"
  uri = URI(api_url)

  req = Net::HTTP::Get.new(uri)
  req.basic_auth(username, access_token)

  res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') {|http|
    http.request(req)
  }

  parsed = JSON.parse(res.body)

  idx = parsed['value'].find_index {|x| x['name'] == artifact_name}

  artifact = parsed['value'][idx]
  download_url = artifact['resource']['downloadUrl']

  artifact_filename = "#{artifact_name}-#{build_id}"

  directory path do
    action :create
    recursive true
  end

  token = Base64.strict_encode64("#{username}:#{access_token}").strip

  remote_file "#{path}\\#{artifact_filename}.zip" do
    source download_url
    headers({"Authorization"=>"Basic #{token}", "Accept" => "application/zip"})
    action :create
  end

end
