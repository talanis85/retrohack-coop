local gui = {}

require("wx")

local frame = nil
local grid = nil
local propRamcode = nil
local propUser = nil
local propPass = nil
local propHost = nil

local ramcodes = {
  "Link to the Past.lua"
}

function gui.init()
  frame = wx.wxFrame(wx.NULL, wx.wxID_ANY, "bizhawk-co-op")

  lblRamcode = wx.wxStaticText(frame, wx.wxID_ANY, "Ramcode:")
  txtRamcode = wx.wxTextCtrl(frame, wx.wxID_ANY, "Link to the Past.lua")

  lblUser = wx.wxStaticText(frame, wx.wxID_ANY, "User:")
  txtUser = wx.wxTextCtrl(frame, wx.wxID_ANY, "")

  lblPass = wx.wxStaticText(frame, wx.wxID_ANY, "Password:")
  txtPass = wx.wxTextCtrl(frame, wx.wxID_ANY, "")

  lblHost = wx.wxStaticText(frame, wx.wxID_ANY, "Host:")
  txtHost = wx.wxTextCtrl(frame, wx.wxID_ANY, "")

  lblPort = wx.wxStaticText(frame, wx.wxID_ANY, "Port:")
  txtPort = wx.wxTextCtrl(frame, wx.wxID_ANY, "")

  frame:Show(true)
end

function gui.iterate()
  wx.wxGetApp():Dispatch()
end

function gui.update()
end

function gui.getRamcode()
  return "Link to the Past.lua"
end

function gui.getUser()
  return "testuser"
end

function gui.getPass()
  return "testpassword"
end

function gui.getHost()
  return "localhost"
end

function gui.getPort()
  return 50000
end

return gui
