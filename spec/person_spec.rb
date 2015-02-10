describe "Person" do

  it "is initialized with a name" do
    expect { Person.new("Blake") }.to_not raise_error
  end

  describe "#initialize" do

    let(:stella) { Person.new("Stella") }

    describe "#name" do

      it "knows its name" do
        expect(stella.name).to eq("Stella")
      end

      it "can't change its name" do
        expect { stella.name = "Qwen" }.to raise_error 
      end

    end

    describe "#bank_account" do

      it "is initialized with a bank_account 'amount' of $25" do
        expect(stella.happiness).to eq(8)
      end

      it "can change it bank_account" do
        original_amount = stella.bank_account
        expect(stella.bank_account += 1 ).to eq(original_amount + 1)
      end

    end

    describe "#happiness" do

      it "is initialized with a happiness 'score' of 8" do
        expect(stella.happiness).to eq(8)
      end

      it "can change it happiness" do
        original_happiness = stella.happiness
        stella.happiness += 1
        expect(stella.happiness).to eq(original_happiness + 1)
      end

      it "doesn't exceed 10" do
        original_happiness = stella.happiness
        stella.happiness += 100 
        expect(stella.happiness).to eq(10)
      end
      
    end

    describe "#hygiene" do

      it "is initialized with a hygiene 'score' of 8" do
        expect(stella.hygiene).to eq(8)
      end

      it "can change it hygiene" do
        original_hygiene = stella.hygiene
        stella.hygiene += 1 
        expect(stella.hygiene).to eq(original_hygiene + 1)
      end

      it "doesn't exceed 10" do
        original_hygiene = stella.hygiene
        stella.hygiene += 100 
        expect(stella.hygiene).to eq(10)
      end
      
    end

  end

  context "custom methods" do
    let(:penelope) { Person.new("Penelope") }
    let(:felix) { Person.new("Felix") }

    describe "#happy?" do

      it "returns true if happiness is greater than seven, else false" do
        penelope.happiness = 0
        expect(penelope.happy?).to eq(false)
        penelope.happiness = 8
        expect(penelope.happy?).to eq(true)
      end
    end

    describe "#clean?" do

      it "returns true if hygiene is greater than seven, else false" do
        penelope.hygiene = 0
        expect(penelope.clean?).to eq(false)
        penelope.hygiene = 8
        expect(penelope.clean?).to eq(true)
      end
    end

    describe "#take_bath" do
      
      it "makes the person cleaner by 4 points" do
        original = 5
        penelope.hygiene = original
        penelope.take_bath
        expect(penelope.hygiene).to eq(original + 4)
      end

      it "returns a song" do
        penelope.hygiene = 5
        expect(penelope.take_bath).to eq("♪ Rub-a-dub just relaxing in the tub ♫")
      end
    end

    describe "#get_paid" do

      it "accepts an argument of salary" do
        expect { penelope.get_paid(100) }.to_not raise_error
      end

      it "increments bank_account by the salary" do
        original_amount = penelope.bank_account
        penelope.get_paid(100)
        expect(penelope.bank_account).to eq(original_amount += 100)
      end

      it "returns 'all about the benjamins'" do
        expect(penelope.get_paid(100)).to eq('all about the benjamins')
      end

    end

    describe "#call_friend" do

      it "accepts one argument, an instance of the Person class" do
        expect { penelope.call_friend(felix) }.to_not raise_error
      end

      it "makes the person calling happier by three points" do
        penelope.happiness = 6
        penelope.call_friend(felix)
        expect(penelope.happiness).to eq(9)
      end

      it "makes the person who got called happier by three points" do
        felix.happiness = 5
        penelope.call_friend(felix)
        expect(felix.happiness).to eq(8)
      end
    end

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
          people = [penelope, felix]
          people.each  { |p| p.happiness = 7 }
          penelope.start_conversation(felix, "politics")
          people.each  { |p| expect(p.happiness).to eq(5) }
        end

      end

      context "topic: weather" do

        it "returns 'blah blah sun blah rain' if the topic is weather" do
          convo = "blah blah sun blah rain"
          expect(penelope.start_conversation(felix, "weather")).to eq(convo)
        end
  
        it "if topic is weather, it makes both people in the convo one point more happy" do
          people = [penelope, felix]
          people.each  { |p| p.happiness = 7 }
          penelope.start_conversation(felix, "weather")
          people.each  { |p| expect(p.happiness).to eq(8) }
        end

      end

      context "topic: other" do

        it "returns 'blah blah blah blah blah' if the topic is not politics or weather" do
          convo = "blah blah blah blah blah"
          expect(penelope.start_conversation(felix, "programming")).to eq(convo)
        end

        it "if topic is not politics or weather, it doesn't affect happiness" do
          people = [penelope, felix]
          people.each  { |p| p.happiness = 7 }
          penelope.start_conversation(felix, "other")
          people.each  { |p| expect(p.happiness).to eq(7) }
        end

      end

    end

  end
  # def start_conversation(person, topic)
  #   objects = [self, person]
  #   if topic == "politics"
  #     objects.each { |o| o.happiness -= 2}
  #     first, second = ["partisan", "lobbyist"]
  #   elsif topic == "weather"
  #     objects.each { |o| o.happiness += 1}
  #     first, second = ["sun", "rain"]
  #   end
  #   [first, second].each {|v| v ||= "blah" }
  #   base_string = "blah blah #{first} blah #{second}"
  # end

end