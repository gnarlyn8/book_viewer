require "sinatra"
require "sinatra/reloader"
require "tilt/erubi"

before do
  @chapters = File.readlines("data/toc.txt")
end

get "/" do
  @title = "The Adventures of Sherlocks Home"

  erb :home
end

get "/chapters/:number" do
  number =  params["number"].to_i
  @chapter_num = params["number"]
  @chapter_name = @chapters[number - 1]

  # works similar to inlcude, but doesn't iterate
  # through every element, so it is faster, especially
  # for non-numeric types
  redirect "/" unless (1..@chapters.size).cover?(number)

  @title = "Chapter #{@chapter_num}: #{@chapter_name}"
  @chapter_content = File.read("data/chp#{@chapter_num}.txt")

  erb :chapter
end

get "/search" do
  @search = params[:query]

  @results = chapters_matching(@search)
  erb :search
end

not_found do
  redirect "/"
end

def chapters_matching(query)
  results = []
  return results if !query || query.empty?

  @chapters.each_with_index do |chapter, index|
    results << {number: index + 1, name: chapter} if chapter.include?(query)
  end

  results
end

helpers do
  def in_paragraphs(text)
    text.split("\n\n").map do |paragraph|
      "<p>#{paragraph}</p>"
    end.join
  end
end
