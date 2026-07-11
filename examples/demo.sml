(* demo.sml - lunar phase calculations: phase angle, illuminated fraction,
   phase name, lunar age, and next new/full moon epochs from a literal
   Julian Date. Deterministic: identical output on every run and both
   compilers. *)

structure L = Lunar

fun clean x = if Real.== (x, 0.0) then 0.0 else x
fun fmt n x = Real.fmt (StringCvt.FIX (SOME n)) (clean x)

val () = print "sml-lunar demo\n"
val () = print "==============\n\n"

val () = print "Constants:\n"
val () = print ("  synodicMonth     = " ^ fmt 4 L.synodicMonth ^ " days\n")
val () = print ("  anomalisticMonth = " ^ fmt 4 L.anomalisticMonth ^ " days\n")
val () = print ("  meanDistanceKm   = " ^ fmt 1 L.meanDistanceKm ^ " km\n")

val jd = 2460300.0
val () = print ("\nJulian Date jd = " ^ fmt 1 jd ^ "\n")

val age    = L.ageDays jd
val waxing = L.isWaxing jd
val () = print ("  ageDays jd  = " ^ fmt 3 age ^ " days\n")
val () = print ("  isWaxing jd = " ^ Bool.toString waxing ^ "\n")

val ang1 = L.phaseAngle {sunLonDeg = 45.0, moonLonDeg = 200.0}
val ang2 = L.phaseAngle {sunLonDeg = 310.0, moonLonDeg = 100.0}
val () = print ("\n  phaseAngle {sun=45.0, moon=200.0}  = " ^ fmt 2 ang1 ^ " deg\n")
val () = print ("  phaseAngle {sun=310.0, moon=100.0} = " ^ fmt 2 ang2 ^ " deg\n")

val frac1 = L.illuminatedFraction ang1
val frac2 = L.illuminatedFraction ang2
val () = print ("  illuminatedFraction ang1 = " ^ fmt 2 frac1 ^ "\n")
val () = print ("  illuminatedFraction ang2 = " ^ fmt 2 frac2 ^ "\n")

val approxAng   = age / L.synodicMonth * 360.0
val fracFromAge = L.illuminatedFraction approxAng
val name        = L.phaseName (fracFromAge, waxing)
val () = print ("\n  phase (from age) name = " ^ name ^ "\n")

val nnm = L.nextNewMoon jd
val nfm = L.nextFullMoon jd
val () = print ("\n  nextNewMoon jd  = " ^ fmt 3 nnm ^ "\n")
val () = print ("  nextFullMoon jd = " ^ fmt 3 nfm ^ "\n")
