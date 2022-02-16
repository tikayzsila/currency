if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require 'rexml/document'
require 'uri'
require 'net/http'
require 'uri-handler'

uri = URI.parse("http://www.cbr.ru/scripts/XML_daily.asp")
response = Net::HTTP.get_response(uri)
doc = REXML::Document.new(response.body)

doc.each_element('//Valute[@ID="R01235" or @ID="R01239"]') do |currency_tag|

  name = currency_tag.get_text('Name')
  value = currency_tag.get_text('Value')
  puts "#{name}: #{value} руб."

end