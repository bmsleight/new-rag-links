$fn=60;


module pcb()
{
  color("Green") cube([9,19,1.8], center=true);
}

module inside()
{
  color("Purple") cube([10,16,8], center=true);
}


module screw_holes(radius=1.25)
{
#  translate([0,(24-3.5)/2,0]) cylinder(h=2.5,r=radius,center=true);
  rotate([0,0,180]) translate([0,(24-3.5)/2,0]) cylinder(h=2.5,r=radius,center=true);
}

module light_hoods()
{
  difference()
  {
    cylinder(h=1,r=2,center=true);
//    cylinder(h=5,r=1.5,center=true);
    translate([0,0,1]) rotate([-25,0,0]) cylinder(h=2,r1=3,r2=3,center=true);
  }

}


module top()
{
  difference()
  {
    union()
    {
      cube([12,24,9], center=true);
      translate([0,0,5])
      {
        // Light holes hoods    
 //       translate([0,0,0]) light_hoods();
 //       translate([0,5,0])  light_hoods();
 //       translate([0,-5,0]) light_hoods();
        difference()
        {
          translate([0,0,-0.25]) cube([12,24,0.5], center=true);
          cube([6,18,2], center=true);
        }
      }
    }
    translate([0,0,0.5]) cube([10,22,6], center=true);
    translate([0,0,-1]) cube([10,17,9], center=true);
    translate([0,0,-1]) cube([10,17,9], center=true);
    // Screw holes
 #   translate([0,0,-3.75]) screw_holes(radius=0.80);
    // Light holes
    translate([0,0,5]) cylinder(h=5,r=1.25,center=true);
    translate([0,5,5])  cylinder(h=5,r=1.25,center=true);
    translate([0,-5,5]) cylinder(h=5,r=1.25,center=true);
    // Button hole
    translate([0,12,1]) cube([6,5,3], center=true);

  }
  // thin layer to support hoods
//  translate([0,0,3.5-0.1]) cube([12,24,0.2], center=true);

}

module bottom()
{
  // base is "squeezed" by brim 
  scale([0.95, 0.95,1])  difference()
  {
    union()
    {
      // scale as bottom is not rotated
      cube([12,24,1], center=true);
      translate([0,0,(10+1)/2]) cylinder(h=10,r=2,center=true);
      translate([0,0,(10+1/2+7.5/2)]) cylinder(h=7.5,r1=2, r2=4,center=true);
      translate([0,0,1]) cylinder(h=1,r1=3, r2=2,center=true);
    }
  translate([0,0,0]) screw_holes();
  }
}

difference()
{
  union()
  {
//    bottom();
    top();
    pcb();
   //translate([0,0,-0.5]) inside();
  }
  translate([0,0,-50]) cube([100,100,100]);
}


//!rotate([-90,0,0]) top();
//!bottom();