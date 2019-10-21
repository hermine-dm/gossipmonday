require 'csv'

class Gossip
	attr_accessor :author, :content

	def initialize(author, content) #pour .new
		@author = author
		@content = content
	end

	def save
		CSV.open("./db/gossip.csv", "ab") do |csv|
			csv << [@author, @content]
		end
	end

	def self.all
		all_gossips = [] #on initialise un array vide
		CSV.read("./db/gossip.csv").each do |csv_line| #ligne par ligne
			all_gossips << Gossip.new(csv_line[0], csv_line[1]) 
		end
		return all_gossips #on retourne un array rempli d'objets Gossip
	end

	def self.find(id)
		all_gossips = self.all #tous les gossips
		params = [] #initalise un array vide
		for i in 0..all_gossips.size
			if i == id
				gossip = all_gossips[i] #décalage d'un a cause du début a 0
				params.push(all_gossips[i].author, all_gossips[i].content, i)
				#rempli le array avec son auteur, son content et son numero
				return params
			end
		end
	end

	def update(author, content) #pas spécialement utile
    	@author = author
    	@content = content
    	return self
	end
	def self.save_update(gossip,id)
		gossip_csv = CSV.table("./db/gossip.csv") #avec .table == présence de titre sur la premiere ligne
		CSV.open("./db/gossip.csv", 'w',:write_headers=> true, :headers => ["auteur","secret"]) do |csv| #va réécrire sur l'ancien fichier, en gardant un titre
			gossip_csv.each_with_index.map do |row, index| #existant du fichier avant d'étre réécrit
				if (index+1) == (id) #en fonction du id, on implémente le gossip modifié ..
					csv << [gossip.author, gossip.content]
				else  #ou les anciens déjà présents
					csv << [row[0], row[1]]
				end
			end
		end

	end
end