require 'gossip'


class ApplicationController < Sinatra::Base

  get '/' do #page d'acceuil
    erb :index, locals: {gossips: Gossip.all} #affiche l'index et l'array de gossips.all
  end

  get '/gossips/new/' do #premiere page lors du clichage sur le lien
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/' #permet de revenir a la page d'acceuil
  end
  
  get '/gossips/:id' do 
  	erb :show, locals: {params_gossip: Gossip.find(params['id'].to_i)} #renvoie un array d'un potin suite à la fct.find
 	#on aurait pu mettre directement dans locals id: params['id'] pour sortir le num
  end

  get '/gossips/:id/edit' do
  	erb :edit, locals: {params_gossip: Gossip.find(params['id'].to_i), id: params['id'].to_i}
  end

  post '/gossips/:id/edit' do
     gossip_updated = Gossip.all[params["id"].to_i-1].update(params["gossip_author"],params["gossip_content"])
     Gossip.save_update(gossip_updated,params["id"].to_i)
     redirect '/'
   end
end
