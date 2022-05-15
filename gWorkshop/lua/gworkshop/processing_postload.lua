do
    assert(gWorkshop)
    assert(gWorkshop.Settings)
    assert(gWorkshop.Settings.PostLoad)

    if (!next(gWorkshop.Settings.PostLoad)) then
        return
    end
end

local buffer = {WaitForDownload = gWorkshop.Settings.WaitForDownload}

do
    for _, workshop_id in ipairs(gWorkshop.Settings.PostLoad) do
        table.insert(buffer, workshop_id)
    end
end

do
    buffer = util.Compress(util.TableToJSON(buffer))

    local io_stream = file.Open('gworkshop_client_list.json', 'wb', 'DATA')
    assert(io_stream)

    io_stream:Write(buffer)
    io_stream:Close()
end

do
    buffer = nil
    resource.AddSingleFile('data/gworkshop_client_list.json')

    jit.flush()
    collectgarbage()
end