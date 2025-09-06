# 🗂️ Obsidian Sync

Keep your Obsidian notes safe and synced to GitHub automatically.  
This script handles commits and pushes for you, so you never lose your work.  

---

## ⚡ Features
- Automatic Git commit & push  
- SSH key support (no password typing)  
- Clean, minimal output

---

## 🛠️ Requirements
- Git installed  
- Obsidian vault folder  
- SSH key linked to GitHub  

---

## ⚙️ Setup
1. Clone the repo:
```bash
git clone git@github.com:your-username/obsidian-backup.git
cd obsidian-backup
```

2. Make the script executable:
```bash
chmod +x obsidian-sync.sh
```

3. Configure your SSH key (optional if using default ~/.ssh/id_rsa):
```bash
cp .env.example .env
nano .env
```
Set GITHUB_PRIVATE_SSH_KEY_PATH to your SSH private key path.

---
 
## 🚀 Usage

Run the script from inside your Obsidian vault folder:
```bash
./obsidian-sync.sh
```

[TODO: Add example output here]


---

## 💡 Notes / Troubleshooting

- Make sure your SSH key is loaded:
```bash
ssh-add -l
```
- Ensure your GitHub repo is initialized and the correct branch is set.
- Always run the script from inside your vault folder.


---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.