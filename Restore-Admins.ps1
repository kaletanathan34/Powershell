function Restore-LocalAdministratorGroup {
    param (
        [string[]]$UserAccounts
    )

    foreach ($user in $UserAccounts) {
        if (-not (Get-LocalGroupMember -Group "Administrators" | Where-Object {$_.Name -eq $user})) {
            try {
                Add-LocalGroupMember -Group "Administrators" -Member $user
                Write-Output "Successfully added $user to the Administrators group."
            } catch {
                Write-Output "Failed to add $user to the Administrators group. Error: $_"
            }
        } else {
            Write-Output "$user is already a member of the Administrators group."
        }
    }
}

# Example usage
$usersToRestore = @('DOMAIN\User1', 'DOMAIN\User2', 'LocalUser3')
Restore-LocalAdministratorGroup -UserAccounts $usersToRestore
