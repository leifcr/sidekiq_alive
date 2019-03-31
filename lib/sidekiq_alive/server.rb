require 'sinatra/base'
require_relative './config'
module SidekiqAlive
  class Server < Sinatra::Base
    set :bind, '0.0.0.0'
    # set :server, :webrick
    set :port, SidekiqAlive.config.port

    # # class << self
    #   def start
    #     fork do 
    #       SideKiqAlive::Server.run!
    #     end
    #   end
    # end

    get '/' do
      if SidekiqAlive.alive?
        status 200
        body 'Alive!'
      else
        response = "Can't find the alive key"
        SidekiqAlive.logger.error(response)
        status 404
        body response
      end
    end
  end
end
