#!/usr/bin/env ruby
require 'lifx'

$client = LIFX::Client.lan # Talk to bulbs on the LAN

def on()
    puts "Turning on"
    $client.lights.turn_on
    $client.flush
end

def off()
    puts "Turning off"
    $client.lights.turn_off
end

def setColor(color)
    light = $client.lights.with_label('leon')
    light.set_color(color, duration: 2)
    $client.flush
end

def dim()
    color = LIFX::Color.hsbk(20,0.7,0.5,2500)
    setColor(color)
end

def wake()
    color = LIFX::Color.hsbk(0,0,1,6400)
    setColor(color)
end

def mid()
    color = LIFX::Color.hsbk(35,1,1,3000)
    setColor(color)
end

def callit(funname)
    m = method(funname)
    m.call
end

if ARGV.length > 1
    puts "Too many args"
end

print "Looking for lamp..."
$client.discover! #discover synchronosuly (blocking)
print ".. Found.\n"



arg =  ARGV[0]
cases = ['on','off','dim','wake','mid']

if cases.include? arg
    puts "Mode #{arg}"
    callit(arg)
else
    puts "Not sure what to do"
end


