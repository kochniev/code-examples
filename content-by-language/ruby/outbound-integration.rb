require 'uri'
require 'json'
require 'net/http'
require 'net/https'

proxy = URI.parse('https://{ACCESS_CREDENTIALS}@{VAULT_HOST}:{PORT}')
uri = URI.parse('{VGS_SAMPLE_ECHO_SERVER}/post')
http = Net::HTTP.new(uri.host, uri.port, proxy.host, proxy.port, proxy.user, proxy.password)
http.use_ssl = true
http.ca_file = '../../mixed-content/sandbox_cert.pem'
http.verify_mode = OpenSSL::SSL::VERIFY_PEER
http.verify_depth = 5

request = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
request.body = {account_number: 'tok_sandbox_w8CBfH8vyYL2xWSmMWe3Ds'}.to_json
response = http.request(request)
puts "Response #{response.code} #{response.message}: #{response.body}"