require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "9863419f1d57fef327f7a0e19efad68b"



  
# news is now a Hash you can pretty print (pp) and parse for your output

get "/" do
  # show a view that asks for the location
  view "ask"
end

get "/news" do
  # do everything else
  # News API
    url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=d55a2ab8a4a249799cbd868d319821e5"
    @news = HTTParty.get(url).parsed_response.to_hash
    results = Geocoder.search(params["q"])

    @lat_long = results.first.coordinates # => [lat, long]
    @location = results.first.city
    # Define the lat and long
    @lat = "#{@lat_long [0]}"
    @long = "#{@lat_long [1]}"

    # Results from Geocoder
    @forecast = ForecastIO.forecast("#{@lat}" , "#{@long}").to_hash
    @current_temperature = @forecast["currently"]["temperature"]
    @current_conditions = @forecast["currently"]["summary"]
# high_temperature = forecast["daily"]["data"][0]["temperatureHigh"]
# puts high_temperature
# puts forecast["daily"]["data"][1]["temperatureHigh"]
# puts forecast["daily"]["data"][2]["temperatureHigh"]
    @daily_temperature = []
    @daily_conditions = []
    @daily_wind = []
    @daily_humidity = []

pp forecast

view "news"
view "forecast"

end
