module path

import arrays
import os
import rand

// combine multiple strings into a path
pub fn combine(entries ...string) string {
	return arrays.join_to_string(entries, os.path_separator, fn (elem string) string {
		return elem
	})
}

// exists return true if a path exists
pub fn exists(path string) bool {
	return os.is_dir(path)
}

pub fn get_directory_name(path string) string {
	return os.dir(path)
}

pub fn get_extension(path string) string {
	idx := path.last_index('.') or { return '' }
	return path.substr(idx + 1, path.len)
}

pub fn get_filename(path string) string {
	idx := path.last_index(os.path_separator) or { return path }
	return path.substr(idx + 1, path.len)
}

pub fn get_filename_without_extension(path string) string {
	file := get_filename(path)
	idx := file.last_index('.') or { path.len }
	return file.substr(0, idx)
}

pub fn get_fullpath(path string) string {
	wd := os.getwd()
	return combine(wd, path)
}

pub fn get_random_filename() string {
	return rand.uuid_v4()
}

pub fn get_temp_filename() !string {
	filename := get_random_filename()
	temp := os.temp_dir()
	fullpath := combine(temp, filename)
	os.create(fullpath)!
	return fullpath
}

pub fn has_extension(path string) bool {
	idx := path.last_index('.') or { return false }
	return true
}
