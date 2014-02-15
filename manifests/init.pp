define windows_autologon
($username = $title, $password, $count) {
  $DefaultUserName = '$DefaultUserName'
  $DefaultPassword = '$DefaultPassword'
  $remoteRegBaseKey = '$remoteRegBaseKey'
  $remoteRegSubKey = '$remoteRegSubKey'
  $true = '$true'
  exec { "Set-autologon-${$username}":
    command   => "
      $DefaultUserName = \"${username}\"
      $DefaultPassword = \"${password}\"
      $remoteRegBaseKey = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey(\"LocalMachine\",\"\")
      $remoteRegSubKey = $remoteRegBaseKey.OpenSubKey(\"SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon\",$true)
      $remoteRegSubKey.SetValue(\"AutoAdminLogon\",1,[Microsoft.Win32.RegistryValueKind]::String)
      $remoteRegSubKey.SetValue(\"DefaultUserName\",$DefaultUserName,[Microsoft.Win32.RegistryValueKind]::String)
      $remoteRegSubKey.SetValue(\"DefaultPassword\",$DefaultPassword,[Microsoft.Win32.RegistryValueKind]::String)
      if (${count}) { $remoteRegSubKey.SetValue(\"AutoLogonCount\",${count},[Microsoft.Win32.RegistryValueKind]::DWord) }
    ",
    logoutput => true,
    provider  => powershell,
  }
  notify {"autologon-setup":
    message => "${username} is autologon user!",
  }
}