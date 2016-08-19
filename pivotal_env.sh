##Customize Constants
#Git Root
export CUS_GIT_ROOT=~/gitdev
#GPDB Var
export CUS_GPDB_DEFAULT_REPO=$CUS_GIT_ROOT/gpdb
export CUS_GP_PORT=5432
export CUS_GPDATA=~/gpdb-data
export CUS_GP_LOG=~/gpAdminLogs
export CUS_GP_AUX=gpAux
#HAWQ Var
export CUS_HAWQ_DEFAULT_REPO=$CUS_GIT_ROOT/hawq
export CUS_HAWQ_PORT=5450
export CUS_HAWQDATA=~/hawq-data-directory
export CUS_HAWQ_LOG=~/hawqAdminLogs
#HAWQ13 Var
export CUS_HAWQ13_DEFAULT_REPO=$CUS_GIT_ROOT/hawq13
export CUS_HAWQ13_PORT=5450
export CUS_HAWQ13DATA=~/hawq13-data-directory
export CUS_HAWQ13_LOG=~/hawq13AdminLogs
#GPOS Var
export CUS_GPOS_REPO=~/gitdev/gpos
#ORCA Var
export CUS_ORCA_REPO=~/gitdev/gp-orca
#POSTGres Var
export CUS_POSTGRES_REPO=~/gitdev/postgres
#BACK up
export CUS_BACKUP=$CUS_GIT_ROOT/backup
#HDFS
export CUS_HDFS_ROOT=$CUS_GIT_ROOT/singlecluster-PHD
#Baleriong
export CUS_BAL_ROOT=$CUS_GIT_ROOT/balerion
#llvm
export CUS_LLVM_ROOT=$CUS_GIT_ROOT/llvm
export CUS_LLVM_INSTALL=$CUS_GIT_ROOT/llvm-install
#P4
export CUS_P4USER=krajaraman
export CUS_P4CLIENT=krajaraman-mac
export CUS_P4_ROOT=$CUS_GIT_ROOT/$CUS_P4CLIENT
export CUS_P4_PORT=perforce.greenplum.com:1666
#Tinc
export CUS_TINC_ROOT=$CUS_P4_ROOT/tinc/main
export CUS_TINCREPO_ROOT=$CUS_P4_ROOT/tincrepo/main
#Environment
export CUS_BLD_ARCH=osx106_x86
export CUS_MACOSX_DEPLOYMENT_TARGET=10.9
#GCC
export CUS_GCC_ENV=/opt/gcc_env.sh
#JAVA
export CUS_JAVA6_HOME="$(/usr/libexec/java_home -v 1.6)"
export CUS_JAVA7_HOME="$(/usr/libexec/java_home -v 1.7)"
export CUS_JAVA8_HOME="$(/usr/libexec/java_home -v 1.8)"

#AWS
export CUS_AWS_LOC=/Users/krajaraman/work/aws

#GCC
#source $CUS_GCC_ENV

#JAVA
export JAVA_HOME=$CUS_JAVA8_HOME

#bash
export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS='exfxbxdxcxegedabagacad'
PS1="[\W: \u\$(git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/{\1}/')]\$ "
export PATH=/usr/local/opt/gnu-tar/libexec/gnubin:$PATH

##User Specific Setting
export BLOCKSIZE=1024
alias ll="ls -lF"
alias la="ls -laF"
alias lt="ls -lstrF"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias tz="tar -zcvf"
alias tx="tar -zxvf"
#usefule command to display git history in a test graphical format
alias gg="git log --graph --decorate --oneline"
#highlight the matching word in different color
export GREP_OPTION="--color=auto"
#gpdb alias
alias gpstart="gpstart -a"
alias gpstop="gpstop -a"

#GPDB
export GPROOT=$CUS_GPDB_DEFAULT_REPO

#HDFS
export GPHD_ROOT=$CUS_HDFS_ROOT
export HADOOP_ROOT=$GPHD_ROOT/hadoop
export HBASE_ROOT=$GPHD_ROOT/hbase
export HIVE_ROOT=$GPHD_ROOT/hive
export ZOOKEEPER_ROOT=$GPHD_ROOT/zookeeper
export PATH=$PATH:$GPHD_ROOT/bin:$HADOOP_ROOT/bin:$HBASE_ROOT/bin:$HIVE_ROOT/bin:$ZOOKEEPER_ROOT/bin

#Perforce
export P4HOME=$CUS_P4_ROOT
export P4PORT=$CUS_P4_PORT
export P4CLIENT=$CUS_P4CLIENT
export P4CONFIG=$P4HOME/.p4config
export P4EDITOR=vim

