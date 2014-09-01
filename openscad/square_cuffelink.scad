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
      cube([15,23,9], center=true);
      translate([0,0,5])
      {
        // Top with boarder cut-out
        difference()
        {
          translate([0,0,-0.25]) cube([15,23,0.5], center=true);
          cube([6,14,2], center=true);
        }
      }
    }
    translate([0,0,0.5]) cube([10,21,6], center=true);
    translate([0,0,-1]) cube([10,16,9], center=true);
    translate([0,0,-1]) cube([10,16,9], center=true);
    // Extra space for inserting PCB
    translate([0,0,-4]) cube([10,21,5], center=true);

    // Screw holes
  #  translate([0,0,-3.75]) screw_holes(radius=0.60);
    // Light holes
    translate([0,0,5]) cylinder(h=5,r=1.0,center=true);
    translate([0,3.5,5])  cylinder(h=5,r=1.0,center=true);
    translate([0,-3.5,5]) cylinder(h=5,r=1.0,center=true);
    // Button hole
    translate([0,12,1]) cube([6,5,3], center=true);

  }
  // Side arms to support pcb step-out
  side_arms();
  mirror([1,0,0]) side_arms();
}


module side_arms()
{
  // Side arms to support pcb step-out
  translate([(12-4.3)/2,4.3/4,1.25]) difference()
  {
    cube([4.3,4.3,4.3], center=true);
    rotate([0,0,45]) translate([0,4.3,0]) cube([4.3*2,4.3*2,4.3*2], center=true);
  }
}


module cuffend_oneside()
{
  difference()
  {
    translate([14.75,-.8,0]) rotate([90,0,0]) cylinder(h=2.5, r=17.5, center=true);
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
        cube([15,23,0.8], center=true);
        translate([0,0,0.8]) cube([6,6,0.8], center=true);
      }
      translate([0,0,0.8])
      {
        translate([0,0,(15+0.8)/2]) cylinder(h=15,r=1.5,center=true);
        translate([0,0,0.8]) cylinder(h=1,r1=3, r2=1.5,center=true);
        translate([0,0,15-0.8]) cylinder(h=1,r1=1.2, r2=2.5,center=true);
      }
      difference()
      {
//          rotate([0,0,0]) translate([0,0,(15+0.8)])  cube([25,5,2.5	], center=true);
          translate([0,0,(15+0.8)]) rotate([-90,0,90])  cuffend();
          translate([15,0,(15+1)])  cube([15,5*5,3*2], center=true);
          translate([-15,0,(15+1)])  cube([15,5*5,3*2], center=true);
      }
    }
  translate([0,0,0]) screw_holes(radius=0.8);
  }
}



module button()
{
  rotate([-90,0,0]) color("Blue") 
  {
    cube([8,4,0.25], center=true);
    translate([0,0,(5-0.25)/2])  cube([5,2,5], center=true);
  }

}

difference()
{
  union()
  {
   top();
   translate([0,0,-6])  rotate([180,0,180]) bottom_();
   translate([0,0,-1.25]) pcb();
   translate([0,10.,1])  button();
  }
//  translate([0,-50,-50]) cube([100,100,100]);
//  translate([0,-0,-50]) cube([100,100,100]);
}


//!rotate([-90,0,0]) top();
!rotate([-90,90,0])  bottom_();
//!rotate([90,0,0]) button();
