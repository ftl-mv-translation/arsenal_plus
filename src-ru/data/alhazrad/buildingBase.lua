
local iconScrap = Hyperspace.Resources:CreateImagePrimitiveString('alhazrad/icon_scrap_mini.png', 0, 0, 0, Graphics.GL_Color(1, 1, 1, 1), 1.0, false)
local box = Hyperspace.Resources:CreateImagePrimitiveString('alhazrad/box.png', 0, 0, 0, Graphics.GL_Color(1, 1, 1, 1), 1.0, false)

local portrait1 = Hyperspace.Resources:CreateImagePrimitiveString('alhazrad/trader_portrait_1.png', 0, 0, 0, Graphics.GL_Color(1, 1, 1, 1), 1.0, false)
local portrait2 = Hyperspace.Resources:CreateImagePrimitiveString('alhazrad/trader_portrait_2.png', 0, 0, 0, Graphics.GL_Color(1, 1, 1, 1), 1.0, false)
local portrait3 = Hyperspace.Resources:CreateImagePrimitiveString('alhazrad/trader_portrait_3.png', 0, 0, 0, Graphics.GL_Color(1, 1, 1, 1), 1.0, false)
local portrait4 = Hyperspace.Resources:CreateImagePrimitiveString('alhazrad/trader_portrait_4.png', 0, 0, 0, Graphics.GL_Color(1, 1, 1, 1), 1.0, false)

local gib1 = Hyperspace.Resources:CreateImagePrimitiveString('alhazrad/1a.png', 0, 0, 0, Graphics.GL_Color(1, 1, 1, 1), 1.0, false)
local gib2 = Hyperspace.Resources:CreateImagePrimitiveString('alhazrad/2a.png', 0, 0, 0, Graphics.GL_Color(1, 1, 1, 1), 1.0, false)
local gib3 = Hyperspace.Resources:CreateImagePrimitiveString('alhazrad/3a.png', 0, 0, 0, Graphics.GL_Color(1, 1, 1, 1), 1.0, false)
local gib4 = Hyperspace.Resources:CreateImagePrimitiveString('alhazrad/4a.png', 0, 0, 0, Graphics.GL_Color(1, 1, 1, 1), 1.0, false)
local gib5 = Hyperspace.Resources:CreateImagePrimitiveString('alhazrad/5a.png', 0, 0, 0, Graphics.GL_Color(1, 1, 1, 1), 1.0, false)
local gib6 = Hyperspace.Resources:CreateImagePrimitiveString('alhazrad/6a.png', 0, 0, 0, Graphics.GL_Color(1, 1, 1, 1), 1.0, false)
local gib7 = Hyperspace.Resources:CreateImagePrimitiveString('alhazrad/7a.png', 0, 0, 0, Graphics.GL_Color(1, 1, 1, 1), 1.0, false)
local gib8 = Hyperspace.Resources:CreateImagePrimitiveString('alhazrad/8a.png', 0, 0, 0, Graphics.GL_Color(1, 1, 1, 1), 1.0, false)
local gib9 = Hyperspace.Resources:CreateImagePrimitiveString('alhazrad/9a.png', 0, 0, 0, Graphics.GL_Color(1, 1, 1, 1), 1.0, false)

local station = Hyperspace.Resources:CreateImagePrimitiveString('alhazrad/station_10.png', 0, 0, 0, Graphics.GL_Color(1, 1, 1, 1), 1.0, false)

local score = 0
local lvl = 0

local port = 0
local nextLevel = 0 

local metaDrawGib = 0

local isDestroy = false
local isStarted = false
local gibIsDraw = false
local drawGib = 0
local curLVL = 0
local isInDrawEvent = false
local leave = false
local enemyName = ''


