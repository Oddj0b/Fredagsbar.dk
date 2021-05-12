#!/usr/bin/ruby
require 'fileutils'

def checkTemplateFolder(folderPath)
raise 'No Guides and Template folder' unless File.directory?(folderPath)
end

def checkProgramFolder(programFolder)
raise 'No program folder' unless File.directory?(programFolder)
end

def createProgramFolder(programFolder, programID)
if Dir.exist?("#{programFolder}/#{programID}")
  puts 'Program directory already exists'
else
  FileUtils.mkdir_p("#{programFolder}/#{programID}")
end
end

def createGitBranch(templateFolder, programID, programFolder)
raise "Expected three arguments only got #{ARGV.count}" unless ARGV.count == 3
checkTemplateFolder(templateFolder)
createProgramFolder(programFolder, programID)
checkProgramFolder(programFolder)
addTemplatesToFolder(templateFolder, programID, programFolder)
end

def addTemplatesToFolder(templateFolder, programID, programFolder)
  Dir["#{templateFolder}/template-*"].each do |file|
    if File.exist?("#{programFolder}/#{programID}/#{File.basename(file)}")
      puts 'File already in folder'
    else
      FileUtils.cp(file, "#{programFolder}/#{programID}")
      puts "copied file: #{programFolder}/#{programID}: #{$?}"
    end
  end
end
createGitBranch(ARGV[0], ARGV[1], ARGV[2])
