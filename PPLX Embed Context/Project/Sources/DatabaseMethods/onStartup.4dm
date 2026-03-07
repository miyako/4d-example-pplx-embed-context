/*

callbacks for downloader (alert on error)

*/

var $event : cs:C1710.event.event
$event:=cs:C1710.event.event.new()
$event.onError:=Formula:C1597(ALERT:C41($2.message))
//$event.onSuccess:=Formula(ALERT($2.models.extract("name").join(",")+" loaded!"))
$event.onData:=Formula:C1597(LOG EVENT:C667(Into 4D debug message:K38:5; This:C1470.file.fullName+":"+String:C10((This:C1470.range.end/This:C1470.range.length)*100; "###.00%")))
$event.onResponse:=Formula:C1597(LOG EVENT:C667(Into 4D debug message:K38:5; This:C1470.file.fullName+":download complete"))
$event.onTerminate:=Formula:C1597(LOG EVENT:C667(Into 4D debug message:K38:5; (["process"; $1.pid; "terminated!"].join(" "))))

var $options : Object
var $huggingfaces : cs:C1710.event.huggingfaces
var $folder : 4D:C1709.Folder
var $path : Text
var $URL : Text
var $pooling : Text

/*

ONNX Runtime: 

use int8 quantisation

*/

$homeFolder:=Folder:C1567(fk home folder:K87:24).folder(".ONNX")
$port:=8081
$options:={pooling: "mean"}

$folder:=$homeFolder.folder("pplx-embed-context-v1-0.6b")
$path:="pplx-embed-context-v1-0.6b-onnx-int8"
$URL:="keisuke-miyako/pplx-embed-context-v1-0.6b-onnx-int8"

$huggingface:=cs:C1710.event.huggingface.new($folder; $URL; $path; "embedding"; ($URL="@-f16" || ($URL="@-f32")) ? "model.onnx" : "model_quantized.onnx")
$huggingfaces:=cs:C1710.event.huggingfaces.new([$huggingface])

$ONNX:=cs:C1710.ONNX.ONNX.new($port; $huggingfaces; $homeFolder; $options; $event)