require 'pg'
require 'pry'

class Recipe

  def initialize(recipes, recipe_list)
    @recipes = recipe_list
  end

  def db_connection
    begin
      connection = PG.connect(dbname: "recipes")
      yield(connection)
    ensure
      connection.close
    end
  end

  def self.all
    @recipes
  end

  def recipe_list
    recipe_list =
    binding.pry
    db_connection do |conn|
      conn.exec("SELECT name FROM recipes LIMIT 50")
    end
  end
end
