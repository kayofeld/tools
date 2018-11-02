#! /usr/bin/env ruby
require 'json'

json_data = JSON.parse(File.read("replacements.json"))

files = Dir.glob("#{json_data["path"]}**/*").delete_if {| i | !i.end_with? json_data["file_endings"]}
replacements = json_data["strings"]
  
files.each do | file |
  file = file.gsub! " ", "\\ "
  replacements.each do | key, val |
    system("sed -i 's:#{key}:#{val}:g' #{file}")
  end  
end


# replacements.json format:
#{
#  "file_endings": ".txt",
# "path": "./",
# "strings": {
#              "ferge": "gfzfezfe",
#             "paedfd": "eefze"
#            }
#}
