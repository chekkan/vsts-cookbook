property :artifact_name, String, :name_attribute => true,
          :required => true
property :instance, String, :required => true
property :project_id, String, :required => true
property :build_id, Fixnum, :required => true
property :access_token, String, :require => true

default_action :download

action :download do
  require "net/http"
  require "uri"
  require "json"

  api_url = "https://#{instance}/defaultcollection/#{project_id}/_apis/build/builds/#{build_id}/artifacts"
  uri = URI(api_url)

  req = Net::HTTP::Get.new(uri)
  req['Authorization'] = "Bearer #{access_token}"

  res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') {|http|
    http.request(req)
  }

  parsed = JSON.parse(res)

  parsed['value'][0]['name']

end
