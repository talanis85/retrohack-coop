function strsplit(inputstr, sep, max)
	if not inputstr then
		return {}
	end

	if not sep then
		sep = ","
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		if max and i > max then
			if t[i] then
				t[i] = t[i] .. sep .. str
			else
				t[i] = str
			end
		else
			t[i] = str
			i = i + 1
		end
	end
	return t
end

-- A simple function to count a table, even though some functions
-- do exist for counting, they do not work in all cases
function getTableSize(t)
	local count = 0
	for _, __ in pairs(t) do
		count = count + 1
	end
	return count
end

-- Checks if a single dimension table has a value
-- Returns true if found, false if not found
function tableHasValue(tbl, val)
	for _, v in pairs(tbl) do
		if (tostring(v) == tostring(val)) then
			return true
		end

		if(tonumber(v) == tonumber(val)) then
			return true
		end
	end

	return false
end

-- Returns a table of input tables keys sorted by the values
-- of the input table. Accepts a sort function for sort ordering
function getKeysSortedByValue(tbl, sortFunction)
	local keys = {}
	for key in pairs(tbl) do
		table.insert(keys, key)
	end

	table.sort(keys, function(a, b)
		return sortFunction(tbl[a], tbl[b])
	end)

	return keys
end

-- Returns an inverted version of the table provided
function invert_table(t)
	local inverted = {}
	for key,val in pairs(t) do
		inverted[val] = key
	end
	return inverted
end

--Repeatedly tries to reconnect with the host using exponential backoff.
function reconnectToHost()
	local retry = 0
	while host.reconnecting() do
		local init = os.time()
		local backoff = math.random(5, math.min(60, 5 * math.pow(2, retry)))
		printOutput("Waiting " .. tostring(backoff) .. "s to reconnect.")
		while os.difftime(os.time(), init) < backoff do
			coroutine.yield()
			if not host.reconnecting() then
				return
			end
		end
		--pcall doesn't work with functions that call coroutine.yield(), so we
		--use a coroutine instead.
		local thread = coroutine.create(host.join)
		while coroutine.status(thread) == 'suspended' do
		  coroutine.resume(thread)
		  coroutine.yield()
		end
		retry = retry + 1
	end
end

--Returns a list of files in a given directory
function os.dir(dir)
	local files = {}
	local f = assert(io.popen('dir \"' .. dir .. '\" /b ', 'r'))
	for file in f:lines() do
		table.insert(files, file)
	end
	f:close()
	return files
end
