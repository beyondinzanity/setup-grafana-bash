# setup-grafana-bash

<H2>Download the zip-folder</H2>

```bash
wget {HTTPS-PATH to zipfolder with the bashscript}
```

Ezample:
```bash
wget https://github.com/beyondinzanity/setup-grafana-bash/archive/main.zip
```

```bash
sudo unzip thefile.zip -d /opt/target_dir
```

Example:
```bash
sudo unzip setup-autosetup-grafana.zip -d ~/Desktop
```

-----------------------------------------------------------------------------------------------------------------------------
<h2>Use the bash script</h2>
cd into the unzipped folder and give execute permissions to the autosetup-grafana script

```bash
sudo chmod 775 autosetup-grafana
```

Setup the config file to match your settings

Execute the script and follow the instructions in the terminal.

```bash
./autosetup-grafana
```

If the script does not run and throws the error => `{path}: bash\r` you have to convert the file from dos to unix 

```bash
sudo dos2unix autosetup-grafana
```

If `dos2unix` is not already installed you can do so with `sudo apt install dos2unix` 

-----------------------------------------------------------------------------------------------------------------------------
<h2>Update binray or config file</h2>
To update the the config file you can either change the config file in the downloaded zip-folder and run the script again
and then say yes to overwriting the config file that's already been setup.

The other option is to manually go to the config file at the path `/etc/grafana` and then use the `nano` command to edit the file

```bash
sudo nano config-grafana.yml
```

If you want to update the binary, first remove the binary from the zip-folder where the script is located. Then instsall a new binary from the original Grafana repo https://github.com/grafana/grafana-kiosk
then put the newly installed Grafana binary into the zip-folder and rename it to `grafana-kiosk-binary` just as the one was named before

Now you just have to run the script again and do the same as when you want to update the config file with the script

