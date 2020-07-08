//
// 3D printed *Generic* EQ mount
// for OnStep Integration
//

$fn=300;

w_th=12;
print_gap=2;
nema17_size=42;

nema_hole_dist=21.920310216782973;
nema_hole_dia=3;

gear_hole_dist=35/2;
gear_hole_dia=5;

// 184mm GT2
//axis_pulley_dist=36.94;
// corrected value mesured apon reception of belts & pulleys
//axis_pulley_dist=36.82;
// re-mesured (second attempt)
axis_pulley_dist=37.32;

// min : 182mm GT2
//axis_pulley_dist=35.75;

// 186mm GT2
//axis_pulley_dist=38.1;
axis_dia=9.5;

KFL08_h=12;
KFL08_l=48;
KFL08_w=27;

nema_h=46.5;
OKD42_h=53;

insert_5mm_od=6.3;
insert_4mm_od=5.2;

eqblockDEC1_h=nema_h+OKD42_h-KFL08_h;

rj45_x=15;
rj45_y=13;
rj45_z=18;

module rotate_at(rotation, coord) {
  translate(coord)
    rotate(rotation)
    translate(-coord)
    children();
}

module planetary_gearbox_OKD42(len, with_holes=0) {
  plate_h=5;
  cyl_r=21;
  cshaft_l=2;
  cshaft_r=12.5;
  shaft_r=4;
  shaft_l=21.6;

  difference()
    {
      union()
      {	
	difference()
	  {
	    translate([0, 0, plate_h/2]) cube([42, 42, plate_h], center=true);
	    union()
	    {
	      for (a=[45,135,225, 315])
		rotate([0, 0, a]) translate([0, 29.69, 3]) cube([10, 7.6, 10], center=true);
	    }
	  }
// 	translate([0, 0, plate_h/2]) cylinder(r=cyl_r,  h=len);
// 	translate([0, 0, plate_h/2+len]) cylinder(r=cshaft_r,  h=cshaft_l);
// 	translate([0, 0, plate_h/2+len+cshaft_l]) cylinder(r=shaft_r,  h=shaft_l);

	translate([0, 0, 0]) cylinder(r=cyl_r,  h=len);
	translate([0, 0, len]) cylinder(r=cshaft_r,  h=cshaft_l);
	translate([0, 0, len+cshaft_l]) cylinder(r=shaft_r,  h=shaft_l);

      }
	union()
	{
	  if (with_holes==1)
	    {
	      for (a=[45, 135, 225, 315])
		{
		  rotate([0, 0, a]) translate([0, nema_hole_dist, -0.01]) cylinder(r=nema_hole_dia/2, h=plate_h+0.02);
		  rotate([0, 0, a]) translate([0, nema_hole_dist, plate_h/2]) cylinder(r=nema_hole_dia, h=plate_h+plate_h/2+0.02);
		  rotate([0, 0, a]) translate([0, gear_hole_dist, len-plate_h*2]) cylinder(r=gear_hole_dia/2, h=plate_h+len+0.02);
		}
	    }
	}
    }
}

module planetary_gearbox(len, with_holes=0)
{
  planetary_gearbox_OKD42(len, with_holes);
}

module nema17_geared(gearlen,with_holes=0) {
  import("./Nema17_48h.stl");
    if (with_holes == 0)
    {
      // renoving nema stl holings ...
      for (a=[45, 135, 225, 315])
	{
	  rotate([0, 0, a]) translate([0, nema_hole_dist, nema_h-12-0.01]) cylinder(r=nema_hole_dia/2+1, h=12+0.02);
	  //rotate([0, 0, a]) translate([0, nema_hole_dist, plate_h/2]) cylinder(r=nema_hole_dia, h=plate_h+plate_h/2+0.02);
	  //	  rotate([0, 0, a]) translate([0, gear_hole_dist, len-plate_h*2]) cylinder(r=gear_hole_dia/2, h=plate_h+len+0.02);
	}
    }
  translate([0, 0, nema_h]) planetary_gearbox(gearlen, with_holes);
}

