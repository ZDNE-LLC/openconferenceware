require 'spec_helper'

describe "open_conference_ware/tracks/index.html.erb" do
  include OpenConferenceWare::TracksHelper

  before(:each) do
    @event = stub_current_event!

    @tracks = [
      stub_model(Track,
        id: 2,
        title: "value for title",
        event: @event
      ),
      stub_model(Track,
        id: 3,
        title: "value for title",
        event: @event
      )
    ]
    assign(:tracks, @tracks)
  end

  describe "anonymous" do
    before do
      view.stub(:admin?).and_return(false)
    end

    it "should render list" do
      render
      rendered.should have_selector("h3", text: "value for title".to_s, count: 2)
    end
  end

  describe "admin" do
    fixtures :all

    before(:each) do
      view.stub(:admin?).and_return(true)
      render
    end

    it "should render list" do
      rendered.should have_selector("h3", text: "value for title".to_s, count: 2)
    end

    it "should render new link" do
      rendered.should have_selector("a[href='#{new_track_path}']")
    end

    it "should render edit links" do
      rendered.should have_selector("a[href='#{edit_track_path(@tracks.first)}']")
    end
  end
end
