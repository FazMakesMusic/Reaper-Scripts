-- Script: DA Tempo-Time | Import Tempo Cues From Item
-- Author: DA / fazmakesmusic
-- Description:

--[[

TO DO


]]

------------------------------
----------VARIABLES-----------
------------------------------




------------------------------
-----------GET INFO-----------
------------------------------


------------------------------
-----------TABLES-------------
------------------------------

tCues = {}

------------------------------
----------FUNCTIONS-----------
------------------------------


------------------------------
-------------MAIN-------------
------------------------------

reaper.Undo_BeginBlock("script")

-----

item = reaper.GetSelectedMediaItem(0,0)
take = reaper.GetActiveTake(item)
pcmSource = reaper.GetMediaItemTake_Source(take)

cueIDX = 0


repeat 

  cueRetval, time, endTime, isRegion, name = reaper.CF_EnumMediaSourceCues(pcmSource,cueIDX)
  
  if string.match(name,"Tempo:") then
  
    name = string.gsub(name,"Tempo: ","")
    --reaper.ShowConsoleMsg("Time: " .. time .. ", Name: " .. name .. "\n")
    tCues[time] = name
  end
  
  cueIDX = cueIDX+1
  
until cueRetval == 0


markerIDX=0

for time,name in pairs(tCues) do
  
    reaper.SetTempoTimeSigMarker(0,-1,time,-1,-1,name,0,0,0)

end

reaper.UpdateTimeline()
-----

reaper.Undo_EndBlock("script",-1)

------------------------------
------------------------------
------------------------------


--[[

--Flags:
-1, include all undo states
1, track/master vol/pan/routing, routing/hwout envelopes too
2, track/master fx
4, track items
8, loop selection, markers, regions, extensions
16, freeze state
32, non-FX envelopes only
64, FX envelopes, implied by UNDO_STATE_FX too
128, contents of automation items -- not position, length, rate etc of automation items, which is part of envelope state
256, ARA state

]]
