module directory

import path
import os
import rand

fn random_dir() !string {
	return '${os.temp_dir()}/${rand.uuid_v4()}}'
}

fn test_current_directoy() {
	assert @VMODROOT == os.getwd()
	//
	home := os.home_dir()
	os.chdir(home)!
	assert home == os.getwd()
}

fn test_create_directory() {
	dir := random_dir()!
	assert exists(dir) == false
	create(dir) or { println(err) }
	assert exists(dir)
	delete(dir) or { println(err) }
	assert exists(dir) == false
}

fn test_get_top_files() ! {
	files := get_files(@VMODROOT, SearchOption.top_only)!
	assert files.contains('${@VMODROOT}/v.mod')
	assert files.contains(@FILE) == false
}

fn test_get_all_files() ! {
	files := get_files(@VMODROOT, SearchOption.recursive)!
	assert files.contains('${@VMODROOT}/v.mod')
	assert files.contains(@FILE)
}

fn test_get_top_directories() {
	dir := random_dir()!
	folder := '${dir}/intermediate/one'
	create(folder)!
	dirs := get_directories(dir, SearchOption.top_only)!
	assert dirs.contains(get_parent(folder))
	assert dirs.contains(folder) == false
}

fn test_get_all_directories() {
	dir := random_dir()!
	folder := '${dir}/intermediate/one'
	create(folder)!
	dirs := get_directories(dir, SearchOption.recursive)!
	assert dirs.contains(get_parent(folder))
	assert dirs.contains(folder)
}
