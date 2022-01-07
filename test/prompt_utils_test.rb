require "test_helper"

class PromptUtilsTest < Minitest::Test
    def test_that_it_has_a_version_number
        refute_nil ::PromptUtils::VERSION
        assert_equal ::PromptUtils::VERSION, "0.1.0"
    end

    include PromptUtils

    def test_for_methods
        assert self.respond_to? :choice
        assert self.respond_to? :num_input
    end

    def test_choice
        assert false
    end
end
