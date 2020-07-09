# 3D Printed Travel EQ

### Status : Beta / Work In Progress

3D Printed Motorised Traveling Equatorial mount compatible with OnStep eletronics Project.

The goal is to build a basic, simple, easy to transport EQ mount.

![Travel EQ Image](https://github.com/ulysse31/OnStep_Travel_EQ/raw/master/gallery/main.jpg)


# What you need (Part list):
My travel EQ mount is composed of:
- The three 3D printed parts of this project (printed twice for DEC and RA so 6 total ^^')
- 2x NEMA17 motors (mine 400 steps, 47mm long nema17).
- 2x 100:1 gearbox (I used a OKD42 100:1 precision gearbox).
- 2x 80T GT2 pulley.
- 2x 20T GT2 pulley.
- 2x 92T (184mm) GT2 belt.
- 2x KFL08 bearings.
- 2x M8 steel tube (for now).
- M5 threaded rods (cut to length).
- M4 threaded rods (cut to length).
- 16x M5 locking nuts.
- 8x M4 locking nuts.
- 2x M5 to M8 shaft couplers (for now).
- 2x M5 to 1/4" adapter (for now).
- 2x RJ45 ports.
- 2x piece of copper PCB for etching the little boards for the RJ45 ports connectors.
- 4x M5 DIN912 screws for "easy" lock / unlock of the main axis.
- 2x Arca Swiss Quick & Release plates.
- A good photo tripod that can handle the load.

You can use other parts, but you'll have to modify the SCAD and regenerate the STLs.

On the elements marked "for now", this is because it is a beta version, I want to improve it and change those elements in the future.

# Precision :
With minimal 32 microsteps motor drivers, the 100:1 gearbox with 4:1 pulley/belt reduction, it should give arround 0.253 sec arc for tracking resolution.

# What you need to know :
- STL are made with some print gap, that may depend on your printer, you can modify it editing the SCAD and changing the "print_gap" value. Once modified, re-generate the three STL files for each blocks with OpenSCAD.
- If you want to customize it, please note that this design does NOT have a belt tensioner.
- This means the three 3D printed parts are made (customized in the SCAD file) to "fit" the exact size needed to tension the belt. Why didn't I put a belt tensioning system ? I wanted to keep it simple, and didn't find a "good and simple" way to add it to the design.
- Once printed, you'll have to sand a bit the interior to get the gearbox+motor inside the middle block. DO NOT FORCE TOO MUCH or you'll get stuck ^^'

Please keep in mind that this is a "Work in Progress" project, didn't even made "real life tests" for now.

# Things I would like to do on it in the future :
- Get rid of the shaft couplers by using 8mm tube with 5mm or 6mm inside threading
- Modelize a holder for a polaris scope / aligner, that could integrate this design and be easy to use.
