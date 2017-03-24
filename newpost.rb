#!/usr/bin/env ruby

require 'date'
require 'optparse'

ARGV << '-h' if ARGV.empty?

options = {}
OptionParser.new do |opt|
    options[:edit] = false
    options[:cats] = ""
    options[:tags] = ""
    options[:summary] = ""

    opt.banner = 'usage: newpost.rb TITLE [OPTIONS]'
    opt.separator ''
    opt.separator 'Options'
    opt.on('-f', '--filename [FILENAME]', String, 'Filename, different from auto-parsed from title') do |fname|
        options[:filename] = fname
    end

    opt.on('-c', '--categories [CATEGORIES]', String, 'Space-delimited string of categories') do |cats|
        options[:cats] = cats
    end

    opt.on('-t', '--tags [TAGS]', String, 'Space-delimited string of tags') do |tags|
        options[:tags] = tags
    end

    opt.on('-s', '--summary [SUMMARY]', String, 'Summary text for post.') do |summary|
        options[:summary] = summary
    end

    opt.on('-e', '--edit', 'Edit the page') do |edit|
        options[:edit] = true
    end

    opt.separator ''

    opt.on('-h', '--help', 'Display help for options' ) do
        puts opt
        exit
    end
end.parse!

title = ARGV[0]

if not options[:filename]
    filename = title.downcase.gsub(/[^a-z0-9\s]/, '').gsub(/\s+/, '-')
else
    filename = options[:filename]
end

categories = options[:cats]
tags = options[:tags]
summary = options[:summary]

# Resolve any relative links
BASE_DIR = Dir.pwd
POSTS_DIR = "#{BASE_DIR}/_posts"

# Ensure the _posts directory exists (we are in the correct directory)
if not Dir.exists?(POSTS_DIR)
    puts "#{POSTS_DIR} directory does not exist here."
    exit
end

today=Date.today().strftime('%F')
now=DateTime.now().strftime('%F %R')

filepath = "#{POSTS_DIR}/#{today}-#{filename}.md"

puts "Creating new post " + filepath + "..."

if File.exists?(filepath)
    puts "File #{filepath} already exists"
    exit
end

content = <<END
---
layout: post
title: \"#{title}\"
categories: #{categories}
tags: #{tags}
date: #{now}
summary: #{summary}
---

END

File.open(filepath, 'w') do |file|
    file.puts content
end

puts "Post created"

if options[:edit]
    command_text = 'open -a "Sublime Text" ' + filepath
    exec(command_text)
end
