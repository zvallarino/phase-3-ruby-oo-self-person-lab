# OO Person

![people](https://s3-us-west-2.amazonaws.com/web-dev-readme-photos/oo-labs/people.jpg)

# Tutorial
## RSpec Test 1: `::new`


```ruby
Person
  instantiation
    ::new
      a new person is instantiated with a name (FAILED - 1)

Failures:
  1) Person instantiation `::new` a new person is instantiated with a name
     Failure/Error: let(:stella) { Person.new("Stella") }
     NameError:
       uninitialized constant Person
```

Our 1st hint is the NameError `uninitialized constant Person`.  This error points to the fact that we do not have a person class.

Open up the person.rb file in lib directory and write the code that gets the first test to pass:

```ruby

class Person
end

```
And then run rspec with the fail fast option, `rspec --fail-fast`, to get our next hint.

**2nd Hint**

```ruby
Person
  instantiation
    ::new
      a new person is instantiated with a name (FAILED - 1)

Failures:
  1) Person instantiation ::new a new person is instantiated with a name
     Failure/Error: let(:stella) { Person.new("Stella") }
     ArgumentError:
       wrong number of arguments (1 for 0)
       # ./spec/person_spec.rb:3:in `initialize'
       # ./spec/person_spec.rb:3:in `new'

```

Our 2nd hint is the ArgumentError `wrong number of arguments (1 for 0)`. To get an even better idea of what this error means, we will examine the next 2 lines.

**Line 3: `# ./spec/person_spec.rb:3:in 'initialize'`**
- In Ruby, `::new` typically calls the instance method `#initialize`
- `#initialize` then instructs the newly instantiated object to set its internal state up according to the parameters requested
- inside the definition  of `#method`, we almost always make the argument being passed in accessible by setting it equal to an instance variable

For this test, it appears that `#initialize` expects to accept an argument (name), via `::new`.  Putting all this together, our code in `lib/person.rb` should look like this:

```ruby
class Person

  def initialize(name)
    @name = name
  end

end
```

Update your code to reflect the change above and then run rspec with the fail fast option.

## RSpec Test 2: `#name`
```ruby
Person
  (passing code omitted for brevity)
  #initialize
    #name
      a new person knows its name once he/she has been initialized (FAILED - 1)

Failures:

  1) Person instantiation #initialize #name a new person knows its name once he/she has been initialized
     Failure/Error: expect(person.name).to eq(name)
     NoMethodError:
       undefined method `name' for #<Person:0x007f992d0ac508 @name="Stella">

```

Here we have a **NoMethodError error** `undefined method 'name' for #<Person:0x007f992d0ac508 @name="Stella">`. An even better hint lies right about our  **NoMethodError error**: `Failure/Error: expect(person.name).to eq(name)`. Given the above hints, what type of methods do you think needs to be added to class `Person`?  Take a moment to think about this before looking at the solution below.

> Point to Consider:
> Given that the README for this lab instructs us **to create a person class that is initialized with a name that cannot be changed** you need only one type of accessor method.

```ruby
class Person

  attr_reader :name

  def initialize(name)
    @name = name
  end
end
```

Update your code to reflect the change above and then run rspec with the fail fast option.



## RSpec Test 3: `#bank_account`
```ruby
Person
(passing code omitted for brevity)
  #initialize
    #bank_account
      a new person instance is initialized with a bank_account balance of $25 (FAILED - 1)

Failures:
  1) Person instantiation #initialize #bank_account a new person instance is initialized with a bank_account balance of $25
     Failure/Error: people.each { |person| expect(person.bank_account).to eq(25) }
     NoMethodError:
       undefined method `bank_account' for #<Person:0x007fd0714cd3f0 @name="Stella">

```

A couple of things are going on here:
- We have a `NoMethodError` for `#bank_account`. We also need `person.bank_account` to return the integer 25.  What instance method do you think you need to add to `class Person` to achieve this?
- the line `1) Person instantiation #initialize #bank_account a new person instance is initialized with a bank_account balance of $25` points out that `#back_account` is tied to `#initialize`


Write out the code that you think should get this test to pass. And then compare it to the solution below.

```ruby
class Person

  attr_reader :name, :back_account

  def initialize(name)
    @name = name
    @bank_account = 25
  end
end
```

At this point, when we run rspec with the fail fast option we should see this error message:

```ruby
Person
(passing code omitted for brevity)
  #initialize
    #bank_account
      a person instance can change his/her bank_account amount (FAILED - 1)

Failures:

  1) Person instantiation #initialize #bank_account a person instance can change his/her bank_account amount
     Failure/Error: expect(person.bank_account += 1).to eq (original_amount + 1)
     NoMethodError:
       undefined method `bank_account=' for #<Person:0x007fa6cba6d3c0 @name="Stella", @bank_account=25>

```

How do we change our code base to reflect that a person should be able to BOTH know how much she has in her bank account and change that amount (either by increasing or decreasing the amount of money in her bank account)?

See if you can refactor your code to get this test to pass before looking at the solution below.

```ruby
class Person

  attr_reader :name
  attr_accessor :bank_account

  def initialize(name)
    @name = name
    @bank_account = 25
  end
end
```


## RSpec Test 4: `#happiness`

```ruby
Person
  (passing code omitted for brevity)
  #initialize
    #happiness
      a new person instance is initialized with a happiness index of 8 (FAILED - 1)

Failures:
  1) Person instantiation #initialize #happiness  a new person instance is initialized with a happiness index of 8
     Failure/Error: people.each { |person| expect(person.happiness).to eq(8)}
     NoMethodError:
       undefined method `happiness' for #<Person:0x007fd2ac3ab228 @name="Stella", @bank_account=25>


```
Again, we encounter a `NoMethodError` but this time around its for `#happiness`. We will also need `person.happiness` to return the integer 8. The line `1) Person instantiation #initialize #happiness a new person instance is initialized with a happiness index of 8` points out that `#happiness` is tied to `#initialize`.

Write out the code that you think should get this test to pass. And then compare it to the solution below.

```ruby
class Person

  attr_reader :name, :happiness
  attr_accessor :bank_account

  def initialize(name)
    @name = name
    @bank_account = 25
    @happiness = 8
  end
end
```

At this point, when we run rspec with the fail fast option we should see this error message:

```ruby
Person
  (passing code omitted for brevity)
  #initialize
    #happiness
      a person instance can change his/her happiness index (FAILED - 1)

Failures:

  1) Person instantiation #initialize #happiness a person instance can change his/her happiness index
     Failure/Error: person.happiness += 1
     NoMethodError:
       undefined method `happiness=' for #<Person:0x007fb5db9f1b70>
```

How do we change our code base to reflect that a person should be able to know how happy he/she is and also be able to change increase or decrease his/her happiness index?

See if you can refactor your code to get this test to pass before looking at the solution below.

```ruby
class Person

  attr_reader :name
  attr_accessor :bank_account, :happiness

  def initialize(name)
    @name = name
    @bank_account = 25
    @happiness = 8
  end
end
```
When we run rspec again we should see this error message:

```ruby
Person
  (passing code omitted for brevity)
  #initialize
    #happiness
      a person's happiness doesn't exceed 10 (FAILED - 1)

Failures:
  1) Person instantiation #initialize #happiness a person's happiness doesn't exceed 10
     Failure/Error: expect(person.happiness).to eq(10)

       expected: 10
            got: 108
