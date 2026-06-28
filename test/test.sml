structure Tests =
struct
  open Harness
  fun close name e a eps = check name (Real.abs (e - a) <= eps)

  fun run () =
  let
    val () = section "illuminatedFraction"
    val () = close "illuminated new (0 deg)"  0.0 (Lunar.illuminatedFraction 0.0)   1e~12
    val () = close "illuminated full (180 deg)" 1.0 (Lunar.illuminatedFraction 180.0) 1e~12
    val () = close "illuminated quarter (90 deg)" 0.5 (Lunar.illuminatedFraction 90.0) 1e~12

    val () = section "phaseAngle"
    val () = close "phaseAngle new->full" 180.0
               (Lunar.phaseAngle {sunLonDeg=0.0, moonLonDeg=180.0}) 1e~12
    val () = close "phaseAngle wraps 350->10" 20.0
               (Lunar.phaseAngle {sunLonDeg=350.0, moonLonDeg=10.0}) 1e~12

    val () = section "phaseName"
    val () = checkString "phaseName new"          ("New",           Lunar.phaseName (0.0, true))
    val () = checkString "phaseName first quarter" ("First Quarter", Lunar.phaseName (0.5, true))
    val () = checkString "phaseName full"          ("Full",          Lunar.phaseName (1.0, true))
    val () = checkString "phaseName waxing crescent" ("Waxing Crescent", Lunar.phaseName (0.25, true))
    val () = checkString "phaseName waning gibbous"  ("Waning Gibbous",  Lunar.phaseName (0.75, false))

    val () = section "ageDays"
    val age0 = Lunar.ageDays 2451550.1
    val () = close "ageDays at epoch ~ 0" 0.0 age0 0.01
    val age1 = Lunar.ageDays 2451560.0
    val () = check "ageDays in [0, synodicMonth)" 
               (age1 >= 0.0 andalso age1 < Lunar.synodicMonth)

    val () = section "isWaxing"
    val () = checkBool "isWaxing at epoch" (true, Lunar.isWaxing 2451550.1)

    val () = section "nextNewMoon"
    val nnm = Lunar.nextNewMoon 2451550.1
    val () = close "nextNewMoon after epoch ~ epoch + synodic" 
               (2451550.1 + Lunar.synodicMonth) nnm 0.01

    val () = section "nextFullMoon"
    val nfm = Lunar.nextFullMoon 2451550.1
    val () = close "nextFullMoon after new moon ~ 14.77 days later"
               14.765 (nfm - 2451550.1) 0.1

  in Harness.run () end
end
