# Stopwatch to keep tracking duration
$sw = new-object System.Diagnostics.Stopwatch
$sw.Start()

# Inputs
$textFile = "C:\Users\Caleb\Desktop\Repo\MyProject\hello.txt"
$directory = "C:\Users\Caleb\Desktop\Repo\MyProject\Slow\"
$linesPerFile = 100

# Get the contents of the file
$contents = Get-Content $textFile

# We need the total count to determine when we hit the end
$totalLineCount = $contents.Count

# Counters
$counter = 0 # Counter in the outermost loop
$every100Counter = 0 # Counter for every 100 files
$fileNameCounter = 1 # Counter for the name of each file that will be exported

# Where the batches of 100 lines will be in
$batchContents = @()

# Loop against each row
foreach ($c in $contents) {
    
    # Add the contents into here
    $batchContents += $c

    # If we hit the 100 files
    if ($counter -eq $linesPerFile) {
        $batchContents | ForEach-Object {
            $_ | Add-Content ($directory + "_$($fileNameCounter).txt")
        } 
        $fileNameCounter++
        $every100Counter = 0
        $batchContents = @()
    }

    $every100Counter++    
    $counter++

    # For the remainder if there is anything left outside of the last batch
    if ($originalCounter -ge $totalLineCount) {
        $diree = $directory + "_$($fileNameCounter+1).txt"
        $batchContents | ForEach-Object {
            $_ | Add-Content $diree
        }
    }
}
$sw.Stop()

Write-Host "Split complete in " $sw.Elapsed.TotalSeconds "seconds"