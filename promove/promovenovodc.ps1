#passo 1 

Rename-Computer -NewName <nome do DC> Restart-Computer -Force

#passo 2.1 

Sconfig: Definir ip;

#ou

#passo 2.1 Fixar IP: 

New-NetIPAddress –InterfaceIndex 12 –IPAddress 192.168.2.3 -PrefixLength 24 Set-DNSClientServerAddress –InterfaceIndex 10 -ServerAddresses 10.61.50.5

#passo 2.2 Desativar firewall: 

netsh firewall set opmode mode=DISABLE exception=DISABLE profile=ALL

#passo 2.3 Desativar IPV6 

Disable-NetAdapterBinding -InterfaceDescription (Get-NetAdapterBinding -componentid ms_tcpip6).InterfaceDescription -ComponentID ms_tcpip6

#passo 3 

Add-Computer -DomainName <domínio> -Credential (Get-Credential)

#passo 3.1 

Restart-Computer -Force

#passo 4 

Install-WindowsFeature -Name AD-Domain-Services 

#passo 5 

$Password = ConvertTo-SecureString -AsPlainText -String SenhaDominio -Force

#passo 5.1 

Install-ADDSDomainController -DomainName nomedoservidor.com.br -DatabasePath "%SYSTEMROOT%\NTDS" -LogPath "%SYSTEMROOT%\NTDS" -SysvolPath "%SYSTEMROOT%\SYSVOL" -InstallDns -ReplicationSourceDC nomedoservidordc.com.br  -SafeModeAdministratorPassword $Password -NoRebootOnCompletion

#passo 6 

Restart-Computer -Force #Get all the Domain Controllers Get-ADGroupMember "Domain Controllers"

#passo 7 

net view \\localhost