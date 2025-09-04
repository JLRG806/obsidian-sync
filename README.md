# 🗂️ Obsidian Sync

A simple script to **automatically back up your Obsidian notes to GitHub**.  

---

## Features
- Automatic Git commit & push  
- SSH key support (no password typing)  

---

## Requirements
- Git installed  
- Obsidian vault folder  
- SSH key linked to GitHub

---

## Setup
```bash
git clone git@github.com:your-username/obsidian-backup.git
cd obsidian-backup
chmod +x obsidian-backup.sh
```
## Usage

Run inside your vault:
```bash
./obsidian-backup.sh
```
