hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.alert.show("Hello World!")
end)

-- load Aclock
hs.loadSpoon("AClock")
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "C", function()
  spoon.AClock:toggleShow()
end)

-- half of screen
hs.hotkey.bind({'alt', 'cmd'}, 'left', function() hs.window.focusedWindow():moveToUnit({0, 0, 0.5, 1}) end)
hs.hotkey.bind({'alt', 'cmd'}, 'right', function() hs.window.focusedWindow():moveToUnit({0.5, 0, 0.5, 1}) end)
hs.hotkey.bind({'alt', 'cmd'}, 'up', function() hs.window.focusedWindow():moveToUnit({0, 0, 1, 0.5}) end)
hs.hotkey.bind({'alt', 'cmd'}, 'down', function() hs.window.focusedWindow():moveToUnit({0, 0.5, 1, 0.5}) end)

-- quarter of screen
hs.hotkey.bind({'shift', 'alt', 'cmd'}, 'left', function() hs.window.focusedWindow():moveToUnit({0, 0, 0.5, 0.5}) end)
hs.hotkey.bind({'shift', 'alt', 'cmd'}, 'right', function() hs.window.focusedWindow():moveToUnit({0.5, 0.5, 0.5, 0.5}) end)
hs.hotkey.bind({'shift', 'alt', 'cmd'}, 'up', function() hs.window.focusedWindow():moveToUnit({0.5, 0, 0.5, 0.5}) end)
hs.hotkey.bind({'shift', 'alt', 'cmd'}, 'down', function() hs.window.focusedWindow():moveToUnit({0, 0.5, 0.5, 0.5}) end)

-- full screen
hs.hotkey.bind({'alt', 'cmd'}, 'f', function() hs.window.focusedWindow():moveToUnit({0, 0, 1, 1}) end)

-- center screen
hs.hotkey.bind({'alt', 'cmd'}, 'c', function() hs.window.focusedWindow():centerOnScreen() end)


-- load mouseFollows focus
mouse_follows_focus = hs.loadSpoon("MouseFollowsFocus")
mouse_follows_focus:configure({})
mouse_follows_focus:start()
