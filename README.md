
<p align="center">
    <img src="Resources/logo.png" width="120">
</p>

# My TouchBar. My rules
[![GitHub release](https://img.shields.io/github/release/toxblh/MTMR.svg)](https://github.com/Toxblh/MTMR/releases)

<p align="center">
    <img src="Resources/TouchBar-v0.6.png">
</p>

My the idea is to create the program like a platform for plugins for customization TouchBar. I very like BTT and a full custom TouchBar (my [BTT preset](https://github.com/Toxblh/btt-touchbar-preset)). And I want to create it. And it's my the first Swift project for MacOS :)

### Roadmap
- [x] Create the first prototype with TouchBar in Storyboard
- [x] Put in stripe menu on startup the application
- [x] Find how to simulate real buttons like brightness, volume, night shift and etc.
- [x] Time in touchbar!
- [x] First the weather plugin
- [x] Find how to open full-screen TouchBar without the cross and stripe menu
- [x] Find how to add haptic feedback
- [x] Add icon and menu in StatusBar
- [x] Hide from Dock
- [x] Status menu: "preferences", "quit"
- [x] JSON or another approch for save preset, maybe in `~/Library/Application Support/MTMR/`
- [x] Custom buttons size, actions by click
- [x] Layout: [always left, NSSliderView for center, always right]
- [ ] Overwrite default values from item types (e.g. title for brightness)
- [ ] System for autoupdate (maybe https://sparkle-project.org/)

Settings:
- [ ] Intarface for plugins and export like presets
- [ ] Startup at login
- [ ] Show on/off in Dock
- [ ] Show on/off in StatusBar
- [ ] On/off Haptic Feedback

Maybe:
- [ ] Refactoring the application on packages (AppleScript, JavaScript? and Swift?)


## Installation
1. Download last release [Releases](https://github.com/Toxblh/MTMR/releases)
2. Unzip
3. Open MTMR
4. Open preset `open ~/Library/Application Support/MTMR/items.json` and customize it. Restart MTMR to apply changes.

## Preset

File for customize your preset for MTMR: `open ~/Library/Application Support/MTMR/items.json`

## Built-in button types:

- escape
- exitTouchbar
- brightnessUp
- brightnessDown
- volumeDown
- volumeUp

> Media Keys
- previous
- play
- next

> AppleScript plugins
- weather
- battery
- sleep
- displaySleep

## Built-in slider types:

- brightness
- volume

### You can also make a custom buttons using these types
- `staticButton`
```json
 "type": "staticButton",
 "title": "esc",
```

- `appleScriptTitledButton`
```js
    "type": "appleScriptTitledButton",
    "refreshInterval": 60, //optional
    "source": {
      "filePath": "/Users/toxblh/Library/Application Support/MTMR/iTunes.nowPlaying.scpt",
      // or
      "inline": "tell application \"Finder\"\rmake new Finder window\rset target of front window to path to home folder as string\ractivate\rend tell",
      // or
      "base64": "StringInbase64"
    },
```

- `timeButton`
```js
  "type": "timeButton",
  "formatTemplate": "HH:mm" //optional
```

## Actions:
- `hidKey`
```json
 "action": "hidKey",
 "keycode": 53,
```

- `keyPress`
```json
 "action": "keyPress",
 "keycode": 1,
```

- `appleScript`
```js
 "action": "appleScript",
 "actionAppleScript": {
     "inline": "tell application \"Finder\"\rmake new Finder window\rset target of front window to path to home folder as string\ractivate\rend tell"
    // "filePath" or "base64" will work as well
 },
```

- `shellScript`
```js
 "action": "shellScript",
 "executablePath": "/usr/bin/pmset",
 "shellArguments": "sleepnow", // optional

```

## Additional paramaters:

- `width` allow to easily restrict how much room a particular button will take
```json
  "width": 34
```

- `align` can stick the time to the side. default is center
```js
  "align": "left" //or "right" or "center"
```

## Example configuration:
```json
[
  { "type": "escape", "width": 110 },
  { "type": "exitTouchbar", "align": "left" },
  {
    "type": "brightnessUp",
    "align": "left",
    "width": 36
  },
  {
    "type": "staticButton",
    "align": "left",
    "title": "🔆",
    "action": "keyPress",
    "keycode": 113,
    "width": 36
  },

  {
    "type": "appleScriptTitledButton",
    "source": {
      "filePath": "/Users/toxblh/Library/Application Support/MTMR/iTunes.nowPlaying.scpt"
    },
    "refreshInterval": 1
  },
 {
    "type": "staticButton",
    "align": "left",
    "image": { "base64" : "%base64Finder%"},
    "action": "appleScript",
    "actionAppleScript": {
        "inline": "tell application \"Finder\"\rmake new Finder window\rset target of front window to path to home folder as string\ractivate\rend tell"
    },
    "width": 36
  },
  {
    "type": "appleScriptTitledButton",
    "source": {
      "inline": "if application \"Safari\" is running then\r\ttell application \"Safari\"\r\t\trepeat with t in tabs of windows\r\t\t\ttell t\r\t\t\t\tif URL starts with \"https:\/\/music.yandex.ru\" and name does not end with \"на Яндекс.Музыке\" then\r\t\t\t\t\treturn name of t as text\r\t\t\t\tend if\r\t\t\tend tell\r\t\tend repeat\r\tend tell\rend if\rreturn \"\""
    },
    "refreshInterval": 1
  },
  { "type": "previous", "width": 36, "align": "right" },
  { "type": "play", "width": 36, "align": "right" },
  { "type": "next", "width": 36, "align": "right" },
  { "type": "sleep", "width": 36 , "align": "right"},
  { "type": "displaySleep", "align": "right" },
  { "type": "weather", "refreshInterval": 1800, "width": 70, "align": "right" },
  { "type": "volumeDown", "width": 36 , "align": "right"},
  { "type": "volumeUp", "width": 36 , "align": "right"},
  { "type": "battery", "refreshInterval": 60 , "align": "right"},
  { "type": "appleScriptTitledButton", "refreshInterval": 1800, "source": { "filePath": "/Users/redetection/Library/Application Support/MTMR/Weather.scpt"} , "align": "right"},
  { "type": "timeButton", "formatTemplate": "HH:mm", "width": 64, "align": "right" }
]
```


### Author's presets

[@Toxblh preset](Resources/toxblh.json)

[@ReDetection preset](Resources/ReDetection.json)

## Credits

Built by [@Toxblh](https://patreon.com/toxblh) and [@ReDetection](http://patreon.com/ReDetection).