module nema17() {
  import("./Nema17_48h.stl");
}


module EQBlockDECbottom()
{
  top_h=18;
  //  translate([nema23_hole_dist/2, nema23_hole_dist/2, 0]) cylinder(r=3, h=130);
  echo("eqblockDEC1_h=",top_h);
  difference()
    {
      union()
      {
	difference()
	  {
	    union()
	    {
	      translate([-nema17_size/2-w_th, -nema17_size/2-w_th, 0]) cube([nema17_size+w_th*2, nema17_size+w_th*2, top_h]);
	      translate([0, (nema17_size+w_th)/2-4, 0]) cylinder(r=(nema17_size+w_th+7)/2, h=top_h);
	      translate([-(rj45_x+16.9)/2, -nema17_size/2-1, -0.01]) rotate([90,0,0]) cube([rj45_x+16.9,top_h,rj45_z+0.02]);
	      //	      translate([0, (nema17_size+w_th)/2, 0]) cylinder(r=(nema17_size+w_th)/2, h=top_h);
	    }
	    union()
	    {
	      for (a=[45, 135, 225, 315])
		  rotate([0, 0, a]) translate([0, 34,-0.01]) cylinder(r=3, h=top_h+w_th+20);
	      for (a=[45, 135, 225, 315])
		  rotate([0, 0, a]) translate([-4.75, 42,-0.01]) cube([9.5,9.5,top_h+w_th+20]);
	    }
	  }
	//	translate([0, (nema17_size+w_th)/2-1, 0]) cylinder(r=(nema17_size+w_th+4)/2, h=top_h);
	rotate_at([0,0, 29.05], [nema17_size/2+w_th, nema17_size/2+5.4, 0]) translate([nema17_size/2+w_th-5, nema17_size/2+5.4, 0]) cube([5,13, top_h]);
	rotate_at([0,0, -29.05], [-nema17_size/2-w_th, nema17_size/2+5.4, 0]) translate([-nema17_size/2-w_th, nema17_size/2+5.4, 0]) cube([5,13, top_h]);
      }
      union()
      {
	translate([0, 0, -0.01-print_gap]) cylinder(r=axis_dia/2+3, h=nema_h+OKD42_h+w_th*2+0.02);
	translate([0, axis_pulley_dist, -0.01-print_gap]) cylinder(r=axis_dia/2, h=nema_h+OKD42_h+w_th*2+0.02);
	translate([0, axis_pulley_dist, -0.01-print_gap]) resize([KFL08_l+print_gap,0,0], auto=true) KFL08(5);
	translate([0, 0, -0.01-eqblockDEC1_h-1.7-print_gap]) resize([nema17_size+print_gap,0,0], auto=true) nema17_geared(OKD42_h);
	for (a=[45, 135, 225, 315])
	  rotate([0, 0, a]) translate([0, gear_hole_dist, 0]) cylinder(r=gear_hole_dia/2, h=top_h+0.02);
	//translate([-5, -nema17_size/2-5, -0.01]) cube([10,4,top_h+0.02]);
	translate([-rj45_x/2-0.5, -nema17_size/2+1.3-0.01, -0.02]) rotate([90,0,0]) cube([rj45_x+1,rj45_y+3,rj45_z+5+0.02]);
	translate([-(28.5/2), -nema17_size+3.2-0.02, -0.02]) 
	  {
	    difference()
	      {
		cube([28.5,18.5, 2.5]);
		union()
		{
		  translate([3.17, 8.89+0.5, -0.02]) cylinder(r=1.91, h=3);
		  translate([24.77, 8.89+0.5, -0.02]) cylinder(r=1.91, h=3);
		}
	      }
	  }
      }
    }
  //  translate([-rj45_x/2, -nema17_size/2-1-0.01, 1.6]) rotate([90,0,0]) cube([rj45_x,rj45_y,rj45_z]);
}