#export MACOSX_DEPLOYMENT_TARGET=$CUS_MACOSX_DEPLOYMENT_TARGET

#Directory Location
export ESCALATION=~/work/Esclation/

#vitual env
#export PIP_REQUIRE_VIRTUALENV=true

ulimit -c unlimited
#function python27 {
#	python --version
#}

function gpdb_common {
	export JAVA_HOME=$CUS_JAVA6_HOME
	export GPHOME=$CUS_GPDB_DEFAULT_REPO/$CUS_GP_AUX/greenplum-db-devel
	export PGPORT=$CUS_GP_PORT
	export GPDATA=$CUS_GPDATA
	export MASTER_DATA_DIRECTORY=$GPDATA/master/gpseg-1
	export BLD_ARCH=$CUS_BLD_ARCH
	#Work around warning of "couldn't understand kern.osversion `14.5.0'"
	export MACOSX_DEPLOYMENT_TARGET=$CUS_MACOSX_DEPLOYMENT_TARGET
	cd $CUS_GPDB_DEFAULT_REPO/$CUS_GP_AUX
	export GPROOT=$CUS_GPDB_DEFAULT_REPO
	#python27
}

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

function use {
	case "$1" in
	"gpdb" )
		export PROMPT_COMMAND='echo -ne "\033]0;gpdb\007"'
		tmux rename-window -t${TMUX_PANE} "gpdb"
		gpdb_common
		source_build_env
		source $CUS_GCC_ENV
	;;
	"gpdb4" )
		export PROMPT_COMMAND='echo -ne "\033]0;gpdb4\007"'
		tmux rename-window -t${TMUX_PANE} "gpdb4"
		g4S_env
		gpdb_common
		source_build_env
		source $CUS_GCC_ENV
	;;
	"gpdb43" )
		export PROMPT_COMMAND='echo -ne "\033]0;gpdb43\007"'
		tmux rename-window -t${TMUX_PANE} "gpdb43"
		g43S_env
		gpdb_common
		source_build_env
		source $CUS_GCC_ENV
	;;
	"gpdb64" )
		export PROMPT_COMMAND='echo -ne "\033]0;gpdb64\007"'
		tmux rename-window -t${TMUX_PANE} "gpdb64"
		g64_env
		gpdb_common
		export MACOSX_DEPLOYMENT_TARGET=10.10
		source /usr/local/gpdb/greenplum_path.sh
		cd ../
	;;
	"hawq" )
		export PROMPT_COMMAND='echo -ne "\033]0;hawq\007"'
		tmux rename-window -t${TMUX_PANE} "hawq"
		export JAVA_HOME=$CUS_JAVA8_HOME
		export GPHOME=$CUS_HAWQ_DEFAULT_REPO/hawq-db-devel
		export PGPORT=$CUS_HAWQ_PORT
    export GPDATA=$CUS_HAWQDATA
		export MASTER_DATA_DIRECTORY=$GPDATA/masterdd
		export BLD_ARCH=$CUS_BLD_ARCH
		cd $CUS_HAWQ_DEFAULT_REPO
		source_build_env
		source $CUS_GCC_ENV
		#export VERSIONER_PYTHON_VERSION=2.6
		#export PYTHONPATH=/Library/Python/2.6/site-packages:$PYTHONPATH
	;;
	"hawqd" )
		export PROMPT_COMMAND='echo -ne "\033]0;hawq\007"'
		tmux rename-window -t${TMUX_PANE} "hawqd"
		export JAVA_HOME=$CUS_JAVA8_HOME
		export GPHOME=$CUS_HAWQ_DEFAULT_REPO/hawq-db-dist
		export PGPORT=$CUS_HAWQ_PORT
    export GPDATA=$CUS_HAWQDATA
		export MASTER_DATA_DIRECTORY=$GPDATA/masterdd
		#Common Env Variable
		export BLD_ARCH=$CUS_BLD_ARCH
		cd $CUS_HAWQ13_DEFAULT_REPO
		source_build_env
		source $CUS_GCC_ENV
		#export VERSIONER_PYTHON_VERSION=2.6
		#export PYTHONPATH=/Library/Python/2.6/site-packages:$PYTHONPATH
	;;
	"hawq13" )
		export PROMPT_COMMAND='echo -ne "\033]0;hawq13\007"'
		tmux rename-window -t${TMUX_PANE} "hawq13"
		export JAVA_HOME=$CUS_JAVA7_HOME
		export GPHOME=$CUS_HAWQ13_DEFAULT_REPO/greenplum-db-devel
		export PGPORT=$CUS_HAWQ13_PORT
    export GPDATA=$CUS_HAWQ13DATA
		export MASTER_DATA_DIRECTORY=$GPDATA/master/gpseg-1
		export BLD_ARCH=$CUS_BLD_ARCH
		export MACOSX_DEPLOYMENT_TARGET=$CUS_MACOSX_DEPLOYMENT_TARGET
		cd $CUS_HAWQ13_DEFAULT_REPO
		export GPROOT=$CUS_HAWQ13_DEFAULT_REPO
		source_build_env
		source $CUS_GCC_ENV
		export VERSIONER_PYTHON_VERSION=2.6
		export PYTHONPATH=/Library/Python/2.6/site-packages:$PYTHONPATH
	;;
	"hdfs" )
		export PROMPT_COMMAND='echo -ne "\033]0;hdfs\007"'
		tmux rename-window -t${TMUX_PANE} "hdfs"
		export JAVA_HOME=$CUS_JAVA8_HOME
		#export GPHOME=~/gitdev/hawq/hawq-db-devel
		#export PGPORT="5450"
		#export MASTER_DATA_DIRECTORY=~/hawq-data-directory
		cd $CUS_HDFS_ROOT
		source_build_env
	;;
	"tinc" )
	  export PROMPT_COMMAND='echo -ne "\033]0;tinc\007"'
		tmux rename-window -t${TMUX_PANE} "tinc"
		. ${P4HOME}/kraja_setup.sh
		cd ${P4HOME}
		source_build_env
		source $CUS_GCC_ENV
	;;
	"bal" )
	  export PROMPT_COMMAND='echo -ne "\033]0;balerion\007"'
		tmux rename-window -t${TMUX_PANE} "balerion"
		cd ${CUS_BAL_ROOT}
	;;
	"llvm" )
		export PROMPT_COMMAND='echo -ne "\033]0;llvm\007"'
		tmux rename-window -t${TMUX_PANE} "llvm"
		cd ${CUS_LLVM_ROOT}
	;;
	"gpos" )
	  export PROMPT_COMMAND='echo -ne "\033]0;gpos\007"'
		tmux rename-window -t${TMUX_PANE} "gpos"
		cd ${CUS_GPOS_REPO}
	;;
	"orca" )
	  export PROMPT_COMMAND='echo -ne "\033]0;orca\007"'
		tmux rename-window -t${TMUX_PANE} "orca"
		cd ${CUS_ORCA_REPO}
	;;
	"postgres" )
		export PROMPT_COMMAND='echo -ne "\033]0;postgres\007"'
		tmux rename-window -t${TMUX_PANE} "postgres"
		source $CUS_GCC_ENV
		cd ${CUS_POSTGRES_REPO}
	;;
	"aws" )
		cd ${CUS_AWS_LOC}
	;;
	"hack" )
		export PROMPT_COMMAND='echo -ne "\033]0;hack\007"'
		tmux rename-window -t${TMUX_PANE} "hack"
		cd /Users/krajaraman/work/antlr/hackathon
	;;
	* )
		echo "unknown build - please update the use function in .bash_profile"
	;;
