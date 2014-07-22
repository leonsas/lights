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
    $client.flush
end

def setColor(color)
    light = $client.lights
    light.set_color(color, duration: 0.5)
    $client.flush
end

def dim()
    color = LIFX::Color.hsbk(20,0.7,0.2,2500)
    setColor(color)
end

def white()
    color = LIFX::Color.hsbk(0,0,1.0,6400)
    setColor(color)
end

def start()
    color = LIFX::Color.hsbk(35,0.8,1,5000)
    setColor(color)
end

def wake()
    color = LIFX::Color.hsbk(230,1.0,1.0,6400)
    setColor(color)
end

def mid()
    color = LIFX::Color.hsbk(35,1,1,3000)
    setColor(color)
end

def auto
    start
    current = [35,0.8,1,5000]
    final = [20,0.7,0.2,2500]
    num_steps = Integer(ARGV[1])
    steps = current.zip(final).collect do |i,f| (f-i)/num_steps end
    60.times do |n|
        color = LIFX::Color.hsbk(*current)
        setColor(color)
        current = current.zip(steps).collect! do |c,s| c+s end
        puts "sleeping", n
        sleep(num_steps)
    end
end

def callit(funname)
    m = method(funname)
    m.call
end

if ARGV.length > 1 and ARGV[0] != "auto"
    puts "Too many args"
    
end

print "Looking for lamp..."
$client.discover! #discover synchronosuly (blocking)
print ".. Found.\n"



arg =  ARGV[0]
cases = ['on','off','dim','wake','mid','white','auto','start']

if cases.include? arg
    puts "Mode #{arg}"
    callit(arg)
else
    puts "Not sure what to do"
end