module EQBlockDECtop()
{
  top_h=18;
  echo("eqblockDEC1_h=",top_h);

  // translate([0,0, -top_h])
  rotate([0, 180, 0])
  difference()
    {
      union()
      {
	difference()
	  {
	    union()
	    {
	      translate([-nema17_size/2-w_th, -nema17_size/2-w_th, 0]) cube([nema17_size+w_th*2, nema17_size+w_th*2, top_h]);
	      translate([0, (nema17_size+w_th)/2-4, 0]) cylinder(r=(nema17_size+w_th+7)/2, h=top_h);
	    }
	    union()
	    {
	      for (a=[45, 135, 225, 315])
		  rotate([0, 0, a]) translate([0, 34,-0.01]) cylinder(r=3, h=top_h+w_th+20);
	      for (a=[45, 135, 225, 315])
		  rotate([0, 0, a]) translate([-4.75, 42,-0.01]) cube([9.5,9.5,top_h+w_th+20]);
	    }
	  }
	rotate_at([0,0, 29.05], [nema17_size/2+w_th, nema17_size/2+5.4, 0]) translate([nema17_size/2+w_th-5, nema17_size/2+5.4, 0]) cube([5,13, top_h]);
	rotate_at([0,0, -29.05], [-nema17_size/2-w_th, nema17_size/2+5.4, 0]) translate([-nema17_size/2-w_th, nema17_size/2+5.4, 0]) cube([5,13, top_h]);
      }
      union()
      {
	translate([0, axis_pulley_dist, -0.01-print_gap]) cylinder(r=axis_dia/2, h=nema_h+OKD42_h+w_th*2+0.02);
	translate([0, axis_pulley_dist, -0.01-print_gap]) resize([KFL08_l+print_gap,0,0], auto=true) KFL08(5);
      }
    }
}


module EQBlockDECtop2()
{
  top_h=22;
  width=3;
  //  translate([nema23_hole_dist/2, nema23_hole_dist/2, 0]) cylinder(r=3, h=130);
  echo("eqblockDEC1_h=",top_h);
  difference()
    {
      union()
      {
	difference()
	  {
	    union()
	    {
	      translate([-nema17_size/2-w_th, -nema17_size/2-w_th, 0]) cube([nema17_size+w_th*2, nema17_size+w_th*2, top_h]);
	      translate([0, (nema17_size+w_th)/2-4, 0]) cylinder(r=(nema17_size+w_th+7)/2, h=top_h);
	      //	      translate([0, (nema17_size+w_th)/2, 0]) cylinder(r=(nema17_size+w_th)/2, h=top_h);
	    }
	    union()
	    {
	      for (a=[135, 225])
		  rotate([0, 0, a]) translate([0, 34,-0.01]) cylinder(r=3, h=top_h+w_th+20);
	      for (a=[45, 135, 225, 315])
		  rotate([0, 0, a]) translate([-4.75, 42,-0.01]) cube([9.5,9.5,top_h+w_th+20]);
	    }
	  }
	//	translate([0, (nema17_size+w_th)/2-1, 0]) cylinder(r=(nema17_size+w_th+4)/2, h=top_h);
	rotate_at([0,0, 29.05], [nema17_size/2+w_th, nema17_size/2+5.4, 0]) translate([nema17_size/2+w_th-5, nema17_size/2+5.4, 0]) cube([5,13, top_h]);
	rotate_at([0,0, -29.05], [-nema17_size/2-w_th, nema17_size/2+5.4, 0]) translate([-nema17_size/2-w_th, nema17_size/2+5.4, 0]) cube([5,13, top_h]);
      }
      union()
      {
	translate([0,0,-0.01]) cylinder(r=21, h=top_h-width);
	translate([0, axis_pulley_dist, -0.01]) cylinder(r=axis_dia/2, h=nema_h+OKD42_h+w_th*2+0.02);
	//translate([0, axis_pulley_dist, -0.01]) resize([KFL08_l+print_gap,0,0], auto=true) KFL08(5);
	//translate([0, 0, -0.01-eqblockDEC1_h-1.7]) resize([nema17_size+print_gap,0,0], auto=true) nema17_geared(OKD42_h);
// 	for (a=[45, 135, 225, 315])
// 	  rotate([0, 0, a]) translate([0, gear_hole_dist, 0]) cylinder(r=gear_hole_dia/2, h=top_h+0.02);
	translate([-5, -nema17_size/2-5, -0.01]) cube([10,4,top_h+0.02]);
	translate([-rj45_x/2, -nema17_size/2-5, -0.01]) cube([rj45_x,rj45_y,top_h+0.02]);
	p_x=15.1;
	p_y=6;
	rotate_at([0,0,-14], [p_x+5,-p_y,0]) translate([p_x,-p_y,-0.01]) cube([5,nema17_size*2, top_h-width+0.02]);
	rotate_at([0,0,14], [-p_x,-p_y,0]) translate([-p_x-5+0.19,-p_y,-0.01]) cube([5,nema17_size*2, top_h-width+0.02]);
      }
    }
  p_x=15.1;
  p_y=6;
  //  rotate_at([0,0,14], [-p_x,-p_y,0]) translate([-p_x-5,-p_y,-0.01]) cube([5,nema17_size*2, top_h-width+0.02]);
}

