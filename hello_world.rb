require_relative 'advice'

class HelloWorld
  def call(env)
    case env['REQUEST_PATH']
    when '/'
      [
        '200',
        { "Content-Type" => 'text/html' },
        ["<h1>Hello World!!!</h1>"]
      ]
    when '/advice'
      piece_of_advice = Advice.new.generate
      [
        '200',
        { "Content-Type" => 'text/html' },
        ["<html><body><b><em>#{piece_of_advice}</em></b></body></html>"]
      ]
    else
      [
        '404',
        { "Content-Type" => 'text/html', "Content-Length" => '48' },
        ["<html><body><h2>404 Not Found</h2></body></html>"]
      ]
    end
  end
end
