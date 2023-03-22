path=`realpath $1`
out_dir=$2
config_content="""
[mypy]
mypy_path = $path/utbot-python/samples/easy_samples
namespace_packages = True
check_untyped_defs = True
cache_fine_grained = True
show_absolute_path = True
"""
echo "$config_content" > mypy_config.ini
mkdir -p $out_dir

python3 -m utbot_mypy_runner \
	--config mypy_config.ini \
	--sources $path/utbot-python/samples/easy_samples/annotation_tests.py \
	--modules annotation_tests \
	--annotations_out $out_dir/annotation_sample.json

python3 -m utbot_mypy_runner \
	--config mypy_config.ini \
	--sources $path/utbot-python/samples/easy_samples/subtypes.py \
	--modules subtypes \
	--annotations_out $out_dir/subtypes_sample.json

python3 -m utbot_mypy_runner \
	--config mypy_config.ini \
	--sources $path/utbot-python/samples/easy_samples/import_test.py \
	--modules import_test \
	--annotations_out $out_dir/imports_sample.json

python3 -m utbot_mypy_runner \
	--config mypy_config.ini \
	--sources $path/utbot-python/samples/easy_samples/boruvka.py \
	--modules boruvka \
        --module_for_types boruvka \
	--annotations_out $out_dir/boruvka.json

if [ $3 == "open" ]
then
	explorer.exe .
fi
