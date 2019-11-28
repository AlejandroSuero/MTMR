if application "Mail" is running then
    tell application "Mail"
        if player state is playing then
            return (get artist of current track) & " – " & (get name of current track)
        else
            return ""
        end if
    end tell
end if
return ""
