# Don't Starve Dedicated Server  

## SteamCmd Version  

### Step 1: Create a Klei Account and Game Server  

1. **Login to Klei account**:  
   [Klei Account Login](https://accounts.klei.com/)  

2. **Go to the game list**:  
   [Game List](https://accounts.klei.com/account/game/list)  

3. **Create a new game for Don't Starve Together**:  
   [Create Server](https://accounts.klei.com/account/game/servers?game=DontStarveTogether)  

---

## Step 2: Download and Set Up the Server  

1. **Download `MyDediServer/`**  
2. **Move it to the folder**:  
```plaintext
./.klei/DoNotStarveTogether/
```

---

## Step 3: Start the Server  

Run the following command:  
```sh
docker compose up -d
```

---

## [IF YOU WANT TO RUN MODS]  

### Step 1: Remove Validation from `run_dedicated_server.sh`  

We need to remove the validation step to prevent Steam from overwriting the necessary files for enabling mod downloads. Having the `"validate"` command within the update command will overwrite the `dedicated_server_mods_setup.lua`.  

#### Steps:  

1. Navigate to your **Don't Starve Together** install directory (e.g., `/home/steam/steamapps/DST`).  
2. Open the server script:  
   ```sh
   nano run_dedicated_server.sh
   ```
3.	Locate the following line:
   ```sh
   steamcmd +force_install_dir "$install_dir" +login anonymous +app_update 343050 validate +quit
   ```
4.	Remove the word "validate" from the command.
5.	Save and exit the file.

### Step 2: Enable Linux Server Mods

Follow this guide to install, configure, and update mods for the dedicated server:
How to Install/Configure and Update Mods

---

## Reference  
- [Updated Dedicated Server Quick Setup Guide (Linux, 2022)](https://forums.kleientertainment.com/forums/topic/140715-2022-updated-dedicated-server-quick-setup-guide-linux/)  
- [SteamCmd Docker Hub](https://hub.docker.com/r/steamcmd/steamcmd/tags)  
- [YouTube Setup Guide](https://www.youtube.com/watch?v=87az8KCmU04)  
