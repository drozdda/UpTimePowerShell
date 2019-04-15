Function Get-Uptime {
Param ( [string] $ComputerName = $env:COMPUTERNAME )
$os = Get-WmiObject win32_operatingsystem -ComputerName $ComputerName -ErrorAction SilentlyContinue
	if ($os.LastBootUpTime) {
		$uptime = (Get-Date) - $os.ConvertToDateTime($os.LastBootUpTime)
		[PSCustomObject]@{
		    LastBoot = $os.ConvertToDateTime($os.LastBootUpTime)
		    UpTime = Get-Date -Days $uptime.Days -Hours $uptime.Hours -Minutes $uptime.Minutes
		}
	}
	else {
		Write-Warning "Unable to connect to $computername"
	}
}