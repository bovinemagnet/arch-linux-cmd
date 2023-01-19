#!/usr/bin/env bash

# MIT License
#
# Copyright (c) 2023 Paul
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

## Check if sourced
[[ $0 != "$BASH_SOURCE" ]] && sourced=1 || sourced=0[1]

## Check for zing directory exists
if [ -d "/usr/lib/jvm/zing-8/bin" ] && [ -v "${USE_ZING}" ]; then
	export PATH="/usr/lib/jvm/zing-8/bin/:$PATH"
	export JAVA_HOME="/usr/lib/jvm/zing-8"
else
	## Check for zulu directory exists
	if [ -d "/usr/lib/jvm/zulu-8/bin" ]; then
		export PATH="/usr/lib/jvm/zulu-8/bin/:$PATH"
		export JAVA_HOME="/usr/lib/jvm/zulu-8"
	else
		## Check for open JDK
		if [ -d "/usr/lib/jvm/java-8-openjdk/bin" ]; then
			export PATH="/usr/lib/jvm/java-8-openjdk/bin/:$PATH"
			export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"
		else
			## Check if java-8-amazon-corretto is installed
			if [ -d "/usr/lib/jvm/java-8-amazon-corretto/bin" ]; then
				export PATH="/usr/lib/jvm/java-8-amazon-corretto/bin/:$PATH"
				export JAVA_HOME="/usr/lib/jvm/java-8-amazon-corretto"
			else
				echo "ERROR: No Java 19 JDK found, exiting..."
				exit 1
			fi
		fi
	fi
fi

# If sourced = 1, then.
if [ "$sourced" = 1 ]; then
	# Do nothing.
	echo "Java 8 - Sourced"
	echo "$(java -version)"
else
	# If sourced = 0, then.
	echo "Java 8 - Not sourced"
	java "$@"
fi