module EQBlockDEC1()
{
  //  translate([nema23_hole_dist/2, nema23_hole_dist/2, 0]) cylinder(r=3, h=130);
  echo("eqblockDEC1_h=",eqblockDEC1_h);
  difference()
    {
      union()
      {
	difference()
	  {
	    union()
	    {
	      translate([-nema17_size/2-w_th, -nema17_size/2-w_th, 0]) cube([nema17_size+w_th*2, nema17_size+w_th*2, eqblockDEC1_h]);
	      translate([0, (nema17_size+w_th)/2-4, 0]) cylinder(r=(nema17_size+w_th+7)/2, h=eqblockDEC1_h);
	      translate([0,  -(nema17_size+w_th*2)/2-2-5.0292, 0]) arca_swiss_plate(eqblockDEC1_h);
	    }
	    union()
	    {
	      for (a=[45, 135, 225, 315])
		  rotate([0, 0, a]) translate([0, 34,-0.01]) cylinder(r=3, h=eqblockDEC1_h+w_th+20);
	      for (a=[135, 225])
		  rotate([0, 0, a]) translate([-4.75, 42,-0.01]) cube([9.5,9.5,eqblockDEC1_h+w_th+20]);
	      for (a=[45, 315])
		  rotate([0, 0, a]) translate([-4.75, 42,-0.01]) cube([9.5,9.5,eqblockDEC1_h+w_th+20]);
// 	      translate([0, -nema17_size/3, (nema_h+OKD42_h)/2+17]) rotate([90,0,0]) cylinder(r=insert_4mm_od/2, h=w_th*2);
// 	      translate([0, -nema17_size/3, (nema_h+OKD42_h)/2-17]) rotate([90,0,0]) cylinder(r=insert_4mm_od/2, h=w_th*2);
	    }
	  }

	rotate_at([0,0, 29.05], [nema17_size/2+w_th, nema17_size/2+5.4, 0]) translate([nema17_size/2+w_th-5, nema17_size/2+5.4, 0]) cube([5,13, eqblockDEC1_h]);
	rotate_at([0,0, -29.05], [-nema17_size/2-w_th, nema17_size/2+5.4, 0]) translate([-nema17_size/2-w_th, nema17_size/2+5.4, 0]) cube([5,13, eqblockDEC1_h]);
      }
      union()
      {
	translate([0, 0, -0.01]) resize([nema17_size+print_gap,0,0], auto=true) nema17_geared(OKD42_h);
	translate([0, axis_pulley_dist, -0.01]) cylinder(r=axis_dia/2, h=nema_h+OKD42_h+w_th*2+0.02);
	translate([18, axis_pulley_dist, -0.01]) cylinder(r=5/2, h=nema_h+OKD42_h+w_th*2+0.02);
	translate([-18, axis_pulley_dist, -0.01]) cylinder(r=5/2, h=nema_h+OKD42_h+w_th*2+0.02);
	translate([-6, -nema17_size/2-3, -0.01]) cube([12,5,eqblockDEC1_h+KFL08_h+50]);
	//	translate([-80/2, 0, 12]) rotate([0, 90, 0]) myrc([60,30,80], 15);
	translate ([0,0,-5+0.01]) union()
	  {
	    translate([-5, -nema17_size/2-1-10, eqblockDEC1_h]) cylinder(r=2,h=4);
	    translate([5, -nema17_size/2-1-10, eqblockDEC1_h]) cylinder(r=2,h=4);
	    translate([-5, -nema17_size/2-1-10, eqblockDEC1_h]) cylinder(r=2,h=5);
	    translate([5, -nema17_size/2-1-10, eqblockDEC1_h]) cylinder(r=2,h=5);
	  }
      }
    }
}


