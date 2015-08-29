#!/usr/bin/env ruby
# Proof-of-concept for dmfs
# (c) nilsding

require 'twitter'
require 'base64'
require 'pry'

CONFIG = {
  consumer_key: 'FYRuQcDbPAXAyVjuPZMuw',
  consumer_secret: 'KiLCYTftPdxNebl5DNcj7Ey2Y8YVZu7hfqiFRYkcg',
  access_token: '',
  access_token_secret: '',
  
  magic: '!!DMFS'
}

$client = Twitter::REST::Client.new do |config|
  config.consumer_key        = CONFIG[:consumer_key]
  config.consumer_secret     = CONFIG[:consumer_secret]
  config.access_token        = CONFIG[:access_token]
  config.access_token_secret = CONFIG[:access_token_secret]
end

def download_file(dm_id)
  dm = $client.direct_message dm_id, full_text: true
  fail "DirectMessage does not start with #{CONFIG[:magic]}" unless dm.text.start_with? CONFIG[:magic]
  data = JSON.parse(dm.text.sub /^#{CONFIG[:magic]}/, '')
  File.open data['fn'], 'wb' do |f|
    f.write Base64.decode64 data['ct']
  end
  data['fn']
end

def encode_file(filename)
  CONFIG[:magic] + {
    'fn' => File.basename(filename),
    'pt' => 0,
    'ct' => Base64.encode64(File.read(filename))
  }.to_json
end

def send_file(target, filename)
  $client.create_direct_message target, encode_file(filename)
end
  
# get a list of direct messages with the full text
dms = $client.direct_messages

binding.pry