local function CheckEnemyShip()  
    local enemyShip = Hyperspace.ships.enemy  
    local enemyShipName = ''
    if enemyShip then
        enemyShipName = Hyperspace.ships.enemy.myBlueprint.blueprintName
        if enemyShipName == 'BUILDINGSTATION_1' or enemyShipName == 'BUILDINGSTATION_2' or enemyShipName == 'BUILDINGSTATION_3' or enemyShipName == 'BUILDINGSTATION_4' or enemyShipName == 'BUILDINGSTATION_5' or enemyShipName == 'BUILDINGSTATION_6' or enemyShipName == 'BUILDINGSTATION_7' or enemyShipName == 'BUILDINGSTATION_8' or enemyShipName == 'BUILDINGSTATION_9' or enemyShipName == 'BUILDINGSTATION_10' then
            if Hyperspace.ships.enemy.ship.hullIntegrity.first <= 0 then
                isInDrawEvent = false
                return
            else 
                enemyName = enemyShipName
                isInDrawEvent = true
            end
        end
    else 
        isInDrawEvent = false
    end
end


local function LeavePoint() 
   leave = true  
       enemyName = ''
end

local function ResetJump() 
    --print('ResetJump')
    leave = false
    isInDrawEvent = false 
    isDestroy = false
    enemyName = ''
end

local function ResetMain()
    --print('ResetMain')
    leave = false
    isInDrawEvent = false
     isDestroy = false 
    score =0
    lvl = 0
    curLVL = 0
    port = 0
    nextLevel = 0
    isDestroy = false
    isStarted = false
    enemyName = ''
end

local function ResetRestart()
    --print('ResetRestart')
    Hyperspace.metaVariables['meta_trader_store_drawgib'] = 0
    Hyperspace.metaVariables['meta_trader_store_drawevent'] = 0
    metaDrawGib = 0
    leave = false
    isInDrawEvent = false   
    gibIsDraw = false
    drawGib = 0
    leave = false
    isDestroy = false 
    enemyName = ''
end

local function DestroyStation()  
    --print('DestroyStation')
    isDestroy = true
 score =0
 lvl = 0

 port = 0
 nextLevel = 0 

 metaDrawGib = 0


 isStarted = false
 gibIsDraw = false
 drawGib = 0
 curLVL = 0
 isInDrawEvent = false
 leave = false
 enemyName = ''

    Hyperspace.metaVariables['meta_trader_store_lvl'] = 0
    Hyperspace.metaVariables['meta_trader_store_drawgib'] = 0
    Hyperspace.metaVariables['meta_trader_store_drawevent'] = 0
end


local function StartEvent()
    --print('StartEvent')
    enemyName = ''
    CheckEnemyShip()
       Hyperspace.metaVariables['meta_trader_store_drawevent'] = 0
    lvl = Hyperspace.metaVariables['meta_trader_store_lvl']
    if lvl == 0 then
        lvl = 1
    end 

    gibIsDraw = false
    drawGib = 0
    leave = false

    curLVL = lvl
     isStarted = true
    isInDrawEvent = true
     if enemyName == 'BUILDINGSTATION_10' and curLVL == 10 then
        Hyperspace.metaVariables['meta_trader_store_lvl'] = 10
        lvl = 10
        curLVL = 10
        gibIsDraw = false
    end
    if enemyName == 'BUILDINGSTATION_9' and curLVL == 10 then
        curLVL = 9
        drawGib = 9
        gibIsDraw = true
    end
    if enemyName == 'BUILDINGSTATION_8' and curLVL == 9 then
        curLVL = 8
        drawGib = 8
        gibIsDraw = true
    end
     if enemyName == 'BUILDINGSTATION_7' and curLVL == 8 then
        curLVL = 7
        drawGib = 7
        gibIsDraw = true
    end
     if enemyName == 'BUILDINGSTATION_6' and curLVL == 7 then
        curLVL = 6
        drawGib = 6
        gibIsDraw = true
    end
     if enemyName == 'BUILDINGSTATION_5' and curLVL == 6 then
        curLVL = 5
        drawGib = 5
        gibIsDraw = true
    end
    if enemyName == 'BUILDINGSTATION_4' and curLVL == 5 then
        curLVL = 4
        drawGib = 4
        gibIsDraw = true
    end
    if enemyName == 'BUILDINGSTATION_3' and curLVL == 4 then
        curLVL = 3
        drawGib = 3
        gibIsDraw = true
    end
    if enemyName == 'BUILDINGSTATION_2' and curLVL == 3 then
        curLVL = 2
        drawGib = 2
        gibIsDraw = true
    end
    if enemyName == 'BUILDINGSTATION_1' and curLVL == 2 then
        curLVL = 1
        drawGib = 1
        gibIsDraw = true
    end
   
