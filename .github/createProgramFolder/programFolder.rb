#!/usr/bin/ruby
require 'fileutils'

# $programID = ''

# def setProgramID(programID)
#   $programID = programID.gsub(/[^0-9A-Za-z]/, '_')
#   $programID
# end

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

  # `export PROGRAM=#{$programID} > ~/.my-variables.sh"`
  # `git checkout -b #{$programID}`
  # setProgramID(programID)
  checkTemplateFolder(templateFolder)
  createProgramFolder(programFolder, $programID)
  checkProgramFolder(programFolder)
  addTemplatesToFolder(templateFolder, $programID, programFolder)
  # commitAndPush($programID, programFolder)
  # puts $programID.to_s
end

def commitAndPush(_programID, programFolder)
  `git add #{programFolder}/#{$programID}`
  `git commit -m "Automatically adding template files"`
  `git push -u origin #{$programID}`
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
