class HomeController < ApplicationController
  def index
  end

  def welcome
    require 'net/http'
    require 'uri'
    console 

    @email_address = request.query_parameters['email_address']
    @status = request.query_parameters['status']

    uri = URI('https://us15.api.mailchimp.com/3.0/lists/d4077cce58/members/')
    body = '{"email_address": "' + @email_address + '","status": "' + @status + '"}'

    req = Net::HTTP::Post.new(uri)
    req.set_content_type("application/json")
    req.body = body
    req.basic_auth(ENV['MAILCHIMP_USER'],ENV['MAILCHIMP_API_KEY'])
    
    res = Net::HTTP.start(uri.host, uri.port,:use_ssl => uri.scheme == 'https') do |http|
      http.request(req) # Net::HTTPResponse object
    end

  end 

end