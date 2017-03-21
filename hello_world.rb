require_relative 'advice'

class HelloWorld
  def call(env)
    case env['REQUEST_PATH']
    when '/'
      template = File.read("views/index.erb")
      content = ERB.new(template)
      ['200', { "Content-Type" => "text/html" }, [content.result]]
    when '/advice'
      piece_of_advice = Advice.new.generate
      [
        '200',
        { "Content-Type" => 'text/html' },
        ["<html><body><h2><em>#{piece_of_advice}</em></h2></body></html>"]
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
