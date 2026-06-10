<!-- markdownlint-disable MD041 -->
![Version][version-shield]
![Project Stage][project-stage-shield]
![Maintained][maintenance-shield]

[![Community Forum][forum-shield]][forum]
[![Buy me a coffee][buymeacoffee-shield]][buymeacoffee]

# NPM Export Import

Back up and restore your [Nginx Proxy Manager](https://nginxproxymanager.com/) configuration via a built-in web UI. Export files are stored as JSON in Home Assistant's shared `/share/npm-export-import/` folder.

## What Gets Exported / Imported

| Entity | Exported | Imported | Notes |
| --- | --- | --- | --- |
| Proxy Hosts | Yes | Yes | Full config including custom Nginx; certs require manual setup |
| Redirection Hosts | Yes | Yes | |
| TCP/UDP Streams | Yes | Yes | |
| Access Lists | Yes | Yes | HTTP Basic Auth + IP rules |
| SSL Certificates | No | No | Configure manually in NPM; use "Request SSL" checkbox to obtain new LE certs |
| Users | No | No | NPM API does not support creating users with known passwords |

## Configuration

NPM server connections are managed in the add-on web UI under the **Configuration** tab.
Each server entry requires a name, URL, username, and password. Multiple servers can
be added — use the **Source Server** and **Target Server** dropdowns on the
Operations tab to select which NPM instance to export from or import into.

## Usage

Open the add-on web UI from the Home Assistant sidebar or the add-on page.

### Export

Click **Export Now**. The add-on authenticates to NPM, fetches all configuration, and writes a timestamped JSON file:

```text
/share/npm-export-import/npm-export-20260101T120000Z.json
```

### Import

Previously exported files appear in the **Import** section of the UI. Click **Import** next to the file you want to restore.

The import runs in this order to preserve references:

1. SSL certificates (from exported cert files)
2. Access lists
3. Proxy hosts (with remapped access list and certificate IDs)
4. Redirection hosts
5. Streams

**Important:** Import creates new entries — it does not check for duplicates. Run against a fresh NPM instance or one you have already cleared.

## Server Config Backup

NPM Export Import now supports exporting and importing your server connections (URLs,
usernames, passwords) for easy migration or backup.

### Export Server Config

1. Open the app and navigate to the **Configuration** tab
2. Scroll to **Server Config Backup** → **Export**
3. (Optional) Add a custom label to identify the backup (e.g., "home-lab", "before-migration")
4. (Optional) Enter a password to encrypt the export with AES-256-GCM
5. Click **Export Server Config** — a JSON file is generated and saved to `/share/npm-export-import/`
6. Click the filename link to download the file

**Security note:** Exporting without a password includes server credentials in plaintext JSON.
Use encryption if the file will be stored or transmitted over untrusted channels.

### Import Server Config

1. Go to **Configuration** → **Server Config Backup** → **Import**
2. Select a previously exported file from the dropdown (or upload one — see below)
3. (Optional) Enter the password if the file is encrypted
4. Choose import mode:
   - **Merge** (default) — adds new servers; skips any whose name already exists
   - **Replace all** — deletes all current servers and imports the file's list
5. Click **Import Server Config**
6. Confirm the count of imported/skipped servers

### Upload Server Config File

If you have a server config file on your local computer (e.g., from a previous export):

1. Go to **Configuration** → **Server Config Backup** → **Upload**
2. Click **Choose File** and select a `.json` file
3. Click **Upload File**
4. The file appears in the Import file selector immediately

## File Location

Export files land in `/share/npm-export-import/` on the HA host, accessible via:

- **Samba add-on** — browse to the `share` folder
- **SSH add-on** — `/share/npm-export-import/`

[version-shield]: https://img.shields.io/badge/version-0.3.3-blue.svg
[project-stage-shield]: https://img.shields.io/badge/project%20stage-experimental-yellow.svg
[maintenance-shield]: https://img.shields.io/maintenance/yes/2026.svg
[forum-shield]: https://img.shields.io/badge/community-forum-brightgreen.svg
[forum]: https://community.home-assistant.io
[buymeacoffee-shield]: https://img.shields.io/badge/buy%20me%20a%20coffee-donate-yellow.svg
[buymeacoffee]: https://www.buymeacoffee.com/slopsynclabs
