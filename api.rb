# frozen_string_literal: true

require 'sinatra'
require 'open3'
require 'digest'
require 'rdiscount'

raise 'You must provide ZOHO_PEOPLE_ROOT_TOKEN as env variable' unless ENV['ZOHO_PEOPLE_ROOT_TOKEN']

get '/' do
  markdown :README, views: settings.root
end

post '/' do
  auth_token = env.fetch('HTTP_AUTHORIZATION', '').slice(6..-1)
  computed_token = Digest::SHA1.hexdigest("#{params[:email]}.#{ENV['ZOHO_PEOPLE_ROOT_TOKEN']}")

  halt 401, 'Unuthorized' unless auth_token == computed_token

  stream do |out|
    out << "\r\n"
    options = []
    options += ['--dry'] if params[:dry]
    options += ['--verbose'] if params[:verbose]
    options += ['--email', params[:email]] if params[:email]
    options += ['--from', params[:from]] if params[:from]
    options += ['--to', params[:to]] if params[:to]
    options += ['--check_in', params[:check_in]] if params[:from]
    options += ['--check_out', params[:check_out]] if params[:to]

    Open3.popen2e({ 'ZOHO_PEOPLE_AUTH_TOKEN' => ENV['ZOHO_PEOPLE_ROOT_TOKEN'] }, 'attend', *options) do |_, stdoe|
      stdoe.each { |line| out << line }
    end
  end
end
