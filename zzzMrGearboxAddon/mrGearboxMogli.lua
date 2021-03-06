--***************************************************************
--
-- mrGearboxMogli
-- 
-- version 1.300 by mogli (biedens)
-- created at 2015/03/09
-- changed at 2015/06/15
--
--***************************************************************

local mrGearboxMogliVersion=1.500

-- allow modders to include this source file together with mogliBase.lua in their mods
if mrGearboxMogli == nil or mrGearboxMogli.version == nil or mrGearboxMogli.version < mrGearboxMogliVersion then

--***************************************************************
--mogliBase20.newClass( "mrGearboxMogli", "mrGbMS" )
if _G[g_currentModName..".mogliBase"] == nil then
	source(Utils.getFilename("mogliBase.lua", g_currentModDirectory))
end
_G[g_currentModName..".mogliBase"].newClass( "mrGearboxMogli", "mrGbMS" )
--***************************************************************

mrGearboxMogli.version              = mrGearboxMogliVersion
mrGearboxMogli.huge                 = 1000000
mrGearboxMogli.eps                  = 1E-6
mrGearboxMogli.factor30pi           = 9.5492965855137201461330258023509
mrGearboxMogli.factorpi30           = 0.10471975511965977461542144610932
mrGearboxMogli.rpmRatedMinus        = 100 -- 100  -- min RPM at 900 RPM
mrGearboxMogli.rpmMinus             = 300 -- 100  -- min RPM at 900 RPM
mrGearboxMogli.rpmFadeOut           = 100  -- no torque at 2300 RPM
mrGearboxMogli.rpmPlus              = 200  -- braking at 2350 RPM
mrGearboxMogli.minRpmInSpeedHudDelta=  500
mrGearboxMogli.maxRpmInSpeedHudDelta= 2500
mrGearboxMogli.ptoRpmFactor         = 0.900 -- 0.75 -- reduce PTO RPM; e.g. 1900 with PTO and 2200 rated RPM
mrGearboxMogli.ptoRpmFactorEco      = 2/3   -- 0.5  -- reduce PTO RPM in eco mode; e.g. 1600 with PTO and 2200 rated RPM
mrGearboxMogli.rpmMinusEco          = 0    -- reduce target RPM in eco mode
mrGearboxMogli.autoShiftRpmDiff     = 50
mrGearboxMogli.autoShiftPowerRatio  = 1.03
mrGearboxMogli.autoShiftMaxDeltaRpm = 1E-3
mrGearboxMogli.minClutchPercent     = 0.01
mrGearboxMogli.minClutchPercentStd  = 0.5
mrGearboxMogli.minClutchPercentTC   = 0.3
mrGearboxMogli.minClutchPercentTCL  = 0.3
mrGearboxMogli.clutchLoopTimes      = 10
mrGearboxMogli.clutchLoopDelta      = 10
mrGearboxMogli.minGearRatio         = 0.1
mrGearboxMogli.maxGearRatio         = 7540 -- 0.05 km/h @1000 RPM / gear ratio might be bigger, but no clutch in this case
--mrGearboxMogli.maxGearRatio       = 1885 -- 0.2 km/h @1000 RPM / gear ratio might be bigger, but no clutch in this case
mrGearboxMogli.maxHydroGearRatio    = 75400 --7540 --754
mrGearboxMogli.maxHydroGearRatio2   = mrGearboxMogli.maxHydroGearRatio
mrGearboxMogli.brakeFxSpeed         = 2.5  -- m/s = 9 km/h
mrGearboxMogli.rpmReduction         = 0.85 -- 15% RPM reduction allowed e.g. 330 RPM for 2200 rated RPM 
mrGearboxMogli.maxPowerLimit        = 0.97 -- 97% max power is equal to max power
mrGearboxMogli.maxPowerPlusRpm      = 50   -- plus 50 RPM
mrGearboxMogli.extraTragetRpm				= 200
mrGearboxMogli.smoothLittle         = 0.2
mrGearboxMogli.smoothFast           = 0.12
mrGearboxMogli.smoothMedium         = 0.04
mrGearboxMogli.smoothSlow           = 0.015
mrGearboxMogli.absWheelSpeedRpmMin  = 10
mrGearboxMogli.hydroEffDiff         = 50
mrGearboxMogli.hydroEffDiffInc      = 150
mrGearboxMogli.ptoRpmThrottleDiff   = 25 --75
mrGearboxMogli.powerFactor0         = 0.1424083769633507853403141361257
mrGearboxMogli.fuelFactor           = 1/(830*60*60*1000)-- 830 g per liter per hour => liter per millisecond
mrGearboxMogli.accDeadZone          = 0.15
mrGearboxMogli.blowOffVentilTime0   = 1000
mrGearboxMogli.blowOffVentilTime1   = 1000
mrGearboxMogli.blowOffVentilTime2   = 100
mrGearboxMogli.debugGearShift       = false
mrGearboxMogli.globalsLoaded        = false
mrGearboxMogli.ptoSpeedLimitMin     = 3 / 3.6  -- minimal speed limit
mrGearboxMogli.ptoSpeedLimitIni     = 0 / 3.6  -- initial offset for ptoSpeedLimit 
mrGearboxMogli.ptoSpeedLimitOff     = 1 / 3.6  -- turn off ptoSpeedLimit 
mrGearboxMogli.ptoSpeedLimitDec     = 0 / 3600 -- brake 
mrGearboxMogli.ptoSpeedLimitInc     = 1 / 3600 -- accelerate by 2 km/h per second 
mrGearboxMogli.ptoSpeedLimitRatio   = 0.15
mrGearboxMogli.combineUseRealArea   = true
mrGearboxMogli.AIPowerShift         = "P"
mrGearboxMogli.AIGearboxOff         = "N"
mrGearboxMogli.AIAllAuto            = "A"
mrGearboxMogli.AIGearboxOn          = "Y"
mrGearboxMogli.kmhTOms              = 5 / 18
mrGearboxMogli.extraSpeedLimit      = 0.25
mrGearboxMogli.extraSpeedLimitMs    = 5 / 72
mrGearboxMogli.deltaLimitMax        = 100
mrGearboxMogli.deltaLimitFactor     = 1.0
mrGearboxMogli.deltaLimitAdd        = 0.0
mrGearboxMogli.deltaLimitTimeMs     = 500
mrGearboxMogli.speedLimitBrake      = 2 / 3.6 -- m/s
mrGearboxMogli.speedLimitMode       = "B" -- "T"orque limit only / "M"ax RPM only / "B"oth
mrGearboxMogli.motorBrakeTime       = 250     
mrGearboxMogli.hackSounds           = false
mrGearboxMogli.motorLoadExp         = 1.5

mrGearboxMogliGlobals                       = {}
mrGearboxMogliGlobals.debugPrint            = false
mrGearboxMogliGlobals.torqueFactor          = 1.1182033096926713947990543735225  -- Giants is cheating: 0.86 * 0.88 = 0.7568 > 0.72 => torqueFactor = 0.86 * 0.88 / ( 0.72 * 0.94 )
mrGearboxMogliGlobals.blowOffVentilVol      = 0.14
mrGearboxMogliGlobals.drawTargetRpm         = false 
mrGearboxMogliGlobals.drawReqPower          = false
mrGearboxMogliGlobals.defaultOn             = true
mrGearboxMogliGlobals.noDisable             = false
mrGearboxMogliGlobals.disableManual         = false
mrGearboxMogliGlobals.blowOffVentilRpmRatio = 0.7
mrGearboxMogliGlobals.minTimeToShift			  = 0    -- ms
mrGearboxMogliGlobals.maxTimeToSkipGear  	  = 251  -- ms
mrGearboxMogliGlobals.autoShiftTimeoutLong  = 4000 -- ms
mrGearboxMogliGlobals.autoShiftTimeoutShort = 500 -- ms
mrGearboxMogliGlobals.autoShiftTimeoutHydroL= 1000 -- ms 
mrGearboxMogliGlobals.autoShiftTimeoutHydroS= 0    -- ms
mrGearboxMogliGlobals.shiftEffectTime			  = 251  -- ms
mrGearboxMogliGlobals.shiftTimeMsFactor     = 1
mrGearboxMogliGlobals.playGrindingSound     = true
mrGearboxMogliGlobals.defaultHudMode        = 1    -- 0: no HUD, 1: big HUD, 2: small HUD with gear name only
mrGearboxMogliGlobals.hudPositionX          = 0.84
mrGearboxMogliGlobals.hudPositionY          = 0.7
mrGearboxMogliGlobals.hudTextSize           = 0.02
mrGearboxMogliGlobals.hudTitleSize          = 0.03
mrGearboxMogliGlobals.hudBorder             = 0.005
mrGearboxMogliGlobals.hudWidth              = 0.15
mrGearboxMogliGlobals.stallWarningTime      = 250
mrGearboxMogliGlobals.stallMotorOffTime     = 3000
mrGearboxMogliGlobals.realFuelUsage         = true
mrGearboxMogliGlobals.defaultLiterPerSqm    = 1.2  -- 1.2 l/m² for wheat
mrGearboxMogliGlobals.combineDefaultSpeed   = 8 -- km/h
mrGearboxMogliGlobals.combineDynamicRatio   = 0.6
mrGearboxMogliGlobals.combineDynamicChopper = 0.8
mrGearboxMogliGlobals.dtDeltaTargetFast     = 0.0005 --  2 second 
mrGearboxMogliGlobals.dtDeltaTargetSlow     = 0.0001 -- 10 seconds
mrGearboxMogliGlobals.ddsDirectory          = "dds/"
mrGearboxMogliGlobals.initMotorOnLoad       = true
mrGearboxMogliGlobals.ptoSpeedLimit         = true
mrGearboxMogliGlobals.clutchFrom            = 0.0
mrGearboxMogliGlobals.clutchTo              = 0.8
mrGearboxMogliGlobals.clutchExp             = 2.2
mrGearboxMogliGlobals.clutchFactor          = 2.4
mrGearboxMogliGlobals.blinkingWarning       = true
mrGearboxMogliGlobals.grindingMinRpmDelta   = 200
mrGearboxMogliGlobals.grindingMaxRpmSound   = 600
mrGearboxMogliGlobals.grindingMaxRpmDelta   = mrGearboxMogli.huge
mrGearboxMogliGlobals.hydroTransVolRatio    = 0 --0.2
mrGearboxMogliGlobals.defaultEnableAI       = mrGearboxMogli.AIPowerShift
mrGearboxMogliGlobals.autoHold              = true
mrGearboxMogliGlobals.minAutoGearSpeed      = 0.5
mrGearboxMogliGlobals.minAbsSpeed           = 0.2   -- km/h
mrGearboxMogliGlobals.brakeNeutralTimeout   = 1000  -- ms
mrGearboxMogliGlobals.brakeNeutralLimit     = -0.3
mrGearboxMogliGlobals.DefaultRevUpMs0       = 1000  -- ms
mrGearboxMogliGlobals.DefaultRevUpMs1       = 2000  -- ms
mrGearboxMogliGlobals.DefaultRevDownMs      = 1500  -- ms
mrGearboxMogliGlobals.HydroSpeedIdleRedux   = 0.02  -- 0.04  -- default reduce by 10 km/h per second => 0.4 km/h with const. RPM and w/o acc.
mrGearboxMogliGlobals.motorLoadVolumeBrake  = 1.0   -- make some noise with motor brake; -1 take normal motor load 
mrGearboxMogliGlobals.motorLoadVolumeBrakeR = -1    -- make some noise with motor brake; -1 take normal motor load
mrGearboxMogliGlobals.minClutchTimeManual   = 3000  -- ms; time from 0% to 100% for the digital manual clutch
mrGearboxMogliGlobals.momentOfInertia       = 2     -- J in unit kg m^2; for a cylinder with mass m and radius r: J = 0.5 * m * r^2
mrGearboxMogliGlobals.maxTorqueMsInv        = 0.002 -- 1 / ( time in ms to increase torque )
mrGearboxMogliGlobals.clutchSimu1           = true
mrGearboxMogliGlobals.clutchSimu2           = false
mrGearboxMogliGlobals.clutchSimu3           = false

--**********************************************************************************************************	
-- setSampleVolume
--**********************************************************************************************************	
mrGearboxMogli.builtInSetSampleVolume   = setSampleVolume
mrGearboxMogli.SoundUtilSetSampleVolume = SoundUtil.setSampleVolume
mrGearboxMogli.disabledVolumes          = {}
setSampleVolume = function( sample, volume )
	if mrGearboxMogli.disabledVolumes[sample] then
		return 
	end
	mrGearboxMogli.builtInSetSampleVolume( sample, volume )
end

SoundUtil.setSampleVolume = function( sound, volume, ... )
	if sound ~= nil and sound.sample ~= nil then
		sound.mrGbMVolumeO = volume 
	end
	mrGearboxMogli.SoundUtilSetSampleVolume( sound, volume, ... )
end

--**********************************************************************************************************	
-- mrGearboxMogli.setSampleVolume 
--**********************************************************************************************************	
function mrGearboxMogli.setSampleVolume( sound, volume )
	if sound ~= nil and sound.sample ~= nil then
		mrGearboxMogli.disabledVolumes[sound.sample] = true
		sound.mrGbMVolume = volume 
		if sound.mrGbMVolumeO ~= nil then
			sound.mrGbMVolumeD = volume - sound.mrGbMVolumeO
		end
		mrGearboxMogli.builtInSetSampleVolume( sound.sample, volume )
	end
end

--**********************************************************************************************************	
-- mrGearboxMogli.resetSampleVolume 
--**********************************************************************************************************	
function mrGearboxMogli.resetSampleVolume( sound )
	if sound ~= nil and sound.sample ~= nil then
		mrGearboxMogli.disabledVolumes[sound.sample] = false
		mrGearboxMogli.builtInSetSampleVolume( sound.sample, Utils.getNoNil( sound.mrGbMVolumeO, 0 ) )
	end
end

--**********************************************************************************************************	
-- setSamplePitch
--**********************************************************************************************************	
mrGearboxMogli.builtInSetSamplePitch   = setSamplePitch
mrGearboxMogli.SoundUtilSetSamplePitch = SoundUtil.setSamplePitch
mrGearboxMogli.disabledPitches         = {}
setSamplePitch = function( sample, pitch )
	if mrGearboxMogli.disabledPitches[sample] then
		return 
	end
	mrGearboxMogli.builtInSetSamplePitch( sample, pitch )
end

SoundUtil.setSamplePitch = function( sound, pitch, ... )
	if sound ~= nil and sound.sample ~= nil then
		sound.mrGbMPitchO = pitch 
	end
	mrGearboxMogli.SoundUtilSetSamplePitch( sound, pitch, ... )
end

--**********************************************************************************************************	
-- mrGearboxMogli.setSamplePitch 
--**********************************************************************************************************	
function mrGearboxMogli.setSamplePitch( sound, pitch )
	if sound ~= nil and sound.sample ~= nil then
		mrGearboxMogli.disabledPitches[sound.sample] = true
		sound.mrGbMPitch = pitch 
		if sound.mrGbMPitchO ~= nil then
			sound.mrGbMPitchD = pitch - sound.mrGbMPitchO
		end
		mrGearboxMogli.builtInSetSamplePitch( sound.sample, pitch )
	end
end

--**********************************************************************************************************	
-- mrGearboxMogli.resetSamplePitch 
--**********************************************************************************************************	
function mrGearboxMogli.resetSamplePitch( sound )
	if sound ~= nil and sound.sample ~= nil then
		mrGearboxMogli.disabledPitches[sound.sample] = false
		mrGearboxMogli.builtInSetSamplePitch( sound.sample, Utils.getNoNil( sound.mrGbMPitchO, sound.pitchOffset ) )
	end
end

--**********************************************************************************************************	
-- mrGearboxMogli.prerequisitesPresent 
--**********************************************************************************************************	
function mrGearboxMogli.prerequisitesPresent(specializations) 
	return true
end 

--**********************************************************************************************************	
-- mrGearboxMogli:load
--**********************************************************************************************************	
function mrGearboxMogli:load(savegame) 
	local key = "vehicle.gearboxMogli"
	if hasXMLProperty(xmlFile, key) then
		mrGearboxMogli.initFromXml(self,self.xmlFile,key,"vehicle",true)
	end
end

--**********************************************************************************************************	
-- mrGearboxMogli.getNoNil2
--**********************************************************************************************************	
function mrGearboxMogli.getNoNil2( v0, v1, v2, use2 )
	if v0 == nil then
		if v2 ~= nil and use2 then
			return v2
		end
		return v1
	end
	return v0
end

--**********************************************************************************************************	
-- mrGearboxMogli generic getter methods
--**********************************************************************************************************	
mrGearboxMogli.stateWithSetGet = { "IsOnOff", 
                                   "CurrentGear", 
																	 "CurrentRange", 
																	 "CurrentRange2",
																	 "Automatic", 
																	 "NeutralActive", 
																	 "ReverseActive", 
																	 "SpeedLimiter",  
																	 "HandThrottle", 
																	 "AutoClutch", 
																	 "ManualClutch",
																	 "AccelerateToLimit",
																	 "DecelerateToLimit",
																	 "EcoMode",
																	 "HudMode" }

for _,state in pairs( mrGearboxMogli.stateWithSetGet ) do
	mrGearboxMogli["mrGbMGet"..state] = function(self)
		return self.mrGbMS[state]
	end
	mrGearboxMogli["mrGbMSet"..state] = function(self, value, noEventSend )
		mrGearboxMogli.mbSetState( self, state, value, noEventSend ) 		
	end
end

--**********************************************************************************************************	
-- mrGearboxMogli:initClient
--**********************************************************************************************************	
function mrGearboxMogli:initClient()		

	print("mrGearboxMogli: Initialization of client...")

	-- state
	self.mrGbMS = {}
	-- locals used for calculations
	self.mrGbML = {}
	-- draw
	self.mrGbMD = {}
	-- backup
	self.mrGbMB = {}
	
	if self.mrGbMG == nil then
		if not( mrGearboxMogli.globalsLoaded ) then
			mrGearboxMogli.globalsLoaded = true
			file = mrGearboxMogli.modsDirectory.."zzzMrGearboxAddonConfig.xml"
			if fileExists(file) then	
				mrGearboxMogli.globalsLoad( file, "vehicles.gearboxMogliGlobals", mrGearboxMogliGlobals )	
			end		
			mrGearboxMogliGlobals.hudWidth = Utils.clamp( 16.0 * g_screenHeight * mrGearboxMogliGlobals.hudWidth / ( 9.0 * g_screenWidth ), 0.05, 0.3 )
			if mrGearboxMogliGlobals.hudWidth + mrGearboxMogliGlobals.hudPositionX > 1 then
				mrGearboxMogliGlobals.hudPositionX = 1 - mrGearboxMogliGlobals.hudWidth
			end
		end	
		
		self.mrGbMG = mrGearboxMogliGlobals
	end

	self.mrGbMSetState    = mrGearboxMogli.mbSetState
	self.mrGbMDoGearShift = mrGearboxMogli.mrGbMDoGearShift
	
	mrGearboxMogli.registerState( self, "IsOn",          false, mrGearboxMogli.mrGbMOnSetIsOn )
	mrGearboxMogli.registerState( self, "BlowOffVentilPlay",false )
	mrGearboxMogli.registerState( self, "GrindingGearsVol", 0 )--, mrGearboxMogli.debugEvent )
	mrGearboxMogli.registerState( self, "DrawText",      "off" )
	mrGearboxMogli.registerState( self, "DrawText2",     "off" )
	mrGearboxMogli.registerState( self, "G27Mode",       0 ) 	
	mrGearboxMogli.registerState( self, "WarningText",   "",    mrGearboxMogli.mrGbMOnSetWarningText )
	mrGearboxMogli.registerState( self, "InfoText",      "",    mrGearboxMogli.mrGbMOnSetInfoText )
	mrGearboxMogli.registerState( self, "MotorBrake",    false )
	mrGearboxMogli.registerState( self, "ConstantRpm",   false )
	mrGearboxMogli.registerState( self, "NoUpdateStream",false, mrGearboxMogli.mrGbMOnSetNoUpdateStream )
	mrGearboxMogli.registerState( self, "NUSMessage",    {},    mrGearboxMogli.mrGbMOnSetNUSMessage )
	
--**********************************************************************************************************	
-- state variables with setter methods	
	for _,state in pairs( mrGearboxMogli.stateWithSetGet ) do
		self["mrGbMSet"..state] = mrGearboxMogli["mrGbMSet"..state] 
		self["mrGbMGet"..state] = mrGearboxMogli["mrGbMGet"..state] 
	end
	
	mrGearboxMogli.initStateHandling( self )
	mrGearboxMogli.registerState( self, "IsOnOff",       false )
	mrGearboxMogli.registerState( self, "CurrentGear",   1,     mrGearboxMogli.mrGbMOnSetGear ) 
	mrGearboxMogli.registerState( self, "CurrentRange",  1,     mrGearboxMogli.mrGbMOnSetRange )
	mrGearboxMogli.registerState( self, "CurrentRange2", 1,     mrGearboxMogli.mrGbMOnSetRange2 )
	mrGearboxMogli.registerState( self, "NewGear",       0,     mrGearboxMogli.mrGbMOnSetNewGear ) 
	mrGearboxMogli.registerState( self, "NewRange",      0,     mrGearboxMogli.mrGbMOnSetNewRange )
	mrGearboxMogli.registerState( self, "NewRange2",     0,     mrGearboxMogli.mrGbMOnSetNewRange2 )
	mrGearboxMogli.registerState( self, "NewReverse",    false, mrGearboxMogli.mrGbMOnSetNewReverse )
	mrGearboxMogli.registerState( self, "IsNeutral",     true )
	mrGearboxMogli.registerState( self, "Automatic",     false )
	mrGearboxMogli.registerState( self, "ReverseActive", false, mrGearboxMogli.mrGbMOnSetReverse )
	mrGearboxMogli.registerState( self, "NeutralActive", true,  mrGearboxMogli.mrGbMOnSetNeutral ) 	
	mrGearboxMogli.registerState( self, "AutoHold",     false ) 	
	mrGearboxMogli.registerState( self, "AutoClutch",    true  )
	mrGearboxMogli.registerState( self, "ManualClutch",  1,     mrGearboxMogli.mrGbMOnSetManualClutch )
	mrGearboxMogli.registerState( self, "HandThrottle",  0 )
	mrGearboxMogli.registerState( self, "SpeedLimiter",  false )
	mrGearboxMogli.registerState( self, "AllAuto",       false )
	mrGearboxMogli.registerState( self, "EcoMode",       false )
	mrGearboxMogli.registerState( self, "HudMode",       self.mrGbMG.defaultHudMode )

--**********************************************************************************************************	
-- special getter functions for motor parameters
	self.mrGbMGetClutchPercent     = mrGearboxMogli.mrGbMGetClutchPercent
	self.mrGbMGetAutoClutchPercent = mrGearboxMogli.mrGbMGetAutoClutchPercent
	self.mrGbMGetCurrentRPM        = mrGearboxMogli.mrGbMGetCurrentRPM
	self.mrGbMGetTargetRPM         = mrGearboxMogli.mrGbMGetTargetRPM
	self.mrGbMGetMotorLoad         = mrGearboxMogli.mrGbMGetMotorLoad 
	self.mrGbMGetUsedPower         = mrGearboxMogli.mrGbMGetUsedPower
	self.mrGbMGetThroughPut        = mrGearboxMogli.mrGbMGetThroughPut
	self.mrGbMGetModeText          = mrGearboxMogli.mrGbMGetModeText 
	self.mrGbMGetModeShortText     = mrGearboxMogli.mrGbMGetModeShortText 
	self.mrGbMGetGearText          = mrGearboxMogli.mrGbMGetGearText 
	self.mrGbMGetIsOn              = mrGearboxMogli.mrGbMGetIsOn 
	self.mrGbMGetAutoStartStop     = mrGearboxMogli.mrGbMGetAutoStartStop 
	self.mrGbMGetAutoShiftGears    = mrGearboxMogli.mrGbMGetAutoShiftGears 
	self.mrGbMGetAutoShiftRange    = mrGearboxMogli.mrGbMGetAutoShiftRange  
	self.mrGbMGetGearSpeed         = mrGearboxMogli.mrGbMGetGearSpeed
	self.mrGbMGetGearNumber        = mrGearboxMogli.mrGbMGetGearNumber
	self.mrGbMGetRangeNumber       = mrGearboxMogli.mrGbMGetRangeNumber
	self.mrGbMGetRange2Number      = mrGearboxMogli.mrGbMGetRange2Number
	self.mrGbMGetHasAllAuto        = mrGearboxMogli.mrGbMGetHasAllAuto
	self.mrGbMGetAutoHold          = mrGearboxMogli.mrGbMGetAutoHold
	self.mrGbMGetOnlyHandThrottle  = mrGearboxMogli.mrGbMGetOnlyHandThrottle
	self.mrGbMGetHydrostaticFactor = mrGearboxMogli.mrGbMGetHydrostaticFactor
	
--**********************************************************************************************************	

	self.mrGbML.lastSumDt          = 0 
	self.mrGbML.soundSumDt         = 0 
	self.mrGbML.autoShiftTime      = 0
	self.mrGbML.currentGearSpeed   = 0	
	self.mrGbML.lastGearSpeed      = 0	
	self.mrGbML.warningTimer       = 0	
	self.mrGbML.infoTimer          = 0	
	self.mrGbML.manualClutchTime   = 0
	self.mrGbML.gearShiftingNeeded = 0 
	self.mrGbML.gearShiftingTime   = 0 
	self.mrGbML.clutchShiftingTime = 0 
	self.mrGbML.doubleClutch       = false
	self.mrGbML.lastReverse        = false
	self.mrGbML.dirtyFlag          = self:getNextDirtyFlag() 
	self.mrGbML.wantedAcceleration = 0
	self.mrGbML.blowOffVentilTime0 = 0
	self.mrGbML.blowOffVentilTime1 = 0
	self.mrGbML.blowOffVentilTime2 = -1
	self.mrGbML.oneButtonClutchTimer = 0
	self.mrGbML.strawDisableTime     = 0
	self.mrGbML.currentCuttersArea   = 0
	self.mrGbML.currentRealArea      = 0
	self.mrGbML.maxRealArea          = 0
	self.mrGbML.cutterAreaPerSecond  = 0
	self.mrGbML.realAreaPerSecond    = 0
	self.mrGbML.updateStreamErrors   = 0

	
	if mrGearboxMogli.ovArrowUpWhite == nil then
		local w  = math.floor(0.0095 * g_screenWidth) / g_screenWidth * g_uiScale
		local h = w * g_screenAspectRatio;
	--local x = g_currentMission.speedHud.x - w * 0.25
	--local y = g_currentMission.speedHud.y + g_currentMission.speedHud.height - 0.75 * h
		local x = g_currentMission.speedMeterIconOverlay.x-- + w * 0.25
		local y = g_currentMission.speedMeterIconOverlay.y-- + g_currentMission.speedMeterIconOverlay.height - 0.75 * h
		
		mrGearboxMogli.ovArrowUpWhite   = Overlay:new("ovArrowUpWhite",   Utils.getFilename( self.mrGbMG.ddsDirectory.."arrow_up_white.dds",   mrGearboxMogli.baseDirectory), x, y, w, h)
		mrGearboxMogli.ovArrowUpGray    = Overlay:new("ovArrowUpGray",    Utils.getFilename( self.mrGbMG.ddsDirectory.."arrow_up_gray.dds",    mrGearboxMogli.baseDirectory), x, y, w, h)
		mrGearboxMogli.ovArrowDownWhite = Overlay:new("ovArrowDownWhite", Utils.getFilename( self.mrGbMG.ddsDirectory.."arrow_down_white.dds", mrGearboxMogli.baseDirectory), x, y, w, h)
		mrGearboxMogli.ovArrowDownGray  = Overlay:new("ovArrowDownGray",  Utils.getFilename( self.mrGbMG.ddsDirectory.."arrow_down_gray.dds",  mrGearboxMogli.baseDirectory), x, y, w, h)
		mrGearboxMogli.ovHandBrakeUp    = Overlay:new("ovHandBrakeUp",    Utils.getFilename( self.mrGbMG.ddsDirectory.."hand_brake_up.dds",    mrGearboxMogli.baseDirectory), x, y, w, h)
		mrGearboxMogli.ovHandBrakeDown  = Overlay:new("ovHandBrakeDown",  Utils.getFilename( self.mrGbMG.ddsDirectory.."hand_brake_down.dds",  mrGearboxMogli.baseDirectory), x, y, w, h)
	end
	
	self.mrGbMD.Rpm        = 0 
	self.mrGbMD.lastRpm    = 0 
	self.mrGbMD.Tgt        = 0 
	self.mrGbMD.lastTgt    = 0 
	self.mrGbMD.Clutch     = 0 
	self.mrGbMD.lastClutch = 0 
	self.mrGbMD.Load       = 0   
	self.mrGbMD.lastLoad   = 0   
	self.mrGbMD.Speed      = 0 
	self.mrGbMD.lastSpeed  = 0 
	self.mrGbMD.Fuel       = 0 
	self.mrGbMD.lastPower  = 0 
	self.mrGbMD.Power      = 0 
	self.mrGbMD.lastRate   = 0 
	self.mrGbMD.Rate       = 0 
	self.mrGbMD.Hydro      = 255
	self.mrGbMD.lastHydro  = 255
	
	self.lastAcceleration  = 0
end 

--**********************************************************************************************************	
-- mrGearboxMogli.completeXMLGearboxEntry
--**********************************************************************************************************	
function mrGearboxMogli.completeXMLGearboxEntry( xmlFile, baseName, fixEntry )
	local newEntry = fixEntry
	newEntry.reverseOnly    = getXMLBool( xmlFile, baseName .. "#reverseOnly" )		
	newEntry.forwardOnly    = getXMLBool( xmlFile, baseName .. "#forwardOnly" )
	newEntry.minGear        = getXMLFloat(xmlFile, baseName .. "#minGear" )
	newEntry.maxGear        = getXMLFloat(xmlFile, baseName .. "#maxGear" )
	newEntry.minRange       = getXMLFloat(xmlFile, baseName .. "#minRange" )
	newEntry.maxRange       = getXMLFloat(xmlFile, baseName .. "#maxRange" )
	newEntry.minRange2      = getXMLFloat(xmlFile, baseName .. "#minRange2" )
	newEntry.maxRange2      = getXMLFloat(xmlFile, baseName .. "#maxRange2" )
	return newEntry
end

--**********************************************************************************************************	
-- mrGearboxMogli:initFromXml
--**********************************************************************************************************	
function mrGearboxMogli:initFromXml(xmlFile,xmlString,xmlSource,serverAndClient) 

--**************************************************************************************************	
	if xmlSource == "vehicle" then
		self.mrGbMG = {}
		for n,v in pairs( mrGearboxMogliGlobals ) do
			self.mrGbMG[n] = v
		end
		
		self.mrGbMG.playGrindingSound = false
		mrGearboxMogli.globalsLoad2( xmlFile, "vehicle.gearboxMogliGlobals", self.mrGbMG )	
		self.mrGbMG.hudWidth = Utils.clamp( 16.0 * g_screenHeight * self.mrGbMG.hudWidth / ( 9.0 * g_screenWidth ), 0.05, 0.3 )
		if self.mrGbMG.hudWidth + self.mrGbMG.hudPositionX > 1 then
			self.mrGbMG.hudPositionX = 1 - self.mrGbMG.hudWidth
		end
		mrGearboxMogli.noInputWarning = true
	else
		if not( mrGearboxMogli.globalsLoaded ) then
			mrGearboxMogli.globalsLoaded = true
			file = mrGearboxMogli.modsDirectory.."zzzMrGearboxAddonConfig.xml"
			if fileExists(file) then	
				mrGearboxMogli.globalsLoad( file, "vehicles.gearboxMogliGlobals", mrGearboxMogliGlobals )	
			end		
			mrGearboxMogliGlobals.hudWidth = Utils.clamp( 16.0 * g_screenHeight * mrGearboxMogliGlobals.hudWidth / ( 9.0 * g_screenWidth ), 0.05, 0.3 )
			if mrGearboxMogliGlobals.hudWidth + mrGearboxMogliGlobals.hudPositionX > 1 then
				mrGearboxMogliGlobals.hudPositionX = 1 - mrGearboxMogliGlobals.hudWidth
			end
		end	
		
		self.mrGbMG = mrGearboxMogliGlobals
	end
	
--**************************************************************************************************		
	mrGearboxMogli.initClient( self )		
	
	local excludeList = {}
	local default 
	
	if not ( serverAndClient ) then
		if self.mrGbMS ~= nil then
			for n,_ in pairs(self.mrGbMS) do
				excludeList[n] = true
			end	
		end	
	end
	
--**************************************************************************************************	
	self.mrGbMS.ConfigVersion           = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#version" ),1.4)
	self.mrGbMS.NoDisable               = Utils.getNoNil(getXMLBool( xmlFile, xmlString .. "#noDisable" ),self.mrGbMG.noDisable)
	if self.mrGbMS.NoDisable then
		self.mrGbMS.DefaultOn             = true
	else
		self.mrGbMS.DefaultOn             = Utils.getNoNil(getXMLBool( xmlFile, xmlString .. "#defaultOn" ),self.mrGbMG.defaultOn )
	end
	self.mrGbMS.showHud                 = Utils.getNoNil(getXMLBool( xmlFile, xmlString .. "#showHud" ),true)
	self.mrGbMS.drawTargetRpm           = Utils.getNoNil(getXMLBool( xmlFile, xmlString .. "#drawTargetRpm" ),self.mrGbMG.drawTargetRpm)
	self.mrGbMS.SwapGearRangeKeys       = Utils.getNoNil(getXMLBool( xmlFile, xmlString .. "#swapGearRangeKeys" ),false)
	self.mrGbMS.TransmissionEfficiency  = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#transmissionEfficiency"), 0.94) 
	self.mrGbMS.MomentOfInertia         = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#momentOfInertia"), self.mrGbMG.momentOfInertia) 
	
	self.mrGbMS.IdleRpm	                = math.max( Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#idleRpm"),  self.motor.minRpm ), self.motor.minRpm )
	self.mrGbMS.RatedRpm                = math.min( Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#ratedRpm"), math.max( self.motor.maxRpm - mrGearboxMogli.rpmRatedMinus, 2 * self.mrGbMS.IdleRpm ) ), self.motor.maxRpm )
	self.mrGbMS.StallRpm                = math.max( self.mrGbMS.IdleRpm  - mrGearboxMogli.rpmMinus, 0 )
	self.mrGbMS.OrigMinRpm              = self.motor.minRpm
	self.mrGbMS.OrigMaxRpm              = self.motor.maxRpm	
	self.mrGbMS.OrigRatedRpm            = math.max( self.motor.maxRpm - mrGearboxMogli.rpmRatedMinus, 2 * self.mrGbMS.IdleRpm )
	self.mrGbMS.AccelerateToLimit       = 5  -- km/h per second
	self.mrGbMS.DecelerateToLimit       = 10 -- km/h per second
	self.mrGbMS.MinTargetRpm            = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#minTargetRpm"), 0.7 * math.max( 0.475 * self.mrGbMS.RatedRpm, self.mrGbMS.IdleRpm ) + 0.3 * self.mrGbMS.RatedRpm )
	self.mrGbMS.IdleEnrichment          = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#idleEnrichment"), 0.15 )
	
--**************************************************************************************************	
	self.mrGbMS.RpmInSpeedHud           = getXMLBool( xmlFile, xmlString .. "#rpmInSpeedHud")
	self.mrGbMS.MinHudRpm               = getXMLFloat(xmlFile, xmlString .. "#minHudRpm")
	self.mrGbMS.MaxHudRpm               = getXMLFloat(xmlFile, xmlString .. "#maxHudRpm")
--**************************************************************************************************	
	self.mrGbMS.Engine = {}
	self.mrGbMS.Sound  = {}
	self.mrGbMS.Engine.maxTorque = 0;
	self.mrGbMS.Engine.maxTorqueRpm = 0;
	self.mrGbMS.Engine.minRpm = mrGearboxMogli.huge;
	self.mrGbMS.Engine.maxRpm = 0;

	local torqueI = 0;
	local torqueF = nil
	local torqueP = 0
	local realEngineBaseKey = nil
	
	for i=1,3 do
		local key 
		if     i == 1 then
			if self.configurations["motor"] ~= nil then
				key = string.format(xmlString..".engines.engine(%d)", self.configurations["motor"]-1)
			end
		elseif i == 2 then
			key = xmlString..".engines.engine(0)"
		else
			key = xmlString..".realEngine"
		end
		
		if key ~= nil and getXMLFloat(xmlFile, key..".torque(0)#rpm") ~= nil then
			realEngineBaseKey = key
			break
		end
	end

	if realEngineBaseKey ~= nil then
		local s = getXMLString( xmlFile, realEngineBaseKey.."#name" )
		if s ~= nil then
			print("New engine with name "..s)
		end
		
		while true do
			local key = string.format(realEngineBaseKey..".torque(%d)", torqueI);
			local rpm = getXMLFloat(xmlFile, key.."#rpm");
			local torque = getXMLFloat(xmlFile, key.."#motorTorque");
			if torque == nil then
				torque = getXMLFloat(xmlFile, key.."#ptoTorque");
				if torque ~= nil then
					torque = torque / self.mrGbMS.TransmissionEfficiency
				end
			end		

			if torque == nil or rpm == nil then --or fuelUsageRatio==nil then
				break;
			end;
			
			if self.mrGbMS.Engine.torqueValues == nil then
				--print("loading motor with new torque curve")
				self.mrGbMS.Engine.torqueValues = {}
				torqueF = Utils.getNoNil(getXMLFloat(xmlFile, realEngineBaseKey.."#torqueFactor"), self.mrGbMG.torqueFactor) / 1000
			end
			
			torque = torque * torqueF 
		
			self.mrGbMS.Engine.torqueValues[torqueI+1] = {v=torque, time = rpm}
					
			if torque>self.mrGbMS.Engine.maxTorque then
				self.mrGbMS.Engine.maxTorqueRpm = rpm;
				self.mrGbMS.Engine.maxTorque = torque;
			end;
			
			local ecoTorque = getXMLFloat(xmlFile, key.."#motorTorqueEco");
			if ecoTorque == nil then
				ecoTorque = getXMLFloat(xmlFile, key.."#ptoTorqueEco");
				if ecoTorque ~= nil then
					ecoTorque = ecoTorque / self.mrGbMS.TransmissionEfficiency
				end
			end		
			if      ecoTorque ~= nil
					and ( ecoTorque > 0 or self.mrGbMS.Engine.ecoTorqueValues ~= nil ) then
				ecoTorque = ecoTorque * torqueF 
				
				if self.mrGbMS.Engine.ecoTorqueValues == nil then
					self.mrGbMS.Engine.ecoTorqueValues = {}
				end
				table.insert( self.mrGbMS.Engine.ecoTorqueValues, {v=ecoTorque, time = rpm} )
			end
			
			local fuelUsageRatio = getXMLFloat(xmlFile, key.."#fuelUsageRatio");
			if      fuelUsageRatio ~= nil
					and ( fuelUsageRatio > 0 or self.mrGbMS.Engine.fuelUsageValues ~= nil ) then
				if self.mrGbMS.Engine.fuelUsageValues == nil then
					self.mrGbMS.Engine.fuelUsageValues = {}
				end
				table.insert( self.mrGbMS.Engine.fuelUsageValues, {v=fuelUsageRatio, time = rpm} )
			end
			
			if      self.mrGbMS.Engine.maxRpm < rpm 
					and ( torque > 0 or torqueP > 0 ) then
				self.mrGbMS.Engine.maxRpm = rpm
			end
			if      self.mrGbMS.Engine.minRpm > rpm 
					and torque > 0 then
				self.mrGbMS.Engine.minRpm = rpm
			end
			torqueI = torqueI + 1;	
			torqueP = torque
		end

		if torqueI > 0 then
			self.mrGbMS.IdleRpm	  = Utils.getNoNil(getXMLFloat(xmlFile, realEngineBaseKey.."#idleRpm"), 800);
			self.mrGbMS.RatedRpm  = Utils.getNoNil(getXMLFloat(xmlFile, realEngineBaseKey.."#ratedRpm"), 2100);
			self.mrGbMS.StallRpm  = Utils.getNoNil(getXMLFloat(xmlFile, realEngineBaseKey.."#stallRpm"), math.max( self.mrGbMS.IdleRpm  - mrGearboxMogli.rpmMinus, self.mrGbMS.Engine.minRpm ))
		end
		
		self.mrGbMS.BoostMinSpeed = Utils.getNoNil( getXMLFloat(xmlFile, realEngineBaseKey.."#boostMinSpeed"), 30 ) / 3600
	end
		
	if self.mrGbMS.Engine.fuelUsageValues == nil then
		local fuelUsageRatio = getXMLFloat(xmlFile, xmlString.."#minFuelUsageRatio")
		if fuelUsageRatio == nil then
			self.mrGbMS.GlobalFuelUsageRatio = Utils.getNoNil( getXMLFloat(xmlFile, xmlString.."#fuelUsageRatio"), 230 )			
		else
			self.mrGbMS.GlobalFuelUsageRatio = fuelUsageRatio / 0.9
		end
	end
	
	local maxTorque = 0
	
	if torqueI > 0 then
		self.mrGbMS.CurMinRpm = math.max( self.mrGbMS.IdleRpm - mrGearboxMogli.rpmMinus, self.mrGbMS.Engine.minRpm )
		self.mrGbMS.CurMaxRpm = self.mrGbMS.Engine.maxRpm + mrGearboxMogli.rpmPlus
		maxTorque             = self.mrGbMS.Engine.maxTorque
	else
		self.mrGbMS.CurMinRpm = math.max( self.mrGbMS.OrigMinRpm - mrGearboxMogli.rpmMinus, 0 )
		self.mrGbMS.CurMaxRpm = self.mrGbMS.OrigMaxRpm + mrGearboxMogli.rpmPlus
		maxTorque             = self.motor.torqueCurve:getMaximum()
	end
						
	self.mrGbMS.Sound.MaxRpm = getXMLFloat(xmlFile, xmlString .. "#soundMaxRpm")
	if self.mrGbMS.Sound.MaxRpm == nil then
	--local oldRatedRpm       = math.min( math.max( self.mrGbMS.OrigMaxRpm - mrGearboxMogli.rpmMinus, 2 * self.mrGbMS.OrigMinRpm ), self.mrGbMS.OrigMaxRpm )
	--self.mrGbMS.Sound.MaxRpm = self.mrGbMS.RatedRpm * self.mrGbMS.OrigMaxRpm / oldRatedRpm
		self.mrGbMS.Sound.MaxRpm = self.mrGbMS.RatedRpm
	end
	
--**************************************************************************************************	
-- PTO RPM
--**************************************************************************************************		
	self.mrGbMS.PtoRpm                  = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. "#ptoRpm"),    
																												self.mrGbMS.IdleRpm + 50 * math.floor( 0.5 + 0.02 * mrGearboxMogli.ptoRpmFactor * ( self.mrGbMS.RatedRpm - self.mrGbMS.IdleRpm ) ) ) 
	self.mrGbMS.PtoRpmEco               = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. "#ptoRpmEco"),    
																												self.mrGbMS.IdleRpm + 50 * math.floor( 0.5 + 0.02 * mrGearboxMogli.ptoRpmFactorEco * ( self.mrGbMS.RatedRpm - self.mrGbMS.IdleRpm ) ) ) 
	if self.mrGbMS.PtoRpmEco > self.mrGbMS.PtoRpm then
		self.mrGbMS.PtoRpmEco             = self.mrGbMS.PtoRpm
	end
	
	local maxPtoTorqueRatio = 0
	local maxPtoTorqueSpeed = 20

--**************************************************************************************************	
-- combine
--**************************************************************************************************		
	if SpecializationUtil.hasSpecialization(Combine, self.specializations) then	
		self.mrGbMS.IsCombine                    = true
		
		local width  = getXMLFloat(xmlFile, xmlString .. ".combine#defaultWidth") 
		local speed = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. ".combine#defaultSpeed"), self.mrGbMG.combineDefaultSpeed )
		maxPtoTorqueSpeed = 2 * speed 
		local f = 1.36 * self.mrGbMG.torqueFactor / mrGearboxMogli.powerFactor0 * 7 / speed
		local du0, dc0, dci, dp0, dpi = 0, 0, 0, 0, 10.6
		
		if width ~= nil then
			local defaultFruit = getXMLString(xmlFile, xmlString .. ".combine#defaultFruit")			
			local defaultLiterPerSqm = self.mrGbMG.defaultLiterPerSqm
			
			if     defaultFruit == nil
					or defaultFruit == "wheat"  then
				defaultLiterPerSqm = 1.2
			elseif defaultFruit == "barley" then
				defaultLiterPerSqm = 1.1
			elseif defaultFruit == "rape" then
				defaultLiterPerSqm = 0.6
			elseif defaultFruit == "maize" then
				defaultLiterPerSqm = 1.2
			elseif defaultFruit == "potato" then
				defaultLiterPerSqm = 4
			elseif defaultFruit == "sugarBeet" then
				defaultLiterPerSqm = 3.5
			elseif defaultFruit == "grass" then
				defaultLiterPerSqm = 1.2
			elseif defaultFruit == "dryGrass" then
				defaultLiterPerSqm = 1.2
			elseif defaultFruit == "chaff" then
				defaultLiterPerSqm = 3.9
			else
				print('Unknown fruit type: "'..tostring(defaultFruit)..'"' )
			end
			
			defaultLiterPerSqm = defaultLiterPerSqm * self.mrGbMG.defaultLiterPerSqm / 1.2
			
			local factor = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. ".combine#defaultLiterPerSqm"), defaultLiterPerSqm )
			
			if width == nil then
				if     self.combineSize <= 1 then
					width = 3
				elseif self.combineSize <= 2 then
					width = 6
				else
					width = 12
				end
			end		
			
			local dynamicRatio = getXMLFloat(xmlFile, xmlString .. ".combine#dynamicRatio")
			
			if     defaultFruit   == "chaff" 
					or ( defaultFruit == nil and defaultLiterPerSqm > 3 ) then
				if dynamicRatio == nil then
					dynamicRatio = self.mrGbMG.combineDynamicChopper
				end
				du0 = 0
				dc0 = 0
				dci = 0
				dp0 = width * 60 * ( 1 - dynamicRatio )
				dpi = 11.5 * dynamicRatio
			else
				if dynamicRatio == nil then
					dynamicRatio = self.mrGbMG.combineDynamicRatio
				end
				du0 = 6 + width
				dp0 = width * 25 * ( 1 - dynamicRatio )
				dpi = 10 * dynamicRatio
				dc0 = dp0 * 0.06/0.94
				dci = dpi * 0.06/0.94
			end
		end	
	
		if self.mrGbMG.debugPrint then
			print(string.format("combine settings: du0: %4.3f dp0: %4.3f dpi: %3.3f dc0: %4.3f dci: %3.3f", du0, dp0, dpi, dc0, dci ))
		end			
			
		self.mrGbMS.ThreshingMinRpm              = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. ".combine#minRpm")                      , 0.2 * self.mrGbMS.IdleRpm + 0.8 * self.mrGbMS.RatedRpm )
		self.mrGbMS.ThreshingMaxRpm              = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. ".combine#maxRpm")                      , self.mrGbMS.RatedRpm )
		self.mrGbMS.UnloadingPowerConsumption    = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. ".combine#unloadingPowerConsumption")   , du0 ) * f
		
		self.mrGbMS.ThreshingPowerConsumption    = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. ".combine#threshingPowerConsumption")   , dp0 ) * f
		self.mrGbMS.ThreshingPowerConsumptionInc = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. ".combine#threshingPowerConsumptionInc"), dpi ) * f
		self.mrGbMS.ChopperPowerConsumption      = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. ".combine#chopperPowerConsumption")     , dc0 ) * f
		self.mrGbMS.ChopperPowerConsumptionInc   = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. ".combine#chopperPowerConsumptionInc")  , dci ) * f
		
		self.mrGbMS.ThreshingReductionFactor     = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. ".combine#powerReductionFactor")        , 0 ) 
		self.mrGbMS.ThreshingSoundOffset         = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. ".combine#threshingSoundOffset")        , 0.95 ) 
		self.mrGbMS.ThreshingSoundScale          = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. ".combine#threshingSoundScale")         , 0.1 ) 
		
		self.addCutterArea = Utils.appendedFunction(self.addCutterArea, mrGearboxMogli.addCutterArea)
	end
	
--**************************************************************************************************	
-- reduce PTO torque at low speed
--**************************************************************************************************		
	self.mrGbMS.MaxPtoTorqueRatio       = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. "#maxPtoTorqueRatio" ), maxPtoTorqueRatio ) 
	self.mrGbMS.MaxPtoTorqueRatioInc    = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. "#maxPtoTorqueRatioInc" ), ( 1-self.mrGbMS.MaxPtoTorqueRatio ) / maxPtoTorqueSpeed ) 

--**************************************************************************************************	
-- speed limiter
--**************************************************************************************************		
	self.mrGbMS.AutoStartStop           = Utils.getNoNil(getXMLBool( xmlFile, xmlString .. "#autoStartStop"), true)
	self.mrGbMS.MaxSpeedLimiter         = getXMLBool( xmlFile, xmlString .. "#speedLimiter")
	self.mrGbMS.CruiseControlBrake      = Utils.getNoNil(getXMLBool( xmlFile, xmlString .. "#cruiseControlBrake" ), self.mrGbMS.AutoStartStop)
	
	self.mrGbMS.OnlyHandThrottle        = Utils.getNoNil(getXMLBool( xmlFile, xmlString .. "#onlyHandThrottle" ), false)
	self.mrGbMS.MinHandThrottle         = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#minHandThrottle" ), 0.5)
	self.mrGbMS.PtoSpeedLimit	          = Utils.getNoNil(getXMLBool( xmlFile, xmlString .. "#ptoSpeedLimit"), self.mrGbMG.ptoSpeedLimit )
	
	self.mrGbMS.MaxForwardSpeed         = getXMLFloat(xmlFile, xmlString .. "#maxForwardSpeed")
	self.mrGbMS.MaxBackwardSpeed        = getXMLFloat(xmlFile, xmlString .. "#maxBackwardSpeed")
	if self.mrGbMS.MaxSpeedLimiter == nil then
		if     self.mrGbMS.MaxForwardSpeed  ~= nil
				or self.mrGbMS.MaxBackwardSpeed ~= nil then
			self.mrGbMS.MaxSpeedLimiter = true
		else
			self.mrGbMS.MaxSpeedLimiter = self.mrGbMS.AutoStartStop 
		end
	end

	local hasHydrostat = hasXMLProperty(xmlFile, xmlString ..".hydrostatic.efficiency(0)#ratio" ) 
										or hasXMLProperty(xmlFile, xmlString ..".hydrostatic#profile" ) 
	
	self.mrGbMS.AutoShiftUpRpm        = getXMLFloat(xmlFile, xmlString .. ".gears#autoUpRpm") 
	self.mrGbMS.AutoShiftDownRpm      = getXMLFloat(xmlFile, xmlString .. ".gears#autoDownRpm") 
	self.mrGbMS.AutoShiftRpmReduction = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. ".gears#autoRpmReduction"), (1-mrGearboxMogli.rpmReduction) * self.mrGbMS.RatedRpm )
	self.mrGbMS.AutoShiftHl           = Utils.getNoNil(getXMLBool(xmlFile, xmlString .. ".ranges(0)#automatic"), false )
	self.mrGbMS.AutoShiftGears        = Utils.getNoNil(getXMLBool(xmlFile, xmlString .. ".gears#automatic"), (self.mrGbMS.AutoShiftUpRpm ~= nil) )
	if self.mrGbMS.AutoShiftGears then
		self.mrGbMS.DisableManual       = Utils.getNoNil(getXMLBool( xmlFile, xmlString .. "#disableManual" ), self.mrGbMG.disableManual or hasHydrostat )
	else                             
		self.mrGbMS.DisableManual       = false
	end
		
--**************************************************************************************************	
-- Clutch parameter
--**************************************************************************************************		
	self.mrGbMS.TorqueConverter         = getXMLBool( xmlFile, xmlString .. "#torqueConverter" )	
	self.mrGbMS.MaxClutchPercent        = getXMLFloat(xmlFile, xmlString .. "#maxClutchRatio")
	
	if self.mrGbMS.TorqueConverter == nil and self.mrGbMS.MaxClutchPercent == nil then
		self.mrGbMS.TorqueConverter    = false
		self.mrGbMS.MaxClutchPercent   = 1
	elseif self.mrGbMS.MaxClutchPercent == nil then
		if self.mrGbMS.TorqueConverter then
			self.mrGbMS.MaxClutchPercent = 0.9
		else
			self.mrGbMS.MaxClutchPercent = 1
		end
	elseif self.mrGbMS.TorqueConverter == nil then
		self.mrGbMS.TorqueConverter    = ( self.mrGbMS.MaxClutchPercent < 0.99 )		
	end
	
	if self.mrGbMS.MaxClutchPercent > 1 then 
		self.mrGbMS.MaxClutchPercent   = 1 
	end	
	
	self.mrGbMS.TorqueConverterOrHydro  = false
	if self.mrGbMS.TorqueConverter then
		self.mrGbMS.TorqueConverterOrHydro = true
	elseif hasHydrostat then
		self.mrGbMS.TorqueConverterOrHydro = true
	end

	self.mrGbMS.TorqueConverterLossExp  = getXMLFloat(xmlFile, xmlString .. "#torqueConverterLossExponent")
	
	if self.mrGbMS.TorqueConverterLossExp == nil and self.mrGbMS.TorqueConverterOrHydro then 
		self.mrGbMS.TorqueConverterLossExp = 3 
	end		
	
	default = self.mrGbMS.IdleRpm+0.2*(self.mrGbMS.RatedRpm-self.mrGbMS.IdleRpm)
	if self.mrGbMS.TorqueConverter then 
		default = mrGearboxMogli.huge --self.mrGbMS.CurMaxRpm
	end
	self.mrGbMS.CloseRpm                = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#clutchCloseRpm"), default )
	
	default = self.mrGbMS.StallRpm-1 -- no automatic opening of clutch by default!!!
	if self.mrGbMS.TorqueConverter then 
		default = math.min( self.mrGbMS.CloseRpm, self.mrGbMS.RatedRpm )
	end
	self.mrGbMS.OpenRpm                 = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#clutchOpenRpm"), default )
	self.mrGbMS.ClutchMaxTargetRpm      = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#clutchMaxTargetRpm"), math.min( self.mrGbMS.RatedRpm, self.mrGbMS.CloseRpm + 0.1 * self.mrGbMS.RatedRpm ) )
	
	local clutchEngagingTimeMs          = getXMLFloat(xmlFile, xmlString .. "#clutchEngagingTimeMs")
	local clutchTimeManualDefault      
	if clutchEngagingTimeMs == nil then
		if     hasHydrostat then
			clutchEngagingTimeMs = 1
		elseif self.mrGbMS.TorqueConverter then
			clutchEngagingTimeMs = 100
		elseif getXMLBool(xmlFile, xmlString .. ".gears#automatic") then
			clutchEngagingTimeMs = 500
		else
			clutchEngagingTimeMs = 1000 -- 1000 = 1s
		end
	end
	
	self.mrGbMS.TorqueConverterLockupMs = getXMLFloat(xmlFile, xmlString .. "#torqueConverterLockupMs")
	if      self.mrGbMS.TorqueConverter 
			and self.mrGbMS.CloseRpm < self.mrGbMS.RatedRpm 
			and self.mrGbMS.TorqueConverterLockupMs == nil then
		self.mrGbMS.TorqueConverterLockupMs = 1000
	end		
	
	self.mrGbMS.MinClutchPercent        = getXMLFloat(xmlFile, xmlString .. "#minClutchRatio")
	if     self.mrGbMS.MinClutchPercent == nil then 
		if      self.mrGbMS.TorqueConverter 
				and self.mrGbMS.TorqueConverterLockupMs ~= nil
				and self.mrGbMS.TorqueConverterLockupMs >= 0 then
			self.mrGbMS.MinClutchPercent    = mrGearboxMogli.minClutchPercentTCL
		elseif self.mrGbMS.TorqueConverterOrHydro then
			self.mrGbMS.MinClutchPercent    = mrGearboxMogli.minClutchPercentTC
		else
			self.mrGbMS.MinClutchPercent    = mrGearboxMogli.minClutchPercentStd 
		end
	end
	if self.mrGbMS.MinClutchPercent < 2 * mrGearboxMogli.minClutchPercent then 
		self.mrGbMS.MinClutchPercent      = 2 * mrGearboxMogli.minClutchPercent 
	end	
	
	if self.mrGbMS.TorqueConverter then
		self.mrGbMS.TorqueConverterFactor = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#torqueConverterMaxFactor"),3)
	end
		
	self.mrGbMS.ClutchTimeInc           = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#clutchTimeIncreaseMs"), clutchEngagingTimeMs )
	self.mrGbMS.ClutchTimeDec           = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#clutchTimeDecreaseMs"), 0.50 * clutchEngagingTimeMs ) 		
	self.mrGbMS.ClutchShiftTime         = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#clutchShiftingTimeMs"), 0.25 * self.mrGbMS.ClutchTimeDec) 
	self.mrGbMS.ClutchTimeManual        = math.max( Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#clutchTimeManualMs"), self.mrGbMG.minClutchTimeManual ), self.mrGbMS.ClutchTimeInc )
	self.mrGbMS.ClutchCanOverheat       = Utils.getNoNil(getXMLBool( xmlFile, xmlString .. "#clutchCanOverheat"), not self.mrGbMS.TorqueConverterOrHydro ) 
	self.mrGbMS.ClutchOverheatStartTime = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#clutchOverheatStartTimeMs"), 5000 ) 
	self.mrGbMS.ClutchOverheatIncTime   = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#clutchOverheatIncTimeMs"), 5000 ) 
	self.mrGbMS.ClutchOverheatMaxTime   = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#clutchOverheatIncTimeMs"), 25000 ) 
	
	local alwaysDoubleClutch            = Utils.getNoNil(getXMLBool(xmlFile, xmlString .. "#doubleClutch"), false) 
	self.mrGbMS.GearsDoubleClutch       = Utils.getNoNil(getXMLBool(xmlFile, xmlString .. ".gears#doubleClutch"), alwaysDoubleClutch) 
	self.mrGbMS.Range1DoubleClutch      = Utils.getNoNil(getXMLBool(xmlFile, xmlString .. ".ranges(0)#doubleClutch"), alwaysDoubleClutch) 
	self.mrGbMS.Range2DoubleClutch      = Utils.getNoNil(getXMLBool(xmlFile, xmlString .. ".ranges(1)#doubleClutch"), alwaysDoubleClutch) 
	self.mrGbMS.ReverseDoubleClutch     = Utils.getNoNil(getXMLBool(xmlFile, xmlString .. ".reverse#doubleClutch"), alwaysDoubleClutch) 
	
	self.mrGbMS.GearTimeToShiftGear     = mrGearboxMogli.getNoNil2(getXMLFloat(xmlFile, xmlString .. ".gears#shiftTimeMs"), 750, -1, hasHydrostat and self.mrGbMS.DisableManual )
	self.mrGbMS.GearShiftEffectGear     = Utils.getNoNil(getXMLBool( xmlFile, xmlString .. ".gears#shiftEffect"),     self.mrGbMS.GearTimeToShiftGear < self.mrGbMG.shiftEffectTime )
	self.mrGbMS.GearTimeToShiftHl       = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. ".ranges(0)#shiftTimeMs"),  900 ) 
	self.mrGbMS.GearShiftEffectHl       = Utils.getNoNil(getXMLBool( xmlFile, xmlString .. ".ranges(0)#shiftEffect"), self.mrGbMS.GearTimeToShiftHl < self.mrGbMG.shiftEffectTime )
	self.mrGbMS.GearTimeToShiftRanges2  = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. ".ranges(1)#shiftTimeMs"), 1200 ) 
	self.mrGbMS.GearShiftEffectRanges2  = Utils.getNoNil(getXMLBool( xmlFile, xmlString .. ".ranges(1)#shiftEffect"), self.mrGbMS.GearTimeToShiftRanges2 < self.mrGbMG.shiftEffectTime )
	self.mrGbMS.GearTimeToShiftReverse  = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. ".reverse#shiftTimeMs"),    700 ) 

	self.mrGbMS.GearTimeToShiftGear     = self.mrGbMS.GearTimeToShiftGear    * self.mrGbMG.shiftTimeMsFactor
	self.mrGbMS.GearTimeToShiftHl       = self.mrGbMS.GearTimeToShiftHl      * self.mrGbMG.shiftTimeMsFactor
	self.mrGbMS.GearTimeToShiftRanges2  = self.mrGbMS.GearTimeToShiftRanges2 * self.mrGbMG.shiftTimeMsFactor
	
	local default = self.mrGbMS.MinClutchPercent
	if self.mrGbMS.TorqueConverter then
		default = -1
	elseif hasHydrostat then
		default = 1
	end
	
	self.mrGbMS.ClutchAfterShiftGear    = mrGearboxMogli.getNoNil2(getXMLFloat(xmlFile, xmlString .. ".gears#clutchRatio"),     default, 1, self.mrGbMS.GearShiftEffectGear ) 
	self.mrGbMS.ClutchAfterShiftHl      = mrGearboxMogli.getNoNil2(getXMLFloat(xmlFile, xmlString .. ".ranges(0)#clutchRatio"), default, 1, self.mrGbMS.GearShiftEffectHl ) 
	self.mrGbMS.ClutchAfterShiftRanges2 = mrGearboxMogli.getNoNil2(getXMLFloat(xmlFile, xmlString .. ".ranges(1)#clutchRatio"), default, 1, self.mrGbMS.GearShiftEffectRanges2 ) 
	self.mrGbMS.ClutchAfterShiftReverse = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. ".reverse#clutchRatio"), default )

	self.mrGbMS.ManualClutchGear      	= Utils.getNoNil(getXMLBool( xmlFile, xmlString .. ".gears#manualClutch"),     self.mrGbMS.ClutchAfterShiftGear + 0.1 <= self.mrGbMS.MaxClutchPercent )
	self.mrGbMS.ManualClutchHl        	= Utils.getNoNil(getXMLBool( xmlFile, xmlString .. ".ranges(0)#manualClutch"), self.mrGbMS.ClutchAfterShiftHl + 0.1 <= self.mrGbMS.MaxClutchPercent ) 
	self.mrGbMS.ManualClutchRanges2   	= Utils.getNoNil(getXMLBool( xmlFile, xmlString .. ".ranges(1)#manualClutch"), self.mrGbMS.ClutchAfterShiftRanges2 + 0.1 <= self.mrGbMS.MaxClutchPercent ) 
	self.mrGbMS.ManualClutchReverse   	= Utils.getNoNil(getXMLBool( xmlFile, xmlString .. ".reverse#manualClutch"),   self.mrGbMS.ClutchAfterShiftReverse + 0.1 <= self.mrGbMS.MaxClutchPercent )
		
	self.mrGbMS.RealMotorBrakeFx        = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#motorBrakeFx"), self.motor.lowBrakeForceScale ) --0.1 )
	self.mrGbMS.GlobalRatioFactor       = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#globalRatioFactor"), 1 ) --1.025 )

	local revUpMs0                      = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. "#revUpMs"),  self.mrGbMG.DefaultRevUpMs0 ) 
	local f                             = revUpMs0 /  math.max(1,self.mrGbMG.DefaultRevUpMs0)
	local revUpMs1                      = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. "#revUpMsFullLoad"),  self.mrGbMG.DefaultRevUpMs1 * f ) 
	local revDownMs                     = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. "#revDownMs"), self.mrGbMG.DefaultRevDownMs * f ) 
	self.mrGbMS.RpmIncFactor            = ( self.mrGbMS.RatedRpm - self.mrGbMS.IdleRpm ) / math.max( 1, revUpMs0 )
	self.mrGbMS.RpmIncFactorFull        = ( self.mrGbMS.RatedRpm - self.mrGbMS.IdleRpm ) / math.max( 1, revUpMs1 )
	self.mrGbMS.RpmDecFactor            = ( self.mrGbMS.RatedRpm - self.mrGbMS.IdleRpm ) / math.max( 1, revDownMs )
	
--**************************************************************************************************	
-- Sound parameter
--**************************************************************************************************		
	self.mrGbMS.IdlePitchFactor         = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#idlePitchFactor"), -1 )
	self.mrGbMS.IdlePitchMax            = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#idlePitchMax"), -1 )
	self.mrGbMS.RunPitchFactor          = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#runPitchFactor"), -1 )
	self.mrGbMS.RunPitchMax             = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. "#runPitchMax"), -1 )
	self.mrGbMS.Run2PitchEffect         = getXMLFloat(xmlFile, xmlString .. "#run2PitchEffect" )
		
	if xmlSource == "vehicle" then
		self.mrGbMS.BlowOffVentilFile     = getXMLString( xmlFile, xmlString.. ".blowOffVentilSound#file" )
		self.mrGbMS.BlowOffVentilVolume   = Utils.getNoNil( getXMLFloat( xmlFile, xmlString.. ".blowOffVentilSound#volume" ), 1 )
		self.mrGbMS.GrindingSoundFile     = getXMLString( xmlFile, xmlString.. ".grindingGearsSound#file" )
		self.mrGbMS.GrindingSoundVolume   = Utils.getNoNil( getXMLFloat( xmlFile, xmlString.. ".grindingGearsSound#volume" ), 1 )
	else
		self.mrGbMS.BlowOffVentilFile     = nil
		self.mrGbMS.BlowOffVentilVolume   = 0
		self.mrGbMS.GrindingSoundFile     = nil
		self.mrGbMS.GrindingSoundVolume   = 0
	end	

	if self.mrGbMS.BlowOffVentilFile == nil then
	-- no autoStartStop => old vehicle => louder blow off ventil sound
		if xmlSource == "vehicle" then
			self.mrGbMS.BlowOffVentilVolume = 0
		else
			if self.mrGbMS.AutoStartStop then
				default = 1.4
			else
				default = 2
			end
			self.mrGbMS.BlowOffVentilVolume = Utils.getNoNil( getXMLFloat( xmlFile, xmlString.. ".blowOffVentilSound#volume" ), default ) * self.mrGbMG.blowOffVentilVol
		end
	else
		self.mrGbMS.BlowOffVentilFile = Utils.getFilename( self.mrGbMS.BlowOffVentilFile, self.baseDirectory )
	end
		
	if self.mrGbMS.GrindingSoundFile == nil then
		if xmlSource == "vehicle" then
			self.mrGbMS.GrindingSoundVolume = 0
		else
			self.mrGbMS.GrindingSoundVolume = Utils.getNoNil( getXMLFloat( xmlFile, xmlString.. ".grindingGearsSound#volume" ), 1.5 )
		end
	else
		self.mrGbMS.GrindingSoundFile = Utils.getFilename( self.mrGbMS.GrindingSoundFile, self.baseDirectory )
	end
		
--**************************************************************************************************	
-- Gears, Ranges, Reverse, ...
--**************************************************************************************************		
	local reverseMinGear  = getXMLInt(xmlFile, xmlString .. ".reverse#minGear")
	local reverseMaxGear  = getXMLInt(xmlFile, xmlString .. ".reverse#maxGear")
	local reverseMinRange = getXMLInt(xmlFile, xmlString .. ".reverse#minRange")
	local reverseMaxRange = getXMLInt(xmlFile, xmlString .. ".reverse#maxRange")
	local rangeGearOffset = Utils.getNoNil(getXMLInt(xmlFile, xmlString .. ".ranges(0)#gearOffset"), 0) 
	local gearRangeOffset = Utils.getNoNil(getXMLInt(xmlFile, xmlString .. ".gears#rangeOffset"), 0) 
	local minRatio        = 0.6
	local prevSpeed, gearTireRevPerKm, gearInvRadiusAxleSpeed
	self.mrGbMS.Gears     = {} 
	
	local i = 0 
	while true do
		local baseName = xmlString .. string.format(".gears.gear(%d)", i) 		
		local speed    = getXMLFloat(xmlFile, baseName .. "#speed") 
		
		if speed==nil then
			local invRatio = getXMLFloat(xmlFile, baseName .. "#inverseRatio") 
			
			if invRatio ~= nil then
				if gearTireRevPerKm == nil then
					local radius = getXMLFloat(xmlFile, xmlString .. ".gears#wheelRadius" )
					if radius == nil then
						local w = getXMLFloat(xmlFile, xmlString .. ".gears#tireWidth" )
						local r = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. ".gears#tireRatio" ), 80 )
						local d = getXMLFloat(xmlFile, xmlString .. ".gears#rimDiameter" )
						if w ~= nil and d ~= nil then
							-- w is in mm
							-- r is in %
							-- d is in inch
							radius = w * r * 0.00001 + 0.0127 * d
						end
					end
					if radius == nil then
						radius = self.wheels[1].radius
					end
					gearTireRevPerKm = 1000 / ( 2 * math.pi * radius )
				end
				
				if gearInvRadiusAxleSpeed == nil then
					gearInvRadiusAxleSpeed = getXMLFloat(xmlFile, xmlString .. ".gears#axleSpeed" )
					if gearInvRadiusAxleSpeed == nil then
						gearInvRadiusAxleSpeed = self.mrGbMS.RatedRpm * 60 / ( 3.6 * self.motor.maxForwardSpeed * gearTireRevPerKm )
					end
				end
				
				speed = self.mrGbMS.RatedRpm * 60 / ( gearInvRadiusAxleSpeed * gearTireRevPerKm * invRatio )
			end
		end
		
		if speed==nil then
			local maxRatio = getXMLFloat(xmlFile, baseName .. "#maxForwardSpeedRatio") 
			if maxRatio ~= nil then
				speed = 3.6 * maxRatio * self.motor.maxForwardSpeed / self.mrGbMS.GlobalRatioFactor
			end
		end
		
		if speed==nil then
			break 
		end 
		
		local atRpm = getXMLFloat(xmlFile, baseName .. "#atRpm") 
		if atRpm ~= nil and atRpm > 0 then
			speed = speed * self.mrGbMS.RatedRpm / atRpm 
		end
		
		i = i + 1 
		local name  = Utils.getNoNil(getXMLString(xmlFile, baseName .. "#name"), tostring(i)) 

		local fwdOnly = getXMLBool(xmlFile, baseName .. "#forwardOnly" )
		if fwdOnly == nil then
			fwdOnly = not ( ( reverseMinGear == nil or i >= reverseMinGear )
									and ( reverseMaxGear == nil or i <= reverseMaxGear ) )
		end		

		local newEntry = mrGearboxMogli.completeXMLGearboxEntry( xmlFile, baseName, {speed=speed/3.6,name=name} )
		
		newEntry.upRangeOffset   = Utils.getNoNil( getXMLInt( xmlFile, baseName .. "#upRangeOffset" ),  -gearRangeOffset ) 
		newEntry.downRangeOffset = Utils.getNoNil( getXMLInt( xmlFile, baseName .. "#downRangeOffset" ), gearRangeOffset ) 
		
		table.insert(self.mrGbMS.Gears, newEntry)  -- m/s
		
		if not ( newEntry.reverseOnly ) then
			if prevSpeed ~= nil then
				local m = prevSpeed / speed 
				if minRatio > m then
					minRatio = m
				end
			end
			prevSpeed = speed 
		end
	end
	
	if i==0 then
		local newEntry = {speed=self.motor.maxForwardSpeed/self.mrGbMS.GlobalRatioFactor,name=""} 
		table.insert(self.mrGbMS.Gears, newEntry)  -- m/s
	end 	
			
	self.mrGbMS.Ranges = {} 
	i = 0 
	local generateNames = true 
	while true do
		local baseName = xmlString .. string.format(".ranges(0).range(%d)", i) 		
		local ratio = getXMLFloat(xmlFile, baseName .. "#ratio") 
		if ratio==nil then
			local g = Utils.getNoNil( getXMLInt(xmlFile, baseName .. "#gear") , table.getn(self.mrGbMS.Gears) )
			local s = getXMLFloat(xmlFile, baseName .. "#speed") 
			if s ~= nil and self.mrGbMS.Gears[g] ~= nil then
				ratio = s / (3.6*self.mrGbMS.Gears[g].speed)
			end
		end 
		if ratio==nil then
			local invRatio = getXMLFloat(xmlFile, baseName .. "#inverseRatio") 
			if invRatio ~= nil then
				ratio=1/invRatio
			end
		end
		if ratio==nil then
			break 
		end 
		i = i + 1 
		
		local name = getXMLString(xmlFile, baseName .. "#name") 
		if name == nil then
			name = tostring(i) 
		else
			generateNames = false 
		end
		
		local newEntry = mrGearboxMogli.completeXMLGearboxEntry( xmlFile, baseName, {ratio=ratio,name=name} )
		
		newEntry.upGearOffset   = Utils.getNoNil( getXMLInt( xmlFile, baseName .. "#upGearOffset" ),  -rangeGearOffset ) 
		newEntry.downGearOffset = Utils.getNoNil( getXMLInt( xmlFile, baseName .. "#downGearOffset" ), rangeGearOffset ) 

		if      fwdOnly == nil
				and not ( ( reverseMinRange == nil or i >= reverseMinRange )
							and ( reverseMaxRange == nil or i <= reverseMaxRange ) ) then
			newEntry.forwardOnly = true
		end		
		
		table.insert(self.mrGbMS.Ranges, newEntry)  -- m/s
	end 
	
	if i==0 then
		local newEntry = {ratio=1,name=""} 
		table.insert(self.mrGbMS.Ranges, newEntry)  -- m/s
		generateNames = false
	end
	
	if generateNames then
		local fwd,rev=0,0
		for _,newRange in pairs( self.mrGbMS.Ranges ) do
			if     newRange.forwardOnly then
				fwd = fwd + 1
			elseif newRange.reverseOnly then
				rev = rev + 1
			else
				fwd = fwd + 1
				rev = rev + 1
			end
		end
		
		local fwd2,rev2=0,0

		for _,newRange in pairs( self.mrGbMS.Ranges ) do
			local isFwd,isRev=true,true
			if     newRange.forwardOnly then
				fwd2 = fwd2 + 1
				isRev = false
			elseif newRange.reverseOnly then
				rev2 = rev2 + 1
				isFwd = false
			else
				fwd2 = fwd2 + 1
				rev2 = rev2 + 1
			end
			if     isFwd then
				if     fwd == 1 then
					newRange.name = ""
				elseif fwd == 2 then
					if fwd2 == 1 then
						newRange.name = "L"
					else
						newRange.name = "H"
					end
				elseif fwd == 3 then
					if     fwd2 == 1 then
						newRange.name = "L"
					elseif fwd2 == 2 then
						newRange.name = "M"
					else
						newRange.name = "H"
					end
				elseif fwd == 4 then
					if     fwd2 == 1 then
						newRange.name = "S"
					elseif fwd2 == 2 then
						newRange.name = "L"
					elseif fwd2 == 3 then
						newRange.name = "M"
					else
						newRange.name = "H"
					end
				else
					newRange.name = "G"..tostring(fwd2)
				end
			elseif isRev then
				if rev==1 then
					newRange.name = "R"
				else
					newRange.name = "R"..tostring(rev2)
				end			
			end
		end		
	end
	
	self.mrGbMS.Ranges2 = {} 
	i = 0 
	while true do
		local baseName = xmlString .. string.format(".ranges(1).range(%d)", i) 		
		local ratio = getXMLFloat(xmlFile, baseName .. "#ratio") 
		if ratio==nil then
			local g = Utils.getNoNil( getXMLInt(xmlFile, baseName .. "#gear") , table.getn(self.mrGbMS.Gears) )
			local s = getXMLFloat(xmlFile, baseName .. "#speed") 
			if s ~= nil and self.mrGbMS.Gears[g] ~= nil then
				ratio = s / (3.6*self.mrGbMS.Gears[g].speed)
			end
		end 
		if ratio==nil then
			break 
		end 
		i = i + 1 
		
		local name = getXMLString(xmlFile, baseName .. "#name") 
		if name == nil then
			name = "G"..tostring(i) 
		end
		local newEntry = mrGearboxMogli.completeXMLGearboxEntry( xmlFile, baseName, {ratio=ratio,name=name} )
		
		table.insert(self.mrGbMS.Ranges2, newEntry)  -- m/s
	end 
	
	if i==0 then
		local newEntry = {ratio=1,name=""} 
		table.insert(self.mrGbMS.Ranges2, newEntry)  -- m/s
	end
		
	self.mrGbMS.ReverseRatio            = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. ".reverse#ratio"), 1) 
	
	self.mrGbMS.ReverseResetGear        = false 
	if getXMLBool(xmlFile, xmlString .. ".reverse#resetGear") or getXMLBool(xmlFile, xmlString .. ".gears#reverseReset") then
		self.mrGbMS.ReverseResetGear      = true 
	end
	self.mrGbMS.ReverseResetRange       = false 
	if getXMLBool(xmlFile, xmlString .. ".reverse#resetRange") or getXMLBool(xmlFile, xmlString .. ".ranges(0)#reverseReset") then
		self.mrGbMS.ReverseResetRange     = true
	end
	self.mrGbMS.ReverseResetRange2      = false
	if getXMLBool(xmlFile, xmlString .. ".ranges(1)#reverseReset") then
		self.mrGbMS.ReverseResetRange2    = true
	end
	
	local hasDefaultGear = true
	self.mrGbMS.DefaultGear        = getXMLInt(xmlFile, xmlString .. ".gears#defaultGear")
	if     self.mrGbMS.DefaultGear == nil
			or self.mrGbMS.DefaultGear  < 1 then
		self.mrGbMS.DefaultGear = 1
		hasDefaultGear          = false
	elseif self.mrGbMS.DefaultGear  > table.getn(self.mrGbMS.Gears) then
		self.mrGbMS.DefaultGear = table.getn(self.mrGbMS.Gears)
		hasDefaultGear          = false
	end
	if hasHydrostat and not hasDefaultGear then
		hasDefaultGear = true
		if self.mrGbMS.DisableManual then
			self.mrGbMS.DefaultGear = 1
		else
			self.mrGbMS.DefaultGear = table.getn(self.mrGbMS.Gears)
		end
	end
	
	self.mrGbMS.LaunchGear         = self.mrGbMS.DefaultGear
	
 	self.mrGbMS.DefaultRange       = getXMLInt(xmlFile, xmlString .. ".ranges(0)#defaultRange")
	if     self.mrGbMS.DefaultRange == nil
			or self.mrGbMS.DefaultRange  > table.getn(self.mrGbMS.Ranges) then
		self.mrGbMS.DefaultRange     = table.getn(self.mrGbMS.Ranges)
	elseif self.mrGbMS.DefaultRange  < 1 then
		self.mrGbMS.DefaultRange     = 1
	end
	self.mrGbMS.LaunchRange        = self.mrGbMS.DefaultRange
	
	self.mrGbMS.DefaultRange2      = Utils.getNoNil(getXMLInt(xmlFile, xmlString .. ".ranges(1)#defaultRange"), table.getn(self.mrGbMS.Ranges2)) 
	if     self.mrGbMS.DefaultRange2 == nil
			or self.mrGbMS.DefaultRange2  > table.getn(self.mrGbMS.Ranges2) then
		self.mrGbMS.DefaultRange2    = table.getn(self.mrGbMS.Ranges2)
	elseif self.mrGbMS.DefaultRange2  < 1 then
		self.mrGbMS.DefaultRange2    = 1
	end
	self.mrGbMS.LaunchRange2       = self.mrGbMS.DefaultRange2
	
	local defaultLaunchSpeed       = 20
	
	if hasDefaultGear then
		defaultLaunchSpeed           = self.mrGbMS.Gears[self.mrGbMS.LaunchGear].speed
																 * self.mrGbMS.Ranges[self.mrGbMS.LaunchRange].ratio
																 * self.mrGbMS.Ranges2[self.mrGbMS.LaunchRange2].ratio
																 * self.mrGbMS.GlobalRatioFactor
																 * 3.6
  end	
	if hasHydrostat then
		defaultLaunchSpeed           = 3.6
	end
	self.mrGbMS.LaunchGearSpeed    = Utils.getNoNil(getXMLInt(xmlFile, xmlString .. "#launchGearSpeed"), defaultLaunchSpeed ) / 3.6
	if not hasDefaultGear then
		local r = self.mrGbMS.Ranges[self.mrGbMS.LaunchRange].ratio
						* self.mrGbMS.Ranges2[self.mrGbMS.LaunchRange2].ratio
						* self.mrGbMS.GlobalRatioFactor
						* 3.6
		local d = nil
		for i,g in pairs(self.mrGbMS.Gears) do
			if not ( g.reverseOnly ) then
				local s = math.abs( r * g.speed - self.mrGbMS.LaunchGearSpeed )
				if d == nil or d > s then
					self.mrGbMS.LaunchGear = i
					d = s
				end
			end
		end
	end
		
	-- start with 7 km/h with "drueckung" 15% => 8 km/h
	self.mrGbMS.LaunchPtoSpeed     = Utils.getNoNil(getXMLInt(xmlFile, xmlString .. "#ptolaunchSpeed"), 8 ) / 3.6 
	self.mrGbMS.MatchRanges        = getXMLString(xmlFile, xmlString .. ".ranges(0)#speedMatching")
  self.mrGbMS.MatchGears         = getXMLString(xmlFile, xmlString .. ".gears#speedMatching")
	
	if      self.mrGbMS.MatchRanges == nil 
			and self.mrGbMS.MatchGears  == nil then
		if      self.mrGbMS.AutoShiftGears
				and self.mrGbMS.AutoShiftHl then
			-- gears and ranges are already shifted automatic
			self.mrGbMS.MatchGears  = "false"
			self.mrGbMS.MatchRanges = "false"
		elseif  self.mrGbMS.GearShiftEffectGear then
			-- default speed matching for power shift 
			self.mrGbMS.MatchGears  = "true"
			self.mrGbMS.MatchRanges = "false"
		elseif  self.mrGbMS.GearShiftEffectHl   then
			-- default speed matching for power shift 
			self.mrGbMS.MatchGears  = "false"
			self.mrGbMS.MatchRanges = "true"
		elseif  self.mrGbMS.AutoShiftGears then
			-- find best gear (automatic)
			self.mrGbMS.MatchGears  = "true"
			self.mrGbMS.MatchRanges = "false"
		elseif  self.mrGbMS.AutoShiftHl then
			-- find best range (automatic)
			self.mrGbMS.MatchGears  = "false"
			self.mrGbMS.MatchRanges = "true"
		else
			local r1,rp,rl, g1,gp,gl
			for _,r in pairs(self.mrGbMS.Ranges) do
				if not ( r.reverseOnly ) then
					if r1 == nil then
						r1 = r.ratio
						rp = r.ratio 
						rl = r.ratio 
					end
					if r1 > r.ratio then
						r1 = r.ratio 
					end 
					if rl < r.ratio then
						rp = rl
						rl = r.ratio 
					elseif rl > r.ratio and r.ratio > rp then
						rp = r.ratio
					end
				end
			end
			for _,g in pairs(self.mrGbMS.Gears) do
				if not ( g.reverseOnly ) then
					if g1 == nil then
						g1 = g.speed
						gp = g.speed 
						gl = g.speed 
					end
					if g1 > g.speed then
						g1 = g.speed 
					end 
					if gl < g.speed then
						gp = gl
						gl = g.speed 
					elseif gl > g.speed and g.speed > gp then
						gp = g.speed 
					end
				end
			end
			
			if     r1 == nil 
					or g1 == nil 
					or r1 == rl
					or g1 == gl then
				-- not more than one gear and more than one range
				self.mrGbMS.MatchRanges = "false"
				self.mrGbMS.MatchGears  = "false"
			elseif rp * gl < rl * g1 then
				-- 2nd last range in last gear is smaller then last range in 1st gear
				self.mrGbMS.MatchRanges = "false"
				self.mrGbMS.MatchGears  = "true"
			elseif self.mrGbMS.SwapGearRangeKeys then
				-- gears and ranges are swapped 
				self.mrGbMS.MatchRanges = "end"
				self.mrGbMS.MatchGears  = "false"
			else 
				self.mrGbMS.MatchRanges = "false"
				self.mrGbMS.MatchGears  = "end"
			end
		end
	elseif  self.mrGbMS.MatchRanges == nil then
		self.mrGbMS.MatchRanges = "false"
	elseif  self.mrGbMS.MatchGears  == nil then
		self.mrGbMS.MatchGears  = "false"
	end
	
--**************************************************************************************************	
-- Hydrostatic
--**************************************************************************************************			
	i = 0 
	while true do
		local baseName = xmlString .. string.format(".hydrostatic.efficiency(%d)", i) 		
		local ratio    = getXMLFloat(xmlFile, baseName .. "#ratio") 
		local factor   = getXMLFloat(xmlFile, baseName .. "#factor") 
		if ratio==nil or factor == nil then
			break 
		end 
		i = i + 1 
		
		self.mrGbMS.HydrostaticMax = ratio
		if self.mrGbMS.HydrostaticEfficiency == nil then
			self.mrGbMS.HydrostaticMin         = ratio
			self.mrGbMS.TransmissionEfficiency = factor		
			self.mrGbMS.HydrostaticEfficiency  = {}
		elseif self.mrGbMS.TransmissionEfficiency < factor then
			self.mrGbMS.TransmissionEfficiency = factor
		end
		
		table.insert(self.mrGbMS.HydrostaticEfficiency, {time=ratio,v=factor})  
	end 

	self.mrGbMS.HydrostaticVolumePump     = getXMLFloat(xmlFile, xmlString .. ".hydrostatic#volumePump")
	self.mrGbMS.HydrostaticVolumeMotor    = getXMLFloat(xmlFile, xmlString .. ".hydrostatic#volumeMotor")
	self.mrGbMS.HydrostaticPressure       = getXMLFloat(xmlFile, xmlString .. ".hydrostatic#pressure")
	self.mrGbMS.HydrostaticCoupling       = getXMLString(xmlFile,xmlString .. ".hydrostatic#coupling")
	self.mrGbMS.HydrostaticMaxTorque      = getXMLFloat(xmlFile, xmlString .. ".hydrostatic#maxTorque")

	if i <= 0 then
		self.mrGbMS.HydrostaticProfile = getXMLString(xmlFile, xmlString .. ".hydrostatic#profile")
	  
		if self.mrGbMS.HydrostaticProfile == nil then
			-- nothing 
		elseif self.mrGbMS.HydrostaticProfile == "ZF" then
			self.mrGbMS.HydrostaticMin = 0
			self.mrGbMS.HydrostaticMax = 1.333333333
			self.mrGbMS.TransmissionEfficiency = 0.98
			self.mrGbMS.HydrostaticEfficiency  = {}
			
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=0.00,v=0.600})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=0.22,v=0.680})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=0.67,v=0.870})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=0.80,v=0.930})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=0.90,v=0.970})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=0.95,v=0.978})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=1.00,v=0.980})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=1.04,v=0.970})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=1.10,v=0.945})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=1.20,v=0.920})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=1.33,v=0.890})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=1.50,v=0.860})
			
			i = table.getn( self.mrGbMS.HydrostaticEfficiency )
		elseif self.mrGbMS.HydrostaticProfile == "Fendt" then
			self.mrGbMS.HydrostaticMin = -1
			self.mrGbMS.HydrostaticMax = 1.333333333
			self.mrGbMS.TransmissionEfficiency = 0.98
			self.mrGbMS.HydrostaticEfficiency  = {}

			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=-1	 ,v=0.65 })
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=-0.01,v=0.82 })
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=0	   ,v=0.6  })
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=0.01 ,v=0.825})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=1	   ,v=0.98 })
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=1.5  ,v=0.89 })

			i = table.getn( self.mrGbMS.HydrostaticEfficiency )
		elseif self.mrGbMS.HydrostaticProfile == "Combine" then
			self.mrGbMS.HydrostaticMin = 0
			self.mrGbMS.HydrostaticMax = 1.4
		--self.mrGbMS.HydrostaticCoupling    = "direct"
			self.mrGbMS.TransmissionEfficiency = 0.98
			self.mrGbMS.HydrostaticEfficiency  = {}

			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=0	 ,v=0.6 })
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=0.2,v=0.75})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=0.4,v=0.84})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=0.7,v=0.93})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=0.9,v=0.97})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=1	 ,v=0.98})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=1.1,v=0.97})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=1.2,v=0.95})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=1.4,v=0.9 })

			i = table.getn( self.mrGbMS.HydrostaticEfficiency )
		elseif self.mrGbMS.HydrostaticProfile == "Linde" then
			self.mrGbMS.HydrostaticMin = -1
			self.mrGbMS.HydrostaticMax = 1
		--self.mrGbMS.HydrostaticCoupling    = "direct"
			self.mrGbMS.TransmissionEfficiency = 0.98
			self.mrGbMS.HydrostaticEfficiency  = {}

			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=-1.00,v=0.870})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=-0.85,v=0.920})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=-0.70,v=0.930})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=-0.50,v=0.870})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=-0.15,v=0.700})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=0.000,v=0.600})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=0.150,v=0.750})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=0.300,v=0.850})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=0.500,v=0.930})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=0.650,v=0.975})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=0.700,v=0.980})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=0.750,v=0.975})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=0.850,v=0.950})
			table.insert(self.mrGbMS.HydrostaticEfficiency, {time=1.000,v=0.900})

			i = table.getn( self.mrGbMS.HydrostaticEfficiency )
		end
	end
	
	if     i > 0 
			or self.mrGbMS.HydrostaticProfile     ~= nil 
			or self.mrGbMS.HydrostaticPressure    ~= nil 
			or self.mrGbMS.HydrostaticVolumePump  ~= nil
			or self.mrGbMS.HydrostaticVolumeMotor ~= nil 
			or self.mrGbMS.HydrostaticCoupling    ~= nil then		
			
		self.mrGbMS.Hydrostatic = true
		
		if     self.mrGbMS.HydrostaticPressure    ~= nil 
				or self.mrGbMS.HydrostaticVolumePump  ~= nil
				or self.mrGbMS.HydrostaticVolumeMotor ~= nil 
				or self.mrGbMS.HydrostaticCoupling    ~= nil then
				
			self.mrGbMS.HydrostaticGearRatio = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. ".hydrostatic#gearRatio"), 1 )
			self.mrGbMS.HydrostaticMin       = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. ".hydrostatic#minRatio"), -1 )
			self.mrGbMS.HydrostaticMax       = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. ".hydrostatic#maxRatio"), 1.41421356 )
			
			if self.mrGbMS.HydrostaticPressure == nil then
				self.mrGbMS.HydrostaticPressure = 400
			end
			
			if self.mrGbMS.HydrostaticCoupling == nil then
				self.mrGbMS.HydrostaticCoupling = "direct"
			end
			
			if self.mrGbMS.HydrostaticMaxTorque == nil then
				self.mrGbMS.HydrostaticMaxTorque = 1.1 * maxTorque
			end
			
			if self.mrGbMS.HydrostaticVolumePump  == nil and self.mrGbMS.HydrostaticVolumeMotor == nil then
				self.mrGbMS.HydrostaticVolumePump   = 20000 * self.mrGbMS.HydrostaticMaxTorque * math.pi / ( self.mrGbMS.HydrostaticPressure * self.mrGbMS.HydrostaticGearRatio )
				self.mrGbMS.HydrostaticVolumeMotor  = self.mrGbMS.HydrostaticVolumePump
			elseif self.mrGbMS.HydrostaticVolumeMotor == nil then
				self.mrGbMS.HydrostaticVolumeMotor  = self.mrGbMS.HydrostaticVolumePump
			elseif self.mrGbMS.HydrostaticVolumePump == nil then
				self.mrGbMS.HydrostaticVolumePump   = self.mrGbMS.HydrostaticVolumeMotor
			end
		elseif self.mrGbMS.HydrostaticMaxTorque == nil then
			self.mrGbMS.HydrostaticMaxTorque = mrGearboxMogli.huge
		end
	
		if i > 0 then
			local tmp
			tmp = getXMLFloat(xmlFile, xmlString .. ".hydrostatic#minRatio")
			if      tmp ~= nil 
					and self.mrGbMS.HydrostaticEfficiency[1].time <= tmp 
					and tmp < self.mrGbMS.HydrostaticEfficiency[i].time then
				self.mrGbMS.HydrostaticMin = tmp
			end
			tmp = getXMLFloat(xmlFile, xmlString .. ".hydrostatic#maxRatio")
			if      tmp ~= nil 
					and self.mrGbMS.HydrostaticEfficiency[1].time < tmp 
					and tmp <= self.mrGbMS.HydrostaticEfficiency[i].time then
				self.mrGbMS.HydrostaticMax = tmp
			end	
		end	
	
		self.mrGbMS.HydrostaticMaxRpm   = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. ".hydrostatic#maxWheelRpm"), self.mrGbMS.RatedRpm )
		if self.mrGbMS.HydrostaticMin < 0 then
			self.mrGbMS.HydrostaticStart  = 0
		elseif self.mrGbMS.HydrostaticMax > 1 and self.mrGbMS.DisableManual then
			self.mrGbMS.HydrostaticStart  = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. ".hydrostatic#startFactor"), math.max( 2 - self.mrGbMS.HydrostaticMax, self.mrGbMS.HydrostaticMin )  )
		else
			self.mrGbMS.HydrostaticStart  = self.mrGbMS.HydrostaticMin
		end
		
		local dft = 2000
		local hit = getXMLFloat(xmlFile, xmlString .. ".hydrostatic#minMaxTimeMs")
		if hit == nil then
			-- 2000 ms
			self.mrGbMS.HydrostaticSmIFactor = 100/dft
			self.mrGbMS.HydrostaticIncFactor = 1/(dft+dft+dft)
		elseif hit < 100 then
			-- do not smooth 
			self.mrGbMS.HydrostaticSmIFactor = 1
			self.mrGbMS.HydrostaticIncFactor = 1
		else
			-- see Documents/smooth.xlsx
			self.mrGbMS.HydrostaticSmIFactor = 100 / hit 
			self.mrGbMS.HydrostaticIncFactor = 1 / (hit+hit+hit)
		end
		dft = 2000
		local hdt = getXMLFloat(xmlFile, xmlString .. ".hydrostatic#maxMinTimeMs")
		if hdt == nil and hit == nil then
			-- 2000 ms
			self.mrGbMS.HydrostaticSmDFactor = 100/dft
			self.mrGbMS.HydrostaticDecFactor = 1/(dft+dft+dft)
		elseif hdt == nil then
			-- compatibility
			self.mrGbMS.HydrostaticSmDFactor = self.mrGbMS.HydrostaticSmIFactor
			self.mrGbMS.HydrostaticDecFactor = self.mrGbMS.HydrostaticIncFactor
		elseif hdt < 100 then
			-- do not smooth 
			self.mrGbMS.HydrostaticSmDFactor = 1
			self.mrGbMS.HydrostaticDecFactor = 1
		else
			-- see Documents/smooth.xlsx
			self.mrGbMS.HydrostaticSmDFactor = 100 / hdt 
			self.mrGbMS.HydrostaticDecFactor = 1 / (hdt+hdt+hdt)
		end
		
		local sc = getXMLBool(xmlFile, xmlString .. ".hydrostatic#startWithClutch")
		if sc == nil then
			local smallestGearSpeed  = self.mrGbMS.Gears[1].speed 
															* self.mrGbMS.Ranges[1].ratio 
															* self.mrGbMS.Ranges2[1].ratio
															* self.mrGbMS.GlobalRatioFactor
															* self.mrGbMS.HydrostaticMin
															* 3.6
			
			if smallestGearSpeed < 1 then
				self.mrGbMS.HydrostaticLaunch = true
			else                            
				self.mrGbMS.HydrostaticLaunch = false
			end
		else
			self.mrGbMS.HydrostaticLaunch = not ( sc )
		end
		self.mrGbMS.HydroTransVolRatio  = Utils.getNoNil( getXMLFloat(xmlFile, xmlString .. ".hydrostatic#transVolRatio"), self.mrGbMG.hydroTransVolRatio )
		
		if      self.mrGbMS.HydrostaticMax > mrGearboxMogli.eps 
				and math.abs( self.mrGbMS.HydrostaticMax - 1 ) > mrGearboxMogli.eps 
				and getXMLBool(xmlFile, xmlString .. ".hydrostatic#correctGearSpeed") then
			for i,g in pairs( self.mrGbMS.Gears ) do
				g.speed = g.speed / self.mrGbMS.HydrostaticMax
			end
		end
	else
		self.mrGbMS.Hydrostatic         = false
	end

--**************************************************************************************************	
-- misc. parameter
--**************************************************************************************************		
	self.mrGbMS.PowerManagement = getXMLBool(xmlFile, xmlString .. "#powerManagement")
	if self.mrGbMS.PowerManagement == nil then
		if     self.mrGbMS.Hydrostatic then
			if     self.mrGbMS.HydrostaticCoupling == nil 
					or self.mrGbMS.HydrostaticCoupling ~= "direct" then
				self.mrGbMS.PowerManagement = true
			end
		elseif self.mrGbMS.AutoShiftGears
			  or self.mrGbMS.AutoShiftHl then
			self.mrGbMS.PowerManagement = true
		else
			self.mrGbMS.PowerManagement = false
		end
	end
	
	self.mrGbMS.AutoShiftTimeoutLong  = mrGearboxMogli.getNoNil2(getXMLFloat(xmlFile, xmlString .. ".gears#autoShiftTimeout"),  self.mrGbMG.autoShiftTimeoutLong , self.mrGbMG.autoShiftTimeoutHydroL, self.mrGbMS.Hydrostatic and self.mrGbMS.DisableManual )
	self.mrGbMS.AutoShiftTimeoutShort = mrGearboxMogli.getNoNil2(getXMLFloat(xmlFile, xmlString .. ".gears#autoShiftTimeout2"), self.mrGbMG.autoShiftTimeoutShort, self.mrGbMG.autoShiftTimeoutHydroS, self.mrGbMS.Hydrostatic and self.mrGbMS.DisableManual )
	self.mrGbMS.AutoShiftMinClutch    = Utils.getNoNil(getXMLFloat(xmlFile, xmlString .. ".gears#autoShiftMinClutch"), self.mrGbMS.MaxClutchPercent - 0.1 ) 

	if self.mrGbMS.AutoShiftTimeoutShort > self.mrGbMS.AutoShiftTimeoutLong then
		self.mrGbMS.AutoShiftTimeoutShort = self.mrGbMS.AutoShiftTimeoutLong
	end

	local enableAI = getXMLBool( xmlFile, xmlString .. "#enableAI" )
	if enableAI == nil then
		if     self.mrGbMS.Hydrostatic then
			self.mrGbMS.EnableAI = mrGearboxMogli.AIGearboxOn
		else
			self.mrGbMS.EnableAI = self.mrGbMG.defaultEnableAI
		end
	elseif enableAI then
		self.mrGbMS.EnableAI = mrGearboxMogli.AIGearboxOn
	else
		self.mrGbMS.EnableAI = mrGearboxMogli.AIGearboxOff
	end	
	
	self.mrGbMS.MaxAIGear   = getXMLInt(xmlFile, xmlString .. "#maxAIGear")
	self.mrGbMS.MaxAIRange  = getXMLInt(xmlFile, xmlString .. "#maxAIRange")
	self.mrGbMS.MaxAIRange2 = getXMLInt(xmlFile, xmlString .. "#maxAIRange2")

	if self.mrGbMS.Run2PitchEffect == nil then
		if self.mrGbMS.Hydrostatic then
			self.mrGbMS.Run2PitchEffect = 0
		elseif self.mrGbMS.AutoShiftGears then
			self.mrGbMS.Run2PitchEffect = 0.1
		else
			self.mrGbMS.Run2PitchEffect = 0
		end
	end
	
	self.mrGbMS.G27Gears = {} 
	local revereGear     = nil
	local defaultGear    = self.mrGbMS.LaunchGear
	local g27Entries     = self.mrGbMS.Gears 
	if self.mrGbMS.SwapGearRangeKeys then
		defaultGear = self.mrGbMS.LaunchRange
		g27Entries  = self.mrGbMS.Ranges 
	end
	
	for i,entry in pairs( g27Entries ) do
		if not ( entry.reverseOnly ) then
			local j=1
			while self.mrGbMS.G27Gears[j] ~= nil do
				j = j + 1
			end
			if j > 7 then
				for j=1,6 do
					self.mrGbMS.G27Gears[j] = self.mrGbMS.G27Gears[j+1]
				end
				self.mrGbMS.G27Gears[7] = i
			else
				self.mrGbMS.G27Gears[j] = i
			end
			
		elseif ( revereGear == nil or i < defaultGear ) then
			revereGear = i
		end
	end
	
	if revereGear ~= nil then
		if self.mrGbMS.G27Gears[7] ~= nil then
			for j=1,6 do
				self.mrGbMS.G27Gears[j] = self.mrGbMS.G27Gears[j+1]
			end
		end
		self.mrGbMS.G27Gears[7] = -revereGear
	end
	for j=1,7 do
		if self.mrGbMS.G27Gears[j] == nil then
			self.mrGbMS.G27Gears[j] = 0
		end
	end

	self.mrGbMS.sendTargetRpm   = self.mrGbMS.drawTargetRpm
	self.mrGbMS.sendReqPower    = self.mrGbMG.drawReqPower
	self.mrGbMS.sendHydro       = false
	
	if self.mrGbMS.Hydrostatic and math.abs( self.mrGbMS.HydroTransVolRatio ) > mrGearboxMogli.eps then
		self.mrGbMS.sendHydro     = true
	end
	if self.mrGbMS.OnlyHandThrottle then
		self.mrGbMS.sendHydro     = true
		self.mrGbMS.sendTargetRpm = true
	end
	
	self.mrGbMS.MaxGearSpeed = 0
	for i,g in pairs( self.mrGbMS.Gears ) do
		if self.mrGbMS.MaxGearSpeed < g.speed then
			self.mrGbMS.MaxGearSpeed = g.speed 
		end
	end

	local rr1 = 1
	for i,r in pairs( self.mrGbMS.Ranges ) do
		if rr1 < r.ratio then
			rr1 = r.ratio 
		end
	end
	local rr2 = 1
	for i,r in pairs( self.mrGbMS.Ranges2 ) do
		if rr2 < r.ratio then
			rr2 = r.ratio 
		end
	end

	if rr1 > 1 or rr2 > 1 then
		self.mrGbMS.MaxGearSpeed = self.mrGbMS.MaxGearSpeed * rr1 * rr2 
	end
	if self.mrGbMS.ReverseRatio > 1 then
		self.mrGbMS.MaxGearSpeed = self.mrGbMS.MaxGearSpeed * self.mrGbMS.ReverseRatio 
	end
	self.mrGbMS.MaxGearSpeed = self.mrGbMS.MaxGearSpeed * self.mrGbMS.GlobalRatioFactor
	
	self.mrGbMS.NormSpeedFactorS = 255 / self.mrGbMS.MaxGearSpeed
	self.mrGbMS.NormSpeedFactorC = 3.6 / self.mrGbMS.NormSpeedFactorS
	
--**********************************************************************************************************		
-- sound 
--**********************************************************************************************************		

	do
		-- modified RPM range with old pitch offset
		local newRpmRange = self.mrGbMS.CurMaxRpm  - self.mrGbMS.IdleRpm
		-- original RPM range
		local oldRpmRange = self.mrGbMS.OrigMaxRpm - self.mrGbMS.OrigMinRpm
		-- reduce pitch offset => original pitch at idle RPM
		local lowRpmRange = self.mrGbMS.IdleRpm    - self.mrGbMS.CurMinRpm
		
		-- scale pitch max to wider RPM range => original pitch at new rated RPM plus 100
		local rpmFactor   = self.mrGbMS.CurMaxRpm / self.mrGbMS.Sound.MaxRpm
		
		local newRpsRange = newRpmRange / 60
		local oldRpsRange = oldRpmRange / 60
		local lowRpsRange = lowRpmRange / 60
				
		local function soundHelper( sound, pitchScale, pitchMax, factor, newMax )
			local o, s, m = 0, 0, 0 
			if sound.sample ~= nil then
				if factor < 0 and newMax < 0 then 
					m = sound.pitchOffset + math.min( pitchMax - sound.pitchOffset, pitchScale * oldRpsRange ) * rpmFactor
				else
					if factor > 0 then
						s = pitchScale * factor * newRpmRange / oldRpmRange
					end
					
					if     newMax < 0 then 
						m = sound.pitchOffset + s * newRpsRange
					elseif newMax > 0 then 
						m = sound.pitchOffset + ( newMax - sound.pitchOffset ) * rpmFactor
					else
						m = pitchMax
					end 
				end 
				
				if factor < 0 then
					s = ( m - sound.pitchOffset ) / newRpsRange
				end
				
				o = sound.pitchOffset - lowRpsRange * s
			end
			return o, s, m
		end
		
		self.mrGbMS.Sound.IdlePitchOffset, self.mrGbMS.Sound.IdlePitchScale, self.mrGbMS.Sound.IdlePitchMax = soundHelper( self.sampleMotor,     self.motorSoundPitchScale,     self.motorSoundPitchMax,     self.mrGbMS.IdlePitchFactor, self.mrGbMS.IdlePitchMax )
		self.mrGbMS.Sound.RunPitchOffset,  self.mrGbMS.Sound.RunPitchScale,  self.mrGbMS.Sound.RunPitchMax  = soundHelper( self.sampleMotorRun,  self.motorSoundRunPitchScale,  self.motorSoundRunPitchMax,  self.mrGbMS.RunPitchFactor,  self.mrGbMS.RunPitchMax  )
		self.mrGbMS.Sound.LoadPitchOffset, self.mrGbMS.Sound.LoadPitchScale, self.mrGbMS.Sound.LoadPitchMax = soundHelper( self.sampleMotorLoad, self.motorSoundLoadPitchScale, self.motorSoundLoadPitchMax, self.mrGbMS.RunPitchFactor,  self.mrGbMS.RunPitchMax  )		
		self.mrGbMS.Sound.LoadMinimalVolumeFactor = self.motorSoundLoadMinimalVolumeFactor
	end

--**********************************************************************************************************		
-- server fields...	
--**********************************************************************************************************		
	if not ( serverAndClient ) then
		for n,_ in pairs(self.mrGbMS) do
			if not ( excludeList[n] ) then
				mrGearboxMogli.registerServerField( self, n )
			end
		end	
	end	
--**************************************************************************************************	
	
-- set the default values for SERVER		
	self.mrGbMS.Automatic     = self.mrGbMS.AutoShiftGears or self.mrGbMS.AutoShiftHl
	self.mrGbMS.IsOnOff       = self.mrGbMS.DefaultOn
	self.mrGbMS.NeutralActive = self.mrGbMS.AutoStartStop	
	self.mrGbMS.CurrentGear   = self.mrGbMS.DefaultGear
	self.mrGbMS.CurrentRange  = self.mrGbMS.DefaultRange
	self.mrGbMS.CurrentRange2 = self.mrGbMS.DefaultRange2
	self.mrGbMS.NewGear       = self.mrGbMS.DefaultGear
	self.mrGbMS.NewRange      = self.mrGbMS.DefaultRange
	self.mrGbMS.NewRange2     = self.mrGbMS.DefaultRange2
	self.mrGbMS.ManualClutch  = 1
-- set the default values for SERVER		
--**********************************************************************************************************		


--**********************************************************************************************************		
-- Try to initialize motor during load
--**********************************************************************************************************		
	if self.mrGbMG.initMotorOnLoad and self.motor ~= nil and self.motor.minRpm ~= nil and self.motor.minRpm > 0 then
		self.mrGbML.motor = mrGearboxMogliMotor:new( self, self.motor )			
		if self.mrGbML.motor ~= nil then
			self.mrGbMB.motor = self.motor	
		end
	end
--**********************************************************************************************************		
  
	self.mrGbML.smoothSlow   = 1
	self.mrGbML.smoothMedium = 1
	self.mrGbML.smoothFast   = 1
	self.mrGbML.smoothLittle = 1
end
		
--**********************************************************************************************************	
-- mrGearboxMogli.getSmoothBase
--**********************************************************************************************************	
function mrGearboxMogli.getSmoothBase( dt )	
	if     mrGearboxMogli.lastSmoothBaseV  == nil
			or mrGearboxMogli.lastSmoothBaseDt == nil
			or mrGearboxMogli.lastSmoothBaseDt ~= dt then
		mrGearboxMogli.lastSmoothBaseV  = 0.3 * ( dt * 0.06 + math.sqrt( dt * 0.06 ) )
		mrGearboxMogli.lastSmoothBaseDt = dt
	end
	return mrGearboxMogli.lastSmoothBaseV
end

--**********************************************************************************************************	
-- mrGearboxMogli:checkIfReady
--**********************************************************************************************************	
function mrGearboxMogli:checkIfReady( noEventSend )
	if self.mrGbMS == nil then
		print("ERROR: GearboxAddon not initialized")
	elseif not ( self.mrGbMS.IsOn ) then
	elseif self.mrGbML                                          == nil 
			or self.mrGbMB                                          == nil
			or self.mrGbMS.Gears                                    == nil
			or self.mrGbMS.CurrentGear                              == nil
			or self.mrGbMS.Gears[self.mrGbMS.CurrentGear].speed     == nil
			or self.mrGbMS.Ranges                                   == nil
			or self.mrGbMS.CurrentRange                             == nil
			or self.mrGbMS.Ranges[self.mrGbMS.CurrentRange].ratio   == nil
			or self.mrGbMS.Ranges2                                  == nil
			or self.mrGbMS.CurrentRange2                            == nil
			or self.mrGbMS.Ranges2[self.mrGbMS.CurrentRange2].ratio == nil
			or self.mrGbMS.ReverseRatio                             == nil
			or self.mrGbMS.GlobalRatioFactor                        == nil then
		print("ERROR: client initialization failed")
		self:mrGbMSetState( "IsOn", false, noEventSend )
		return 
	end
end

--**********************************************************************************************************	
-- mrGearboxMogli:mbIsSoundActive
--**********************************************************************************************************	
function mrGearboxMogli:mbIsSoundActive()
	if self.isClient and self.isMotorStarted then -- and ( self.isEntered or not ( self.steeringEnabled ) ) then
		return true
	end
	return false
end
		
--**********************************************************************************************************	
-- mrGearboxMogli:mbIsActiveForInput
--**********************************************************************************************************	
function mrGearboxMogli:mbIsActiveForInput(onlyTrueIfSelected)
  if not ( self.isEntered ) or g_gui.currentGui ~= nil or g_currentMission.isPlayerFrozen then
    return false
  end
  if onlyTrueIfSelected == nil or onlyTrueIfSelected then
    return self.selectedImplement == nil
	end
  return true
end

--**********************************************************************************************************	
-- mrGearboxMogli:update
--**********************************************************************************************************	
function mrGearboxMogli:update(dt)

	if self.mrGbMS == nil then
		return
	end

	if self.mrGbML.updateStreamErrors > 10 and not self.mrGbMS.NoUpdateStream then
		self:mrGbMSetState( "NoUpdateStream", true )
	end
	
	self.mrGbML.smoothBase   = mrGearboxMogli.getSmoothBase( dt )
	self.mrGbML.smoothSlow   = Utils.clamp( mrGearboxMogli.smoothSlow   * self.mrGbML.smoothBase, 0, 1 )
	self.mrGbML.smoothMedium = Utils.clamp( mrGearboxMogli.smoothMedium	* self.mrGbML.smoothBase, 0, 1 )
	self.mrGbML.smoothFast   = Utils.clamp( mrGearboxMogli.smoothFast   * self.mrGbML.smoothBase, 0, 1 )
	self.mrGbML.smoothLittle = Utils.clamp( mrGearboxMogli.smoothLittle * self.mrGbML.smoothBase, 0, 1 )
	
	local processInput = true
	
	self.motorSoundLoadMinimalVolumeFactor = self.mrGbMS.Sound.LoadMinimalVolumeFactor
	
	if     self.hasChangedGearBoxAddon then
	-- IncreaseRPMWhileTipping.lua
		if not self.mrGbMS.IsOnOff then
			self:mrGbMSetState( "IsOn", false ) 		
			self.mrGbML.turnedOffByIncreaseRPMWhileTipping = true
		end
		processInput = false
	elseif self.mrGbMS.NoDisable then
		self:mrGbMSetIsOnOff( true ) 
	elseif mrGearboxMogli.mbIsActiveForInput(self, false) and mrGearboxMogli.mbHasInputEvent( "mrGearboxMogliON_OFF" ) then
		if      self.isMotorStarted
				and ( ( self.dCcheckModule ~= nil
						and self:dCcheckModule("manMotorStart") )
					 or ( self.setManualIgnitionMode ~= nil ) ) then
			self:mrGbMSetState( "WarningText", "Cannot exchange gearbox while motor is running" )
		else	
			self:mrGbMSetIsOnOff( not self.mrGbMS.IsOnOff ) 
		end
		processInput = false
	end
	
	if      self.mrGbMS.WarningText ~= nil
			and self.mrGbMS.WarningText ~= "" then
		if self.mrGbMG.blinkingWarning and self.isEntered then
			g_currentMission:showBlinkingWarning(self.mrGbMS.WarningText, self.mrGbML.warningTimer - g_currentMission.time )
			self.mrGbMS.WarningText = ""
		elseif g_currentMission.time < self.mrGbML.warningTimer then
			g_currentMission:addWarning(self.mrGbMS.WarningText, 0.018, 0.033)
		else
			self.mrGbMS.WarningText = ""
		end
	end
	
	if self.mrGbML.turnOnMotorTimer ~= nil and g_currentMission.time > self.mrGbML.turnOnMotorTimer then
		self.mrGbML.turnOnMotorTimer = nil
		if not ( self.isMotorStarted ) then
			self:startMotor()
		end
	end
	
	if self.mrGbML.soundModified and not ( self.mrGbMS.IsOn and mrGearboxMogli.hackSounds ) then
		self.mrGbML.soundModified = false
		mrGearboxMogli.resetSampleVolume( self.sampleMotor )
		mrGearboxMogli.resetSampleVolume( self.sampleMotorRun )
		mrGearboxMogli.resetSampleVolume( self.sampleMotorLoad )
		mrGearboxMogli.resetSamplePitch( self.sampleMotor )
		mrGearboxMogli.resetSamplePitch( self.sampleMotorRun )
		mrGearboxMogli.resetSamplePitch( self.sampleMotorLoad )
	end
	
	if      self.mrGbMS.IsOnOff 
			and self.mrGbML.turnedOffByIncreaseRPMWhileTipping
			and not ( self.hasChangedGearBoxAddon ) then
		self.mrGbML.turnedOffByIncreaseRPMWhileTipping = false
	end
	
	if self.isMotorStarted and self.motor.minRpm > 0 and self.mrGbMS.IsOnOff then
		if self.mrGbML.motor == nil then 
	-- initialize as late as possible 			
			if not ( self.mbClientInitDone30 ) then return end
			if self.motor == nil then return end
		
			if self.mrGbML.motor == nil then
				self.mrGbML.motor = mrGearboxMogliMotor:new( self, self.motor )			
				self.mrGbMB.motor = self.motor	
			end
		end
		if self.mrGbML.motor == nil or self.mrGbMB.motor == nil then 
	-- no backup of original motor => error in mrGearboxMogliMotor:new
			local code = 0
			if self.mrGbML.motor == nil then code = code + 1 end
			if self.mrGbMB.motor == nil then code = code + 2 end
			print("Initialization of motor failed: "..tostring(self.configFileName).." ("..tostring(code)..")")
			self.mrGbML.motor = nil
			self:mrGbMSetIsOnOff( false ) 
			self:mrGbMSetState( "IsOn", false ) 	
			return
		end
	end
	
	if not self.mrGbMS.IsOn then
		return 
	end 	
		
	if self.mrGbMS.CurMinRpm == nil or self.mrGbMS.CurMaxRpm == nil then
		print("Init failed")
	end
	
	self.motor.minRpm = self.mrGbMS.CurMinRpm
	self.motor.maxRpm = self.mrGbMS.CurMaxRpm

	if self.isServer and not ( self.mrGbML.firstTimeRun ) then
		self.mrGbML.firstTimeRun = true
		self:mrGbMSetState( "CurrentGear",   mrGearboxMogli.mrGbMGetNewEntry( self, self.mrGbMS.Gears,   self.mrGbMS.CurrentGear,   self.mrGbMS.DefaultGear,   "gear" ) )
		self:mrGbMSetState( "CurrentRange",  mrGearboxMogli.mrGbMGetNewEntry( self, self.mrGbMS.Ranges,  self.mrGbMS.CurrentRange,  self.mrGbMS.DefaultRange,  "range" ) )
		self:mrGbMSetState( "CurrentRange2", mrGearboxMogli.mrGbMGetNewEntry( self, self.mrGbMS.Ranges2, self.mrGbMS.CurrentRange2, self.mrGbMS.DefaultRange2, "range2" ) )
	end	

	if self.mrGbMG.debugPrint and not ( mrGearboxMogli.consoleCommand1 ) then
		mrGearboxMogli.consoleCommand1 = true
		self.mrGbMTestNet = mrGearboxMogli.mrGbMTestNet
		self.mrGbMTestAPI = mrGearboxMogli.mrGbMTestAPI
		self.mrGbMDebug   = mrGearboxMogli.mrGbMDebug
		addConsoleCommand("mrGbMTestNet", "Test networking of mrGearboxMogli", "mrGbMTestNet", self)
		addConsoleCommand("mrGbMTestAPI", "Test API of mrGearboxMogli", "mrGbMTestAPI", self)
		addConsoleCommand("mrGbMDebug", "Console output during gear shift", "mrGbMDebug", self)
	end

--**********************************************************************************************************			
-- area per second calculation for combines 
--**********************************************************************************************************			
	if self.mrGbML.strawDisableTime ~= nil and self.mrGbML.strawDisableTime > g_currentMission.time then 
		local timeUntilDisable = self.mrGbML.strawDisableTime - g_currentMission.time
		local numToDrop
		
		numToDrop = math.min((dt*self.mrGbML.currentCuttersArea)/timeUntilDisable, self.mrGbML.currentCuttersArea)
		self.mrGbML.currentCuttersArea  = self.mrGbML.currentCuttersArea - numToDrop
		self.mrGbML.cutterAreaPerSecond = numToDrop * 1000 / dt

		numToDrop = math.min((dt*self.mrGbML.currentRealArea)/timeUntilDisable, self.mrGbML.currentRealArea)
		self.mrGbML.currentRealArea  = self.mrGbML.currentRealArea - numToDrop		
    self.mrGbML.realAreaPerSecond   = numToDrop * 1000 / dt
	else
		self.mrGbML.cutterAreaPerSecond = 0
    self.mrGbML.realAreaPerSecond   = 0
	end
	
--**********************************************************************************************************			
-- driveControl 
--**********************************************************************************************************			
	local driveControlShuttle   = false
	local driveControlHandBrake = false
	if      self.dCcheckModule ~=  nil 
			and self.driveControl  ~= nil then
			
		if      self:dCcheckModule("shuttle")
				and self.driveControl.shuttle ~= nil 
				and self.driveControl.shuttle.isActive then
			--driveControlShuttle = true
			--if self.driveControl.shuttle.direction < 0 then
			--	self:mrGbMSetReverseActive( true )
			--else
			--	self:mrGbMSetReverseActive( false )
			--end
			self.mrGbMB.dcShuttle = true
			self.driveControl.shuttle.isActive = false
		end
		
		if      self:dCcheckModule("handBrake")
				and self.driveControl.handBrake ~= nil then
			if self.driveControl.handBrake.isActive then
				driveControlHandBrake = true
				self:mrGbMSetNeutralActive( true, false, true ) 
				if self:mrGbMGetAutoHold() then
					self:mrGbMSetState( "AutoHold", true )
				end
			elseif self.mrGbML.lastDCHandBrake then
				if self:mrGbMGetAutoClutch() and not ( self:mrGbMGetAutoStartStop() ) then
					self:mrGbMSetNeutralActive( false )
				end
			end
			self.mrGbML.lastDCHandBrake = self.driveControl.handBrake.isActive
		end
	end
	
--**********************************************************************************************************			
-- text	
--**********************************************************************************************************			
	if self.isServer then
		local text = ""
		local text2 = ""

		if not ( self.isMotorStarted ) then
			text = mrGearboxMogli.getText( "mrGearboxMogliTEXT_OFF", "off" )
		elseif not ( self.steeringEnabled ) then
			text = mrGearboxMogli.getText( "mrGearboxMogliTEXT_AI", "AI" )
			text2 = text
			if self:mrGbMGetHasAllAuto() then
				if not ( self:mrGbMGetAutoShiftGears() and self:mrGbMGetAutoShiftRange() ) then
					text = text .. " (M)"
				end
			elseif self.mrGbMS.Hydrostatic then
			elseif ( self.mrGbMS.AutoShiftGears and not self:mrGbMGetAutoShiftGears() )
					or ( self.mrGbMS.AutoShiftHl    and not self:mrGbMGetAutoShiftRange() ) then
				text = text .. " (M)"
			end
		elseif driveControlHandBrake then
			text = mrGearboxMogli.getText( "mrGearboxMogliTEXT_BRAKE", "handbrake" )
		elseif self.mrGbMS.AutoHold then
			text = mrGearboxMogli.getText( "mrGearboxMogliTEXT_AUTO_HOLD", "auto hold" )
			if self:mrGbMGetAutomatic() then
				text = text .. " (A)"
			end
		elseif self.mrGbML.gearShiftingNeeded < 0 then
			text = mrGearboxMogli.getText( "mrGearboxMogliTEXT_DC", "double clutch" ) .." "..tostring(-self.mrGbML.gearShiftingNeeded)
			text2 = text
		elseif self.mrGbMS.NeutralActive then
			text = mrGearboxMogli.getText( "mrGearboxMogliTEXT_NEUTRAL", "neutral" )
			if self:mrGbMGetAutomatic() then
				text = text .. " (A)"
			end
		elseif self.mrGbMS.AllAuto then
			text = mrGearboxMogli.getText( "mrGearboxMogliTEXT_ALLAUTO", "all auto" )
			if not ( self.mrGbMS.AutoShiftHl or self.mrGbMS.AutoShiftGears ) then
				text2 = "A"
			end
		elseif self.mrGbMS.Hydrostatic then
			text = mrGearboxMogli.getText( "mrGearboxMogliTEXT_VARIO", "CVT" )
		elseif self:mrGbMGetAutomatic() then
			text = mrGearboxMogli.getText( "mrGearboxMogliTEXT_AUTO", "auto" )
		elseif self.mrGbMS.G27Mode == 1 then
			text = mrGearboxMogli.getText( "mrGearboxMogliTEXT_NOGEAR", "no gear" )
			text2 = text
		else
			text = mrGearboxMogli.getText( "mrGearboxMogliTEXT_MANUAL", "manual" )
			if self.mrGbMS.AutoShiftHl or self.mrGbMS.AutoShiftGears then
				text2 = text
			end
		end
		
		if self.mrGbMS.ReverseActive and not ( driveControlShuttle ) then
			if text  ~= "" then text  = text  .. " " end
			text = text .. "(R)" 	
		end
		if self.mrGbMS.SpeedLimiter then
			if text  ~= "" then text  = text  .. " " end
			if text2 ~= "" then text2 = text2 .. " " end
			text = text .. "(L)"
			text2 = text2 .. "(L)"
		end
		if self.mrGbMS.G27Mode > 0 then
			if text  ~= "" then text  = text  .. " " end
			text = text .. "G27"
		end
		if self.mrGbMS.G27Mode > 1 then
			if text2 ~= "" then text2 = text2 .. " " end
			text2 = text2 .. "G27"			
		end
		if self.mrGbMS.EcoMode then
			if text  ~= "" then text  = text  .. " " end
			if text2 ~= "" then text2 = text2 .. " " end
			text = text .. "(eco)"
			text2 = text2 .. "(eco)"
		end
		
		self:mrGbMSetState( "DrawText", text )
		self:mrGbMSetState( "DrawText2", text2 )
	end
		
--**********************************************************************************************************			
-- inputs	
--**********************************************************************************************************			
	if mrGearboxMogli.mbIsActiveForInput( self, false ) then					
		-- auto start/stop
		if      self.mrGbMS.NeutralActive
				and self.isMotorStarted
				and self:mrGbMGetAutoStartStop()
				and g_currentMission.time > self.motorStartTime
				and not ( driveControlHandBrake )
				and ( self.axisForward < -0.1 or self.cruiseControl.state ~= 0 ) then
			self:mrGbMSetNeutralActive( false ) 
		end

		if self.mrGbMS.AllAuto and not ( self:mrGbMGetHasAllAuto() ) then
			self:mrGbMSetState( "AllAuto", false )		
		end

		if not self.mrGbMS.AllAuto then
			local autoClutch = self.mrGbMS.AutoClutch
			if mrGearboxMogli.mbHasInputEvent( "mrGearboxMogliAUTOCLUTCH2" ) then
				autoClutch = not ( autoClutch )
			end

			if     autoClutch
					or ( not ( self.mrGbMS.AutoClutch )
					 and ( self.mrGbMS.DisableManual 
							or ( self.mrGbMS.Hydrostatic
							 and self.mrGbMS.HydrostaticLaunch )
							or self.mrGbMS.DisableManual ) ) then
				self:mrGbMSetAutoClutch( true )
			else
				self:mrGbMSetAutoClutch( false )
				self:mrGbMSetAutomatic( false, noEventSend )
			end
		end
		
		local clutchSpeed = 1 / math.max( self.mrGbMS.ClutchShiftTime, 1 )
		if not ( self:mrGbMGetAutoClutch() ) then
			clutchSpeed     = math.max( 0.002, clutchSpeed )
		end
		
		if     mrGearboxMogli.mbIsInputPressed( "mrGearboxMogliCLUTCH_3" ) then
			self.mrGbML.oneButtonClutchTimer = g_currentMission.time + 100
			self:mrGbMSetManualClutch( math.max( 0, self.mrGbMS.ManualClutch - dt * clutchSpeed ))
		elseif InputBinding.mrGearboxMogliCLUTCH ~= nil then
			local targetClutchPercent = InputBinding.getDigitalInputAxis(InputBinding.mrGearboxMogliCLUTCH)
			if InputBinding.isAxisZero(targetClutchPercent) then
				targetClutchPercent = InputBinding.getAnalogInputAxis(InputBinding.mrGearboxMogliCLUTCH)
				if not InputBinding.isAxisZero(targetClutchPercent) then
					targetClutchPercent = Utils.clamp( 0.55 * ( targetClutchPercent + 1 ), 0, 1 ) 
					if math.abs( targetClutchPercent - self.mrGbMS.ManualClutch ) > 0.01 then
						self.mrGbML.oneButtonClutchTimer = math.huge
						self:mrGbMSetManualClutch( targetClutchPercent ) 
					end
				end
			elseif targetClutchPercent < 0 then
				self.mrGbML.oneButtonClutchTimer = math.huge
				self:mrGbMSetManualClutch( math.max( 0, self.mrGbMS.ManualClutch - dt * clutchSpeed ))
			elseif targetClutchPercent > 0 then
				self.mrGbML.oneButtonClutchTimer = math.huge
				self:mrGbMSetManualClutch( math.min( 1, self.mrGbMS.ManualClutch + dt * clutchSpeed ))
			end
		end

		if     self.mrGbML.oneButtonClutchTimer == nil
				or self.mrGbMS.ClutchTimeManual     < dt
				or g_currentMission.time >= self.mrGbML.oneButtonClutchTimer + self.mrGbMS.ClutchTimeManual then
			if self.mrGbMS.ManualClutch < 1 then
				self:mrGbMSetManualClutch( 1 )
			end
		elseif g_currentMission.time > self.mrGbML.oneButtonClutchTimer then
			local mi = ( g_currentMission.time - self.mrGbML.oneButtonClutchTimer ) / self.mrGbMS.ClutchTimeManual
			local ma = math.min( 1, self.mrGbMS.ManualClutch + dt / self.mrGbMS.ClutchTimeInc )
			if self.motor.targetRpm == nil then
				self:mrGbMSetManualClutch( mi )
			else
				self:mrGbMSetManualClutch( self.motor:getClutchPercent( self.motor.targetRpm, self.mrGbMS.OpenRpm, self.mrGbMS.CloseRpm, mi, ma ) )
			end
		--print(string.format("%d, %5.2f%% <= %5.2f%% <= %5.2f%%",g_currentMission.time - self.mrGbML.oneButtonClutchTimer, mi*100,self.mrGbMS.ManualClutch*100,ma*100))
		end
		
		if InputBinding.mrGearboxMogliMINRPM ~= nil then
			local handThrottle = InputBinding.getDigitalInputAxis(InputBinding.mrGearboxMogliMINRPM)
			if InputBinding.isAxisZero(handThrottle) then
				handThrottle = InputBinding.getAnalogInputAxis(InputBinding.mrGearboxMogliMINRPM)
				if not InputBinding.isAxisZero(handThrottle) then
					self:mrGbMSetHandThrottle( handThrottle )
				end
			elseif handThrottle < 0 then
				self:mrGbMSetHandThrottle( self.mrGbMS.HandThrottle - 0.0004 * dt )
			elseif handThrottle > 0 then
				self:mrGbMSetHandThrottle( self.mrGbMS.HandThrottle + 0.0004 * dt ) 
			end
		end
			
		-- avoid conflicts with driveControl
		--if     mrGearboxMogli.mbHasInputEvent( "driveControlHandbrake" ) then
		if     not processInput
				or mrGearboxMogli.mbHasInputEvent( "mrGearboxMogliCONFLICT_1" )
				or mrGearboxMogli.mbHasInputEvent( "mrGearboxMogliCONFLICT_2" )
				or mrGearboxMogli.mbHasInputEvent( "mrGearboxMogliCONFLICT_3" )
				or mrGearboxMogli.mbHasInputEvent( "mrGearboxMogliCONFLICT_4" ) then
			-- ignore
		elseif mrGearboxMogli.mbHasInputEvent( "TOGGLE_CHOPPER" ) and self.mrGbMS.IsCombine then
			-- ignore
		elseif mrGearboxMogli.mbHasInputEvent( "mrGearboxMogliECO" ) then
			self:mrGbMSetState( "EcoMode", not self.mrGbMS.EcoMode )
		elseif mrGearboxMogli.mbHasInputEvent( "mrGearboxMogliHUD" ) then
			-- HUD mode	
		--local m = self.mrGbMS.HudMode + 1
		--if m > 2 then 
		--	m = 0
		--end
			local m = self.mrGbMG.defaultHudMode
			if self.mrGbMS.HudMode == 1 then
				m = 2
			else
				m = 1
			end
			self:mrGbMSetState( "HudMode", m )
		elseif  mrGearboxMogli.mbHasInputEvent( "mrGearboxMogliAllAuto" )
				and self:mrGbMGetHasAllAuto() then
			-- toggle always AI => has to work with worker too
			self:mrGbMSetState( "AllAuto", not self.mrGbMS.AllAuto )
		elseif mrGearboxMogli.mbHasInputEvent( "mrGearboxMogliNEUTRAL" ) then
			if self.mrGbMS.AllAuto then
				if not self.mrGbMS.NeutralActive then
					self:setCruiseControlState(0)
				end
				self:mrGbMSetNeutralActive( not self.mrGbMS.NeutralActive ) 
			elseif self.mrGbMS.AutoClutch and ( self.mrGbMS.AutoShiftGears or self.mrGbMS.AutoShiftHl ) then
				if     self.mrGbMS.DisableManual then
					self:mrGbMSetNeutralActive( not self.mrGbMS.NeutralActive ) 
					self:mrGbMSetAutomatic( true ) 
				elseif self.mrGbMS.AutoStartStop and self.mrGbMS.AutoClutch then
					self:mrGbMSetAutomatic( not self.mrGbMS.Automatic ) 
				elseif self.mrGbMS.NeutralActive then
					self:mrGbMSetNeutralActive( false ) 
					self:mrGbMSetAutomatic( true ) 
				elseif self.mrGbMS.Automatic then
					self:mrGbMSetAutomatic( false )
				else 
					self:mrGbMSetNeutralActive( true ) 
				end	
			else	
				if not self.mrGbMS.NeutralActive then
					self:setCruiseControlState(0)
				end
				self:mrGbMSetNeutralActive( not self.mrGbMS.NeutralActive ) 
			end
		elseif not ( driveControlShuttle ) and mrGearboxMogli.mbHasInputEvent( "mrGearboxMogliREVERSE" ) then			
		--self:setCruiseControlState(0)
			self:mrGbMSetReverseActive( not self.mrGbMS.ReverseActive ) 
		elseif mrGearboxMogli.mbHasInputEvent( "mrGearboxMogliSPEEDLIMIT" ) then -- speed limiter
			self:mrGbMSetSpeedLimiter( not self.mrGbMS.SpeedLimiter ) 
		elseif mrGearboxMogli.mbHasInputEvent( "mrGearboxMogliACCTOLIMIT" ) then -- speed limiter acc.
			self:mrGbMSetAccelerateToLimit( self.mrGbMS.AccelerateToLimit + 1 )
			self:mrGbMSetDecelerateToLimit( self.mrGbMS.AccelerateToLimit * 2 )
			self:mrGbMSetState( "InfoText", string.format( "Speed Limiter: +%2.0f km/h/s / -%2.0f km/h/s", self.mrGbMS.AccelerateToLimit, self.mrGbMS.DecelerateToLimit ))
		elseif mrGearboxMogli.mbHasInputEvent( "mrGearboxMogliDECTOLIMIT" ) then -- speed limiter dec.
			self:mrGbMSetAccelerateToLimit( self.mrGbMS.AccelerateToLimit - 1 )
			self:mrGbMSetDecelerateToLimit( self.mrGbMS.AccelerateToLimit * 2 )
			self:mrGbMSetState( "InfoText", string.format( "Speed Limiter: +%2.0f km/h/s / -%2.0f km/h/s", self.mrGbMS.AccelerateToLimit, self.mrGbMS.DecelerateToLimit ))
		elseif table.getn( self.mrGbMS.Ranges2 ) > 1 and mrGearboxMogli.mbHasInputEvent( "mrGearboxMogliSHIFTRANGE2UP" ) then -- high/low range shift
			self:mrGbMSetCurrentRange2(self.mrGbMS.CurrentRange2+1)                                       
		elseif table.getn( self.mrGbMS.Ranges2 ) > 1 and mrGearboxMogli.mbHasInputEvent( "mrGearboxMogliSHIFTRANGE2DOWN" ) then -- high/low range shift
			self:mrGbMSetCurrentRange2(self.mrGbMS.CurrentRange2-1)
		elseif table.getn( self.mrGbMS.Ranges ) > 1 and mrGearboxMogli.mbHasInputEvent( "mrGearboxMogliSHIFTRANGEUP" ) then -- high/low range shift
			if self.mrGbMS.SwapGearRangeKeys then
				self:mrGbMSetCurrentGear(self.mrGbMS.CurrentGear+1, false, true) 
			else
				self:mrGbMSetCurrentRange(self.mrGbMS.CurrentRange+1, false, true)                                        
			end 
		elseif table.getn( self.mrGbMS.Ranges ) > 1 and mrGearboxMogli.mbHasInputEvent( "mrGearboxMogliSHIFTRANGEDOWN" ) then -- high/low range shift
			if self.mrGbMS.SwapGearRangeKeys then
				self:mrGbMSetCurrentGear(self.mrGbMS.CurrentGear-1, false, true) 	
			else
				self:mrGbMSetCurrentRange(self.mrGbMS.CurrentRange-1, false, true) 
			end 
		elseif not ( self.mrGbMS.DisableManual ) and mrGearboxMogli.mbHasInputEvent( "mrGearboxMogliSHIFTGEARUP" ) then
			self:mrGbMSetState( "G27Mode", 0 ) 
			if self.mrGbMS.SwapGearRangeKeys then
				self:mrGbMSetCurrentRange(self.mrGbMS.CurrentRange+1, false, true)                                        
			else
				self:mrGbMSetCurrentGear(self.mrGbMS.CurrentGear+1, false, true) 
			end 
		elseif not ( self.mrGbMS.DisableManual ) and mrGearboxMogli.mbHasInputEvent( "mrGearboxMogliSHIFTGEARDOWN" ) then
			self:mrGbMSetState( "G27Mode", 0 ) 
			if self.mrGbMS.SwapGearRangeKeys then
				self:mrGbMSetCurrentRange(self.mrGbMS.CurrentRange-1, false, true) 
			else
				self:mrGbMSetCurrentGear(self.mrGbMS.CurrentGear-1, false, true) 	
			end 
		elseif mrGearboxMogli.mbHasInputEvent( "mrGearboxMogliGEARFWD" )  then 
		--self:setCruiseControlState(0) 
			self:mrGbMSetReverseActive( false ) 
		elseif mrGearboxMogli.mbHasInputEvent( "mrGearboxMogliGEARBACK" ) then 
		--self:setCruiseControlState(0) 
			self:mrGbMSetReverseActive( true ) 
		end
		
		if not ( self.mrGbMS.DisableManual ) then
			local gear = 0
			if     mrGearboxMogli.mbIsInputPressed( "mrGearboxMogliGEAR1" ) then gear=self.mrGbMS.G27Gears[1]
			elseif mrGearboxMogli.mbIsInputPressed( "mrGearboxMogliGEAR2" ) then gear=self.mrGbMS.G27Gears[2]
			elseif mrGearboxMogli.mbIsInputPressed( "mrGearboxMogliGEAR3" ) then gear=self.mrGbMS.G27Gears[3]
			elseif mrGearboxMogli.mbIsInputPressed( "mrGearboxMogliGEAR4" ) then gear=self.mrGbMS.G27Gears[4]
			elseif mrGearboxMogli.mbIsInputPressed( "mrGearboxMogliGEAR5" ) then gear=self.mrGbMS.G27Gears[5]
			elseif mrGearboxMogli.mbIsInputPressed( "mrGearboxMogliGEAR6" ) then gear=self.mrGbMS.G27Gears[6]
			elseif mrGearboxMogli.mbIsInputPressed( "mrGearboxMogliGEARR" ) then gear=self.mrGbMS.G27Gears[7]
			end
			
		--self.mrGbML.G27Gear = tostring(gear)
			
			local noAutomatic = true
			if self.mrGbMS.SwapGearRangeKeys then
				noAutomatic = not self:mrGbMGetAutoShiftRange()
			else
				noAutomatic = not self:mrGbMGetAutoShiftGears()
			end
			
		--self.mrGbML.G27Gear = self.mrGbML.G27Gear ..", "..tostring(noAutomatic)..", "..tostring(self.mrGbMS.G27Mode)
			
			if noAutomatic and ( self.mrGbMS.G27Mode > 0 or gear ~= 0 ) then		
				if self.mrGbMS.G27Mode <= 0 then
					if self.mrGbMS.NeutralActive then
						self:mrGbMSetState( "G27Mode", 1 ) 
					else
						self:mrGbMSetState( "G27Mode", 2 ) 
					end
				end
			
				local curGear = 0
				if self.mrGbMS.G27Mode >= 2  then
					if self.mrGbMS.SwapGearRangeKeys then
						curGear   = self.mrGbMS.CurrentRange
					else
						curGear   = self.mrGbMS.CurrentGear
					end					
					if self.mrGbMS.ReverseActive then
						curGear = -curGear 
					end				
					if self.mrGbMS.G27Gears[7] >= 0 then
						curGear = math.abs( curGear )
					end											
				end											

			--self.mrGbML.G27Gear = self.mrGbML.G27Gear .." => "..tostring(curGear)..", "..tostring(gear)
				
				if curGear ~= gear then					
					local manClutch = self.mrGbMS.ManualClutchGear
					if self:mrGbMGetAutoClutch() then
						manClutch = false
					elseif ( curGear>0 and gear<0 ) or ( curGear<0 and gear>0 ) then
						manClutch = self.mrGbMS.ManualClutchReverse
					elseif self.mrGbMS.SwapGearRangeKeys then
						manClutch = self.mrGbMS.ManualClutchHl
					end
	
				--self.mrGbML.G27Gear = self.mrGbML.G27Gear ..", "..tostring(manClutch)
	
					if mrGearboxMogli.mrGbMCheckGrindingGears( self, manClutch, noEventSend ) then
					-- do nothing 
					elseif gear == 0 then
						self:mrGbMSetNeutralActive( true, false, true )	
						self:mrGbMSetState( "G27Mode", 1 ) 
					else
						if self.mrGbMS.G27Gears[7] < 0 then
							self:mrGbMSetReverseActive( (gear < 0) )
						end
						
						if self.mrGbMS.SwapGearRangeKeys then
							self:mrGbMSetCurrentRange(math.abs(gear), false, true)
							curGear = self.mrGbMS.CurrentRange
						else
							self:mrGbMSetCurrentGear(math.abs(gear), false, true)
							curGear = self.mrGbMS.CurrentGear
						end
						
						if self.mrGbMS.ReverseActive then
							curGear = -curGear 
						end			

						self:mrGbMSetState( "G27Mode", 2 ) 
					--if not self:mrGbMGetAutoStartStop() then
						self:mrGbMSetNeutralActive( false, false, true )
						self:mrGbMSetState( "AutoHold", false )											
					--end
					end
				end
				
			--self.mrGbML.G27Gear = self.mrGbML.G27Gear .." => "..tostring(self.mrGbMS.G27Mode)
				
			elseif self.mrGbMS.G27Mode > 0 then
				self:mrGbMSetState( "G27Mode", 0 ) 

			--self.mrGbML.G27Gear = self.mrGbML.G27Gear .." => off"				
			end
		end
	end
	
	if      self.isServer 
			and self:mrGbMGetOnlyHandThrottle()
			and not ( self.isMotorStarted ) then
		-- no hand throttle w/o motor
		self:mrGbMSetHandThrottle( 0 )
	end

--**********************************************************************************************************					
	if self.isMotorStarted and self.mrGbML.motor ~= nil then
		-- switch the motor 
		self.motor = self.mrGbML.motor
		
		if self.mrGbMS.BlowOffVentilVolume > 0 then			
			if self.isEntered and mrGearboxMogli.mbIsSoundActive( self ) and self.mrGbMS.BlowOffVentilPlay then
				self.mrGbMS.BlowOffVentilPlay = false
				
				if self.mrGbMS.BlowOffVentilFile == nil then
					if mrGearboxMogli.BOVSample == nil then
						mrGearboxMogli.BOVSample = createSample("mrGearboxMogliBOVSample")
						local fileName = Utils.getFilename( "blowOffVentil.wav", mrGearboxMogli.baseDirectory )
						loadSample(mrGearboxMogli.BOVSample, fileName, false)
					end
					playSample(mrGearboxMogli.BOVSample, 1, self.mrGbMS.BlowOffVentilVolume, 0)	
				else
					if self.mrGbML.blowOffVentilSample == nil then
						self.mrGbML.blowOffVentilSample = createSample("mrGearboxMogliBOVSample")
						loadSample( self.mrGbML.blowOffVentilSample, self.mrGbMS.BlowOffVentilFile, false )
					end
					playSample( self.mrGbML.blowOffVentilSample, 1, self.mrGbMS.BlowOffVentilVolume, 0 )	
				end
			end
		end
		
		if self.mrGbMS.GrindingSoundVolume > 0 then
			if mrGearboxMogli.mbIsSoundActive( self ) and self.mrGbMS.GrindingGearsVol > 0 then
				local v = self.mrGbMS.GrindingGearsVol
				self.mrGbMS.GrindingGearsVol = 0

				local sample = nil
				
				if self.mrGbMS.GrindingSoundFile == nil then
					if mrGearboxMogli.GrindingSample == nil then
						mrGearboxMogli.GrindingSample = createSample("mrGearboxMogliGrindingSample")
						local fileName = Utils.getFilename( "grinding.wav", mrGearboxMogli.baseDirectory )
						loadSample(mrGearboxMogli.GrindingSample, fileName, false)
					end
					sample = mrGearboxMogli.GrindingSample
				else
					if self.mrGbML.grindingSample == nil then
						self.mrGbML.grindingSample = createSample("mrGearboxMogliGrindingSample")
						loadSample(self.mrGbML.grindingSample, self.mrGbMS.GrindingSoundFile, false)
					end
					sample = self.mrGbML.grindingSample
				end
				
				
				if sample ~= nil then
					if     v <= 0 then
						self.mrGbML.grindingSampleEnd = nil
						self.mrGbML.grindingSampleVol = nil
						stopSample( sample )
					elseif self.mrGbML.grindingSampleEnd == nil 
							or self.mrGbML.grindingSampleEnd < g_currentMission.time
							or self.mrGbML.grindingSampleVol < v then
						self.mrGbML.grindingSampleEnd = g_currentMission.time + getSampleDuration( sample )
						self.mrGbML.grindingSampleVol = v
						playSample( sample, 1, v * self.mrGbMS.GrindingSoundVolume, 0 )	
					end
				end
			end
		end
				
--**********************************************************************************************************			
		-- this is from Motorized.lua 
		local minRpm = self.motor:getMinRpm();
		local maxRpm = self.motor:getMaxRpm();
		local maxSpeed; 
		if self.movingDirection >= 0 then
			maxSpeed = self.motor:getMaximumForwardSpeed()*0.001;
		else
			maxSpeed = self.motor:getMaximumBackwardSpeed()*0.001;
		end
		local motorRpm = self.motor:getEqualizedMotorRpm();
		-- Increase the motor rpm to the max rpm if faster than 75% of the full speed
		if self.movingDirection > 0 and self.lastSpeed > 0.75*maxSpeed and motorRpm < maxRpm then
			motorRpm = motorRpm + (maxRpm - motorRpm) * math.min((self.lastSpeed-0.75*maxSpeed) / (0.25*maxSpeed), 1);
		end
		-- The actual rpm offset is 50% from the motor and 50% from the speed
		local targetRpmOffset = (motorRpm - minRpm)*0.5 + math.min(self.lastSpeed/maxSpeed, 1)*(maxRpm-minRpm)*0.5;
		local alpha = math.pow(0.01, dt*0.001);
		local roundPerMinute = targetRpmOffset + alpha*(self.lastRoundPerMinute-targetRpmOffset);
				
		local realRpmOffset     = motorRpm - minRpm
		self.lastRoundPerMinute = targetRpmOffset + ( realRpmOffset - targetRpmOffset ) / alpha
						
--**********************************************************************************************************			
	end
	
--**********************************************************************************************************			
-- sound pitch and volume
--**********************************************************************************************************			
	
	if      self:getIsMotorStarted()
			and self.isClient
			and mrGearboxMogli.hackSounds
			and ( (self.wheels ~= nil and table.getn(self.wheels) > 0) 
				 or (self.dummyWheels ~= nil and table.getn(self.dummyWheels) > 0) )
			then
		
		self.mrGbML.soundModified	= true
		
		local minRpm = self.mrGbMS.CurMinRpm
		local maxRpm = self.mrGbMS.CurMaxRpm
		local roundPerMinute = self:mrGbMGetCurrentRPM() - minRpm
		local roundPerSecondSmoothed = roundPerMinute / 60;
		if self.sampleMotor.sample ~= nil then
			local motorSoundPitch = math.min(self.mrGbMS.Sound.IdlePitchOffset + self.mrGbMS.Sound.IdlePitchScale*math.abs(roundPerSecondSmoothed), self.mrGbMS.Sound.IdlePitchMax);
			mrGearboxMogli.setSamplePitch(self.sampleMotor, motorSoundPitch);
			local deltaVolume = (self.sampleMotor.volume - self.motorSoundVolumeMin) * math.max(0.0, math.min(1.0, self:getLastSpeed()/self.motorSoundVolumeMinSpeed))
			mrGearboxMogli.setSampleVolume(self.sampleMotor, math.max(self.motorSoundVolumeMin, self.sampleMotor.volume - deltaVolume));
		end;
		if self.sampleMotorRun.sample ~= nil then
			local motorSoundRunPitch = math.min(self.mrGbMS.Sound.RunPitchOffset + self.mrGbMS.Sound.RunPitchScale*math.abs(roundPerSecondSmoothed), self.mrGbMS.Sound.RunPitchMax);
			mrGearboxMogli.setSamplePitch(self.sampleMotorRun, motorSoundRunPitch);
			local runVolume = roundPerMinute/(maxRpm - minRpm);
			runVolume = 0.65 * Utils.clamp(runVolume, 0.0, 1.0) + 0.5 * Utils.clamp( self.motorSoundLoadFactor - 0.3, 0.0, 0.7 )
			if self.sampleMotorLoad.sample == nil then
				mrGearboxMogli.setSampleVolume(self.sampleMotorRun, runVolume * self.sampleMotorRun.volume);
			else
				local motorSoundLoadPitch = math.min(self.mrGbMS.Sound.LoadPitchOffset + self.mrGbMS.Sound.LoadPitchScale*math.abs(roundPerSecondSmoothed), self.mrGbMS.Sound.LoadPitchMax);
				mrGearboxMogli.setSamplePitch(self.sampleMotorLoad, motorSoundLoadPitch);
				mrGearboxMogli.setSampleVolume(self.sampleMotorRun,  math.max(self.motorSoundRunMinimalVolumeFactor, (1.0 - self.motorSoundLoadFactor) * runVolume * self.sampleMotorRun.volume) );
				mrGearboxMogli.setSampleVolume(self.sampleMotorLoad, math.max(self.motorSoundLoadMinimalVolumeFactor, self.motorSoundLoadFactor * runVolume * self.sampleMotorLoad.volume) );
			end
		end
	elseif self.sampleMotorLoad.sample ~= nil and self.motorSoundLoadFactor > 0.5 then
	-- at least half of the motor sound load volume even at low RPM
		self.motorSoundLoadMinimalVolumeFactor = math.max( self.mrGbMS.Sound.LoadMinimalVolumeFactor, ( self.motorSoundLoadFactor - 0.5 ) * self.sampleMotorLoad.volume )
	end			

	if      self.steeringEnabled 
			and self.isServer 
			and not ( self.isEntered or self.isControlled ) then
	
--**********************************************************************************************************			
-- drive control parallel mode
--**********************************************************************************************************			
		if      self.dCcheckModule                  ~= nil
				and self.driveControl                   ~= nil
				and self:dCcheckModule("cruiseControl")  
				and self.driveControl.cruiseControl     ~= nil
			--and g_currentMission.controlledVehicle  ~= self 
				and self.cruiseControl.state             > 0 then
				
			local rootVehicle = self:getRootAttacherVehicle();
				
			if self.driveControl.cruiseControl.mode == self.driveControl.cruiseControl.MODE_STOP_FULL then
				local trailerFillLevel, trailerCapacity = rootVehicle:getAttachedTrailersFillLevelAndCapacity()
				if trailerFillLevel~= nil and trailerCapacity~= nil then
					if trailerFillLevel >= trailerCapacity then
						self:setCruiseControlState(0);
					end;
				end;
				self.driveControl.cruiseControl.refVehicle = nil;
			elseif self.driveControl.cruiseControl.mode == self.driveControl.cruiseControl.MODE_STOP_EMPTY then
				local trailerFillLevel, trailerCapacity = rootVehicle:getAttachedTrailersFillLevelAndCapacity()
				if trailerFillLevel~= nil and trailerCapacity~= nil then
					if trailerFillLevel <= 0 then
						self:setCruiseControlState(0);
					end;
				end;
				self.driveControl.cruiseControl.refVehicle = nil;
			elseif  self.driveControl.cruiseControl.mode                == self.driveControl.cruiseControl.MODE_PARALLEL
					and self.driveControl.cruiseControl.refVehicle          ~= nil
					and self.driveControl.cruiseControl.refVehicle.rootNode ~= nil then
				local dx, _, dz = localDirectionToWorld(rootVehicle.rootNode, 0, 0, 1)
				local sdx, _, sdz = localDirectionToWorld(self.driveControl.cruiseControl.refVehicle.rootNode, 0, 0, 1)
											
				local diffAngle = (dx*sdx + dz*sdz)/(math.sqrt(dx^2+dz^2)*math.sqrt(sdx^2+sdz^2))
				diffAngle = math.acos(diffAngle);
				
				if diffAngle > math.rad(20) then
					self:setCruiseControlState(0);
				else				
					self:setCruiseControlMaxSpeed(self.driveControl.cruiseControl.refVehicle.lastSpeed*3600/math.cos(diffAngle))
					self.cruiseControl.wasSpeedChanged = true;
					self.cruiseControl.changeCurrentDelay = 0;

					if g_server ~= nil then
						g_server:broadcastEvent(SetCruiseControlSpeedEvent:new(self, self.cruiseControl.speed), nil, nil, self)
					else
						g_client:getServerConnection():sendEvent(SetCruiseControlSpeedEvent:new(self, self.cruiseControl.speed))
					end

					self.cruiseControl.speedSent = self.cruiseControl.speed
				end
			end
		end

	
--**********************************************************************************************************			
-- keep on going if not entered 
--**********************************************************************************************************			
		if      self.cruiseControl.state ~= Drivable.CRUISECONTROL_STATE_OFF then	
			Drivable.updateVehiclePhysics(self, 0, false, 0, false, dt)
		elseif  not self.mrGbMS.NeutralActive
				and ( self.mrGbMS.AutoClutch or self.mrGbMS.AutoStartStop or self.mrGbMS.AllAuto ) then
			self:mrGbMSetNeutralActive( true, false, true )
			self:mrGbMSetState( "AutoHold", true )
			Drivable.updateVehiclePhysics(self, 1, false, 0, false, dt)
		end
	end	
end 

--**********************************************************************************************************	
-- mrGearboxMogli:addCutterArea
--**********************************************************************************************************	
function mrGearboxMogli:addCutterArea( cutter, area, realArea, inputFruitType, fruitType )
	if self.mrGbMS.IsCombine and 0 < area then
		self.mrGbML.currentRealArea    = self.mrGbML.currentRealArea + realArea	
		if self.mrGbML.maxRealArea     < self.mrGbML.currentRealArea then
			self.mrGbML.maxRealArea      = self.mrGbML.currentRealArea
		end
		
		local timeAdd = Utils.getNoNil( self.strawToggleTime, 2000 ) 
		if timeAdd > 500 and self.mrGbML.maxRealArea > 0 then
			timeAdd = 500 + ( 1 - self.mrGbML.currentRealArea / self.mrGbML.maxRealArea ) * ( timeAdd - 500 )
		end
		
		self.mrGbML.currentCuttersArea    = self.mrGbML.currentCuttersArea + area
		self.mrGbML.currentInputFruitType = inputFruitType 
		self.mrGbML.currentFruitType      = fruitType 
		if self.mrGbML.strawDisableTime == nil then
			self.mrGbML.strawDisableTime = g_currentMission.time + timeAdd 
		else
			self.mrGbML.strawDisableTime = math.max( self.mrGbML.strawDisableTime, g_currentMission.time + timeAdd )
		end
	end
end

--**********************************************************************************************************	
-- mrGearboxMogli:setIsReverseDriving
--**********************************************************************************************************	
function mrGearboxMogli:setIsReverseDriving( isReverseDriving, noEventSend )
	if      self.isServer 
			and self.mrGbMS ~= nil
			and self.mrGbMS.IsOn
			then
		self:mrGbMSetReverseActive( not self.mrGbMS.ReverseActive ) 
	end
end

--**********************************************************************************************************	
-- mrGearboxMogli:onLeave
--**********************************************************************************************************	
function mrGearboxMogli:onLeave()
	if self.mrGbMS == nil or self.mrGbML == nil or self.mrGbML.motor == nil then
		return
	end

	if      self.steeringEnabled 
			and self.mrGbMS.IsOn 
			and self.cruiseControl.state == Drivable.CRUISECONTROL_STATE_OFF
			and ( self:mrGbMGetAutoClutch() or self:mrGbMGetAutomatic() or self:mrGbMGetAutoStartStop() ) then 
		self:mrGbMSetNeutralActive( true, false, true )
		if self:mrGbMGetAutoHold() then
			self:mrGbMSetState( "AutoHold", true )
		end
		self:mrGbMSetState( "IsNeutral", true )
	end
end

--**********************************************************************************************************	
-- mrGearboxMogli:updateTick
--**********************************************************************************************************	
function mrGearboxMogli:updateTick(dt)

	if self.mrGbMS == nil or self.mrGbML == nil or self.mrGbML.motor == nil then
		return
	end	
	
	if self.isActive then
		if self.isServer then
			if not ( self.mrGbMS.IsOnOff ) then
				self:mrGbMSetState( "IsOn", false ) 
			elseif not ( self.steeringEnabled ) then
				
				if  self.mrGbMS.EnableAI ~= mrGearboxMogli.AIGearboxOff then
					self:mrGbMSetState( "IsOn", true ) 
				
					if not ( self.mrGbML.aiControlled ) then
						self.mrGbML.aiControlled    = true
						self.mrGbML.aiBackupGear    = self.mrGbMS.CurrentGear
						self.mrGbML.aiBackupRange   = self.mrGbMS.CurrentRange 
						self.mrGbML.aiBackupRange2  = self.mrGbMS.CurrentRange2 
						self.mrGbML.aiBackupReverse = self.mrGbMS.ReverseActive 
						
						self:mrGbMSetReverseActive( false )
						
						if self.aiIsStarted then
							if self.mrGbMS.MaxAIRange2 ~= nil and self.mrGbMS.MaxAIRange2 < self.mrGbMS.CurrentRange2 then
								self:mrGbMSetCurrentRange2( self.mrGbMS.MaxAIRange2 ) 	
							end
							if self:mrGbMGetAutomatic() then
								mrGearboxMogli.setLaunchGear( self, false, true )
							end
							if self.mrGbMS.MaxAIRange ~= nil and self.mrGbMS.MaxAIRange < self.mrGbMS.CurrentRange then
								self:mrGbMSetCurrentRange( self.mrGbMS.MaxAIRange ) 	
							end
							if self.mrGbMS.MaxAIGear  ~= nil and self.mrGbMS.MaxAIGear  < self.mrGbMS.CurrentGear  then
								self:mrGbMSetCurrentGear( self.mrGbMS.MaxAIGear ) 	
							end
						elseif self:mrGbMGetAutomatic() then
							mrGearboxMogli.setLaunchGear( self, false, true )
						end
						
					elseif self.mrGbML.gearShiftingNeeded == 0 then
						if self.mrGbMS.ReverseActive then
							self.mrGbML.aiGearR  = self.mrGbMS.CurrentGear
							self.mrGbML.aiRangeR = self.mrGbMS.CurrentRange
						else
							self.mrGbML.aiGearF  = self.mrGbMS.CurrentGear
							self.mrGbML.aiRangeF = self.mrGbMS.CurrentRange
						end
					end					
				else
					self:mrGbMSetState( "IsOn", false ) 	
				end

			elseif self.mrGbML.aiControlled then
				self.mrGbML.aiControlled = false
				self:mrGbMSetNeutralActive( true, false, true )
				self:mrGbMSetState( "AutoHold", true )
				self:mrGbMSetState( "IsOn", true ) 

				self:mrGbMSetReverseActive( self.mrGbML.aiBackupReverse )
				if self.mrGbMS.CurrentRange2 ~= self.mrGbML.aiBackupRange2 then
					self:mrGbMSetCurrentRange2( self.mrGbML.aiBackupRange2 ) 	
				end
				if self.mrGbMS.CurrentRange ~= self.mrGbML.aiBackupRange then
					self:mrGbMSetCurrentRange( self.mrGbML.aiBackupRange ) 	
				end
				if self.mrGbMS.CurrentGear ~= self.mrGbML.aiBackupGear then
					self:mrGbMSetCurrentGear( self.mrGbML.aiBackupGear ) 	
				end
				
			else		
				self:mrGbMSetState( "IsOn", true ) 
			end 	
			
		--if not ( self.isMotorStarted ) or g_currentMission.time < self.motorStartTime then
		--	self:mrGbMSetNeutralActive( true, false, true )
		--	self:mrGbMSetState( "AutoHold", true )
		--end
			
			if  not ( self.mrGbMS.Automatic ) 
					and self.mrGbMS.DisableManual then
				self:mrGbMSetAutomatic( true ) 
			end
	
			if self.mrGbMS.Automatic and not ( self.mrGbMS.HydrostaticLaunch ) then
				if self.mrGbMS.AutoShiftGears and self.mrGbMS.ManualClutchGear then
					self:mrGbMSetAutoClutch( true ) 
				end
				if self.mrGbMS.AutoShiftHl and self.mrGbMS.ManualClutchHl then
					self:mrGbMSetAutoClutch( true ) 
				end
			end 	
		end
		
		if self.mrGbMS.IsOn and self.mrGbML.motor ~= nil and self.motor == self.mrGbML.motor then	
			self.mrGbML.lastSumDt = self.mrGbML.lastSumDt + dt
					
			local maxSumDt = 333
			if self.mrGbMS.NoUpdateStream then
				maxSumDt = 1000
			end
			
			if self.mrGbML.lastSumDt > maxSumDt then
				if self.isServer then
					self.mrGbMD.Rpm    = 0
					self.mrGbMD.Tgt    = 0
					self.mrGbMD.Clutch = 0
          self.mrGbMD.Load   = 0
					self.mrGbMD.Power  = 0
					self.mrGbMD.Hydro  = 255
					
					if self.isMotorStarted then
						self.mrGbMD.Rpm    = tonumber( Utils.clamp( math.floor( 200*(self.motor.lastMotorRpm-self.mrGbMS.StallRpm)/(self.mrGbMS.RatedRpm-self.mrGbMS.StallRpm)+0.5), 0, 255 ))	 				
						if self.motor.targetRpm     ~= nil then
							self.mrGbMD.Tgt  = tonumber( Utils.clamp( math.floor( 200*(self.motor.targetRpm-self.mrGbMS.StallRpm)/(self.mrGbMS.RatedRpm-self.mrGbMS.StallRpm)+0.5), 0, 255 ))	 				
						end
						self.mrGbMD.Clutch = tonumber( Utils.clamp( math.floor( mrGearboxMogli.mrGbMGetAutoClutchPercent( self ) * 200+0.5), 0, 255 ))	
						if self.motor.motorLoadS    ~= nil then
							self.mrGbMD.Load = tonumber( Utils.clamp( math.floor( self.motor.motorLoadS*20+0.5)*5, 0, 255 ))	
						end
						if      self.mrGbMS.sendReqPower 
								and self.motor.motorLoad              ~= nil
								and self.motor.lastPtoTorque          ~= nil
								and self.motor.lastLostTorque         ~= nil
								and self.motor.prevNonClampedMotorRpm ~= nil
								and self.motor.stallRpm               ~= nil then
							local power = ( self.motor.motorLoad + self.motor.lastPtoTorque + self.motor.lastLostTorque ) * math.max( self.motor.prevNonClampedMotorRpm, self.motor.stallRpm )
							self.mrGbMD.Power  = tonumber( Utils.clamp( math.floor( power * mrGearboxMogli.powerFactor0 / self.mrGbMG.torqueFactor + 0.5 ), 0, 65535 ))	
						end
						if self.motor.vehicle.mrGbMS.Hydrostatic and not ( self.motor.noTransmission ) then
							if self.mrGbMS.HydrostaticMax - self.mrGbMS.HydrostaticMin > mrGearboxMogli.eps then
								self.mrGbMD.Hydro = 200 * Utils.clamp( ( self.motor.hydrostaticFactor - self.mrGbMS.HydrostaticMin ) / ( self.mrGbMS.HydrostaticMax - self.mrGbMS.HydrostaticMin ), 0, 1 )
							else
								self.mrGbMD.Hydro = 200
							end
						end
					end

					if     self.mrGbML.motor == nil then
						self.mrGbMD.Speed = 0
					else
						self.mrGbMD.Speed  = tonumber( Utils.clamp( math.floor( self.mrGbML.currentGearSpeed * self.mrGbMS.NormSpeedFactorS + 0.5 ), 0, 255 ))	
					end
					
					self.mrGbMD.Rate     = tonumber( Utils.clamp( math.floor( mrGearboxMogli.mrGbMGetThroughPutS( self ) + 0.5 ), 0, 255 ))						
					
					if     self.mrGbMD.lastClutch ~= self.mrGbMD.Clutch
							or self.mrGbMD.lastLoad   ~= self.mrGbMD.Load   
							or self.mrGbMD.lastSpeed  ~= self.mrGbMD.Speed 
							or self.mrGbMD.lastRpm    ~= self.mrGbMD.Rpm
							or ( self.mrGbMS.sendHydro     and self.mrGbMD.lastHydro  ~= self.mrGbMD.Hydro )
							or ( self.mrGbMS.sendTargetRpm and self.mrGbMD.lastTgt    ~= self.mrGbMD.Tgt   )
							or ( self.mrGbMS.sendReqPower  and self.mrGbMD.lastPower  ~= self.mrGbMD.Power )
							or ( self.mrGbMS.IsCombine     and self.mrGbMD.lastRate   ~= self.mrGbMD.Rate  )
							then
						self.mrGbMD.lastRpm    = self.mrGbMD.Rpm
						self.mrGbMD.lastTgt    = self.mrGbMD.Tgt
						self.mrGbMD.lastClutch = self.mrGbMD.Clutch
						self.mrGbMD.lastLoad   = self.mrGbMD.Load   
						self.mrGbMD.lastSpeed  = self.mrGbMD.Speed 
						self.mrGbMD.lastPower  = self.mrGbMD.Power 
						self.mrGbMD.lastRate   = self.mrGbMD.Rate
						self.mrGbMD.lastHydro  = self.mrGbMD.Hydro

						if self.mrGbMS.NoUpdateStream then					
							local message = {}
							message.Clutch = self.mrGbMD.Clutch
							message.Load   = self.mrGbMD.Load  
							message.Speed  = self.mrGbMD.Speed 	 			
							
							if self.mrGbMS.sendHydro     then message.Hydro = self.mrGbMD.Hydro end		 
							if self.mrGbMS.sendTargetRpm then message.Rpm   = self.mrGbMD.Tgt   end			
							if self.mrGbMS.sendReqPower  then message.Power = self.mrGbMD.Power end			
							if self.mrGbMS.IsCombine     then message.Rate  = self.mrGbMD.Rate  end		
							
							self:mrGbMSetState( "NUSMessage", message )
						else
							self:raiseDirtyFlags(self.mrGbML.dirtyFlag) 
						end 
					end 
				end
				
				if self.mrGbML.lastFuelFillLevel == nil then
					self.mrGbML.lastFuelFillLevel = self.fuelFillLevel
					self.mrGbMD.Fuel              = 0
				else
					local fuelUsed = self.mrGbML.lastFuelFillLevel - self.fuelFillLevel
					self.mrGbML.lastFuelFillLevel = self.fuelFillLevel
					if self.isFuelFilling then
						fuelUsed = fuelUsed + self.fuelFillLitersPerSecond * self.mrGbML.lastSumDt * 0.001
					end
					local fuelUsageRatio          = fuelUsed * (1000 * 3600) / self.mrGbML.lastSumDt
					self.mrGbMD.Fuel              = self.mrGbMD.Fuel + mrGearboxMogli.smoothMedium * ( fuelUsageRatio - self.mrGbMD.Fuel )
				end 
				
				self.mrGbML.lastSumDt = 0
			end 
		else
			self.mrGbML.lastSumDt         = 0
			self.mrGbML.lastFuelFillLevel = self.fuelFillLevel
		end
	end	
end 

--**********************************************************************************************************	
-- mrGearboxMogli:readUpdateStream
--**********************************************************************************************************	
function mrGearboxMogli:readUpdateStream(streamId, timestamp, connection)
  if connection:getIsServer() and not ( self.mrGbMS.NoUpdateStream ) then
	--if streamReadBool( streamId ) then
		local checkId = streamReadUInt8( streamId )
		if checkId ~= nil and checkId == 178 then
			if self.mrGbMD == nil then
				self.mrGbMD = {}
			end
			self.mrGbMD.Clutch = streamReadUInt8( streamId ) 
			self.mrGbMD.Load   = streamReadUInt8( streamId )  
			self.mrGbMD.Speed  = streamReadUInt8( streamId ) 			 			
			
			if self.mrGbMS.sendHydro     then self.mrGbMD.Hydro  = streamReadUInt8( streamId  ) end		 
			if self.mrGbMS.sendTargetRpm then self.mrGbMD.Tgt    = streamReadUInt8( streamId  ) end			
			if self.mrGbMS.sendReqPower  then self.mrGbMD.Power  = streamReadUInt16( streamId ) end			
			if self.mrGbMS.IsCombine     then self.mrGbMD.Rate   = streamReadUInt8( streamId  ) end		
		elseif checkId == nil or checkId ~= 142 then
			print("mrGearboxMogli: there is another specialization with incorrect readUpdateStream implementation ("..tostring(checkId)..")")
			if self.mrGbMD ~= nil then
				self.mrGbML.updateStreamErrors = self.mrGbML.updateStreamErrors + 1
			end
		end 
  end 
end 

--**********************************************************************************************************	
-- mrGearboxMogli:writeUpdateStream
--**********************************************************************************************************	
function mrGearboxMogli:writeUpdateStream(streamId, connection, dirtyMask)
  if not connection:getIsServer() and not ( self.mrGbMS.NoUpdateStream ) then
		if bitAND(dirtyMask, self.mrGbML.dirtyFlag) ~= 0 then			
			streamWriteUInt8(streamId, 178 )
			streamWriteUInt8(streamId, self.mrGbMD.Clutch ) 
			streamWriteUInt8(streamId, self.mrGbMD.Load   ) 
			streamWriteUInt8(streamId, self.mrGbMD.Speed  ) 	
			
			if self.mrGbMS.sendHydro     then streamWriteUInt8(streamId, self.mrGbMD.Hydro  ) end		 
			if self.mrGbMS.sendTargetRpm then streamWriteUInt8(streamId, self.mrGbMD.Tgt    ) end			
			if self.mrGbMS.sendReqPower  then streamWriteUInt16(streamId,self.mrGbMD.Power ) end			
			if self.mrGbMS.IsCombine     then streamWriteUInt8(streamId, self.mrGbMD.Rate   ) end
		else
			streamWriteUInt8(streamId, 142 )
		end 
	end 
end 

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMOnSetNoUpdateStream
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMOnSetNoUpdateStream( old, new, noEventSend )
	self.mrGbMS.NoUpdateStream = new
	if new and not ( old ) then
		print("mrGearboxMogli: there is another specialization with incorrect readUpdateStream implementation => turning off update stream")
		self.mrGbML.lastSumDt  = 1001
		self.mrGbMD.lastClutch = -1
	elseif old and not ( new ) then 
	end
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMOnSetNUSMessage
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMOnSetNUSMessage( old, new, noEventSend )
	self.mrGbMS.NUSMessage = new
	if type( new ) == "table" then
		for n,v in pairs( new ) do
			self.mrGbMD[n] = v
		end
	end			
end

--**********************************************************************************************************	
-- mrGearboxMogli:delete
--**********************************************************************************************************	
function mrGearboxMogli:delete()
	if self.mrGbML ~= nil then
		if self.mrGbML.blowOffVentilSample ~= nil then
			pcall( delete, self.mrGbML.blowOffVentilSample )
			self.mrGbML.blowOffVentilSample= nil
		end
		if self.mrGbML.grindingSample ~= nil then
			pcall( delete, self.mrGbML.grindingSample )
			self.mrGbML.grindingSample= nil
		end
	end
end

--**********************************************************************************************************	
-- mrGearboxMogli:deleteMap
--**********************************************************************************************************	
function mrGearboxMogli:deleteMap()
	if mrGearboxMogli.backgroundOverlayId ~= nil then
		pcall( delete, mrGearboxMogli.backgroundOverlayId )
		mrGearboxMogli.backgroundOverlayId = nil
	end
	if mrGearboxMogli.BOVSample ~= nil then
		pcall( delete, mrGearboxMogli.BOVSample )
		mrGearboxMogli.BOVSample= nil
	end
end

--**********************************************************************************************************	
-- mrGearboxMogli:draw
--**********************************************************************************************************	
function mrGearboxMogli:draw() 	
	
--if self.mrGbML.motor == nil then return end
	
	if self.mrGbMS.IsOn and self.mrGbMS.showHud and self.mrGbMS.HudMode > 0 then
		if      self.mrGbMS.InfoText ~= nil
				and self.mrGbMS.InfoText ~= "" then
			if g_currentMission.time < self.mrGbML.infoTimer then
				g_currentMission:addExtraPrintText(self.mrGbMS.InfoText)
			else
				self.mrGbMS.InfoText = ""
			end
		end
		
		local gearText = self:mrGbMGetGearText()
		
		if self.mrGbMS.HudMode == 1 then
	
			if mrGearboxMogli.backgroundOverlayId == nil then
				mrGearboxMogli.backgroundOverlayId = createImageOverlay( "dataS2/menu/blank.png" )
				setOverlayColor( mrGearboxMogli.backgroundOverlayId, 0,0,0, 0.4 )
			end	
			
			local ovTop    = self.mrGbMG.hudPositionY   -- title plus 0.03 plus character size of title (0.03)
			local deltaY   = self.mrGbMG.hudTextSize 
			local titleY   = self.mrGbMG.hudTitleSize
			local ovBorder = self.mrGbMG.hudBorder   
			local drawY0   = ovTop - 1.25*deltaY - titleY - self.mrGbMG.hudBorder
			local ovLeft   = self.mrGbMG.hudPositionX + self.mrGbMG.hudBorder
			local ovRight  = self.mrGbMG.hudPositionX + self.mrGbMG.hudWidth - self.mrGbMG.hudBorder            
			                                          
			--==============================================
			-- enable/disable infos
			--==============================================
			local ovRows   = 0
			local infos    = {}
			if     self.mrGbMS.Hydrostatic and self.mrGbMS.DisableManual then
				if gearText ~= "" then			
					ovRows = ovRows + 1 infos[ovRows] = "gear"
				end
			elseif self.mrGbMS.Hydrostatic and self.mrGbMS.ConstantRpm and not self.mrGbMS.AllAuto then
				ovRows = ovRows + 1 infos[ovRows] = "target1"		
			else
				ovRows = ovRows + 1 infos[ovRows] = "speed"
			end
			ovRows = ovRows + 1 infos[ovRows] = "rpm"
			if self.mrGbMG.drawTargetRpm then
				ovRows = ovRows + 1 infos[ovRows] = "target"
			elseif self:mrGbMGetOnlyHandThrottle() or self.mrGbMS.HandThrottle > 0 then
				ovRows = ovRows + 1 infos[ovRows] = "hand"
			end
			if self.mrGbMG.drawReqPower  then
				ovRows = ovRows + 1 infos[ovRows] = "power"
			end
			ovRows = ovRows + 1 infos[ovRows] = "load"
			if self.mrGbMD.Fuel > 0 then
				ovRows = ovRows + 1 infos[ovRows] = "fuel"
			end
			if not self:mrGbMGetAutoClutch() then
				ovRows = ovRows + 1 infos[ovRows] = "clutch"
			elseif self.mrGbMD.Clutch < 200  then
				ovRows = ovRows + 1 infos[ovRows] = "clutch2"
			end
			if self.mrGbMG.debugPrint and self.isServer and self.mrGbMS.IsCombine then
				ovRows = ovRows + 1 infos[ovRows] = "pto"
			elseif self.mrGbMD.Rate ~= nil and self.mrGbMD.Rate > 0 then
				ovRows = ovRows + 1 infos[ovRows] = "combine"
			end
			--==============================================
			
			local ovH      = titleY + ( ovRows + 1 ) * deltaY + self.mrGbMG.hudBorder + self.mrGbMG.hudBorder-- title is 0.03 points above drawY0; add border of 0.01 x 2
			local ovY      = ovTop - ovH
			
			renderOverlay( mrGearboxMogli.backgroundOverlayId, self.mrGbMG.hudPositionX, ovY, self.mrGbMG.hudWidth, ovH )
		
			setTextAlignment(RenderText.ALIGN_LEFT) 
			setTextColor(1, 1, 1, 1) 

			setTextBold(true) 
			renderText(ovLeft, drawY0 + titleY, titleY, self.mrGbMS.DrawText) 			     	
			setTextBold(false) 
			
			--==============================================
			-- render infos
			--==============================================
			local drawY
			
			local speed = self:mrGbMGetGearSpeed()
			if self.mrGbMS.MaxSpeedLimiter then
				if self.mrGbMS.ReverseActive then
					if self.motor.maxBackwardSpeed ~= nil then
						speed = math.min( speed, 3.6 * self.motor.maxBackwardSpeed )
					end
				else
					if self.motor.maxForwardSpeed ~= nil then
						speed = math.min( speed, 3.6 * self.motor.maxForwardSpeed )
					end
				end
			end					
			
			
			for col=1,2 do
				drawY = drawY0 
				
				if col == 1 then
					setTextAlignment(RenderText.ALIGN_LEFT) 
				else
					setTextAlignment(RenderText.ALIGN_RIGHT) 
				end
				
				for row,info in pairs( infos ) do
				
					if     info == "gear" then
						if col == 1 then
							renderText(ovLeft, drawY, deltaY, gearText) 	
						end
					elseif info == "speed" then
						if col == 1 then
							local t
							if gearText == "" then
								t = "Max. speed"
							else
								t = gearText
							end
							renderText(ovLeft, drawY, deltaY, t) 	
						else
							renderText(ovRight,drawY, deltaY, string.format("%3.1f km/h", speed ))
						end
					elseif info == "target1" then
						if col == 1 then
							local t
							if gearText == "" then
								t = "Max. speed"
							else
								t = gearText
							end
							renderText(ovLeft, drawY, deltaY, t) 	
						else
							local ir = self.mrGbMS.IdleRpm / self.mrGbMS.RatedRpm
							local sp = math.min( speed, self:mrGbMGetGearSpeed() * ( ir + self.mrGbMS.HandThrottle * ( 1 - ir ) ) )
							renderText(ovRight,drawY, deltaY, string.format("%3.1f km/h", sp ))
						end
					elseif info == "target3" then
						renderText(ovRight, drawY, deltaY, string.format("%3d %%", math.floor( self.mrGbMD.Hydro * 0.5 + 0.5 ) ))  		
					elseif info == "rpm" then
						if col == 1 then
							renderText(ovLeft, drawY, deltaY, "Current rpm")
						else
							renderText(ovRight, drawY, deltaY, string.format("%4.0f rpm", math.floor( self:mrGbMGetCurrentRPM() * 0.1 +0.5)*10)) 		
						end
					elseif info == "target" then
						if col == 1 then
							renderText(ovLeft, drawY, deltaY, "Target rpm")
						else
							renderText(ovRight, drawY, deltaY, string.format("%4.0f rpm", math.floor( self:mrGbMGetTargetRPM() * 0.1 +0.5)*10)) 		
						end
					elseif info == "power" then
						if col == 1 then
							renderText(ovLeft, drawY, deltaY, "Power")
						else
							renderText(ovRight, drawY, deltaY, string.format("%4.0f HP", self:mrGbMGetUsedPower() ))
						end
					elseif info == "load" then
						if col == 1 then
							renderText(ovLeft, drawY, deltaY, "Load")
						else
							renderText(ovRight, drawY, deltaY, string.format("%3d %%", self.mrGbMD.Load )) 
						end
					elseif info == "fuel" then
						if col == 1 then
							renderText(ovLeft, drawY, deltaY, "Fuel used")
						else
							renderText(ovRight, drawY, deltaY, string.format("%3d l/h", self.mrGbMD.Fuel ))
						end
					elseif info == "clutch" then
						if col == 1 then
							renderText(ovLeft, drawY, deltaY, "Clutch")
						else
							renderText(ovRight, drawY, deltaY, string.format("%3.0f %%", math.floor( self.mrGbMS.ManualClutch * 100 + 0.5 ) ))
						end
					elseif info == "clutch2" then
						if col == 1 then
							renderText(ovLeft, drawY, deltaY, "Auto clutch")
						else
							renderText(ovRight, drawY, deltaY, string.format("%3.0f %%", self.mrGbMD.Clutch*0.5 ))
						end
					elseif info == "hand" then
						if col == 1 then
							renderText(ovLeft, drawY, deltaY, "Hand throttle")	
						else
						--renderText(ovRight, drawY, deltaY, string.format("%3d %%", math.floor( self.mrGbMS.HandThrottle * 100 + 0.5 ) ))
							local r = self.mrGbMS.IdleRpm + self.mrGbMS.HandThrottle * ( self.mrGbMS.RatedRpm - self.mrGbMS.IdleRpm )
							renderText(ovRight, drawY, deltaY, string.format("%4.0f rpm", math.floor( r * 0.1 +0.5)*10)) 		
						end
					elseif info == "combine" then
						if col == 1 then
							renderText(ovLeft, drawY, deltaY, "Combine")	
						else
							renderText(ovRight, drawY, deltaY, string.format("%3.0f t/h", self.mrGbMD.Rate ) )
						end
					elseif info == "pto" then
						if col == 1 then
							renderText(ovLeft, drawY, deltaY, "PTO Debug")	
						else
							local f = math.max( self.motor.prevNonClampedMotorRpm, self.motor.stallRpm ) 
							local p = f*self.motor.motorLoad     
											+ f*self.motor.lastPtoTorque  
											+ f*self.motor.lastLostTorque 
											+ f*self.motor.lastMissingTorque 
							if     self.motor.lastMissingTorque > 0 then
								setTextColor(1, 0, 0, 1) 
							elseif 0.2 * self.motor.lastPtoTorque > 0.8 * self.motor.motorLoad then
								setTextColor(1, 1, 0, 1) 
							else
								setTextColor(0, 1, 0, 1) 
							end
							renderText(ovRight, drawY, deltaY, string.format("%3.0f %%", 100 * p / self.motor.maxPower ) )  		          
							setTextColor(1, 1, 1, 1) 
						end
					end
					
					drawY = drawY - deltaY
				end
			end
			--==============================================

			
			drawY = drawY + 0.25*deltaY
			renderText(ovRight, drawY, 0.5*deltaY, mrGearboxMogli.getText( "mrGearboxMogliVERSION", "Gearbox by mogli" ) )  		          

			if InputBinding.mrGearboxMogliON_OFF ~= nil and not self.mrGbMS.NoDisable then
				g_currentMission:addHelpButtonText(mrGearboxMogli.getText("mrGearboxMogliON", "Gearbox [on]"),  InputBinding.mrGearboxMogliON_OFF);		
			end

			if InputBinding.mrGearboxMogliAllAuto ~= nil then
				if self.mrGbMS.AllAuto then
					g_currentMission:addHelpButtonText(mrGearboxMogli.getText("mrGearboxMogliAllAutoON", "All auto [on]"),  InputBinding.mrGearboxMogliAllAuto);	
				elseif self:mrGbMGetHasAllAuto() and self.steeringEnabled then
					g_currentMission:addHelpButtonText(mrGearboxMogli.getText("mrGearboxMogliAllAutoOFF", "All auto [off]"),  InputBinding.mrGearboxMogliAllAuto);		
				end
			end
			
		elseif self.mrGbMS.HudMode == 2 then
			setTextBold(true)
			
			local w = math.floor(0.0095 * g_screenWidth) / g_screenWidth
		--local t = w * g_screenAspectRatio
			local t = 0.5*self.mrGbMG.hudTextSize
			local d = 0.25*t
			
			local text = self.mrGbMS.DrawText2 .." "..gearText
			
      local x = self.mrGbMG.hudPositionX + self.mrGbMG.hudWidth - self.mrGbMG.hudBorder 
      local y = self.mrGbMG.hudPositionY
			setTextAlignment(RenderText.ALIGN_RIGHT) 
			renderText( x, y, t, text )

			if InputBinding.mrGearboxMogliHUD ~= nil then
				g_currentMission:addHelpButtonText(mrGearboxMogli.getText("mrGearboxMogliHUD", "Gearbox HUD"),  InputBinding.mrGearboxMogliHUD);		
			end
		end
			
		setTextAlignment(RenderText.ALIGN_LEFT) 
		setTextBold(false)
		
		local revShow = self.mrGbMS.ReverseActive
		if self.isReverseDriving then
			revShow = not revShow
		end
			
		if not ( self:mrGbMGetNeutralActive() ) then
			if revShow then
				mrGearboxMogli.ovArrowDownWhite:render()
			else
				mrGearboxMogli.ovArrowUpWhite:render()
			end
		elseif self:mrGbMGetAutoStartStop() then
			if revShow then
				mrGearboxMogli.ovArrowDownGray:render()
			else
				mrGearboxMogli.ovArrowUpGray:render()
			end
		else
			if revShow then
				mrGearboxMogli.ovHandBrakeDown:render()
			else
				mrGearboxMogli.ovHandBrakeUp:render()
			end
		end
			
	else
		if InputBinding.mrGearboxMogliON_OFF ~= nil and not self.mrGbMS.NoDisable then
			g_currentMission:addHelpButtonText(mrGearboxMogli.getText("mrGearboxMogliOFF", "Gearbox [off]"), InputBinding.mrGearboxMogliON_OFF);		
		end
	end
	
end 

--**********************************************************************************************************	
-- mrGearboxMogli:getSaveAttributesAndNodes
--**********************************************************************************************************	
function mrGearboxMogli:getSaveAttributesAndNodes(nodeIdent)

	local attributes = ""

	if self.mrGbMS ~= nil then
		if      self.mrGbMS.CurrentGear ~= self.mrGbMS.LaunchGear
				and not self:mrGbMGetAutoShiftGears() then
			attributes = attributes.." mrGbMCurrentGear=\""  .. tostring(self.mrGbMS.CurrentGear  ) .. "\""
		end
		if      self.mrGbMS.CurrentRange ~= self.mrGbMS.LaunchRange
				and not self:mrGbMGetAutoShiftRange() then
			attributes = attributes.." mrGbMCurrentRange=\"" .. tostring(self.mrGbMS.CurrentRange ) .. "\""
		end
		if self.mrGbMS.CurrentRange2 ~= self.mrGbMS.LaunchRange2 then
			attributes = attributes.." mrGbMCurrentRange2=\"" ..tostring(self.mrGbMS.CurrentRange2 ) .. "\""
		end
		if self.mrGbMS.G27Mode > 0 then
			attributes = attributes.." mrGbMG27Mode=\"" ..tostring(self.mrGbMS.G27Mode ) .. "\""
		end
		if not ( self.mrGbMS.AutoClutch ) then
			attributes = attributes.." mrGbMAutoClutch=\"" .. tostring(self.mrGbMS.AutoClutch ) .. "\""
		end
		if    self.mrGbMS.AllAuto then
			attributes = attributes.." mrGbMAllAuto=\"" .. tostring( self.mrGbMS.AllAuto ) .. "\""  
		elseif not ( self.mrGbMS.Automatic ) and ( self.mrGbMS.AutoShiftGears or self.mrGbMS.AutoShiftHl ) then
			attributes = attributes.." mrGbMAutomatic=\"" .. tostring( self.mrGbMS.Automatic ) .. "\""  
		end
		if self.mrGbMS.DefaultOn ~= self.mrGbMS.IsOnOff then
			attributes = attributes.." mrGbMIsOnOff=\"" .. tostring( self.mrGbMS.IsOnOff ) .. "\""     
		end
		if self.mrGbMS.EcoMode then
			attributes = attributes.." mrGbMEcoMode=\"" .. tostring( self.mrGbMS.EcoMode ) .. "\""     
		end
		if self.mrGbMG.defaultHudMode ~= self.mrGbMS.HudMode then
			attributes = attributes.." mrGbMHudMode=\"" .. tostring( self.mrGbMS.HudMode ) .. "\""     
		end
		if self.mrGbMS.AccelerateToLimit <= 4 or self.mrGbMS.AccelerateToLimit >= 6 then
			attributes = attributes.." mrGbMSpeedAcc=\"" .. tostring( self.mrGbMS.AccelerateToLimit ) .. "\""     
		end                                                                        
		if self.mrGbMS.DecelerateToLimit <= 9 or self.mrGbMS.DecelerateToLimit >= 11 then
			attributes = attributes.." mrGbMSpeedDec=\"" .. tostring( self.mrGbMS.DecelerateToLimit ) .. "\""     
		end
	end 
	
	return attributes
end 

--**********************************************************************************************************	
-- mrGearboxMogli:loadFromAttributesAndNodes
--**********************************************************************************************************	
function mrGearboxMogli:loadFromAttributesAndNodes(xmlFile, key, resetVehicles)
	local i, b
	
	if self.mrGbMS ~= nil then
		i = getXMLInt(xmlFile, key .. "#mrGbMCurrentGear" )
		if i ~= nil then
			self.mrGbMS.DefaultGear = i
		end

		i = getXMLInt(xmlFile, key .. "#mrGbMCurrentRange" )
		if i ~= nil then
			self.mrGbMS.DefaultRange = i
		end
		
		i = getXMLInt(xmlFile, key .. "#mrGbMCurrentRange2" )
		if i ~= nil then
			self.mrGbMS.DefaultRange2 = i
		end

		i = getXMLInt(xmlFile, key .. "#mrGbMG27Mode" )
		if i ~= nil then
			self.mrGbMS.G27Mode = i
		end

		i = getXMLInt(xmlFile, key .. "#mrGbMSpeedAcc" )
		if i ~= nil then
			self.mrGbMS.AccelerateToLimit = i
		end

		i = getXMLInt(xmlFile, key .. "#mrGbMSpeedDec" )
		if i ~= nil then
			self.mrGbMS.DecelerateToLimit = i
		end

		i = getXMLInt(xmlFile, key .. "#mrGbMHudMode" )
		if i ~= nil then
			self.mrGbMS.HudMode = i
		end

		b = getXMLBool(xmlFile, key .. "#mrGbMAutoClutch" )
		if b ~= nil then
			self.mrGbMS.AutoClutch = b
		end

		b = getXMLBool(xmlFile, key .. "#mrGbMAllAuto" )
		if b ~= nil then
			self.mrGbMS.AllAuto = b
		end

		b = getXMLBool(xmlFile, key .. "#mrGbMAutomatic" )
		if b ~= nil then
			self.mrGbMS.Automatic = b
		end

		b = getXMLBool(xmlFile, key .. "#mrGbMIsOnOff" )
		if b ~= nil then
			self.mrGbMS.IsOnOff = b
		end

		b = getXMLBool(xmlFile, key .. "#mrGbMEcoMode" )
		if b ~= nil then
			self.mrGbMS.EcoMode = b
		end

	--self:mrGbMSetState( "FirstTimeRun", false )
	end
	
	return BaseMission.VEHICLE_LOAD_OK
end 

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMIsNotValidEntry
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMIsNotValidEntry( entry, cg, c1, c2 )

	if self.mrGbMS.ReverseActive then
		if entry.forwardOnly then
			return true
		end
	else
		if entry.reverseOnly then
			return true
		end
	end
	
	local cg0 = Utils.getNoNil( cg, self.mrGbMS.CurrentGear )
	local cr1 = Utils.getNoNil( c1, self.mrGbMS.CurrentRange )
	local cr2 = Utils.getNoNil( c2, self.mrGbMS.CurrentRange2 )
	
	for i=1,3 do
		local check
		if     i == 1 then
			check = self.mrGbMS.Gears[cg0]
		elseif i == 2 then
			check = self.mrGbMS.Ranges[cr1]
		else --if i == 3 then
			check = self.mrGbMS.Ranges2[cr2]
		end
		
		if check == nil then
			return true
		end
		if check.minGear   ~= nil and cg0 < check.minGear   then
			return true
		end
		if check.maxGear   ~= nil and cg0 > check.maxGear   then
			return true
		end
		if check.minRange  ~= nil and cr1 < check.minRange then
			return true
		end 
		if check.maxRange  ~= nil and cr1 > check.maxRange  then
			return true
		end
		if check.minRange2 ~= nil and cr2 < check.minRange2 then
			return true
		end
		if check.maxRange2 ~= nil and cr2 > check.maxRange2 then
			return true
		end	
	end
	
	return false
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetNewEntry
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetNewEntry( entries, current, index, name )

	local new = Utils.clamp( index, 1, table.getn( entries ) )
	local cg  = self.mrGbMS.CurrentGear
	local cr  = self.mrGbMS.CurrentRange
	local c2  = self.mrGbMS.CurrentRange2
	
	local function moveIt()
		if     name == "gear"  then
			cg = new	
		elseif name == "range" then
			cr = new 
		elseif name == "range2" then
			c2 = new 
		end
	end
	
	moveIt()

	if new > current then
		while new < table.getn( entries ) 
			and mrGearboxMogli.mrGbMIsNotValidEntry( self, entries[new], cg, cr, c2 ) do
			new = new + 1
			moveIt()
		end
	end
	while new > 1
		and mrGearboxMogli.mrGbMIsNotValidEntry( self, entries[new], cg, cr, c2 ) do
		new = new -1
		moveIt()
	end
	while new < table.getn( entries ) 
		and mrGearboxMogli.mrGbMIsNotValidEntry( self, entries[new], cg, cr, c2 ) do
		new = new + 1
		moveIt()
	end
		
	if mrGearboxMogli.mrGbMIsNotValidEntry( self, entries[new], cg, cr, c2 ) then
		print(string.format("no %s found: %d", name, index))
	end
	
	return new
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMCheckGrindingGears
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMCheckGrindingGears( checkIt, noEventSend )
	if self.steeringEnabled and checkIt and not ( self:mrGbMGetAutoClutch() ) and not ( self:mrGbMGetAutomatic() ) then
		if self.mrGbMS.ManualClutch > self.mrGbMS.MinClutchPercent + 0.1 then
			self:mrGbMSetState( "InfoText", string.format( "Cannot shift gear; clutch > %3.0f%%", 100*Utils.clamp( self.mrGbMS.MinClutchPercent + 0.1, 0, 1 ) ))
			self.mrGbMS.GrindingGearsVol = 0
			self:mrGbMSetState( "GrindingGearsVol", 1 )
			return true
		end		
	end		
	return false
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMCheckDoubleClutch
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMCheckDoubleClutch( checkIt, noEventSend )
	if      self.steeringEnabled 
			and math.abs( self.lastSpeedReal ) > 0.0003
			and checkIt 
			and not ( self:mrGbMGetAutoClutch() ) 
			and not ( self:mrGbMGetAutomatic() ) then
		return true
	end		
	return false
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetRangeForNewGear
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetRangeForNewGear( newGear )
	local newRange = self.mrGbMS.CurrentRange
	if      newGear > self.mrGbMS.CurrentGear 
			and self.mrGbMS.Gears[self.mrGbMS.CurrentGear].upRangeOffset   ~= nil then 
		newRange = self.mrGbMS.CurrentRange + self.mrGbMS.Gears[self.mrGbMS.CurrentGear].upRangeOffset
	elseif  newGear < self.mrGbMS.CurrentGear
			and self.mrGbMS.Gears[self.mrGbMS.CurrentGear].downRangeOffset ~= nil then 
		newRange = self.mrGbMS.CurrentRange + self.mrGbMS.Gears[self.mrGbMS.CurrentGear].downRangeOffset
	end

	if     self:mrGbMGetAutoShiftRange()
			or ( self.mrGbMS.MatchRanges ~= nil
			 and self.mrGbMS.MatchRanges ~= "false"
			 and ( self.mrGbMS.G27Mode    <= 0
					or not self.mrGbMS.SwapGearRangeKeys )
			 and ( ( newGear ~= self.mrGbMS.CurrentGear
				 	 and self.mrGbMS.MatchRanges == "true" )
					or ( newGear > self.mrGbMS.CurrentGear
					 and self.mrGbMS.MatchRanges == "end"
					 and self.mrGbMS.CurrentRange == table.getn( self.mrGbMS.Ranges ) )
					or ( newGear < self.mrGbMS.CurrentGear
					 and self.mrGbMS.MatchRanges == "end"
					 and self.mrGbMS.CurrentRange == 1 ) ) ) then
		
		local speed = self.mrGbMS.Gears[self.mrGbMS.CurrentGear].speed * self.mrGbMS.Ranges[self.mrGbMS.CurrentRange].ratio
		local delta = nil
		for i,r in pairs(self.mrGbMS.Ranges) do
			if not mrGearboxMogli.mrGbMIsNotValidEntry( self, r, newGear, i ) then			
				local diff = self.mrGbMS.Gears[newGear].speed * r.ratio - speed 
				if newGear < self.mrGbMS.CurrentGear then
					if      diff < 0
							and ( delta == nil or delta < diff ) then
						delta = diff
						newRange = i
					end
				else
					if      diff > 0
							and ( delta == nil or delta > diff ) then
						delta = diff
						newRange = i
					end
				end
			end
		end
	end
	
	newRange = mrGearboxMogli.mrGbMGetNewEntry( self, self.mrGbMS.Ranges, self.mrGbMS.CurrentRange, newRange, "range" )
	return newRange
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMSetCurrentGear
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMSetCurrentGear( new, noEventSend, manual )
	if      not ( self.mrGbMS.NeutralActive )
			and mrGearboxMogli.mrGbMCheckGrindingGears( self, self.mrGbMS.ManualClutchGear, noEventSend ) then
		return false
	end
	
	local newGear  = mrGearboxMogli.mrGbMGetNewEntry( self, self.mrGbMS.Gears, self.mrGbMS.CurrentGear, new, "gear" )

	if      newGear ~= self.mrGbMS.CurrentGear 
			and mrGearboxMogli.mrGbMCheckDoubleClutch( self, self.mrGbMS.GearsDoubleClutch, noEventSend ) then
		if self.isServer then
			if not mrGearboxMogli.checkGearShiftDC( self, newGear, "G", noEventSend ) then		
				return true -- better false ???
			end
		else
			self:mrGbMSetState( "NewGear", new, noEventSend )
			return true
		end
	end

	local newRange = self.mrGbMS.CurrentRange
	if manual then
		newRange = mrGearboxMogli.mrGbMGetRangeForNewGear( self, newGear )
	else
		newRange = mrGearboxMogli.mrGbMGetNewEntry( self, self.mrGbMS.Ranges, self.mrGbMS.CurrentRange, newRange, "range" )
	end
	
	if newGear ~= self.mrGbMS.CurrentGear then
		self:mrGbMSetState( "CurrentGear",  newGear,  noEventSend ) 		
		self:mrGbMSetState( "CurrentRange", newRange, noEventSend ) 
		self:mrGbMSetState( "CurrentRange2", mrGearboxMogli.mrGbMGetNewEntry( self, self.mrGbMS.Ranges2, self.mrGbMS.CurrentRange2,  self.mrGbMS.CurrentRange2, "range2" ), noEventSend ) 

		if      self.steeringEnabled 
				and not ( self:mrGbMGetAutoClutch() ) 
				and not ( self:mrGbMGetAutomatic() ) 
				and self.mrGbMS.IsNeutral
				and self.mrGbMS.ManualClutch <= self.mrGbMS.MinClutchPercent + 0.1 then	
			self:mrGbMSetNeutralActive( false, noEventSend, true )
		end
		
		return true
	end
	
	return false
end 

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetRangeForNewGear
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetGearForNewRange( newRange )
	local newGear  = self.mrGbMS.CurrentGear
	if      newRange > self.mrGbMS.CurrentRange 
			and self.mrGbMS.Ranges[self.mrGbMS.CurrentRange].upGearOffset   ~= nil then 
		newGear = self.mrGbMS.CurrentGear + self.mrGbMS.Ranges[self.mrGbMS.CurrentRange].upGearOffset
	elseif  newRange < self.mrGbMS.CurrentRange 
			and self.mrGbMS.Ranges[self.mrGbMS.CurrentRange].downGearOffset ~= nil then  
		newGear = self.mrGbMS.CurrentGear + self.mrGbMS.Ranges[self.mrGbMS.CurrentRange].downGearOffset
	end
	
	if     self:mrGbMGetAutoShiftGears()
			or ( self.mrGbMS.MatchGears ~= nil
			 and self.mrGbMS.MatchGears ~= "false"
			 and ( self.mrGbMS.G27Mode    <= 0
					or self.mrGbMS.SwapGearRangeKeys )
			 and ( ( newRange ~= self.mrGbMS.CurrentRange
					 and self.mrGbMS.MatchGears == "true" )
					or ( newRange > self.mrGbMS.CurrentRange
					 and self.mrGbMS.MatchGears == "end"
					 and self.mrGbMS.CurrentGear == table.getn( self.mrGbMS.Gears ) )
					or ( newRange < self.mrGbMS.CurrentRange
					 and self.mrGbMS.MatchGears == "end"
					 and self.mrGbMS.CurrentGear == 1 ) ) ) then
		
		local speed = self.mrGbMS.Gears[self.mrGbMS.CurrentGear].speed * self.mrGbMS.Ranges[self.mrGbMS.CurrentRange].ratio
		local delta = nil
		for i,g in pairs(self.mrGbMS.Gears) do
			if not mrGearboxMogli.mrGbMIsNotValidEntry( self, g, i, newRange ) then
				local diff = g.speed * self.mrGbMS.Ranges[newRange].ratio - speed 
				if newRange < self.mrGbMS.CurrentRange then
					if      diff < 0
							and ( delta == nil or delta < diff ) then
						delta = diff
						newGear = i
					end
				else
					if      diff > 0
							and ( delta == nil or delta > diff ) then
						delta = diff
						newGear = i
					end
				end
			end
		end
	end
	
	newGear = mrGearboxMogli.mrGbMGetNewEntry( self, self.mrGbMS.Gears, self.mrGbMS.CurrentGear, newGear, "gear" )
	return newGear 
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMSetCurrentRange
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMSetCurrentRange( new, noEventSend, manual )
	if      not ( self.mrGbMS.NeutralActive )
			and mrGearboxMogli.mrGbMCheckGrindingGears( self, self.mrGbMS.ManualClutchHl, noEventSend ) then
		return false
	end

	local newRange = mrGearboxMogli.mrGbMGetNewEntry( self, self.mrGbMS.Ranges, self.mrGbMS.CurrentRange, new, "range" )

	if      newRange ~= self.mrGbMS.CurrentRange 
			and mrGearboxMogli.mrGbMCheckDoubleClutch( self, self.mrGbMS.Range1DoubleClutch, noEventSend ) then
		if self.isServer then
			if not mrGearboxMogli.checkGearShiftDC( self, newRange, "1", noEventSend ) then		
				return true -- better false ???
			end
		else
			self:mrGbMSetState( "NewRange", new, noEventSend )
			return true
		end
	end

	local newGear  = self.mrGbMS.CurrentGear
	if manual then
		newGear = mrGearboxMogli.mrGbMGetGearForNewRange( self, newRange )
	else
		newGear = mrGearboxMogli.mrGbMGetNewEntry( self, self.mrGbMS.Gears, self.mrGbMS.CurrentGear, newGear, "gear" )
	end
	
	if newRange ~= self.mrGbMS.CurrentRange then
		self:mrGbMSetState( "CurrentRange", newRange, noEventSend ) 
		self:mrGbMSetState( "CurrentGear",  newGear,  noEventSend ) 		
		self:mrGbMSetState( "CurrentRange2", mrGearboxMogli.mrGbMGetNewEntry( self, self.mrGbMS.Ranges2, self.mrGbMS.CurrentRange2,  self.mrGbMS.CurrentRange2, "range2" ), noEventSend ) 
	
		if      self.steeringEnabled 
				and not ( self:mrGbMGetAutoClutch() ) 
				and not ( self:mrGbMGetAutomatic() ) 
				and self.mrGbMS.IsNeutral
				and self.mrGbMS.ManualClutch <= self.mrGbMS.MinClutchPercent + 0.1 then
			self:mrGbMSetNeutralActive( false, noEventSend, true )
		end
		
		return true
	end
	
	return false
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMSetCurrentRange2
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMSetCurrentRange2(new, noEventSend)
	if      not ( self.mrGbMS.NeutralActive )
			and mrGearboxMogli.mrGbMCheckGrindingGears( self, self.mrGbMS.ManualClutchRanges2, noEventSend ) then
		return 
	end

	local newRange2 = mrGearboxMogli.mrGbMGetNewEntry( self, self.mrGbMS.Ranges2, self.mrGbMS.CurrentRange2, new, "range2" )

	if      newRange2 ~= self.mrGbMS.CurrentRange2 
			and mrGearboxMogli.mrGbMCheckDoubleClutch( self, self.mrGbMS.Range2DoubleClutch, noEventSend ) then
		if self.isServer then
			if not mrGearboxMogli.checkGearShiftDC( self, newRange2, "2", noEventSend ) then		
				return true -- better false ???
			end
		else
			self:mrGbMSetState( "NewRange2", new, noEventSend )
			return true
		end
	end
	
	if newRange2 ~= self.mrGbMS.CurrentRange2 then
		local newRange = self.mrGbMS.CurrentRange
		local newGear  = self.mrGbMS.CurrentGear
		
		if true then -- self:mrGbMGetAutomatic() then
			local speed = self.mrGbMS.Gears[self.mrGbMS.CurrentGear].speed * self.mrGbMS.Ranges[self.mrGbMS.CurrentRange].ratio * self.mrGbMS.Ranges2[self.mrGbMS.CurrentRange2].ratio
			local delta = nil
			local fr    = self.motor:combineGear( self.mrGbMS.CurrentGear, self.mrGbMS.CurrentRange )
			local to    = self.motor:combineGear( table.getn( self.mrGbMS.Gears ), table.getn( self.mrGbMS.Ranges ) )
			if newRange2 > self.mrGbMS.CurrentRange2 then
				to = fr
				fr = 1
			end
			for i=fr,to do
				local i2g, i2r = self.motor:splitGear( i )
				local skip = false
				if      not mrGearboxMogli.mrGbMIsNotValidEntry( self, self.mrGbMS.Gears[i2g], i2g, i2r, newRange2 )
						and not mrGearboxMogli.mrGbMIsNotValidEntry( self, self.mrGbMS.Ranges[i2r], i2g, i2r, newRange2 ) then
					local diff = self.mrGbMS.Gears[i2g].speed * self.mrGbMS.Ranges[i2r].ratio * self.mrGbMS.Ranges2[newRange2].ratio - speed 
					if newRange2 < self.mrGbMS.CurrentRange2 then
						if      diff < 0
								and ( delta == nil or delta < diff ) then
							delta    = diff
							newGear  = i2g
							newRange = i2r
						end
					else
						if      diff > 0
								and ( delta == nil or delta > diff ) then
							delta    = diff
							newGear  = i2g
							newRange = i2r
						end
					end
				end
			end
		end
		
		newRange = mrGearboxMogli.mrGbMGetNewEntry( self, self.mrGbMS.Ranges, self.mrGbMS.CurrentRange, newRange, "range" )
		newGear  = mrGearboxMogli.mrGbMGetNewEntry( self, self.mrGbMS.Gears,  self.mrGbMS.CurrentGear,  newGear,  "gear" )
		
		
		self:mrGbMSetState( "CurrentRange2", newRange2, noEventSend ) 
		self:mrGbMSetState( "CurrentRange", newRange, noEventSend ) 
		self:mrGbMSetState( "CurrentGear",  newGear,  noEventSend ) 		

		if      self.steeringEnabled 
				and not ( self:mrGbMGetAutoClutch() ) 
				and not ( self:mrGbMGetAutomatic() ) 
				and self.mrGbMS.IsNeutral
				and self.mrGbMS.ManualClutch <= self.mrGbMS.MinClutchPercent + 0.1 then
			self:mrGbMSetNeutralActive( false, noEventSend, true )
		end
	
		return true
	end
	
	return false
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMSetAccelerateToLimit
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMSetAccelerateToLimit( value, noEventSend )
	self:mrGbMSetState( "AccelerateToLimit", Utils.clamp( value, 1, 10 ), noEventSend ) 		
end 

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMSetDecelerateToLimit
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMSetDecelerateToLimit( value, noEventSend )
	self:mrGbMSetState( "DecelerateToLimit", Utils.clamp( value, 1, 20 ), noEventSend ) 		
end 

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMSetAutomatic
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMSetAutomatic( value, noEventSend )
	local new = false 
	if value and ( self.mrGbMS.AutoShiftGears or self.mrGbMS.AutoShiftHl ) then
		new = true 
	end 
	self:mrGbMSetState( "Automatic", new, noEventSend ) 		
end 

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMSetNeutralActive
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMSetNeutralActive( value, noEventSend, noCheck )

--if value ~= self.mrGbMS.NeutralActive then
--	mrGearboxMogli.debugEvent( self, self.mrGbMS.NeutralActive, value, noEventSend )
--end

	if      not ( value )
			and self.mrGbMS.NeutralActive
			and not ( noCheck )
			and mrGearboxMogli.mrGbMCheckGrindingGears( self, self.mrGbMS.ManualClutchReverse, noEventSend ) then
		return false
	end

	self:mrGbMSetState( "NeutralActive", value, noEventSend ) 
	
	if not ( value ) and self.mrGbMS.AutoHold then
		self:mrGbMSetState( "AutoHold", false, noEventSend ) 
	end
	
	return true
end 

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMSetReverseActive
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMSetReverseActive( value, noEventSend )
	if      self.mrGbMS.ReverseActive ~= nil
			and self.mrGbMS.ReverseActive ~= value 
			and not ( self.mrGbMS.NeutralActive )
			and mrGearboxMogli.mrGbMCheckGrindingGears( self, self.mrGbMS.ManualClutchReverse, noEventSend ) then
		return false
	end
	
	local f = -1
	if value then
		f = 1
	end
	
	--print( type( self.calculateDamageFromVelocity )
	--.." "..tostring(self:mrGbMGetAutoStartStop())
	--.." "..string.format( "%2.3f %1.1f %d => %f", self.lastSpeedReal * 1000, self.movingDirection, f, self.lastSpeedReal * self.movingDirection * f )
	--.." "..tostring(self.mrGbMS.ReverseActive)
	--.." "..tostring(value) )
	
	if      type( self.calculateDamageFromVelocity ) == "function"
			and not self:mrGbMGetAutoStartStop()
			and self.lastSpeedReal * self.movingDirection * f > 0.0005 -- 0.5 m/s
			and self.mrGbMS.ReverseActive ~= value then
		self:mrGbMSetState( "WarningText", "Not so fast!" )
		self.mrGbMS.GrindingGearsVol = 0
		self:mrGbMSetState( "GrindingGearsVol", 1 )
		return false
	end
		
	if      self.mrGbMS.ReverseActive ~= value 
			and mrGearboxMogli.mrGbMCheckDoubleClutch( self, self.mrGbMS.ReverseDoubleClutch, noEventSend ) then
		if self.isServer then
			if not mrGearboxMogli.checkGearShiftDC( self, value, "R", noEventSend ) then		
				return true -- better false ???
			end
		else
			self:mrGbMSetState( "NewReverse", value, noEventSend )
			return true
		end
	end

	if      self.steeringEnabled 
			and not ( self:mrGbMGetAutoClutch() ) 
			and not ( self:mrGbMGetAutomatic() ) 
			and self.mrGbMS.IsNeutral
			and self.mrGbMS.ManualClutch <= self.mrGbMS.MinClutchPercent + 0.1 then
		self:mrGbMSetNeutralActive( false, noEventSend, true )
	end
	
	self:mrGbMSetState( "ReverseActive", value, noEventSend ) 		
	
	return true
end 

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMSetHandThrottle
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMSetHandThrottle( value, noEventSend )
	self:mrGbMSetState( "HandThrottle", Utils.clamp( value, 0, 1 ), noEventSend )
end 

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMSetManualClutch
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMSetManualClutch( value, noEventSend )
	self:mrGbMSetState( "ManualClutch", Utils.clamp( value, 0, 1 ), noEventSend ) 		
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetAutoClutchPercent
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetAutoClutchPercent()
	if self.mrGbML.motor == nil or not ( self.isServer ) then
		return 0
	end
	
	if     self.mrGbMS.NeutralActive then
		return 0
	elseif self.mrGbMS.ManualClutch < 1
	    or not self:mrGbMGetAutoClutch() then
		return self.mrGbMS.ManualClutch
	elseif self.mrGbMS.TorqueConverterOrHydro then
		return 1
	else
		return self.motor.clutchPercent
	end
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetClutchPercent
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetClutchPercent()
	if self.mrGbML.motor == nil then
		return 0
	end
	if self:mrGbMGetAutoClutch() then 
		if self.isServer then
			return mrGearboxMogli.mrGbMGetAutoClutchPercent( self )
		end
		return self.mrGbMD.Clutch*0.005
	end	
	return self.mrGbMS.ManualClutch
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetCurrentRPM
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetCurrentRPM()
	if self.mrGbML.motor == nil then
		if self.motor ~= nil then
			return self.motor.equalizedMotorRpm 
		else
			return nil
		end
	end
	if self.isServer then
		return self.motor.lastMotorRpm 
	end
	return self.mrGbMS.StallRpm + self.mrGbMD.Rpm * (self.mrGbMS.RatedRpm-self.mrGbMS.StallRpm) * 0.005
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetTargetRPM
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetTargetRPM()
	if self.mrGbML.motor == nil then
		return nil
	end

	if not ( self.mrGbMS.sendTargetRpm ) then
		self:mrGbMSetState( "sendTargetRpm", true )
		return 0
	else
		if self.isServer then
			return self.motor.targetRpm 
		end
		return self.mrGbMS.StallRpm + self.mrGbMD.Tgt * (self.mrGbMS.RatedRpm-self.mrGbMS.StallRpm) * 0.005
	end
	return nil
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetUsedPower
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetUsedPower()
	if self.mrGbML.motor == nil then
		return nil
	end
	
	if not ( self.mrGbMS.sendReqPower ) then
		self:mrGbMSetState( "sendReqPower", true )
		return 0
	else
		return self.mrGbMD.Power
	end
	return nil
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetHydrostaticFactor
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetHydrostaticFactor( defaultNoHydro )		

	if self.mrGbMS.Hydrostatic then
		if not ( self.mrGbMS.sendHydro ) then
			self:mrGbMSetState( "sendHydro", true )
		elseif 0 <= self.mrGbMD.Hydro and self.mrGbMD.Hydro <= 200 then
			return self.mrGbMS.HydrostaticMin + 0.005 * self.mrGbMD.Hydro * ( self.mrGbMS.HydrostaticMax - self.mrGbMS.HydrostaticMin )
		end
	end
	
	return defaultNoHydro
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetCombineLS(erver) liters per second
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetCombineLS()
	local sqm = 0
	if mrGearboxMogli.combineUseRealArea then
		sqm = self.mrGbML.realAreaPerSecond  
	else
		sqm = self.mrGbML.cutterAreaPerSecond
	end
	
	if      self.mrGbMS.IsCombine 
			and sqm ~= nil
			and sqm > 0 then
		
		sqm = sqm * g_currentMission:getFruitPixelsToSqm()

		local fruitType
		if      self.mrGbML.currentFruitType == nil then
			fruitType = FruitUtil.FRUITTYPE_UNKNOWN  
		elseif  self.mrGbML.currentFruitType      == FruitUtil.FRUITTYPE_CHAFF
				and self.mrGbML.currentInputFruitType ~= nil
		    and self.mrGbML.currentInputFruitType ~= FruitUtil.FRUITTYPE_MAIZE then
			fruitType = self.mrGbML.currentInputFruitType
		else
			fruitType = self.mrGbML.currentFruitType
		end			

		if     fruitType == FruitUtil.FRUITTYPE_WHEAT     then
			sqm = sqm * 1.2
		elseif fruitType == FruitUtil.FRUITTYPE_BARLEY    then
			sqm = sqm * 1.1
		elseif fruitType == FruitUtil.FRUITTYPE_RAPE      then
			sqm = sqm * 0.6
		elseif fruitType == FruitUtil.FRUITTYPE_MAIZE     then
			sqm = sqm * 1.2
		elseif fruitType == FruitUtil.FRUITTYPE_POTATO    then
			sqm = sqm * 4  
		elseif fruitType == FruitUtil.FRUITTYPE_SUGARBEET then
			sqm = sqm * 3.5
		elseif fruitType == FruitUtil.FRUITTYPE_GRASS     then
			sqm = sqm * 1.2
		elseif fruitType == FruitUtil.FRUITTYPE_DRYGRASS  then
			sqm = sqm * 1.2
		elseif fruitType == FruitUtil.FRUITTYPE_CHAFF     then
			sqm = sqm * 3.9
		elseif  fruitType                                         ~= nil 
				and FruitUtil.fruitIndexToDesc[fruitType]             ~= nil 
				and FruitUtil.fruitIndexToDesc[fruitType].literPerSqm ~= nil then
			if not ( mrGearboxMogli.combineUseRealArea ) then     
			-- factor 2 because of spraySum in CutterAreaEvent.lua
				sqm = sqm * 2 * FruitUtil.fruitIndexToDesc[fruitType].literPerSqm 
			elseif  FruitUtil.fruitIndexToDesc[fruitType].origLiterPerSqm ~= nil then
			-- realistic yield 
				sqm = sqm * FruitUtil.fruitIndexToDesc[fruitType].origLiterPerSqm
			else
			-- standard
				sqm = sqm * FruitUtil.fruitIndexToDesc[fruitType].literPerSqm
			end
		else
			sqm = 0
		end

	else
		sqm = 0
	end
	
	return sqm
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetThroughPutS
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetThroughPutS()
	if self.mrGbML.motor == nil then
		return nil
	end
	
	if      self.mrGbMS.IsCombine 
			and self.mrGbML.cutterAreaPerSecond ~= nil
			and self.mrGbML.cutterAreaPerSecond > 0 then
			
		sqm = self.mrGbML.cutterAreaPerSecond * g_currentMission:getFruitPixelsToSqm()
			
		local fruitType= FruitUtil.FRUITTYPE_UNKNOWN  
		if self.mrGbML.currentFruitType ~= nil then
			fruitType = self.mrGbML.currentFruitType
		end			
		if      fruitType ~= FruitUtil.FRUITTYPE_UNKNOWN 
				and FruitUtil.fruitIndexToDesc[fruitType]             ~= nil
				and FruitUtil.fruitIndexToDesc[fruitType].literPerSqm ~= nil then
			sqm = sqm * FruitUtil.fruitIndexToDesc[fruitType].literPerSqm
		end		
		if      fruitType ~= FruitUtil.FRUITTYPE_UNKNOWN 
				and FruitUtil.fruitTypeToFillType[fruitType]                               ~= nil
				and FillUtil.fillTypeIndexToDesc[FruitUtil.fruitTypeToFillType[fruitType]] ~= nil then
			return sqm * FillUtil.fillTypeIndexToDesc[FruitUtil.fruitTypeToFillType[fruitType]].massPerLiter * 3600
		else
			return sqm * 3.6
		end
	end

	return 0
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetThroughPut
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetThroughPut()
	if self.mrGbML.motor == nil then
		return nil
	end
	
	if     self.isServer then
		return mrGearboxMogli.mrGbMGetThroughPutS( self )
	elseif self.mrGbMD.Rate ~= nil then
		return self.mrGbMD.Rate
	end
	return 0
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetMotorLoad
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetMotorLoad()
	if self.mrGbML.motor == nil then
		return nil
	end

	if self.isServer then
		return self.motor.motorLoadS 
	end
	return self.mrGbMD.Load
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetGearText
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetGearText()

	if     self.mrGbMS               == nil
			or self.mrGbMS.Gears         == nil
			or self.mrGbMS.CurrentGear   == nil
			or self.mrGbMS.Ranges        == nil
			or self.mrGbMS.CurrentRange  == nil
			or self.mrGbMS.Ranges2       == nil 
			or self.mrGbMS.CurrentRange2 == nil then
		return ""
	end

	if self.mrGbMS.G27Mode       == 1 then
		return mrGearboxMogli.getText( "mrGearboxMogliTEXT_NOGEAR", "no gear" )
	end
	
	local gearText = Utils.getNoNil( self.mrGbMS.Gears[self.mrGbMS.CurrentGear].name, "" )
	if self.mrGbMS.Ranges[self.mrGbMS.CurrentRange].name ~= nil and self.mrGbMS.Ranges[self.mrGbMS.CurrentRange].name ~= "" then
		if self.mrGbMS.SwapGearRangeKeys then
			gearText = gearText .." ".. self.mrGbMS.Ranges[self.mrGbMS.CurrentRange].name
		else
			gearText = self.mrGbMS.Ranges[self.mrGbMS.CurrentRange].name .." ".. gearText
		end
	end
	if self.mrGbMS.Ranges2[self.mrGbMS.CurrentRange2].name ~= nil and self.mrGbMS.Ranges2[self.mrGbMS.CurrentRange2].name ~= "" then
		gearText = self.mrGbMS.Ranges2[self.mrGbMS.CurrentRange2].name .." ".. gearText
	end
	
	return gearText
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetNumberHelper
--**********************************************************************************************************	
function mrGearboxMogli.mrGbMGetNumberHelper( array, current, rev )
	if type(array) ~= "table" or current == nil then
		return 0
	end
	
	local number = 0
	
	for i,g in pairs(array) do
		if i > current then
			break
		end
		if rev then
			if not ( g.forwardOnly ) then
				number = number + 1 
			end
		else
			if not ( g.reverseOnly ) then
				number = number + 1 
			end
		end
	end
	
	return number
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetGearSpeed
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetGearSpeed()
	if self.motor == nil then
		return 0
	end
	if self.mrGbMD == nil then
		return 3.6 * self.motor.maxForwardSpeed
	end
	
	local speed 
	if self.isServer then
		speed = 3.6 * self.mrGbML.currentGearSpeed 
	else
		speed = self.mrGbMD.Speed * self.mrGbMS.NormSpeedFactorC
	end
	if self.mrGbMS.Hydrostatic and self.mrGbMS.HydrostaticMax ~= nil then
		speed = speed * self.mrGbMS.HydrostaticMax
	end
	return speed
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetGearNumber
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetGearNumber()
	if self.mrGbMS == nil then
		return 0
	end
	return mrGearboxMogli.mrGbMGetNumberHelper( self.mrGbMS.Gears, self.mrGbMS.CurrentGear, self.mrGbMS.ReverseActive )
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetRangeNumber
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetRangeNumber()
	if self.mrGbMS == nil then
		return 0
	end
	return mrGearboxMogli.mrGbMGetNumberHelper( self.mrGbMS.Ranges, self.mrGbMS.CurrentRange, self.mrGbMS.ReverseActive )
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetRange2Number
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetRange2Number()
	if self.mrGbMS == nil then
		return 0
	end
	return mrGearboxMogli.mrGbMGetNumberHelper( self.mrGbMS.Ranges2, self.mrGbMS.CurrentRange2, self.mrGbMS.ReverseActive )
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetModeText
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetModeText()
	return self.mrGbMS.DrawText
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetModeShortText
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetModeShortText()
	return self.mrGbMS.DrawText2
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetIsOn
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetIsOn()
	return self.mrGbMS.IsOn
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetHasAllAuto
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetHasAllAuto()

	if not self.mrGbMS.AutoShiftHl then
		local cf, cr = 0, 0
		for _,r in pairs(self.mrGbMS.Ranges) do
			if r.forwardOnly then
				cf = cf + 1
			elseif r.reverseOnly then
				cr = cr + 1
			else
				cf = cf + 1
				cr = cr + 1 
			end
		end
		if cf > 1 or cr > 1 then
			return true
		end
	end
	
	if not self.mrGbMS.AutoShiftGears then
		local cf, cr = 0, 0
		for _,g in pairs(self.mrGbMS.Gears) do
			if g.forwardOnly then
				cf = cf + 1
			elseif g.reverseOnly then
				cr = cr + 1
			else
				cf = cf + 1
				cr = cr + 1 
			end
		end
		if cf > 1 or cr > 1 then
			return true
		end
	end
	
	return false
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetAutoStartStop
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetAutoStartStop()
	return self.mrGbMS.AllAuto or self.mrGbMS.AutoStartStop or not ( self.steeringEnabled )
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetAutoShiftGears
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetAutoShiftGears()

	if      self.mrGbMS.AllAuto then
		return true
	elseif  self.mrGbMS.Automatic 
			and self.mrGbMS.AutoShiftGears then
		return true
	elseif not ( self.steeringEnabled ) then
		if      self.mrGbMS.EnableAI == mrGearboxMogli.AIAllAuto
				and self:mrGbMGetHasAllAuto() then
			return true
		elseif  self.mrGbMS.AutoShiftGears
		    or  self.mrGbMS.AutoShiftHl then
			return false
		elseif  self.mrGbMS.EnableAI == mrGearboxMogli.AIPowerShift
				and self.mrGbMS.GearShiftEffectGear then
			return true
		end
	end
	return false
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetAutoShiftRange
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetAutoShiftRange()

	if      self.mrGbMS.AllAuto then
		return true
	elseif  self.mrGbMS.Automatic 
			and self.mrGbMS.AutoShiftHl then
		return true
	elseif not ( self.steeringEnabled ) then
		if      self.mrGbMS.EnableAI == mrGearboxMogli.AIAllAuto
				and self:mrGbMGetHasAllAuto() then
			return true
		elseif  self.mrGbMS.AutoShiftGears
		    or  self.mrGbMS.AutoShiftHl then
			return false
		elseif  self.mrGbMS.EnableAI == mrGearboxMogli.AIPowerShift
				and self.mrGbMS.GearShiftEffectHl then
			return true
		end
	end
	return false
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetAutoClutch
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetAutoClutch()
	return self.mrGbMS.AllAuto or self.mrGbMS.AutoClutch or not ( self.steeringEnabled ) or self.mrGbMS.Hydrostatic
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetIsOn
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetAutomatic()
	if      self.mrGbMS.AllAuto then
		return true
	elseif  self.mrGbMS.Automatic then
		return true
	elseif  not ( self.steeringEnabled )
			and self.mrGbMS.EnableAI == mrGearboxMogli.AIAllAuto
			and self:mrGbMGetHasAllAuto() then
		return true
	elseif  not ( self.steeringEnabled )
			and self.mrGbMS.EnableAI == mrGearboxMogli.AIPowerShift
			and ( self.mrGbMS.GearShiftEffectGear or self.mrGbMS.GearShiftEffectHl ) then
		return true
	end
	return false
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMPrepareGearShift
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMPrepareGearShift( timeToShift, clutchPercent, doubleClutch, shiftingEffect )
	if self.isServer then
		if self.mrGbML.motor ~= nil then
			self.mrGbML.beforeShiftRpm = self.motor.lastRealMotorRpm 
			if mrGearboxMogli.debugGearShift then
				self.mrGbML.debugTimer = g_currentMission.time + 1000
			end				
			-- reset some values...
			self.motor.requestedPower1 = nil
			self.motor.targetRpm1      = nil
		end
		self.mrGbML.autoShiftTime = g_currentMission.time + timeToShift
		
		if shiftingEffect and ( timeToShift >= 0 ) then
			if self.mrGbML.gearShiftingNeeded == 0 then
				self.mrGbML.gearShiftingEffect = true
			end
		else
			self.mrGbML.gearShiftingEffect = false
		end
		
		local minTimeToShift = self.mrGbMG.minTimeToShift
		if ( timeToShift < 0 or ( timeToShift == 0 and minTimeToShift == 0 ) ) and self.mrGbML.gearShiftingTime < g_currentMission.time then
			mrGearboxMogli.mrGbMDoGearShift(self)		
			self.mrGbML.gearShiftingNeeded   = 0
		elseif self:mrGbMGetAutoClutch() then
			self.mrGbML.gearShiftingNeeded   = 1 
			-- reduce time to shift at very low speed
			local kmh = self.lastSpeedReal * 3600			
			if kmh < 20 then
				timeToShift = timeToShift * ( 0.5 + 0.025 * kmh )
			end
			self.mrGbML.gearShiftingTime     = math.max( self.mrGbML.gearShiftingTime, g_currentMission.time + math.max( minTimeToShift, timeToShift ) ) 
			self.mrGbML.afterShiftClutch     = clutchPercent
			if doubleClutch then
				self.mrGbML.doubleClutch       = true
				self.mrGbML.clutchShiftingTime = math.max( self.mrGbML.clutchShiftingTime, g_currentMission.time + 0.4 * timeToShift ) 
			else
				self.mrGbML.doubleClutch       = false
				self.mrGbML.clutchShiftingTime = math.max( self.mrGbML.clutchShiftingTime, g_currentMission.time + self.mrGbMS.ClutchShiftTime ) 
			end
		elseif doubleClutch then
			self.mrGbML.gearShiftingNeeded  = -1 
		else
			mrGearboxMogli.mrGbMDoGearShift(self)		
			self.mrGbML.gearShiftingNeeded  = 0
		end
	else
		print("ERROR: mrGearboxMogli:mrGbMPrepareGearShift called at client")
	end 
	
--print("B: "..tostring(self.mrGbML.beforeShiftRpm))
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMDoGearShift
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMDoGearShift()
	if self.isServer then
		
		if     self.mrGbMS               == nil
				or self.mrGbMS.Gears         == nil
				or self.mrGbMS.CurrentGear   == nil
				or self.mrGbMS.Ranges        == nil
				or self.mrGbMS.CurrentRange  == nil
				or self.mrGbMS.Ranges2       == nil 
				or self.mrGbMS.CurrentRange2 == nil then
			self.mrGbML.currentGearSpeed = 0
			return
		end

		if     self.mrGbML.gearShiftingTime < g_currentMission.time then
			self.mrGbML.gearShiftingNeeded = 0
		elseif self.mrGbML.doubleClutch then
			self.mrGbML.gearShiftingNeeded = 2
		else
			self.mrGbML.gearShiftingNeeded = 3
		end
		local gearMaxSpeed = self.mrGbMS.Gears[self.mrGbMS.CurrentGear].speed 
		                   * self.mrGbMS.Ranges[self.mrGbMS.CurrentRange].ratio 
											 * self.mrGbMS.Ranges2[self.mrGbMS.CurrentRange2].ratio
											 * self.mrGbMS.GlobalRatioFactor
		if self.mrGbMS.ReverseActive then	
			gearMaxSpeed = gearMaxSpeed * self.mrGbMS.ReverseRatio 
		end
		
		self.mrGbML.autoShiftTime    = g_currentMission.time
		self.mrGbML.lastGearSpeed    = Utils.getNoNil( self.mrGbML.currentGearSpeed, 0 )				
		self.mrGbML.currentGearSpeed = gearMaxSpeed 
		
		if self.mrGbML.motor ~= nil then	
			self.mrGbML.motor.deltaRpm = 0
			
			if self.mrGbML.beforeShiftRpm ~= nil then
				self.mrGbML.afterShiftRpm = Utils.clamp( self.mrGbML.beforeShiftRpm * self.mrGbML.lastGearSpeed / self.mrGbML.currentGearSpeed, self.mrGbML.motor.idleRpm, self.mrGbML.motor.maxAllowedRpm )

				if self.mrGbML.gearShiftingEffect then
					self.motor.currentRpmS  = self.mrGbML.afterShiftRpm
					self.motor.lastMotorRpm = self.mrGbML.afterShiftRpm
				end
			else
				self.mrGbML.afterShiftRpm = nil
			end
		else
			self.mrGbML.afterShiftClutch  = nil
			self.mrGbML.beforeShiftRpm    = nil
			self.mrGbML.afterShiftRpm     = nil
		end		
	end 

--print("B: "..tostring(self.mrGbML.beforeShiftRpm).." => A: "..tostring(self.mrGbML.afterShiftRpm))
end 

--**********************************************************************************************************	
-- mrGearboxMogli:setLaunchGear
--**********************************************************************************************************	
function mrGearboxMogli:setLaunchGear( noEventSend, init )
	if not self:mrGbMGetAutomatic() then
		return
	end
	
	
	
	local gear      = self.mrGbMS.CurrentGear
	local oldGear   = self.mrGbMS.CurrentGear
	local range     = self.mrGbMS.CurrentRange
	local oldRange  = self.mrGbMS.CurrentRange
	local gearSpeed = self.mrGbMS.Ranges2[self.mrGbMS.CurrentRange2].ratio * self.mrGbMS.GlobalRatioFactor	
	local maxSpeed  = self.mrGbMS.LaunchGearSpeed
	if self.mrGbMS.ConstantRpm then
		maxSpeed      = self.mrGbMS.LaunchPtoSpeed
		if self.mrGbMS.HandThrottle > 0 then
			maxSpeed    = maxSpeed * self.mrGbMS.IdleRpm / ( self.mrGbMS.IdleRpm + self.mrGbMS.HandThrottle * ( self.mrGbMS.RatedRpm - self.mrGbMS.IdleRpm ) )
		end
	end
	
	if self.mrGbMS.ReverseActive then
		gearSpeed = gearSpeed * self.mrGbMS.ReverseRatio 
	end

	local skip = false
	
	if not ( init ) then
		if self.mrGbML.currentGearSpeed ~= nil and self.mrGbML.currentGearSpeed < maxSpeed then
			maxSpeed = self.mrGbML.currentGearSpeed
		end
		if not self.steeringEnabled then
			if self.mrGbMS.ReverseActive then
				if self.mrGbML.aiGearR ~= nil and self.mrGbML.aiRangeR ~= nil then
					gear  = self.mrGbML.aiGearR
					range = self.mrGbML.aiRangeR
					skip  = true
				end
			else
				if self.mrGbML.aiGearF ~= nil and self.mrGbML.aiRangeF ~= nil then
					gear  = self.mrGbML.aiGearF
					range = self.mrGbML.aiRangeF
					skip  = true
				end
			end
		end
	end
	
	local dist = math.abs( self.mrGbML.currentGearSpeed - maxSpeed )
		
  if skip then			
		if self:mrGbMGetAutoShiftRange() then
			self:mrGbMSetCurrentRange( range, noEventSend ) 	
		end
		if self:mrGbMGetAutoShiftGears() then 
			self:mrGbMSetCurrentGear( gear, noEventSend ) 	
		end
	elseif not self:mrGbMGetAutoShiftRange() then
	-- select gear
		gearSpeed = gearSpeed * self.mrGbMS.Ranges[range].ratio
		for i,g in pairs( self.mrGbMS.Gears ) do
			if not mrGearboxMogli.mrGbMIsNotValidEntry( self, g, i, range ) then
				local s = gearSpeed * g.speed
			--if s >= maxSpeed - mrGearboxMogli.eps then
				local d = math.abs( s - maxSpeed )
				if d < dist then
					dist = d
					gear = i
				end
			end
		end
		self:mrGbMSetCurrentGear( gear, noEventSend ) 	
	elseif not self:mrGbMGetAutoShiftGears() then 
	-- select range
		gearSpeed = gearSpeed * self.mrGbMS.Gears[gear].speed
		for i,r in pairs( self.mrGbMS.Ranges ) do
			if not mrGearboxMogli.mrGbMIsNotValidEntry( self, r, gear, i ) then
				local s = gearSpeed * r.ratio
			--if s >= maxSpeed - mrGearboxMogli.eps then
				local d = math.abs( s - maxSpeed )
				if d < dist then
					dist = d
					range = i
					break
				end
			end
		end
		self:mrGbMSetCurrentRange( range, noEventSend ) 	
	elseif self.mrGbMS.GearTimeToShiftHl < self.mrGbMS.GearTimeToShiftGear then
	-- select range and gear
		for k=0,table.getn( self.mrGbMS.Gears ) do
			local j
			if k < 1 then
				j = self.mrGbMS.CurrentGear
			else
				j = table.getn( self.mrGbMS.Gears ) - k + 1
			end
			local g = self.mrGbMS.Gears[j]
			
			local minS = nil
			
			for i,r in pairs( self.mrGbMS.Ranges ) do
				if j < 1 then
					g = self.mrGbMS.Gears[self.mrGbMS.CurrentGear]
				else
					g = self.mrGbMS.Gears[j]
				end
				if      not mrGearboxMogli.mrGbMIsNotValidEntry( self, g, j, i )
						and not mrGearboxMogli.mrGbMIsNotValidEntry( self, r, j, i ) then
					local s = gearSpeed * g.speed * r.ratio
					if minS == nil or minS > s then
						minS = s
					end
					local d = math.abs( s - maxSpeed )
					if d < dist then
						dist  = d
						range = i
						gear  = j
					end
				end
			end
			if minS ~= nil and minS < maxSpeed - mrGearboxMogli.eps then
				break
			end
		end

		self:mrGbMSetCurrentGear( gear, noEventSend ) 	
		self:mrGbMSetCurrentRange( range, noEventSend ) 	
		
	else
	-- select gear and range
		for k=0,table.getn( self.mrGbMS.Ranges ) do
			local i
			if k < 1 then
				i = self.mrGbMS.CurrentRange
			else
				i = table.getn( self.mrGbMS.Ranges ) - k + 1
			end
			local r = self.mrGbMS.Ranges[i]
			
			local minS = nil
			
			for j,g in pairs( self.mrGbMS.Gears ) do
				if      not mrGearboxMogli.mrGbMIsNotValidEntry( self, g, j, i )
						and not mrGearboxMogli.mrGbMIsNotValidEntry( self, r, j, i ) then
					local s = gearSpeed * g.speed * r.ratio
					if minS == nil or minS > s then
						minS = s
					end
					local d = math.abs( s - maxSpeed )
					if d < dist then
						dist  = d
						range = i
						gear  = j
					end
				end
			end
			if minS ~= nil and minS < maxSpeed - mrGearboxMogli.eps then
				break
			end
		end
			
		self:mrGbMSetCurrentRange( range, noEventSend ) 	
		self:mrGbMSetCurrentGear( gear, noEventSend ) 	
	end
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMOnSetReverse
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMOnSetReverse( old, new, noEventSend )

	self.mrGbMS.ReverseActive = new 
	--timer to shift the "reverse/forward"
	
	if self.isServer then
		self.mrGbML.lastReverse = Utils.getNoNil( old, false )
		mrGearboxMogli.mrGbMPrepareGearShift( self, self.mrGbMS.GearTimeToShiftReverse, self.mrGbMS.ClutchAfterShiftReverse, self.mrGbMS.ReverseDoubleClutch, false ) 
		if self.motor.hydrostatFlow ~= nil then
			if ( not ( new ) and old ) or ( new and not ( old ) ) then
				self.motor.hydrostatFlow = -self.motor.hydrostatFlow
				self.motor.hydrostatPressureI, self.motor.hydrostatPressureO = self.motor.hydrostatPressureO, self.motor.hydrostatPressureI
			end
		end
	end
	
	local default 
	
	default = self.mrGbMS.CurrentGear
	if self.mrGbMS.ReverseResetGear  then
		default = self.mrGbMS.DefaultGear
	end
	self:mrGbMSetState( "DefaultGear", self.mrGbMS.CurrentGear, noEventSend ) 
	self:mrGbMSetState( "CurrentGear", mrGearboxMogli.mrGbMGetNewEntry( self, self.mrGbMS.Gears, self.mrGbMS.CurrentGear, default, "gear" ), noEventSend ) 
	
	default = self.mrGbMS.CurrentRange
	if self.mrGbMS.ReverseResetRange then
		default = self.mrGbMS.DefaultRange
	end
	self:mrGbMSetState( "DefaultRange", self.mrGbMS.CurrentRange, noEventSend ) 
	self:mrGbMSetState( "CurrentRange", mrGearboxMogli.mrGbMGetNewEntry( self, self.mrGbMS.Ranges, self.mrGbMS.CurrentRange, default, "range" ), noEventSend ) 

	local default = self.mrGbMS.CurrentRange2
	if self.mrGbMS.ReverseResetRange2 then
		default = self.mrGbMS.DefaultRange2
	end
	self:mrGbMSetState( "DefaultRange2", self.mrGbMS.CurrentRange2, noEventSend ) 
	self:mrGbMSetState( "CurrentRange2", mrGearboxMogli.mrGbMGetNewEntry( self, self.mrGbMS.Ranges2, self.mrGbMS.CurrentRange2, default, "range2" ), noEventSend ) 
	
	if self.steeringEnabled and self:mrGbMGetAutomatic() then
		mrGearboxMogli.setLaunchGear( self, noEventSend )
	end	
	
	if self.isServer and self.mrGbML.motor ~= nil then
		self.mrGbML.motor.speedLimitS = 0
	end 
end 

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetAutoHold
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetAutoHold( )
	if not ( self.steeringEnabled ) then
		return false
	elseif self:mrGbMGetAutoStartStop() then
		return true
	elseif self.dCcheckModule ~= nil and self:dCcheckModule("handBrake") then
		return false
	end
	return self.mrGbMG.autoHold
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMGetOnlyHandThrottle
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMGetOnlyHandThrottle( )
	if not ( self.steeringEnabled ) then
		return false
	elseif self.mrGbMS.AllAuto then
		return false 
	end
	return self.mrGbMS.OnlyHandThrottle 
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMOnSetNeutral
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMOnSetNeutral( old, new, noEventSend )		
	self.mrGbMS.NeutralActive   = new 

	if new and self:mrGbMGetAutomatic() then 
		mrGearboxMogli.setLaunchGear( self, noEventSend )
	end
	
	if self.isServer then
		mrGearboxMogli.mrGbMPrepareGearShift( self, 0, self.mrGbMS.MinClutchPercent, false, false ) 
		if self.mrGbML.motor ~= nil then
			self.mrGbML.motor.speedLimitS = 0
		end
		
		if not ( new ) then
			self:mrGbMSetState( "AutoHold", false )
			if      self:mrGbMGetOnlyHandThrottle()
					and self.mrGbMS.HandThrottle < self.mrGbMS.MinHandThrottle then
				self:mrGbMSetHandThrottle( self.mrGbMS.MinHandThrottle, noEventSend )
			end								
		end
	end
end 

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMOnSetRange
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMOnSetRange( old, new, noEventSend )
		
	local timeToShift = self.mrGbMS.GearTimeToShiftHl
	
	self.mrGbMS.CurrentRange = new
	self.mrGbMS.NewRange     = new

	--timer to shift the "range"
	if self.isServer then
		mrGearboxMogli.mrGbMPrepareGearShift( self, timeToShift, self.mrGbMS.ClutchAfterShiftHl, self.mrGbMS.Range1DoubleClutch, self.mrGbMS.GearShiftEffectHl ) 
	end 
end 

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMOnSetRange2
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMOnSetRange2( old, new, noEventSend )
		
	local timeToShift = self.mrGbMS.GearTimeToShiftRanges2
	
	self.mrGbMS.CurrentRange2 = new
	self.mrGbMS.NewRange2     = new

	--timer to shift the "range 2"
	if self.isServer then	
		mrGearboxMogli.mrGbMPrepareGearShift( self, timeToShift, self.mrGbMS.ClutchAfterShiftRanges2, self.mrGbMS.Range2DoubleClutch, self.mrGbMS.GearShiftEffectRanges2 ) 		
	end 
end 

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMOnSetGear
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMOnSetGear( old, new, noEventSend )

	local timeToShift = self.mrGbMS.GearTimeToShiftGear
		
	self.mrGbMS.CurrentGear = new
	self.mrGbMS.NewGear     = new
	
	if self.isServer then			
		--timer to set the gear
		mrGearboxMogli.mrGbMPrepareGearShift( self, timeToShift, self.mrGbMS.ClutchAfterShiftGear, self.mrGbMS.GearsDoubleClutch, self.mrGbMS.GearShiftEffectGear ) 	 	
	end
end

--**********************************************************************************************************	
-- mrGearboxMogli:checkGearShiftDC
--**********************************************************************************************************	
function mrGearboxMogli:checkGearShiftDC( new, what, noEventSend )

	local g1 = self.mrGbMS.CurrentGear
	local g2 = self.mrGbMS.CurrentRange 
	local g3 = self.mrGbMS.CurrentRange2 
	local gr = self.mrGbMS.ReverseActive
	local dc = false
	
	if     what == "G"    then
		g1 = new
		dc = self.mrGbMS.GearsDoubleClutch
	elseif what == "1"  then 
		g2 = new
		dc = self.mrGbMS.Range1DoubleClutch
	elseif what == "2"  then 
		g3 = new
		dc = self.mrGbMS.Range2DoubleClutch
	elseif what == "R" then 
		gr = new
		dc = self.mrGbMS.ReverseDoubleClutch
	else
		return true
	end

	if      mrGearboxMogli.mrGbMCheckDoubleClutch( self, dc, noEventSend )
			and self.motor.transmissionInputRpm ~= nil then				
		
		local s  = self.mrGbMS.Gears[g1].speed 
	           * self.mrGbMS.Ranges[g2].ratio 
						 * self.mrGbMS.Ranges2[g3].ratio
						 * self.mrGbMS.GlobalRatioFactor
		if gr then	
			s = self.mrGbMS.ReverseRatio * s
		end
		
		local r1 = mrGearboxMogli.gearSpeedToRatio( self, self.mrGbML.currentGearSpeed )
		local r2 = mrGearboxMogli.gearSpeedToRatio( self, s )
		local w  = self.motor.clutchRpm * r2 / r1
		
		local v = 0			
		if self.motor.transmissionInputRpm < w then
			v = ( w - self.motor.transmissionInputRpm ) / self.mrGbMG.grindingMinRpmDelta
		else
			v = ( self.motor.transmissionInputRpm - w ) / self.mrGbMG.grindingMaxRpmSound
			if v > 1 and self.motor.transmissionInputRpm - w < self.mrGbMG.grindingMaxRpmDelta then
				v = 0.999
			end
		end
		
		-- grinding sound if v > 0.5, no shift if v > 1
		v = math.max( v + v - 1, 0 )
		
		if self.mrGbMG.debugPrint then
			print(string.format("DC: %3.0fkm/h (%3.0f) %3.0fkm/h (%3.0f) => in %4.0f U/min / out %4.0f U/min => %1.2f", self.mrGbML.currentGearSpeed, r1, s, r2, self.motor.transmissionInputRpm, w, v ))
		end
			
		if     v > 1 then
			self:mrGbMSetNeutralActive( true, noEventSend )
			self:mrGbMSetState( "WarningText", string.format( "Cannot shift gear: rpm in: %4.0f / out: %4.0f", self.motor.transmissionInputRpm, w ))
			self.mrGbMS.GrindingGearsVol = 0
			self:mrGbMSetState( "GrindingGearsVol", 1 )
			return false
		elseif v > 0 and v > self.mrGbMS.GrindingGearsVol then
			self:mrGbMSetState( "InfoText", string.format( "Cannot shift gear: rpm in: %4.0f / out: %4.0f", self.motor.transmissionInputRpm, w ))
			self:mrGbMSetState( "GrindingGearsVol", v )
		elseif self.mrGbMS.GrindingGearsVol > 0 then
			self:mrGbMSetState( "GrindingGearsVol", 0 )
		end
	end
	
	return true
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMOnSetNewGear
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMOnSetNewGear( old, new, noEventSend )
	if self.isServer then		
		self:mrGbMSetCurrentGear( new, noEventSend, true )
	end
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMOnSetNewRange
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMOnSetNewRange( old, new, noEventSend )
	if self.isServer then		
		self:mrGbMSetCurrentRange( new, noEventSend, true )
	end
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMOnSetNewRange2
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMOnSetNewRange2( old, new, noEventSend )
	if self.isServer then		
		self:mrGbMSetCurrentRange2( new, noEventSend )
	end
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMOnSetNewRange2
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMOnSetNewReverse( old, new, noEventSend )
	if self.isServer then		
		self:mrGbMSetReverseActive( new, noEventSend )
	end
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMOnSetIsOn
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMOnSetIsOn( old, new, noEventSend )

	self.mrGbMS.IsOn = new

	if new then				
		if      self.dCcheckModule ~= nil
				and self.driveControl  ~= nil
				and self:dCcheckModule("shuttle")
				and self.driveControl.shuttle ~= nil 
				and self.driveControl.shuttle.isActive then
			if self.driveControl.shuttle.direction < 0 then
				self:mrGbMSetReverseActive( true, noEventSend )  -- first gear, H range, reverse
			else
				self:mrGbMSetReverseActive( false, noEventSend )  -- first gear, H range, forward
			end
		end
		if self.mrGbML.motor ~= nil then
			mrGearboxMogliMotor.copyRuntimeValues( self.mrGbMB.motor, self.mrGbML.motor )
			self.motor = self.mrGbML.motor
		end
		if self:mrGbMGetAutomatic() then
			if self:mrGbMGetAutoShiftGears() then
				self:mrGbMSetState( "CurrentGear", self.mrGbMS.LaunchGear, noEventSend ) 
			end
			if self:mrGbMGetAutoShiftRange() then
				self:mrGbMSetState( "CurrentRange", self.mrGbMS.LaunchRange, noEventSend ) 
			end
		end
		self:mrGbMDoGearShift() 
	elseif old and self.mrGbML.motor ~= nil then
		if self.isServer then
			self:mrGbMSetState( "DefaultGear", self.mrGbMS.CurrentGear, noEventSend ) 
			self:mrGbMSetState( "DefaultRange", self.mrGbMS.CurrentRange, noEventSend ) 
			self:mrGbMSetState( "DefaultRange2", self.mrGbMS.CurrentRange2, noEventSend ) 
		end
		self.mrGbML.gearShiftingNeeded = 0 	
		if self.mrGbMB.motor ~= nil then
			mrGearboxMogliMotor.copyRuntimeValues( self.mrGbML.motor, self.mrGbMB.motor )
			self.motor = self.mrGbMB.motor
		end
		if self.mrGbMB.dcShuttle then
			self.mrGbMB.dcShuttle = false
			self.driveControl.shuttle.isActive = true
			if self.mrGbMS.ReverseActive then
				self.driveControl.shuttle.direction = -1
			else
				self.driveControl.shuttle.direction = 1
			end
		end
	end	
end 

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMOnSetWarningText
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMOnSetWarningText( old, new, noEventSend )
	self.mrGbMS.WarningText  = new
  self.mrGbML.warningTimer = g_currentMission.time + 2000
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMOnSetInfoText
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMOnSetInfoText( old, new, noEventSend )
	self.mrGbMS.InfoText  = new
  self.mrGbML.infoTimer = g_currentMission.time + 2000
end

--**********************************************************************************************************	
-- mrGearboxMogli:mrGbMOnSetManualClutch
--**********************************************************************************************************	
function mrGearboxMogli:mrGbMOnSetManualClutch( old, new, noEventSend )
	self.mrGbMS.ManualClutch     = new
  self.mrGbML.manualClutchTime = g_currentMission.time
end

--**********************************************************************************************************	
-- mrGearboxMogli:newUpdateWheelsPhysics
--**********************************************************************************************************	
function mrGearboxMogli:newUpdateWheelsPhysics( superFunc, dt, currentSpeed, acc, doHandbrake, requiredDriveMode, ... )
	if self.mrGbMS == nil or not ( self.mrGbMS.IsOn ) or self.motor ~= self.mrGbML.motor then		
		return superFunc( self, dt, currentSpeed, acc, doHandbrake, requiredDriveMode, ... )
	end
	if self.motor.updateMotorRpm == nil or self.motor.updateMotorRpm ~= mrGearboxMogliMotor.updateMotorRpm then
		return superFunc( self, dt, currentSpeed, acc, doHandbrake, requiredDriveMode, ... )
	end
	
	if self.steeringEnabled and self.isReverseDriving  then
		acc = -acc
	end
	
	local acceleration        = acc
	local accelerationPedal   = 0
	local brakePedal          = 0
	local brakeLights         = false
	
	local oldHts              = self.lastSpeedReal*1000
	if self.mrGbML.hydroTargetSpeed ~= nil then
		oldHts = math.min( oldHts, self.mrGbML.hydroTargetSpeed )
		self.mrGbML.hydroTargetSpeed = nil
	end

	if self.steeringEnabled then
	-- driveControl and GPS
		if      self.cruiseControl.state ~= Drivable.CRUISECONTROL_STATE_OFF then
			acceleration = 1
		elseif  self.cruiseControl.state <= 0 
				and g_currentMission.driveControl            ~= nil
				and g_currentMission.driveControl.useModules ~= nil
				and g_currentMission.driveControl.useModules.handBrake
				and self.driveControl.handBrake              ~= nil 
				and self.driveControl.handBrake.isActive then
			doHandbrake  = true
			acceleration = -self.axisForward 
		elseif  self.mrGbMS.Hydrostatic 
				and self.mrGbMS.ConstantRpm then
			local m = self.motor.maxForwardSpeed
			if self.mrGbMS.ReverseActive then
				m = self.motor.maxBackwardSpeed 
			end
			if not self:mrGbMGetAutomatic() then
				m = math.min( m, self.mrGbML.currentGearSpeed * self.mrGbMS.HydrostaticMax )
			end
			 
			local decHts = Utils.clamp( ( 1.4142 * math.min( 0, acceleration ) )^2, self.mrGbMG.HydroSpeedIdleRedux, 1 )			
			local newHts = math.min( math.max( acceleration * m, oldHts - decHts * 0.001 * dt * self.mrGbMS.DecelerateToLimit ), oldHts + 0.001 * dt * self.mrGbMS.AccelerateToLimit )

			if acceleration < 0 then
				if self.axisForwardIsAnalog then
					self.mrGbML.hydroTargetTimer = nil
					if acceleration > -0.7071 then
						acceleration = 0
					end
				else
					if self.mrGbML.hydroTargetTimer == nil then
						self.mrGbML.hydroTargetTimer = g_currentMission.time + 1000
					end
					if g_currentMission.time < self.mrGbML.hydroTargetTimer then
						acceleration = 0
					end
				end
			elseif self.mrGbML.hydroTargetTimer ~= nil then
				self.mrGbML.hydroTargetTimer = nil
			end
			
			self.mrGbML.hydroTargetSpeed = Utils.clamp( newHts, 0, m )
		end		
		
		if acceleration < -0.001 then
			brakeLights = true
		end
	elseif doHandbrake  then
		self.motor.speedLimitS = 0
		self:mrGbMSetNeutralActive( true )
		acceleration = -1
	elseif self.movingDirection*currentSpeed*acc < -0.0003 then
		acceleration = -( 1 - ( 1 - math.abs( acc ) )^2 )
		self:mrGbMSetNeutralActive( true )
	elseif math.abs( acc ) > 0.001 then
		acceleration = ( 1 - ( 1 - math.abs( acc ) )^2 )
		self:mrGbMSetReverseActive( acc < 0 )
		self:mrGbMSetNeutralActive( false )
	else
		acceleration = 0
		self.motor.speedLimitS = 0
		self:mrGbMSetNeutralActive( true )
	end
	
	-- blow off ventil
	if      not ( self.motor.noTorque )
			and acceleration                   > 0.5 
			and ( self:mrGbMGetCurrentRPM()    > self.mrGbMS.IdleRpm + self.mrGbMG.blowOffVentilRpmRatio * ( self.mrGbMS.RatedRpm - self.mrGbMS.IdleRpm ) 
				 or g_currentMission.time        < self.mrGbML.blowOffVentilTime1 )
			and g_currentMission.time          > self.mrGbML.blowOffVentilTime0 then
		self.mrGbML.blowOffVentilTime1 = g_currentMission.time + mrGearboxMogli.blowOffVentilTime1
		self.mrGbML.blowOffVentilTime2 = -1
	end			

	--if self.mrGbMS.PlayBOVRpm > 0 and self:mrGbMGetCurrentRPM() < self.mrGbMS.PlayBOVRpm and self.mrGbMS.PlayBOV2 and self.mrGbMS.BlowOffVentilVolume > 0 then
	if      ( self.motor.noTorque or acceleration < 0.001 )
			and g_currentMission.time         < self.mrGbML.blowOffVentilTime1 then
		if     self.mrGbML.blowOffVentilTime2 < 0 then
			self.mrGbML.blowOffVentilTime2 = g_currentMission.time + mrGearboxMogli.blowOffVentilTime2
		elseif g_currentMission.time > self.mrGbML.blowOffVentilTime2 then
			self.mrGbML.blowOffVentilTime1 = 0
			self.mrGbML.blowOffVentilTime2 = -1
			self.mrGbML.blowOffVentilTime0 = g_currentMission.time + mrGearboxMogli.blowOffVentilTime0
			self.mrGbMS.BlowOffVentilPlay  = false
			self:mrGbMSetState( "BlowOffVentilPlay", true )
		end
	end
	
	if self.mrGbMS.ReverseActive then
		self.GPSmovingDirection    = -1
		self.GPSmovingDirectionCnt = 40
	else
		self.GPSmovingDirection    =  1
		self.GPSmovingDirectionCnt = 40
	end	
		
	--*******************
	-- motor brake
	--*******************
	local motorBrake = -self.mrGbMS.RealMotorBrakeFx * self.motor.clutchPercent * math.min( mrGearboxMogli.brakeFxSpeed * ( self.motor.nonClampedMotorRpm - self.motor.idleRpm ) / ( math.max( self.mrGbML.currentGearSpeed, 0.1 ) * ( self.motor.maxAllowedRpm - self.motor.idleRpm ) ), 1 )
	
	--*******************
	-- cruise control 
	--*******************
	self.motor:updateMotorRpm( dt )
	
	if     not ( self.mrGbMS.SpeedLimiter or self.cruiseControl.state > 0 ) 
			or not self.steeringEnabled
			or self.mrGbMS.CruiseControlBrake
			or self.mrGbMS.AllAuto
			or mrGearboxMogli.speedLimitMode == "M" then
		self.motor.limitMaxRpm = true
	elseif mrGearboxMogli.speedLimitMode == "T" then
		self.motor.limitMaxRpm = false
	elseif math.abs( currentSpeed ) * 3600 <= self.cruiseControl.speed then
		self.motor.limitMaxRpm = true
	elseif self.motor.motorLoad < mrGearboxMogli.eps then
		self.motor.limitMaxRpm = false
	end

	if not self.motor.limitMaxRpm then
		if currentSpeed * 3600 >= self.cruiseControl.speed + mrGearboxMogli.extraSpeedLimit then
			acceleration = 0
			-- turn on motor brake 
			self.mrGbML.motorBrakeTime = 0
		end
	end
	
	self.motor:updateSpeedLimit( dt )
	
	local motorBrakeOn = false
	if     self.mrGbML.gearShiftingNeeded ~= 0
	    or self.motor.noTransmission 
			or self.mrGbML.hydroTargetSpeed   ~= nil then
		-- disable motor brake 
		self.mrGbML.motorBrakeTime = g_currentMission.time + mrGearboxMogli.motorBrakeTime 
		
		if     ( self.mrGbML.gearShiftingNeeded > 0 and self.mrGbML.gearShiftingNeeded ~= 2 )
				or ( self.mrGbML.gearShiftingNeeded < 0 and acceleration < 0.001 ) then
			motorBrakeOn = true
		end
	elseif self.mrGbML.motorBrakeTime == nil then
		-- initialize motor brake 
		self.mrGbML.motorBrakeTime = g_currentMission.time + mrGearboxMogli.motorBrakeTime 
	end
	
	if     doHandbrake or self.mrGbMS.AutoHold or not ( self.isMotorStarted ) or g_currentMission.time < self.motorStartTime then
		-- hand brake
		if math.abs(self.rotatedTime) < 0.01 or self.articulatedAxis == nil then
			brakePedal = 1
		end
	elseif acceleration < motorBrake then
		-- braking 
		brakePedal   = -acceleration
		motorBrakeOn = true 
	elseif self.motor.lastRealMotorRpm >= self.motor.maxAllowedRpm then
		-- no fuel => motorBrake
		self.mrGbML.motorBrakeTime = 0 
		brakePedal   = -motorBrake
		motorBrakeOn = true 
	elseif acceleration < 0.001 then
		-- nothing => motorBrake
		if self.mrGbML.motorBrakeTime < g_currentMission.time then
			brakePedal   = -motorBrake
			motorBrakeOn = true 
		end
	elseif self.mrGbMS.ReverseActive then
		-- reverse 
		self.mrGbML.motorBrakeTime = nil
		accelerationPedal = -acceleration
	else                
		-- forward        
		self.mrGbML.motorBrakeTime = nil
		accelerationPedal =  acceleration
	end
	
	if     self.motor.clutchPercent < 1 - mrGearboxMogli.eps
			or self.mrGbMS.Hydrostatic then
		motorBrakeOn = false
	end
	
	self:mrGbMSetState( "MotorBrake", motorBrakeOn )
	
	if      ( self:mrGbMGetAutoHold() or ( self:mrGbMGetAutoClutch() and acceleration > 0.001 ) )
			and ( ( self.movingDirection * currentSpeed >  5.5555555556e-4 and self.mrGbMS.ReverseActive )
			   or ( self.movingDirection * currentSpeed < -5.5555555556e-4 and not ( self.mrGbMS.ReverseActive ) ) ) then
		-- wrong direction 
		brakePedal  = 1
		brakeLights = true
	end
		
	self.setBrakeLightsVisibility(self, brakeLights)
	self.setReverseLightsVisibility(self, self.mrGbMS.ReverseActive)
	mrGearboxMogliMotor.mrGbMUpdateGear( self.motor, acceleration )	
	
	local absAccelerationPedal = math.abs(accelerationPedal)
	local wheelDriveTorque = 0
	 
	self.lastAcceleration  = acceleration
		
	if brakePedal > 0 then
	--print(string.format("brake: %0.3f %0.3f %0.3f %0.3f",acceleration,accelerationPedal,brakePedal,motorBrake))
	elseif brakePedal < 0 then
		brakePedal = 0
	end
	
	if next(self.differentials) ~= nil and self.motorizedNode ~= nil then
		local torque      = self.motor:getTorque(accelerationPedal, false)
		local maxRpm      = self.motor:getCurMaxRpm()
		local ratio       = self.motor:getGearRatio()		
		local maxRotSpeed = maxRpm * mrGearboxMogli.factorpi30
		local c           = 0
		
		if     self.mrGbMS.TorqueConverter then
			if mrGearboxMogli.minClutchPercent + mrGearboxMogli.minClutchPercent <= self.motor.clutchPercent and self.motor.clutchPercent < 1 then
				c = self.mrGbMS.TorqueConverterFactor * self.motor.lastTransTorque
			end
		elseif self.mrGbMS.Hydrostatic and self.mrGbMS.HydrostaticLaunch then
			if self.motor.clutchPercent >= mrGearboxMogli.minClutchPercent + mrGearboxMogli.minClutchPercent then
				c = self.motor.maxClutchTorque
			end
		else
			if     self.motor.clutchPercent <= self.mrGbMG.clutchFrom   then
				c = 0
		--elseif self.motor.clutchPercent > self.mrGbMG.clutchTo      then
		--	c = self.mrGbMG.clutchFactor
			elseif self.mrGbMG.clutchTo - self.mrGbMG.clutchFrom < 0.01 then
				c = mrGearboxMogli.huge
			else
				c = self.mrGbMG.clutchFactor * ( ( self.motor.clutchPercent - self.mrGbMG.clutchFrom ) / ( self.mrGbMG.clutchTo - self.mrGbMG.clutchFrom ) ) ^ self.mrGbMG.clutchExp
			end
			
			c = math.min( self.motor.maxClutchTorque, c * self.motor.maxMotorTorque )
		end
		
		setVehicleProps(self.motorizedNode, torque, maxRotSpeed, ratio, c, self.motor:getRotInertia(), self.motor:getDampingRate());
		
	--if self.mrGbML.debugTimer ~= nil and g_currentMission.time < self.mrGbML.debugTimer and not ( self.mrGbMS.Hydrostatic ) then
		if      mrGearboxMogli.debugGearShift
				and ( self.mrGbMS.Hydrostatic 
					 or ( self.mrGbML.debugTimer ~= nil 
						and g_currentMission.time < self.mrGbML.debugTimer ) ) then
		  if not ( mrGearboxMogli.debugGearShiftHeader ) then
				mrGearboxMogli.debugGearShiftHeader = true
				print("AccPed: slAcc,  limit, torque,  brake,   nc.mot.RPM, motor RPM,  wheel RPM,  max RPM,     rot speed,  speed, ratio 1, ratio 2, factor, clutch, shift")
			end
			print(string.format("%6.2f%%: %4.0f Nm, %4.0f Nm, %4.0f Nm, %4.0f U/min, %4.0f U/min, %4.0f U/min, %4.0f U/min, %4.0f U/min, %4.2f %4.2f km/h, %3.1f, %3.1f, %3.0f%%, %d ",
													accelerationPedal*100,
													brakePedal*1000,
													torque*1000, 
													self.motor.lastRawTorque*1000,
													self.motor.nonClampedMotorRpm,
													self.motor.lastRealMotorRpm,
													self.motor.wheelRpm,
													self.motor.maxPossibleRpm,
													maxRpm, 
													maxRotSpeed,
													self.lastSpeedReal * self.movingDirection * 3600,
													ratio,
													mrGearboxMogliMotor.getMogliGearRatio( self.motor ),
													self.motor.clutchPercent * 100,
													self.mrGbML.gearShiftingNeeded)..tostring(self.motor.noTorque))
		elseif self.mrGbML.debugTimer ~= nil then
			self.mrGbML.debugTimer = nil
			print("=======================================================================================")
		end
													
	else
		local numTouching = 0
		local numNotTouching = 0
		local numHandbrake = 0
		local axleSpeedSum = 0

		for _, wheel in pairs(self.wheels) do
			if requiredDriveMode <= wheel.driveMode then
				if doHandbrake and wheel.hasHandbrake then
					numHandbrake = numHandbrake + 1
				elseif wheel.hasGroundContact then
					numTouching = numTouching + 1
				else
					numNotTouching = numNotTouching + 1
				end
			end
		end

		if 0 < numTouching and 0.01 < absAccelerationPedal then
			local axisTorque, brakePedalMotor = WheelsUtil.getWheelTorque(self, accelerationPedal)

			if axisTorque ~= 0 then
				wheelDriveTorque = axisTorque/(numTouching + numNotTouching)
			else
				brakePedal = brakePedalMotor
			end
		end
	end

	local doBrake = brakePedal > 0; --(brakePedal > 0 and self.lastSpeed > 0.0002) or doHandbrake;			  -- ToDo
	for _, implement in pairs(self.attachedImplements) do
		if implement.object ~= nil then
			if doBrake then
				implement.object:onBrake(brakePedal);
			else
				implement.object:onReleaseBrake();
			end
		end
	end
	for _, wheel in pairs(self.wheels) do
		WheelsUtil.updateWheelPhysics(self, wheel, doHandbrake, wheelDriveTorque, brakePedal, requiredDriveMode, dt)
	end

	return 
end

--**********************************************************************************************************	
-- mrGearboxMogli:gearSpeedToRatio
--**********************************************************************************************************	
function mrGearboxMogli:gearSpeedToRatio( gearSpeed )
	if gearSpeed > mrGearboxMogli.eps then 
		return math.min( self.mrGbMS.RatedRpm / ( gearSpeed * mrGearboxMogli.factor30pi ), mrGearboxMogli.huge )
	else
		return mrGearboxMogli.huge 
	end
end


--**********************************************************************************************************	
-- mrGearboxMogliMotor
--**********************************************************************************************************	

mrGearboxMogliMotor = {}
mrGearboxMogliMotor_mt = Class(mrGearboxMogliMotor)

setmetatable( mrGearboxMogliMotor, { __index = function (table, key) return VehicleMotor[key] end } )

--**********************************************************************************************************	
-- mrGearboxMogliMotor:new
--**********************************************************************************************************	
function mrGearboxMogliMotor:new( vehicle, motor )

	local interpolFunction = linearInterpolator1
	local interpolDegree   = 2
	
	local self = {}

	setmetatable(self, mrGearboxMogliMotor_mt)

	self.vehicle          = vehicle
	self.original         = motor 
	
	self.idleRpm          = vehicle.mrGbMS.IdleRpm
	self.ratedRpm         = vehicle.mrGbMS.RatedRpm
	self.stallRpm       	= vehicle.mrGbMS.StallRpm
	self.torqueCurve      = AnimCurve:new( interpolFunction, interpolDegree )
	

	if mrGearboxMogli.powerFuelCurve == nil then
		mrGearboxMogli.powerFuelCurve = AnimCurve:new( interpolFunction, interpolDegree )
		mrGearboxMogli.powerFuelCurve:addKeyframe( {v=0.010, time=0.0} )
		mrGearboxMogli.powerFuelCurve:addKeyframe( {v=0.125, time=0.02} )
		mrGearboxMogli.powerFuelCurve:addKeyframe( {v=0.240, time=0.06} )
		mrGearboxMogli.powerFuelCurve:addKeyframe( {v=0.360, time=0.12} )
		mrGearboxMogli.powerFuelCurve:addKeyframe( {v=0.500, time=0.2} )
		mrGearboxMogli.powerFuelCurve:addKeyframe( {v=0.800, time=0.4} )
		mrGearboxMogli.powerFuelCurve:addKeyframe( {v=0.952, time=0.6} )
		mrGearboxMogli.powerFuelCurve:addKeyframe( {v=0.986, time=0.7} )
		mrGearboxMogli.powerFuelCurve:addKeyframe( {v=1.000, time=0.8} )
		mrGearboxMogli.powerFuelCurve:addKeyframe( {v=0.978, time=0.9} )
		mrGearboxMogli.powerFuelCurve:addKeyframe( {v=0.909, time=1.0} )
	end
	
	if vehicle.mrGbMS.Engine.maxTorque > 0 then
		for _,k in pairs(vehicle.mrGbMS.Engine.torqueValues) do
			self.torqueCurve:addKeyframe( k )	
		end
		
		if vehicle.mrGbMS.Engine.ecoTorqueValues ~= nil then
			self.ecoTorqueCurve = AnimCurve:new( interpolFunction, interpolDegree )
			for _,k in pairs(vehicle.mrGbMS.Engine.ecoTorqueValues) do
				self.ecoTorqueCurve:addKeyframe( k )	
			end
		end
	
		self.maxTorqueRpm   = vehicle.mrGbMS.Engine.maxTorqueRpm
		self.maxMotorTorque = vehicle.mrGbMS.Engine.maxTorque
		self.maxAllowedRpm  = vehicle.mrGbMS.Engine.maxRpm
	else
		local zeroTorqueRpm = 0.5*motor.minRpm
		local idleTorque    = motor.torqueCurve:get(motor.minRpm) --/ self.vehicle.mrGbMS.TransmissionEfficiency
		self.torqueCurve:addKeyframe( {v=0.1*idleTorque, time=0} )
		self.torqueCurve:addKeyframe( {v=0.9*idleTorque, time=zeroTorqueRpm} )
		local vMax  = 0
		local tMax  = motor.maxRpm
		local tvMax = 0
		local vvMax = 0
		for _,k in pairs(motor.torqueCurve.keyframes) do
			if k.time > zeroTorqueRpm then 
				local kv = k.v --/ self.vehicle.mrGbMS.TransmissionEfficiency
				local kt = k.time
				
				if vvMax < k.v then
					vvMax = k.v
					tvMax = k.time
				end
				
				vMax = kv
				tMax = kt
				
				self.torqueCurve:addKeyframe( {v=kv, time=kt} )				
			end
		end		
		
		if vMax > 0 then
			self.torqueCurve:addKeyframe( {v=0.9*vMax, time=tMax + 25} )
			self.torqueCurve:addKeyframe( {v=0.5*vMax, time=tMax + 50} )
			self.torqueCurve:addKeyframe( {v=0.1*vMax, time=tMax + 75} )
			self.torqueCurve:addKeyframe( {v=0, time=tMax + 100} )
			tMax = tMax + 100
		end
		self.maxTorqueRpm   = tvMax	
		self.maxMotorTorque = self.torqueCurve:getMaximum()
		self.maxAllowedRpm  = self.ratedRpm + mrGearboxMogli.rpmPlus
	end

	self.fuelCurve = AnimCurve:new( interpolFunction, interpolDegree )
	if vehicle.mrGbMS.Engine.fuelUsageValues == nil then		
		self.fuelCurve:addKeyframe( { v = 0.96 * vehicle.mrGbMS.GlobalFuelUsageRatio, time = self.stallRpm } )
		self.fuelCurve:addKeyframe( { v = 0.94 * vehicle.mrGbMS.GlobalFuelUsageRatio, time = self.idleRpm } )
		self.fuelCurve:addKeyframe( { v = 0.91 * vehicle.mrGbMS.GlobalFuelUsageRatio, time = 0.8*self.idleRpm+0.2*self.ratedRpm } )		
		self.fuelCurve:addKeyframe( { v = 0.90 * vehicle.mrGbMS.GlobalFuelUsageRatio, time = 0.6*self.idleRpm+0.4*self.ratedRpm } )		
		self.fuelCurve:addKeyframe( { v = 0.92 * vehicle.mrGbMS.GlobalFuelUsageRatio, time = 0.3*self.idleRpm+0.7*self.ratedRpm } )		
		self.fuelCurve:addKeyframe( { v = 1.00 * vehicle.mrGbMS.GlobalFuelUsageRatio, time = self.ratedRpm } )		
		self.fuelCurve:addKeyframe( { v = 1.25 * vehicle.mrGbMS.GlobalFuelUsageRatio, time = 0.5*self.ratedRpm+0.5*self.maxAllowedRpm } )		
		self.fuelCurve:addKeyframe( { v = 2.00 * vehicle.mrGbMS.GlobalFuelUsageRatio, time = self.maxAllowedRpm } )		
	else
		for _,k in pairs(vehicle.mrGbMS.Engine.fuelUsageValues) do
			self.fuelCurve:addKeyframe( k )	
		end
	end
	
	
	self.rpmPowerCurve  = AnimCurve:new( interpolFunction, interpolDegree )	
	self.maxPower       = self.idleRpm * self.torqueCurve:get( self.idleRpm ) 		
	self.maxPowerRpm    = self.ratedRpm 
	self.maxMaxPowerRpm = self.ratedRpm
	self.rpmPowerCurve:addKeyframe( {v=self.idleRpm,  time=0} )				
	self.rpmPowerCurve:addKeyframe( {v=self.idleRpm+1,time=self.maxPower} )		

	local lastP = self.maxPower 
	local lastR = self.maxPowerRpm

	for _,k in pairs(self.torqueCurve.keyframes) do			
		local p = k.v*k.time
		if self.maxPower < p then
			self.maxPower       = p
			self.maxPowerRpm    = k.time
			self.maxMaxPowerRpm = k.time
			self.rpmPowerCurve:addKeyframe( {v=k.time, time=self.maxPower} )		
		elseif k.time <= self.ratedRpm then
			if      p     >= mrGearboxMogli.maxPowerLimit * self.maxPower then
				self.maxMaxPowerRpm = k.time
			elseif  lastP >= mrGearboxMogli.maxPowerLimit * self.maxPower 
			    and lastP >  p + mrGearboxMogli.eps then
				self.maxMaxPowerRpm = lastR + ( k.time - lastR ) * ( lastP - mrGearboxMogli.maxPowerLimit * self.maxPower ) / ( lastP - p )
			end
		end
		lastP = p
		lastR = k.time
	end
	
	self.maxMaxPowerRpm = math.min( self.maxMaxPowerRpm + mrGearboxMogli.maxPowerPlusRpm, self.ratedRpm )
	
	if self.ecoTorqueCurve ~= nil then
		self.maxEcoPower   = self.idleRpm * self.ecoTorqueCurve:get( self.idleRpm ) 		
		self.ecoPowerCurve = AnimCurve:new( interpolFunction, interpolDegree )
		self.ecoPowerCurve:addKeyframe( {v=self.idleRpm,  time=0} )				
		self.ecoPowerCurve:addKeyframe( {v=self.idleRpm+1,time=self.maxEcoPower} )		
		for _,k in pairs(self.ecoTorqueCurve.keyframes) do			
			local p = k.v*k.time
			if self.maxEcoPower < p then
				self.maxEcoPower  = p
				self.ecoPowerCurve:addKeyframe( {v=k.time, time=self.maxEcoPower} )		
			end
		end
	end
	
	if vehicle.mrGbMS.HydrostaticEfficiency ~= nil then
		self.hydroEff = AnimCurve:new( linearInterpolator1 )
		local ktime, kv
		for _,k in pairs(vehicle.mrGbMS.HydrostaticEfficiency) do
			if ktime == nil then
				self.hydroEff:addKeyframe( { time = k.time-2*mrGearboxMogli.eps, v = 0 } )
				self.hydroEff:addKeyframe( { time = k.time-mrGearboxMogli.eps, v = k.v } )
			end
			ktime = k.time
			kv    = k.v
			self.hydroEff:addKeyframe( k )
		end
		self.hydroEff:addKeyframe( { time = ktime+mrGearboxMogli.eps, v = kv } )
		self.hydroEff:addKeyframe( { time = ktime+2*mrGearboxMogli.eps, v = 0 } )
	end
	
	mrGearboxMogliMotor.copyRuntimeValues( motor, self )
	
	self.minRpm                  = vehicle.mrGbMS.CurMinRpm
	self.maxRpm                  = vehicle.mrGbMS.CurMaxRpm	
	self.minRequiredRpm          = self.idleRpm
	self.maxClutchTorque         = motor.maxClutchTorque
	self.brakeForce              = motor.brakeForce
	self.gear                    = 0
	self.gearRatio               = 0
	self.forwardGearRatios       = motor.forwardGearRatio
	self.backwardGearRatios      = motor.backwardGearRatio
	self.minForwardGearRatio     = motor.minForwardGearRatio
	self.maxForwardGearRatio     = motor.maxForwardGearRatio
	self.minBackwardGearRatio    = motor.minBackwardGearRatio
	self.maxBackwardGearRatio    = motor.maxBackwardGearRatio
	self.rpmFadeOutRange         = motor.rpmFadeOutRange
	self.clutchRpm               = 0
	self.motorLoad               = 0
	self.motorLoadP              = 0
	self.targetRpm               = self.idleRpm
	self.requiredWheelTorque     = 0

	self.maxForwardSpeed         = motor.maxForwardSpeed 
	self.maxBackwardSpeed        = motor.maxBackwardSpeed 
	if vehicle.mrGbMS.MaxForwardSpeed  ~= nil then
		self.maxForwardSpeed       = vehicle.mrGbMS.MaxForwardSpeed / 3.6 
	end
	if vehicle.mrGbMS.MaxBackwardSpeed ~= nil then
		self.maxBackwardSpeed      = vehicle.mrGbMS.MaxBackwardSpeed / 3.6
	end
	self.ptoMotorRpmRatio        = motor.ptoMotorRpmRatio

	self.maxTorque               = motor.maxTorque
	self.lowBrakeForceScale      = vehicle.mrGbMS.RealMotorBrakeFx --motor.lowBrakeForceScale
	self.lowBrakeForceSpeedLimit = 0.01 -- motor.lowBrakeForceSpeedLimit
		
	self.maxPossibleRpm          = self.ratedRpm
	self.wheelRpm                = 0
	self.wheelSpeedRpm           = 0
	self.currentRpmS             = 0
	self.noTransmission          = true
	self.noTorque                = true
	self.ptoOn                   = false
	self.clutchPercent           = 0
	self.minThrottle             = 0.3
	self.minThrottleS            = 0.3
	self.lastMotorRpm            = motor.lastMotorRpm
	self.lastRealMotorRpm        = motor.lastRealMotorRpm
	self.prevMotorRpm            = motor.lastMotorRpm
	self.prevNonClampedMotorRpm  = motor.nonClampedMotorRpm
	self.nonClampedMotorRpmS     = motor.nonClampedMotorRpm
	self.deltaRpm                = 0
	self.transmissionInputRpm    = 0
	self.lastRawTorque           = 0
	self.lastMotorTorque         = 0
	self.lastTransTorque         = 0
	self.lastFinalTorque         = 0
	self.neededPtoTorque         = 0
	self.lastPtoTorque           = 0
	self.lastLostTorque          = 0
	self.lastMissingTorque       = 0
	self.lastLimitDeltaTorque    = 0
	self.lastCurMaxRpm           = self.maxAllowedRpm
	self.lastAbsDeltaRpm         = 0
	self.limitMaxRpm             = true
	self.motorLoadS              = 0
	self.requestedPower          = 0
	self.maxRpmIncrease          = 0
	self.tickDt                  = 0
	self.absWheelSpeedRpm        = 0
	self.absWheelSpeedRpmS       = 0
	self.autoClutchPercent       = 0
	self.lastThrottle            = 0
	self.lastClutchClosedTime    = 0
	self.brakeNeutralTimer       = 0
	if self.vehicle.mrGbMS.Hydrostatic then
		self.hydrostaticFactor     = 0
	else
		self.hydrostaticFactor     = 1
	end
	self.rpmIncFactor            = self.vehicle.mrGbMS.RpmIncFactor	
	self.equalizedRpmFactor      = ( self.vehicle.mrGbMS.Sound.MaxRpm - self.vehicle.mrGbMS.OrigMinRpm ) / ( self.ratedRpm - self.idleRpm ) 
	
	self:chooseTorqueCurve( true )
	
	return self
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor.chooseTorqueCurve
--**********************************************************************************************************	
function mrGearboxMogliMotor:chooseTorqueCurve( eco )
	if eco and self.ecoTorqueCurve ~= nil then
		self.boost              = false
		self.currentTorqueCurve = self.ecoTorqueCurve
		self.currentPowerCurve  = self.ecoPowerCurve
		self.currentMaxPower    = self.maxEcoPower 
	else
		self.boost              = ( self.ecoTorqueCurve ~= nil )
		self.currentTorqueCurve = self.torqueCurve
		self.currentPowerCurve  = self.rpmPowerCurve
		self.currentMaxPower    = self.maxPower 
	end
	
	self.maxMotorTorque = self.currentTorqueCurve:getMaximum()
	self.maxRatedTorque = self.currentTorqueCurve:get( self.ratedRpm )
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor.copyRuntimeValues
--**********************************************************************************************************	
function mrGearboxMogliMotor.copyRuntimeValues( motorFrom, motorTo )

	motorTo.nonClampedMotorRpm      = motorFrom.nonClampedMotorRpm 
	motorTo.clutchRpm               = motorFrom.clutchRpm          
	motorTo.motorLoad               = motorFrom.motorLoad          
	motorTo.requiredWheelTorque     = motorFrom.requiredWheelTorque
	motorTo.lastMotorRpm            = motorFrom.lastMotorRpm       
	motorTo.lastRealMotorRpm        = motorFrom.lastRealMotorRpm       
	motorTo.equalizedMotorRpm       = motorFrom.equalizedMotorRpm
	motorTo.lastPtoRpm              = motorFrom.lastPtoRpm
	motorTo.gear                    = motorFrom.gear               
	motorTo.gearRatio               = motorFrom.gearRatio          
	motorTo.rpmLimit                = motorFrom.rpmLimit 
	motorTo.speedLimit              = motorFrom.speedLimit
	motorTo.minSpeed                = motorFrom.minSpeed

	motorTo.rotInertia              = motorFrom.rotInertia 
	motorTo.dampingRate             = motorFrom.dampingRate

end

--**********************************************************************************************************	
-- mrGearboxMogliMotor:getHydroEff
--**********************************************************************************************************	
function mrGearboxMogliMotor:getHydroEff( h )
	if self.hydroEff == nil then
		return 1
	elseif  self.vehicle.mrGbMS.ReverseActive
			and self.vehicle.mrGbMS.HydrostaticMin < 0 then
		h = -h
	end
	if self.vehicle.mrGbMS.HydrostaticMin <= h and h <= self.vehicle.mrGbMS.HydrostaticMax then
		return self.hydroEff:get( h )
	end
	return 0
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor:getMogliGearRatio
--**********************************************************************************************************	
function mrGearboxMogliMotor:getMogliGearRatio()
	local ratio = mrGearboxMogli.gearSpeedToRatio( self.vehicle, self.vehicle.mrGbML.currentGearSpeed )

	if self.vehicle.mrGbMS.HydrostaticCoupling ~= nil then
		return ratio
	end
	
	if self.vehicle.mrGbMS.Hydrostatic and self:lateRatioModification() ~= 3 then
		if self.hydrostaticFactor < mrGearboxMogli.eps then
			ratio = mrGearboxMogli.maxHydroGearRatio2
		else
			ratio = ratio / self.hydrostaticFactor
		end
		
		if mrGearboxMogli.maxHydroGearRatio < mrGearboxMogli.maxHydroGearRatio2 then
			if self.maxHydroGearRatio == nil then
				self.maxHydroGearRatio = mrGearboxMogli.maxHydroGearRatio2
			end
			
			local mhgr = mrGearboxMogli.maxHydroGearRatio
			
			if     self.noTransmission then
				mhgr = mrGearboxMogli.maxHydroGearRatio
		--elseif self.vehicle.lastAcceleration < 0.1 then
		--	mhgr = mrGearboxMogli.maxHydroGearRatio2
			elseif self.nonClampedMotorRpm <= self.stallRpm then
				mhgr = mrGearboxMogli.maxHydroGearRatio2
			elseif self.nonClampedMotorRpm < self.idleRpm then
				mhgr = mrGearboxMogli.maxHydroGearRatio + ( self.nonClampedMotorRpm - self.stallRpm ) / ( self.idleRpm - self.stallRpm ) * ( mrGearboxMogli.maxHydroGearRatio2 - mrGearboxMogli.maxHydroGearRatio )
			elseif ratio < mrGearboxMogli.maxHydroGearRatio then
				mhgr = mrGearboxMogli.maxHydroGearRatio
			end   
			
			local inv1 = 1 / self.maxHydroGearRatio
			local inv2 = 1 / mhgr 
			local inv3 = self.tickDt * 0.0005 / mrGearboxMogli.maxHydroGearRatio
			
			self.maxHydroGearRatio = 1 / ( inv1 + Utils.clamp( inv2 - inv1, -inv3, inv3 ) )

			if ratio > self.maxHydroGearRatio then
				ratio = self.maxHydroGearRatio 
			end
		end
		
		if mrGearboxMogli.debugGearShift and self.ptoWarningTimer ~= nil then
			print(string.format("gs: %2.2fkm/h; hf: %1.3f; hs: %2.2fkm/h; r: %3.1f; fgs: %2.4fkm/h",
													self.vehicle.mrGbML.currentGearSpeed,
													self.hydrostaticFactor,
													self.vehicle.mrGbML.currentGearSpeed * self.hydrostaticFactor,
													ratio,
													self.vehicle.mrGbMS.RatedRpm / ( ratio * mrGearboxMogli.factor30pi )))
		end
		
	end
	return ratio
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor:getGearRatioFactor
--**********************************************************************************************************	
function mrGearboxMogliMotor:getGearRatioFactor()

	local gearRatio 
	if self.noTransmission then
		gearRatio = mrGearboxMogli.maxGearRatio 
	else
		gearRatio = self:getMogliGearRatio()
	end
	
	return math.max( 0.01, math.abs( self.gearRatio / math.max( gearRatio, mrGearboxMogli.minGearRatio ) ) )
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor:getSpeedLimit
--**********************************************************************************************************	
function mrGearboxMogliMotor:getSpeedLimit( )
	return self.currentSpeedLimit
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor:updateSpeedLimit
--**********************************************************************************************************	
function mrGearboxMogliMotor:updateSpeedLimit( dt )
	self.currentSpeedLimit = math.huge
	
	local speedLimit = self.vehicle:getSpeedLimit(true)
	
	if not ( self.vehicle.steeringEnabled ) then
		speedLimit = math.min( speedLimit, self.speedLimit )
	end
	
	if      self.vehicle.tempomatMogliV14 ~= nil 
			and self.vehicle.tempomatMogliV14.keepSpeedLimit ~= nil then
		speedLimit = math.min( speedLimit, self.vehicle.tempomatMogliV14.keepSpeedLimit )
	end

	speedLimit = speedLimit * mrGearboxMogli.kmhTOms

	if     self.vehicle.mrGbMS.SpeedLimiter 
			or self.vehicle.cruiseControl.state > 0 
			or self.vehicle.mrGbML.hydroTargetSpeed ~= nil then

		local cruiseSpeed = speedLimit
		if self.vehicle.mrGbMS.SpeedLimiter or self.vehicle.cruiseControl.state > 0 then
			cruiseSpeed = math.min( cruiseSpeed, self.vehicle.cruiseControl.speed * mrGearboxMogli.kmhTOms )
		end
		
		if self.vehicle.mrGbML.hydroTargetSpeed ~= nil then
			cruiseSpeed = math.min( cruiseSpeed, self.vehicle.mrGbML.hydroTargetSpeed ) 
		end
		
		if dt == nil then
			dt = self.tickDt
		end
		
		if self.speedLimitS == nil then 
			self.speedLimitS = math.abs( self.vehicle.lastSpeedReal*1000 )
		end
		-- limit speed limiter change to given km/h per second
		local limitMax   =  0.001 * mrGearboxMogli.kmhTOms * self.vehicle.mrGbMS.AccelerateToLimit * dt
		local decToLimit = self.vehicle.mrGbMS.DecelerateToLimit
		---- avoid to much brake force => limit to 7 km/h/s if difference below 2.77778 km/h difference
		if self.speedLimitS - 1 < cruiseSpeed and cruiseSpeed < self.speedLimitS and decToLimit > 7 then
			decToLimit     = 7
		end
		local limitMin   = -0.001 * mrGearboxMogli.kmhTOms * decToLimit * dt
		self.speedLimitS = self.speedLimitS + Utils.clamp( math.min( cruiseSpeed, self.maxForwardSpeed ) - self.speedLimitS, limitMin, limitMax )
		if cruiseSpeed < self.maxForwardSpeed or self.speedLimitS < 0.97 * self.maxForwardSpeed then
			cruiseSpeed = self.speedLimitS
		end
		
		if speedLimit > cruiseSpeed then
			speedLimit = cruiseSpeed
		end
	else
		self.speedLimitS = math.min( speedLimit, math.abs( self.vehicle.lastSpeedReal*1000 ) )
	end
	
	if self.vehicle.mrGbMS.MaxSpeedLimiter then
		local maxSpeed = self.maxForwardSpeed
		
		if self.vehicle.mrGbMS.ReverseActive then
			maxSpeed = self.maxBackwardSpeed
		end		
		
		if speedLimit > maxSpeed then
			speedLimit = maxSpeed
		end
	end
						
	self.currentSpeedLimit = speedLimit 
	
	return speedLimit + mrGearboxMogli.extraSpeedLimitMs
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor:getCurMaxRpm
--**********************************************************************************************************	
function mrGearboxMogliMotor:getCurMaxRpm( forGetTorque )

	curMaxRpm = mrGearboxMogli.huge
						
	if not ( self.noTransmission ) then		
		curMaxRpm = self.maxPossibleRpm
		
		if     self:lateRatioModification() == 1 then
		elseif self:lateRatioModification() == 2 then
		elseif self:lateRatioModification() == 3 then
			curMaxRpm = self.maxPossibleRpm * self.hydrostaticFactor
		elseif self.clutchPercent < 1 then
			local maxWheelRpm = self.wheelRpm 
			curMaxRpm = math.max( curMaxRpm, self.clutchPercent * maxWheelRpm + ( 1-self.clutchPercent ) * self.maxPossibleRpm )
		end
		
		curMaxRpm = math.max( curMaxRpm, self.nonClampedMotorRpm - self.tickDt * self.vehicle.mrGbMS.RpmDecFactor )

		local speedLimit   = mrGearboxMogli.huge
		
		if self.ptoSpeedLimit ~= nil then
			speedLimit = self.ptoSpeedLimit
		end
		
		if forGetTorque or self.limitMaxRpm then
			speedLimit = math.min( speedLimit, self:getSpeedLimit() )
		elseif self.ptoOn then
			speedLimit = math.min( speedLimit, self:getSpeedLimit() + mrGearboxMogli.speedLimitBrake )
		end
		
		if speedLimit < mrGearboxMogli.huge then
			speedLimit = speedLimit + mrGearboxMogli.extraSpeedLimitMs
			curMaxRpm  = Utils.clamp( speedLimit * mrGearboxMogli.factor30pi * math.abs(self.gearRatio), 1, curMaxRpm )
		end
		
		if self.rpmLimit ~= nil and self.rpmLimit < curMaxRpm then
			curMaxRpm  = self.rpmLimit
		end
		
		if curMaxRpm < self.stallRpm then
			curMaxRpm  = self.stallRpm 
		end
		
		speedLimit = self.vehicle:getSpeedLimit(true)
		if speedLimit < mrGearboxMogli.huge then
			speedLimit = speedLimit * mrGearboxMogli.kmhTOms
			speedLimit = speedLimit + mrGearboxMogli.extraSpeedLimitMs
			curMaxRpm  = Utils.clamp( speedLimit * mrGearboxMogli.factor30pi * math.abs(self.gearRatio), 1, curMaxRpm )
		end
	end
	
	if not ( forGetTorque ) then
		self.lastCurMaxRpm = curMaxRpm
	end
	
	return curMaxRpm
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor:lateRatioModification
--**********************************************************************************************************	
function mrGearboxMogliMotor:lateRatioModification()

	if     self.vehicle.mrGbMS.HydrostaticCoupling ~= nil then
		return 3
	elseif self.vehicle.mrGbMS.Hydrostatic then
		if self.vehicle.mrGbMG.clutchSimu3 then
			return 3
		end
	elseif self.vehicle.mrGbMS.TorqueConverter then
		if self.vehicle.mrGbMG.clutchSimu2 then
			return 2
		end
	else
		if self.vehicle.mrGbMG.clutchSimu1 then
			return 1
		end
	end

	return 0
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor:getBestGear
--**********************************************************************************************************	
function mrGearboxMogliMotor:getBestGear( acceleration, wheelSpeedRpm, accSafeMotorRpm, requiredWheelTorque, requiredMotorRpm )

	local gearRatio     = mrGearboxMogliMotor.getMogliGearRatio( self )
	local bestGearRatio = gearRatio
	local maxGearRatio  = math.max( mrGearboxMogli.maxGearRatio, 10*bestGearRatio )

	if self:lateRatioModification() > 0 then
		self.wheelRpm = self.clutchRpm
	elseif self.clutchPercent < 1 then	  
		local wheelRpm = math.max( 0, self.wheelRpm )
		local motorRpm = self:getMotorRpm()
		
		if     wheelRpm < mrGearboxMogli.eps then
			bestGearRatio = maxGearRatio
		elseif gearRatio * motorRpm > maxGearRatio * wheelRpm then
			bestGearRatio = maxGearRatio
		else
			bestGearRatio = gearRatio * motorRpm / wheelRpm 
		end
		
		bestGearRatio = Utils.clamp( bestGearRatio, math.max( mrGearboxMogli.minGearRatio, 0.1 * gearRatio ), maxGearRatio )
		if bestGearRatio >= mrGearboxMogli.eps then
			self.wheelRpm = self.clutchRpm * gearRatio / bestGearRatio
		end
	else
		self.wheelRpm = self.clutchRpm
	end
	
	if self.vehicle.mrGbMS.ReverseActive then
		return -1, -bestGearRatio
	else
		return 1, bestGearRatio
	end
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor:increaseHyroLaunchRpm
--**********************************************************************************************************	
function mrGearboxMogliMotor:increaseHyroLaunchRpm()
	if      self.vehicle.mrGbMS.Hydrostatic
			and self.nonClampedMotorRpm < self.stallRpm 
			and self.hydrostaticFactor  < 1
			and self.hydrostaticFactor * self.vehicle.mrGbML.currentGearSpeed < self.vehicle.mrGbMS.LaunchGearSpeed 
			then
		return true
	end
	return false
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor:motorStall
--**********************************************************************************************************	
function mrGearboxMogliMotor:motorStall( warningText1, warningText2 )
	self.vehicle:mrGbMSetNeutralActive(true, false, true)
	if      self.vehicle.dCcheckModule ~= nil
			and self.vehicle:dCcheckModule("manMotorStart") 
			and self.vehicle.driveControl ~= nil
			and self.vehicle.driveControl.manMotorStart ~= nil then
		self.vehicle.driveControl.manMotorStart.isMotorStarted = false;
		driveControlInputEvent.sendEvent(self.vehicle)
		self.vehicle:mrGbMSetState( "WarningText", warningText1 )
	elseif self.vehicle.setManualIgnitionMode ~= nil then
		self.vehicle:setManualIgnitionMode(ManualIgnition.STAGE_OFF)
		self.vehicle:mrGbMSetState( "WarningText", warningText1 )
	else
		self.vehicle:mrGbMSetState( "WarningText", warningText2 )
	end
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor:getTorque
--**********************************************************************************************************	
function mrGearboxMogliMotor:getTorque( acceleration, limitRpm )

	self.lastTransTorque         = 0
	self.lastPtoTorque           = 0
	self.lastLostTorque          = 0	
	self.neededPtoTorque         = 0	
	self.lastMissingTorque       = 0
	self.lastLimitDeltaTorque    = 0
	
	local lastPtoTorque   = self.lastPtoTorque
	
	local acc             = math.max( self.minThrottle, self.lastThrottle )
	local brakePedal      = 0
	local rpm             = self.lastRealMotorRpm
	local torque          = 0

	local pt = 0
	self.neededPtoTorque = PowerConsumer.getTotalConsumedPtoTorque(self.vehicle) 
	
--if self.vehicle.mrGbMS.EcoMode and self.neededPtoTorque > 0 then
--	self.neededPtoTorque = self.neededPtoTorque * self.vehicle.mrGbMS.PtoRpm / self.vehicle.mrGbMS.PtoRpmEco
--end

	if self.neededPtoTorque > 0 then
	  pt = self.neededPtoTorque / self.ptoMotorRpmRatio
	end

	local eco = false
	if      self.ecoTorqueCurve ~= nil
			and ( self.vehicle.mrGbMS.EcoMode
				 or not ( self.neededPtoTorque                   > 0
						-- or self.motorLoadS                        > 0.99
							 or ( self.vehicle.mrGbMS.IsCombine and self.vehicle:getIsTurnedOn() )
							 or math.abs( self.vehicle.lastSpeedReal ) > self.vehicle.mrGbMS.BoostMinSpeed ) ) then
		eco = true
	end
	self:chooseTorqueCurve( eco )
	
	if self.noTorque then
		torque = 0
	else
		torque = self.currentTorqueCurve:get( rpm )
	end
	
	if self.lastRawTorque >= torque or self.vehicle.mrGbMG.maxTorqueMsInv <= 0 then
		self.lastRawTorque = torque 
	else
		self.lastRawTorque = self.lastRawTorque + math.min( torque - self.lastRawTorque, self.tickDt * self.vehicle.mrGbMG.maxTorqueMsInv * self.maxMotorTorque )
	end
	torque = self.lastRawTorque
	
--if self.noTransmission or self.noTorque then
--	self.lastMOI = 0
--else
--	local pR = self.prevMotorRpm
--	local cR = self.lastRealMotorRpm
--	self.lastMOI = self.vehicle.mrGbMS.MomentOfInertia * ( cR - pR ) / ( 60 * self.tickDt )	
--	if cR > self.maxPossibleRpm and self.lastMOI < 0 then
--		self.lastMOI = 0
--	end
--end	
--torque  = math.max( 0, torque - self.lastMOI )
	
	self.lastMotorTorque	= torque
	
	if self.vehicle.mrGbMS.IsCombine then
		local combinePower    = 0
		local combinePowerInc = 0
	
		if self.vehicle.pipeIsUnloading then
			combinePower = combinePower + self.vehicle.mrGbMS.UnloadingPowerConsumption
		end
		
		local sqm = 0
		if self.vehicle:getIsTurnedOn() then
			combinePower  = combinePower    + self.vehicle.mrGbMS.ThreshingPowerConsumption		
			if not ( self.vehicle.isStrawEnabled ) then
				combinePower  = combinePower    + self.vehicle.mrGbMS.ChopperPowerConsumption
			end
		end

		combinePowerInc = combinePowerInc + self.vehicle.mrGbMS.ThreshingPowerConsumptionInc
		if not ( self.vehicle.isStrawEnabled ) then
			combinePowerInc = combinePowerInc + self.vehicle.mrGbMS.ChopperPowerConsumptionInc
		end
		
		if combinePowerInc > 0 then
			combinePower = combinePower + combinePowerInc * mrGearboxMogli.mrGbMGetCombineLS( self.vehicle )
		end

		if rpm < self.vehicle.mrGbMS.ThreshingMaxRpm then
			local f      = Utils.clamp( 1 - self.vehicle.mrGbMS.ThreshingReductionFactor * ( 1 - rpm / self.vehicle.mrGbMS.ThreshingMaxRpm ), 0, 1 )
			combinePower = combinePower * f
		end
		
		pt = pt + ( combinePower / rpm )
	end
	
	if pt > 0 then
		if not ( self.noTransmission 
					or self.noTorque 
					or self.vehicle.mrGbMS.Hydrostatic
					or ( self.vehicle.mrGbMS.TorqueConverter and self.vehicle.mrGbMS.OpenRpm > self.maxPowerRpm - 1 ) ) then
			local mt = self.currentTorqueCurve:get( Utils.clamp( self.lastRealMotorRpm, self.idleRpm, self.ratedRpm ) ) 
			if mt < pt then
			--print(string.format("Not enough power for PTO: %4.0f Nm < %4.0fNm", mt*1000, pt*1000 ).." @RPM: "..tostring(self.lastRealMotorRpm))
				if self.ptoWarningTimer == nil then
					self.ptoWarningTimer = g_currentMission.time
				end
				if      g_currentMission.time > self.ptoWarningTimer + 10000 then
					self.ptoWarningTimer = nil
					
					mrGearboxMogliMotor.motorStall( self, string.format("Motor stopped due to missing power for PTO: %4.0f Nm < %4.0fNm", mt*1000, pt*1000 ), 
																								string.format("Not enough power for PTO: %4.0f Nm < %4.0fNm", mt*1000, pt*1000 ) )
				elseif  g_currentMission.time > self.ptoWarningTimer + 2000 then
					self.vehicle:mrGbMSetState( "WarningText", string.format("Not enough power for PTO: %4.0f Nm < %4.0fNm", mt*1000, pt*1000 ))
				end			
			elseif self.ptoWarningTimer ~= nil then
				self.ptoWarningTimer = nil
			end
		else
			self.ptoWarningTimer = nil
		end
		
		local maxPtoTorqueRatio = math.min( 1, self.vehicle.mrGbMS.MaxPtoTorqueRatio + math.abs( self.vehicle.lastSpeedReal*3600 ) * self.vehicle.mrGbMS.MaxPtoTorqueRatioInc )
		local lastDriveTorque   = self.motorLoad
		
		if     torque < 1e-4 then
			self.lastPtoTorque = 0
			self.ptoSpeedLimit = nil
		elseif self.noTransmission 
				or self.noTorque then
			self.lastPtoTorque = math.min( torque, pt )
			self.ptoSpeedLimit = nil
	--elseif  torque < lastDriveTorque + pt then
		elseif 0 <= maxPtoTorqueRatio and maxPtoTorqueRatio < 1 then
			local m = maxPtoTorqueRatio 
			if self.nonClampedMotorRpm > self.stallRpm and math.abs( self.vehicle.lastSpeedReal ) > 2.78e-4 then
				m = math.max( m, 1 - lastDriveTorque / torque )
			end
			self.lastPtoTorque = math.min( pt, m * torque )
		else
			self.lastPtoTorque = math.min( pt, torque )
		end
		
		if self.lastPtoTorque < pt then
			self.lastMissingTorque = self.lastMissingTorque + pt - self.lastPtoTorque
		end
		torque             = torque - self.lastPtoTorque
	else
		if self.ptoWarningTimer ~= nil then
			self.ptoWarningTimer = nil
		end
		if self.ptoSpeedLimit   ~= nil then
			self.ptoSpeedLimit   = nil
		end
	end
		
	if self.noTorque or torque <= 0 or acc <= 0 then
		if torque < 0 then
			self.lastMissingTorque = self.lastMissingTorque - torque
		end
		torque = 0
	else
		if self.limitMaxRpm then
			self.lastLimitDeltaRatio  = 0
			self.lastLimitDeltaTorque = 0
		else
			local limit = self:getCurMaxRpm( true )
			if      not self.noTransmission 
					and not self.noTorque
					and not ( self.vehicle.mrGbMS.Hydrostatic )
					and self.vehicle.steeringEnabled 
					and limit > self.minRequiredRpm 
					and acc   < 1 then
				limit = math.min( limit, self:getThrottleMaxRpm( acc ) )
			end
			
			local limitRatio = 0
			if self.lastLimitDeltaRatio == nil then
				self.lastLimitDeltaRatio = 0
			end
			
			if self.lastAbsDeltaRpm > 0 and self.lastLimitDeltaRatio > 0 then
				limit = limit - self.lastLimitDeltaRatio * self.lastAbsDeltaRpm
			end
			
			if     self.nonClampedMotorRpm <= limit then
				limitRatio = 0
			elseif self.nonClampedMotorRpm >= limit + self.lastAbsDeltaRpm then
				limitRatio = 1
			elseif self.lastAbsDeltaRpm < mrGearboxMogli.eps then
				limitRatio = 0.5
			else
				limitRatio = ( self.nonClampedMotorRpm - limit ) / self.lastAbsDeltaRpm
			end

			self.lastLimitDeltaRatio  = Utils.clamp( self.lastLimitDeltaRatio + self.vehicle.mrGbML.smoothFast * ( limitRatio - self.lastLimitDeltaRatio ), 0, 1 )
			self.lastLimitDeltaTorque = self.lastLimitDeltaRatio * torque 
						
			if self.lastLimitDeltaTorque > 0 then
				self.lastMotorTorque = self.lastMotorTorque - self.lastLimitDeltaTorque
				torque               = torque               - self.lastLimitDeltaTorque 
			end		
		end
		
	--if     self.vehicle.lastAcceleration <= -0.001 then
	--	acc = 0
	--elseif self.vehicle:mrGbMGetOnlyHandThrottle() or self.vehicle.mrGbMS.HandThrottle > 0.01 then
		if     self.vehicle:mrGbMGetOnlyHandThrottle() or self.vehicle.mrGbMS.HandThrottle > 0.01 then
			acc = self.vehicle.mrGbMS.HandThrottle
		elseif self.vehicle.mrGbMS.PowerManagement and acc > 0 then
			local p1 = rpm * ( self.lastMotorTorque - self.lastPtoTorque )
			local p0 = 0
			if self.vehicle.mrGbMS.EcoMode then
				p0 = self.currentMaxPower
			else
				p0 = self.maxPower
			end
			p0 = acc * ( p0 - rpm * self.lastPtoTorque )
			
			if     p0 <= 0 
					or p1 <= 0 then
				acc = 1
			elseif p0 >= p1 then
				acc = 1
			else --if p1 * acc < p0 then
				acc = p0 / p1
			end
		end

	--if      self.ptoOn
	--		and ( self.vehicle.mrGbMS.Hydrostatic or self.vehicle.mrGbMS.PowerManagement )
	--		and self.nonClampedMotorRpm < self.minRequiredRpm then
	--	acc = 1
	--end
		
		torque = torque * acc		
	end
	
	if limitRpm then
		local maxRpm = self.maxAllowedRpm
		local rpmFadeOutRange = self.rpmFadeOutRange * mrGearboxMogliMotor.getMogliGearRatio( self )
		local fadeStartRpm = maxRpm - rpmFadeOutRange

		if fadeStartRpm < self.nonClampedMotorRpm then
			if maxRpm < self.nonClampedMotorRpm then
				brakePedal = math.min((self.nonClampedMotorRpm - maxRpm)/rpmFadeOutRange, 1)
				torque = 0
			else
				torque = torque*math.max((fadeStartRpm - self.nonClampedMotorRpm)/rpmFadeOutRange, 0)
			end
		end
	end

	if     torque < 0 then
		self.lastMissingTorque = self.lastMissingTorque - torque
		torque = 0
	elseif self.noTransmission then
		self.lastLostTorque	 = torque
	elseif torque > 0 then
		local e = 0.94
		
		if self.vehicle.mrGbMS.Hydrostatic then
			e = self:getHydroEff( self.hydrostaticFactor )
		else
			e = self.vehicle.mrGbMS.TransmissionEfficiency
		end

		if self.clutchPercent < 1 - mrGearboxMogli.eps and self.vehicle.mrGbMS.TorqueConverterLossExp ~= nil then
			local v = math.max( 0.1, 1 / mrGearboxMogliMotor.getGearRatioFactor( self ) )
			e = e * ( 1 - ( 1 - v ) ^ self.vehicle.mrGbMS.TorqueConverterLossExp )
		end
		
		self.lastLostTorque  = torque * Utils.clamp( 1 - e, 0, 1 )
	end
	torque = torque - self.lastLostTorque	
	
	self.lastTransTorque = torque
	
	if     self.noTransmission 
			or self.noTorque then
		self.ptoSpeedLimit = nil
	elseif  self.lastMissingTorque > mrGearboxMogli.ptoSpeedLimitRatio * self.lastMotorTorque 
			and self.vehicle.mrGbMS.PtoSpeedLimit 
			and ( not ( self.vehicle.steeringEnabled ) or self.vehicle.cruiseControl.state ~= Drivable.CRUISECONTROL_STATE_OFF )
			and self.vehicle.lastSpeedReal*1000 > mrGearboxMogli.ptoSpeedLimitMin then
		if self.ptoSpeedLimit ~= nil then
			self.ptoSpeedLimit = math.max( self.ptoSpeedLimit - self.tickDt * mrGearboxMogli.ptoSpeedLimitDec, mrGearboxMogli.ptoSpeedLimitMin )
		else		
			self.ptoSpeedLimit = math.max( self.vehicle.lastSpeedReal*1000 - mrGearboxMogli.ptoSpeedLimitIni, mrGearboxMogli.ptoSpeedLimitMin )
		end
	elseif self.ptoSpeedLimit ~= nil then
		if mrGearboxMogli.ptoSpeedLimitInc > 0 then
			self.ptoSpeedLimit = self.ptoSpeedLimit + self.tickDt * mrGearboxMogli.ptoSpeedLimitInc
			if self.ptoSpeedLimit > self.vehicle.lastSpeedReal*1000 + mrGearboxMogli.ptoSpeedLimitOff then
				self.ptoSpeedLimit = nil
			end
		else
			self.ptoSpeedLimit = nil
		end
	end
	
	if self.vehicle.mrGbMS.HydrostaticCoupling ~= nil then
		local factorP, factorM, Mv, Mf = 1, 1, 0, 0
		local h  = self.hydrostaticFactor
	--local h  = Utils.clamp( self.hydrostaticFactor, 
	--												self.wheelRpm / ( rpm + self.tickDt * self.rpmIncFactor ), 
	--												self.wheelRpm / ( rpm - self.tickDt * self.vehicle.mrGbMS.RpmDecFactor ) )
		
		if     self.vehicle.mrGbMS.HydrostaticCoupling == "direct" then
			if h < 1 then
				factorP = h
			else
				factorM = 1 / h
			end
			Mv      = self.lastMotorTorque
		elseif self.vehicle.mrGbMS.HydrostaticCoupling == "output" then
			if h < 0.5 then
				factorP = h / ( 1 - h )
			else
				factorM = ( 1 - h ) / h
			end
			Mv      = ( torque - self.lastMissingTorque )
			Mf      = torque
		end
		
		Mv = Mv  / self.vehicle.mrGbMS.HydrostaticGearRatio
		
		self.hydrostatVolumeMotor = self.vehicle.mrGbMS.HydrostaticVolumeMotor * factorM
		self.hydrostatVolumePump  = self.vehicle.mrGbMS.HydrostaticVolumePump  * factorP
		
		if self.hydrostatPressureO == nil then
			self.hydrostatPressureO = 0
			self.hydrostatPressureI = 0
			self.hydrostatFlow      = 0
		end
		
		local Po = Utils.getNoNil( self.hydrostatPressureO, 0 )
		local Pi = Po -- math.min( Po, self.vehicle.mrGbMS.HydrostaticPressure )
		
		if self.hydrostatVolumePump > mrGearboxMogli.eps and Po < self.vehicle.mrGbMS.HydrostaticPressure then
			Pi = Utils.clamp( Pi + 0.95 * Mv * 20000 * math.pi / self.hydrostatVolumePump, 0, self.vehicle.mrGbMS.HydrostaticPressure )
		end
		
		self.hydrostatPressureI = self.hydrostatPressureI + self.vehicle.mrGbML.smoothLittle * ( Pi - self.hydrostatPressureI )
		Pi = math.min( self.hydrostatPressureI, self.vehicle.mrGbMS.HydrostaticPressure )
		
		local Mo = 0
		if self.noTransmission or self.noTorque or self.vehicle.lastAcceleration <= 0 then
			Mo = 0
		else
			Mo = 0.95 * Pi * self.hydrostatVolumeMotor / ( 20000 * math.pi )
		end		
		
		Mo = Mo * self.vehicle.mrGbMS.HydrostaticGearRatio
		
		self.hydrostatTorqueFactor = 0
		if     math.abs( Mf )      < mrGearboxMogli.eps then
			self.hydrostatTorqueFactor = 1
		elseif math.abs( Mo + Mf ) > mrGearboxMogli.eps then
			self.hydrostatTorqueFactor = Mo / ( Mo + Mf )
		end
			
		if self.vehicle.mrGbMG.debugPrint then
			print(string.format("Torque: Mi: %4.0f (%4.0f, %3.0f%%) Vi: %4.0f Pi: %4.0f Mo: %4.0f Vo: %4.0f Po: %4.0f Ni: %4.0f No: %4.0f h: %1.3f f: %1.3f", 
													Mv*1000,
													self.lastRawTorque*1000,
													acc*100,
													self.hydrostatVolumePump,
													Pi,
													Mo*1000,
													self.hydrostatVolumeMotor,
													Po,
													rpm,
													self.wheelRpm,
													h,
													self.hydrostatTorqueFactor ))
		end
		
		torque = math.max( 0, Mo + Mf )
	end
	
	self.torqueMultiplier = 1
	
	if self:lateRatioModification() == 2 and 0 < self.clutchPercent and self.clutchPercent < 1 then
		if rpm >= self.vehicle.mrGbMS.TorqueConverterFactor * self.wheelRpm then
			self.torqueMultiplier = self.vehicle.mrGbMS.TorqueConverterFactor
		else
			self.torqueMultiplier = rpm / self.wheelRpm
		end
	end
	
	if self:lateRatioModification() == 3 and self.vehicle.mrGbMS.HydrostaticCoupling == nil then
		if      torque                 < self.hydrostaticFactor * self.vehicle.mrGbMS.HydrostaticMaxTorque
				and self.hydrostaticFactor > mrGearboxMogli.eps then
			self.torqueMultiplier = 1 / self.hydrostaticFactor
		elseif  torque                 > mrGearboxMogli.eps then
			self.torqueMultiplier = self.vehicle.mrGbMS.HydrostaticMaxTorque / torque 
		else
			self.torqueMultiplier = mrGearboxMogli.huge
		end
	end
		
	torque = torque * self.torqueMultiplier
	
	self.lastFinalTorque = torque
		
	return torque, brakePedal
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor:updateMotorRpm
--**********************************************************************************************************	
function mrGearboxMogliMotor:updateMotorRpm( dt )
	local vehicle = self.vehicle
	self.tickDt                  = dt
	self.prevNonClampedMotorRpm  = self.nonClampedMotorRpm
	self.prevMotorRpm            = self.lastRealMotorRpm
	
	if next(vehicle.differentials) ~= nil and vehicle.motorizedNode ~= nil then
		self.nonClampedMotorRpm, self.clutchRpm, self.motorLoad = getMotorRotationSpeed(vehicle.motorizedNode)		
		self.nonClampedMotorRpm  = self.nonClampedMotorRpm * mrGearboxMogli.factor30pi
		self.clutchRpm           = self.clutchRpm          * mrGearboxMogli.factor30pi
		self.requiredWheelTorque = self.maxMotorTorque*math.abs(self.gearRatio)
	else
		local gearRatio = self.getGearRatio(self)

		if vehicle.isServer then
			self.nonClampedMotorRpm = math.max(WheelsUtil.computeRpmFromWheels(vehicle)*gearRatio, 0)
		else
			self.nonClampedMotorRpm = math.max(WheelsUtil.computeRpmFromSpeed(vehicle)*gearRatio, 0)
		end
	end

	if self:lateRatioModification() > 0 then
		self.wheelRpm = self.clutchRpm --math.max( self.nonClampedMotorRpm, self.clutchRpm )
		if self.noTransmission or self:getMogliGearRatio() < mrGearboxMogli.eps then
			self.wheelSpeedRpm = self.vehicle.lastSpeedReal * 1000 * mrGearboxMogli.factor30pi * self.vehicle.movingDirection 
		else
			self.wheelSpeedRpm = self.wheelRpm / self:getMogliGearRatio()
			if self.vehicle.mrGbMS.ReverseActive then self.wheelSpeedRpm = -self.wheelSpeedRpm end
		end
		
		
		if self.noTransmission then
			self.nonClampedMotorRpm = self:getThrottleRpm()
			self.motorLoad          = 0
		else
			
			if self.vehicle.mrGbMS.HydrostaticCoupling ~= nil then
					
				-- calculate volume based on 110% motor torque and 420 bar
				local Mo, No

				Mo = self.motorLoad * self.hydrostatTorqueFactor / self.vehicle.mrGbMS.HydrostaticGearRatio
				No = self.wheelRpm -- * self.vehicle.mrGbMS.HydrostaticGearRatio
				
				local Q  = self.hydrostatVolumeMotor * No / 1050				
				local Po = self.hydrostatPressureI - Mo * 20000 * math.pi / self.hydrostatVolumeMotor
				local Pi = self.hydrostatPressureI

			--Po = Utils.clamp( Po, 0, self.vehicle.mrGbMS.HydrostaticPressure )
				self.hydrostatPressureO = self.hydrostatPressureO + self.vehicle.mrGbML.smoothLittle * ( Po - self.hydrostatPressureO )
				self.hydrostatFlow      = Q --self.hydrostatFlow      + self.vehicle.mrGbML.smoothLittle * ( Q  - self.hydrostatFlow )
				
				local Ni, Mi
				
			--Ni = ( 1 - self.hydrostaticFactor ) * Ni + 1050 * Q / self.hydrostatVolumeMotor
				if self.hydrostatVolumePump > mrGearboxMogli.eps then
					Ni = 1050 * self.hydrostatFlow / self.hydrostatVolumePump					
					Mi = ( self.hydrostatPressureI - self.hydrostatPressureO ) * self.hydrostatVolumePump / ( 20000 * math.pi )
				else
					Ni = self:getThrottleRpm()
					Mi = 0
				end
				
				Ni = Ni -- / self.vehicle.mrGbMS.HydrostaticGearRatio
				Mi = Mi * self.vehicle.mrGbMS.HydrostaticGearRatio

				if     self.vehicle.mrGbMS.HydrostaticCoupling == "direct" then
					self.nonClampedMotorRpm = Ni
				elseif self.vehicle.mrGbMS.HydrostaticCoupling == "output" then				
					self.nonClampedMotorRpm = Ni + No
				end

				if self.vehicle.mrGbMG.debugPrint then
					print(string.format("RPM...: Mi: %4.0f Vi: %4.0f Pi: %4.0f Mo: %4.0f (%4.0f) Vo: %4.0f Po: %4.0f Q: %4.0f Ni: %4.0f No: %4.0f h: %1.3f f: %1.3f", 
															Mi*1000,
															self.hydrostatVolumePump,
															Pi,
															self.motorLoad*1000,
															self.lastFinalTorque*1000,
															self.hydrostatVolumeMotor,
															Po,
															Q,
															Ni,
															No,
															self.hydrostaticFactor,
															self.hydrostatTorqueFactor ))
				end
				
				self.wheelRpm = self.nonClampedMotorRpm
				
			--self.motorLoad = math.max( -( self.lastPtoTorque + self.lastLostTorque + self.lastMissingTorque ), Mi )
				self.motorLoad = math.max( 0, Mi )
			elseif self:lateRatioModification() == 3 then
				if self.hydrostaticFactor == 0 then
					self.nonClampedMotorRpm = self:getThrottleRpm()
				else
					self.nonClampedMotorRpm = self.wheelRpm / self.hydrostaticFactor
				end
				self.wheelRpm = self.nonClampedMotorRpm
			end
			
			if self.clutchPercent < 1 then
				self.nonClampedMotorRpm = self.clutchPercent * self.nonClampedMotorRpm + ( 1-self.clutchPercent ) * self:getThrottleRpm()
			end
			
			self.motorLoad = self.motorLoad / self.torqueMultiplier
		end

		self.lastRealMotorRpm = self.nonClampedMotorRpm
	else
		self.wheelSpeedRpm = self.vehicle.lastSpeedReal*1000*mrGearboxMogli.factor30pi 
		if math.abs( self.gearRatio ) > mrGearboxMogli.eps then
			self.wheelSpeedRpm = math.max( self.wheelSpeedRpm, self.clutchRpm / math.abs( self.gearRatio ) )
		end
		self.wheelSpeedRpm = self.wheelSpeedRpm * self.vehicle.movingDirection 
		self.wheelRpm = self.wheelSpeedRpm * self:getMogliGearRatio()
		if self.vehicle.mrGbMS.ReverseActive then self.wheelRpm = -self.wheelRpm end

		if self.wheelRpm < self.clutchRpm then
			self.wheelRpm = self.clutchRpm 
			if self:getMogliGearRatio() > mrGearboxMogli.eps then
				self.wheelSpeedRpm = self.wheelRpm / self:getMogliGearRatio()
				if self.vehicle.mrGbMS.ReverseActive then self.wheelSpeedRpm = -self.wheelSpeedRpm end
			end
		end
	
		self.lastRealMotorRpm = self:getMotorRpm()
		
		if mrGearboxMogliMotor.increaseHyroLaunchRpm( self ) then
			self.lastRealMotorRpm = math.max( self.lastRealMotorRpm, self.minRequiredRpm * mrGearboxMogli.rpmReduction )	
		end
	end
	
	if     not ( self.vehicle.isMotorStarted ) then
		self.lastRealMotorRpm  = 0
	elseif self.lastRealMotorRpm > self.maxRpm then
		self.lastRealMotorRpm  = self.maxRpm
	elseif self.lastRealMotorRpm < self.minRpm then
		self.lastRealMotorRpm  = self.minRpm
	end
	
	self.lastAbsDeltaRpm = self.lastAbsDeltaRpm + self.vehicle.mrGbML.smoothMedium * ( math.abs( self.prevNonClampedMotorRpm - self.nonClampedMotorRpm ) - self.lastAbsDeltaRpm )	
	self.deltaMotorRpm   = math.floor( self.lastRealMotorRpm - self.nonClampedMotorRpm + 0.5 )
	
	if not ( self.vehicle.isMotorStarted ) then
		self.lastMotorRpm = 0
	elseif self.noTransmission then
		self.lastMotorRpm = self.currentRpmS
	else
		self.lastMotorRpm = self.lastMotorRpm + Utils.clamp( self.lastRealMotorRpm - self.lastMotorRpm,	
																												-self.tickDt * self.vehicle.mrGbMS.RpmDecFactor,
																												 self.tickDt * self.rpmIncFactor )
	end
	
	local c = self.clutchPercent
	if not ( self.vehicle.mrGbMS.Hydrostatic or self.vehicle:mrGbMGetAutoClutch() ) then
		c = self.vehicle.mrGbMS.ManualClutch
	end
	local tir = math.max( 0, self.transmissionInputRpm - self.tickDt * self.ratedRpm * 0.0001 )
	
	if     c < 0.1 then
		self.transmissionInputRpm = tir
	elseif c > 0.9 then
		self.transmissionInputRpm = self.lastRealMotorRpm
	else
		self.transmissionInputRpm = math.max( self.lastRealMotorRpm, tir )
	end
	
	self.nonClampedMotorRpmS = self.nonClampedMotorRpmS + mrGearboxMogli.smoothFast * ( self.nonClampedMotorRpm - self.nonClampedMotorRpmS )
	--if g_currentMission.time < self.vehicle.mrGbML.gearShiftingTime and self.vehicle.mrGbML.gearShiftingEffect then
	----print("sound effect on")
	--	self.lastRealMotorRpm = self.minRpm
	--end
	
	self.lastPtoRpm        = self.lastRealMotorRpm
	self.equalizedMotorRpm = self:getMinRpm() +  ( self.lastMotorRpm - self.idleRpm ) * self.equalizedRpmFactor
	
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor:updateGear
--**********************************************************************************************************	
function mrGearboxMogliMotor:updateGear( acc )
	-- this method is not used here, it is just for convenience 
	if self.vehicle.mrGbMS.ReverseActive then
		acceleration = -acc
	else
		acceleration = acc
	end

	return self:mrGbMUpdateGear( acceleration )
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor:mrGbMUpdateGear
--**********************************************************************************************************	
function mrGearboxMogliMotor:mrGbMUpdateGear( accelerationPedal )

	-- Vehicle.drawDebugRendering !!!
	self.debugEffectiveTorqueGraph    = nil
	self.debugEffectivePowerGraph     = nil
	self.debugEffectiveGearRatioGraph = nil
	self.debugEffectiveRpmGraph       = nil

	local acceleration = math.max( accelerationPedal, 0 )

	if self == nil or self.vehicle == nil then
		local i = 1
		local info 
		print("------------------------------------------------------------------------") 
		while i <= 10 do
			info = debug.getinfo(i) 
			if info == nil then break end
			print(string.format("%i: %s (%i): %s", i, info.short_src, Utils.getNoNil(info.currentline,0), Utils.getNoNil(info.name,"<???>"))) 
			i = i + 1 
		end
		if info ~= nil and info.name ~= nil and info.currentline ~= nil then
			print("...") 
		end
		print("------------------------------------------------------------------------") 
	end
	
	if self.vehicle.mrGbMS.ReverseActive then
		acceleration = -acceleration
	end
	
--**********************************************************************************************************	
-- VehicleMotor.updateGear I
	local requiredWheelTorque = math.huge

	if (0 < acceleration) == (0 < self.gearRatio) then
		requiredWheelTorque = self.requiredWheelTorque
	end

	--local requiredMotorRpm = PowerConsumer.getMaxPtoRpm(self.vehicle)*self.ptoMotorRpmRatio
	local gearRatio          = self:getMogliGearRatio()
	local lastMaxPossibleRpm = Utils.getNoNil( self.maxPossibleRpm, self.maxAllowedRpm )
	local lastNoTransmission = self.noTransmission
	local lastNoTorque       = self.noTorque 
	self.noTransmission      = false
	self.noTorque            = not ( self.vehicle.isMotorStarted )
	self.maxPossibleRpm      = self.maxAllowedRpm
	
--**********************************************************************************************************	

	self.ptoMotorRpmRatio    = self.original.ptoMotorRpmRatio
	local currentSpeed       = 3.6 * self.wheelSpeedRpm * mrGearboxMogli.factorpi30 --3600 * self.vehicle.lastSpeedReal * self.vehicle.movingDirection
	local currentAbsSpeed    = currentSpeed
	if self.vehicle.mrGbMS.ReverseActive then
		currentAbsSpeed        = -currentSpeed
	end
					
--**********************************************************************************************************	
	-- current RPM and power

	self.minRequiredRpm = self.idleRpm
	
	lastPtoOn  = self.ptoOn
	self.ptoOn = false
	--if self.vehicle.mrGbMS.Hydrostatic then
	
	local handThrottle = -1
	
	if     self.vehicle:mrGbMGetOnlyHandThrottle()
			or self.vehicle.mrGbMS.HandThrottle > 0.01 then
		handThrottle = self.vehicle.mrGbMS.HandThrottle
	end
	
	local handThrottleRpm = self.idleRpm 
	if handThrottle >= 0 then
		self.ptoOn = true
		handThrottleRpm     = self.idleRpm + handThrottle * math.max( 0, self.ratedRpm - self.idleRpm )
		self.minRequiredRpm = math.max( self.minRequiredRpm, handThrottleRpm )
	end
	if self.vehicle.mrGbMS.AllAuto then
		handThrottle = -1
	end
	
	local ptoTq = self.neededPtoTorque --PowerConsumer.getTotalConsumedPtoTorque(self.vehicle)
	if ptoTq > 0 then
		self.ptoOn = true
		local ptoRpm = PowerConsumer.getMaxPtoRpm( self.vehicle )
		
		local p2 = Utils.clamp( ptoRpm * self.original.ptoMotorRpmRatio, self.minRequiredRpm, self.ratedRpm )
		local p0 = self.vehicle.mrGbMS.PtoRpm
		if self.vehicle.mrGbMS.EcoMode then
			p0 = self.vehicle.mrGbMS.PtoRpmEco
		end
		local p1 = p0
		
	--for i=0,4 do
	--	p1 = p0 + 0.25 * i * ( p2 - p0 )
	--	self.ptoMotorRpmRatio = p1 / ptoRpm
	--		
	--	if self.ptoMotorRpmRatio * self.currentTorqueCurve:get( p1 ) >= ptoTq or p2 <= p0 then
	--		break
	--	end                      
	--end
		if self.minRequiredRpm < p1 then
			self.minRequiredRpm = p1
		end
	end
	
	-- acceleration pedal and speed limit
	local requestedTorque   = self.motorLoad + self.lastPtoTorque + self.lastLostTorque + self.lastMissingTorque
	local currentSpeedLimit = self.currentSpeedLimit
	if self.ptoSpeedLimit ~= nil and currentSpeedLimit < self.ptoSpeedLimit then
		currentSpeedLimit = self.ptoSpeedLimit
	end
	currentSpeedLimit       = currentSpeedLimit + mrGearboxMogli.extraSpeedLimitMs
	
	if      self.limitMaxRpm 
			and accelerationPedal > 0.01 
			and currentAbsSpeed   > currentSpeedLimit * 3.6 - 1 
			and self.motorLoad    < accelerationPedal * self.lastTransTorque then
		if     self.motorLoad <= 0.01 * self.lastTransTorque then
			accelerationPedal = 0.01
		else
			accelerationPedal = self.motorLoad / self.lastTransTorque
		end
	end
	
	self.lastThrottle = math.max( self.minThrottle, accelerationPedal )
	
	local prevWheelSpeedRpm = self.absWheelSpeedRpm
	self.absWheelSpeedRpm = self.wheelSpeedRpm
	if self.vehicle.mrGbMS.ReverseActive then 
		self.absWheelSpeedRpm = -self.absWheelSpeedRpm
	end
	
	-- predict wheel speed RPM in next round 
	if math.abs(self.gearRatio) > 0.001 then
		local rpmInc  = self.maxAllowedRpm - self.lastRealMotorRpm
		if     rpmInc > self.tickDt * self.rpmIncFactor then
			rpmInc = self.tickDt * self.rpmIncFactor
		end
		self.absWheelSpeedRpm = self.absWheelSpeedRpm + rpmInc / math.abs(self.gearRatio)
	end

	self.absWheelSpeedRpm   = math.max( self.absWheelSpeedRpm, 0 )	
	self.absWheelSpeedRpmS  = self.absWheelSpeedRpmS + self.vehicle.mrGbML.smoothFast * ( self.absWheelSpeedRpm - self.absWheelSpeedRpmS )
	local deltaRpm          = ( self.absWheelSpeedRpm - prevWheelSpeedRpm ) / self.tickDt         
	self.deltaRpm           = self.deltaRpm + self.vehicle.mrGbML.smoothMedium * ( deltaRpm - self.deltaRpm )
	local currentPower      = ( self.motorLoad + self.lastPtoTorque + self.lastLostTorque ) * math.max( self.prevNonClampedMotorRpm, self.idleRpm )
	local getMaxPower       = ( self.lastMissingTorque > 0 )
	
	if currentAbsSpeed > 3 and requestedTorque > self.lastMotorTorque - mrGearboxMogli.eps then
		getMaxPower = true
	end
	
	if self.vehicle.mrGbMS.IsCombine then
		if self.vehicle:getIsTurnedOn() then
			self.ptoOn          = true
			local targetRpmC 
			if self.vehicle.steeringEnabled and handThrottle >= 0 then
			--targetRpmC        = math.max( self.vehicle.mrGbMS.ThreshingMinRpm, self.idleRpm + handThrottle * math.max( 0, self.ratedRpm - self.idleRpm ) )
				targetRpmC        = self.idleRpm + handThrottle * math.max( 0, self.ratedRpm - self.idleRpm )
			elseif self.lastMissingTorque > 0 then
			--targetRpmC        = math.min( self.vehicle.mrGbMS.ThreshingMaxRpm, self.maxMaxPowerRpm )
				targetRpmC        = self.vehicle.mrGbMS.ThreshingMaxRpm
			elseif getMaxPower then
				targetRpmC        = Utils.clamp( self.maxMaxPowerRpm, self.vehicle.mrGbMS.ThreshingMinRpm, self.vehicle.mrGbMS.ThreshingMaxRpm )
			else
				targetRpmC        = self.currentPowerCurve:get( math.max( requestedTorque, 1.25 * self.lastPtoTorque ) * math.max( self.prevNonClampedMotorRpm, self.idleRpm ) )
				targetRpmC        = Utils.clamp( targetRpmC, self.vehicle.mrGbMS.ThreshingMinRpm, self.vehicle.mrGbMS.ThreshingMaxRpm )
				if handThrottle >= 0 then 
					targetRpmC      = math.max( targetRpmC, self.idleRpm + handThrottle * math.max( 0, self.ratedRpm - self.idleRpm ) )
				end
			end			
			if self.targetRpmC == nil or self.targetRpmC < targetRpmC then
				self.targetRpmC   = targetRpmC 
			else
				self.targetRpmC   = self.targetRpmC + self.vehicle.mrGbML.smoothSlow * ( targetRpmC - self.targetRpmC )		
			end
			self.minRequiredRpm = self.targetRpmC
		else
			self.targetRpmC     = nil
		end
	end

	self.vehicle:mrGbMSetState( "ConstantRpm", self.ptoOn )
	
	
--if      handThrottle    >= 0
--		and handThrottleRpm < self.minRequiredRpm 
--		and self.ratedRpm   > self.idleRpm + mrGearboxMogli.eps then
--	self.vehicle:mrGbMSetHandThrottle( ( self.minRequiredRpm - self.idleRpm ) / ( self.ratedRpm - self.idleRpm ) )
--end
	
	local minRpmReduced = Utils.clamp( self.minRequiredRpm * mrGearboxMogli.rpmReduction, self.stallRpm, self.ratedRpm * mrGearboxMogli.rpmReduction )		

	local rp = math.max( ( self.lastPtoTorque + self.lastMissingTorque ) * math.max( self.prevNonClampedMotorRpm, self.idleRpm ), self.lastThrottle * self.currentMaxPower )
	
	if     self.motorLoad < self.lastTransTorque - mrGearboxMogli.eps then
		requestedPower = math.min( rp, currentPower )
	elseif getMaxPower then
		requestedPower = self.currentMaxPower
	elseif rp > currentPower then
		if     self.nonClampedMotorRpm > self.lastCurMaxRpm then
			requestedPower = currentPower
		elseif self.nonClampedMotorRpm + 10 > self.lastCurMaxRpm then
			requestedPower = currentPower + Utils.clamp( 0.1 * ( self.lastCurMaxRpm - self.nonClampedMotorRpm ), 0, 1 ) * ( rp - currentPower )
		elseif self.vehicle.mrGbMS.EcoMode then
			requestedPower = math.min( 0.9*rp, 1.11 * currentPower )
		else
			requestedPower = rp
		end
	else
		requestedPower = currentPower
	end

--print(string.format( "%3.0f%% %4.0f %4.0f %4.0f %4.0f => %4.0f ", self.lastThrottle*100, currentPower, pp, rp, self.currentMaxPower, requestedPower )..tostring(getMaxPower))
	
	self.motorLoadP = 0
	
	if     not ( self.vehicle.isMotorStarted )          then
		self.motorLoadP = 0
		self.motorLoadS1 = nil
--elseif self.vehicle.mrGbML.gearShiftingNeeded > 0   then
--	self.motorLoadP = self.motorLoadS
	elseif self.lastRealMotorRpm >= self.maxAllowedRpm or self.lastRawTorque < mrGearboxMogli.eps then
		self.motorLoadP = 0
--elseif self.lastRealMotorRpm > self.ratedRpm and self.maxRatedTorque > self.lastRawTorque then
--	local refTorque = self.lastRawTorque + ( self.lastRealMotorRpm - self.ratedRpm ) / ( self.maxAllowedRpm - self.ratedRpm ) * ( self.maxRatedTorque - self.lastRawTorque )
--	self.motorLoadP = Utils.clamp( requestedTorque / refTorque, 0, 1 )
	elseif self.prevMotorRpm > self.ratedRpm and self.lastRawTorque * self.prevMotorRpm  < self.maxRatedTorque * self.ratedRpm then
		self.motorLoadP = Utils.clamp( requestedTorque * self.prevMotorRpm / ( self.maxRatedTorque * self.ratedRpm ), 0, 1 )
	elseif self.lastMissingTorque > 0 then
		self.motorLoadP = 1
	elseif lastNoTorque then
		self.motorLoadP = 0
	else
		self.motorLoadP = Utils.clamp( requestedTorque / self.lastRawTorque, 0, 1 )
	end
	
--if lastNoTransmission or lastNoTorque then
--	self.motorLoadP = math.max( self.motorLoadP, self.lastThrottle )
--end

	if self.requestedPower1 == nil then
		self.requestedPower1 = requestedPower
	  self.requestedPower2 = requestedPower
	  self.requestedPower  = requestedPower
	else
		local slow = self.vehicle.mrGbMG.dtDeltaTargetSlow * self.tickDt * self.currentMaxPower
		local fast = self.vehicle.mrGbMG.dtDeltaTargetFast * self.tickDt * self.currentMaxPower
		
		self.requestedPower1 = self.requestedPower1 + Utils.clamp( requestedPower - self.requestedPower1, -fast, fast )
		self.requestedPower2 = self.requestedPower2 + Utils.clamp( requestedPower - self.requestedPower2, -slow, slow )
		self.requestedPower  = math.max( self.requestedPower1, self.requestedPower2 )
	end
	
	if self.motorLoadS1 == nil then
		self.motorLoadS1     = self.motorLoadP
		self.motorLoadS2     = self.motorLoadP
		self.motorLoadS	     = self.motorLoadP
	else
		local slow = self.vehicle.mrGbMG.dtDeltaTargetSlow * self.tickDt
		local fast = self.vehicle.mrGbMG.dtDeltaTargetFast * self.tickDt
		
		self.motorLoadS1     = self.motorLoadS1 + Utils.clamp( self.motorLoadP - self.motorLoadS1, -fast, fast )		
		self.motorLoadS2     = self.motorLoadS2 + Utils.clamp( self.motorLoadP - self.motorLoadS2, -slow, slow )		
		self.motorLoadS	     = math.max( self.motorLoadS1, self.motorLoadS2 )		
  end		
	
	local wheelLoad        = math.abs( self.motorLoad * self:getGearRatio()	)
	if self.wheelLoadS == nil then
		self.wheelLoadS = wheelLoad
	else
		self.wheelLoadS = self.wheelLoadS + self.vehicle.mrGbML.smoothSlow * ( wheelLoad - self.wheelLoadS )		
  end		
	
	local targetRpm 
	if     lastNoTransmission then
	-- no transmission 
		targetRpm = self.minRequiredRpm
	elseif self.ptoOn then
		targetRpm = self.minRequiredRpm
	else
		if getMaxPower then
		-- get max power even with "drueckung"
			if self.vehicle.mrGbMS.EcoMode then
				targetRpm = self.maxPowerRpm 
			else
				targetRpm = self.maxMaxPowerRpm
			end
		else
		-- get RPM that fits best to requested power
			targetRpm = Utils.clamp( self.currentPowerCurve:get( requestedPower ), self.minRequiredRpm, self.ratedRpm )
			if self.vehicle.mrGbMS.EcoMode then
				targetRpm = math.min( targetRpm, self.maxPowerRpm - mrGearboxMogli.rpmMinusEco )
			elseif 0.8 < self.motorLoadP and self.motorLoadP <= 1 then
				targetRpm = math.min( targetRpm + 5 * ( self.motorLoadP - 0.8 ) * mrGearboxMogli.extraTragetRpm, self.maxMaxPowerRpm ) --self.ratedRpm )
			end
		end
	--targetRpm = math.min( targetRpm, lastMaxPossibleRpm + 100 ) 
	end

	local minTarget = minRpmReduced
	if minRpmReduced < self.vehicle.mrGbMS.MinTargetRpm then
		if     currentAbsSpeed < mrGearboxMogli.eps then
			minTarget = minRpmReduced
		elseif currentAbsSpeed < 3 then
			minTarget = minRpmReduced + ( self.vehicle.mrGbMS.MinTargetRpm - minRpmReduced ) * currentAbsSpeed / 3 
		else
			minTarget = self.vehicle.mrGbMS.MinTargetRpm
		end
	end
	if targetRpm < minTarget then
		targetRpm = minTarget		
	end
	
	if      self.vehicle.steeringEnabled 
			and accelerationPedal < mrGearboxMogli.accDeadZone 
			and minTarget         < targetRpm then
	-- reduce target RPM to force automatic / hydrostat into higher gear 
		if accelerationPedal > 0 then
			targetRpm = minTarget + accelerationPedal / mrGearboxMogli.accDeadZone * ( targetRpm - minTarget )
		else
			targetRpm = minTarget
		end
	end
	
	if self.targetRpm1 == nil then
		self.targetRpm1 = targetRpm 
		self.targetRpm2 = targetRpm 
		self.targetRpm  = targetRpm 
	else
		local slow = self.vehicle.mrGbMG.dtDeltaTargetSlow * self.tickDt * ( self.maxPowerRpm - self.vehicle.mrGbMS.MinTargetRpm )
		local fast = self.vehicle.mrGbMG.dtDeltaTargetFast * self.tickDt * ( self.maxPowerRpm - self.vehicle.mrGbMS.MinTargetRpm )
		
		self.targetRpm1 = self.targetRpm1 + Utils.clamp( targetRpm - self.targetRpm1, -fast, fast )		
		self.targetRpm2 = self.targetRpm2 + Utils.clamp( targetRpm - self.targetRpm2, -slow, slow )		
		self.targetRpm  = math.max( self.targetRpm1, self.targetRpm2 )		
  end		
	
	if      self.ptoOn then
	-- reduce target RPM to accelerate and increase to brake 
		self.targetRpm = Utils.clamp( self.minRequiredRpm - accelerationPedal * mrGearboxMogli.ptoRpmThrottleDiff, self.stallRpm, self.ratedRpm )		
	end
					
	-- clutch calculations...
	local clutchMode = 0 -- no clutch calculation

	if self.lastClutchClosedTime < self.vehicle.mrGbML.autoShiftTime then
		self.lastClutchClosedTime = self.vehicle.mrGbML.autoShiftTime + self.vehicle.mrGbMS.AutoShiftTimeoutShort
	end
	
--**********************************************************************************************************		
-- no transmission / neutral 
--**********************************************************************************************************		
	local brakeNeutral   = false
	local autoOpenClutch = self.vehicle:mrGbMGetAutoClutch() or ( self.vehicle.mrGbMS.Hydrostatic and self.vehicle.mrGbMS.HydrostaticLaunch )
	
	if      self.vehicle.mrGbMS.Hydrostatic
			and self.ptoOn 
			and currentAbsSpeed >= self.vehicle.mrGbMG.minAbsSpeed then
		autoOpenClutch = false
	end
	
	if accelerationPedal >= -0.001 then
		self.brakeNeutralTimer = g_currentMission.time + self.vehicle.mrGbMG.brakeNeutralTimeout
	end
	
	if     self.vehicle.mrGbMS.NeutralActive
			or self.vehicle.mrGbMS.G27Mode == 1
			or not ( self.vehicle.isMotorStarted ) 
			or g_currentMission.time < self.vehicle.motorStartTime then
	-- off or neutral
		brakeNeutral = true
	elseif  currentAbsSpeed < -1.8 
			and math.abs( self.vehicle.lastSpeedReal * 3600 ) > 1
			and autoOpenClutch 
		--and not (  self.vehicle.mrGbMS.HydrostaticCoupling ~= nil 
		--	     and self.vehicle.mrGbMS.HydrostaticCoupling == "direct" ) then
			and not self.vehicle.mrGbMS.TorqueConverterOrHydro then
		brakeNeutral  = true 
		self.noTorque = true
	elseif self.vehicle.cruiseControl.state ~= 0 
			or not autoOpenClutch then
	-- no automatic stop or cruise control is on 
		brakeNeutral = false
	elseif accelerationPedal >= -0.001 then
	-- not braking 
		if      accelerationPedal      <  0.1
				and self.wheelRpm          <  0
				and self.vehicle:mrGbMGetAutoStartStop() 
				and self.vehicle.mrGbMS.G27Mode  <= 0 
				and not self.vehicle.mrGbMS.TorqueConverterOrHydro then				
	-- idle
			brakeNeutral = true 
		else
			brakeNeutral = false
		end
	elseif currentAbsSpeed        < self.vehicle.mrGbMG.minAbsSpeed + self.vehicle.mrGbMG.minAbsSpeed 
			or self.lastMotorRpm     < minRpmReduced 
			or ( self.lastMotorRpm   < self.minRequiredRpm and self.minThrottle > 0.2 ) then
	-- no transmission 
		brakeNeutral = true 
	else
		brakeNeutral = false
	end
	
--print(string.format("%1.3f %4d %s %2.1f", accelerationPedal, self.brakeNeutralTimer - g_currentMission.time, tostring(brakeNeutral), currentAbsSpeed))
		
	if brakeNeutral then
	-- neutral	
	
	--print("neutral: "..tostring(self.wheelRpm).." "..tostring(currentAbsSpeed))
	
		if  not ( self.vehicle.mrGbMS.NeutralActive ) 
				and self.vehicle:mrGbMGetAutoStartStop()
				and self.vehicle.mrGbMS.G27Mode <= 0
				and self.brakeNeutralTimer  < g_currentMission.time
				and ( currentAbsSpeed       < self.vehicle.mrGbMG.minAbsSpeed
					 or ( self.lastMotorRpm  < minRpmReduced and not self.vehicle:mrGbMGetAutomatic() ) ) then
			self.vehicle:mrGbMSetNeutralActive( true ) 
		end
	-- handbrake 
		if      self.vehicle.mrGbMS.NeutralActive 
				and self.vehicle:mrGbMGetAutoHold( )
				and self.brakeNeutralTimer  < g_currentMission.time 
			  and currentAbsSpeed         < self.vehicle.mrGbMG.minAbsSpeed then
			self.vehicle:mrGbMSetState( "AutoHold", true )
		end
					
		if self.vehicle:mrGbMGetAutoClutch() then
			self.autoClutchPercent  = math.max( 0, self.autoClutchPercent -self.tickDt/self.vehicle.mrGbMS.ClutchTimeDec ) 
			self.vehicle:mrGbMSetState( "IsNeutral", true )
		elseif self.vehicle.mrGbMS.ManualClutch > 0.9 then
			self.vehicle:mrGbMSetState( "IsNeutral", true )
		end
		
		if self.vehicle.mrGbML.gearShiftingNeeded > 0 then
			if g_currentMission.time>=self.vehicle.mrGbML.gearShiftingTime then
				if self.vehicle.mrGbML.gearShiftingNeeded < 2 then	
					self.vehicle:mrGbMDoGearShift() 
				end 
				self.vehicle.mrGbML.gearShiftingNeeded = 0 
			elseif self.vehicle.mrGbML.gearShiftingNeeded < 2 then	
				if self.autoClutchPercent <= 0 then
					self.vehicle:mrGbMDoGearShift() 
				end 
			end 
		end

		self.noTransmission = true
		if self.vehicle.mrGbMS.Hydrostatic then
			self.hydrostaticFactor = 0
		end
		
--**********************************************************************************************************		
	else
--**********************************************************************************************************		
		self.vehicle:mrGbMSetState( "IsNeutral", false )

		-- acceleration for idle/minimum rpm		
		if lastNoTransmission then
			self.minThrottle  = math.max( 0.3, self.vehicle.mrGbMS.HandThrottle )
			self.minThrottleS = math.max( 0.3, self.vehicle.mrGbMS.HandThrottle )
			self.hydrostaticStartTime = g_currentMission.time 
			if self.vehicle.mrGbMS.Hydrostatic then			
				self.hydrostaticFactor = Utils.clamp( ( self.vehicle.mrGbMG.minAutoGearSpeed + self.vehicle.mrGbMG.minAutoGearSpeed ) * self.idleRpm / ( 3.6 * self.ratedRpm * self.vehicle.mrGbML.currentGearSpeed ), 
																							math.max( 0, self.vehicle.mrGbMS.HydrostaticMin ),
																							math.min( 1, self.vehicle.mrGbMS.HydrostaticMax ) )
			end
			self.targetRpm = minRpmReduced
		else
			local minThrottleRpm = minRpmReduced 
			if handThrottle > 0 then
				minThrottleRpm = Utils.clamp( handThrottleRpm - mrGearboxMogli.ptoRpmThrottleDiff, minRpmReduced, self.minRequiredRpm )
			end
			if self.nonClampedMotorRpm <= minThrottleRpm then
				self.minThrottle  = 1
			elseif self.nonClampedMotorRpm < self.minRequiredRpm then
				self.minThrottle = ( self.minRequiredRpm - self.nonClampedMotorRpm ) / ( self.minRequiredRpm - minThrottleRpm )
			else
				self.minThrottle = 0
			end			
			self.minThrottleS = Utils.clamp( self.minThrottleS + self.vehicle.mrGbML.smoothFast * ( self.minThrottle - self.minThrottleS ), 0, 1 )
			
			if self.vehicle.mrGbMS.Hydrostatic then			
				-- launch
				if self.hydrostaticStartTime == nil then
					print("ERROR (6944)")
					self.hydrostaticStartTime = g_currentMission.time + 2500
				elseif g_currentMission.time - self.hydrostaticStartTime < 2500 then
					local sf = ( g_currentMission.time - self.hydrostaticStartTime ) * 0.0004 
					self.hydrostaticFactor = math.max( self.hydrostaticFactor, ( 1 - sf ) *
																	Utils.clamp( ( self.vehicle.mrGbMG.minAutoGearSpeed + self.vehicle.mrGbMG.minAutoGearSpeed ) * self.idleRpm / ( 3.6 * self.ratedRpm * self.vehicle.mrGbML.currentGearSpeed ), 
																								math.max( 0, self.vehicle.mrGbMS.HydrostaticMin ),
																								math.min( 1, self.vehicle.mrGbMS.HydrostaticMax ) ) )
					self.targetRpm = Utils.clamp( self.idleRpm + sf * ( self.ratedRpm - self.idleRpm ), minRpmReduced, self.targetRpm )
				end
			end
		end
		
		self.lastThrottle = math.max( self.minThrottle, accelerationPedal )								
		
		if self.vehicle.mrGbML.gearShiftingNeeded > 0 then
	--**********************************************************************************************************		
	-- during gear shift with automatic clutch
			if self.vehicle.mrGbML.gearShiftingNeeded == 2 and g_currentMission.time < self.vehicle.mrGbML.gearShiftingTime then	
				if self.lastRealMotorRpm > 0.9 * self.ratedRpm then
					self.vehicle.mrGbML.gearShiftingNeeded  = 3
				end
				accelerationPedal = 1
			else               
				accelerationPedal = 0
				self.noTorque     = true
			end

			if g_currentMission.time >= self.vehicle.mrGbML.gearShiftingTime then
				if self.vehicle.mrGbML.gearShiftingNeeded < 2 then	
					self.vehicle:mrGbMDoGearShift() 
				end 
				self.vehicle.mrGbML.gearShiftingNeeded = 0 
				self.maxPossibleRpm          = self.maxAllowedRpm 
				self.vehicle.mrGbML.manualClutchTime = 0
				clutchMode                   = 2 
			elseif self.vehicle.mrGbML.gearShiftingNeeded < 2 then	
				if self.autoClutchPercent > 0 and g_currentMission.time < self.vehicle.mrGbML.clutchShiftingTime then
					self.autoClutchPercent   = Utils.clamp( ( self.vehicle.mrGbML.clutchShiftingTime - g_currentMission.time )/self.vehicle.mrGbMS.ClutchShiftTime, 0, self.autoClutchPercent ) 					
				else
					self.vehicle:mrGbMDoGearShift() 
					self.noTransmission = true
				end 
			else
				self.noTransmission = true
			end 
			self.prevNonClampedMotorRpm = self.maxAllowedRpm
			self.extendAutoShiftTimer   = true
			
		elseif self.vehicle.mrGbML.gearShiftingNeeded < 0 then
	--**********************************************************************************************************		
	-- during gear shift with manual clutch
			self.noTransmission = true			
			self.vehicle:mrGbMDoGearShift() 
			self.vehicle.mrGbML.gearShiftingNeeded = 0						
			
		elseif not ( self.vehicle:mrGbMGetAutoClutch() ) and self.vehicle.mrGbMS.ManualClutch < self.vehicle.mrGbMS.MinClutchPercent + 0.1 then
	--**********************************************************************************************************		
	-- manual clutch pressed
			self.noTransmission = true		
		else
	--**********************************************************************************************************		
	-- normal drive with gear and clutch
			self.noTransmission = false

			local accHydrostaticTarget = false

	--**********************************************************************************************************		
	-- reduce hydrostaticFactor instead of braking  
			if      self.vehicle.mrGbMS.Hydrostatic
					and self.ptoOn then
				accHydrostaticTarget = true			
			end
			
	--**********************************************************************************************************		
	-- no transmission while braking 
			if      self.vehicle.cruiseControl.state == 0 
					and self.vehicle.steeringEnabled
					and autoOpenClutch 
					and accelerationPedal       < self.vehicle.mrGbMG.brakeNeutralLimit 
					and self.nonClampedMotorRpm < self.minRequiredRpm
					and ( self.vehicle.axisForwardIsAnalog 
						 or not accHydrostaticTarget
						 or currentAbsSpeed       < self.vehicle.mrGbMG.minAbsSpeed ) then
				self.noTransmission = true
			end
		
			clutchMode = 1 -- calculate clutch percent respecting inc/dec time ms

	--**********************************************************************************************************		
	-- hydrostatic drive
			if self.vehicle.mrGbMS.Hydrostatic then
				local gearMaxSpeed = self.vehicle.mrGbMS.Ranges2[self.vehicle.mrGbMS.CurrentRange2].ratio
													 * self.vehicle.mrGbMS.GlobalRatioFactor
				if self.vehicle.mrGbMS.ReverseActive then	
					gearMaxSpeed = gearMaxSpeed * self.vehicle.mrGbMS.ReverseRatio 
				end
				
				local currentGear = self:combineGear()
				local maxGear
				if     not self.vehicle:mrGbMGetAutoShiftRange() then
					maxGear = table.getn( self.vehicle.mrGbMS.Gears )
				elseif not self.vehicle:mrGbMGetAutoShiftGears() then 
					maxGear = table.getn( self.vehicle.mrGbMS.Ranges )
				else
					maxGear = table.getn( self.vehicle.mrGbMS.Gears ) * table.getn( self.vehicle.mrGbMS.Ranges )
				end
				
				local refTime   = self.lastClutchClosedTime
				local downTimer = refTime + self.vehicle.mrGbMS.AutoShiftTimeoutShort
				local upTimer   = refTime + self.vehicle.mrGbMS.AutoShiftTimeoutShort
				
				local bestE     = -1
				local bestH     = self.hydrostaticFactor
				local bestG     = currentGear
				local bestS     = 0
				local first     = true
				local tooBig    = false
				local tooSmall  = false
				local sMin, sMax
				
				local g = bestG
				if self.vehicle:mrGbMGetAutomatic() then
					g = 1
				end
				
				if      self.vehicle.cruiseControl.state > 0 
						and self.vehicle.mrGbML.currentGearSpeed * self.idleRpm / self.ratedRpm > currentSpeedLimit then
					-- allow down shift after short timeout
				elseif self.vehicle.mrGbML.lastGearSpeed < self.vehicle.mrGbML.currentGearSpeed + mrGearboxMogli.eps then
					if self.autoClutchPercent > self.vehicle.mrGbMS.AutoShiftMinClutch then
						downTimer = refTime + self.vehicle.mrGbMS.AutoShiftTimeoutLong 
					end
				elseif self.vehicle.mrGbML.lastGearSpeed > self.vehicle.mrGbML.currentGearSpeed + mrGearboxMogli.eps then
					if      accelerationPedal       > 0.5
							and self.nonClampedMotorRpm > self.ratedRpm then
						-- allow up shift after short timeout
						upTimer   = refTime -- + self.vehicle.mrGbMS.AutoShiftTimeoutShort
					else
						upTimer   = refTime + self.vehicle.mrGbMS.AutoShiftTimeoutLong 
					end
				end		
				
				-- target RPM
				local c = self.lastRealMotorRpm 
				local t = self.targetRpm 
			--if not self.ptoOn and 0.8 < self.motorLoadP and self.motorLoadP < 1 then
			--	local d = 1 - 10 * math.abs( self.motorLoadP - 0.9 )
			--	t = math.min( t + d * 100, self.ratedRpm )
			--end
				
				local a = math.min( accelerationPedal, self.lastThrottle )
				
				-- min RPM
				local n = minTarget --self.idleRpm
				
				-- max RPM
				local m0 = self.maxAllowedRpm			
				if self.vehicle.mrGbMS.AutoShiftUpRpm ~= nil    and m0 > self.vehicle.mrGbMS.AutoShiftUpRpm then
					m0 = self.vehicle.mrGbMS.AutoShiftUpRpm 
				end
				if self.vehicle.mrGbMS.HydrostaticMaxRpm ~= nil and m0 > self.vehicle.mrGbMS.HydrostaticMaxRpm then
					m0= self.vehicle.mrGbMS.HydrostaticMaxRpm
				end
				local m = m0
				
				if self.vehicle.mrGbMS.EcoMode then
					m = t
				end
				local d = mrGearboxMogli.huge
				if self.ptoOn and d > mrGearboxMogli.ptoRpmThrottleDiff then
					d = mrGearboxMogli.ptoRpmThrottleDiff
				end
				
				n  = math.max( n, t - d )
				m  = math.min( m, t + d )
				local ns = math.max( self.idleRpm, t - d )
				local ms = math.min( m0, t + d )
				
				-- boundaries hStart, hMin & hMax
				local hMax0 = self.vehicle.mrGbMS.HydrostaticMax			
				-- find the best hMin
				local hMin0 = self.vehicle.mrGbMS.HydrostaticMin 
				
				if self.vehicle.mrGbMS.HydrostaticMin < 0 then
					if self.vehicle.mrGbMS.ReverseActive then	
						hMax0 = -self.vehicle.mrGbMS.HydrostaticMin 
					end
					hMin0 = 0
				end
				if hMin0 < 0 then -- mrGearboxMogli.eps then
					hMin0 =  0 --mrGearboxMogli.eps
				end
				
				while true do
					local isValidEntry = true
					local hMin         = hMin0
					local hMax         = hMax0

					local i2g, i2r = self:splitGear( g )
					
					if self.vehicle:mrGbMGetAutomatic() then
						if isValidEntry and self.vehicle:mrGbMGetAutoShiftGears() and mrGearboxMogli.mrGbMIsNotValidEntry( self.vehicle, self.vehicle.mrGbMS.Gears[i2g], i2g, i2r ) then
							isValidEntry = false
						end
						if isValidEntry and self.vehicle:mrGbMGetAutoShiftRange() and mrGearboxMogli.mrGbMIsNotValidEntry( self.vehicle, self.vehicle.mrGbMS.Ranges[i2r], i2g, i2r ) then
							isValidEntry = false
						end
						if isValidEntry then
							if first then
								first = false
							elseif hMin < self.vehicle.mrGbMS.HydrostaticStart then
								hMin  = self.vehicle.mrGbMS.HydrostaticStart 
							end
						end
					end
					
					local spd = self.vehicle.mrGbMS.Gears[i2g].speed
										* self.vehicle.mrGbMS.Ranges[i2r].ratio
										* gearMaxSpeed 
											
					local r = mrGearboxMogli.gearSpeedToRatio( self.vehicle, spd )					
					local w = ( self.absWheelSpeedRpm + math.max( 0, self.absWheelSpeedRpm - prevWheelSpeedRpm ) ) * r
					
					if self.vehicle:mrGbMGetAutomatic() and g ~= currentGear then						
						if not isValidEntry then
						-- nothing 
						elseif self.vehicle.mrGbMS.AutoShiftTimeoutLong > 0 then								
							local autoShiftTimeout = 0
							if     spd < self.vehicle.mrGbML.currentGearSpeed - mrGearboxMogli.eps then
								autoShiftTimeout = downTimer							
							elseif spd > self.vehicle.mrGbML.currentGearSpeed + mrGearboxMogli.eps then
								autoShiftTimeout = upTimer
							else
								autoShiftTimeout = math.min( downTimer, upTimer )
							end
							
							autoShiftTimeout = autoShiftTimeout + self.vehicle.mrGbMS.GearTimeToShiftGear
							
							if autoShiftTimeout > g_currentMission.time then
								if mrGearboxMogli.debugGearShift then print(tostring(g)..": Still waiting") end
								isValidEntry = false
							end
						end
						
						if not isValidEntry then
						--nothing
						elseif  self.deltaRpm < -mrGearboxMogli.autoShiftMaxDeltaRpm
								and spd           > self.vehicle.mrGbML.currentGearSpeed + mrGearboxMogli.eps then
							if mrGearboxMogli.debugGearShift then print(tostring(g)..": no down shift II") end
							isValidEntry = false
						elseif  self.deltaRpm > mrGearboxMogli.autoShiftMaxDeltaRpm
								and spd           < self.vehicle.mrGbML.currentGearSpeed - mrGearboxMogli.eps
								and self.autoClutchPercent > self.vehicle.mrGbMS.AutoShiftMinClutch then
							if mrGearboxMogli.debugGearShift then print(tostring(g)..": no up shift II") end
							isValidEntry = false
						end
					end
										
					if      self.vehicle:mrGbMGetAutomatic()
							and isValidEntry then												
													
						if     w < self.idleRpm * hMin then
							if mrGearboxMogli.debugGearShift then print(tostring(g)..": too big") end
							isValidEntry = false			
							tooBig       = true
						elseif w > self.maxAllowedRpm * hMax then
							if mrGearboxMogli.debugGearShift then print(tostring(g)..": too small") end
							isValidEntry = false				
							tooSmall     = true
						end
					end
									
					if isValidEntry or not self.vehicle:mrGbMGetAutomatic() then
						if self.vehicle.mrGbMG.debugPrint then
							local sInt = math.floor(0.5+3.6*spd)
							if sMin == nil or sMin > sInt then
								sMin = sInt
							end
							if sMax == nil or sMax < sInt then
								sMax = sInt
							end
						end
					
						local h     = self.hydrostaticFactor
						local hMin1 = Utils.clamp( w / m, hMin, hMax )
						local hMax1 = Utils.clamp( w / n, hMin, hMax )
						local lastH = Utils.clamp( self.hydrostaticFactor, hMin1, hMax1 )
						
						-- smooth shifting with power shift
						if      self.vehicle.mrGbMS.GearTimeToShiftGear < self.vehicle.mrGbMG.shiftEffectTime
								and ( clutchMode > 1 or ( g ~= currentGear and self.nonClampedMotorRpm > 1 ) ) then
							lastH = Utils.clamp( self.hydrostaticFactor * self.vehicle.mrGbML.currentGearSpeed / spd, hMin1, hMax1 )
						end
						
						-- calculated target hydrostatic factor w/o HydrostaticIncFactor																						
						if     hMin1 >= hMax1 then
							h = hMin1
						elseif self.ptoOn and ( self.vehicle.cruiseControl.state > 0 or self.vehicle.mrGbML.hydroTargetSpeed ~= nil ) then
							h = Utils.clamp( self.ratedRpm * currentSpeedLimit / ( t * spd ), hMin1, hMax1 )
						elseif a <= mrGearboxMogli.eps then
							h = lastH
						else
							h = lastH
							
							local sp   = nil
							local sf   = nil
							local hf   = math.max( hMin, w / m )
							local ht   = math.min( hMax, w / n )
							
							for f=0,1,0.01 do
								local h2 = ht + f * ( hMin1 - ht )
								local r2 = w / h2 
														
								local mt = self.currentTorqueCurve:get( r2 )
								if mt > mrGearboxMogli.eps and mt > self.lastPtoTorque then
									local e  = self:getHydroEff( h2 )
									local rt = a * ( mt - self.lastPtoTorque ) 
									local lt = Utils.clamp( 1 - e, 0, 1 ) * rt
									rt = rt - lt
									if self.motorLoad < rt and self.motorLoad < self.lastTransTorque - mrGearboxMogli.eps then
										rt = self.motorLoad 
									end
									
									local ratio = self.fuelCurve:get( r2 ) / math.max( 0.001, mrGearboxMogli.powerFuelCurve:get( ( rt + self.lastPtoTorque + lt ) / mt ) )										
									local rp = ( rt + self.lastPtoTorque + lt ) * r2
									local dp = math.max( 0, requestedPower - mt * r2 )
									local df = ratio * rp
																	
									if     sp == nil 
											or dp < sp 
											or ( dp == sp and df < sf ) then
										sp = dp
										sf = df 
										h  = h2
									end
								end
							end
						end
						
						-- now apply HydrostaticIncFactor
						local hr = h
						-- after gear shift
						if     h > lastH then
							h = math.max( lastH + self.vehicle.mrGbML.smoothBase * ( h - lastH )      * self.vehicle.mrGbMS.HydrostaticSmIFactor,
														lastH + math.min( h - lastH,  self.tickDt * self.vehicle.mrGbMS.HydrostaticIncFactor ) )				
						elseif h < lastH then
							h = math.min( lastH + self.vehicle.mrGbML.smoothBase * ( h - lastH )      * self.vehicle.mrGbMS.HydrostaticSmDFactor,
														lastH + math.max( h - lastH, -self.tickDt * self.vehicle.mrGbMS.HydrostaticDecFactor ) )
						end
																		
						local e = 0
						if      ( self.vehicle:mrGbMGetAutomatic() 
									 or mrGearboxMogli.debugGearShift ) then
							e = self:getHydroEff( h )
						end
												
						if mrGearboxMogli.debugGearShift then
							print(string.format("g: %1d target: %4.0f c: %4.0f w: %4.0f r: %4.0f hMin: %0.3f hMax: %0.3f h: %0.3f hr: %0.3f hl: %0.3f e: %0.3f cm: %d lnt: ",g,t,c,w,r,hMin,hMax,h,hr,lastH,e,clutchMode)..tostring(lastNoTransmission))
						end
						
						if self.vehicle:mrGbMGetAutomatic() then
							local t1 = self:getRpmScore( w / h, ns, ms )							
							local t2
							if t1 <= 0 then
								t2 = 1+e
							else
								t2 = 1-t1
							end
							
							if mrGearboxMogli.debugGearShift then
								print(string.format("w/h: %4.0f n: %4.0f (%4.0f) m: %4.0f (%4.0f) => %5f / %5f", w/h, n, ns, m, ms, t1, t2 ))
							end
							
							if     bestE < t2 
									or ( math.abs( bestE - t2 ) < 1e-4
									 and math.abs( self.vehicle.mrGbML.currentGearSpeed - spd ) < math.abs( self.vehicle.mrGbML.currentGearSpeed - bestS ) ) then
								bestE = t2
								bestG = g
								bestH = h
								bestS = spd
							end
						else
							bestH = h
							break
						end					


						
					elseif mrGearboxMogli.debugGearShift then
						print(string.format("g: %1d target: %4.0f c: %4.0f w: %4.0f r: %4.0f hMin: %0.3f hMax: %0.3f cm: %d lnt: ",g,t,c,w,r,hMin,hMax,clutchMode)..tostring(lastNoTransmission))
					end
					
					
					
					
					
					if self.vehicle:mrGbMGetAutomatic() then				
						g = g + 1
						if g > maxGear then
							break
						end							
					else
						break
					end							
				end
				
				if self.vehicle:mrGbMGetAutomatic() then
					if bestE < 0 then
						if     tooBig   then
							bestG = 1
						elseif tooSmall then
							bestG = maxGear
						end
					end
					
					if self.vehicle.mrGbMG.debugPrint then
						self.vehicle.mrGbML.autoShiftInfo = "target: "..tostring(math.floor(self.targetRpm))
																							.." power: "..tostring(math.floor(0.5+100*self.requestedPower/self.currentMaxPower))
																							.." deriv: "..string.format("%0.6f", self.deltaRpm)
																							.." spd: "..tostring(sMin).." .. "..tostring(sMax)
																							.."\ncurrent: "..tostring(self.vehicle.mrGbMS.CurrentGear)
																							.." speed: "..tostring(math.floor(0.5+3.6*self.vehicle.mrGbML.currentGearSpeed))
																							.." eff: "..string.format("%0.3f",self:getHydroEff( self.hydrostaticFactor ))
																							.." => best: "..tostring(bestG)
																							.." speed: "..tostring(math.floor(0.5+3.6*bestS))
																							.." eff: "..string.format("%0.3f",bestE)
																							.."\nupTimer: "..tostring(math.floor(math.max(0, upTimer-g_currentMission.time)))
																							.." downTimer: "..tostring(math.floor(math.max(0, downTimer-g_currentMission.time)))
																							.." tooBig: "..tostring(tooBig)
																							.." tooSmall: "..tostring(tooSmall)
					end				
					
					if bestG ~= currentGear then			
						local i2g, i2r = self:splitGear( bestG )
						
						if self.vehicle.mrGbMG.debugPrint then
							print(self.vehicle.mrGbML.autoShiftInfo)
							print("-------------------------------------------------------")
						end
						
						if self.vehicle:mrGbMGetAutoShiftGears() then
							self.vehicle:mrGbMSetCurrentGear( i2g ) 
						end
						if self.vehicle:mrGbMGetAutoShiftRange() then
							self.vehicle:mrGbMSetCurrentRange( i2r ) 
						end
						clutchMode                           = 2
						self.vehicle.mrGbML.manualClutchTime = 0
					end
				end
				
				self.hydrostaticFactor = bestH
				
				-- launch & clutch					
				local r = mrGearboxMogli.gearSpeedToRatio( self.vehicle, self.vehicle.mrGbML.currentGearSpeed )
				if     self.vehicle.mrGbMS.HydrostaticLaunch then
					clutchMode             = 0
					self.autoClutchPercent = self.vehicle.mrGbMS.MaxClutchPercent
				elseif self.hydrostaticFactor <= hMin0 then
					clutchMode             = 1
					self.hydrostaticFactor = hMin0 
				elseif self.autoClutchPercent + mrGearboxMogli.eps < 1 then
					clutchMode             = 1
					self.hydrostaticFactor = math.max( self.hydrostaticFactor, r / mrGearboxMogli.maxHydroGearRatio )
				elseif self.hydrostaticFactor < r / mrGearboxMogli.maxHydroGearRatio then
					-- open clutch to stop
					clutchMode             = 1
					self.hydrostaticFactor = r / mrGearboxMogli.maxHydroGearRatio
				else				
					local smallestGearSpeed  = self.vehicle.mrGbMS.Gears[bestG].speed 
																	 * self.vehicle.mrGbMS.Ranges[1].ratio 
																	 * self.vehicle.mrGbMS.Ranges2[1].ratio
																	 * self.vehicle.mrGbMS.GlobalRatioFactor
																	 * hMin0
																	 * 3.6
					if self.vehicle.mrGbMS.ReverseActive then	
						smallestGearSpeed = smallestGearSpeed * self.vehicle.mrGbMS.ReverseRatio 
					end															 
					
					if currentAbsSpeed < smallestGearSpeed then
						clutchMode             = 1
					else
						clutchMode             = 0
						self.autoClutchPercent = self.vehicle.mrGbMS.MaxClutchPercent
						self.hydrostaticFactor = math.max( self.hydrostaticFactor, r / mrGearboxMogli.maxHydroGearRatio )
					end			
				end			
				
				-- check static boundaries
				if     self.hydrostaticFactor > hMax0 then
					self.hydrostaticFactor = hMax0
				elseif self.hydrostaticFactor < hMin0 then
					self.hydrostaticFactor = hMin0
				end

	--**********************************************************************************************************		
	-- automatic shifting			
			elseif  self.vehicle:mrGbMGetAutomatic() 
					and self.vehicle.aiIsStarted
					and self.turnStage ~= nil and self.turnStage > 0 then			
				mrGearboxMogli.setLaunchGear( self.vehicle )
			elseif self.vehicle:mrGbMGetAutomatic() then		
				local maxAutoRpm   = self.maxAllowedRpm - math.min( 50, 0.5 * ( self.maxAllowedRpm - self.ratedRpm ) )
				local halfOverheat = 0.5 * self.vehicle.mrGbMS.ClutchOverheatStartTime										
				local gearMaxSpeed = self.vehicle.mrGbMS.Ranges2[self.vehicle.mrGbMS.CurrentRange2].ratio
													 * self.vehicle.mrGbMS.GlobalRatioFactor
				if self.vehicle.mrGbMS.ReverseActive then	
					gearMaxSpeed = gearMaxSpeed * self.vehicle.mrGbMS.ReverseRatio 
				end
				
				local currentGear = self:combineGear()
				local maxGear
				if     not self.vehicle:mrGbMGetAutoShiftRange() then
					maxGear = table.getn( self.vehicle.mrGbMS.Gears )
				elseif not self.vehicle:mrGbMGetAutoShiftGears() then 
					maxGear = table.getn( self.vehicle.mrGbMS.Ranges )
				else
					maxGear = table.getn( self.vehicle.mrGbMS.Gears ) * table.getn( self.vehicle.mrGbMS.Ranges )
				end

				local scoreRpm = nil
				local scorePwr = nil
				local scoreLag = nil
				local scoreCur = nil
				local scoreNxt = nil
				local nextGear = nil
				local bestGear = currentGear 
				local downRpm  = math.max( self.idleRpm, self.vehicle.mrGbMS.MinTargetRpm )
				local upRpm    = 0.5 * ( self.ratedRpm + self.maxAllowedRpm )
							
				if self.vehicle.mrGbMS.AutoShiftDownRpm ~= nil and self.vehicle.mrGbMS.AutoShiftDownRpm > downRpm then
					downRpm = self.vehicle.mrGbMS.AutoShiftDownRpm
				end
				if self.vehicle.mrGbMS.AutoShiftUpRpm   ~= nil and self.vehicle.mrGbMS.AutoShiftUpRpm   < upRpm   then
					upRpm  = self.vehicle.mrGbMS.AutoShiftUpRpm
				end
				
				if self.ptoOn then
					upRpm   = Utils.clamp( self.minRequiredRpm + mrGearboxMogli.autoShiftRpmDiff, downRpm, upRpm )
					downRpm = Utils.clamp( math.max( self.minRequiredRpm - mrGearboxMogli.autoShiftRpmDiff, minRpmReduced ), downRpm, upRpm )
				end
				
				local currentGearPower = self.absWheelSpeedRpmS * gearRatio
				if self.stallRpm < currentGearPower and currentGearPower < self.maxAllowedRpm then
					currentGearPower = currentGearPower * self.currentTorqueCurve:get( currentGearPower )
				else
					currentGearPower = 0
				end
				local bestSpeed  = nil
				local nextSpeed  = nil
				local maxDcSpeed = math.huge
				
				if      self.vehicle.dCcheckModule ~= nil
						and self.vehicle:dCcheckModule("gasAndGearLimiter") 
						and self.vehicle.driveControl.gasGearLimiter.gearLimiter ~= nil 
						and self.vehicle.driveControl.gasGearLimiter.gearLimiter < 1.0 then
				
					local maxGearSpeed = 0
					for i = 1,maxGear do
						local i2g, i2r = self:splitGear( i )							
						local spd      = gearMaxSpeed * self.vehicle.mrGbMS.Gears[i2g].speed * self.vehicle.mrGbMS.Ranges[i2r].ratio		
						if maxGearSpeed < spd then
							maxGearSpeed = spd
						end
					end
					
					if maxGearSpeed > 0 then
						maxDcSpeed = self.vehicle.driveControl.gasGearLimiter.gearLimiter * maxGearSpeed
					end
				end

				local refTime   = self.lastClutchClosedTime
				local downTimer = refTime + self.vehicle.mrGbMS.AutoShiftTimeoutShort
				local upTimer   = refTime + self.vehicle.mrGbMS.AutoShiftTimeoutShort
				
				if      self.vehicle.cruiseControl.state > 0 
						and self.vehicle.mrGbML.currentGearSpeed * self.idleRpm / self.ratedRpm > currentSpeedLimit then
					-- allow down shift after short timeout
				elseif self.vehicle.mrGbML.lastGearSpeed < self.vehicle.mrGbML.currentGearSpeed + mrGearboxMogli.eps then
					if self.autoClutchPercent > self.vehicle.mrGbMS.AutoShiftMinClutch then
						downTimer = refTime + self.vehicle.mrGbMS.AutoShiftTimeoutLong 
					end
				elseif self.vehicle.mrGbML.lastGearSpeed > self.vehicle.mrGbML.currentGearSpeed + mrGearboxMogli.eps then
					if      accelerationPedal       > 0.5
							and self.nonClampedMotorRpm > self.ratedRpm then
						-- allow up shift after short timeout
						upTimer   = refTime -- + self.vehicle.mrGbMS.AutoShiftTimeoutShort
					else
						upTimer   = refTime + self.vehicle.mrGbMS.AutoShiftTimeoutLong 
					end
				end		

				local sMin = nil
				local sMax = nil
							
				for i = 1,maxGear do
					local i2g, i2r     = self:splitGear( i )							
					local isValidEntry = true
					local timeToShift = 0
					local spd, rpmHi, rpmLo
					
					if i == currentGear then
						spd   = self.vehicle.mrGbML.currentGearSpeed
						rpmHi = self.nonClampedMotorRpmS
						rpmLo = rpmHi
					else
						if i2g ~= self.vehicle.mrGbMS.CurrentGear then
							timeToShift = math.max( timeToShift, self.vehicle.mrGbMS.GearTimeToShiftGear )
						end
						if i2r ~= self.vehicle.mrGbMS.CurrentRange then
							timeToShift = math.max( timeToShift, self.vehicle.mrGbMS.GearTimeToShiftHl )
						end
						
						spd   = gearMaxSpeed * self.vehicle.mrGbMS.Gears[i2g].speed * self.vehicle.mrGbMS.Ranges[i2r].ratio								
						rpmHi = self.absWheelSpeedRpmS * mrGearboxMogli.gearSpeedToRatio( self.vehicle, spd )
						rpmLo = rpmHi					
						--**********************************************************************************--
						-- estimate speed lost: 3.6 km/h lost at wheelLoad above 50 kNm for every 800 ms					
						if timeToShift > 0 and spd > 0 and self.maxMotorTorque > 0 then
							-- rpmLo can become negative !!!
							rpmLo = rpmHi - timeToShift * 0.00125 * Utils.clamp( self.wheelLoadS * 0.02, 0.1, 2 ) * self.ratedRpm / spd
						end
						--**********************************************************************************--
					end
					
					if     spd > maxDcSpeed 
							or spd < self.vehicle.mrGbMG.minAutoGearSpeed then
						isValidEntry = false
					end
					
					if      self.vehicle.cruiseControl.state > 0 
							and spd * self.idleRpm > currentSpeedLimit * self.ratedRpm then
						isValidEntry = false
					end			
										
					if i ~= currentGear then
						if isValidEntry and self.vehicle:mrGbMGetAutoShiftGears() and mrGearboxMogli.mrGbMIsNotValidEntry( self.vehicle, self.vehicle.mrGbMS.Gears[i2g], i2g, i2r ) then
							isValidEntry = false
						end
						if isValidEntry and self.vehicle:mrGbMGetAutoShiftRange() and mrGearboxMogli.mrGbMIsNotValidEntry( self.vehicle, self.vehicle.mrGbMS.Ranges[i2r], i2g, i2r ) then
							isValidEntry = false
						end
						
						if      isValidEntry 
								and i2g ~= self.vehicle.mrGbMS.CurrentGear
								and i2r ~= self.vehicle.mrGbMS.CurrentRange then
							if self.vehicle.mrGbMS.GearTimeToShiftGear > self.vehicle.mrGbMS.GearTimeToShiftHl then
								-- shifting gears is more expensive => avoid paradox up/down shifts
								if      spd > self.vehicle.mrGbML.currentGearSpeed + mrGearboxMogli.eps 
										and i2g < self.vehicle.mrGbMS.CurrentGear then
									isValidEntry = false
								elseif  spd < self.vehicle.mrGbML.currentGearSpeed - mrGearboxMogli.eps 
										and i2g > self.vehicle.mrGbMS.CurrentGear then
									isValidEntry = false
								end
							else
								-- shifting ranges is more expensive => avoid up/paradox down shifts
								if      spd > self.vehicle.mrGbML.currentGearSpeed + mrGearboxMogli.eps 
										and i2r < self.vehicle.mrGbMS.CurrentRange then
									isValidEntry = false
								elseif  spd < self.vehicle.mrGbML.currentGearSpeed - mrGearboxMogli.eps 
										and i2r > self.vehicle.mrGbMS.CurrentRange then
									isValidEntry = false
								end
							end
						end
						
						if      isValidEntry 
								and timeToShift > self.vehicle.mrGbMG.maxTimeToSkipGear
								and spd         > self.vehicle.mrGbMS.LaunchGearSpeed
								and spd         > self.vehicle.mrGbML.currentGearSpeed + mrGearboxMogli.eps then
							if      self.vehicle.mrGbMS.GearTimeToShiftGear > self.vehicle.mrGbMG.maxTimeToSkipGear
									and i2g > self.vehicle.mrGbMS.CurrentGear + 1 then
								for j=self.vehicle.mrGbMS.CurrentGear+1,i2g-1 do
									if not mrGearboxMogli.mrGbMIsNotValidEntry( self.vehicle, self.vehicle.mrGbMS.Gears[j], j, i2r ) then
										isValidEntry = false
									end
								end
							end
							if      self.vehicle.mrGbMS.GearTimeToShiftHl > self.vehicle.mrGbMG.maxTimeToSkipGear
									and i2r > self.vehicle.mrGbMS.CurrentRange + 1 then
								for j=self.vehicle.mrGbMS.CurrentRange+1,i2r-1 do
									if not mrGearboxMogli.mrGbMIsNotValidEntry( self.vehicle, self.vehicle.mrGbMS.Ranges[j], i2g, j ) then
										isValidEntry = false
									end
								end
							end
						end
					end
						
					if      isValidEntry 
							and i ~= currentGear then							
						if      self.deltaRpm < -mrGearboxMogli.autoShiftMaxDeltaRpm
								and spd           > self.vehicle.mrGbML.currentGearSpeed + mrGearboxMogli.eps then
							isValidEntry = false
						elseif  self.deltaRpm > mrGearboxMogli.autoShiftMaxDeltaRpm
								and spd           < self.vehicle.mrGbML.currentGearSpeed - mrGearboxMogli.eps
								and self.autoClutchPercent > self.vehicle.mrGbMS.AutoShiftMinClutch then
							isValidEntry = false
						end
					end
					
					if      isValidEntry 
							and i ~= currentGear
							and self.vehicle.mrGbMS.AutoShiftTimeoutLong > 0 then
							
						local autoShiftTimeout = 0
						if     spd < self.vehicle.mrGbML.currentGearSpeed - mrGearboxMogli.eps then
							autoShiftTimeout = downTimer							
						elseif spd > self.vehicle.mrGbML.currentGearSpeed + mrGearboxMogli.eps then
							autoShiftTimeout = upTimer
						else
							autoShiftTimeout = math.min( downTimer, upTimer )
						end
						
						autoShiftTimeout = autoShiftTimeout + timeToShift
						
						if autoShiftTimeout > g_currentMission.time then
							isValidEntry = false
						end
					end
					
					if isValidEntry then
						-- gear is possible 													
						local test = math.huge
						
            local testRpm
						
						testRpm = self:getRpmScore( rpmHi, downRpm, upRpm )
						if testRpm < 1 and rpmLo < rpmHi then
							testRpm = testRpm + self:getRpmScore( rpmLo, downRpm, upRpm )
						elseif testRpm < 1 then
							testRpm = testRpm + testRpm
						else
							testRpm = 2
						end

						local t1, t2 = 0, 0
						if self.stallRpm < rpmHi and rpmHi < self.maxAllowedRpm then
							t1 = self.currentTorqueCurve:get( rpmHi ) * mrGearboxMogli.autoShiftPowerRatio
						end
						if self.stallRpm < rpmLo and rpmLo < self.maxAllowedRpm then
							t2 = self.currentTorqueCurve:get( rpmLo ) * mrGearboxMogli.autoShiftPowerRatio
						end													
					
						local testPwr = Utils.clamp( ( self.requestedPower - rpmHi * t1 ) / self.currentMaxPower, 0, 1 )
					
						if testPwr < 1 and rpmLo < rpmHi then
							testPwr = testPwr + Utils.clamp( ( self.requestedPower - rpmLo * t2 ) / self.currentMaxPower, 0, 1 )
						elseif testPwr < 1 then
							testPwr = testPwr + testPwr
						else
							testPwr = 2
						end
					
						if      testPwr <= 0 
								and testRpm <= 0 then
							test = Utils.clamp( 0.001 * self.fuelCurve:get( rpmHi ), 0, 0.4 )
							if rpmLo < rpmHi then
								test = math.max( test, Utils.clamp( 0.001 * self.fuelCurve:get( rpmLo ), 0, 0.4 ) )
							--test = Utils.clamp( test + 0.0001 * ( rpmHi - rpmLo ) , 0, 1 )
							end
						elseif self.ptoOn then
							if testRpm > 0 then
							-- reach RPM window
								test = 4 + testRpm 
							else
							-- and optimize power afterwards
								test = 2 + testPwr 
							end
						else
							test = math.max( testRpm, testPwr )
							test = 2 + test + test
						end
							
						if     scoreRpm == nil 
								or scoreRpm > test 
								or ( math.abs( scoreRpm - test ) < 1e-4
								 and math.abs( self.vehicle.mrGbML.currentGearSpeed - spd ) < math.abs( self.vehicle.mrGbML.currentGearSpeed - bestSpeed ) ) then
							scoreRpm  = test
							bestGear  = i
							bestSpeed = spd
						end			
						
						if self.vehicle.mrGbMG.debugPrint or mrGearboxMogli.debugGearShif then
							local sInt = math.floor(0.5+3.6*spd)
							if sMin == nil or sMin > sInt then
								sMin = sInt
							end
							if sMax == nil or sMax < sInt then
								sMax = sInt
							end
							if i == currentGear then
								scoreCur = test
							elseif scoreNxt == nil 
									or scoreNxt > test
									or ( math.abs( scoreNxt - test ) < 1e-4
									 and math.abs( self.vehicle.mrGbML.currentGearSpeed - spd ) < math.abs( self.vehicle.mrGbML.currentGearSpeed - nextSpeed ) ) then
								scoreNxt  = test
								nextGear  = i
								nextSpeed = spd
							end
						end
					end
				end
				
				local timeToShift
				if nextGear ~= nil then
					local i2g, i2r = self:splitGear( nextGear )							
					timeToShift    = 0
					if i2g ~= self.vehicle.mrGbMS.CurrentGear then
						timeToShift = math.max( timeToShift, self.vehicle.mrGbMS.GearTimeToShiftGear )
					end
					if i2r ~= self.vehicle.mrGbMS.CurrentRange then
						timeToShift = math.max( timeToShift, self.vehicle.mrGbMS.GearTimeToShiftHl )
					end
				end
				
				if self.vehicle.mrGbMG.debugPrint or mrGearboxMogli.debugGearShift then
					self.vehicle.mrGbML.autoShiftInfo = "target: "..tostring(math.floor(self.targetRpm))
																						.." power: "..tostring(math.floor(0.5+100*self.requestedPower/self.currentMaxPower))
																						.." deriv: "..string.format("%0.6f", self.deltaRpm)
																						.." spd: "..tostring(sMin).." .. "..tostring(sMax)
																						.."\ncurrent: "..tostring(currentGear)
																						.." speed: "..tostring(math.floor(0.5+3.6*self.vehicle.mrGbML.currentGearSpeed))
																						.." next: "..tostring(nextGear)
																						.." => best: "..tostring(bestGear)
																						.." speed: "..tostring(math.floor(0.5+3.6*Utils.getNoNil(bestSpeed,0)))
																						.."\nupTimer: "..tostring(math.floor(math.max(0, upTimer-g_currentMission.time)))
																						.." downTimer: "..tostring(math.floor(math.max(0, downTimer-g_currentMission.time)))
																						.." timeToShift: "..tostring(timeToShift)
																						.."\nscoreCur: "..tostring(scoreCur)
																						.."\nscoreNxt: "..tostring(scoreNxt)
				end
				
				if currentGear ~= bestGear then
					local i2g, i2r = self:splitGear( bestGear )
					
					if self.vehicle.mrGbMG.debugPrint then
						print(self.vehicle.mrGbML.autoShiftInfo)
						print("-------------------------------------------------------")
					end
					
					if self.vehicle:mrGbMGetAutoShiftGears() then
						self.vehicle:mrGbMSetCurrentGear( i2g ) 
					end
					if self.vehicle:mrGbMGetAutoShiftRange() then
						self.vehicle:mrGbMSetCurrentRange( i2r ) 
					end
					clutchMode                           = 2
					self.vehicle.mrGbML.manualClutchTime = 0
				end										
			end
		end
	end
	
	--**********************************************************************************************************		
	-- clutch			
	
	if clutchMode > 0 and not ( self.noTransmission ) then
		if self.vehicle:mrGbMGetAutoClutch() or self.vehicle.mrGbMS.TorqueConverter then
			local openRpm   = self.vehicle.mrGbMS.OpenRpm --math.max( self.vehicle.mrGbMS.OpenRpm, self.stallRpm + 20 )
			local closeRpm  = self.vehicle.mrGbMS.CloseRpm
			local targetRpm = self.targetRpm
			
			if     clutchMode > 1 then
				openRpm        = self.ratedRpm 
				closeRpm       = self.ratedRpm 
				if self.vehicle.mrGbML.afterShiftRpm ~= nil and not ( self.vehicle.mrGbMS.TorqueConverter ) then
					targetRpm = math.max( self.minRequiredRpm, self.vehicle.mrGbML.afterShiftRpm )
				end
				self.torqueConverterLockupMs = nil
			elseif self.vehicle.mrGbMS.TorqueConverter and not self.ptoOn then
				-- reduce close RPM depending on motor load
				local refRpm   = math.max( self.lastMotorRpm, minRpmReduced )
			
				if self.vehicle.mrGbMS.CloseRpm > refRpm then
					closeRpm = refRpm + self.motorLoadS * ( self.vehicle.mrGbMS.CloseRpm - refRpm )
				end							
			elseif self.vehicle.mrGbMS.Hydrostatic then
				openRpm         = self.maxAllowedRpm
				closeRpm        = math.min( self.maxAllowedRpm, self.targetRpm + mrGearboxMogli.hydroEffDiff )
				if self.vehicle.mrGbMS.AutoShiftUpRpm ~= nil and closeRpm > self.vehicle.mrGbMS.AutoShiftUpRpm then
					closeRpm = self.vehicle.mrGbMS.AutoShiftUpRpm 
				end
				if self.vehicle.mrGbMS.HydrostaticMaxRpm ~= nil and closeRpm > self.vehicle.mrGbMS.HydrostaticMaxRpm then
					closeRpm = self.vehicle.mrGbMS.HydrostaticMaxRpm
				end				
			end
			
			if      self.vehicle.mrGbMS.TorqueConverter 
					and self.vehicle.mrGbMS.TorqueConverterLockupMs ~= nil 
					and ( getMaxPower or self.ptoOn ) then
				openRpm = math.max( openRpm, closeRpm )
			end
			
			local fromClutchPercent   = self.vehicle.mrGbMS.MinClutchPercent
			local toClutchPercent     = self.vehicle.mrGbMS.MaxClutchPercent

			if      clutchMode > 1 
					and self.vehicle.mrGbML.afterShiftClutch ~= nil then
				if self.vehicle.mrGbML.afterShiftClutch < 0 then
					self.autoClutchPercent = self:getClutchPercent( targetRpm, openRpm, closeRpm, fromClutchPercent, toClutchPercent )
				else
					self.autoClutchPercent = self.vehicle.mrGbML.afterShiftClutch
				end
			elseif  self.vehicle.mrGbMS.TorqueConverter
			    and self.torqueConverterLockupMs ~= nil
			    and self.torqueConverterLockupMs < g_currentMission.time
					and self.wheelRpm                > openRpm then
				self.autoClutchPercent = 1
			else
				-- timer for torque converter lockup clutch
				if      self.vehicle.mrGbMS.TorqueConverter
						and self.vehicle.mrGbMS.TorqueConverterLockupMs ~= nil 
						and ( self.wheelRpm < self.vehicle.mrGbMS.CloseRpm
							 or self.torqueConverterLockupMs == nil ) then
					self.torqueConverterLockupMs = g_currentMission.time + self.vehicle.mrGbMS.TorqueConverterLockupMs
				end

				self.autoClutchPercent = Utils.clamp( self.autoClutchPercent, 0, self.vehicle.mrGbMS.MaxClutchPercent )
				
				if clutchMode <= 1 then
					if self.nonClampedMotorRpm > self.stallRpm and self.tickDt < self.vehicle.mrGbMS.ClutchTimeDec then
						fromClutchPercent = math.max( fromClutchPercent, self.autoClutchPercent - self.tickDt/self.vehicle.mrGbMS.ClutchTimeDec )
					end
					local timeInc = self.vehicle.mrGbMS.ClutchShiftTime
					if self.wheelRpm < closeRpm then
						timeInc = self.vehicle.mrGbMS.ClutchTimeInc
					end
					if self.tickDt < timeInc then
						toClutchPercent = math.min( toClutchPercent, self.autoClutchPercent + self.tickDt/timeInc )
					end
				end
				
				local c = self:getClutchPercent( targetRpm, openRpm, closeRpm, fromClutchPercent, toClutchPercent )
				
				if self.vehicle.mrGbML.debugTimer ~= nil and g_currentMission.time < self.vehicle.mrGbML.debugTimer then
					print(string.format("Clutch mode %d: %3.0f%% => %3.0f%% o: %4.0f U/min c: %4.0f U/min / %3.0f%% .. %3.0f%%",
					                    clutchMode,
															self.autoClutchPercent*100,
															c*100,
															openRpm,
															closeRpm,
															fromClutchPercent*100,
															toClutchPercent*100 ))
				end
				
				self.autoClutchPercent = c
			end
			
		else
			self.autoClutchPercent   = self.vehicle.mrGbMS.MaxClutchPercent
		end 		
	else
		self.torqueConverterLockupMs = nil
	end 					
	
	local lastStallWarningTimer = self.stallWarningTimer
	self.stallWarningTimer = nil
	
	if     self.noTransmission then
		self.clutchPercent = 0
	elseif self.vehicle:mrGbMGetAutoClutch() or self.vehicle.mrGbMS.TorqueConverterOrHydro then
		self.clutchPercent = math.min( self.autoClutchPercent, self.vehicle.mrGbMS.ManualClutch )
		
		if not ( self.noTransmission ) and self.vehicle.mrGbML.debugTimer ~= nil and g_currentMission.time < self.vehicle.mrGbML.debugTimer and self.autoClutchPercent < self.vehicle.mrGbMS.MaxClutchPercent then
			self.vehicle.mrGbML.debugTimer = math.max( g_currentMission.time + 200, self.vehicle.mrGbML.debugTimer )
		end
	else
	--local stallRpm = math.min( 100, 0.5 * self.stallRpm ) --math.max( 0.5 * self.stallRpm, self.stallRpm - 100 )
		local stallRpm = math.max( 0.5 * self.stallRpm, self.stallRpm - 100 )
		if not ( self.noTransmission ) and self.vehicle.mrGbMS.ManualClutch > self.vehicle.mrGbMS.MinClutchPercent and self.nonClampedMotorRpm < stallRpm then
			if lastStallWarningTimer == nil then
				self.stallWarningTimer = g_currentMission.time
			else
				self.stallWarningTimer = lastStallWarningTimer
				if     g_currentMission.time > self.stallWarningTimer + self.vehicle.mrGbMG.stallMotorOffTime then
					self.stallWarningTimer = nil
					self:motorStall( string.format("Motor stopped because RPM too low: %4.0f < %4.0f", self.nonClampedMotorRpm, stallRpm ),
													 string.format("RPM is too low: %4.0f < %4.0f", self.nonClampedMotorRpm, stallRpm ) )
				elseif g_currentMission.time > self.stallWarningTimer + self.vehicle.mrGbMG.stallWarningTime then
					self.vehicle:mrGbMSetState( "WarningText", string.format("RPM is too low: %4.0f < %4.0f", self.nonClampedMotorRpm, stallRpm ))
				end		
			end		
		end
		
		self.clutchPercent = self.vehicle.mrGbMS.ManualClutch
	end
	
	
	--**********************************************************************************************************		
	-- no transmission => min throttle 
	if self.noTorque       then
		self.lastThrottle   = 0
		accelerationPedal   = 0
	end
	if self.clutchPercent < mrGearboxMogli.minClutchPercent then
		self.noTransmission = true
	end
	if self.noTransmission then
		self.minThrottle    = 0
		if self.lastRealMotorRpm < self.minRequiredRpm + 10 then
			self.minThrottle  = self.vehicle.mrGbMS.IdleEnrichment
		end		
		self.minThrottleS   = Utils.clamp( self.minThrottleS + 0.1 * ( self.minThrottle - self.minThrottleS ), 0, 1 )
		if self.noTorque then
			self.lastThrottle = 0
		elseif self.vehicle:mrGbMGetOnlyHandThrottle() then
			self.lastThrottle = self.vehicle.mrGbMS.HandThrottle
		else
			self.lastThrottle = math.max( self.vehicle.mrGbMS.HandThrottle, accelerationPedal )
		end
		if self.lastThrottle > 0 then			
			self.currentRpmS  = Utils.clamp( self.currentRpmS + 5 * self.lastThrottle * self.tickDt * self.vehicle.mrGbMS.RpmIncFactor, 
																			 self.minRequiredRpm, 
																			 self:getThrottleMaxRpm( ) )
		else
			self.currentRpmS  = Utils.clamp( self.currentRpmS - self.tickDt * self.vehicle.mrGbMS.RpmDecFactor, self.minRequiredRpm, self.maxAllowedRpm )
		end	
		self.lastThrottle   = math.max( self.minThrottle, self.lastThrottle )	
	else
		self.currentRpmS    = self.lastRealMotorRpm
	end	
	
	--**********************************************************************************************************		
	-- timer for automatic shifting				
	if      self.noTransmission then
		self.lastClutchClosedTime = g_currentMission.time + self.vehicle.mrGbMS.AutoShiftTimeoutShort
		self.hydrostaticStartTime = nil
		self.deltaRpm = 0
	elseif  self.lastClutchClosedTime            > g_currentMission.time 
			and self.clutchPercent                  >= self.vehicle.mrGbMS.MaxClutchPercent - mrGearboxMogli.eps then
		-- cluch closed => "start" the timer
		self.lastClutchClosedTime = g_currentMission.time 
	elseif  accelerationPedal                    < mrGearboxMogli.accDeadZone
			and self.vehicle.mrGbML.currentGearSpeed < self.vehicle.mrGbMS.LaunchGearSpeed - mrGearboxMogli.eps 
			and self.clutchPercent                  >= self.vehicle.mrGbMS.MaxClutchPercent - mrGearboxMogli.eps
			and self.lastClutchClosedTime            < g_currentMission.time 
			and self.vehicle.steeringEnabled
			then
		-- no down shift for small gears w/o throttle
		self.lastClutchClosedTime = g_currentMission.time 
	end
	
	
	--**********************************************************************************************************		
	-- overheating of clutch				
	if self.vehicle.mrGbMS.ClutchCanOverheat and self.vehicle.steeringEnabled then
		if 0.1 < self.clutchPercent and self.clutchPercent < 0.9 then
			if self.clutchOverheatTimer == nil then
				self.clutchOverheatTimer = 0
			else
				self.clutchOverheatTimer = self.clutchOverheatTimer + self.tickDt * self.motorLoadP
			end

			if self.vehicle.mrGbMS.ClutchOverheatMaxTime > 0 then
				self.clutchOverheatTimer = math.min( self.clutchOverheatTimer, self.vehicle.mrGbMS.ClutchOverheatMaxTime )
			end
			
			if      self.clutchOverheatTimer > self.vehicle.mrGbMS.ClutchOverheatStartTime
					and self.vehicle.mrGbMS.ClutchOverheatIncTime > 0 then
				local w = "Clutch is overheating"
				if      self.vehicle.mrGbMS.WarningText ~= nil
						and self.vehicle.mrGbMS.WarningText ~= "" 
						and self.vehicle.mrGbMS.WarningText ~= w 
						and string.len( self.vehicle.mrGbMS.WarningText ) < 200 then
					w = self.vehicle.mrGbMS.WarningText .. " / " .. w
				end
					
				self.vehicle:mrGbMSetState( "WarningText", w )
				local e = 1 + ( self.clutchOverheatTimer - self.vehicle.mrGbMS.ClutchOverheatStartTime ) / self.vehicle.mrGbMS.ClutchOverheatIncTime
				self.clutchPercent = self.clutchPercent ^ e
			end
		elseif self.clutchOverheatTimer ~= nil then
			self.clutchOverheatTimer = self.clutchOverheatTimer - self.tickDt
			
			if self.clutchOverheatTimer < 0 then
				self.clutchOverheatTimer = nil
			end
		end
	end

	--**********************************************************************************************************		
	-- calculate max RPM increase based on current RPM
  local r = self.vehicle.mrGbMS.RpmIncFactor + self.motorLoadP * self.motorLoadP * ( self.vehicle.mrGbMS.RpmIncFactorFull - self.vehicle.mrGbMS.RpmIncFactor )
  self.rpmIncFactor   = self.rpmIncFactor + self.vehicle.mrGbML.smoothMedium * ( r - self.rpmIncFactor )
	self.maxRpmIncrease = self.tickDt * self.rpmIncFactor
		
	if self.noTransmission then
		self.maxPossibleRpm = mrGearboxMogli.huge
		self.lastMaxRpmTab  = nil
		self.rpmIncFactor   = self.vehicle.mrGbMS.RpmIncFactor
	elseif self.lastMissingTorque > 0 then
		self.maxPossibleRpm = self.maxAllowedRpm
		self.lastMaxRpmTab  = nil
		self.rpmIncFactor   = self.vehicle.mrGbMS.RpmIncFactorFull
	end
	
	if not self.noTransmission then
		local tab = nil
		if self.lastMaxRpmTab == nil then
		--tab = nil
		elseif lastNoTransmission then
		--tab = nil
		else
			tab = self.lastMaxRpmTab
		end
		
		local m 
		if type( self.lastRealMotorRpm ) == "number" then
			m = self.lastRealMotorRpm
		else
			print( 'ERROR in mrGearboxMogli.lua(7838): type( self.lastRealMotorRpm ) ~= "number"' )
			m = self.nonClampedMotorRpm
		end
		
		self.lastMaxRpmTab = {}
		table.insert( self.lastMaxRpmTab, { t = 0, m = m } )
				
		if tab ~= nil then
			local mm = m
			local cm = 1
			
			for _,tm in pairs( tab ) do
				local t = tm.t + self.tickDt 
				if t < mrGearboxMogli.deltaLimitTimeMs then
					table.insert( self.lastMaxRpmTab, { t = t, m = tm.m } )
					mm = mm + tm.m + t * self.rpmIncFactor
					cm = cm + 1
				end
			end
			
			if cm > 1 then
				m = math.max( m, mm / cm )
			end
		end
		
		self.maxPossibleRpm = m + self.maxRpmIncrease
		if self.maxPossibleRpm < self.wheelRpm then
			self.maxPossibleRpm = self.wheelRpm
		end
		if self.maxPossibleRpm < minRpmReduced then
			self.maxPossibleRpm = minRpmReduced
		end
		if self.maxPossibleRpm > self.maxAllowedRpm then
			self.maxPossibleRpm = self.maxAllowedRpm
		end
		if      handThrottle           >= 0 
				and self.hydrostaticFactor ~= nil
				and self.maxPossibleRpm    >  self.minRequiredRpm + mrGearboxMogli.ptoRpmThrottleDiff then
			self.maxPossibleRpm = self.minRequiredRpm + mrGearboxMogli.ptoRpmThrottleDiff
		end
		
		if self.vehicle.mrGbML.afterShiftRpm ~= nil and self.vehicle.mrGbML.gearShiftingEffect then
			if self.maxPossibleRpm > self.vehicle.mrGbML.afterShiftRpm then
				self.maxPossibleRpm               = self.vehicle.mrGbML.afterShiftRpm
				self.vehicle.mrGbML.afterShiftRpm = self.vehicle.mrGbML.afterShiftRpm + self.maxRpmIncrease 
			else
				self.vehicle.mrGbML.afterShiftRpm = nil
			end
		end
	end

	--**********************************************************************************************************		
	-- reduce RPM if more power than available is requested 
	local reductionMinRpm = self.stallRpm 
	if     currentAbsSpeed < 1 then
		reductionMinRpm = self.maxAllowedRpm 
	elseif currentAbsSpeed < 2 then
		reductionMinRpm = self.maxAllowedRpm + ( currentAbsSpeed - 1 ) * ( self.stallRpm - self.maxAllowedRpm )
	end
	
	if      self.lastMissingTorque  > 0 
			and self.nonClampedMotorRpm > reductionMinRpm
			and not ( self.noTransmission ) then
		if self.torqueRpmReduction == nil then
			self.torqueRpmReference = self.nonClampedMotorRpm
			self.torqueRpmReduction = 0
		end
		local m = self.stallRpm
		self.torqueRpmReduction   = math.min( self.nonClampedMotorRpm - reductionMinRpm, self.torqueRpmReduction + math.min( 0.2, self.lastMissingTorque / self.lastMotorTorque ) * self.tickDt * self.vehicle.mrGbMS.RpmDecFactor )
	elseif  self.torqueRpmReduction ~= nil then
		self.torqueRpmReduction = self.torqueRpmReduction - self.tickDt * self.rpmIncFactor 
		if self.torqueRpmReduction < 0 then
			self.torqueRpmReference = nil
			self.torqueRpmReduction = nil
		end
	end
	if self.torqueRpmReduction ~= nil then
		self.maxPossibleRpm = Utils.clamp( self.torqueRpmReference - self.torqueRpmReduction, self.stallRpm, self.maxPossibleRpm )
	end
	
	self.lastThrottle = math.max( self.minThrottle, accelerationPedal )
	
--**********************************************************************************************************	
-- VehicleMotor.updateGear II
	self.gear, self.gearRatio = self.getBestGear(self, acceleration, self.wheelSpeedRpm, self.maxAllowedRpm*0.1, requiredWheelTorque, self.minRequiredRpm )
--**********************************************************************************************************	
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor:getMotorRpm
--**********************************************************************************************************	
function mrGearboxMogliMotor:getMotorRpm( noLimit )
	if self.noTransmission then
		return self:getThrottleRpm()
	end
	local minRpm = self.lastRealMotorRpm - self.tickDt * self.vehicle.mrGbMS.RpmDecFactor
	local maxRpm = self.maxPossibleRpm
	if true then -- noLimit then
		minRpm = 0
		maxRpm = mrGearboxMogli.huge
	elseif g_currentMission.time <= self.vehicle.mrGbML.gearShiftingTime and self.vehicle.mrGbML.gearShiftingEffect then
		minRpm = 0
	end
	return Utils.clamp( self.clutchPercent * self.wheelRpm + ( 1-self.clutchPercent ) * self:getThrottleRpm(),
											minRpm,
											maxRpm )
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor:getThrottleRpm
--**********************************************************************************************************	
function mrGearboxMogliMotor:getThrottleRpm( )
	if     self.noTorque       then
		return self.currentRpmS
	elseif self.noTransmission then
		return self.currentRpmS
	end
	
	return self.idleRpm + self.lastThrottle * ( self.maxAllowedRpm - self.idleRpm )
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor:getThrottleRpm
--**********************************************************************************************************	
function mrGearboxMogliMotor:getThrottleMaxRpm( acc )
	if acc == nil then acc = self.lastThrottle end
	return math.max( self.minRequiredRpm, self.idleRpm + acc * math.max( 0, self.ratedRpm - self.idleRpm ) )
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor:getLimitedRpm
--**********************************************************************************************************	
function mrGearboxMogliMotor:getLimitedRpm( rpm )
	if self.ptoOn then
		return self.minRequiredRpm
	end

	local minRpm = math.max( self.stallRpm,      self.lastRealMotorRpm - self.tickDt * self.vehicle.mrGbMS.RpmDecFactor )
	local maxRpm = math.min( self.maxAllowedRpm, self.lastRealMotorRpm + self.tickDt * self.rpmIncFactor )

	if     rpm < minRpm then
		return minRpm
	elseif rpm > maxRpm then
		return maxRpm
	end
	
	return rpm
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor:getClutchPercent
--**********************************************************************************************************	
function mrGearboxMogliMotor:getClutchPercent( targetRpm, openRpm, closeRpm, fromPercent, toPercent )

	if fromPercent ~= nil and toPercent ~= nil and fromPercent >= toPercent then
		return fromPercent
	end
	if closeRpm <= self.wheelRpm and self.wheelRpm <= self.maxAllowedRpm then
		return Utils.getNoNil( toPercent, self.vehicle.mrGbMS.MaxClutchPercent )
	end
	if self.lastRealMotorRpm < self.stallRpm and self.stallRpm < openRpm then
		return Utils.getNoNil( fromPercent, self.vehicle.mrGbMS.MinClutchPercent )
	end	
	
	local minPercent    = self.vehicle.mrGbMS.MinClutchPercent + Utils.clamp( 0.5 + 0.02 * ( self.lastRealMotorRpm - openRpm ), 0, 1 ) * math.max( 0, self.autoClutchPercent - self.vehicle.mrGbMS.MinClutchPercent )
	local maxPercent    = self.vehicle.mrGbMS.MaxClutchPercent		
	
	if fromPercent ~= nil and minPercent < fromPercent then
		minPercent        = fromPercent
	end
	if toPercent   ~= nil and maxPercent > toPercent   then
		maxPercent        = toPercent 
	end
	
	local target        = math.min( targetRpm, self.vehicle.mrGbMS.ClutchMaxTargetRpm )
	local throttle      = self:getThrottleRpm()
	
	local eps           = maxPercent - minPercent
	local delta         = ( throttle - math.max( self.wheelRpm, 0 ) ) * eps
	
	local times         = math.max( mrGearboxMogli.clutchLoopTimes, math.ceil( delta / mrGearboxMogli.clutchLoopDelta ) )
	delta = delta / times 
	eps   = eps   / times 
	
	local clutchRpm     = maxPercent * math.max( self.wheelRpm, 0 ) + ( 1 - maxPercent ) * throttle
	local clutchPercent = maxPercent
	local diff, diffi, rpm
	
	for i=0,times do
		clutchRpm = clutchRpm + delta
		diffi     = math.abs( target - clutchRpm )
		if diff == nil or diff > diffi then
			diff = diffi
			clutchPercent = maxPercent - i * eps
		end
	end
	
--if self.vehicle.mrGbMG.debugPrint 
--		and self.autoClutchPercent < self.vehicle.mrGbMS.MaxClutchPercent
--		and fromPercent ~= nil
--		and toPercent   ~= nil then
--	print(string.format("Clutch: cur: %4.0f tar: %4.0f opn: %4.0f cls: %4.0f rg: %1.3f .. %1.3f => tar: %4.0f thr: %4.0f whl: %4.0f => clu %4.0f diffi %4.0f => %1.3f (%4.4f %4.4f)",
--											self.lastRealMotorRpm, targetRpm, openRpm, closeRpm,
--											fromPercent, toPercent,
--											target, throttle, self.wheelRpm,
--											clutchRpm, diff, clutchPercent, eps, delta ) )
--end 
	
	return clutchPercent 
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor:getRpmScore
--**********************************************************************************************************	
function mrGearboxMogliMotor:getRpmScore( rpm, downRpm, upRpm ) 

	if downRpm <= rpm and rpm <= upRpm then
		return 0
	elseif rpm <= self.stallRpm
	    or rpm >= self.maxAllowedRpm then
		return 1
	elseif rpm < downRpm then
		return ( downRpm - rpm ) / ( downRpm - self.stallRpm )
	elseif rpm > upRpm then
		return ( rpm - upRpm ) / ( self.maxAllowedRpm - upRpm ) 
	end
	-- error
	print("warning: invalid parameters in mrGearboxMogliMotor:getRpmScore( "..tostring(rpm)..", "..tostring(downRpm)..", "..tostring(upRpm).." )")
	return 1
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor:splitGear
--**********************************************************************************************************	
function mrGearboxMogliMotor:splitGear( i ) 
	local i2g, i2r = 1, 1
	if     not self.vehicle:mrGbMGetAutoShiftRange() then
		i2g = i
		i2r = self.vehicle.mrGbMS.CurrentRange
	elseif not self.vehicle:mrGbMGetAutoShiftGears() then 
		i2g = self.vehicle.mrGbMS.CurrentGear
		i2r = i
	elseif self.vehicle.mrGbMS.GearTimeToShiftGear > self.vehicle.mrGbMS.GearTimeToShiftHl + 10 then
		-- shifting gears is more expensive => avoid paradox up/down shifts
		i2g = 1
		i2r = i
		local m = table.getn( self.vehicle.mrGbMS.Ranges )
		while i2r > m do
			i2g = i2g + 1
			i2r = i2r - m
		end		
	else
		i2r = 1
		i2g = i
		local m = table.getn( self.vehicle.mrGbMS.Gears )
		while i2g > m do
			i2r = i2r + 1
			i2g = i2g - m
		end
	end
	if i ~= self:combineGear( i2g, i2r ) then
		print("ERROR in GEARBOX: "..tostring(i).." ~= combine( "..tostring(i2r)..", "..tostring(i2g).." )")
	end
	return i2g,i2r
end

--**********************************************************************************************************	
-- mrGearboxMogliMotor:combineGear
--**********************************************************************************************************	
function mrGearboxMogliMotor:combineGear( I2g, I2r ) 
	local i2g = Utils.getNoNil( I2g, self.vehicle.mrGbMS.CurrentGear )
	local i2r = Utils.getNoNil( I2r, self.vehicle.mrGbMS.CurrentRange )
	
	if     not self.vehicle:mrGbMGetAutoShiftRange() then
		return i2g
	elseif not self.vehicle:mrGbMGetAutoShiftGears() then 
		return i2r
	elseif self.vehicle.mrGbMS.GearTimeToShiftGear > self.vehicle.mrGbMS.GearTimeToShiftHl + 10 then
		-- shifting gears is more expensive => avoid paradox up/down shifts
		local m = table.getn( self.vehicle.mrGbMS.Ranges )
		return i2r + m * ( i2g-1 )
	else
		local m = table.getn( self.vehicle.mrGbMS.Gears )
		return i2g + m * ( i2r-1 )
	end
	return 1
end

function mrGearboxMogliMotor:getMotorLoad()
	return self.maxMotorTorque * ( 1 - ( 1 - self.motorLoadP )^mrGearboxMogli.motorLoadExp )
end

function mrGearboxMogliMotor:getMinRpm()
	return self.vehicle.mrGbMS.OrigMinRpm
end

function mrGearboxMogliMotor:getMaxRpm()
	return self.vehicle.mrGbMS.OrigMaxRpm
end

function mrGearboxMogliMotor:getMaximumForwardSpeed()
	return mrGearboxMogli.huge
end

function mrGearboxMogliMotor:getMaximumBackwardSpeed()
	return mrGearboxMogli.huge
end

function mrGearboxMogliMotor:getRotInertia()
	return 0.001 * self.vehicle.mrGbMS.MomentOfInertia 
end

function mrGearboxMogliMotor:getDampingRate()
	return 0.0007 * self.vehicle.mrGbMS.MomentOfInertia 
end

--**********************************************************************************************************	
-- mrGearboxMogli:afterLoadMotor
--**********************************************************************************************************	
function mrGearboxMogli:afterLoadMotor(xmlFile)
	if self.mrGbML ~= nil then 
		self.mrGbML.motor = nil
	end
end

--**********************************************************************************************************	
-- mrGearboxMogli:newGetLastSpeed
--**********************************************************************************************************	
function mrGearboxMogli:newGetLastSpeed( superFunc, ... )
	if  	 self.mrGbMS == nil 
			or self.mrGbML == nil 
			or self.mrGbML.smoothFast == nil
			or not ( self.mrGbMS.IsOn ) then	
		return superFunc( self, ... )
	end
	
	local speed = superFunc( self, ... )
	if self.mrGbML.lastSpeed == nil then
		self.mrGbML.lastSpeed = speed
	elseif self.isServer then
		self.mrGbML.lastSpeed = self.mrGbML.lastSpeed + self.mrGbML.smoothFast * ( speed - self.mrGbML.lastSpeed )
	else
		self.mrGbML.lastSpeed = self.mrGbML.lastSpeed + self.mrGbML.smoothSlow * ( speed - self.mrGbML.lastSpeed )
	end
	
	return self.mrGbML.lastSpeed
end	

--**********************************************************************************************************	
-- mrGearboxMogli:newSetHudValue
--**********************************************************************************************************	
function mrGearboxMogli:newSetHudValue( superFunc, hud, value, maxValue, ... )
	if     self.mrGbMS        == nil 
			or self.mrGbMB        == nil 
			or not ( self.isMotorStarted )
			or not ( self.mrGbMS.IsOn ) 
			or self.mrGbMB.motor  == nil then
		return superFunc( self, hud, value, maxValue, ... )
	elseif self.motor.updateMotorRpm == nil or self.motor.updateMotorRpm ~= mrGearboxMogliMotor.updateMotorRpm then
		return superFunc( self, hud, value, maxValue, ... )
	elseif  self.rpmHud   ~= nil
			and self.rpmHud   == hud then
	elseif  self.speedHud ~= nil
			and self.speedHud == hud then
	else
		return superFunc( self, hud, value, maxValue, ... )
	end

	if value < 0 then
		value = 0
	end
	
	for _,hudItem in pairs(hud) do
		if hudItem.numbers ~= nil then
			if hudItem.lastValue == nil or math.abs(hudItem.lastValue-value) > 1/(10^(hudItem.precision+1)) then
				local displayedValue
				
				if self.rpmHud   == hud then
					displayedValue = self:mrGbMGetCurrentRPM()
				else
					displayedValue = value
				end
				
				if hudItem.maxValue ~= nil then
					displayedValue = math.min( displayedValue, hudItem.maxValue )
				end
				
				local speed = tonumber(string.format("%."..hudItem.precision.."f", displayedValue));
				Utils.setNumberShaderByValue(hudItem.numbers, speed, hudItem.precision, true);
				hudItem.lastValue = value;
			end;
		end;
		
		if hudItem.animName ~= nil then
			local displayedValue = value
			local normValue = 0

			if self.speedHud == hud then
				maxValue = self.motor.maxForwardSpeed 
			end
			
			local minValueAnim = Utils.getNoNil( hudItem.minValueAnim, 0 )
			local maxValueAnim = Utils.getNoNil( hudItem.maxValueAnim, maxValue )
			
			if self.rpmHud == hud or ( self.speedHud == hud and self.mrGbMS.RpmInSpeedHud ) then
				displayedValue = self:mrGbMGetCurrentRPM()
				
				if self.speedHud == hud then
					minValueAnim = mrGearboxMogli.minRpmInSpeedHudDelta
					maxValueAnim = mrGearboxMogli.maxRpmInSpeedHudDelta
				end
			
				if self.mrGbMS.MinHudRpm ~= nil then
					minValueAnim = self.mrGbMS.MinHudRpm
				end
				if self.mrGbMS.MaxHudRpm ~= nil then
					maxValueAnim = self.mrGbMS.MaxHudRpm
				end
			end
			
			if maxValueAnim  <= minValueAnim or displayedValue <= minValueAnim then
				normValue = 0
			elseif displayedValue >= maxValueAnim then
				normValue = 1
			else
				normValue = Utils.round((displayedValue-minValueAnim)/(maxValueAnim-minValueAnim), 3)
			end		
			
			if hudItem.lastNormValue == nil or math.abs(hudItem.lastNormValue - normValue) > 0.01 then
				self:setAnimationTime(hudItem.animName, normValue, true);
				hudItem.lastNormValue = normValue;
			end;
		end
	end
end
	
--**********************************************************************************************************			
	-- fuel usage
--**********************************************************************************************************			
function mrGearboxMogli:newUpdateFuelUsage(origFunc, superFunc, dt)
	if  	 self.mrGbMS          == nil 
			or self.motor           == nil
			or self.motor.fuelCurve == nil
			or not ( self.mrGbMS.IsOn )
			or not ( self.mrGbMG.realFuelUsage ) then	
		return origFunc( self, superFunc, dt )
	end
	if superFunc ~= nil then
		if not superFunc(self, dt) then
			return false
		end
	end
	
	if self.isMotorStarted then		
		local rpm   = math.max( self.motor.prevNonClampedMotorRpm, self.motor.stallRpm )
		local power = ( self.motor.motorLoad + self.motor.lastPtoTorque + self.motor.lastLostTorque ) * rpm * mrGearboxMogli.powerFactor0 / ( 1.36 * self.mrGbMG.torqueFactor )
		local ratio = self.motor.fuelCurve:get( rpm )			
		
		if self.motor.lastMotorTorque > 0 then
			ratio = ratio / math.max( 0.001, mrGearboxMogli.powerFuelCurve:get( ( self.motor.motorLoad + self.motor.lastPtoTorque + self.motor.lastLostTorque ) / self.motor.lastMotorTorque ) )
		else
			ratio = 0
		end
		
		local fuelUsed  = ratio * power * dt * mrGearboxMogli.fuelFactor		
		if fuelUsed > 0 then
			if g_currentMission.missionInfo.fuelUsageLow then
				fuelUsed = fuelUsed * 0.7
			end
			
		--if self.mrGbML.checkFuelFillLevel ~= nil and self.fuelFillLevel ~= nil then
		--	print("Fuel used: "..tostring(fuelUsed).." ("..tostring(self.mrGbML.checkFuelFillLevel - self.fuelFillLevel)..")")
		--end
			
			if not self:getIsHired() or not g_currentMission.missionInfo.helperBuyFuel then
				self:setFuelFillLevel(self.fuelFillLevel-fuelUsed);
				g_currentMission.missionStats:updateStats("fuelUsage", fuelUsed);
			elseif self:getIsHired() and g_currentMission.missionInfo.helperBuyFuel then
				local delta = fuelUsed * g_currentMission.economyManager:getPricePerLiter(FillUtil.FILLTYPE_FUEL)
				g_currentMission.missionStats:updateStats("expenses", delta);
				g_currentMission:addSharedMoney(-delta, "purchaseFuel");
			end
			
			self.mrGbML.checkFuelFillLevel = self.fuelFillLevel
		end
		
		if self.fuelUsageHud ~= nil then
			VehicleHudUtils.setHudValue(self, self.fuelUsageHud, fuelUsed*1000/dt*60*60);
		end
	end
	
	return true
end
	
	
--**********************************************************************************************************	
WheelsUtil.updateWheelsPhysics = Utils.overwrittenFunction( WheelsUtil.updateWheelsPhysics,mrGearboxMogli.newUpdateWheelsPhysics )
--Vehicle.getLastSpeed = Utils.overwrittenFunction( Vehicle.getLastSpeed, mrGearboxMogli.newGetLastSpeed )
VehicleHudUtils.setHudValue = Utils.overwrittenFunction( VehicleHudUtils.setHudValue, mrGearboxMogli.newSetHudValue )
Motorized.loadMotor = Utils.appendedFunction( Motorized.loadMotor, mrGearboxMogli.afterLoadMotor )
Motorized.updateFuelUsage = Utils.overwrittenFunction( Motorized.updateFuelUsage, mrGearboxMogli.newUpdateFuelUsage )
--**********************************************************************************************************	

--oldClamp = Utils.clamp
--function Utils.clamp(value, minVal, maxVal)
--	if value == nil or minVal == nil or maxVal == nil then
--		mrGearboxMogli.debugEvent( nil, value, minVal, maxVal )
--		return 0
--	end
--	return oldClamp(value, minVal, maxVal)
--end


function mrGearboxMogli:mrGbMTestNet()
	local vehicle = self
	if g_currentMission ~= nil and g_currentMission.controlledVehicle ~= nil then
		vehicle = g_currentMission.controlledVehicle
	end
	
	mrGearboxMogli.mogliBaseTestStream( vehicle )
end

function mrGearboxMogli:mrGbMTestAPI()
	local vehicle = self
	if g_currentMission ~= nil and g_currentMission.controlledVehicle ~= nil then
		vehicle = g_currentMission.controlledVehicle
	end
	
	print("vehicle.mrGbMGetClutchPercent        : "..tostring(vehicle:mrGbMGetClutchPercent())) 
	print("vehicle.mrGbMGetAutoClutchPercent    : "..tostring(vehicle:mrGbMGetAutoClutchPercent())) 
	print("vehicle.mrGbMGetCurrentRPM           : "..tostring(vehicle:mrGbMGetCurrentRPM())) 
	print("vehicle.mrGbMGetTargetRPM            : "..tostring(vehicle:mrGbMGetTargetRPM())) 
	print("vehicle.mrGbMGetMotorLoad            : "..tostring(vehicle:mrGbMGetMotorLoad())) 
	print("vehicle.mrGbMGetUsedPower            : "..tostring(vehicle:mrGbMGetUsedPower())) 
	print("vehicle.mrGbMGetModeText             : "..tostring(vehicle:mrGbMGetModeText())) 
	print("vehicle.mrGbMGetModeShortText        : "..tostring(vehicle:mrGbMGetModeShortText())) 
	print("vehicle.mrGbMGetGearText             : "..tostring(vehicle:mrGbMGetGearText())) 
	print("vehicle.mrGbMGetIsOn                 : "..tostring(vehicle:mrGbMGetIsOn())) 
                                              
	print("vehicle.mrGbMGetIsOnOff              : "..tostring(vehicle:mrGbMGetIsOnOff())) 
	print("vehicle.mrGbMGetCurrentGear          : "..tostring(vehicle:mrGbMGetCurrentGear())) 
	print("vehicle.mrGbMGetGearSpeed            : "..tostring(vehicle:mrGbMGetGearSpeed())) 
	print("vehicle.mrGbMGetGearNumber           : "..tostring(vehicle:mrGbMGetGearNumber())) 
	print("vehicle.mrGbMGetCurrentRange         : "..tostring(vehicle:mrGbMGetCurrentRange())) 
	print("vehicle.mrGbMGetRangeNumber          : "..tostring(vehicle:mrGbMGetRangeNumber())) 
	print("vehicle.mrGbMGetCurrentRange2        : "..tostring(vehicle:mrGbMGetCurrentRange2())) 
	print("vehicle.mrGbMGetRange2Number         : "..tostring(vehicle:mrGbMGetRange2Number())) 
	print("vehicle.mrGbMGetAutomatic            : "..tostring(vehicle:mrGbMGetAutomatic())) 
	print("vehicle.mrGbMGetAutoStartStop        : "..tostring(vehicle:mrGbMGetAutoStartStop())) 
	print("vehicle.mrGbMGetNeutralActive        : "..tostring(vehicle:mrGbMGetNeutralActive())) 
	print("vehicle.mrGbMGetReverseActive        : "..tostring(vehicle:mrGbMGetReverseActive())) 
	print("vehicle.mrGbMGetSpeedLimiter         : "..tostring(vehicle:mrGbMGetSpeedLimiter())) 
	print("vehicle.mrGbMGetHandThrottle         : "..tostring(vehicle:mrGbMGetHandThrottle())) 
	print("vehicle.mrGbMGetAutoClutch           : "..tostring(vehicle:mrGbMGetAutoClutch())) 
	print("vehicle.mrGbMGetManualClutch         : "..tostring(vehicle:mrGbMGetManualClutch())) 	
	print("vehicle.mrGbMGetAccelerateToLimit    : "..tostring(vehicle:mrGbMGetAccelerateToLimit())) 	
	print("vehicle.mrGbMGetDecelerateToLimit    : "..tostring(vehicle:mrGbMGetDecelerateToLimit())) 	
	print("vehicle.mrGbMGetHasAllAuto           : "..tostring(vehicle:mrGbMGetHasAllAuto())) 	
	print("vehicle.mrGbMGetAutoHold             : "..tostring(vehicle:mrGbMGetAutoHold())) 	
	print("vehicle.mrGbMGetOnlyHandThrottle     : "..tostring(vehicle:mrGbMGetOnlyHandThrottle())) 	
	print("vehicle.mrGbMGetHydrostaticFactor    : "..tostring(vehicle:mrGbMGetHydrostaticFactor())) 	
	
	print("vehicle.tempomatMogliGetSpeedLimit   : "..tostring(vehicle:tempomatMogliGetSpeedLimit())) 	
	print("vehicle.tempomatMogliGetSpeedLimit2  : "..tostring(vehicle:tempomatMogliGetSpeedLimit2())) 	
end

function mrGearboxMogli:mrGbMDebug()
	mrGearboxMogli.debugGearShift = not mrGearboxMogli.debugGearShift
	print("debugGearShift: "..tostring(mrGearboxMogli.debugGearShift))
end
end