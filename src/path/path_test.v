module path

import os

pub fn test_combine_empty() {
	path := combine('')
	assert path == ''
}

pub fn test_combine_single() {
	path := combine(os.temp_dir())
	assert path == os.temp_dir()
}

pub fn test_combine_multiple() {
	folder := 'folder'
	path := combine(os.temp_dir(), folder)
	assert path == '${os.temp_dir()}${os.path_separator}${folder}'
}

fn test_exists() {
	assert exists(os.temp_dir())
	assert exists(combine(os.temp_dir(), 'folder')) == false
}

fn test_get_directory_name() {
	folder := 'folder'
	path := combine(os.temp_dir(), folder)
	name := get_directory_name(path)
	assert name == os.temp_dir()
}

fn test_get_directory_name_root() {
	home := os.dir(os.home_dir())
	root := os.dir(home)
	name := get_directory_name(root)
	assert get_directory_name(root) == root
}

fn test_get_extension() {
	ext := 'txt'
	file := 'file.${ext}'
	assert get_extension(file) == ext
}

fn test_get_extension_fullpath() {
	ext := 'txt'
	file := combine(os.temp_dir(), 'file.${ext}')
	assert get_extension(file) == ext
}

fn test_get_filename() {
	path := 'file.txt'
	assert get_filename(path) == path
}

fn test_get_filename_fullpath() {
	file := 'file.txt'
	path := combine(os.temp_dir(), file)
	assert get_filename(path) == file
}

fn test_get_filename_without_extension() {
	ext := 'txt'
	file := 'file'
	assert get_filename_without_extension('${file}.${ext}') == file
}

fn test_get_filename_with_no_extension() {
	file := 'file'
	assert get_filename_without_extension(file) == file
}

fn test_get_filename_without_extension_fullpath() {
	ext := 'txt'
	file := 'file'
	path := combine(os.temp_dir(), '${file}.${ext}')
	assert get_filename_without_extension(path) == file
}

fn test_get_fullpath() ! {
	os.chdir(os.temp_dir())!
	file := 'file.txt'
	assert get_fullpath(file) == combine(os.getwd(), file)
}

fn test_has_extension() {
	ext := 'ext'
	file := 'file'
	assert has_extension('${file}.${ext}')
	assert has_extension(file) == false
}
