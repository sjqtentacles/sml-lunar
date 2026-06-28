# sml-lunar

A zero-dependency Standard ML library for simplified lunar phase calculations. Computes phase angle, illuminated fraction, phase name, lunar age, and next new/full moon times — all from Julian Date, using a synodic month model.

## API

| Function/Value | Description |
|---|---|
| `synodicMonth : real` | Synodic (lunar) month: 29.530588853 days |
| `anomalisticMonth : real` | Anomalistic month: 27.554549878 days |
| `meanDistanceKm : real` | Mean Earth–Moon distance: 384400.0 km |
| `phaseAngle {sunLonDeg, moonLonDeg}` | Phase angle (0–360°) from ecliptic longitudes |
| `illuminatedFraction ang` | Illuminated fraction (0=new, 1=full) from phase angle in degrees |
| `phaseName (frac, waxing)` | Phase name string from fraction and waxing flag |
| `ageDays jd` | Lunar age in days since last new moon, for Julian Date `jd` |
| `isWaxing jd` | True if Moon is waxing at `jd` |
| `nextNewMoon jd` | Julian Date of next new moon after `jd` |
| `nextFullMoon jd` | Julian Date of next full moon after `jd` |

## Worked Example

```sml
val jd   = 2460000.0
val age  = Lunar.ageDays jd
val frac = Lunar.illuminatedFraction (age / Lunar.synodicMonth * 360.0)
val name = Lunar.phaseName (frac, Lunar.isWaxing jd)
val nnm  = Lunar.nextNewMoon jd
```

## Scope and Limitations

This library uses a fixed reference epoch (JD 2451550.1) and a constant synodic month. It does **not** account for the Moon's varying orbital speed, parallax, libration, or the perturbations that cause actual new/full moon times to deviate from the mean by up to ±14 hours. For high-accuracy predictions use an ephemeris-based approach.

## Install / Build / Test

```
$ cd sml-lunar
$ make all-tests
```
