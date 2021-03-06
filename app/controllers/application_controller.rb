class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  get '/' do
    redirect '/recipes'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end 
  
  get '/recipes/new' do 
    erb :new
  end
  
  post '/recipes' do
    @recipes = Recipe.new(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    @recipes.save
    
    redirect "/recipes/#{@recipes.id}"
  end
  
  get '/recipes/:id' do
    @recipes = Recipe.find_by_id(params[:id])
    if @recipes
      erb :show
    else 
      redirect '/recipes'
    end
  end

  get '/recipes/:id/edit' do
    @recipes = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    Recipe.find(params[:id]).each do |recipe|
      recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])

      redirect "/recipes/#{@recipes.id}"
    end
  end

  delete '/recipes/:id' do
    Recipe.find(params[:id]).destroy
    redirect '/recipes'
  end
end
