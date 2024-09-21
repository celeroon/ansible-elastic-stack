#!/bin/bash

# Define the directories and output files for the three commands
declare -A RULES_DIRS_OUTPUTS=(
    ["rules/windows"]="/setup-vm/rules-windows.ndjson"
    ["rules-emerging-threats"]="/setup-vm/rules-emerging-threats.ndjson"
    ["rules-threat-hunting/windows"]="/setup-vm/rules-threat-hunting-windows.ndjson"
)

# Loop through each rules directory and process the files individually
for RULES_DIR in "${!RULES_DIRS_OUTPUTS[@]}"; do
    OUTPUT_FILE="${RULES_DIRS_OUTPUTS[$RULES_DIR]}"

    # Clear the output file at the start of each conversion
    > "$OUTPUT_FILE"

    # Find all .yml files in the current rules directory and loop through each one
    find "$RULES_DIR" -name "*.yml" | while read -r rule; do
        
        # Capture the output (both stdout and stderr) from the sigma convert command
        OUTPUT=$(sigma convert --target lucene --pipeline ecs_windows --format siem_rule_ndjson "$rule" 2>&1)

        # Check if "Error" is present in the output
        if echo "$OUTPUT" | grep -q "Error"; then
            # Print error message and skip this rule if there's an error
            echo "Error: Conversion failed for rule $rule"
            continue
        fi

        # Append the successfully converted rule to the output file
        echo "$OUTPUT" >> "$OUTPUT_FILE"

        # Print success message
        echo "Successfully converted rule: $rule"
    done

    echo "Finished processing rules in $RULES_DIR and outputting to $OUTPUT_FILE"
done
