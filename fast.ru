use Rack::Chunked
use Rack::ContentLength
run Proc.new { |env| ['200', {"Content-Type" => "text/html"}, ["I'm fast!"]] }
