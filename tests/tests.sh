#!/usr/bin/env zsh

test() {
  output="`../lss $2`"
  if [[ `od <(echo $output)` != `od <(echo $3)` ]]; then
    echo "FAILURE: $1"
    echo "Expected: $3"
    echo "Actual:   $output"
    diff <(echo $output) <(echo  $3)
    exit 1
  else
   echo "PASS: $1"
  fi
}

test "prints files" \
     "this_is_a_file" \
     "Definitely a file!"

test "passes args to less" \
     "-n this_is_a_file" \
     "Definitely a file!"

test "lists directories" \
     "this_is_a_directory" \
     "this_is_a_file_inside_a_directory"

test "passes args to ls" \
     "-s this_is_a_directory" \
     "total 0\n0 this_is_a_file_inside_a_directory"

test "lists current directory without args" \
     "" \
     "tests.sh\nthis_is_a_directory\nthis_is_a_file"
