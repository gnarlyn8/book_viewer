require "sinatra"
require "sinatra/reloader"
require "tilt/erubi"

get "/" do
  @title = "The Adventures of Sherlocks Home"
  @toc = File.readlines("data/toc.txt")

  erb :home
end

get "/chapters/1" do
  @title = "The Adventures of Sherlocks Home"
  @toc = File.readlines("data/toc.txt")
  @chapter_content = File.read("data/chp1.txt")

  erb :chapter
end
