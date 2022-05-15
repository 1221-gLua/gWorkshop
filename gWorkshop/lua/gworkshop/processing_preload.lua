do
    assert(gWorkshop)
    assert(gWorkshop.Settings)
    assert(gWorkshop.Settings.PreLoad)

    if (!next(gWorkshop.Settings.PreLoad)) then
        return
    end
end

do
    for _, workshop_id in ipairs(gWorkshop.Settings.PreLoad) do
        resource.AddWorkshop(workshop_id)
    end
end