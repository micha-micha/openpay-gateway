require 'sinatra'
require 'openpay'
require 'json'

before do
  request_payload
  openpay
end


post '/payment' do
  params = request_payload
  charges = openpay.create(:charges)
  case params[:method]
  when "card"
    request_hash = {
      "method" => params[:method],
      "source_id" => params[:token_id],
      "amount" => params[:amount],
      "description" => params[:description],
      "device_session_id" => params[:device_session_id]
    }
  when "store"
    request_hash = {
      "method" => params[:method],
      "amount" => params[:amount],
      "description" => params[:description],
      "device_session_id" => params[:device_session_id]
    }
  when "bank_account"
    request_hash={
     "method" => "bank_account",
     "amount" => params[:amount],
     "description" => params[:description],
     "order_id" => params[:order_id]
   }

  response_hash = charges.create(request_hash.to_hash)
end

post '/webhook' do
  puts request_payload
end

private

def openpay options = {}
  agent = OpenpayApi.new('mtmwhkvledzx2mfoqkej', 'sk_e92711454aba4340b8dba66865d0c3d9')
end

def request_payload
  request.body.rewind
  request_payload = JSON.parse request.body.read
end

def disperse_funds request_payload, options={}
  payouts = openpay.create(:payouts)
  bank_account_hash={
       "holder_name" => params[:holder_name]
       "clabe" => params[:clabe]
     }
  request_hash={
       "method" => "bank_account",
       "bank_account" => bank_account_hash,
       "amount" => params[:amount],
       "description" => params[:description]
     }
  response_hash = payouts.create(request_hash.to_hash)
end
