# https://github.com/metaskills/mocha-phantomjs
# https://github.com/kmiyashiro/grunt-mocha
args = phantom.args
if args.length < 1 or args.length > 2
  console.log "Usage: #{phantom.scriptName} <URL> <timeout>"
  phantom.exit 1

#phantom.viewportSize =
#  width: 800
#  height: 600

page = require('webpage').create()

page.onConsoleMessage = (message) ->
  console.log(message)

page.open args[0], (status) ->
  testCompletion = ->
    page.evaluate ->
      return true if $('#mocha #stats .progress')
      false

  printTestResults = ->
    page.evaluate ->
      console.log document.body.querySelector(".description").innerText
      list = document.body.querySelectorAll("div.jasmine_reporter > div.suite.failed")
      i = 0
      while i < list.length
        el = list[i]
        desc = el.querySelectorAll(".description")
        console.log ""
        j = 0
        while j < desc.length
          console.log desc[j].innerText
          ++j
        ++i

    phantom.exit()

  #waitFor testCompletion, printTestResults
  setTimeout phantom.exit, 3000

# # A bit of a hack until we can figure this out on Travis
# tries = 0
# while tries < 3 && $?.exitstatus === 124
#   tries += 1
#   puts "Timed Out. Trying again..."
#   system(cmd)
# end
# 
# success &&= $?.success?

###
exec  = require("child_process").exec
forever = require("forever")
Hook  = require("hook.io").Hook
hook  = new Hook(name: "tower-test", debug: true, silent: false)
url   = "http://localhost:3000"

browsers =
  names:    ["chrome", "safari", "firefox", "opera"]
  # chrome: ["/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome", "--user-data-dir=/tmp", url]
  chrome:   """open -a "Google Chrome" #{url}"""
  safari:   """open -a "Safari" #{url}"""
  firefox:  """open -a "Firefox" #{url}"""
  opera:    """open -a "Opera" #{url}"""
  
next = (callback) ->
  browser = browsers[browser.names.shift()]
  if browser
    exec browser
  else
    hook.kill()

hook.on "design.io-server::tower-test::ready", =>
  next()
  #exec "open #{url}"

hook.on "design.io-server::tower-test::client::log", (data, callback, event) =>
  # data == spec output from browser
  if data.type == "test"
    console.log data
    if data.phase == "complete"
      next()
  
hook.start()
###