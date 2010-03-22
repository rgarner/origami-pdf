#!/usr/bin/env ruby 

$: << "../../parser"
require 'parser.rb'
include Origami

OUTPUTFILE = "#{File.basename(__FILE__, ".rb")}.pdf"
USERPASSWD = ""
OWNERPASSWD = ""

puts "Now generating a new PDF file from scratch!"

# Creates an encrypted document with AES128 (256 not implemented yet) and a null password.
pdf = PDF.new.encrypt(USERPASSWD, OWNERPASSWD, :Algorithm => :AES )

contents = ContentStream.new
contents.write "Crypto sample",
  :x => 350, :y => 750, :rendering => Text::Rendering::STROKE, :size => 30

pdf.append_page Page.new.setContents(contents)

pdf.saveas(OUTPUTFILE)

puts "PDF file saved as #{OUTPUTFILE}."