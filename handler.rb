require 'json'

def datospersonales(event:, context:)
  begin
   data = JSON.parse(event["body"])
   message = data["message"]["text"]
   chat_id = data["message"]["chat"]["id"]
   first_name = data["message"]["chat"]["first_name"]

   response = "Wecome #{first_name}! You said, #{message}"
   payload = {text: response, chat_id: chat_id}

   uri = URI("https://api.telegram.org")

   Net::HTTP.start(uri.hostname, uri.port, {use_ssl: true}) do |http|
     req = Net::HTTP::Post.new("/bot#{TOKEN}/sendMessage", {'Content-Type' => 'application/json'})
     req.body = payload.to_json
     http.request(req)
   end
 rescue Exception => e
   puts e.message
   puts e.backtrace.inspect
 end

 return { statusCode: 200 }
end
