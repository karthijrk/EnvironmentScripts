##Customize Constants

function custom_var_env() {
	export CUS_GIT_ROOT=~/workspace
	export CUS_JAVA8_HOME="$(/usr/libexec/java_home -v 1.8)"
}
function bash_env() {
	#bash
	export LS_OPTIONS='--color=auto'
	export CLICOLOR='Yes'
	export LSCOLORS='exfxbxdxcxegedabagacad'
	PS1="[\W: \u\$(git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/{\1}/')]\$ "
}

function alias_env() {
	##User Specific Setting
	alias ll="ls -lF"
	alias la="ls -laF"
	alias lt="ls -lstrF"
	alias tz="tar -zcvf"
	alias tx="tar -zxvf"
	#usefule command to display git history in a test graphical format
	alias gg="git log --graph --decorate --oneline"
}

function default_shell_env() {
	bash_env
	alias_env
}

function defualt_env() {
	custom_var_env
	#JAVA
	export JAVA_HOME=$CUS_JAVA8_HOME

	#highlight the matching word in different color
	export GREP_OPTION="--color=auto"

	#core size
	ulimit -c unlimited
}

function use {
	case "$1" in
	"env" )
		export PROMPT_COMMAND='echo -ne "\033]0;Env\007"'
		tmux rename-window -t${TMUX_PANE} "Env"
		defualt_env
		cd $CUS_GIT_ROOT/EnvironmentScripts
	;;
	* )
		echo "unknown build - please update the use function in .bash_profile"
	;;
esac
}

default_shell_env

#########################################################
#unused function
function enable_ccache ()
{
    if [ -a /usr/local/bin/ccache ]; then
        export CC="ccache cc";
        export CXX="ccache c++";
        export BLD_CC="ccache gcc";
        export BLD_CXX="ccache g++";
    else
        echo ccache NOT found. Please use \"brew install ccache\" to install ccache;
    fi;

    unset CCACHE_DISABLE
}

function disable_ccache ()
{
    unset CC;
    unset CXX;
    export BLD_CC="gcc";
    export BLD_CXX="g++";
    export CCACHE_DISABLE=1
}
enable_debug_flags()
{
	# configure flags to help debug
	export CFLAGS="-fno-omit-frame-pointer -O0 -pthread -g -g3 $CFLAGS"
	export CXXFLAGS="-g -g3 $CXXFLAGS"
	export CONFIGURE_DEBUG_FLAGS="--enable-debug --enable-depend --enable-cassert"

	# build DEBUG build for easier debug, by default it's RelWithDebInfo
	export CMAKE_DEBUG_FLAGS="-D CMAKE_BUILD_TYPE=DEBUG"

	# build DEBUG for stash (make devel)
	export BLD_TYPE=debug
}

disable_debug_flags()
{
	# configure flags to help debug
	export CFLAGS=
	export CXXFLAGS=
	export CONFIGURE_DEBUG_FLAGS=

	# build DEBUG build for easier debug, by default it's RelWithDebInfo
	export CMAKE_DEBUG_FLAGS=

	# build DEBUG for stash (make devel)
	export BLD_TYPE=
}

clear_flags()
{
	unset CFLAGS
	unset CXXFLAGS
	unset CONFIGURE_DEBUG_FLAGS
	unset CMAKE_DEBUG_FLAGS
	unset BLD_TYPE
}
#########################################################
