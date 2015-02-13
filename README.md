---
tags: oo, object relations, todo, oop
languages: ruby
resources: 1
---

# OO Person

## Introduction

To practice object oriented programming (OOP), you're going to create a Person class. Instances of your person class should be able to get paid, take a bath, call a friend, and start a conversation. They should also be able to tell you if they are happy and/or clean.

## Instructions

##### Basics

Create a person class. This person should be initialized with a name that can't change. The person should be able to remember their name. Each instance of the person class should start with $25 in their bank accounts. They also should start with eight happiness points and eight hygiene points.

The happiness and hygiene points should be able to change, however they should max out at 10 and min out (pretend that's a thing) at 0. The amount in the bank account should also be able to change, though it has no max or min.

##### More Methods

The `clean?` and `happy?` methods are pretty similiar: they should return `true` if the happiness or hygiene points exceed seven. Otherwise they should return false.

The `get_paid` method should accept a salary amount and add this to the person's bank account. Then the method should return the string "all about the benjamins".

The `take_bath` method should increment the person's hygiene points by four and return the string "♪ Rub-a-dub just relaxing in the tub ♫".

The `work_out` method should increment the person's happiness by two points, decrease their hygiene by three points, and return the Queen lyrics, "♪ another one bites the dust ♫".

The `call_friend` method should accept another instance of the Person class, or "friend". The method should increment the caller and the callee's happiness points by three. If Stella calls her friend Felix, the method should return "Hi Felix. It's Stella. How are you?"

Finally, the `start_conversation` method should accept two arguments, the person to start a conversation with and the topic of conversation. 
* If the topic is politics, both people get sadder and the method returns "blah blah partisan blah lobbyist".
* If the topic is weather, both people get a little happier and the method returns "blah blah sun blah rain".
* If the topic is not politics or weather, their happiness points don't change and the method returns "blah blah blah blah blah".

## Resources

* [Practical Object Oriented Design in Ruby: An Agile Primer](http://books.flatironschool.com/books/102)
