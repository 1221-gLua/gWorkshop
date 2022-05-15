local io_stream = file.Open('download/data/gworkshop_client_list.json', 'rb', 'GAME')
if (!io_stream) then
    return
end

local buffer = io_stream:Read(io_stream:Size())
io_stream:Close()

do
    if (!buffer) then
        return
    end

    buffer = util.Decompress(buffer)
    if (!buffer) then
        return
    end

    buffer = util.JSONToTable(buffer)
    if (!buffer) || (!istable(buffer)) then
        return
    end
end

do
    local queue
    local HasValue = table.HasValue
    local DownloadUGC = steamworks.DownloadUGC
    local MountAddon = game.MountGMA
    local ipairs = ipairs
    local next = next
    
    local WaitForDownload = (buffer.WaitForDownload == true)
    buffer.WaitForDownload = nil

    if (WaitForDownload) then
        queue = {}

        timer.Create('gworkshop.WaitForDownload', 1, 0, function()
            for _, workshop_id in ipairs(buffer) do
                if (!queue[workshop_id]) then
                    return
                end
            end

            timer.Remove('gworkshop.WaitForDownload')

            for _, path in next, queue do
                MountAddon(path)
            end

            queue = nil
            
            jit.flush()
            collectgarbage()
        end)
    end

    for _, workshop_id in ipairs(buffer) do
        DownloadUGC(workshop_id, function(path)
            if WaitForDownload then
                queue[workshop_id] = path
            else
                MountAddon(path)
            end
        end)
    end

    jit.flush()
    collectgarbage()
end
