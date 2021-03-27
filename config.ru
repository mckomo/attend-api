# frozen_string_literal: true

require 'rack/protection'
require './api'

run Sinatra::Application
