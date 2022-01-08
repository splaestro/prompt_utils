require "test_helper"

class PromptUtilsTest < Minitest::Test

    # Note: this assumes test is being run via rake, from typical location of Rakefile!
    TMPDIR = File.expand_path("./tmp")

    def setup
        $stdout.puts name
        %w{A B C}.each do |ll|
            File.open("#{TMPDIR}/input_choice_#{ll}", "w") do |f|
                f.write "#{ll}\n"
            end
        end if name =~ /^test_choice/
        0.upto(4) do |mm|
            File.open("#{TMPDIR}/input_num_#{mm}", "w") do |f|
                f.write "#{mm}\n"
            end
        end if name == "test_num_input"
    end

    def teardown
        FileUtils.rm_f(Dir.glob("#{TMPDIR}/input_*"))
    end

    def test_that_it_has_a_version_number
        refute_nil ::PromptUtils::VERSION
        assert_equal ::PromptUtils::VERSION, "0.1.0"
    end

    include PromptUtils

    def test_for_methods
        assert_respond_to(self, :choice)
        assert_respond_to(self, :num_input)
    end

    def test_choice_simple
        assert_empty(ARGV, "Oh crap! ARGV has something in it! All bets are off!")

        %w{A B C}.each do |rr|
            ARGV[0] = "#{TMPDIR}/input_choice_#{rr}"
            prompt = "\nPlease pick one (A/B/C) "
            assert_output(prompt) {
                assert_equal(rr, resp = choice("Please pick one", %w{A B C}))
                assert_instance_of(String, resp)
            }
        end
        ARGV.shift
    end

    def test_choice_default
        skip
    end
    
    def test_num_input
        assert_empty(ARGV, "Oh crap! ARGV has something in it! All bets are off!")

        prompt = "\nPlease give me a number (0..4) "
        0.upto(4) do |nn|
            ARGV[0] = "#{TMPDIR}/input_num_#{nn}"
            assert_output(prompt) {
                assert_equal(nn, resp = num_input("Please give me a number", (0..4)))
                assert_instance_of(Float, resp)
            }
        end
        ARGV.shift
    end
    
    def test_bad_args
        assert_raises(NoMethodError) {choice("Please pick one", ("A".."Z"))}
        assert_raises(NoMethodError) {num_input("Please give me a number", [0, 1, 2, 3, 4])}
    end
    
end
