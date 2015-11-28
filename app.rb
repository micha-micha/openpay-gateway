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
  request_hash = {
    "method" => "card",
    "source_id" => params[:token_id],
    "amount" => params[:amount],
    "description" => params[:description],
    "device_session_id" => params[:device_session_id]
  }

  response_hash = charges.create(request_hash.to_hash)
end


def openpay options = {}
  agent = OpenpayApi.new('mtmwhkvledzx2mfoqkej', 'sk_e92711454aba4340b8dba66865d0c3d9')
end
