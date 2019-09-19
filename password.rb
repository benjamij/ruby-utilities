require 'digest/sha1'
require 'net/http'
require 'uri'

module Password
    def is_pwned()
        hashed_psw = Digest::SHA1.hexdigest self 
        response = Net::HTTP.get_response(URI.parse('https://api.pwnedpasswords.com/range/' + hashed_psw[0, 5]))
        response.body.include? hashed_psw[5..-1].upcase
    end
end

# Usage
class String
    include Password
end

foo = "test"
puts foo.is_pwned
