#!/bin/bash



#1_FileOrganizer:

organize_files() {
    echo "Organizing files..."
    mkdir -p code docs media

    for file in *; do
        case "$file" in
            *.py|*.js|*.java) mv "$file" code/ ;;
            *.txt|*.md|*.pdf) mv "$file" docs/ ;;
            *.jpg|*.png|*.mp4) mv "$file" media/ ;;
        esac
    done

    echo "Files organized into subdirectories!"
}

#2_BackupScript:

create_backup() {
    echo "Creating a backup..."
    mkdir -p backups
    timestamp=$(date +'%Y%m%d_%H%M%S')
    backup_file="backups/backup_${timestamp}.tar.gz"
    tar -czf "$backup_file" .
    echo "Backup created: $backup_file"
}

#3_SystemHealthChecker:

check_system_health() {
    echo "Checking system health..."
    echo "Disk Usage:"
    df -h | grep '^/dev'
    echo
    echo "Memory Usage:"
    free -m
    echo
    echo "CPU Load:"
    uptime
    echo "System health check complete."
}

#4_ToDoListManager:

manage_todo_list() {
    echo "To-Do List Manager"
    echo "1. View tasks"
    echo "2. Add a task"
    echo "3. Remove a task"
    read -p "Select an option: " option

    case "$option" in
        1)
            echo "Tasks:"
            nl todo.txt
            ;;
        2)
            read -p "Enter new task: " task
            echo "$task" >> todo.txt
            echo "Task added."
            ;;
        3)
            nl todo.txt
	    read -p "Enter the line number to delete: " task_no
	    if [[ "$task_no" =~ ^[0-9]+$ ]] && [ "$task_no" -gt 0 ]; then
    		sed -i '' "${task_no}d" todo.txt
    		echo "Task no $task_no has been deleted from todo.txt."
	    else
    		echo "Invalid input. Please enter a positive number."
	    fi
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
}

#5_GitCommitAutomator:

automate_git_commit() {
    echo "Automating Git commit..."
    git add .
    read -p "Enter commit message (or press enter for default): " commit_msg
    if [ -z "$commit_msg" ]; then
        commit_msg="Automated commit on $(date)"
    fi
    git commit -m "$commit_msg"
    git push origin main
    echo "Changes pushed to remote repository."
}


#MainLogic:

main() {
    case "$1" in
        organize)
            organize_files
            ;;
        backup)
            create_backup
            ;;
        health)
            check_system_health
            ;;
        todo)
            manage_todo_list
            ;;
        commit)
            automate_git_commit
            ;;
        *)
            echo "Usage: $0 {organize|backup|health|todo|commit}"
            ;;
    esac
}

main "$1"
echo "[$(date)] Action: $1" >> script_log.txt
