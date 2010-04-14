require 'erb'
require 'yamlconfig.rb'

class Newsletter
  include YAMLConfig

  attr_accessor :month
  attr_accessor :year

  def write()
    template = <<END_EMAIL
SUBJECT: <%= @subject %>
***** Indy ALT.NET - <%= "#{@month} #{@year}" %> Newsletter *****

** <%= @month %> Meeting Info **
- Location: <%= @month %>
- Date: Thursday, <%= "#{@month}, #{@day}  #{@year}" %> 
- Time: Formal discussion begins at 6pm, food begins at 5:30pm, networking begins at 5:15pm.
- Topic: <%= @topic %>
- Speakers: <%= @speaker %>
- More information:
<%= @meeting_link %>

<%= @synopsis %>

** Food **
Pizza and networking will begin around 5:15 with the technology discussion beginning at 6:00.

** Location **
<%= @location_long %>

** Interesting Blog Posts and Other Links **
<% @links.each do |link| %>

<%= link["title"] %>

<%= link["link"] %>

<% end %>
END_EMAIL

    erb = ERB.new(template, 0, "%<>")
    puts erb.result(binding) 
  end
end

n = Newsletter.new
n.configure('april.yml')
n.write()
