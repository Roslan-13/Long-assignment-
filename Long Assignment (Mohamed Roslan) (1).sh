function to_lowercase() {
	lowercase="$(echo "$1" | awk '{print tolower($0)}')"
	echo $lowercase
}

function compose_name()
{
	first_name=$1
	second_name=$2
	first_character=${first_name:0:1}
	first_7_characters=${second_name:0:7}
	lowercase=$(to_lowercase $first_character)
	new_name="$lowercase$first_7_characters"
	echo $new_name
}

function add_user_name_to_array()
{
	name=$1
	exists=false
	for element in "${user_names[@]}"; do
		if [[ "$element" == "$name" ]]; then
			exists=true
			echo -e "The user name: '$element' already exists in the array."
			break
		fi
	done

	if ! $exists; then
		user_names+=("$name")
	else
		repeat_user_names+=("$name")
	fi
}

function add_department_to_group() {
  	groupName=$1
  	name=$2

	if [[ -v "department_groups[$groupName]" ]]; then
		echo -e "The group: $groupName group name already exists while adding department name: $name."
		department_groups[$groupName]+=",$name"
		exists=true	
	else
		department_groups[$groupName]=$name
	fi
}

file="$1"
is_show_debug=1
IFS=","
line_number=0
user_names=()
repeat_user_names=()
declare -A department_groups 

while read line; do
	((line_number++))
    if [[ $line_number -eq 1 ]]; then
		echo -e "Skip the header line: $line"
		continue
	fi
	
	array=($line)
	count=${#array[@]}
	if [[ $count != 3 ]]; then
		echo "This line format error, line:$line, count:$count"
		exit 1
	fi

	first_name=${array[0]}
	second_name=${array[1]}
	appartment=${array[2]}

    mixed_name=$(compose_name $first_name $second_name)
	add_user_name_to_array $mixed_name
	add_department_to_group $appartment $mixed_name
done < $file


echo "Total number of repeat user: ${#repeat_user_names[@]}"
for element in "${repeat_user_names[@]}"; do
	echo "User name: $element"
done


echo "Total number of users: ${#user_names[@]}"
for element in "${user_names[@]}"; do
	echo "User name: $element"
done


echo "Total number of departments: ${#department_groups[@]}"
for group in "${!department_groups[@]}"; do
	echo "Current department name: $group"
	groupUsers=${department_groups[$group]}
	
	IFS=',' read -ra array <<< "$groupUsers"
	echo "Total no of users: ${#array[@]}"
  	for element in "${array[@]}"; do
		echo "	Department users: $element"
  	done
  	echo -e 
done
