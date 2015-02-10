class Person
  attr_reader :name, :hygiene, :happiness
  attr_accessor :bank_account

  def initialize(name)
    @name = name
    @happiness = 8
    @hygiene = 8
    @bank_account = 25
  end

  def happiness=(num)
    @happiness = num
    @happiness = 10 if @happiness > 10
  end

  def hygiene=(num)
    @hygiene = num
    @hygiene = 10 if @hygiene > 10
  end

  def happy?
    happiness > 7
  end

  def clean?
    hygiene > 7
  end

  def take_bath
    self.hygiene += 4
    "♪ Rub-a-dub just relaxing in the tub ♫"
  end

  def start_conversation(person, topic)
    objects = [self, person]
    if topic == "politics"
      objects.each { |o| o.happiness -= 2}
      first, second = ["partisan", "lobbyist"]
    elsif topic == "weather"
      objects.each { |o| o.happiness += 1}
      first, second = ["sun", "rain"]
    end
    first ||= "blah"
    second ||= "blah"
    base_string = "blah blah #{first} blah #{second}"
  end

  def get_paid(salary)
    self.bank_account += salary
    self.happiness += 1
    "all about the benjamins"
  end

  def call_friend(friend)
    [friend, self].each {|o| o.happiness += 3 }
    "Hi #{friend.name}! It's #{self.name}. How are you?"
  end

end