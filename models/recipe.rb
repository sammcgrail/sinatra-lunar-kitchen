require 'pg'
require 'pry'

class Recipe
  attr_accessor :recipe_list
  def initialize
    @recipes = []
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

  def recipes
    db_connection do |conn|
      @recipes = conn.exec("SELECT * FROM recipes LIMIT 50")
    end
  end
end

new_test = Recipe.new
puts new_test.recipes.to_a
