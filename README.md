# About

Simple test demonstrating the 5s latency of rainbows server when the HTTP
response does not contain either ContentLength or Chunked Transfer-Enconding
headers.

Without these headers, the server sends the response, then waits 5s, then
closes the connection. Tcpdump shows no activity, then a FIN sequence with the
first packet sent by the server.

The server closing the connection to indicate the end of the body is a correct behavior
in the absence of the headers [1].

Rainbows includes the Rack middleware that adds these headers, but only when
the RACK\_ENV env var is set to 'deployment' or 'development', i.e. not 'production'.

# Usage

To run the test, make sure you have ruby (2.1, 2.2) and bundler gem installed.
Then run in the project directory:

    gem install -N bundler
    bundle
    ./run-server slow.ru
    ./test


[1] http://www.w3.org/Protocols/HTTP/1.1/draft-ietf-http-v11-spec-01.html#BodyLength

Otherwise, the body length is determined by the Transfer-Encoding (if the
"chunked" transfer coding has been applied), by the Content-Type (for multipart
types with an explicit end-of-body delimiter), or by the server closing the
connection.