esac
	enable_ccache
}

function source_build_env() {
	if [ ! \( -d "${GPHOME}" \) ]
	then
			 echo "Error: GPDB install directory ${GPHOME} does not exist";
			 return;
	else
			 echo "Using GPDB installed in ${GPHOME}";
	fi

	if [ ! \( -d "${MASTER_DATA_DIRECTORY}" \) ]
	then
			 echo "Warning: Master data directory ${MASTER_DATA_DIRECTORY} does not exist.";
	fi

	export PATH=$GPHOME/bin:$GPHOME/bin/lib:$PATH
	export DYLD_LIBRARY_PATH=$GPHOME/lib:$DYLD_LIBRARY_PATH
	. ${GPHOME}/greenplum_path.sh
}

function g43S_env() {
	export CUS_GIT_ROOT=~/gitdev
	export CUS_GPDB_DEFAULT_REPO=$CUS_GIT_ROOT/gpdb43_STABLE
	export CUS_GP_PORT=5432
	export CUS_GPDATA=~/gpdb-data
	export CUS_GP_LOG=~/gpAdminLogs
	export CUS_GP_AUX=gpAux
}

function g4S_env() {
	export CUS_GIT_ROOT=~/gitdev
	export CUS_GPDB_DEFAULT_REPO=$CUS_GIT_ROOT/gpdb4
	export CUS_GP_PORT=5432
	export CUS_GPDATA=~/gpdb-data
	export CUS_GP_LOG=~/gpAdminLogs
	export CUS_GP_AUX=gpAux
}

