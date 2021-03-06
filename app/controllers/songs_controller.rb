require 'rack-flash'

class SongsController<ApplicationController
	enable :sessions
	use Rack::Flash

	get '/songs' do
		@songs = Song.all
		erb :'/songs/index'
	end

	post '/songs' do
		# binding.pry
		artist = Artist.find_or_create_by(name: params["artist_name"])
		song = Song.create(name: params["song"]["name"], artist_id: artist.id)
		params[:genres].keys.each do |genre|
			song.genres << Genre.find_or_create_by(name: genre)
		end
		flash[:message] = "Successfully created song."
		redirect "/songs/#{song.slug}"
	end

	get '/songs/new' do
		erb :'/songs/new'
	end

	get '/songs/:slug' do
		@song = Song.find_by_slug(params["slug"])
		erb :'/songs/show'
	end


end