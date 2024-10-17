module directory

import os

// create the complete hierarchy of path
pub fn create(path string) ! {
	os.mkdir_all(path)!
}

// delete recursively the content of path
pub fn delete(path string) ! {
	os.rmdir_all(path)!
}

// exists returns true if path refers to an existing directory
pub fn exists(path string) bool {
	return os.is_dir(path)
}

// get_directories returns all directories under path, excluding files
pub fn get_directories(path string, option SearchOption) ![]string {
	list := os.ls(path)!
	//
	mut dirs := []string{}
	for elt in list {
		dir := '${path}/${elt}'
		if os.is_dir(dir) {
			dirs << dir
			if option == SearchOption.recursive {
				dirs << get_directories(dir, option)!
			}
		}
	}
	//
	return dirs
}

// get_files returns all files under path, excluding directories
pub fn get_files(path string, option SearchOption) ![]string {
	list := os.ls(path)!
	//
	mut files := []string{}
	for elt in list {
		entry := '${path}/${elt}'
		if os.is_file(entry) {
			files << entry
		} else if os.is_dir(entry) {
			if option == SearchOption.recursive {
				files << get_files(entry, option)!
			}
		}
	}
	//
	return files
}

// get_parent returns the path without the last entry
pub fn get_parent(path string) string {
	return os.dir(path)
}
