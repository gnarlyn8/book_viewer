require "sinatra"
require "sinatra/reloader"
require "tilt/erubi"

before do
  @toc = File.readlines("data/toc.txt")
end

get "/" do
  @title = "The Adventures of Sherlocks Home"

  erb :home
end

get "/chapters/:number" do
  @chapter_num = params["number"]
  @chapter_name = @toc[@chapter_num.to_i - 1]
  @title = "Chapter #{@chapter_num}: #{@chapter_name}"
  @chapter_content = File.read("data/chp#{@chapter_num}.txt")

  erb :chapter
end

helpers do
  def in_paragraphs(text)
    text.split("\n\n").map do |paragraph|
      "<p>#{paragraph}</p>"
    end.join
  end
end
