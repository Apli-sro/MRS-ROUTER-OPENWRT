m = Map("ser2net", translate("Serial - Ethernet"),
        translate("The ser2net allows telnet and tcp sessions to be established with a unit's serial ports.<br/>"))

function m.on_after_commit(self)
        luci.sys.call("/etc/init.d/ser2net enable 1\>/dev/null 2\>/dev/null")
        luci.sys.call("/etc/init.d/ser2net restart 1\>/dev/null 2\>/dev/null")
end

s = m:section(TypedSection, "proxy", translate("Proxies"),
        translate("The program comes up normally as a service, opens the TCP ports specified in the configuration file, and waits for connections.<br/>Once a connection occurs, the program attempts to set up the connection and open the serial port.<br/>If another user is already using the connection or serial port, the connection is refused with an error message."))

s.anonymous = true
s.addremove = true
s.sectionhead = translate("Configuration")
s.template = "cbi/tblsection"

bind = s:option(Value, "bind", translate("Bind Address"))
bind.rmempty = false
bind.default = "0.0.0.0"

tcpport = s:option(Value, "tcpport", translate("TCP Port"))
tcpport.rmempty = false
tcpport.default = "8000"

state = s:option(Value, "state", translate("State"))
state.rmempty = false
state:value("raw", translate("Raw"))
state:value("rawlp", translate("Rawlp"))
state:value("telnet", translate("Telnet"))
state:value("off", translate("Off"))
state.default = "raw"

timeout = s:option(Value, "timeout", translate("Timeout"))
timeout.rmempty = false
timeout.default = "0"


device = s:option(Value, "device", translate("Device"))
device.rmempty = false
device:value("/dev/ttyS1", translate("M-Bus"))
device:value("/dev/ttyS0", translate("RS-485"))
device:value("/dev/ttyUSB0", translate("USB Serial 0"))
device:value("/dev/ttyUSB1", translate("USB Serial 1"))
device.default = "/dev/ttyS0"

baudrate = s:option(Value, "baudrate", translate("Baudrate"))
baudrate.rmempty = false
baudrate:value("300", translate("300"))
baudrate:value("1200", translate("1200"))
baudrate:value("2400", translate("2400"))
baudrate:value("4800", translate("4800"))
baudrate:value("9600", translate("9600"))
baudrate:value("19200", translate("19200"))
baudrate:value("38400", translate("38400"))
baudrate:value("57600", translate("57600"))
baudrate:value("115200", translate("115200"))
baudrate.default = "9600"

parity = s:option(Value, "parity", translate("Parity"))
parity.rmempty = false
parity:value("NONE", translate("None"))
parity:value("EVEN", translate("Even"))
parity:value("ODD", translate("Odd"))
parity.default = "NONE"

stop = s:option(Value, "stop", translate("Stop bits"))
stop.rmempty = false
stop:value("1STOPBIT", translate("1"))
stop:value("2STOPBITS", translate("2"))
stop.default = "1STOPBIT"

data = s:option(Value, "data", translate("Data bits"))
data.rmempty = false
data:value("8DATABITS", translate("8"))
data:value("7DATABITS", translate("7"))
data.default = "8DATABITS"



return m
