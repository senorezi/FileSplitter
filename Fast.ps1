#split test
$sw = new-object System.Diagnostics.Stopwatch
$sw.Start()
$filename = "C:\Users\Caleb\Desktop\Repo\MyProject\hello.txt"
$rootName = "C:\Users\Caleb\Desktop\Repo\MyProject\Fast\"

$linesperFile = 100
$filecount = 1

# Open the text file
$reader = [io.file]::OpenText($filename)

# Create the text file
$writer = [io.file]::CreateText("{0}{1}.{2}" -f ($rootName,$filecount.ToString("000"),".txt"))

# 
$filecount++
$linecount = 0

while($reader.EndOfStream -ne $true) {

    while( ($linecount -lt $linesperFile) -and ($reader.EndOfStream -ne $true)){
        $writer.WriteLine($reader.ReadLine());
        $linecount++
    }
    
    if($reader.EndOfStream -ne $true) {
        $writer.Dispose();
        $writer = [io.file]::CreateText("{0}{1}.{2}" -f ($rootName,$filecount.ToString("000"),".txt"))
        $filecount++
        $linecount = 0
    }
}

$writer.Dispose()
$reader.Dispose()

$sw.Stop()

Write-Host "Split complete in " $sw.Elapsed.TotalSeconds "seconds"