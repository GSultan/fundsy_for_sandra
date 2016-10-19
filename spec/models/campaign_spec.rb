require 'rails_helper'

RSpec.describe Campaign, type: :model do
  # this is default message to remind you to add a test
  # pending "add some examples to (or delete) #{__FILE__}"
  #
  # this defines a new section for us. In this case we want to write tests for
  # validations. You cn also use 'context' which is an alias to 'describe'
  # but sometimes it reads better to use 'context' instead of 'describe'

    describe 'validations' do
        # to define a test example we use the RSpec method 'it' or 'specify'
        # it's preferable to put a message for every example , especially when
        #it's not self explanatory


        it 'requires a title' do
        #GIVEN
        # a campaign object
        c = Campaign.new
        #WHEN
        #we invoke validations
        c.valid?
        #THEN
        ## The resulting object is invalid
        ##################### expect(c).to be_invalid
        # We use expect to test the outcome of our test example .
        # be_invalid is a matcher from rspec-rails that tests the invalidity of
        # the object given (in this case 'c') by checking errors attached to it.
        # be_invalid is a matcher method
        # be_invalid checks that there are errors attached to an object
        expect(c.errors).to have_key(:title)
        # this is more specific notation to indicate that you're checking the title specifically
        end

        it 'requires a unique title' do
          #GIVEN
          # remember that we assume that we are starting with a clean DB every time we run a test example .
          # So if we want something to be in the DB as part of the test, we must create it and not assume it exists
          # Every test gets run within a DB transaction that has a ROLLBACK at the end of it . This means that every test cleans up after itself and leaves the DB the same state as it was before running the test.
          ########## USING FACTORY GIRL NOW , THIS STATEMENT IS INVALID >>>> ###>>>>>Campaign.create({title: 'Some valid title', goal: 10})
          FactoryGirl.create :campaign, title: 'Some valid title'
          c = Campaign.new title: 'Some valid title'
          #WHEN
          c.valid?
          #THEN
          expect(c.errors).to have_key(:title)
        end

        it 'requires a goal of $10 or more' do

        #GIVEN
        #Campaign.create 'hits' the database to create and save, then you're rolling that back after the test
        c = Campaign.new goal: $9
        #WHEN
        c.valid? #here we're invoking validations on this
        #THEN
        expect(c.errors).to have_key(:goal)
        end


        #DSL is domain specific language , it's Ruby , for instance 'it' is a pethod, that takes a block with do/end

    end

    describe '.titleized_title' do #add a dot beforehand if it's a method, because that's how you call a method
      it 'returns a titleized version of the title' do
        #GIVEN
          c = Campaign.new title: 'hello world'
        #WHEN
          outcome = c.titleize_title
        #THEN ### ALWAYS start with expect ()
          # expect(outcome).to eq('Hello World')
          outcome.should eq('Hello')
      end

    end
end
