structure Lunar :> LUNAR =
struct
  val synodicMonth     = 29.530588853
  val anomalisticMonth = 27.554549878
  val meanDistanceKm   = 384400.0
  val newMoonEpoch     = 2451550.1  (* JD of known new moon 2000-01-06.6 *)

  fun phaseAngle {sunLonDeg, moonLonDeg} =
    let val d = moonLonDeg - sunLonDeg
        val n = Real.fromInt (floor (d / 360.0))
        val r = d - 360.0 * n
    in if r < 0.0 then r + 360.0 else r end

  fun illuminatedFraction ang =
    (1.0 - Math.cos (ang * Math.pi / 180.0)) / 2.0

  fun phaseName (frac, waxing) =
    if frac < 0.02 then "New"
    else if frac < 0.48 andalso waxing then "Waxing Crescent"
    else if frac < 0.52 andalso waxing then "First Quarter"
    else if frac < 0.98 andalso waxing then "Waxing Gibbous"
    else if frac > 0.98 then "Full"
    else if frac > 0.52 then "Waning Gibbous"
    else if frac > 0.48 then "Last Quarter"
    else "Waning Crescent"

  fun ageDays jd =
    let val elapsed = jd - newMoonEpoch
        val n = Real.fromInt (floor (elapsed / synodicMonth))
        val age = elapsed - n * synodicMonth
    in if age < 0.0 then age + synodicMonth else age end

  fun isWaxing jd = ageDays jd < synodicMonth / 2.0

  fun nextNewMoon jd =
    let val age = ageDays jd
        val remaining = synodicMonth - age
    in jd + remaining end

  fun nextFullMoon jd =
    let val age = ageDays jd
        val halfMonth = synodicMonth / 2.0
        val toFull = if age < halfMonth then halfMonth - age
                     else halfMonth + (synodicMonth - age)
    in jd + toFull end
end