function g64_env() {
	export CUS_GIT_ROOT=~/gitdev
	export CUS_GPDB_DEFAULT_REPO=$CUS_GIT_ROOT/gpdb64
	export CUS_GP_PORT=5432
	export CUS_GPDATA=~/gpdb-data
	export CUS_GP_LOG=~/gpAdminLogs
	export CUS_GP_AUX=gpAux
}

function cgpdb() {
	#Work around the libz.1.dylib issue
	if [ -a $GPHOME/lib/libz.1.dylib ];
		then mv -f $GPHOME/lib/libz.1.dylib libz.1.dylib.old
	fi
	if [ -a $GPROOT/$CUS_GP_AUX/ext/osx106_x86/lib/libz.1.dylib ];
		then mv -f $GPROOT/$CUS_GP_AUX/ext/osx106_x86/lib/libz.1.dylib libz.1.dylib.old
	fi

	#diffmerge ~/gitdev/backup/gpinitsystem_config $GPHOME/docs/cli_help/gpconfigs/gpinitsystem_config
	cp $CUS_BACKUP/gpinitsystem_config $GPHOME/docs/cli_help/gpconfigs/gpinitsystem_config
	cp $GPHOME/docs/cli_help/gpconfigs/gpinitsystem_config $GPDATA

	echo "krajaraman" > $GPDATA/hosts
}

function chawq13() {
	#Work around the libz.1.dylib issue
	if [ -a $GPHOME/lib/libz.1.dylib ];
		then mv -f $GPHOME/lib/libz.1.dylib libz.1.dylib.old
	fi

	#hawq version of clean
	mv $GPHOME/lib/libxml2.2.dylib $GPHOME/lib/libxml2.2.dylib.old

	cp $CUS_BACKUP/hawq13_gpinitsystem_config $GPHOME/docs/cli_help/gpconfigs/gpinitsystem_config
	cp $GPHOME/docs/cli_help/gpconfigs/gpinitsystem_config $GPDATA

	echo "krajaraman" > $GPDATA/hosts
}

function fcgpdb() {
	#Work around the libz.1.dylib issue
	if [ -a $GPHOME/lib/libz.1.dylib ];
		then mv -f $GPHOME/lib/libz.1.dylib libz.1.dylib.old
	fi
	if [ -a $GPROOT/gpAux/ext/osx106_x86/lib/libz.1.dylib ];
		then mv -f $GPROOT/gpAux/ext/osx106_x86/lib/libz.1.dylib libz.1.dylib.old
	fi

	rm -rf $GPDATA
	rm -rf $CUS_GP_LOG

	mkdir $GPDATA
	mkdir $GPDATA/master
	mkdir $GPDATA/p1 $GPDATA/p2 $GPDATA/p3
	mkdir $GPDATA/p1/primary
	mkdir $GPDATA/p2/primary
	mkdir $GPDATA/p3/primary

	#diffmerge ~/gitdev/backup/gpinitsystem_config $GPHOME/docs/cli_help/gpconfigs/gpinitsystem_config
	cp $CUS_BACKUP/gpinitsystem_config $GPHOME/docs/cli_help/gpconfigs/gpinitsystem_config
	cp $GPHOME/docs/cli_help/gpconfigs/gpinitsystem_config $GPDATA

	echo "krajaraman" > $GPDATA/hosts
}

function fchawq13() {
	#Work around the libz.1.dylib issue
	if [ -a $GPHOME/lib/libz.1.dylib ];
		then mv -f $GPHOME/lib/libz.1.dylib libz.1.dylib.old
	fi
	rm -rf $GPDATA
	rm -rf $CUS_GP_LOG

	mkdir $GPDATA
	mkdir $GPDATA/master
	mkdir $GPDATA/p1 $GPDATA/p2 $GPDATA/p3
	mkdir $GPDATA/p1/primary
	mkdir $GPDATA/p2/primary
	mkdir $GPDATA/p3/primary

	cp $CUS_BACKUP/hawq13_gpinitsystem_config $GPHOME/docs/cli_help/gpconfigs/gpinitsystem_config
	cp $GPHOME/docs/cli_help/gpconfigs/gpinitsystem_config $GPDATA

	echo "krajaraman" > $GPDATA/hosts

	#hawq version of clean
	mv $GPHOME/lib/libxml2.2.dylib $GPHOME/lib/libxml2.2.dylib.old
	hdfs dfs -rm -r /gpsql
}

function chawq() {
	mv $GPHOME/lib/libxml2.2.dylib $GPHOME/lib/libxml2.2.dylib.old
	diffmerge $CUS_BACKUP/hawq-site-simex.xml hawq-db-devel/etc/hawq-site.xml
	#cp ~/gitdev/backup/hawq-site.xml hawq-db-devel/etc/
	use hawq
}

