gWorkshop = gWorkshop or {}
gWorkshop.Settings = gWorkshop.Settings or {}

do
    if SERVER then
        AddCSLuaFile('gworkshop/fetching_clientstate.lua')

        include('gworkshop/config.lua')
        include('gworkshop/processing_preload.lua')
        include('gworkshop/processing_postload.lua')
    else
        include('gworkshop/fetching_clientstate.lua')
    end
end