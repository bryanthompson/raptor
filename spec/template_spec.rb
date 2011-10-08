require "rack"
require_relative "spec_helper"
require_relative "../lib/raptor/responders"

describe Raptor::Template do
  include Raptor

  it "raises an error when templates access undefined methods" do
    presenter = Object.new
    File.stub(:new) { StringIO.new("<% undefined_method %>") }

    expect do
      Template.new(presenter, "posts/show.html.erb").render
    end.to raise_error(NameError,
                       /undefined local variable or method `undefined_method'/)
  end

  it "renders the template" do
    presenter = stub("presenter")
    template = Template.new(presenter, "with_no_behavior/new.html.erb")
    template.render.strip.should == "<form>New</form>"
  end
end