```

Hmmm ... this is interesting.  It appears that we need to define our setter/attr_writer for happiness in such a way as that its index never greater than 10.
attr_writer
See if you can get the above test to pass and then compare your answer to the one below. Do not fret if your code does not explicitly match the solution - the two most important things are that:

 - you understand what your code is doing, and
 - that your code works (you can refactor your solution later)


```ruby
class Person

  attr_reader :name, :happiness
  attr_accessor :bank_account

  def initialize(name)
    @name = name
    @bank_account = 25
    @happiness = 8
  end

  def happiness=(num)
    @happiness = num
    @happiness  = 10 if @happiness > 10
  end
end
```

The next error we see deals with setting a limit on how unhappy a person can be:

```ruby
Person
  (passing code omitted for brevity)
  #happiness
    a person's happiness doesn't go below 0 (FAILED - 1)

Failures:
  1) Person instantiation #initialize #happiness a person's happiness doesn't go below 0
     Failure/Error: expect(person.happiness).to eq(0)

       expected: 0
            got: -92

       (compared using ==)

```

We get the above test to pass by simply adding a line that handles this specific situation to our setter/attr_writer for happiness:

```ruby
class Person

  attr_reader :name, :happiness
  attr_accessor :bank_account

  def initialize(name)
    @name = name
    @bank_account = 25
    @happiness = 8
  end

  def happiness=(num)
    @happiness = num
    @happiness = 10 if @happiness > 10
    @happiness = 0 if @happiness < 0
  end
