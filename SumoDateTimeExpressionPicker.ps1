############################################################
# generate sumo logic formatted timestamp string 
# to paste into the time field 
###########################################################

Add-Type -AssemblyName System.Windows.Forms

$timeformat="ddd dd/MM/yyyy HH:mm:ss"

# Main Form 
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Text = "Sumologic Date Expression Generator"
$mainForm.Width = 480
$mainForm.Height = 320


# DateTimePicker Label
$startPickerLabel = New-Object System.Windows.Forms.Label
$startPickerLabel.Location = "10,10"
$startPickerLabel.Height = 22
$startPickerLabel.Width = 100
$startPickerLabel.Text = "Start At"
$mainForm.Controls.Add($startPickerLabel)

# DateTimePicker
$startDatePicker = New-Object System.Windows.Forms.DateTimePicker
$startDatePicker.Location = "10,40"
$startDatePicker.MinDate = "01/01/2015"       # Minimum Date Dispalyed
#$startDatePicker.MaxDate = "12/31/2019"       # Maximum Date Dispalyed
$startDatePicker.Format = "Custom"
# $startDatePicker.ShowUpDown=$true better as a picker
$startDatePicker.CustomFormat = $timeformat

$mainForm.Controls.Add($startDatePicker)


# DateTimePicker end Label
$endPickerLabel = New-Object System.Windows.Forms.Label
$endPickerLabel.Location = "250,10"
$endPickerLabel.Height = 22
$endPickerLabel.Width = 100
$endPickerLabel.Text = "End At"
$mainForm.Controls.Add($endPickerLabel)


# DateTimePickerend
$endDatePicker = New-Object System.Windows.Forms.DateTimePicker
$endDatePicker.Location = "250,40"
$endDatePicker.MinDate = "01/01/2015"       # Minimum Date Dispalyed
#$endDatePicker.MaxDate = "31/12/2019"       # Maximum Date Dispalyed
$endDatePicker.Format = "Custom"
$endDatePicker.CustomFormat = $timeformat
$mainForm.Controls.Add($endDatePicker)


# DateBox1Label
$DateBox1Label = New-Object System.Windows.Forms.Label
$DateBox1Label.Location = "10,120"
$DateBox1Label.Height = 22
$DateBox1Label.Width = 100
$DateBox1Label.Text = 'mm/dd browser'
$mainForm.Controls.Add($DateBox1Label)


# TextBox
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = "140,120"
$textBox.Size = "250,30"
$textBox.ForeColor = "MediumBlue"
$textBox.BackColor = "White"
$textBox.font = "Arial"
$textBox.Text = " pick 2 dates and press update"
$textBox.ReadOnly=$true
$mainForm.Controls.Add($textBox)

# DateBox2Label
$DateBox2Label = New-Object System.Windows.Forms.Label
$DateBox2Label.Location = "10,160"
$DateBox2Label.Height = 22
$DateBox2Label.Width = 100
$DateBox2Label.Text = "dd/mm browser"
$mainForm.Controls.Add($DateBox2Label)

# TextBox for ddmm
$ddmmbox = New-Object System.Windows.Forms.TextBox
$ddmmbox.Location = "140,160"
$ddmmbox.Size = "250,30"
$ddmmbox.ForeColor = "MediumBlue"
$ddmmbox.BackColor = "White"
$ddmmbox.Text ="waiting for input"
$ddmmbox.ReadOnly=$true
$ddmmbox.font = "Arial"
$mainForm.Controls.Add($ddmmbox)

# minutes box
$minbox = New-Object System.Windows.Forms.TextBox
$minbox.Location = "140,200"
$minbox.Size = "100,30"
$minbox.ForeColor = "MediumBlue"
$minbox.BackColor = "White"
$minbox.Text =""
$minbox.ReadOnly=$true
$minbox.font = "Arial"
$mainForm.Controls.Add($minbox)

# hours box
$hbox = New-Object System.Windows.Forms.TextBox
$hbox.Location = "240,200"
$hbox.Size = "100,30"
$hbox.ForeColor = "MediumBlue"
$hbox.BackColor = "White"
$hbox.Text =""
$hbox.ReadOnly=$true
$hbox.font = "Arial"
$mainForm.Controls.Add($hbox)

