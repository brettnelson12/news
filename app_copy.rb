require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; 
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
@forecast = ForecastIO.api_key = "9863419f1d57fef327f7a0e19efad68b"




puts forecast



end
