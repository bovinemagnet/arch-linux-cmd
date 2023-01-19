#!/usr/bin/env bash

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