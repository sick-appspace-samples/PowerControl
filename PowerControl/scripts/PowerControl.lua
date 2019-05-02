--[[----------------------------------------------------------------------------

  Application Name: PowerControl

  Description:
  Setting the power output of a connector and retrieving its state and information

  This sample shows how to enable and disable the power output of connectors.
  The available connectors are dependent on the device used. More information for
  available power connectors can be found in the device manual or with the
  code completion on the enum of Connector.Power.create(enum). In this sample
  the Sensor 1 power connector is used. This may have to be adapted if another
  device than a SIM4000 is used.
  This script first enables the power connector and then toggles the power every
  ten seconds and retrieves additional information. To show, this sample must
  be run on a device with power connectors. The results are printed to the console.

------------------------------------------------------------------------------]]
--Start of Global Scope---------------------------------------------------------

--Creation of handle for the power connector. This has to be adapted,
--if not a SIM4000 device is used. Code completion on Connector.Power.create()
--can be used to get other available power connectors
-- luacheck: globals gPowerHandle gToggleTimer
gPowerHandle = Connector.Power.create('S1')

--Creating timer to create a toggle cycle
gToggleTimer = Timer.create()
Timer.setExpirationTime(gToggleTimer, 5000)
Timer.setPeriodic(gToggleTimer, true)

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

--@handleOnStarted()
local function handleOnStarted()
  --Enabling power once after start and
  --then starting timer to call the toggle on every expiration
  Connector.Power.enable(gPowerHandle, true)
  Timer.start(gToggleTimer)
end
--The following registration is part of the global scope which runs once after startup
--Registration of the 'main' function to the 'Engine.OnStarted' event
Script.register('Engine.OnStarted', handleOnStarted)

--@togglePower()
local function togglePower()
  --Toggle power depending on previous state
  if Connector.Power.isEnabled(gPowerHandle) then
    Connector.Power.enable(gPowerHandle, false)
  else
    Connector.Power.enable(gPowerHandle, true)
  end
end
--The following registration is part of the global scope which runs once after startup
--Registration of the 'togglePower' function to the 'OnExpired' event of the gToggleTimer
Timer.register(gToggleTimer, 'OnExpired', togglePower)

--@handleOnSwitched(powerstate:bool)
local function handleOnSwitched(powerstate)
  print('Current state is: ' .. tostring(powerstate))
  Script.sleep(2000) -- Waiting to let the values settle, usage for demonstration only
  local power,
    voltage,
    current = Connector.Power.getValues(gPowerHandle)
  print(
    'Power [W]: ' ..
      power .. ' Voltage [V]: ' .. voltage .. ' Current [A]: ' .. current
  )
end
--The following registration is part of the global scope which runs once after startup
--Registration to the 'OnSwitched' event of the Power Connector
Connector.Power.register(gPowerHandle, 'OnSwitched', handleOnSwitched)

--End of Function and Event Scope-----------------------------------------------
