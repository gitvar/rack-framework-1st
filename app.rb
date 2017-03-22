# app.rb

require_relative 'advice'

class App
  # def initialize
  #   @message = ""
  # end

  def call(env)
    case env['REQUEST_PATH']
    when '/'
      status = '200'
      headers = { "Content-Type" => 'text/html' }
      response(status, headers) do
        erb :index
      end
    when '/advice'
      piece_of_advice = Advice.new.generate
      status = '200'
      headers = { "Content-Type" => 'text/html' }
      response(status, headers) do
        erb :advice, message: piece_of_advice
      end
    else
      status = '404'
      headers = { "Content-Type" => 'text/html', "Content-Length" => '62' }
      response(status, headers) do
        erb :not_found
      end
    end
  end

  def response(status, headers, body = '')
    body = yield if block_given?
    [status, headers, [body]]
  end

  private

  def erb(filename, local = {})
    b = binding
    # @message = local[:message]
    message = local[:message]
    path = File.expand_path("../views/#{filename}.erb", __FILE__)
    content = File.read(path)
    ERB.new(content).result(b)
  end
end

# class HelloWorld
#   def call(env)
#     case env['REQUEST_PATH']
#     when '/'
#       # template = File.read("views/index.erb")
#       # content = ERB.new(template)
#       ['200', { "Content-Type" => "text/html" }, [erb(:index)]] # pass in a symbol, signifying which template to render.
#     when '/advice'
#       piece_of_advice = Advice.new.generate
#       [
#         '200',
#         { "Content-Type" => 'text/html' },
#         ["<html><body><h2><em>#{piece_of_advice}</em></h2></body></html>"]
#       ]
#     else
#       [
#         '404',
#         { "Content-Type" => 'text/html', "Content-Length" => '48' },
#         ["<html><body><h2>404 Not Found</h2></body></html>"]
#       ]
#     end
#   end
#
#   private
#
#   def erb(filename)
#     path = File.expand_path("../views/#{filename}.erb", __FILE__)
#     content = File.read(path)
#     ERB.new(content).result
#   end
# end
