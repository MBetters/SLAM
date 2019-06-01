# SLAM

[SLAM](https://en.wikipedia.org/wiki/Simultaneous_localization_and_mapping) is the applied theory of how to have an intelligent system draw a map and pinpoint where it is in the map at the same time. The pose graph method accomplishes SLAM by constructing a graph of robot pose vertices (x, y, theta) and then adjusting those vertices until the adjusted edges and the edges measured by scan-matching are optimally close, as measured by nonlinear least squares.

I'm using pipenv (<https://pipenv.readthedocs.io/en/latest/>) to manage this workspace. After installing pipenv, run `pipenv install` in this directory to install dependencies.

To get the data, run...

```bash
chmod +x get_data.sh
./get_data.sh
```

To setup Jupyter, run...

```bash
pipenv shell
python -m ipykernel install --user --name=SLAM
```

To start Jupyter, run...

```bash
pipenv shell
chmod +x serve.sh
./serve.sh localhost 8888
```

Go to the link it gives you and open the `main.ipynb` notebook. Click the `Run` button.

## Resources

- http://carmen.sourceforge.net/FAQ.html
- http://carmen.sourceforge.net/program_carmen.html
- http://carmen.sourceforge.net/repository.html. Useful files:
  - doc/messages.html
  - doc/params.html
  - src/global/global.h
  - src/base/base_messages.h
  - src/laser-new/laser_messages.h
  - src/laser-old/laser_messages.h
  - src/robot/robot_messages.h
  - src/logger/logger_messages.h
  - src/logtools/logtools.h
  - src/param_daemon/param_messages.h
- http://www.cs.cmu.edu/~carmen/other_programs.html
- For the optimization portion: https://github.com/ethz-asl/ai_for_robotics/blob/master/3_0_pgo_icp/solution/pose_graph_optimization/assignment_I_2/pgo_2D.py

## Notes

From http://carmen.sourceforge.net/FAQ.html:

- CARMEN uses SI units internally. 
- All distances are in metres. 
- All angles are in radians.
- All velocities are in metres/second.
- All parameters described in an .ini file should obey this constraint, and any that do not should be considered a bug. The only notable exception is that carmen_map_point_t points are in map grid cells, and should be multiplied by the map resolution (or converted using carmen_map_to_world) to get distances in metres.

From http://carmen.sourceforge.net/program_carmen.html:

- Always represent all units in MKS. 
- All distances are always in metres. All angles are always, always in radians.
- All floating point numbers should be doubles, not floats, and all fixed point numbers should be ints, not chars or shorts. The only known exceptions are large, low-precision data chunks, i.e. laser data and maps.
- All co-ordinate frames, internal and external, are right-handed. This means that q always increases counter-clockwise, from positive x to positive y. This is the opposite of screen graphics. q = 0 always points along the positive x axis.
- There are exactly three allowable co-ordinate frames:
  - The robot's frame of reference: distances are in metres, and the robot always faces along the positive x axis
  - The global frame of reference: distances are in metres, and q = 0 is with respect to a map. This is a meaningless frame of reference without a map.
  - The map frame of reference: distances are in grid cells, and q = 0 is with respect to a map. This is a meaningless frame of reference without a map.
- Never convert between radians and degrees yourself. Always use carmen_radians_to_degrees and carmen_degrees_to_radians.
- Angles are always between -p and p. Never normalize angles yourself. Always use carmen_normalize_theta.
- Never use asin, acos or atan to recover angles distances. Always use atan2 (3).
  - `theta = atan2(y, x);` should always be used instead of `theta = atan(y/x);`

From CARMEN's source code documentation at `docs/messages.html`:

- In all messages, `the distance units` are in `metres`.
- `Angle` measurements are in `radians`, in the range `-pi` to `pi`.
- `Velocity` measurements are in `m/sec`.
- `Timestamp`:
  - It's given as the `number of seconds since the unix epoch`, and is a `double`, where the fractional part is computed from the `tv_usec` field of the `timeval` struct returned by `gettimeofday`.
  - It's the time when the data was first created or acquired.
- `Odometry` measurements:
  - The `x`, `y`, and `theta` fields are the `raw odometry`, from the time the robot was turned on.
  - The `tv` and `rv` fields are the `translational and rotational velocities of the robot`. For robots that have differential drive (as opposed to synchrodrive), these velocities are computed from the left and right wheel velocities that base actual uses.
- `Range` measurements:
  - There is no way to tell from a message itself whether or not the message is a front laser message or a rear laser message. This hopefully will be fixed in a future release.
  - They're in `1 degree increments`.
  - They're the `distance to the nearest obstacle along some heading`.
  - The `first range` is in the `-pi/2` direction in the robot's local frame of reference, where `0` is directly ahead.
  - The `last range` is in the `pi/2-1/180` direction.
  - In degrees, that is from `-90 degs`to `89 degs`.
  - The order is `right-handed` (`counter-clockwise`). This is with reference to a laser that is mounted facing the front of the robot, with the laser right way up.
  - For rear laser messages, the measurements go from `pi/2`, through `pi`, to `-pi/2-1/180`. If you mount the laser upside down, the measurements go from `pi/2`, through `0`, to `-pi/2-1/180`.
  - For forward pointing lasers, usually assume the laser is mounted the right way up.