end



local function CheckNextLvl()
  --print('CheckNextLvl')
    if lvl == 0 then
        lvl = 1
    end   
    if lvl == 1 then
      nextLevel = 100 - score
    end
    if lvl == 2 then
      nextLevel = 200 - score
    end   
    if lvl == 3 then
      nextLevel = 300 - score
    end
     if lvl == 4 then
      nextLevel = 500 - score
    end
    if lvl == 5 then
      nextLevel = 750 - score
    end
     if lvl == 6 then
      nextLevel = 1000 - score
    end
     if lvl == 7 then
      nextLevel = 1300 - score
    end
    if lvl == 8 then
      nextLevel = 1600 - score
    end
    if lvl == 9 then
      nextLevel = 2000 - score
    end
    if lvl == 10 then
      nextLevel = 0
    end
end






local function CheckScrap()
    --print('CheckScrap')
    if lvl == 1 and score >= 100 then
        lvl = lvl + 1 
       Hyperspace.metaVariables['meta_trader_store_drawgib'] = 1
        Hyperspace.metaVariables['meta_trader_store_drawevent'] = 1
        metaDrawGib = Hyperspace.metaVariables['meta_trader_store_drawgib']
         Hyperspace.metaVariables['meta_trader_store_lvl'] = lvl
        if not gibIsDraw then
            drawGib = 1
            gibIsDraw = true
        end
    end   
    if lvl == 2 and score >= 200 then
       lvl = lvl + 1 
        Hyperspace.metaVariables['meta_trader_store_drawgib'] = 1
         Hyperspace.metaVariables['meta_trader_store_drawevent'] = 1
        metaDrawGib = Hyperspace.metaVariables['meta_trader_store_drawgib']
        Hyperspace.metaVariables['meta_trader_store_lvl'] = lvl
      if not gibIsDraw then
            drawGib = 2
            gibIsDraw = true
        end
    end
   if lvl == 3 and score >= 300 then
        lvl = lvl + 1 
        Hyperspace.metaVariables['meta_trader_store_drawgib'] = 1
         Hyperspace.metaVariables['meta_trader_store_drawevent'] = 1
        metaDrawGib = Hyperspace.metaVariables['meta_trader_store_drawgib']
         Hyperspace.metaVariables['meta_trader_store_lvl'] = lvl
        if not gibIsDraw then
            drawGib = 3
            gibIsDraw = true
        end
    end
   if lvl == 4 and score >= 500 then       
        lvl = lvl + 1 
       Hyperspace.metaVariables['meta_trader_store_drawgib'] = 1
        Hyperspace.metaVariables['meta_trader_store_drawevent'] = 1
        metaDrawGib = Hyperspace.metaVariables['meta_trader_store_drawgib']
         Hyperspace.metaVariables['meta_trader_store_lvl'] = lvl
        if not gibIsDraw then
            drawGib = 4
            gibIsDraw = true
        end
    end
    if lvl == 5 and score >= 750 then
       lvl = lvl + 1 
       Hyperspace.metaVariables['meta_trader_store_drawgib'] = 1
        Hyperspace.metaVariables['meta_trader_store_drawevent'] = 1
        metaDrawGib = Hyperspace.metaVariables['meta_trader_store_drawgib']
        Hyperspace.metaVariables['meta_trader_store_lvl'] = lvl
      if not gibIsDraw then
            drawGib = 5
            gibIsDraw = true
        end
    end
   if lvl == 6 and score >= 1000 then
       lvl = lvl + 1 
      Hyperspace.metaVariables['meta_trader_store_drawgib'] = 1
       Hyperspace.metaVariables['meta_trader_store_drawevent'] = 1
        metaDrawGib = Hyperspace.metaVariables['meta_trader_store_drawgib']
        Hyperspace.metaVariables['meta_trader_store_lvl'] = lvl
       if not gibIsDraw then
            drawGib = 6
            gibIsDraw = true
        end
    end
    if lvl == 7 and score >= 1300 then
       lvl = lvl + 1 
        Hyperspace.metaVariables['meta_trader_store_drawgib'] = 1
         Hyperspace.metaVariables['meta_trader_store_drawevent'] = 1
        metaDrawGib = Hyperspace.metaVariables['meta_trader_store_drawgib']
        Hyperspace.metaVariables['meta_trader_store_lvl'] = lvl
      if not gibIsDraw then
            drawGib = 7
            gibIsDraw = true
        end
    end
     if lvl == 8 and score >= 1600 then
       lvl = lvl + 1 
        Hyperspace.metaVariables['meta_trader_store_drawgib'] = 1
         Hyperspace.metaVariables['meta_trader_store_drawevent'] = 1
        metaDrawGib = Hyperspace.metaVariables['meta_trader_store_drawgib']
        Hyperspace.metaVariables['meta_trader_store_lvl'] = lvl
        if not gibIsDraw then
            drawGib = 8
            gibIsDraw = true
        end
    end
    if lvl == 9 and score >= 2000 then
        lvl = lvl + 1 
        Hyperspace.metaVariables['meta_trader_store_drawgib'] = 1
         Hyperspace.metaVariables['meta_trader_store_drawevent'] = 1
        metaDrawGib = Hyperspace.metaVariables['meta_trader_store_drawgib']
         Hyperspace.metaVariables['meta_trader_store_lvl'] = lvl
       if not gibIsDraw then
            drawGib = 9
            gibIsDraw = true
        end
    end
    if  lvl == 10 and enemyName == 'BUILDINGSTATION_10' then 
        Hyperspace.metaVariables['meta_trader_store_drawgib'] = 1
         Hyperspace.metaVariables['meta_trader_store_drawevent'] = 1
        metaDrawGib = Hyperspace.metaVariables['meta_trader_store_drawgib']
        drawGib = 0
            gibIsDraw = false
    end

   
    --lvl = Hyperspace.metaVariables['meta_trader_store_lvl']  
    --lvl = math.floor(tonumber(lvl))
     
