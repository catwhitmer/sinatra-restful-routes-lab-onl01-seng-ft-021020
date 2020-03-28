class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end 
  
  get '/recipes/new' do 
    erb :new
  end
  
  get '/recipes/:id' do
    @recipes = Recipe.find_by_id(params[:id])
    if @recipes
      erb :show
    else 
      redirect '/recipes'
    end
  end

  post '/recipes' do
    @recipes = Recipes.new(params)
    @recipes.save
    redirect "/recipes/#{@recipes.id}"
  end
end