# days box
$dbox = New-Object System.Windows.Forms.TextBox
$dbox.Location = "340,200"
$dbox.Size = "100,30"
$dbox.ForeColor = "MediumBlue"
$dbox.BackColor = "White"
$dbox.Text =""
$dbox.ReadOnly=$true
$dbox.font = "Arial"
$mainForm.Controls.Add($dbox)

# Time picker button
$dateTimePickerButton = New-Object System.Windows.Forms.Button 
$dateTimePickerButton.Location = "230,80"
$dateTimePickerButton.Size = "120,25"
$dateTimePickerButton.Text = "Update Time Boxes"

$dateTimePickerButton.add_Click({ 
		$fd=$startDatePicker.Value 
		$td=$endDatePicker.Value

    write-host $fd
    write-host "to"
    write-host $td

        If ($fd -ge $td) {
            write-host "error 'to' time must be greater than 'from' time" 
            $textBox.Text ="error 'to' time must be greater than 'from' time" 
            $ddmmbox.Text ="error 'to' time must be greater than 'from' time" 
            } 
        else {
              # write-host $fd.gettype()
           $textBox.Text ="$($fd.Day)/$($fd.Month)/$($fd.Year) $($fd.Hour):$($fd.Minute.ToString("00")):$($fd.Second.ToString("00")) to $($td.Day)/$($td.Month)/$($td.Year) $($td.Hour):$($td.Minute.ToString("00")):$($td.Second.ToString("00"))"
           write-host "mmdd=$($fd.Day)/$($fd.Month)/$($fd.Year) $($fd.Hour)):$($fd.Minute.ToString("00")):$($fd.Second.ToString("00")) to $($td.Day)/$($td.Month)/$($td.Year) $($td.Hour):$($td.Minute.ToString("00")):$($td.Second.ToString("00"))"
	       $ddmmbox.Text="$($fd.Month)/$($fd.Day)/$($fd.Year) $($fd.Hour):$($fd.Minute.ToString("00")):$($fd.Second.ToString("00")) to $($td.Month)/$($td.Day)/$($td.Year) $($td.Hour):$($td.Minute.ToString("00")):$($td.Second.ToString("00"))"
            write-host "ddmm=$($fd.Day)/$($fd.Month)/$($fd.Year) $($fd.Hour):$($fd.Minute.ToString("00")):$($fd.Second.ToString("00")) to $($td.Day)/$($td.Month)/$($td.Year) $($td.Hour):$($td.Minute.ToString("00")):$($td.Second.ToString("00"))"
            $now=get-date
           
            $m1=[math]::round(($fd - $now).TotalMinutes)
            $m2=[math]::round(($td - $Now).TotalMinutes)
            write-host "$($m1.tostring())m $($m2.tostring())m"

            $minbox.Text="$($m1.tostring())m $($m2.tostring())m"

            $m1=[math]::round(($fd - $now).TotalHours)
            $m2=[math]::round(($td - $Now).TotalHours)
            write-host "$($m1.tostring())h $($m2.tostring())h"

            $hbox.Text="$($m1.tostring())h $($m2.tostring())h"

            $m1=[math]::round(($fd - $now).TotalDays)
            $m2=[math]::round(($td - $Now).TotalDays)
            write-host "$($m1.tostring())d $($m2.tostring())d"

            $dbox.Text="$($m1.tostring())d $($m2.tostring())d"

         }
        })
$mainForm.Controls.Add($dateTimePickerButton)


# Exit Button 
$ExitButton = New-Object System.Windows.Forms.Button
$exitButton.Location = "350,80"
$exitButton.Size = "100,25"
$exitButton.Text = "Exit"
$exitButton.add_Click({$mainForm.close()})
$mainForm.Controls.Add($exitButton)

# HelpPanel
$HelpPanel = New-Object System.Windows.Forms.Label
$HelpPanel.Location = "10,240"
$HelpPanel.Height = 100
$HelpPanel.Width = 440
$HelpPanel.Text = "Sumologic currently has no date picker control on the web form. You can use this form to generate time expressions to paste in for US or UK/NZ browser settings."
$mainForm.Controls.Add($HelpPanel)


[void] $mainForm.ShowDialog()
[void] $mainForm.Activate()