module KFL08(carve=0)
{
  difference()
    {
      union()
      {
	rotate([0,0, 28]) translate([0, 27/2,0]) translate([-16, -5,0]) cube([16, 5,5+0.02+(carve ? 8 : 0)]);
	rotate([0,0, -28]) translate([0, 27/2,0]) translate([0, -5,0]) cube([16, 5,5+0.02+(carve ? 8 : 0)]);
	rotate([0,0, 28]) translate([0, -27/2,0]) translate([0, 0,0]) cube([16, 5,5+0.02+(carve ? 8 : 0)]);
	rotate([0,0, -28]) translate([0, -27/2,0]) translate([-16, 0,0]) cube([16, 5,5+0.02+(carve ? 8 : 0)]);
	translate([18,0,0]) cylinder(r=5.1, h=5+0.02+0.5+carve+(carve ? 3 : 0));
	translate([-18,0,0]) cylinder(r=5.1, h=5+0.02+0.5+carve+(carve ? 3 : 0));	
	translate([-18, -5,0]) cube([36, 10,5.5+0.02+carve]);
	cylinder(r=27/2, h=8.5+(carve ? 5 : 0));
	cylinder(r=12/2 + (carve ? 1 : 0), h=12);
      }
      union()
      {
	translate([0,0,-0.01]) cylinder(r=4, h=12+0.02);
	if (carve == 0)
	  {
	    translate([18,0,-0.01]) cylinder(r=2.5, h=12+0.02);
	    translate([-18,0,-0.01]) cylinder(r=2.5, h=12+0.02);
	  }
      }
    }
}


module dovetail()
{
  dovetail_points = [
		     [0, 0, 0],			//0
		     [38.5, 0, 0],		//1
		     [38.5, 0, eqblockDEC1_h],	//2
		     [0, 0, eqblockDEC1_h],	//3
		     [-5, -15.5, 0],		//4
		     [43.5, -15.5, 0],		//5
		     [43.5, -15.5, eqblockDEC1_h],	//6
		     [-5, -15.5, eqblockDEC1_h],	//7
		     ];

  dovetail_faces = [
		    [0,1,2,3],  // bottom
		    [4,5,1,0],  // front
		    [7,6,5,4],  // top
		    [5,6,2,1],  // right
		    [6,7,3,2],  // back
		    [7,4,0,3]]; // left

  translate([38.5/2,0,0]) rotate([0,0,180]) polyhedron(dovetail_points, dovetail_faces);
}

module	GT2_pulley_80T()
{

