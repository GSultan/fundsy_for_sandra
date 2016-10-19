FactoryGirl.define do
  # we can use factories to create objects to generate valid attributes by:
  # FactoryGirl.create :campaign
  # FactoryGirl.attributes_for :campaign
  # One key thing to remember is that factories must always be able to create valie records which means they should always generate valid set of attributes
  factory :campaign do
    # with sequence it will start at 1 and keep counting within a running
    # instance of ruby ,( in test or dev env.). This way within a run we can
    # use thhe sequence number to ensure that we have a unique title
    sequence(:title) {|n| "Some valid title #{n}" }
    body { Faker::Hipster.paragraph}
    goal { 10 + rand(1000)}
    end_date {Time.now + 10.days} #non static, put it in a block
  end
end
