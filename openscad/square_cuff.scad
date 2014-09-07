$fn=120;


module pcb()
{
  color("Green") cube([8.75,18.75,0.8], center=true);
  translate([0,(18.75-2.4)/2,(0.8+4.3)/2]) switch();
}

module switch()
{
  color("Grey") 
  {
    cube([6.9,2.4,4.3], center=true);
    cube([3,3.5,1.5], center=true);
  }
}


module inside()
{
  color("Purple") cube([10,16,8], center=true);
}


module screw_holes(radius=1.25)
{
  rotate([0,0,180]) translate([6,(21-3.)/2,0]) cylinder(h=10,r=radius,center=true);
  rotate([0,0,180]) translate([-6,(21-3.)/2,0]) cylinder(h=10,r=radius,center=true);
  translate([6,(21-3.)/2,0]) cylinder(h=10,r=radius,center=true);
  translate([-6,(21-3.)/2,0]) cylinder(h=10,r=radius,center=true);
}


module top()
{
  difference()
  {
    union()
    {
      // PCB is ~9 by ~19 
      cube([11+1,21+1.0,10], center=true);
      translate([0,0,5.5])
      {
        // Top with boarder cut-out
        difference()
        {
          translate([0,0,-0.25]) cube([11+1,21+1,0.5], center=true);
          cube([6,14,2], center=true);
        }
      }

    }
    translate([0,-1,-1]) cube([9+1,21+1,10], center=true);

    // Light holes
    translate([0,0,5]) cylinder(h=5,r=1.0,center=true);
    translate([0,3.5,5])  cylinder(h=5,r=1.0,center=true);
    translate([0,-3.5,5]) cylinder(h=5,r=1.0,center=true);
    // Button hole
    translate([0,10,1.5]) cube([6,5,3], center=true);
    // Base holes for screws
    translate([-1,-1,1])  translate([1,-(3-21)/2,(-10+2.75)/2]) rotate([90,0,0]) cylinder(h=10,r=0.9,center=true);
//    mirror([1,0,0]) translate([-1,-1,1])  translate([(11-2.5)/2,-(3-21)/2,(-10+2.75)/2]) rotate([90,0,0]) cylinder(h=10,r=0.6,center=true);

   
  }

 
  // Part with holes to screw into
//  side_hole_supports();
//  mirror([1,0,0]) side_hole_supports();

  // Side arms to support pcb step-out
  side_arms();
  mirror([1,0,0]) side_arms();
}


module side_hole_supports()
{
  // Move into the case by 1 mm
  translate([-1,1,1]) 
  translate([(11-2.5)/2,(5-21)/2,(-10+2.75)/2]) difference()
  {
    translate([-0,0,0])  cube([3,5,2.75], center=true);
    translate([0,0,0]) rotate([0,0,45]) translate([0,5,0]) cube([3*2,5*2,2.75*2], center=true);
    rotate([90,0,0]) cylinder(h=10,r=0.6,center=true);
  }
}


module base_holes_support()
{
  // Part with holes to screw into - at base
  translate([-1,-1,1])  translate([(11-2.5)/2,-(3-21)/2,(-10+2.75)/2]) difference()
  {
    cube([3,3,2.75], center=true);
    rotate([90,0,0]) cylinder(h=10,r=0.6,center=true);
  }
}


module side_arms()
{
  // Side arms to support pcb step-out
  translate([(12-4.3)/2,6.5,2]) difference()
  {
    union() 
    {
      translate([0.,0,0])  cube([2.5,4.3,4.3], center=true);
     translate([0,-11.5/2,0]) cube([2.5,11.5,4.3], center=true);
    translate([1,-11.5/2,-2.5]) cube([0.5,11.5,2], center=true);

    }
    rotate([0,0,45]) translate([0,3.5,0]) cube([4.3*2,4.3*2,4.3*2], center=true);
  }
  translate([0,1.6,2]) cube([10,1,1.3], center=true);
  translate([0,-1.9,2]) cube([10,1,1.3], center=true);

  translate([4.75,1,0]) union()
  {
  }
}


module cuffend_oneside()
{
  difference()
  {
    translate([7.5,-.8,0]) rotate([90,0,0]) cylinder(h=2.5, r=10, center=true);
     // +0.1 to make sure manifold
    translate([17.5*2+0.1,-1.,0]) cube([17.5*4,5,17.5*4], center=true);
  }
}

module cuffend()
{
  union()
  {
    cuffend_oneside();
    mirror([1,0,0]) cuffend_oneside();
  }
}


module bottom_()
{
  // base is "squeezed" by brim 
  scale([1, 1.,1])  difference()
  {
    union()
    {
      // scale as bottom is not rotated
      hull()
      {
        translate([0,-0.5,0]) cube([9+1,20+1,0.8], center=true);
        translate([0,0,0.8]) cube([6,6,0.8], center=true);
      }
      // End Wall (l-shape)
      translate([0,-9.8-0.5,-9/2+0.4]) rotate([5,0,0])cube([9+1,0.8,9], center=true);
      // Other end with hole to screw into
      translate([0,9-1+0.5,-1.5]) cube([9+1,3,3], center=true);
      translate([0,0,0.8])
      {
        translate([0,0,(15+0.8)/2]) cylinder(h=15,r=1.5,center=true);
        translate([0,0,0.8]) cylinder(h=1,r1=3, r2=1.5,center=true);
        translate([0,0,15-0.8]) cylinder(h=1,r1=1.2, r2=2.5,center=true);
      }
      difference()
      {
          rotate([0,0,30]) translate([0,0,(15+0.8)])  cube([25,5,2.5	], center=true);
//          translate([0,0,(15+0.8)]) rotate([-90,0,90])  cuffend();
          translate([9+1,0,(15+1)])  cube([9+1,5*5,3*2], center=true);
#          translate([-9-1,0,(15+1)])  cube([9+1,5*5,3*2], center=true);
      }


    }
   // Screw holes 
#  translate([0,10,-1.75]) rotate([90,0,0])  cylinder(h=10,r=0.8,center=true);


//Cruft
//#  translate([3.25,0,-1.75]) rotate([90,0,0])  cylinder(h=40,r=0.6,center=true);
//#  translate([-3.25,0,-1.75]) rotate([90,0,0])  cylinder(h=40,r=0.6,center=true);
//  translate([0,0,0]) screw_holes(radius=0.8);
//  translate([-1,-1,1])  translate([(11-2.5)/2,(3-21)/2,(-10+2.75)/2]) rotate([90,0,0]) cylinder(h=10,r=0.6,center=true);
//  mirror([1,0,0])   translate([-1,-1,1])  translate([(11-2.5)/2,(3-21)/2,(-10+2.75)/2]) rotate([90,0,0]) cylinder(h=10,r=0.6,center=true);

  }
}



module button()
{
  rotate([-90,0,0]) color("Blue") 
  {
    cube([7,3,0.25], center=true);
    translate([0,0,(3-0.25)/2])  cube([5,2,3], center=true);
  }

}

difference()
{
  union()
  {
   top();
//   translate([0,0,-6])  rotate([180,0,180]) bottom_();
   translate([0,0,-4.6])  rotate([180,0,180]) color("Grey") bottom_();
   translate([0,0,-0.75]) pcb();
   translate([0,10.,1])  button();
  }
//  translate([0,-50,-50]) cube([100,100,100]);
  translate([0,-0,-50]) cube([100,100,100]);
}


//!rotate([-90,0,0]) top();
//!rotate([-90,90,0])  bottom_();
//!rotate([90,0,0]) button();