function fchawq() {
	mv $GPHOME/lib/libxml2.2.dylib $GPHOME/lib/libxml2.2.dylib.old
	diffmerge $CUS_BACKUP/hawq-site.xml hawq-db-devel/etc/hawq-site.xml
	#cp ~/gitdev/backup/hawq-site.xml hawq-db-devel/etc/
	hdfs dfs -rm -r /hawq_default
	hdfs dfs -ls /
	rm -rf $GPDATA
	mkdir $GPDATA
	mkdir $MASTER_DATA_DIRECTORY
	rm -rf $CUS_HAWQ_LOG
	ls -la $GPDATA
	use hawq
}

function fcbal() {
		use bal
		rm -rf build
}

function fcllvm() {
	use llvm
	rm -rf build
}

function fcgpos() {
	use gpos
	rm -rf build
}

function igpdb64() {
	use gpdb64
	cd ./gpAux/gpdemo/
	source gpdemo-env.sh
	gpstop -a
	make cluster
	source gpdemo-env.sh
}

function sgpdb64() {
	use gpdb64
	cd ./gpAux/gpdemo
	source gpdemo-env.sh
}

function igpdb() {
	use gpdb
	gpinitsystem -c $GPDATA/gpinitsystem_config -a
}

function ihawq13() {
	use hawq13
	gpinitsystem -c $GPDATA/gpinitsystem_config -a
}

