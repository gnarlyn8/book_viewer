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

  # works similar to inlcude, but doesn't iterate
  # through every element, so it is faster, especially
  # for non-numeric types
  redirect "/" unless (1..@toc.size).cover?(@chapter_num)

  @title = "Chapter #{@chapter_num}: #{@chapter_name}"
  @chapter_content = File.read("data/chp#{@chapter_num}.txt")

  erb :chapter
end

not_found do
  redirect "/"
end

helpers do
  def in_paragraphs(text)
    text.split("\n\n").map do |paragraph|
      "<p>#{paragraph}</p>"
    end.join
  end
end
