class User
	include DataMapper::Resource

	property :id, Serial, key: true
	property :first_name, String
	property :last_name, String
	property :email, String
end
