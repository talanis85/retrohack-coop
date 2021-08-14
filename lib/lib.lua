-- Host-dependent memory operations

memory = {}
memory.segment = "main"

function memory.usememorydomain(domain)
  if domain == "WRAM" then
    memory.segment = "main"
  elseif domain == "CARTROM" then
    memory.segment = "rom"
  end
end

function memory.writebyte(address, value)
  memory_write(memory.segment, "u8", address, value)
end

function memory.write_u16_le(address, value)
  memory_write(memory.segment, "u16", address, value)
end

function memory.write_u32_le(address, value)
  memory_write(memory.segment, "u32", address, value)
end

function memory.readbyte(address)
  return memory_read(memory.segment, "u8", address)
end

function memory.read_u16_le(address)
  return memory_read(memory.segment, "u16", address)
end

function memory.read_u32_le(address)
  return memory_read(memory.segment, "u32", address)
end

--

-- Bit operations

local numberlua = require("lib.numberlua")

bit = {}

function bit.set(value, n)
  return numberlua.bor(value, numberlua.lshift(1, n))
end

function bit.clear(value, n)
  return numberlua.band(value, numberlua.bnot(numberlua.lshift(1, n)))
end

function bit.check(value, n)
  return numberlua.btest(value, numberlua.lshift(1, n))
end

bit.band = numberlua.band
bit.bxor = numberlua.bxor
bit.bor = numberlua.bor
bit.bnot = numberlua.bnot

