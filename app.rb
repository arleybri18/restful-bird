require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/bird.db")
class Bird
  include DataMapper::Resource
  property :id, Serial
  property :name, Text
  property :image, Text
end
DataMapper.finalize.auto_upgrade!

#index
get '/birds' do
    @birds = Bird.all
    erb :'birds/index'
end

#new
get '/birds/new' do
    erb :'birds/new'
end

#create
post '/birds' do
    Bird.create({:name => params[:name], :image => params[:image]})
    redirect '/birds'
end

#show
get '/birds/:id' do
    @bird = Bird.get(params[:id])
    erb :'birds/show'
end