end


local function Init()


    metaDrawGib = Hyperspace.metaVariables['meta_trader_store_drawgib']

    if isDestroy then
        return
    end

    if leave then
        return
    end 

    --print('Init')
    CheckEnemyShip()
   

    if not isInDrawEvent then
        return
    end

    if not isStarted then
        StartEvent()
        return
    end 

     CheckScrap()

    local cApp = Hyperspace.App
    if not cApp.world.bStartedGame or not isInDrawEvent then 
        return 
    end

    local enemyShip = Hyperspace.ships.enemy    
    if (enemyShip and enemyShip._targetable.hostile) then
        return
    end

 
    lvl = Hyperspace.metaVariables['meta_trader_store_lvl']
    score = Hyperspace.metaVariables['meta_trader_store_score']
    port = Hyperspace.metaVariables['meta_trader_name_id']
    score = math.floor(tonumber(score))
    lvl = math.floor(tonumber(lvl))
    port = math.floor(tonumber(port))    

    local traderName
    local portrait
    if port == 1 then
       portrait = portrait1
       traderName = Hyperspace.Text:GetText('trader_name1')--"Генри Кван"--traderName1
    end
    if port == 2 then
       portrait = portrait2
       traderName = Hyperspace.Text:GetText('trader_name2')--"Бетани Джонс"--traderName2
    end
    if port == 3 then
       portrait = portrait3
       traderName = Hyperspace.Text:GetText('trader_name3')--"Адам"--traderName3
    end
    if port == 4 then
       portrait = portrait4
       traderName = Hyperspace.Text:GetText('trader_name4')--"Абэ Исаму"--traderName4
    end  

    local currentX = 704
    local currentY = 78
    local isBoss = cApp.gui.combatControl.boss_visual

    if isBoss then
       currentX = currentX - 130
    end

    CheckNextLvl()
  
    Graphics.CSurface.GL_PushMatrix()
    Graphics.CSurface.GL_Translate(currentX-9, currentY-8)
    Graphics.CSurface.GL_RenderPrimitive(box)
    Graphics.CSurface.GL_PopMatrix()

    Graphics.CSurface.GL_PushMatrix()   
    Graphics.CSurface.GL_Translate(currentX+2, currentY+2)
    Graphics.CSurface.GL_RenderPrimitive(portrait)        
    Graphics.CSurface.GL_PopMatrix()
	
	Graphics.CSurface.GL_SetColor(Graphics.GL_Color(0.9, 0.9, 0.9, 1))
	Graphics.freetype.easy_print(10, currentX+7, currentY+78, traderName)

    if enemyName ~= 'BUILDINGSTATION_10' then
        Graphics.CSurface.GL_SetColor(Graphics.GL_Color(0.9, 0.9, 0.9, 1))
		Graphics.freetype.easy_print(10, currentX+73, currentY+5, "внесено лома:\n\nдо пристроя:")

        curLVL = math.floor(tonumber(curLVL))   
        
		Graphics.freetype.easy_print(10, 90+currentX+5, currentY+76-55, string.format(score))
        Graphics.freetype.easy_print(10, 90+currentX+5, currentY+76-20, string.format(nextLevel))
        
        Graphics.CSurface.GL_PushMatrix()   
		Graphics.CSurface.GL_Translate(currentX+78, currentY+22)
		Graphics.CSurface.GL_RenderPrimitive(iconScrap) 
		Graphics.CSurface.GL_PopMatrix()

        Graphics.CSurface.GL_PushMatrix()   
		Graphics.CSurface.GL_Translate(currentX+78, currentY+57)
		Graphics.CSurface.GL_RenderPrimitive(iconScrap) 
		Graphics.CSurface.GL_PopMatrix()
    else
        Graphics.CSurface.GL_PushMatrix()   
        Graphics.CSurface.GL_Translate(currentX+85, currentY+2)
        Graphics.CSurface.GL_RenderPrimitive(station)
        Graphics.CSurface.GL_PopMatrix()
    end

    local gibX = 0
    local gibY = 0 
    local curGib
    if drawGib == 1 then      
        gibX = 1108
        gibY = 366 
        curGib = gib1
    end    
    if drawGib == 2 then      
        gibX = 980
        gibY = 401
        curGib = gib2
    end
    if drawGib == 3 then      
        gibX = 943
        gibY = 442 
        curGib = gib3
    end
    if drawGib == 4 then      
        gibX = 1098
        gibY = 365
        curGib = gib4
    end
    if drawGib == 5 then      
        gibX = 1168
        gibY = 257
        curGib = gib5
    end
    if drawGib == 6 then      
        gibX = 1033
        gibY = 229
        curGib = gib6
    end
    if drawGib == 7 then      
        gibX = 1168
        gibY = 400
        curGib = gib7
    end
    if drawGib == 8 then      
        gibX = 945
        gibY = 264
        curGib = gib8
    end
    if drawGib == 9 then      
        gibX = 888
        gibY = 200
        curGib = gib9
    end

    if drawGib > 0 and gibIsDraw and metaDrawGib == 1 then
		Graphics.CSurface.GL_PushMatrix()   
		Graphics.CSurface.GL_Translate(gibX, gibY)
		Graphics.CSurface.GL_RenderPrimitive(curGib)
		Graphics.CSurface.GL_PopMatrix()
    end
end



-- local function HotReset()
    -- Hyperspace.metaVariables['meta_trader_store_lvl'] = 0
    -- Hyperspace.metaVariables['meta_trader_store_score'] = 0
-- end

script.on_game_event("META_TRADER_SHIP_PARAMETERS_DESTROYED", false, DestroyStation)
script.on_game_event("META_TRADER_SHIP_PARAMETERS_DEADCREW", false, DestroyStation)
script.on_game_event("META_TRADER", false, StartEvent)
script.on_game_event("START_BEACON", false, ResetRestart)
script.on_internal_event(Defines.InternalEvents.JUMP_LEAVE, LeavePoint)
script.on_internal_event(Defines.InternalEvents.JUMP_ARRIVE, ResetJump)
script.on_internal_event(Defines.InternalEvents.MAIN_MENU, ResetMain)
script.on_render_event(Defines.RenderEvents.SPACE_STATUS, function() end, Init)

--script.on_internal_event(Defines.InternalEvents.ON_TICK, HotReset)

