#!/bin/bash

# Start X virtual framebuffer in the background
/usr/bin/Xvfb :99 2>/dev/null &

DISPLAY=:99 make test
RESULT=$?

# Stop all background processes
kill $(jobs -p)

# Return the make test exit code
exit $RESULT
