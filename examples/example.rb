#!/usr/bin/env ruby
require '../src/lib/sep6_client/client'

client = Sep6Client::Client.new()

response = client.get('/info')

# The API should return an HTTP status code of 200 if the request was successfully processed, let's have a look.
print "Status Code: " + response.code.to_s + "\n"
print "Response Body: " + response.body + "\n"




# response = client.get('/deposit', {
#   :asset_code => 'BTC',
#   :account => 'GDONUHZKLSYLDOZWR2TDW25GFXOBWCCKTPK34DLUVSOMFHLGURX6FNU6',
#   :memo => 'Sent via SEP-6',
#   :memo_type => 'text',
# })
#
# # The API should return an HTTP status code of 200 if the request was successfully processed, let's have a look.
# print "Status Code: " + response.code.to_s + "\n"
# print "Response Body: " + response.body + "\n"




response = client.get('/withdraw', {
  :asset_code => 'BTC',
  :dest => 'bc1qj633nx575jm28smgcp3mx6n3gh0zg6ndr0ew23'
})

# The API should return an HTTP status code of 200 if the request was successfully processed, let's have a look.
print "Status Code: " + response.code.to_s + "\n"
print "Response Body: " + response.body + "\n"