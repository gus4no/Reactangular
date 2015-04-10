require 'bundler'
Bundler.require

Dir[File.dirname(__FILE__) + "/models/*.rb"].each {|f| require f }

DataMapper::Logger.new($stdout, :debug)		
DataMapper.setup(:default, 'postgres://gus4no@localhost/reactangular')
DataMapper.finalize
DataMapper.auto_migrate!
DataMapper.auto_upgrade!


# If there are no Users in the database, add a few.
if User.count == 0
	(1..500).each do 
		User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email)
	end
end

get '/react' do
	send_file 'public/react.html'
end

get '/angular' do
	send_file 'public/angular.html'
end
 
get '/users' do
	content_type :json
	@users = User.all
	@users.to_json
end