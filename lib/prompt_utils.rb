require "prompt_utils/version"

module PromptUtils
    class Error < StandardError; end
  
    # present a prompt to the user and return the character chosen
    def choice(prompt, resplist=%w{Y N})
        resp = ""
        while !(resplist.include?(resp)) do
            print "\n#{prompt} (#{resplist.join("/")}) "
            resp = gets.chomp
        end
        resp
    end

    # present a prompt to the user to capture a (floating-point) number and return that value
    def num_input(prompt, raynge)
        resp = nil
        while !(raynge.cover?(resp)) do
            print "\n#{prompt} (#{raynge}) "
            resp = gets.chomp
            # a Regexp seems to work for straightforward numeric input 
            resp = resp.match(/^[\+\-\d\.]+$/) ? resp.to_f : nil
        end
        resp
    end

end