end
```

## RSpec Test 5: `#hygiene`

```ruby
Person
  (passing code omitted for brevity)
  #hygiene
    a person instance is initialized with a hygiene index of 8 (FAILED - 1)

Failures:
  1) Person instantiation #initialize #hygiene a person instance is initialized with a hygiene index of 8
     Failure/Error: people.each { |person| expect(person.hygiene).to eq(8) }
     NoMethodError:
       undefined method `hygiene' for #<Person:0x007f94c95dc3b0>
```

Reading through line 73 - 99 in `spec/person_spec.rb` and comparing it to lines 43 - 71 we should notice the similarities between the tests for `#hygiene` and `#happiness`.

Given that we have just worked on `#happiness` see if you can get all the tests for `#hygiene` to pass.  Once you have given the tests a try (and hopefully gotten your code to pass the test) compare your solution to the solution below.

Again, do not fret if your code does not explicitly match the solution - the two most important things are that:

 - you understand what your code is doing, and
 - that your code works (you can refactor your solution later)

 ```ruby
 class Person

  attr_reader :name, :happiness, :hygiene
  attr_accessor :bank_account

  def initialize(name)
    @name = name
    @bank_account = 25
    @happiness = 8
    @hygiene = 8
  end

  def happiness=(num)
    @happiness = num
    @happiness  = 10 if @happiness > 10
    @happiness = 0 if @happiness < 0
  end

  def hygiene=(num)
    @hygiene = num
    @hygiene = 10 if @hygiene > 10
    @hygiene = 0 if @hygiene < 0
  end
end
 ```


## RSpec Test 6: `#happy?`

```ruby
Person
  non-attribute instance methods
    #happy?
      returns true if happiness is greater than seven, else false (FAILED - 1)

Failures:

  1) Person non-attribute instance methods #happy? returns true if happiness is greater than seven, else false
     Failure/Error: expect(penelope.happy?).to eq(false)
     NoMethodError:
       undefined method `happy?' for #<Person:0x007fd14504c400>
```

NoMethodError means we need to define `#happy?`. Also according to line 112 in `spec/person_spec.rb` `#happy`  needs to `"returns true if happiness is greater than seven, else false"`. We can get this test to pass this way:

```ruby
class person
  (previous code omitted for brevity)
  if self.happiness > 7
    true
  else
    false
  end
end
```

The above code is very explicit (and verbose). Can you think of a one-line code that would also achieve the same result? Refactor your code if you.

## RSpec Test 7: `#clean?`

```ruby
Person
  (passing code omitted for brevity)
  non-attribute instance methods
    #clean?
      returns true if hygiene is greater than seven, else false (FAILED - 1)

Failures:

  1) Person non-attribute instance methods #clean? returns true if hygiene is greater than seven, else false
     Failure/Error: expect(penelope.clean?).to eq(false)
     NoMethodError:
       undefined method `clean?' for #<Person:0x007fa0848f15c0>
```

Notice the similarity between the tests for `#clean?` and `#happy?`(compare lines 111-118 and lines 120 - 127)? Therefore our method definition for `#clean` looks like this:

```ruby
class Person

(previous code omitted for brevity)

  def clean?
    self.hygiene > 7
  end

end
```

> Point to consider:
> - do we need the `self` in front of hygiene? What happens if we remove it? See if you can explain in plain english why our code still passes if we remove `self`


## RSpec Test 8: `#get_paid`

```ruby
Person
  (passing code omitted for brevity)
   non-attribute instance methods
     #get_paid
      accepts an argument of salary (FAILED - 1)

Failures:
  1) Person non-attribute instance methods #get_paid accepts an argument of salary
     Failure/Error: expect { penelope.get_paid(100) }.to_not raise_error
       expected no Exception, got #<NoMethodError: undefined method `get_paid' for #<Person:0x007fd89211a7c0>>:

```

Read lines 129 - 143 in `spec/person_spec.rb` to get a better understanding of the requirements for the `#get_paid` method and then write out the code that gets the test to pass.

```ruby
class Person
(previous code omitted for brevity)

  def get_paid(salary)
    self.bank_account += salary
    "all about the benjamins"
  end
end
```

## RSpec Test 9: `#take_bath`

```ruby
Person
  non-attribute instance methods
    #take_bath
      makes the person cleaner by 4 points (FAILED - 1)

Failures:
  1) Person non-attribute instance methods #take_bath makes the person cleaner by 4 points
     Failure/Error: penelope.take_bath
     NoMethodError:
       undefined method `take_bath' for #<Person:0x007ff4ba1410c0>

```
Let's switch things up a bit. In addition to running rspec, we also going to be reading through the specs for the particular method we are trying to get to work.

The lines we are interested in for `#take_bath` are lines 145 - 168:

```ruby
    describe "#take_bath" do
      it "makes the person cleaner by 4 points" do
        penelope.hygiene = 4
        penelope.take_bath
        expect(penelope.hygiene).to eq(8)
      end

      it "returns a song" do
        penelope.hygiene = 5
        expect(penelope.take_bath).to eq("♪ Rub-a-dub just relaxing in the tub ♫")
      end

      it "can't make a person cleaner by 10 points (hint: use the custom #hygiene= method)" do
        penelope.hygiene = 9
        penelope.take_bath
        expect(penelope.hygiene).to eq(10)
      end

      it "calls on the #hygiene= method to increment hygiene" do
        penelope.hygiene = 9
        expect(penelope).to receive(:hygiene=).with(13).and_return(10)
        penelope.take_bath
      end
    end
```
First thing we do is get rid of the NoMethodError `take_bath` by defining the method:

```ruby
  def take_bath
  end
```
Next is to make the method increase a person's hygiene index by 4 points:

```ruby
  def take_bath
    self.hygiene += 4
  end
```

Using `self` inside this method helps us deal with the 3rd and 4th requirements in the spec for `#take_bath`.

Then we make sure that `#take_bath` returns a song:

```ruby
  def take_bath
    self.hygiene += 4
    "♪ Rub-a-dub just relaxing in the tub ♫"
  end
```

## RSpec Test 10: `#work_out`
run rspec, watch it fail, and read the error message:

```ruby
Person
  non-attribute instance methods
    #work_out
      makes the person dirtier by 3 points (FAILED - 1)

Failures:
  1) Person non-attribute instance methods #work_out makes the person dirtier by 3 points
     Failure/Error: penelope.work_out
     NoMethodError:
       undefined method `work_out' for #<Person:0x007fec9a90e988>

