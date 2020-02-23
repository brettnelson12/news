require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "9863419f1d57fef327f7a0e19efad68b"

url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=d55a2ab8a4a249799cbd868d319821e5"
news = HTTParty.get(url).parsed_response.to_hash
# news is now a Hash you can pretty print (pp) and parse for your output

current_news = news["articles"] # continue to parse thru the news
puts "Today's news #{current_news}"

get "/" do
  # show a view that asks for the location
  view "ask"
end

get "/news" do
  # do everything else
    results = Geocoder.search(params["q"])
    lat_long = results.first.coordinates # => [lat, long]
    "#{lat_long[0]} #{lat_long[1]}"
    view "ask"
end