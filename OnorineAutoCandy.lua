-- Create frame and register required events
local frame = CreateFrame("Frame")
frame:RegisterEvent("TRADE_SHOW")
frame:RegisterEvent("GOSSIP_SHOW")
frame:RegisterEvent("MERCHANT_SHOW")
frame:RegisterEvent("LOOT_OPENED")
frame:RegisterEvent("BAG_UPDATE")

local PERFUME_BOTTLE = 21829
local COLOGNE_BOTTLE = 21833
local LOVE_TOKEN     = 21815

local GIFT_OF_ADORATION_DARNASSUS    = 21979
local GIFT_OF_ADORATION_IRONFORGE    = 21980
local GIFT_OF_ADORATION_ORGRIMMAR    = 22164
local GIFT_OF_ADORATION_STORMWIND    = 21981
local GIFT_OF_ADORATION_THUNDERBLUFF = 22165
local GIFT_OF_ADORATION_UNDERCITY    = 22166

-- Determine if we are a character who should be giving out perfumes, or
-- doing chocolate automation.
--
-- Simply, if we have more than 1g, we'll give out perfumes, otherwise we'll
-- be in chocolate mode.
local perfume_giver = GetMoney() >= 10000

-- Searches containers for perfume bottles or cologne bottles and returns
-- the list of where they can be found by bag index and slot
function get_bottles()
    local bottles = {}
    for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
        for slot = 1, GetContainerNumSlots(bag) do
            local itemid = GetContainerItemID(bag, slot)
            if itemid == PERFUME_BOTTLE or itemid == COLOGNE_BOTTLE then
                table.insert(bottles, { bag, slot })
            end
        end
    end

    return bottles
end

-- Searches containers for gifts of adoration
function get_gifts()
    local bottles = {}
    for bag = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
        for slot = 1, GetContainerNumSlots(bag) do
            local itemid = GetContainerItemID(bag, slot)
            if itemid == GIFT_OF_ADORATION_IRONFORGE then
                table.insert(bottles, { bag, slot })
            end
        end
    end

    return bottles
end

frame:SetScript("OnEvent", function(self, event, arg1, arg2)
    if event == "TRADE_SHOW" then
        -- Place a single perfume bottle into trade if we're a perfume giver
        if perfume_giver then
            -- Get current bottles from inventory
            local bottles = get_bottles()

            if #bottles > 0 then
                -- Get the bag and slot where this bottle is located
                local bag  = bottles[1][1]
                local slot = bottles[1][2]

                -- Place the bottle in the trade window
                UseContainerItem(bag, slot)
            end
        end

        -- If we're not a perfume giver, then automatically put all gifts into
        -- the trade window
        if not perfume_giver then
            -- Get current gifts from inventory
            for _, gift in ipairs(get_gifts()) do
                -- Get the bag and slot where this gift is located
                local bag  = gift[1]
                local slot = gift[2]

                -- Put the gift in the trade window
                UseContainerItem(bag, slot)
            end
        end
    elseif event == "GOSSIP_SHOW" and not perfume_giver then
        -- Get the gossip options
        local gossip_options = { GetGossipOptions() }
        for gossip = 1, #gossip_options do
            if gossip % 2 == 1 then
                -- Get the description and type of the gossip
                -- For example
                -- desc = "Let me browse your goods."
                -- typ  = "vendor"
                local desc = gossip_options[gossip + 0]
                local typ  = gossip_options[gossip + 1]

                -- Match for turning in love token
                if desc == "Here, I'd like to give you this token of my love." and typ == "gossip" then
                    SelectGossipOption((gossip + 1) / 2)
                end

                -- Merchant match for buying items
                if desc == "Let me browse your goods." and typ == "vendor" then
                    SelectGossipOption((gossip + 1) / 2)
                end
            end
        end
    elseif event == "LOOT_OPENED" and not perfume_giver then
        -- Take everything out of the Gift of Adoration
        for slot = 1, GetNumLootItems() do
            local item_link = GetLootSlotLink(slot)
            if item_link:find("^|cffffffff|Hitem:21812:") then
                -- If it's a chocolate do not loot it!
                print("Found a chocolate!")
            else
                -- Loot the item since it's not a chocolate
                LootSlot(slot)
            end
        end
    elseif event == "MERCHANT_SHOW" and not perfume_giver then
        -- Get current bottles from inventory
        local bottles = get_bottles()

        -- Sell a single bottle
        if #bottles > 0 then
            -- Get the first bottle inventory info
            local bag  = bottles[1][1]
            local slot = bottles[1][2]

            -- Sell the item
            UseContainerItem(bag, slot)
        end

        -- Look for a love token for sale
        for id = 1, GetMerchantNumItems() do
            local itemid = GetMerchantItemID(id)
            if itemid == LOVE_TOKEN then
                -- Buy one love token
                BuyMerchantItem(id, 1)
            end
        end

        -- Close merchant
        CloseMerchant()
    elseif event == "BAG_UPDATE" and not perfume_giver then
        -- Get current gifts from inventory
        for _, gift in ipairs(get_gifts()) do
            -- Get the bag and slot where this gift is located
            local bag  = gift[1]
            local slot = gift[2]

            -- Attempt to loot the gift
            UseContainerItem(bag, slot)
        end
    end
end)

