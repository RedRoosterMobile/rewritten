require 'rack'

module Rack

  module Rewritten

    class Subdomain

      def initialize(app, *fqdns)
        @app = app
        @fqdns = fqdns
      end

      def call(env)
        puts "-> Rack::Rewritten::Subdomain"
        req = Rack::Request.new(env)

        @fqdns.each do |n|
          if req.host =~ /(.+)\.#{n}$/
            if $1 == 'www'
              break
            else
              env["SUBDOMAIN"] = $1
              env["FQDN"] = n 
              break
            end
          end
        end

        @app.call(env) 
      end

    end

  end

end


