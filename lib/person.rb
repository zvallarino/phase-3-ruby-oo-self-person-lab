class Person

  attr_reader :name
  
  

  attr_accessor  :bank_account, :hygiene

     # setter method
     def happiness=(happiness)
      if (happiness <= 10 && happiness >=0)
      @happiness = happiness
    end
  
    # getter method
    def happiness
      @happiness
    end

  def initialize( name, bankaccount = 25,happiness = 8,hygiene = 8) 
    @name = name
    @bank_account = bankaccount
    @happiness = happiness
    @hygiene = hygiene

  end

  def getname
    self.name
  end 

 
  


end 

zack = Person.new('Zach')
p zack

