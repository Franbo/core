local NPC_TALK_RADIUS = 4
local sDesiredMercDist
local NO_PROFILE = 200

Facts = 
{ 
	FACT_SKYRIDER_CLOSE_TO_CHOPPER = 43,
	FACT_MARIA_ESCORTED_AT_LEATHER_SHOP = 117,
	FACT_JOEY_NEAR_MARTHA = 110,
	FACT_JOHN_ALIVE = 190,
	FACT_MARY_OR_JOHN_ARRIVED = 192,
	FACT_MARY_ALIVE = 187,
	FACT_FIRST_ROBOT_DESTROYED = 203,
    FACT_ROBOT_READY_SECOND_TIME = 205,
    FACT_SECOND_ROBOT_DESTROYED = 206,
	FACT_ESTONI_REFUELLING_POSSIBLE = 277,
	FACT_KINGPIN_KNOWS_MONEY_GONE = 103,
	FACT_PLAYER_REPAID_KINGPIN = 104,
	FACT_KINGPIN_NOT_IN_OFFICE = 256,
}

Attitude = 
{
	DEFENSIVE      = 0,
	BRAVESOLO      = 1,
	BRAVEAID       = 2,
	CUNNINGSOLO    = 3,
	CUNNINGAID     = 4,
	AGGRESSIVE     = 5,
	MAXATTITUDES   = 6,
	ATTACKSLAYONLY = 7,
}

Quests = 
{
	-- Quests ID
	QUEST_DELIVER_LETTER = 0,
	QUEST_FOOD_ROUTE = 1,
	QUEST_KILL_TERRORISTS = 2,
	QUEST_KINGPIN_IDOL = 3,
	QUEST_KINGPIN_MONEY = 4,
	QUEST_RUNAWAY_JOEY = 5,
	QUEST_RESCUE_MARIA = 6,
	QUEST_CHITZENA_IDOL = 7,
	QUEST_HELD_IN_ALMA = 8,
	QUEST_INTERROGATION = 9,
	QUEST_ARMY_FARM = 10,
	QUEST_FIND_SCIENTIST = 11,












	QUEST_DELIVER_VIDEO_CAMERA = 12,
	QUEST_BLOODCATS = 13,
	QUEST_FIND_HERMIT = 14,
	QUEST_CREATURES = 15,
	QUEST_CHOPPER_PILOT = 16,
	QUEST_ESCORT_SKYRIDER = 17,
	QUEST_FREE_DYNAMO = 18,
	QUEST_ESCORT_TOURISTS = 19,
	QUEST_FREE_CHILDREN = 20,
	QUEST_LEATHER_SHOP_DREAM = 21,
	QUEST_ESCORT_SHANK = 22,				-- Start quest 44, End quest 45 - Escort Shank
	QUEST_23 = 23,							-- Start quest 46, End quest 47 - No 23 Yet
	QUEST_24 = 24,		
	QUEST_KILL_DEIDRANNA = 25,












}

Profil = 
{	
	MIGUEL = 57,
	CARLOS = 58,
	IRA = 59, 
	DIMITRI = 60,	
	SLAY = 64,
	DYNAMO = 66,
	SHANK = 67,
	CARMEN = 78,
	MARIA = 88,
	ANGEL = 89,
	JOEY = 90,	
	SKYRIDER = 97,
	JOHN = 118,	
	MARY = 119,
	JIM = 140,
	JACK = 141,
	OLAF = 142,
	RAY = 143,
	OLGA = 144,
	TYRONE = 145,
	MADLAB = 146,
}

What = 
{
	MERC_TYPE__PLAYER_CHARACTER = 0,
	MERC_TYPE__AIM_MERC = 1,
	MERC_TYPE__MERC = 2,
	MERC_TYPE__NPC = 3,
	MERC_TYPE__EPC = 4,
	MERC_TYPE__NPC_WITH_UNEXTENDABLE_CONTRACT = 5,
	MERC_TYPE__VEHICLE = 6,
}

Team = 
{
	OUR_TEAM = 0,
	ENEMY_TEAM = 1,
	CREATURE_TEAM = 2,
	MILITIA_TEAM = 3,	
	CIV_TEAM = 4,	
}

pQuest = 
{
	QUESTNOTSTARTED = 0,
	QUESTINPROGRESS = 1,
	QUESTDONE = 2,
}

