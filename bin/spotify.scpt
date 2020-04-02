if application "Spotify" is running then
  tell application "Spotify"
    set theName to name of the current track
    set theArtist to artist of the current track
    set theAlbum to album of the current track
    set theUrl to spotify url of the current track
    set theState to player state as text
    try
      if theState is "playing" then
        return "♬  " & theName & " - " & theArtist & " ♬"
      end if
      return theName & " - " & theArtist
    on error err
    end try
  end tell
end if
return "☹︎  No Music ☹︎"
