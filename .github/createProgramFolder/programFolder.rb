#!/usr/bin/ruby
$folderPath = ENV['folderPath']

def checkTemplateFolder(folderPath)
  File.directory?(folderPath)
end

def createProgramFolder(programID)
  unless checkTemplateFolder($folderPath)
  Dir.mkdir(programID.toString)
  rescue SystemCallError => e
    print_exception(e, true)
  rescue => e
    print_exception(e, false)
  end
end

def createGitBranch(folderPath, programID)
  `git checkout -b #{programID}`
  createProgramFolder(folderPath)
  addTemplatesToFolder()
  commitAndPush(programID)
end

def commitAndPush(programID)
  `git add programs/#{programID}`
  `git commit -m "Automatically adding template files"`
  `git push -u origin #{programID}`
end

def addTemplatesToFolder()
  templateFolder = Dir("guides-and-templates/template-*")
  FileUtils.cp(templateFolder, programFolder)
end

createGitBranch(ARGV[0], ARGV[1])