Group = 
{
	NON_CIV_GROUP = 0,
	REBEL_CIV_GROUP = 1,
	KINGPIN_CIV_GROUP = 2,
	SANMONA_ARMS_GROUP = 3,
	ANGELS_GROUP = 4,
	BEGGARS_CIV_GROUP = 5,
	TOURISTS_CIV_GROUP = 6,
	ALMA_MILITARY_CIV_GROUP = 7,
	DOCTORS_CIV_GROUP = 8,
	COUPLE1_CIV_GROUP = 9,
	HICKS_CIV_GROUP = 10,
	WARDEN_CIV_GROUP = 11,
	JUNKYARD_CIV_GROUP = 12,
	FACTORY_KIDS_GROUP = 13,
	QUEENS_CIV_GROUP = 14,
}

Status = 
{
	CIV_GROUP_NEUTRAL = 0,
	CIV_GROUP_WILL_EVENTUALLY_BECOME_HOSTILE = 1,
	CIV_GROUP_WILL_BECOME_HOSTILE = 2,
	CIV_GROUP_HOSTILE = 3,
}

SectorY = 
{
	MAP_ROW_A = 1,
	MAP_ROW_B = 2,
	MAP_ROW_C = 3,
	MAP_ROW_D = 4,
	MAP_ROW_E = 5,
	MAP_ROW_F = 6,
	MAP_ROW_G = 7,
	MAP_ROW_H = 8,
	MAP_ROW_I = 9,
	MAP_ROW_J = 10,
	MAP_ROW_K = 11,
	MAP_ROW_L = 12,
	MAP_ROW_M = 13,
	MAP_ROW_N = 14,
	MAP_ROW_O = 15,
	MAP_ROW_P = 16,
}

local iLoop
local aimLoop

local HEARD_3_TURNS_AGO	= -4
local HEARD_2_TURNS_AGO	= -3
local HEARD_LAST_TURN	=  -2
local HEARD_THIS_TURN	= -1
local NOT_HEARD_OR_SEEN	= 0
local SEEN_CURRENTLY	= 1
local SEEN_THIS_TURN	= 2
local SEEN_LAST_TURN	= 3
local SEEN_2_TURNS_AGO	=4
local SEEN_3_TURNS_AGO = 5
-- local function
local function HandleJohnArrival( ID )

	local ID2 = nil
	local sDist

	if ( not ID ) then
		ID = FindSoldierByProfileID (Profil.JOHN)
		if ( not ID ) then
			return
		end
	end
	
	if ( PythSpacesAway( ID,82994) < 40 ) then
	
		if ( CheckFact( Facts.FACT_MARY_ALIVE, 0 ) == true ) then
			ID2 = FindSoldierByProfileID( Profil.MARY )
			if ( ID2 ) then
				if ( PythSpacesAway( ID, GetNPCGridNo(ID2) ) > 8 ) then
					-- Too far away!
					return
				end
			end
		end

		SetFactTrue( Facts.FACT_MARY_OR_JOHN_ARRIVED )
		ActionStopMerc(ID)

		-- If Mary is alive/dead
		if ( ID2 ) then
			ActionStopMerc(ID2)
			TriggerNPCRecord( ID, 13 )
		else
			TriggerNPCRecord( ID, 12 )
		end
		
	end
	
end
-- end local function

-- local function
local function HandleMaryArrival( ID )

	local sDist
	
	if ( not ID ) then
		ID = FindSoldierByProfileID (Profil.MARY)
		if ( not ID ) then
			return
		end
	end
	
	if ( CheckFact( Facts.FACT_JOHN_ALIVE,0) == true ) then
		return
	--new requirements: player close by
	elseif ( PythSpacesAway( ID,82994) < 20 ) then
	
		if ( not TileIsOutOfBounds ( ClosestPC( ID, sDist )) and sDist > NPC_TALK_RADIUS * 2 ) then
			--too far away
			return
		end
		
		SetFactTrue( Facts.FACT_MARY_OR_JOHN_ARRIVED )
		ActionStopMerc(ID)
		TriggerNPCRecord( ID, 13 )
	end

end
-- end local function

