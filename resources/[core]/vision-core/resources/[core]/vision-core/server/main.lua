-- [[ VISIONCORE ULTIMATE ENGINE - CHICAGO EDITION ]]
Vision = { Players = {}, Config = {} }

-- 1. THE PLAYER OBJECT (OOP & Metadata)
function Vision.CreatePlayer(source, data)
    local self = {}
    self.source = source
    self.citizenid = data.citizenid
    self.money = json.decode(data.money) or {cash = 500, bank = 5000}
    self.metadata = json.decode(data.metadata) or {hunger = 100, thirst = 100, street_rep = 0}
    self.inventory = json.decode(data.inventory) or {}

    -- EKONOMI & DIRTY MONEY
    self.AddMoney = function(amount, type)
        type = type or 'cash'
        self.money[type] = self.money[type] + amount
        Player(self.source).state:set('money', self.money, true) -- Sinkron Instan
    end

    -- INVENTORY DENGAN UNIQUE METADATA (Slot Based)
    self.AddItem = function(item, amount, info)
        table.insert(self.inventory, {name = item, amount = amount, info = info or {serial = "V-"..math.random(1111,9999)}})
        Player(self.source).state:set('inv', self.inventory, true)
    end

    -- AUTO-SAVE ANTI ROLLBACK
    self.Save = function()
        MySQL.update('UPDATE players SET money = ?, metadata = ?, inventory = ? WHERE citizenid = ?', 
        {json.encode(self.money), json.encode(self.metadata), json.encode(self.inventory), self.citizenid})
    end

    Vision.Players[source] = self
    return self
end

-- 2. CHICAGO GANGSTA LOGIC (Server-side Authority)
RegisterNetEvent('vision:server:updateRep', function(amount)
    local src = source
    if Vision.Players[src] then Vision.Players[src].metadata.street_rep = Vision.Players[src].metadata.street_rep + amount end
end)

-- 3. ANTICHEAT: ENTITY LOCKDOWN (Blokir Spawn Ilegal)
AddEventHandler('entityCreating', function(entity)
    local owner = NetworkGetEntityOwner(entity)
    if owner > 0 and GetEntityType(entity) == 2 then CancelEvent() end -- Blokir mobil modder
end)

-- 4. AUTO-SAVE LOOP
CreateThread(function()
    while true do
        Wait(10 * 60 * 1000)
        for _, p in pairs(Vision.Players) do p.Save() end
    end
end)

