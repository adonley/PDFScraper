require 'rubygems'
require 'mechanize'
require 'pdf-reader'
require 'open-uri'

#------------- Globals --------------------#

words = ["chapter"]
sites = [""]
pdfs = [""]

#------------- Find PDFs ------------------#

agent = Mechanize.new

sites.each do |site|
	page = agent.get(site)

	page.links.each do |link|
		# ------------------- Need to put the FIND PDF LOGIC HERE AND DEV PDF VAR
		puts link.text
	end
end

#-------------- Begin the PDF Parse -------#

reader = PDF::Reader.new("sample.pdf")
puts reader.page_count

frequency = Hash.new(0) #default value set here as 0
words.each do |word|
	frequency[word] = 0 #Don't know how to initialize this otherwise
end

reader.pages.each do |page|
	s = StringScanner.new(page.text.downcase)
	#puts page.text.downcase.class
	words.each do |word|
		while s.scan_until(/#{word}/) != nil do
			frequency[word] = frequency[word] + 1
		end
	end
end

words.each do |word|
	p word, frequency[word]
end