require 'helper'

class GrouponTest < Test::Unit::TestCase

  context "Groupon API" do

    should "return a list of divisions - cities where Groupon is live" do
      stub_get("/divisions.json?client_id=", "divisions.json")
      divisions = Groupon.divisions
      divisions.size.should == 61
      divisions.last.name.should == 'Wichita'
      divisions.last.location.latitude.should == 37.6922
    end

    should "return a list of deals" do
      stub_get("/deals.json?lat=32.781100000000002&lng=-96.9791&client_id=", "deals.json")
      deals = Groupon.deals(:lat => "32.781100000000002", :lng => "-96.9791")
      deals.size.should == 1
      deals.first.discount_percent.should == 50
    end

    should "return a list of deals for a specified division" do
      stub_get("/dallas/deals.json?client_id=", "deals.json")
      deals = Groupon.deals(:division => :dallas)
      deals.size.should == 1
      deals.first.discount_percent.should == 50
    end

    should "return a single deal" do
      stub_get("/deals/1.json?client_id=", "deal.json")
      deal = Groupon.deal(1)
      deal.discount_percent.should == 50
    end
  end

end
