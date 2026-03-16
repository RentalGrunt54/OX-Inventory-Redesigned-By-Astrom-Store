# PREVIEW

# INSTALLATION GUIDE

A. Create Lua Module
Path:
`modules/dragGive/client.lua`

B. Load Module in Lua
File:
`client.lua`
Add at the beginning of the file:

```lua
require 'modules.dragGive.client'
```

C. Remove the Blur (Sharp Background)
   File:
   `client.lua`

Find and delete all lines that contain:

```
TriggerScreenblurFadeIn(0)
TriggerScreenblurFadeOut(0)
```

D. Interface Files
   Place the **provided `build` folder** inside the `web/` directory.

The final structure should look like this:

```
ox_inventory/
 └─ web/
     ├─ build/
     └─ ...
```

Make sure the `build` folder is directly inside `web/`.
