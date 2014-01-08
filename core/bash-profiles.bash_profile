
bp_debug () {
	if [ $BP_DEBUG == 1 ]; then 
		echo "[bash-profiles] "$1
	fi	 
}

# for now hard code this to dropbox
export BP_DEBUG=1
# export BP_DIR="$HOME/Dropbox/bash-profiles/";
export BP_DIR="$HOME/Development/bash-profiles/";

bp_debug "Initializing with '$BP_DIR' as BP_DIR"

# source the base bashrc
if [ -f ~/.bashrc ] ; then
	bp_debug "Loading bashrc in home dir"
	source ~/.bashrc
fi

source ${BP_DIR}core/bash-profiles.bashrc

bp_debug "Loading modules"

if [ -f ${BP_DIR}hosts/`hostname`.bashrc ] ; then 
	bp_debug "Host specific modules found. Loading...";
	source ${BP_DIR}hosts/`hostname`.bashrc
else 
	export BP_MODULES=`ls ${BP_DIR}modules`
fi

for module in $BP_MODULES; do
	bp_debug "Loading $module";

	mod_dir=${BP_DIR}modules/${module}/

	if [ -d ${mod_dir}bashrc.d ]; then
		bp_debug "Loading $module bashrc.d";
		source ${mod_dir}bashrc.d/*.bashrc;
	fi

	if [ -d ${mod_dir}bin ]; then
		bp_debug "Adding $module/bin to path";
		export PATH=$PATH:${mod_dir}bin;
	fi

	bp_debug "Done loading $module";
done


bp_debug "Initialization complete"