```


Read lines 170 - 216 in `spec/person_spec.rb` and write the code that meets the requirements:

```ruby
describe "#work_out" do

      it "makes the person dirtier by 3 points" do
        penelope.hygiene = 10
        penelope.work_out
        expect(penelope.hygiene).to eq(7)
      end

      it "never makes the person have negative dirty points
        (hint: use the #hygiene= method)" do
        penelope.hygiene = 1
        penelope.work_out
        expect(penelope.hygiene).to be >= 0
        expect(penelope.hygiene).to eq(0)
      end

      it "calls on the #hygiene= method to decrease hygiene" do
        penelope.hygiene = 1
        expect(penelope).to receive(:hygiene=).with(-2).and_return(0)
        penelope.work_out
      end

      it "makes the person happier by 2 points" do
        penelope.happiness = 7
        penelope.work_out
        expect(penelope.happiness).to eq(9)
      end

      it "never makes the person have more than 10 happiness points
        (hint: use the #happiness= method)" do
        penelope.happiness = 9
        penelope.work_out
        expect(penelope.happiness).to be <= 10
        expect(penelope.happiness).to eq(10)
      end

      it "calls on the #happiness= method to increment happiness" do
        penelope.happiness = 9
        expect(penelope).to receive(:happiness=).with(11).and_return(10)
        penelope.work_out
      end

      it "returns Queen lyrics" do
        penelope.hygiene = 5
        expect(penelope.work_out).to eq("♪ another one bites the dust ♫")
      end
    end
```

First, define the method `#work_out`:

```ruby
  def work_out
  end
```

Then make the `#work_out`decrease a person's hygiene index by 3 points:

```ruby
  def work_out
    self.hygiene -=3
  end
```

`#work_out` should also increase a person's happiness index by 2 points:

```ruby
  def work_out
    self.hygiene -=3
    self.happiness += 2
  end
```

 Finally `#work_out` return the lyrics "♪ another one bites the dust ♫":

```ruby
  def work_out
    self.hygiene -=3
    self.happiness += 2
    "♪ another one bites the dust ♫"
  end
```

## RSpec Test 11: `#call_friend`

run rspec, watch it fail, and read error message:

```ruby
Person
  non-attribute instance methods
    #call_friend
      accepts one argument, an instance of the Person class (FAILED - 1)

Failures:
  1) Person non-attribute instance methods #call_friend accepts one argument, an instance of the Person class
     Failure/Error: expect { penelope.call_friend(felix) }.to_not raise_error
       expected no Exception, got #<NoMethodError: undefined method `call_friend' for #<Person:0x007ff992121928>>:

```

Read the lines relevant to getting `#call_friend` test to pass:

```ruby
describe "#call_friend" do
      it "accepts one argument, an instance of the Person class" do
        expect { penelope.call_friend(felix) }.to_not raise_error
      end

      it "makes the person calling happier by three points" do
        penelope.happiness = 6
        penelope.call_friend(felix)
        expect(penelope.happiness).to eq(9)
      end

      it "makes the friend happier by three points" do
        felix.happiness = 5
        penelope.call_friend(felix)
        expect(felix.happiness).to eq(8)
      end

      it "never makes the happiness of either party exceed 10
        (hint: use the custom #happiness= method)" do
        [felix, penelope].each {|person| person.happiness = 9 }
        penelope.call_friend(felix)
        [felix, penelope].each do |person|
          expect(person.happiness <= 10).to eq(true)
          expect(person.happiness).to eq(10)
        end
      end

      it "calls on the #happiness= method to increment happiness" do
        [felix, penelope].each {|person| person.happiness = 9 }
        people.each do |person|
          expect(person).to receive(:happiness=).with(12).and_return(10)
        end
        penelope.call_friend(felix)
      end

      it "returns a string that reflects the caller's side of the conversation" do
        {felix => penelope, penelope => felix}.each do |caller, callee|
          convo = "Hi #{callee.name}! It's #{caller.name}. How are you?"
          expect(caller.call_friend(callee)).to eq(convo)
        end
      end
    end
```

First we define the method `#call_friend`, which takes an argument:

```ruby
  def call_friend(friend)
  end
```

Increase the happiness of both the person who makes the call and the person who receives the call by 3 points.  There are couple of ways we could do this but here we create an array to hold both the caller and the call-receiver:

```ruby
  def call_friend(friend)
    [friend, self].each {|o| o.happiness += 3 }
  end
```

Then we make sure that `#call_friend` method returns a string that matches **"Hi #{callee.name}! It's #{caller.name}. How are you?"**:

```ruby
  def call_friend(friend)
    [friend, self].each {|o| o.happiness += 3 }
    "Hi #{friend.name}! It's #{self.name}. How are you?"
  end
```

## RSpec Test 12: `#start_conversation`

```ruby
describe "#start_conversation" do
      it "accepts two arguments, a person to strike a convo with and a topic" do
        expect { penelope.start_conversation(felix, "politics") }.to_not raise_error
      end

      context "topic: politics" do

        it "returns 'blah blah partisan blah lobbyist' if the topic is politics" do
          convo = "blah blah partisan blah lobbyist"
          expect(penelope.start_conversation(felix, "politics")).to eq(convo)
        end

        it "if topic is politics, it makes both people in the convo two points less happy" do
          people.each  { |person| person.happiness = 7 }
          penelope.start_conversation(felix, "politics")
          people.each  { |person| expect(person.happiness).to eq(5) }
        end

        it "never makes either party less than 0 points happy (never negative)
          (hint: use your #happiness= method)" do
          people.each  { |person| person.happiness = 1 }
          penelope.start_conversation(felix, "politics")
          people.each  do |person|
            expect(person.happiness).to be >= 0
            expect(person.happiness).to eq(0)
          end
        end

        it "calls on the #happiness= method" do
          [felix, penelope].each {|person| person.happiness = 1 }
          people.each do |person|
            expect(person).to receive(:happiness=).with(-1).and_return(0)
          end
          penelope.start_conversation(felix, "politics")
        end
      end
```

`#start_conversation` accepts two arguments:

```ruby
  def start_conversation(person_to_start_conversation_with, topic_of_conversation)
  end
```

When the topic of the conversation in `#start_conversation`is politics, `start_conversation` it makes the two people having the conversation sadder by 2 points. There are a couple of ways to do this but we are going to go for the most basic solution first. Once we get our code to work, we can return to refactoring it.

```ruby
  def start_conversation(person_to_start_conversation_with, topic_of_conversation)
    if topic_of_conversation == "politics"
      person_to_start_conversation_with.happiness -= 2
      self.happiness -= 2
    end
  end
```

`stat_conversation` also returns the string "blah blah partisan blah lobbyist" when the topic is politics. There are a couple of ways to do this but we are going to go for the most basic solution first. Once we get our code to work, we can return to refactoring it.

```ruby
  def start_conversation(person_to_start_conversation_with, topic_of_conversation)
    if topic_of_conversation == "politics"
      person_to_start_conversation_with.happiness -= 2
      self.happiness -= 2
      "blah blah partisan blah lobbyist"
    end
  end
```

Next we need to write the code that makes the test for `#start_conversation` pass when the topic of conversation is weather.  Again, note that there is more elegant solution for this but just like before we are going to go for the most basic solution first. Once we get our code to work, we can return to refactoring it.

```ruby
  def start_conversation(person_to_start_conversation_with, topic_of_conversation)
    if topic_of_conversation == "politics"
      person_to_start_conversation_with.happiness -= 2
      self.happiness -= 2
       "blah blah partisan blah lobbyist"
    else topic_of_conversation == "weather"
      person_to_start_conversation_with.happiness += 1
      self.happiness += 1
      'blah blah sun blah rain'
    end
  end
```

When the topic of conversation is neither politics or weather, each person's happiness level stays the same and the `#start_conversation` returns "blah blah blah blah blah":

```ruby
  def start_conversation(person_to_start_conversation_with, topic_of_conversation)
    if topic_of_conversation == "politics"
      person_to_start_conversation_with.happiness -= 2
      self.happiness -= 2
       "blah blah partisan blah lobbyist"
    elsif topic_of_conversation == "weather"
      person_to_start_conversation_with.happiness += 1
      self.happiness += 1
      'blah blah sun blah rain'
    else
      "blah blah blah blah blah"
    end
  end
```

That's it! All of our tests pass.

A key part of getting better of programming, is learning to spot the places that need refactoring.  Go through your solution and try to find pieces of code that could be written better/tighter/more succinctly.

