# PREVIEW

![Preview1](https://github.com/RentalGrunt54/OX-Inventory-Redesigned-By-Astrom-Store/blob/main/Screenshots/0511F05B-2BD5-4344-B49F-2D94CC2CA8BA.png)
![Preview2](https://github.com/RentalGrunt54/OX-Inventory-Redesigned-By-Astrom-Store/blob/main/Screenshots/5A1DE468-D0B6-4379-890E-7EC6C1C7DDD1.png)
![Preview3](https://github.com/RentalGrunt54/OX-Inventory-Redesigned-By-Astrom-Store/blob/main/Screenshots/77464CA2-0C7F-4D8D-B593-A0BA785ED78D.png)
![Preview4](https://github.com/RentalGrunt54/OX-Inventory-Redesigned-By-Astrom-Store/blob/main/Screenshots/8EB65355-C658-45EB-AFC1-398E019D6BAC.png)
![Preview5](https://github.com/RentalGrunt54/OX-Inventory-Redesigned-By-Astrom-Store/blob/main/Screenshots/9A1C65E8-CCC4-48FC-8D29-B239B6D0A7C3.png)
![Preview6](https://github.com/RentalGrunt54/OX-Inventory-Redesigned-By-Astrom-Store/blob/main/Screenshots/AC48B693-547D-4B45-B7A7-0FE7DE141A32.png)
![Preview7](https://github.com/RentalGrunt54/OX-Inventory-Redesigned-By-Astrom-Store/blob/main/Screenshots/DE06DFF6-55DB-4A9A-B763-CD6998E2D449.png)

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