  difference()
    {
      union()
      {
	cylinder(r=22/2, h=7);
	translate([0,0,7]) cylinder(r=55/2, h=2);
	translate([0,0,7+2]) cylinder(r=50.42/2, h=7);
	translate([0,0,7+2+7]) cylinder(r=55/2, h=2);
      }
      union()
      {
	translate([0,0,-0.01]) cylinder(r=8/2, h=20);
	translate([0,0, 4/2+1.5]) rotate([90,0,0]) cylinder(r=4/2, h=20);
	translate([0,0, 4/2+1.5]) rotate([0,90,0]) cylinder(r=4/2, h=20);

      }
    }
}

module EQBlockDEC_sim()
{
  echo ("bar is ", eqblockDEC1_h+KFL08_h+50);
  translate([0,0, eqblockDEC1_h])
  rotate([180,0,0])
    {
      translate([0, axis_pulley_dist, -25]) cylinder(r=8/2,h=eqblockDEC1_h+KFL08_h+50);
      translate([0, axis_pulley_dist, 0.01+eqblockDEC1_h]) KFL08();
  //translate([0, axis_pulley_dist, 0.01+eqblockDEC1_h+KFL08_h+4+1+19.5]) rotate([180,0,0]) GT2_pulley_80T();
  //  translate([0, 0, 0.01+nema_h+OKD42_h+5+1+17.5]) rotate([180,0,0]) GT2_pulley_20T();
      translate([0, axis_pulley_dist, 0.01+eqblockDEC1_h+KFL08_h+4+0.5+1.8]) GT2_pulley_80T();
      translate([0, 0, 0.01+nema_h+OKD42_h+5+0.5+1.8]) GT2_pulley_20T();
      EQBlockDEC1();
      nema17_geared(OKD42_h,1);
      translate([0, axis_pulley_dist, 0]) rotate([180,0,0]) KFL08();
      //translate([0,0, eqblockDEC1_h]) EQBlockDECbottom();
      //      EQBlockDECtop();
    }
}

module	GT2_pulley_20T()
{
  difference()
    {
      union()
      {
	cylinder(r=16/2, h=8);
	translate([0,0, 8]) cylinder(r=12.22/2, h=7);
	translate([0,0, 8+7]) cylinder(r=16/2, h=1);
      }
      union()
      {
	translate([0,0,-0.01]) cylinder(r=8/2, h=18);
	translate([0,0, 4/2+2]) rotate([90,0,0]) cylinder(r=4/2, h=20);
	translate([0,0, 4/2+2]) rotate([0,90,0]) cylinder(r=4/2, h=20);
      }
    }
}


module arca_swiss_plate(z)
{
  base_x=41.9;
  base_h=5.0292;
  cutoff_x=38.1;
  difference()
    {
      translate([-base_x/2,0,0]) cube([base_x, base_h, z]);
      union()
      {
	rotate_at([0,0,-45], [-base_x/2,0,0]) translate([-base_x/2-base_h*2,0,-0.01]) cube([base_h*2,base_h*2,z+0.02]);
	rotate_at([0,0, 45], [base_x/2,0,0]) translate([base_x/2,0,-0.01]) cube([base_h*2,base_h*2,z+0.02]);
	translate([-cutoff_x/2-base_h*2,-0.01,-0.01]) cube([base_h*2,base_h*2,z+0.02]);
	translate([cutoff_x/2,-0.01,-0.01]) cube([base_h*2,base_h*2,z+0.02]);
      }
    }
  translate([-(base_x-base_h*2)/2, base_h, 0]) cube([base_x-base_h*2, 2, z]);
}

