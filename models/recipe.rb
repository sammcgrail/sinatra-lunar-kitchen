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
attr_accessor :id, :name, :instructions, :description
  def initialize(id, name, instructions, description)
    @id = id
    @name = name
    @instructions = instructions
    @description = description
  end

  def self.find(recipe_id)
    recipes = all
    recipes.each do |recipe|
      if recipe_id == recipe.id
        return recipe
      end
    end
  end

  def self.all
    recipes = []
    db_list = []
    db_connection do |conn|
      db_list = conn.exec("SELECT * FROM recipes")
      db_list.each do |rec|
        recipes << Recipe.new(rec["id"], rec["name"], rec["instructions"], rec["description"])
      end
      recipes
    end
  end

  def ingredients
    ingredients = []
    ingredients_db_hit = db_connection do |conn|
                                  conn.exec("SELECT ingredients.id,
                                  ingredients.name FROM ingredients
                                  WHERE #{id} = ingredients.recipe_id;")
                                end
    ingredients_db_hit.each do |ingred|
      ingredients << Ingredient.new(ingred["id"], ingred["name"])
    end
    ingredients
  end
end
