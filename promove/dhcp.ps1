#Step 1 

Install-WindowsFeature -Name "DHCP" -IncludeManagementTools

#Step 2 

net stop dhcpserver && net start dhcpserver

#Executar em servidores 2012 R2:

#Sept 3 

Export-DhcpServer –ComputerName <FQDN server de origem> -Leases -File <XML file path> -verbose

#Step 4 

Import-DhcpServer –ComputerName <FQDN server de destino> -Leases –File <XML file path> -BackupPath <BKP file path> -Verbose