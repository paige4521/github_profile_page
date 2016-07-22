require 'sinatra'
require 'httparty'
require 'json'
require 'uri'


get "/" do
	erb :index
end


get "/repositories" do
	url = URI("https://api.github.com/users/paige4521/repos")
	response = JSON.parse(HTTParty.get(url).to_json)
	repositories = Array.new #creating an instance of the class Array. It will be empty

	response.each do |repo|
		repo_data = Hash.new #creating an instance of the class Hash.  It will be empty
		repo_data["id"] 			= repo["id"]
		repo_data["name"]			= repo["name"]
		repo_data["url"]			= repo["html_url"]
		repo_data["desc"]			= repo["description"]
		repo_data["avatar_url"]		= repo["owner"]["avatar_url"]
		#repo_data["watchers"]	= repo["watchers_count"]
		#repo_data["language"] = repo["language"]
		#repo_data["forks"] 		= repo["forks"]
		#repo_data["owner"] 		= repo["owner"]["login"]
		repositories.push(repo_data)
	end
	@avatar_url = repositories[0]["avatar_url"]
	@repositories = repositories
	 #instance variables can be passed to our view in views/repositories.erb
	erb :repositories #tell sinatra to output an erb file called repositories.erb
end
