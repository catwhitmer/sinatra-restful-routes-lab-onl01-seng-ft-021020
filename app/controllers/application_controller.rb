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
    @recipes = Recipe.find(params[:id])
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
  
  get '/recipes/:id/edit' do
    @recipes = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    Recipe.find(params[:id]).tap do |recipe|
      recipe.update(
        name: params[:name],
        ingredients: params[:ingredients],
        cook_time: params[:cook_time]
      )

      redirect "/recipes/#{recipe.id}"

    end
  end

  delete '/recipes/:id/delete' do
    Recipe.find(params[:id]).destroy
    redirect '/recipes'
  end
end
