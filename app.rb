require 'sinatra'
require 'openpay'
require 'json'

before do
  request.body.rewind
  @request_payload = JSON.parse request.body.read
end


post '/payment' do
  params = @request_payload
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


def openpay options = {}
  agent = OpenpayApi.new('mtmwhkvledzx2mfoqkej', 'sk_e92711454aba4340b8dba66865d0c3d9')
end
