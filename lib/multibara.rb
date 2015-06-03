require 'capybara'

class Multibara
  def initialize(url)
    @url = url
    capybara.visit(url)
  end

  def title
    capybara.title
  end

  def each_subpage(&block)
    links = capybara.all('a').map{|element| element[:href] }
    links.each do |l|
      capybara.visit l
      block.call(capybara.title)
    end
  end

  private

  attr_reader :url

  def capybara
    @capybara ||= Capybara::Session.new(:selenium)
  end
end
