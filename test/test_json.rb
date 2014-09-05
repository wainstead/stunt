require 'test_helper'

class TestJson < Test::Unit::TestCase

  def test_that_generating_json_works_for_simple_values_in_default_mode
    run_test_as('wizard') do
      assert_equal '1', generate_json(1)
      assert_equal '1.1', generate_json(1.1)
      assert_equal '"1.2"', generate_json("1.2")
      assert_equal '"#13"', generate_json(MooObj.new(13))
      assert_equal '"E_PERM"', generate_json(E_PERM)
      assert_equal '[]', generate_json([])
      assert_equal '{}', generate_json({})
    end
  end

  def test_that_parsing_json_works_for_simple_values_in_default_mode
    run_test_as('wizard') do
      assert_equal 1, parse_json('1')
      assert_equal 1.1, parse_json('1.1')
      assert_equal "1.2", parse_json('\"1.2\"')
      assert_equal [], parse_json('[]')
      assert_equal({}, parse_json('{}'))
    end
  end

  def test_that_parsing_json_fails_for_obvious_errors_in_default_mode
    run_test_as('wizard') do
      assert_equal E_INVARG, parse_json('#13')
      assert_equal E_INVARG, parse_json('E_PERM')
    end
  end

  def test_that_generating_json_works_for_simple_values_in_common_subset_mode
    run_test_as('wizard') do
      assert_equal '1', generate_json(1, 'common-subset')
      assert_equal '1.1', generate_json(1.1, 'common-subset')
      assert_equal '"1.2"', generate_json("1.2", 'common-subset')
      assert_equal '"#13"', generate_json(MooObj.new(13), 'common-subset')
      assert_equal '"E_PERM"', generate_json(E_PERM, 'common-subset')
      assert_equal '[]', generate_json([], 'common-subset')
      assert_equal '{}', generate_json({}, 'common-subset')
    end
  end

  def test_that_parsing_json_works_for_simple_values_in_common_subset_mode
    run_test_as('wizard') do
      assert_equal 1, parse_json('1', 'common-subset')
      assert_equal 1.1, parse_json('1.1', 'common-subset')
      assert_equal "1.2", parse_json('\"1.2\"', 'common-subset')
      assert_equal [], parse_json('[]', 'common-subset')
      assert_equal({}, parse_json('{}'), 'common-subset')
    end
  end

  def test_that_parsing_json_fails_for_obvious_errors_in_common_subset_mode
    run_test_as('wizard') do
      assert_equal E_INVARG, parse_json('#13', 'common-subset')
      assert_equal E_INVARG, parse_json('E_PERM', 'common-subset')
    end
  end

  def test_that_generating_json_works_for_simple_values_in_embedded_types_mode
    run_test_as('wizard') do
      assert_equal '1', generate_json(1, 'embedded-types')
      assert_equal '1.1', generate_json(1.1, 'embedded-types')
      assert_equal '"1.2"', generate_json("1.2", 'embedded-types')
      assert_equal '"#13|obj"', generate_json(MooObj.new(13), 'embedded-types')
      assert_equal '"E_PERM|err"', generate_json(E_PERM, 'embedded-types')
      assert_equal '[]', generate_json([], 'embedded-types')
      assert_equal '{}', generate_json({}, 'embedded-types')
    end
  end

  def test_that_parsing_json_works_for_simple_values_in_embedded_types_mode
    run_test_as('wizard') do
      assert_equal 1, parse_json('1', 'embedded-types')
      assert_equal 1.1, parse_json('1.1', 'embedded-types')
      assert_equal "1.2", parse_json('\"1.2\"', 'embedded-types')
      assert_equal [], parse_json('[]', 'embedded-types')
      assert_equal({}, parse_json('{}'), 'embedded-types')
    end
  end

  def test_that_parsing_json_fails_for_obvious_errors_in_embedded_types_mode
    run_test_as('wizard') do
      assert_equal E_INVARG, parse_json('#13', 'embedded-types')
      assert_equal E_INVARG, parse_json('E_PERM', 'embedded-types')
    end
  end

  def test_that_parsing_json_works_for_simple_values_with_type_info_in_embedded_types_mode
    run_test_as('wizard') do
      assert_equal 1, parse_json('\"1|int\"', 'embedded-types')
      assert_equal 1.1, parse_json('\"1.1|float\"', 'embedded-types')
      assert_equal "1.2", parse_json('\"1.2|str\"', 'embedded-types')
      assert_equal MooObj.new("#13"), parse_json('\"#13|obj\"', 'embedded-types')
      assert_equal E_PERM, parse_json('\"E_PERM|err\"', 'embedded-types')
    end
  end

  def test_that_parsing_json_with_type_info_does_not_work_in_common_subset_mode
    run_test_as('wizard') do
      assert_equal "1|int", parse_json('\"1|int\"', 'common-subset')
      assert_equal "1.1|float", parse_json('\"1.1|float\"', 'common-subset')
      assert_equal "1.2|str", parse_json('\"1.2|str\"', 'common-subset')
      assert_equal "#13|obj", parse_json('\"#13|obj\"', 'common-subset')
      assert_equal "E_PERM|err", parse_json('\"E_PERM|err\"', 'common-subset')
    end
  end

  def test_that_generating_json_works_for_complex_values_in_default_mode
    run_test_as('wizard') do
      assert_equal '[1,1.1,"1.2","#13","E_ARGS",[2,2.2,"#-1","foo"],{"E_PERM":"E_PERM"}]', generate_json([1, 1.1, "1.2", MooObj.new(13), E_ARGS, [2, 2.2, :nothing, "foo"], {E_PERM => E_PERM}])
      assert_equal '{"11":11,"#13":[1,2,3,"E_QUOTA"],"foo":"bar","33.3":33.3}', generate_json({11 => 11, 33.3 => 33.3, MooObj.new(13) => [1, 2, 3, E_QUOTA], "foo" => "bar"})
    end
  end

  def test_that_generating_json_works_for_complex_values_in_common_subset_mode
    run_test_as('wizard') do
      assert_equal '[1,1.1,"1.2","#13","E_ARGS",[2,2.2,"#-1","foo"],{"E_PERM":"E_PERM"}]', generate_json([1, 1.1, "1.2", MooObj.new(13), E_ARGS, [2, 2.2, :nothing, "foo"], {E_PERM => E_PERM}], 'common-subset')
      assert_equal '{"11":11,"#13":[1,2,3,"E_QUOTA"],"foo":"bar","33.3":33.3}', generate_json({11 => 11, 33.3 => 33.3, MooObj.new(13) => [1, 2, 3, E_QUOTA], "foo" => "bar"}, 'common-subset')
    end
  end

  def test_that_generating_json_works_for_complex_values_in_embedded_types_mode
    run_test_as('wizard') do
      assert_equal '[1,1.1,"1.2","#13|obj","E_ARGS|err",[2,2.2,"#-1|obj","foo"],{"E_PERM|err":"E_PERM|err"}]', generate_json([1, 1.1, "1.2", MooObj.new(13), E_ARGS, [2, 2.2, :nothing, "foo"], {E_PERM => E_PERM}], 'embedded-types')
      assert_equal '{"11|int":11,"#13|obj":[1,2,3,"E_QUOTA|err"],"foo":"bar","33.3|float":33.3}', generate_json({11 => 11, 33.3 => 33.3, MooObj.new(13) => [1, 2, 3, E_QUOTA], "foo" => "bar"}, 'embedded-types')
    end
  end

  def test_that_parsing_json_works_for_complex_values_in_default_mode
    run_test_as('wizard') do
      assert_equal [1, 1.1, "1.2", "#13", "E_ARGS", [2, 2.2, "foo"], {"1" => "1"}], parse_json('[1, 1.1, \"1.2\", \"#13\", \"E_ARGS\", [2, 2.2, \"foo\"], {\"1\": \"1\"}]')
      assert_equal({"11" => 11, "33.3" => 33.3, "#13" => [1, 2, 3, "E_QUOTA"], "foo" => "bar"}, parse_json('{\"11\": 11, \"33.3\": 33.3, \"#13\": [1, 2, 3, \"E_QUOTA\"], \"foo\": \"bar\"}'))
    end
  end

  def test_that_parsing_json_works_for_complex_values_in_common_subset_mode
    run_test_as('wizard') do
      assert_equal [1, 1.1, "1.2", "#13", "E_ARGS", [2, 2.2, "foo"], {"1" => "1"}], parse_json('[1, 1.1, \"1.2\", \"#13\", \"E_ARGS\", [2, 2.2, \"foo\"], {\"1\": \"1\"}]', 'common-subset')
      assert_equal({"11" => 11, "33.3" => 33.3, "#13" => [1, 2, 3, "E_QUOTA"], "foo" => "bar"}, parse_json('{\"11\": 11, \"33.3\": 33.3, \"#13\": [1, 2, 3, \"E_QUOTA\"], \"foo\": \"bar\"}'), 'common-subset')
    end
  end

  def test_that_parsing_json_works_for_complex_values_in_embedded_types_mode
    run_test_as('wizard') do
      assert_equal [1, 1.1, "1.2", MooObj.new('#13'), E_ARGS, [2, 2.2, "foo"], {1 => "1"}], parse_json('[1, 1.1, \"1.2\", \"#13|obj\", \"E_ARGS|err\", [2, 2.2, \"foo\"], {\"1|int\": \"1\"}]', 'embedded-types')
      assert_equal({11.1 => 11, "33.3" => 33.3, MooObj.new('#13') => [1, 2, 3, E_QUOTA], "foo" => "bar"}, parse_json('{\"11.1|float\": 11, \"33.3\": 33.3, \"#13|obj\": [1, 2, 3, \"E_QUOTA|err\"], \"foo\": \"bar\"}', 'embedded-types'))
    end
  end

  def test_that_parsing_json_fails_for_various_reasons
    run_test_as('wizard') do
      assert_equal E_INVARG, parse_json('[1, 1.1, \"1.2\", blah]')
      assert_equal E_INVARG, parse_json('{11: 11, \"33.3\": 33.3, \"foo\": \"bar\"}')
      assert_equal E_INVARG, parse_json('[')
      assert_equal E_INVARG, parse_json('{')
      assert_equal E_INVARG, parse_json('\"')
      assert_equal E_INVARG, parse_json('[12abc]')
      assert_equal E_INVARG, parse_json('1..2')
      assert_equal E_INVARG, parse_json('..')
      assert_equal E_INVARG, parse_json('@$*&#*')
      assert_equal E_INVARG, parse_json('[{[{[')
    end
  end

  def test_for_things_I_hate_that_work
    run_test_as('wizard') do
      assert_equal 12, parse_json('12abc')
    end
  end

  def test_that_parsing_types_only_works_for_well_defined_types
    run_test_as('wizard') do
      assert_equal "", parse_json('\"\"', 'embedded-types')
      assert_equal "|", parse_json('\"|\"', 'embedded-types')
      assert_equal "|x", parse_json('\"|x\"', 'embedded-types')
      assert_equal "|in", parse_json('\"|in\"', 'embedded-types')
      assert_equal "|intx", parse_json('\"|intx\"', 'embedded-types')
      assert_equal 0, parse_json('\"|int\"', 'embedded-types')
      assert_equal 0, parse_json('\"|float\"', 'embedded-types')
      assert_equal "", parse_json('\"|str\"', 'embedded-types')
      assert_equal MooObj.new("#0"), parse_json('\"|obj\"', 'embedded-types')
      assert_equal E_NONE, parse_json('\"|err\"', 'embedded-types')
    end
  end

  def test_that_its_an_error_to_specify_anything_other_than_common_subset_or_embedded_types
    run_test_as('wizard') do
      assert_equal E_TYPE, generate_json(1, 1)
      assert_equal E_TYPE, generate_json(1, 1.23)
      assert_equal E_INVARG, generate_json(1, 'foo-bar')
      assert_equal E_TYPE, generate_json(1, :nothing)
      assert_equal E_TYPE, generate_json(1, E_PERM)
      assert_equal E_TYPE, generate_json(1, [])
      assert_equal E_TYPE, generate_json(1, {})
    end
  end

  def test_that_the_argument_to_parse_json_must_be_a_string
    run_test_as('wizard') do
      assert_equal E_TYPE, parse_json(1)
      assert_equal E_TYPE, parse_json(1.1)
      assert_equal E_TYPE, parse_json(E_ARGS)
      assert_equal E_TYPE, parse_json(:nothing)
      assert_equal E_TYPE, parse_json([])
      assert_equal E_TYPE, parse_json({})
    end
  end

  def test_that_generate_json_turns_moo_binary_string_encoded_values_into_escaped_strings
    run_test_as('wizard') do
      assert_equal "{\"foo\":\"bar\\\"baz\"}", generate_json({"foo" => "bar\\\"baz"})
      assert_equal "{\"foo\":\"bar\\\\baz\"}", generate_json({"foo" => "bar\\\\baz"})
      assert_equal "{\"foo\":\"bar/baz\"}", generate_json({"foo" => "bar\\\/baz"})
      assert_equal "{\"foo\":\"bar/baz\"}", generate_json({"foo" => "bar\/baz"})
      assert_equal "{\"foo\":\"bar/baz\"}", generate_json({"foo" => "bar/baz"})

      assert_equal "{\"foo\":\"bar\\bbaz\"}", generate_json({"foo" => "bar~08baz"})
      assert_equal "{\"foo\":\"bar\\fbaz\"}", generate_json({"foo" => "bar~0Cbaz"})
      assert_equal "{\"foo\":\"bar\\nbaz\"}", generate_json({"foo" => "bar~0Abaz"})
      assert_equal "{\"foo\":\"bar\\rbaz\"}", generate_json({"foo" => "bar~0Dbaz"})
      assert_equal "{\"foo\":\"bar\\tbaz\"}", generate_json({"foo" => "bar~09baz"})

      # everything else is just passed, as is
      assert_equal "{\"foo\":\"bar~00baz\"}", generate_json({"foo" => "bar~00baz"})
      assert_equal "{\"foo\":\"bar~zzbaz\"}", generate_json({"foo" => "bar~zzbaz"})
      assert_equal "{\"foo\":\"bar~f\"}", generate_json({"foo" => "bar~f"})
      assert_equal "{\"foo\":\"bar~\"}", generate_json({"foo" => "bar~"})
    end
  end

  def test_that_parse_json_turns_escaped_strings_into_moo_binary_string_encoded_values
    run_test_as('wizard') do
      assert_equal({"foo" => "bar\"baz"}, parse_json('{\"foo\":\"bar\\\\\\"baz\"}'))
      assert_equal({"foo" => "bar\\baz"}, parse_json('{\"foo\":\"bar\\\\\\\\baz\"}'))
      assert_equal({"foo" => "bar/baz"}, parse_json('{\"foo\":\"bar\\\\/baz\"}'))
      assert_equal({"foo" => "bar/baz"}, parse_json('{\"foo\":\"bar\\/baz\"}'))
      assert_equal({"foo" => "bar/baz"}, parse_json('{\"foo\":\"bar/baz\"}'))

      assert_equal({"foo" => "bar~08baz"}, parse_json('{\"foo\":\"bar\\\\bbaz\"}'))
      assert_equal({"foo" => "bar~0Cbaz"}, parse_json('{\"foo\":\"bar\\\\fbaz\"}'))
      assert_equal({"foo" => "bar~0Abaz"}, parse_json('{\"foo\":\"bar\\\\nbaz\"}'))
      assert_equal({"foo" => "bar~0Dbaz"}, parse_json('{\"foo\":\"bar\\\\rbaz\"}'))
      assert_equal({"foo" => "bar~09baz"}, parse_json('{\"foo\":\"bar\\\\tbaz\"}'))

      # ignore other escapes... this includes \u (Unicode) for the time being
      assert_equal(E_INVARG, parse_json('{\"foo\":\"bar\\\\ubaz\"}'))
      assert_equal(E_INVARG, parse_json('{\"foo\":\"bar\\\\abaz\"}'))
      assert_equal(E_INVARG, parse_json('{\"foo\":\"bar\\\\zbaz\"}'))
      assert_equal(E_INVARG, parse_json('{\"foo\":\"bar\\\\\"}'))
    end
  end

  def test_that_round_tripping_works
    run_test_as('wizard') do
      assert(simplify(command(%Q|; x = ["foo" -> "bar\\\"baz"]; return x == parse_json(generate_json(x)); |)))
      assert(simplify(command(%Q|; x = ["foo" -> "bar\\\\baz"]; return x == parse_json(generate_json(x)); |)))
      assert(simplify(command(%Q|; x = ["foo" -> "bar\\\/baz"]; return x == parse_json(generate_json(x)); |)))
      assert(simplify(command(%Q|; x = ["foo" -> "bar\/baz"]; return x == parse_json(generate_json(x)); |)))
      assert(simplify(command(%Q|; x = ["foo" -> "bar/baz"]; return x == parse_json(generate_json(x)); |)))

      assert(simplify(command(%Q|; x = ["foo" -> "bar~08baz"]; return x == parse_json(generate_json(x)); |)))
      assert(simplify(command(%Q|; x = ["foo" -> "bar~0Cbaz"]; return x == parse_json(generate_json(x)); |)))
      assert(simplify(command(%Q|; x = ["foo" -> "bar~0Abaz"]; return x == parse_json(generate_json(x)); |)))
      assert(simplify(command(%Q|; x = ["foo" -> "bar~0Dbaz"]; return x == parse_json(generate_json(x)); |)))
      assert(simplify(command(%Q|; x = ["foo" -> "bar~09baz"]; return x == parse_json(generate_json(x)); |)))

      assert(simplify(command(%q|; x = "{\\"foo\\": \\"bar\\\\\\"baz\\"}"; return x == generate_json(parse_json(x)); |)))
      assert(simplify(command(%q|; x = "{\\"foo\\": \\"bar\\\\\\\baz\\"}"; return x == generate_json(parse_json(x)); |)))
      assert(simplify(command(%q|; x = "{\\"foo\\": \\"bar\\\\\\/baz\\"}"; return x == generate_json(parse_json(x)); |)))
      assert(simplify(command(%q|; x = "{\\"foo\\": \\"bar\\\\/baz\\"}"; return x == generate_json(parse_json(x)); |)))
      assert(simplify(command(%q|; x = "{\\"foo\\": \\"bar/baz\\"}"; return x == generate_json(parse_json(x)); |)))

      assert(simplify(command(%q|; x = "{\\"foo\\": \\"bar\\\\\\bbaz\\"}"; return x == generate_json(parse_json(x)); |)))
      assert(simplify(command(%q|; x = "{\\"foo\\": \\"bar\\\\\\fbaz\\"}"; return x == generate_json(parse_json(x)); |)))
      assert(simplify(command(%q|; x = "{\\"foo\\": \\"bar\\\\\\nbaz\\"}"; return x == generate_json(parse_json(x)); |)))
      assert(simplify(command(%q|; x = "{\\"foo\\": \\"bar\\\\\\rbaz\\"}"; return x == generate_json(parse_json(x)); |)))
      assert(simplify(command(%q|; x = "{\\"foo\\": \\"bar\\\\\\tbaz\\"}"; return x == generate_json(parse_json(x)); |)))
    end
  end

  def test_that_round_tripping_works_on_fuzzy_inputs
    run_test_as('wizard') do
      with_mutating_binary_string("~A7~CED~8E~D2L~16a~F6~F2~01UZ2~BC~B0)~EC~02~86v~CD~9B~05~E66~F3.vx<~F0") do |g|
        100.times do
          assert(simplify(command(%Q|; x = "#{g.next}"; return x == parse_json(generate_json(x)); |)))
        end
      end
    end
  end

  def generate_json(value, mode = nil)
    if mode.nil?
      simplify command %Q|; return generate_json(#{value_ref(value)});|
    else
      simplify command %Q|; return generate_json(#{value_ref(value)}, #{value_ref(mode)});|
    end
  end

  def parse_json(value, mode = nil)
    if mode.nil?
      simplify command %Q|; return parse_json(#{value_ref(value)});|
    else
      simplify command %Q|; return parse_json(#{value_ref(value)}, #{value_ref(mode)});|
    end
  end

  def value_ref(value)
    case value
    when String
      "\"#{value}\""
    when Symbol
      "$#{value.to_s}"
    when MooErr
      value.to_s
    when MooObj
      "##{value.to_s}"
    when Array
      '{' + value.map { |o| value_ref(o).to_s }.join(', ') + '}'
    when Hash
      '[' + value.map { |a, b| value_ref(a).to_s + " -> " + value_ref(b).to_s }.join(', ') + ']'
    else
      value
    end
  end

end
