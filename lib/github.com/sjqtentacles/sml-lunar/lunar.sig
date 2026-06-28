signature LUNAR =
sig
  val synodicMonth    : real   (* 29.530588853 days *)
  val anomalisticMonth : real  (* 27.554549878 days *)
  val meanDistanceKm  : real   (* 384400.0 km *)

  (* Phase angle in degrees given Sun and Moon ecliptic longitudes (degrees) *)
  val phaseAngle : {sunLonDeg:real, moonLonDeg:real} -> real

  (* Illuminated fraction (0=new, 1=full) from phase angle in degrees *)
  val illuminatedFraction : real -> real

  (* Phase name from (fraction, waxing:bool): "New","Waxing Crescent","First Quarter",
     "Waxing Gibbous","Full","Waning Gibbous","Last Quarter","Waning Crescent" *)
  val phaseName : real * bool -> string

  (* Lunar age in days since last new moon, from Julian Date.
     Uses reference new moon at JD 2451550.1 (2000-01-06.6) *)
  val ageDays : real -> real

  (* Is the Moon waxing at this JD? (age < synodicMonth/2) *)
  val isWaxing : real -> bool

  (* Next new moon JD after the given JD *)
  val nextNewMoon : real -> real

  (* Next full moon JD after the given JD *)
  val nextFullMoon : real -> real
end
