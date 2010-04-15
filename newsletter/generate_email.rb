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
- Location: <%= @location_short %>
- Date: Thursday, <%= "#{@month} #{@day},  #{@year}" %> 
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

_______________________________________________

You have been subscribed to this mailing because you have an account at http://IndyALT.NET or because you have provided your contact information at a previous meeting for this purpose. Please use the link at the bottom of this email to manage your subscription. You are free to unsubscribe at any time.

END_EMAIL

    erb = ERB.new(template, 0, "%<>")
    puts erb.result(binding) 
  end
end

n = Newsletter.new
n.configure('april.yml')
n.write()