module holing_tests()
{
  z=8;
  difference()
    {
      cube([35,35,z]);
      translate([0,0,-0.01]) union()
      {
	// hole for gearbox fixation (M3 screws)
	translate([10,10,0]) cylinder(r=gear_hole_dia/2, h=z+1);
	// holes for DEC main fixation (M5 screws)
	translate([25,25,0]) cylinder(r=3, h=z+1);
	// holes for axis / KFL08 holding (M4 screws)
	translate([10,25,0]) cylinder(r=5/2, h=z+1);
	// holes for axis (M8 rod)
	translate([25,10,0]) cylinder(r=axis_dia/2, h=z+1);
      }
    }
}

module bottom_test()
{
  test_h=8;
  difference()
    {
      EQBlockDEC1();
      translate([-42,-42,test_h]) cube([eqblockDEC1_h+20,eqblockDEC1_h+20,eqblockDEC1_h]);
    }
}

module upper_test()
{
  test_h=8;
  difference()
    {
      EQBlockDEC1();
      translate([-42,-42,-test_h]) cube([eqblockDEC1_h+20,eqblockDEC1_h+20,eqblockDEC1_h]);
    }
}

module myrc(size, radius)
{
  x = size[0];
  y = size[1];
  z = size[2];

  xin = x - radius;
  yin = y - radius;
  translate([-x/2+radius, -y/2+radius, 0]) cylinder(h=z, r=radius);
  translate([x/2-radius, -y/2+radius, 0]) cylinder(h=z, r=radius);
  translate([-x/2+radius, y/2-radius, 0]) cylinder(h=z, r=radius);
  translate([x/2-radius, y/2-radius, 0]) cylinder(h=z, r=radius);
  translate([-(x-radius)/2, -(y-radius)/2, 0]) cube([x-radius, y-radius, z]);
  translate([-(x)/2, -(y-radius*2)/2, 0]) cube([radius, y-(radius*2), z]);
  translate([(x-radius*2)/2, -(y-radius*2)/2, 0]) cube([radius, y-(radius*2), z]);
  translate([(-x+radius*2)/2, -y/2, 0]) cube([x-(radius*2), radius, z]);
  translate([(-x+radius*2)/2, (y-radius*2)/2, 0]) cube([x-(radius*2), radius, z]);
  //  translate([-(x)/2, -(y-radius*2)/2, 0]) cube([x-(radius*2), radius, z]);
}

module printable_EQBlockDEC1()
{
  translate([0, 0, eqblockDEC1_h]) rotate([180, 0, 0]) EQBlockDEC1();
}


module printable_EQBlockDECtop()
{
  translate([0,0, 18]) EQBlockDECtop();
}

module printable_EQBlockDECbottom()
{
  translate([0,0, 18]) rotate([180, 0, 0]) EQBlockDECbottom();
}

module simulation()
{
   translate([0,0,eqblockDEC1_h]) rotate([180,0,0]) EQBlockDECtop();
   rotate([180,0,0]) EQBlockDECbottom();
   translate([0,0,eqblockDEC1_h]) rotate([180,0,0]) EQBlockDEC1();
}

simulation();

//holing_tests();

//bottom_test();

//printable_EQBlockDEC1();
//EQBlockDEC1();
//EQBlockDEC_sim();
//translate([0,0,87.6]) EQBlockDECtop();

//printable_EQBlockDECtop();
//printable_EQBlockDECbottom();
//
// EQBlockDECbottom();
//translate([0,0,87.6])
//rotate([180,0,0]) EQBlockDECtop();
//EQBlockDECtop2();
//GT2_pulley_20T();
//
//KFL08(5);
//translate([0, axis_pulley_dist, 0.01+eqblockDEC1_h]) KFL08();
//translate([0, axis_pulley_dist, 0.01+eqblockDEC1_h+KFL08_h]) GT2_pulley_80T();
//translate([0,0,eqblockDEC1_h]) rotate([180,0,0])
//EQBlockDEC1();
//translate([0,nema17_size/2+w_th,0]) dovetail();
//nema17_geared(OKD42_h,0);
//nema17_geared(OKD42_h);
//planetary_gearbox(OKD42_h);
//cube([10,10,10]);
