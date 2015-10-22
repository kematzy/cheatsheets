cheatsheet do
  title 'Minitest Reference'
  docset_file_name 'Ruby_Minitest'
  keyword 'minitest ruby'
  source_url 'http://cheat.kapeli.com'

  introduction <<-MD
    A *"complete"* Ruby [Minitest](https://github.com/seattlerb/minitest) reference. Currently work in progress.
  MD
  
  category do
    id 'Minitest :: Assertions'

    entry do
      name 'Introduction'
      notes <<-MD
      All assertion methods accept a `msg` which is printed if the assertion fails.
      
      Nearly everything here boils up to `assert()`, which expects to be able to increment an instance accessor 
      named assertions. This is not provided by `Assertions` and must be provided by the thing/item including `Assertions`. 
      Refer to `Minitest::Runnable` for an example.
      MD
    end
    
    entry do
      name "### Instance Methods"
    end
    
    entry do
      command 'assert()'
      name    'assert(test, msg = nil)'
      notes   "Fails unless test is truthy."
    end
    
    entry do
      command 'assert_empty()'
      name    'assert_empty(obj, msg = nil)'
      notes    "Fails unless obj is empty."
    end
    
    entry do
      command 'assert_equal()'
      name    'assert_equal(exp, act, msg = nil)'
      notes    <<-MD
        Fails unless exp == act printing the difference between the two, if possible.
        
        If there is no visible difference but the assertion fails, you should suspect that your
        `#==` is buggy, or your inspect output is missing crucial details.
        
        For floats use `assert\_in\_delta`. Refer to also: `::diff`
      MD
    end
    
    entry do
      command 'assert_in_delta()'
      name    'assert\_in\_delta(exp, act, delta = 0.001, msg = nil)'
      notes    <<-MD
        For comparing Floats. Fails unless exp and act are within delta of each other.
        
        ```ruby
        assert_in_delta Math::PI, (22.0 / 7.0), 0.01
        ```
      MD
    end
    
    entry do
      command 'assert_in_epsilon()'
      name    'assert\_in\_epsilon(a, b, epsilon = 0.001, msg = nil)'
      notes    <<-MD
        For comparing Floats. Fails unless exp and act have a relative error less than epsilon.
      MD
    end
    
    entry do
      command 'assert_in_epsilon()'
      name    'assert\_in\_epsilon(a, b, epsilon = 0.001, msg = nil)'
      notes    <<-MD
        For comparing Floats. Fails unless exp and act have a relative error less than epsilon.
      MD
    end
    
    entry do
      command 'assert_includes()'
      name    'assert_includes(collection, obj, msg = nil)'
      notes   <<-MD
      Fails unless collection includes obj.
      MD
    end
    
    entry do
      command 'assert_instance_of()'
      name    'assert\_instance\_of(cls, obj, msg = nil)'
      notes   "Fails unless `obj` is an instance of cls."
    end
    
    entry do
      command 'assert_kind_of()'
      name    'assert\_kind\_of(cls, obj, msg = nil)'
      notes   "Fails unless `obj` is a kind of cls."
    end
    
    entry do
      command 'assert_match()'
      name    'assert_match(matcher, obj, msg = nil)'
      notes   "Fails unless matcher =~ obj."
    end

    entry do
      command 'assert_nil()'
      name    'assert_nil(obj, msg = nil)'
      notes   "Fails unless `obj` is nil"
    end

    entry do
      command 'assert_operator()'
      name    'assert_operator(o1, op, o2 = UNDEFINED, msg = nil)'
      notes   <<-MD
        For testing with binary operators. Eg:
        
        ```ruby
        assert_operator 5, :<=, 4
        ```
      MD
    end
    
    entry do
      command 'assert_output() {}'
      name    'assert_output(stdout = nil, stderr = nil) { || ... }'
      notes   <<-MD
        Fails if `stdout` or `stderr` do not output the expected results. 
        Pass in `nil` if you don't care about that streams output. 
        Pass in `“”` if you require it to be silent. Pass in a `regexp` if you want to pattern match.
        
        NOTE: this uses `capture_io`, not `capture_subprocess_io`.
        
        Refer to also: `assert_silent`
      MD
    end
    
    entry do
      command 'assert_predicate()'
      name    'assert_predicate(o1, op, msg = nil)'
      notes   <<-MD
        For testing with predicates. Eg:
        
        ```ruby
        assert_predicate str, :empty?
        ```

        This is really meant for specs and is front-ended by #assert_operator:

        ```ruby
        str.must_be :empty?
        ```
      MD
    end
    
    entry do
      command 'assert_raises() {}'
      name    'assert_raises(*exp) { || ... }'
      notes   <<-MD
        Fails unless the block raises one of exp. Returns the exception matched so you can check the message, attributes, etc.
        
        `exp` takes an optional message on the end to help explain failures and defaults to `StandardError` if no exception class is passed.
      MD
    end
    
    entry do
      command 'assert_respond_to()'
      name    'assert\_respond\_to(obj, meth, msg = nil)'
      notes   "Fails unless `obj` responds to meth."
    end
    
    entry do
      command 'assert_same()'
      name    'assert_same(exp, act, msg = nil)'
      notes   "Fails unless `exp` and act are equal?"
    end

    entry do
      command 'assert_send()'
      name    'assert\_send(send\_ary, m = nil)'
      notes    <<-MD
        `send_ary` is a receiver, message and arguments.
        
        Fails unless the call returns a `true` value
      MD
    end
    
    entry do
      command 'assert_silent() {}'
      name    'assert_silent() { || ... }'
      notes   <<-MD
        Fails if the block outputs anything to stderr or stdout.
        Refer to also: `assert_output`
      MD
    end
    
    entry do
      command 'assert_throws() {}'
      name    'assert_throws(sym, msg = nil) { || ... }'
      notes   "Fails unless the block throws sym"
    end

    entry do
      command 'capture_io() {}'
      name    'capture_io() { || ... }'
      notes    <<-MD
        Captures `$stdout` and `$stderr` into strings:
        
        ```ruby
        out, err = capture_io do
          puts "Some info"
          warn "You did a bad thing"
        end
        
        assert_match %r%info%, out
        assert_match %r%bad%, err
        ```
        
        NOTE: For efficiency, this method uses `StringIO` and does not capture IO for subprocesses. 
        Use `capture_subprocess_io` for that.
      MD
    end

    entry do
      command 'capture_subprocess_io() {}'
      name    'capture_subprocess_io() { || ... }'
      notes    <<-MD
        Captures `$stdout` and `$stderr` into strings, using `Tempfile` to ensure that subprocess IO is captured as well.

        ```ruby
        out, err = capture_subprocess_io do
          system "echo Some info"
          system "echo You did a bad thing 1>&2"
        end

        assert_match %r%info%, out
        assert_match %r%bad%, err
        ```
        NOTE: This method is approximately 10x slower than `capture_io` so only use it when you need to test the output of a subprocess.
      MD
    end
    
    entry do
      command 'diff()'
      name    'diff(exp, act)'
      notes   "Returns a diff between exp and act. If there is no known diff command or if it doesn't make sense to diff the output (single line, short output), 
              then it simply returns a basic comparison between the two."
    end

    entry do
      command 'exception_details()'
      name    'exception_details(e, msg)'
      notes   "Returns details for exception `e`"
    end
    
    entry do
      command 'flunk()'
      name    'flunk(msg = nil)'
      notes   "Fails with msg"
    end

    entry do
      command 'message()'
      name    'message(msg = nil, ending = nil, &default)'
      notes   "Returns a proc that will output msg along with the default message."
    end
    
    entry do
      command 'mu_pp()'
      name    'mu_pp(obj)'
      notes   "This returns a human-readable version of `obj`. By default `inspect` is called. You can override this to use `pretty_print` if you want."
    end
    
    entry do
      command 'mu_pp_for_diff()'
      name    'mu\_pp\_for_diff(obj)'
      notes   <<-MD
        This returns a diff-able human-readable version of `obj`. This differs from the regular `#mu_pp` because it expands escaped newlines and makes hex-values generic (like object_ids). 
        This uses `#mu_pp` to do the first pass and then cleans it up.
      MD
    end
    
    entry do
      command 'pass()'
      name    'pass(_msg = nil)'
      notes   "used for counting assertions"
    end

    entry do
      name   'Negating Assertions'
      notes  "Generally used to prove that something is not."
    end

    entry do
      command 'refute()'
      name    'refute(test, msg = nil)'
      notes   "Fails if test is truthy."
    end

    entry do
      command  'refute_empty()'
      name    'refute_empty(obj, msg = nil)'
      notes   "Fails if obj is empty."
    end
    
    entry do
      command 'refute_equal()'
      name    'refute_equal(exp, act, msg = nil)'
      notes   <<-MD
        Fails if `exp == act`.
        
        For floats use `refute\_in\_delta`.
      MD
    end
      
    entry do
      command 'refute_in_delta()'
      name    'refute\_in\_delta(exp, act, delta = 0.001, msg = nil)'
      notes   <<-MD
        For comparing Floats. Fails if exp is within delta of act.
        
        ```ruby
        refute_in_delta Math::PI, (22.0 / 7.0)
        ```
      MD
    end

    entry do
      command 'refute_in_epsilon()'
      name    'refute\_in\_epsilon(a, b, epsilon = 0.001, msg = nil)'
      notes   "For comparing Floats. Fails if exp and act have a relative error less than epsilon."
    end
    
    entry do
      command 'refute_includes()'
      name    'refute_includes(collection, obj, msg = nil)'
      notes   "Fails if collection includes obj."
    end
    
    entry do
      command   'refute_instance_of()'
      name      'refute\_instance\_of(cls, obj, msg = nil)'
      notes     "Fails if `obj` is an instance of `cls`."
    end
    
    entry do
      command   'refute_kind_of()'
      name      'refute\_kind\_of(cls, obj, msg = nil)'
      notes     "Fails if `obj` is a kind of `cls`."
    end
    
    entry do
      command   'refute_match()'
      name      'refute_match(matcher, obj, msg = nil)'
      notes     "Fails if `matcher =~ obj`."
    end

    entry do
      command   'refute_nil()'
      name      'refute_nil(obj, msg = nil)'
      notes     "Fails if obj is nil."
    end

    entry do
      command   'refute_operator()'
      name      'refute_operator(o1, op, o2 = UNDEFINED, msg = nil)'
      notes     <<-MD
        Fails if o1 is not op o2. Eg:

        ```ruby
        refute_operator 1, :>, 2 #=> pass
        refute_operator 1, :<, 2 #=> fail
        ```
      MD
    end
    
    entry do
      command   'refute_predicate()'
      name      'refute_predicate(o1, op, msg = nil)'
      notes     <<-MD
        For testing with predicates.
        
        ```ruby
        refute_predicate str, :empty?
        ```
        This is really meant for specs and is front-ended by #refute_operator:
        
        ```ruby
        str.wont_be :empty?
        ```
      MD
    end
    
    entry do
      command   'refute_respond_to()'
      name      'refute\_respond\_to(obj, meth, msg = nil)'
      notes     "Fails if `obj` responds to the message meth."
    end
    
    entry do
      command   'refute_same()'
      name      'refute_same(exp, act, msg = nil)'
      notes     "Fails if exp is the same (by object identity) as act."
    end

    entry do
      command   'skip()'
      name      'skip(msg = nil, bt = caller)'
      notes     <<-MD
        Skips the current run. If run in verbose-mode, the skipped run gets listed at the end of 
        the run but doesn't cause a failure exit code.
      MD
    end
    
    entry do
      command   'skipped?()'
      name      'skipped?()'
      notes     "Was this testcase skipped? Meant for teardown."
    end
    
  end

  category do
    id 'Minitest :: Expectations (spec syntax)'

    entry do
      name 'Introduction'
      notes <<-MD
      It's where you hide your “assertions”.
      
      Please note, because of the way that expectations are implemented, all expectations (eg `#must\_equal`) 
      are dependent upon a thread local variable `:current_spec`. 
      
      If your specs rely on mixing threads into the specs themselves, you're better off using assertions 
      or the new `_(value)` wrapper. 
      
      For example:
      
      ```ruby
      it "should still work in threads" do
        my_threaded_thingy do
          (1+1).must_equal 2         # bad
          assert_equal 2, 1+1        # good
          _(1 + 1).must_equal 2      # good
          value(1 + 1).must_equal 2  # good, also #expect
        end
      end
      ```
      MD
    end
    
    entry do
      name "### Instance Methods"
    end
    
    entry do
      command  'must_be()'
      name    'must_be()'
      notes   <<-MD
        Fails unless test is truthy.
        
        ```ruby
        n.must_be :<=, 42
        ```
        
        This can also do predicates:

        ```ruby
        str.must_be :empty?
        ```
        
        For testing with binary operators. Eg:
        
        ```ruby
        assert_operator 5, :<=, 4
        ```
        Refer to Assertions `#assert\_operator`.
      MD
    end
    
    entry do
      command    'must_be_close_to()'
      name    'must\_be\_close\_to()'
      notes   <<-MD
        
        ```ruby
        n.must_be_close_to m [, delta]
        ```
        
        Refer to Assertions `#assert\_in\_delta`. Also aliased as: `must\_be\_within\_delta`.
      MD
    end
    
    entry do
      command   'must_be_empty()'
      name      'must\_be\_empty()'
      notes   <<-MD
        Fails unless obj is empty.
        
        ```ruby
        collection.must_be_empty
        ```
        
        Refer to Assertions `#assert\_empty`.
      MD
    end
    
    entry do
      command  'must_equal()'
      name     'must_equal()'
      notes    <<-MD
        Fails unless exp == act printing the difference between the two, if possible.
        
        If there is no visible difference but the assertion fails, you should suspect that your
        `#==` is buggy, or your inspect output is missing crucial details.
        
        For floats use `assert\_in\_delta`. Refer to also: `::diff`
        
        ```ruby
        a.must_equal b
        ```
        
        Refer to Assertions `#assert\_equal`.
      MD
    end
    
    entry do
      command 'must_be_within_delta()'
      name    'must\_be\_within\_delta()'
      notes    <<-MD
      ```ruby
        n.must_be_within_delta m [, delta]
        ```
        
        ```ruby
        assert_in_delta Math::PI, (22.0 / 7.0), 0.01
        ```
        
        Alias for: `must\_be\_close\_to`.
      MD
    end
    
    entry do
      command 'must_be_within_epsilon()'
      name    'must\_be\_within\_epsilon()'
      notes    <<-MD
        For comparing Floats. Fails unless exp and act have a relative error less than epsilon.
        
        ```ruby
        n.must_be_within_epsilon m [, epsilon]
        ```
        Refer to Assertions `#assert\_in\_epsilon`.
      MD
    end
    
    entry do
      command   'must_include()'
      name      'must_include(obj, msg = nil)'
      notes   <<-MD
        Fails unless collection includes obj.
        
        ```ruby
        collection.must_include obj
        ```
        Refer to Assertions `#assert\_includes`.
      MD
    end
    
    entry do
      command   'must_be_instance_of()'
      name      'must\_be\_instance\_of()'
      notes  <<-MD
        Fails unless `obj` is an instance of cls.

        ```ruby
        obj.must_be_instance_of klass
        ```
        
        Refer to Assertions `#assert\_instance\_of`.
      MD
    end
    
    entry do
      command 'must_be_kind_of()'
      name    'must\_be\_kind\_of()'
      notes   <<-MD
        Fails unless `obj` is a kind of cls.
        
        ```ruby
        obj.must_be_kind_of mod
        ```
        
        Refer to Assertions `#assert\_kind\_of`.
      MD
    end
    
    entry do
      command   'must_match()'
      name   'must_match(obj, msg = nil)'
      notes  <<-MD
        Fails unless matcher =~ obj.
        
        ```ruby
        a.must_match b
        ```
        Refer to Assertions `#assert\_match`.
      MD
    end
    
    entry do
      command 'must_be_nil()'
      name    'must\_be\_nil()'
      notes   <<-MD
        Fails unless `obj` is nil.
        
        ```ruby
        obj.must_be_nil
        ```
        
        Refer to Assertions `#assert\_nil`.
      MD
    end
    
    entry do
      command   'must_output()'
      name   'must_output(stdout = nil, stderr = nil)'
      notes  <<-MD
        Fails if `stdout` or `stderr` do not output the expected results. 
          
        Pass in `nil` if you don't care about that streams output. 
        
        Pass in `“”` if you require it to be silent. Pass in a `regexp` if you want to pattern match.
        
        
        
        NOTE: this uses `capture\_io`, not `capture\_subprocess\_io`. Also refer to: `assert\_silent` or `must\_be\_silent`
        
        ```ruby
        proc { ... }.must_output out_or_nil [, err]
        ```
        
        Refer to Assertions `#assert\_output`.
      MD
    end
    
    entry do
      command 'must_raise()'
      name    'must_raise(*exp)'
      notes   <<-MD
        Fails unless the block raises one of `exp`. 
        
        Returns the exception matched so you can check the message, attributes, etc.
        
        `exp` takes an optional message on the end to help explain failures and defaults to 
        `StandardError` if no exception class is passed.
        
        ```ruby
        proc { ... }.must_raise exception
        ```
        
        Refer to Assertions `#assert_raises`.
      MD
    end
    
    entry do
      command 'must_respond_to()'
      name    'must\_respond\_to(meth, msg = nil)'
      notes  <<-MD
        Fails unless `obj` responds to meth.
        
        ```ruby
        obj.must_respond_to :meth
        ```
        
        Refer to Assertions `#assert\_respond\_to`.
      MD
    end
    
    entry do
      command 'must_be_same()'
      name   'must\_be\_same()'
      notes  <<-MD
        Fails unless `a` and b are equal?.
        
        ```ruby
        a.must_be_same_as b
        ```
        
        Refer to Assertions `#assert\_same`.
      MD
    end
    
    entry do
      command 'must_be_silent() {}'
      name   'must\_be\_silent() { || ... }'
      notes  <<-MD
        Fails if the block outputs anything to stderr or stdout.
        
        ```ruby
        proc { ... }.must_be_silent
        ```
        
        Refer to Assertions `#assert\_silent`.
      MD
    end
    
    entry do
      command 'must_throw() {}'
      name   'must\_throw(sym, msg = nil) { || ... }'
      notes  <<-MD
        Fails unless the block throws sym.
        
        ```ruby
        proc { ... }.must_throw sym
        ```
        
        Refer to Assertions `#assert\_throws`.
      MD
    end
    
    entry do
      command   'wont_be_empty()'
      name   'wont\_be\_empty()'
      notes  <<-MD
        Fails if obj is empty.
        
        ```ruby
        collection.wont_be_empty
        ```
        
        Refer to Assertions `#refute\_empty`.
      MD
    end
    
    entry do
      command 'wont_equal()'
      name    'wont_equal(act, msg = nil)'
      notes   <<-MD
        Fails if `exp == act`. For floats use `refute\_in\_delta`. 
        
        ```ruby
        a.wont_equal b
        ```
        
        Refer to Assertions `#refute\_equal`.
      MD
    end
      
    entry do
      command 'wont_be_within_delta()'
      name    'wont\_be\_within\_delta()'
      notes   <<-MD
      For comparing Floats. Fails if exp is within delta of act.
        
        ```ruby
        n.wont_be_within_delta m [, delta]
        
        refute_in_delta Math::PI, (22.0 / 7.0)
        ```
        
        Alias for: `wont\_be\_close\_to()`.
      MD
    end

    entry do
      command 'wont_be_within_epsilon()'
      name   'wont\_be\_within\_epsilon()'
      notes  <<-MD
        For comparing Floats. Fails if exp and act have a relative error less than epsilon.
        
        ```ruby
        n.wont_be_within_epsilon m [, epsilon]
        ```
        
        Refer to Assertions `#refute\_in\_epsilon`.
      MD
    end
    
    entry do
      command 'wont_include()'
      name    'wont_include(obj, msg = nil)'
      notes   <<-MD
        Fails if collection includes obj.
        
        ```ruby
        collection.wont_include obj
        ```
        
        Refer to Assertions `#refute\_includes`.
      MD
    end
    
    entry do
      command 'wont_be_instance_of()'
      name   'wont\_be\_instance\_of(obj, msg = nil)'
      notes  <<-MD
        Fails if `obj` is an instance of `klass`.
        
        ```ruby
        obj.wont_be_instance_of klass
        ```
        Refer to Assertions `#refute\_instance\_of`.
      MD
    end
    
    entry do
      command 'wont_be_kind_of()'
      name    'wont\_be\_kind\_of(obj, msg = nil)'
      notes   <<-MD
        Fails if `obj` is a kind of `cls`.
        
        ```ruby
        obj.wont_be_kind_of cls
        ```
        Refer to Assertions `#refute\_kind\_of`.
      MD
    end
    
    entry do
      command   'wont_match()'
      name   'wont_match(obj, msg = nil)'
      notes  <<-MD
        Fails if `matcher =~ obj`.
        
        ```ruby
        a.wont_match b
        ```
        
        Refer to Assertions `#refute\_match`.
      MD
    end

    entry do
      command 'wont_be_nil()'
      name   'wont\_be\_nil(msg = nil)'
      notes  <<-MD
        Fails if obj is nil. 
        
        ```ruby
        obj.wont_be_nil
        ```
        Refer to Assertions `#refute\_nil`.
      MD
    end

    entry do
      command 'wont_be()'
      name   'wont_be()'
      notes <<-MD
        ```ruby
        n.wont_be :<=, 42
        ```
        
        This can also do predicates:
        
        ```ruby
        str.wont_be :empty?
        ```
        
        Fails if o1 is not op o2. Eg:

        ```ruby
        refute_operator 1, :>, 2 #=> pass
        refute_operator 1, :<, 2 #=> fail
        ```
        Refer to Assertions `#refute\_operator`.
      MD
    end
    
    entry do
      command   'wont_be_close_to()'
      name      'wont\_be\_close\_to()'
      notes  <<-MD
      ```ruby
        n.wont_be_close_to m [, delta]
        ```
        
        Refer to Assertions `#refute\_in\_delta`. Also aliased as: `wont\_be\_within\_delta`.
      MD
    end
    
    entry do
      command   'wont_respond_to()'
      name      'wont\_respond\_to()'
      notes  <<-MD
        Fails if `obj` responds to the meth.
        
        ```ruby
        obj.wont_respond_to meth
        ```
        
        Refer to Assertions `#refute\_respond\_to`.
        MD
    end
    
    entry do
      command   'wont_be_same_as()'
      name      'wont\_be\_same\_as()'
      notes  <<-MD
      Fails if exp is the same (by object identity) as act.
        
        ```ruby
        a.wont_be_same_as b
        ```
        Refer to Assertions `#refute\_same`.
      MD
    end
    
  end
  
  
  category do
    id "Minitest :: Mocks"
    
    entry do
      notes <<-MD
        Mocks and stubs defined using terminology by Fowler & Meszaros at www.martinfowler.com/bliki/TestDouble.html:
        
        *“Mocks are pre-programmed with expectations which form a specification of the calls they are expected to receive. They can throw an exception if they receive a call they don't expect and are checked during verification to ensure they got all the calls they were expecting.”*
        
        ```ruby
        class MemeAsker
          def initialize(meme)
            @meme = meme
          end

          def ask(question)
            method = question.tr(" ", "_") + "?"
            @meme.__send__(method)
          end
        end
        ```
        
        ```ruby
        require "minitest/autorun"

        describe MemeAsker, :ask do
          describe "when passed an unpunctuated question" do
            it "should invoke the appropriate predicate method on the meme" do
              @meme = Minitest::Mock.new
              @meme_asker = MemeAsker.new @meme
              @meme.expect :will_it_blend?, :return_value

              @meme_asker.ask "will it blend"

              @meme.verify
            end
          end
        end
        ```
      MD
      
    end #/entry
   
  end #/category
   
  category do
    id 'Minitest :: Stubs'
    
    entry do
      
      notes <<-MD
        Mocks and stubs are defined using terminology by Fowler & Meszaros at www.martinfowler.com/bliki/TestDouble.html:
        
        *“Stubs provide canned answers to calls made during the test”*.
        
        Minitest's stub method overrides a single method for the duration of the block.
        
        ```ruby
        def test_stale_eh
          obj_under_test = Something.new

          refute obj_under_test.stale?

          Time.stub :now, Time.at(0) do   # stub goes away once the block is done
            assert obj_under_test.stale?
          end
        end
        ```
        
        A note on stubbing: In order to stub a method, the **method must actually exist prior to stubbing**. 
        Use a singleton method to create a new non-existing method:
        
        ```ruby
        def obj_under_test.fake_method
          ...
        end
        ```
      MD
      
    end #/entry
   
  end #/category
    
  
  category do
    id 'Minitest :: Running Your Tests'
    
    entry do
        notes <<-MD
          Ideally, you'll use a rake task to run your tests, either piecemeal or all at once. Both rake and rails ship with rake tasks for running your tests. BUT! You don't have to:

          ```bash
          % ruby -Ilib:test test/minitest/test_minitest_unit.rb
          Run options: --seed 37685

          # Running:

          ...................................................................... (etc)

          Finished in 0.107130s, 1446.8403 runs/s, 2959.0217 assertions/s.

          155 runs, 317 assertions, 0 failures, 0 errors, 0 skips
          ```

          There are runtime options available, both from minitest itself, and also provided via plugins.

          To see them, simply run with `–help`:

          ```bash
          % ruby -Ilib:test test/minitest/test_minitest_unit.rb --help
          minitest options:
              -h, --help                       Display this help.
              -s, --seed SEED                  Sets random seed
              -v, --verbose                    Verbose. Show progress processing files.
              -n, --name PATTERN               Filter run on /pattern/ or string.

          Known extensions: pride, autotest
              -p, --pride                      Pride. Show your testing pride!
              -a, --autotest                   Connect to autotest server.
          ```
        MD
    end #/entry
   
  end #/category
    
  
  
  notes <<-MD
    * Based on information taken from [Minitest](https://github.com/seattlerb/minitest/) and a collection of other sources.
    * Converted and extended by [Kematzy](https://github.com/kematzy).
  MD
  
end