function HandleAtNewGridNo( ProfileId )


	if ( CheckFact ( Facts.FACT_ESTONI_REFUELLING_POSSIBLE, 0) == true and CheckQuest(Quests.QUEST_ESCORT_SHANK) == pQuest.QUESTINPROGRESS ) then
			EndQuest( Quests.QUEST_ESCORT_SHANK, gWorldSectorX, gWorldSectorY ) 	
	end	
	TeamSoldier = FindSoldierTeam (ProfileId)
	
	if ( TeamSoldier == Team.OUR_TEAM ) then -- Team
	
		-- Kingping expecting visit from player (Sector D5)
		-- The fact has to be TRUE. If FALSE then Kingpin attack the player.
		if ( CheckFact( 98, ProfileId ) == false ) then 
		   if ( NPCInRoomRange( ProfileId, 30, 39 ) == true and gWorldSectorX == 5 and gWorldSectorY == SectorY.MAP_ROW_D and gWorldSectorZ == 0 )then 
		
				for iLoop = GetTacticalStatusFirstID(Team.CIV_TEAM),GetTacticalStatusLastID(Team.CIV_TEAM) do
					if ( CheckMercPtrsInSector (iLoop) == true and CheckMercPtrsInActive(iLoop) == true and CheckMercPtrsInCivilianGroup (iLoop) == 2 ) then
						for aimLoop=GetTacticalStatusFirstID(Team.OUR_TEAM),GetTacticalStatusLastID(Team.OUR_TEAM) do
							if ( CheckMercPtrsID1SeenID2(iLoop,aimLoop) == SEEN_CURRENTLY ) then
								MakeMercPtrsHostile( iLoop )
							end
						end	
					end	
				end
 
				if ( CheckCombatMode == false ) then
					EnterTeamCombatMode(Team.CIV_TEAM)
				end	
	
			end	
		end
		if ( WhatKindOfMercAmI (ProfileId) == What.MERC_TYPE__EPC ) then -- what EPC
		
			-- Skyrider
			if ( ProfileId == Profil.SKYRIDER and CheckNPCSectorBool( Profil.SKYRIDER, 13, SectorY.MAP_ROW_B, 0 ) == true and PythSpacesAway( Profil.SKYRIDER,69576 ) < 11 ) then
					ActionStopMerc(Profil.SKYRIDER)
					SetFactTrue( Facts.FACT_SKYRIDER_CLOSE_TO_CHOPPER )
					TriggerNPCRecord( Profil.SKYRIDER, 15 )
					SetUpHelicopterForPlayer( 13, SectorY.MAP_ROW_B, Profil.SKYRIDER, 163 )
			
			-- Mary & John		
							
			elseif ( ( CheckNPCSectorBool( Profil.MARY, 13, SectorY.MAP_ROW_B, 0 ) == true ) or ( CheckNPCSectorBool( Profil.JOHN, 13, SectorY.MAP_ROW_B, 0 ) == true ) ) then
					
					-- Mary	
					if ( ProfileId == Profil.MARY ) then
						HandleMaryArrival( Profil.MARY )
					-- John
					elseif ( ProfileId == Profil.JOHN ) then
						HandleJohnArrival( Profil.JOHN )
					end
					
			-- Maria		
			elseif ( ProfileId == Profil.MARIA and CheckNPCSectorBool( Profil.MARIA, 6, SectorY.MAP_ROW_C, 0) == true and CheckFact(Facts.FACT_MARIA_ESCORTED_AT_LEATHER_SHOP,Profil.MARIA) == true ) then
			
				if ( NPCInRoom( Profil.ANGEL, 2 ) == true ) then
					TriggerNPCRecord( Profil.ANGEL, 12 )
				end

			-- Joey
			elseif ( ProfileId == Profil.JOEY and CheckNPCSectorBool( Profil.JOEY, 8, SectorY.MAP_ROW_G, 0) == true and CheckFact(Facts.FACT_JOEY_NEAR_MARTHA,0) == true ) then
					ActionStopMerc(Profil.JOEY)
					TriggerNPCRecord( Profil.JOEY, 9 )
			end
		
		-- Drassen stuff for John & Mary
		elseif ( CheckQuest(Quests.QUEST_ESCORT_TOURISTS) == pQuest.QUESTINPROGRESS and ProfileIdsSectorX == 13 and ProfileIdsSectorY == SectorY.MAP_ROW_B and ProfileIdbSectorZ == 0 ) then
			
		if ( CheckFact( Facts.FACT_JOHN_ALIVE, 0) == true ) then
				HandleJohnArrival( nil )
		else
				HandleMaryArrival( nil )
		end
		
	elseif ( TeamSoldier == Team.CIV_TEAM and ProfileId ~= NO_PROFILE and CheckSoldierNeutral( ProfileId ) == true ) then
	
		if ( ProfileId == Profil.JIM or ProfileId == Profil.JACK or ProfileId == Profil.OLAF or ProfileId == Profil.RAY or ProfileId == Profil.OLGA or ProfileId == Profil.TYRONE ) then
	
			if ( not TileIsOutOfBounds( ClosestPC( ProfileId, sDesiredMercDist )) ) then 
				if ( sDesiredMercDist <= NPC_TALK_RADIUS * 2 ) then
					CancelAIAction ( ProfileId ) 
					AddToShouldBecomeHostileOrSayQuoteList( GetPlayerMercID(ProfileId) )
				end
			end
		end
		
		end -- End what EPC
	end -- End team
end