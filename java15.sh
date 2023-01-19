#!/usr/bin/env bash

# MIT License
#
# Copyright (c) 2023 Paul Snow
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

# Helper function
is_sourced() {
	if [ -n "$ZSH_VERSION" ]; then
		case $ZSH_EVAL_CONTEXT in *:file:*) return 0;; esac
	else  # Add additional POSIX-compatible shell names here, if needed.
		case ${0##*/} in dash|-dash|bash|-bash|ksh|-ksh|sh|-sh) return 0;; esac
	fi
	return 1  # NOT sourced.
}

# Sample call.
## Set if it is sourced or not.
#is_sourced && sourced=1 || sourced=0
[[ $0 != "$BASH_SOURCE" ]] && sourced=1 || sourced=0[1]

## Check for zing directory exists
if [ -d "/usr/lib/jvm/zing-15/bin" ] && [ -v "${USE_ZING}" ]; then
	export PATH="/usr/lib/jvm/zing-15/bin/:$PATH"
	export JAVA_HOME="/usr/lib/jvm/zing-15"
else
	## Check for zulu directory exists
	if [ -d "/usr/lib/jvm/zulu-15/bin" ]; then
		export PATH="/usr/lib/jvm/zulu-15/bin/:$PATH"
		export JAVA_HOME="/usr/lib/jvm/zulu-15"
	else
		## Check for open JDK
		if [ -d "/usr/lib/jvm/java-15-openjdk/bin" ]; then
			export PATH="/usr/lib/jvm/java-15-openjdk/bin/:$PATH"
			export JAVA_HOME="/usr/lib/jvm/java-15-openjdk"
		else
			## Check if java-15-amazon-corretto is installed
			if [ -d "/usr/lib/jvm/java-15-amazon-corretto/bin" ]; then
				export PATH="/usr/lib/jvm/java-15-amazon-corretto/bin/:$PATH"
				export JAVA_HOME="/usr/lib/jvm/java-15-amazon-corretto"
			else
				echo "ERROR: No Java 15 JDK found, exiting..."
				exit 1
			fi
		fi
	fi
fi

# If sourced = 1, then.
if [ "$sourced" = 1 ]; then
	# Do nothing.
	echo "Java 15 - Sourced"
	echo "$(java -version)"
else
	# If sourced = 0, then.
	echo "Java 15 - Not sourced"
	java "$@"
fi
