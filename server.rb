require 'sinatra'
require_relative 'lamp'

def all_lamps
  $lamps ||= [
    Lamp.new(:desk, 3.00, 'red'),
    Lamp.new(:table, 8.00, 'silver'),
    Lamp.new(:floor, 15.00, 'blue'),
    Lamp.new(:magic, 1000000.00, 'gold'),
    Lamp.new(:mario, 999.00, 'coin')
  ]
end

get '/' do
  @lamps = all_lamps
  erb :index, :layout => :common_layout
end

get'/about' do
	erb :about, :layout => :common_layout
end		

get '/lamps/:id' do
  @lamp = find_lamp_by_id(params)
  erb :lamp, :layout => :common_layout
end

get '/buy/:id' do
  @lamp = find_lamp_by_id(params)
  erb :buy, :layout => :common_layout
end

post '/submit-order/:id' do
  	@lamp = find_lamp_by_id(params)
  	q = params[:quantity].to_i
  	if q <= 0
  		#cant order 0 or less
  		@error = "You must order at least one lamp!"
  	elsif q > @lamp.quantity
  		#can't order that many either
  		@error = "dont have that many in stock. sorry"
  	else 
  		#hoory!
	  	@lamp.quantity -= q
 		erb :thankyou, :layout => :common_layout
 	end
end

def find_lamp_by_id(params)
	id = params[:id].to_i
	raise "Not valid ID" if id >= all_lamps.size
	
	all_lamps[id]
end