function ihawq() {
	use hawq
	hawq init cluster -a
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

function bgpdb() {
	gpstop -a
	make HOME=`pwd` devel
}

function bgpdb64() {
	gpstop -a
	make -j7
	make -j7 install
}

function bhawq13() {
	gpstop -a
	make HOME=`pwd` devel
}

function bhawq() {
	hawq stop cluster -a
	make devel
}

function bbal() {
	make
}
function bgpos() {
	make
}

function rbpostgres() {
	source $CUS_GCC_ENV
	./configure
	bpostgres
}

function bpostgres() {
	source $CUS_GCC_ENV
	make
}

function rbgpdb() {
	gpstop -a
	clean
	# some time the cached content under ext will cause false build break of mismatching interfaces after publish_local
	rm -rf $CUS_GPDB_DEFAULT_REPO/$CUS_GP_AUX/ext/*
	make sync_tools

	bgpdb
}

function rbgpdb64() {
	rm -rf /usr/local/gpdb
	use gpdb64
	gpstop -a
	clean
	enable_debug_flags
	#Debug
	#./configure  --enable-orca --enable-testutils --enable-codegen --enable-cassert --enable-debug --with-perl --with-python --with-libxml --prefix=/usr/local/gpdb --disable-gpfdist --with-codegen-prefix="/usr/local/Cellar/llvm37/3.7.1/lib/llvm-3.7" CPPFLAGS="-I/usr/local/include -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS -g" CXXFLAGS="-I/usr/local/include -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS -g"
	# Release
	./configure  --enable-orca --enable-testutils --enable-codegen --enable-cassert --enable-debug --with-perl --with-python --with-libxml --prefix=/usr/local/gpdb --disable-gpfdist --with-codegen-prefix="/usr/local/Cellar/llvm37/3.7.1/lib/llvm-3.7" CPPFLAGS="-I/usr/local/include -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS " CXXFLAGS="-I/usr/local/include -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS"
	# Custom llvm
	#./configure  --enable-orca --enable-testutils --enable-codegen --enable-cassert --enable-debug --with-perl --with-python --with-libxml --prefix=/usr/local/gpdb --disable-gpfdist --with-codegen-prefix="/Users/krajaraman/gitdev/llvm-install" CPPFLAGS="-I/usr/local/include -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS -g" CXXFLAGS="-I/usr/local/include -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS -g"


	bgpdb64
}

function rbgpdb64_rel() {
	rm -rf /usr/local/gpdb
	use gpdb64
	gpstop -a
	clean
	disable_debug_flags
	# Release
	./configure  --enable-orca --enable-testutils --enable-codegen --with-perl --with-python --with-libxml --prefix=/usr/local/gpdb --disable-gpfdist --with-codegen-prefix="/usr/local/Cellar/llvm37/3.7.1/lib/llvm-3.7" CPPFLAGS="-I/usr/local/include -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS " CXXFLAGS="-I/usr/local/include -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS"
	bgpdb64
}

function rbgpdb64_nocg() {
	use gpdb64
	gpstop -a
	clean
	./configure --enable-mapreduce --enable-orca --enable-testutils --enable-debug --with-perl --with-python --with-libxml --prefix=/usr/local/gpdb --disable-gpfdist CPPFLAGS="-I/usr/local/include -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS -g" CXXFLAGS="-I/usr/local/include -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS -g"
	bgpdb64

}

function rbhawq13() {
	gpstop -a
	clean
	# some time the cached content under ext will cause false build break of mismatching interfaces after publish_local
	rm -rf $CUS_HAWQ13_DEFAULT_REPO/ext/*
	make sync_tools

	bgpdb
}

function rbhawq() {
	hawq stop cluster -a
	clean
	rm -rf $CUS_HAWQ_DEFAULT_REPO/ext/*
	make sync_tools
	bhawq
}

function rbhawq-oss() {
	hawq stop cluster -a
	clean
	rm -rf $CUS_HAWQ_DEFAULT_REPO/ext/*
	cd ./apache-hawq
	make distclean
	make clean
	./configure --prefix=/usr/local/hawq --enable-orca --with-python --with-perl --enable-debug --enable-depend --enable-cassert
	bhawq
}

function rbbal() {
	use bal
	fcbal
	mkdir build
	cd ./build
	#cmake -D CMAKE_PREFIX_PATH=/usr/local/opt/llvm37/lib/llvm-3.7 -D CMAKE_BUILD_TYPE=Debug -D CMAKE_CXX_COMPILER=clang++ -D CMAKE_TOOLCHAIN_FILE=../i386.toolchain.cmake ../
	#cmake -D build_examples=ON -D CMAKE_PREFIX_PATH=/usr/local/opt/llvm37/lib/llvm-3.7 -D CMAKE_BUILD_TYPE=Debug -D CMAKE_CXX_COMPILER=clang++ ../
	cmake -D build_examples=ON -D CMAKE_PREFIX_PATH=/Users/krajaraman/gitdev/llvm-install -D CMAKE_BUILD_TYPE=Debug -D CMAKE_CXX_COMPILER=clang++ ../
	make -j8
}

function rbllvm() {
	use llvm
	fcllvm
	mkdir build
	cd ./build
	cmake -DCMAKE_INSTALL_PREFIX=$CUS_LLVM_INSTALL -DCMAKE_BUILD_TYPE=Release -DLLVM_LIBDIR_SUFFIX=64 -DLLVM_BUILD_TOOLS=ON -DLLVM_BUILD_EXAMPLES=ON ../
	make -j8
}

function install_bal() {
	sudo make -j8 install
}

function uninstall_bal() {
	sudo rm -rf /usr/local/include/balerion
	sudo rm -rf /usr/local/lib/libbalerion*
}

function rbgpos() {
	use gpos
	fcgpos
	mkdir build
	cd ./build
	#cmake -D CMAKE_BUILD_TYPE=Debug -D CMAKE_CXX_COMPILER=clang++ -D CMAKE_TOOLCHAIN_FILE=../i386.toolchain.cmake ../
	cmake -D CMAKE_CXX_COMPILER=clang++ -D CMAKE_TOOLCHAIN_FILE=../i386.toolchain.cmake ../
	#cmake -D CMAKE_BUILD_TYPE=Debug -D CMAKE_CXX_COMPILER=clang++ -D CMAKE_TOOLCHAIN_FILE=../x86_64.toolchain.cmake ../
	make -j8
}

function rbgpos64() {
	use gpos
	fcgpos
	mkdir build
	cd ./build
	enable_debug_flags
	#cmake -D CMAKE_BUILD_TYPE=Debug -D CMAKE_CXX_COMPILER=clang++ -D CMAKE_TOOLCHAIN_FILE=../i386.toolchain.cmake ../
	cmake -D CMAKE_BUILD_TYPE=Debug -D CMAKE_CXX_COMPILER=clang++ ../
	make -j8
}

function rbgpos64_rel() {
	use gpos
	fcgpos
	mkdir build
	cd ./build
	disable_debug_flags
	#cmake -D CMAKE_BUILD_TYPE=Debug -D CMAKE_CXX_COMPILER=clang++ -D CMAKE_TOOLCHAIN_FILE=../i386.toolchain.cmake ../
	cmake -D CMAKE_CXX_COMPILER=clang++ ../
	make -j8
}

function install_gpos() {
	sudo make -j8 install
}

function uninstall_gpos() {
	sudo rm -rf /usr/local/include/gpos
	sudo rm -rf /usr/local/lib/libgpos*
}

function rborca() {
	use orca
	rm -rf build
	mkdir build
	cd ./build
	cmake -D CMAKE_CXX_COMPILER=clang++ -D CMAKE_TOOLCHAIN_FILE=../cmake/i386.toolchain.cmake -D XERCES_INCLUDE_DIR=/opt/gp_xerces_32/include -D XERCES_LIBRARY=/opt/gp_xerces_32/lib/libxerces-c.dylib ../
	#cmake -D CMAKE_BUILD_TYPE=Debug -D CMAKE_CXX_COMPILER=clang++ -D CMAKE_TOOLCHAIN_FILE=../cmake/x86_64.toolchain.cmake -D XERCES_INCLUDE_DIR=/opt/gp_xerces/include -D XERCES_LIBRARY=/opt/gp_xerces/lib/libxerces-c.dylib ../
	make -j8
}

function rborca64() {
	use orca
	rm -rf build
	mkdir build
	cd ./build
	enable_debug_flags
	#cmake -D CMAKE_BUILD_TYPE=Debug -D CMAKE_CXX_COMPILER=clang++ -D CMAKE_TOOLCHAIN_FILE=../cmake/i386.toolchain.cmake -D XERCES_INCLUDE_DIR=/opt/gp_xerces_32/include -D XERCES_LIBRARY=/opt/gp_xerces_32/lib/libxerces-c.dylib ../
	#cmake -D CMAKE_BUILD_TYPE=Debug -D CMAKE_CXX_COMPILER=clang++ -D XERCES_INCLUDE_DIR=/opt/gp_xerces/include -D XERCES_LIBRARY=/opt/gp_xerces/lib/libxerces-c.dylib ../
	cmake -D CMAKE_BUILD_TYPE=Debug -D CMAKE_CXX_COMPILER=clang++ -D XERCES_INCLUDE_DIR=/opt/gp_xerces/include -D XERCES_LIBRARY=/opt/gp_xerces/lib/libxerces-c.dylib ../
	make -j8
}

function rborca64_rel() {
	use orca
	rm -rf build
	mkdir build
	cd ./build
	disable_debug_flags
	cmake -D CMAKE_CXX_COMPILER=clang++ -D XERCES_INCLUDE_DIR=/opt/gp_xerces/include -D XERCES_LIBRARY=/opt/gp_xerces/lib/libxerces-c.dylib ../
	make -j8
}

# This command has to run with 'sudo' in order to
# be able to copy binaries to /opt/repo/emc/optimizer.
# Limit to 'debug' build only, since most time
# publish_local is for debugging purpose.
publish_local_orca_for_gpdb4()
{
	use orca

	# work around warning of "couldn't understand kern.osversion `14.5.0'"
	export MACOSX_DEPLOYMENT_TARGET=10.9
	#source /opt/gcc_env-osx106.sh

	time build ARCH_BIT=GPOS_32BIT BLD_TYPE=debug
	time build ARCH_BIT=GPOS_32BIT BLD_TYPE=opt

	# publish both opt and debug build
	sudo make ARCH_BIT=GPOS_32BIT BLD_TYPE=opt publish_local
}

build() {
	 make "$@"
}

function publish_orca32()
{
 sudo make ARCH_BIT=GPOS_32BIT BLD_TYPE=opt && make ARCH_BIT=GPOS_32BIT && make ARCH_BIT=GPOS_32BIT BLD_TYPE=opt publish_local
}

function publish_orca64()
{
 sudo make ARCH_BIT=GPOS_64BIT BLD_TYPE=opt && make ARCH_BIT=GPOS_64BIT && make ARCH_BIT=GPOS_64BIT BLD_TYPE=opt publish_local
}

function install_orca() {
	sudo make -j8 install
}

function uninstall_orca() {
	sudo rm -rf /usr/local/include/naucrates
	sudo rm -rf /usr/local/include/gpdbcost
	sudo rm -rf /usr/local/include/gpopt
	sudo rm -rf /usr/local/lib/libnaucrates*
	sudo rm -rf /usr/local/lib/libgpdbcost*
	sudo rm -rf /usr/local/lib/libgpopt*
}

function mv_xerces_64() {
	cp -r /opt/gp_xerces/include/xercesc /usr/local/include/
	cp -r /opt/gp_xerces/lib/libxerces-c* /usr/local/lib/
}

function bdgpdb() {
	gpstop -a
	make HOME=`pwd` dist
}

function bdhawq() {
	hawq stop cluster -a
	make dist
}

function install_postgres() {
	make -j8 install
	rm -rf /usr/local/pgsql/data
	mkdir /usr/local/pgsql/data
}

function run_postgres() {
	/usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data
	/usr/local/pgsql/bin/postgres -D /usr/local/pgsql/data >logfile 2>&1 &
	/usr/local/pgsql/bin/createdb test
	/usr/local/pgsql/bin/psql test
}

function stop_postgres() {
	source /Users/krajaraman/gitdev/backup/clean.sh
	kill -INT `head -1 /usr/local/pgsql/data/postmaster.pid`
}


function clean() {
	make clean
	make distclean
	cobj
}

function clean_all() {
	gpstop -a
	hawq stop cluster -a
	clean
	rm –f /tmp/.s*
}

function show_postgres() {
	ps -ax | grep postgres
}

function kill_postgres() {
	killall postgress
	ipcclean
	rm -rf /tmp/.s*
}

function ungpos() {
	sudo rm -rf usr/local/lib/libgpos*
	sudo rm -rf /usr/local/include/gpos
}

function vm() {
	ssh krajaraman@10.103.217.199
}

function gvm() {
	ssh krajaraman@gpdb1.dev.dh.greenplum.com
}

function pvm() {
	ssh gpadmin@dca7-mdw1.qa.dh.greenplum.com
}

function cobj() {
	find . -name "*.o" -type f -exec rm -rf {} \;
	find . -name "*.dylib" -type f -exec rm -rf {} \;
}

function cvm() {
	echo -n 'krajaraman@10.103.217.199' | pbcopy
}

function cgvm() {
	echo -n 'krajaraman@gpdb1.dev.dh.greenplum.com' | pbcopy
}

function cpvm() {
	echo -n 'gpadmin@dca7-mdw1.qa.dh.greenplum.com' | pbcopy
}

function aws() {
	ssh -i /Users/krajaraman/work/aws/krajaraman-ca.pem centos@10.32.66.35
}
function caws() {
	echo -n 'centos@10.32.66.35' | pbcopy
}

function raws() {
	ssh -i /Users/krajaraman/work/aws/krajaraman-or.pem ec2-user@ec2-52-39-6-42.us-west-2.compute.amazonaws.com
}
function craws() {
	echo -n 'ec2-user@ec2-52-39-6-42.us-west-2.compute.amazonaws.com' | pbcopy
}

function uaws() {
	ssh -i /Users/krajaraman/work/aws/krajaraman-or.pem ubuntu@ec2-52-38-197-52.us-west-2.compute.amazonaws.com
}
function cuaws() {
	echo -n 'ubuntu@ec2-52-38-197-52.us-west-2.compute.amazonaws.com' | pbcopy
}

function codegen_pvm() {
	ssh root@rh55-dev01.dh.greenplum.com
	su caragg
	source ~/gpdb_env.sh
	use GPDB-Main
	cd /data/caragg/profiling/
}

function mv-grammar() {
	rm -rf /Users/krajaraman/work/antlr/hackathon/cgrammar.tokens
	rm -rf /Users/krajaraman/work/antlr/hackathon/cgrammarParser.cc
	rm -rf /Users/krajaraman/work/antlr/hackathon/cgrammarParser.h
	rm -rf /Users/krajaraman/work/antlr/hackathon/cgrammarLexer.cc
	rm -rf /Users/krajaraman/work/antlr/hackathon/cgrammarLexer.h
	rm -rf /Users/krajaraman/work/antlr/hackathon/cgrammarParser.c
	cp -rf /Users/krajaraman/work/antlr/hackathon/output/cgrammar.tokens /Users/krajaraman/work/antlr/hackathon
	cp -rf /Users/krajaraman/work/antlr/hackathon/output/cgrammarParser.h /Users/krajaraman/work/antlr/hackathon
	cp -rf /Users/krajaraman/work/antlr/hackathon/output/cgrammarParser.c /Users/krajaraman/work/antlr/hackathon
	cp -rf /Users/krajaraman/work/antlr/hackathon/output/cgrammarLexer.h /Users/krajaraman/work/antlr/hackathon
	cp -rf /Users/krajaraman/work/antlr/hackathon/output/cgrammarLexer.c /Users/krajaraman/work/antlr/hackathon
	mv /Users/krajaraman/work/antlr/hackathon/cgrammarLexer.c /Users/krajaraman/work/antlr/hackathon/cgrammarLexer.cc
	mv /Users/krajaraman/work/antlr/hackathon/cgrammarParser.c /Users/krajaraman/work/antlr/hackathon/cgrammarParser.cc
}

function rbhack() {
	use hack
	rm -rf ./build
	mkdir build
	cd ./build
	cmake -D CMAKE_BUILD_TYPE=Debug -D CMAKE_TOOLCHAIN_FILE=../cmake/i386.toolchain.cmake ../
	bhack
}

function bhack() {
	use hack
	cd ./build
	make
}

#if [ -e $GPHOME/greenplum_path.sh ]; then
#source $GPHOME/greenplum_path.sh
#fi

#Entong P4 Settings
#export P4PORT=perforce.greenplum.com:1666
#export P4HOST=eshenMBP
#export P4USER=shene
#export P4CLIENT=shene-mbp
#export P4CONFIG=.p4config
#export P4EDITOR=vim
