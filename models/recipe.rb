require 'pg'
require 'pry'

def db_connection
  begin
    connection = PG.connect(dbname: "recipes")
    yield(connection)
  ensure
    connection.close
  end
end

class Recipe
attr_accessor :id, :name, :instructions, :recipes, :recipe_list
  def initialize(id, name, instructions, description)
    @id = id
    @name = name
    @instructions = instructions
    @description = description
    @recipes = recipes
  end

  def self.all
    recipes = []
    db_list = []
    db_connection do |conn|
      db_list = conn.exec("SELECT * FROM recipes")
      db_list.each do |rec|
        recipes << Recipe.new(rec["id"], rec["name"], rec["instructions"], rec["description"])
      end
      return recipes
    end
  end
  #
  # "SELECT ingredients.id, ingredients.name
  #                       FROM ingredients
  #                       WHERE #{id} = ingredients.recipe_id;"


  # def id
  #   recipes.each do |data|
  #     if data["id"] == params[:id]
  #       return data["id"]
  #     end
  #   end
  # end
  #
  # def description
  #   @description
  # end
  #
  # def instructions
  #   @instructions
  # end
  #
  # def find(id)
  #   recipse.each do |data|
  #     if data["id"] == id
  #       return data["id"]
  #     end
  #   end
  # end
  #



end


# Recipe.all
# puts Recipe.all
