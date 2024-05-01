--[[
	This module provides the user with a window containing a single button.
	
	The button will slide from the right to the left and, once it touches
	the left border of the window, it will be reset (placed on the right
	side of the window) in a random Y position.
	
	Should the player press the sliding button, it will reset its position.
]]--


local padding		= 15	-- Space between the button and the window borders.
local slideLoopId	= nil	-- Id used to keep track of the sliding animation process.


-- This resets the given button to the right side of the window on a random Y position.
function resetButton(button)
	
	local mainWindowPos 	= mainWindow:getPosition()
	local mainWindowWidth	= mainWindow:getWidth()
	local mainWindowHeight	= mainWindow:getHeight()
	
	local buttonWidth 	= button:getWidth()
	local buttonHeight 	= button:getHeight()
	
	local buttonX = mainWindowPos.x + mainWindowWidth - padding - buttonWidth
	local minY = mainWindowPos.y + padding + buttonHeight
	local maxY = mainWindowPos.y + mainWindowHeight - padding - buttonHeight
	local buttonY = math.random(minY, maxY)
	
  	button:setPosition({ x = buttonX, y = buttonY})
end

-- Once called, this function will recursivelly call itself to provide a sliding animation to the button.
function slideButton()
	if mainWindow == nil then
		return
	end
	
	local button = mainWindow:getChildById("answer7button")
	local pos = button:getPosition()
	pos.x = pos.x - 2

	local buttonWidth 	= button:getWidth()
	local mainWindowPos 	= mainWindow:getPosition()
	local mainWindowWidth	= mainWindow:getWidth()
	local minX = mainWindowPos.x + padding

	-- If button reached the left window side, reset its position, otherwise, just make it slide.
	if pos.x < minX then
		resetButton(button)
	else
		button:setPosition(pos)
	end
	
	-- Recursively call this function with 16ms delay (about 30 times per second).
	slideLoopId = scheduleEvent(slideButton, 16)
end

-- Below is mostly boilerplate code to setup and take care of the module's window and menu button.

function init()
	mainWindow = g_ui.displayUI('answer7', modules.game_interface.getRightPanel())
	mainWindow:hide()

	menuButton = modules.client_topmenu.addRightGameToggleButton('menuButton', tr('Jump!'), '/images/topbuttons/answer7', toggle)
	menuButton:setOn(false)
end

function terminate()
	mainWindow:destroy()
	menuButton:destroy()
	if slideLoopId ~= nil then
		removeEvent(slideLoopId) -- Stop the sliding animation process.
	end
end

function toggle()
  if menuButton:isOn() then
    menuButton:setOn(false)
    mainWindow:hide()
    
    removeEvent(slideLoopId) -- Stop the sliding animation process.
  else
    menuButton:setOn(true)
    mainWindow:show()
    mainWindow:raise()
    mainWindow:focus()
    
    slideButton() -- Start the sliding animation process.
  end
end
