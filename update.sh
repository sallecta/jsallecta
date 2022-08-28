dir0="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

fn_stoponerror ()
{
	# Usage:
	# fn_stoponerror $? $LINENO
	error_code=$1
	line=$2
	if [ $error_code -ne 0 ]; then
		printf "\n"$line": error ["$error_code"]\n\n"
		exit $error_code
	fi
}

include="."
$include $dir0/settings.ignore.sh

dir_git_dest=$dir0/src

if [[ "$settings_dir_dev" == "" ]] || [[ "$settings_dir_dev" == "/" ]] || [[ "$dir_git_dest" == "/" ]]; then
	printf "\nError: settings_dir_dev/git is empty or root.\n"
	exit
fi

if [ ! -d "$settings_dir_dev" ]; then
	printf "\nError: settings_dir_dev not exist.\n"
	exit
fi

rm -rf "$dir_git_dest"
fn_stoponerror $? $LINENO

printf "\nCopying templates...\n"
mkdir -p "$dir_git_dest/templates"
fn_stoponerror $? $LINENO
cp -R "$settings_dir_dev/templates/jsallecta" "$dir_git_dest/templates/"
fn_stoponerror $? $LINENO

printf "\nCopying media...\n"
mkdir -p "$dir_git_dest/media/templates/site/jsallecta"
fn_stoponerror $? $LINENO
cp -R "$settings_dir_dev/media/templates/site/jsallecta" "$dir_git_dest/media/templates/site/"
fn_stoponerror $? $LINENO


printf "\nCopying languages...\n\n"
mkdir -p "$dir_git_dest/language/en-GB"
fn_stoponerror $? $LINENO
cp "$settings_dir_dev/language/en-GB/tpl_jsallecta.ini" "$dir_git_dest/language/en-GB/"
fn_stoponerror $? $LINENO
cp "$settings_dir_dev/language/en-GB/tpl_jsallecta.sys.ini" "$dir_git_dest/language/en-GB/"
fn_stoponerror $? $LINENO
