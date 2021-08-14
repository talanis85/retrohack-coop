host = require("coop.host")
sync = require("coop.sync")

require("lib.aux")
require("lib.lib")

config = {}
config.room = ""
config.ramcode = "LinkToThePast"
config.ramconfig = {}
config.user = ""
config.pass = ""
config.port = 50000
config.hostname = "localhost"
config.is_host = true

kicked = false

function printOutput(str)
	str = "[" .. os.date("%H:%M:%S", os.time()) .. "] " .. str
  output(str)
end

function updateGUI()
  -- no gui
end

math.randomseed(os.time())

sendMessage = {}
local thread
local reconnectThread

function retrohack_start()
  host.ramcode = config.ramcode
  host.ramconfig = config.ramconfig

  printOutput("config.user = " .. config.user)

  if config.is_host then
    host.start()
  else
    host.join()
  end
end

function retrohack_stop()
  host.close(false)
end

function retrohack_frame()
	host.listen()

	--If connected, run the syncinputs thread
	if host.connected() or host.reconnecting() then
    sync.syncRAM()
	end

	--If we're reconnecting, run the reconnect thread. host.reconnecting() can
	--temporarily become false during host.join(), so we continue running the
	--thread until it exits.
	if host.reconnecting() then
		--If the thread didn't yield, create a new one
		if reconnectThread == nil or coroutine.status(reconnectThread) == "dead" then
			reconnectThread = coroutine.create(reconnectToHost)
		end
	end
	if reconnectThread ~= nil and coroutine.status(reconnectThread) ~= "dead" then
		local status, err = coroutine.resume(reconnectThread)
		if (status == false and err ~= nil) then
		  printOutput("Error during reconnect: " .. tostring(err))
		end
	end
end
