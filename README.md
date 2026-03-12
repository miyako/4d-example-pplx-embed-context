## [perplexity-ai/pplx-embed-context-v1-0.6b](https://huggingface.co/perplexity-ai/pplx-embed-context-v1-0.6b)

**PPLX Embed** is a text embedding model released by **Perplexity AI** in 2026. 

|`max_position_embeddings`|`hidden_size`|`num_hidden_layers`|`pooling`
|-:|-:|-:|-:|
|`32768`|`1024`|`28`|`mean`

```4d
var $en; $fr : 4D.Vector
var $AIClient : cs.AIKit.OpenAI
var $cosineSimilarity : Real
$AIClient:=cs.AIKit.OpenAI.new()

$AIClient.baseURL:="http://127.0.0.1:8081/v1/contextualized"  // onnx-genai

$inputs:=[\
[\
"Acme Corp announced its Q3 earnings today. "; \
"CEO Jane Doe stated that revenue dropped by 20%, but should recover next quarter. "; \
"She is highly optimistic."\
]; \
[\
"Sara thinks the rain will stop by noon. "; \
"She is highly optimistic."\
]]

$batch:=$AIClient.embeddings.create($inputs)

$d1s1:=$batch.embeddings[0].embedding
$d1s2:=$batch.embeddings[1].embedding
$d1s3:=$batch.embeddings[2].embedding  //She is highly optimistic.
$d2s1:=$batch.embeddings[3].embedding
$d2s2:=$batch.embeddings[4].embedding  //She is highly optimistic.

$cosineSimilarity1:=$d1s2.cosineSimilarity($d1s3)
//0.9182668966287
$cosineSimilarity2:=$d1s2.cosineSimilarity($d2s2)
//0.2638508626077

/*
	even though the text was identical, the cosine similarity is very different
	"she" is referrring to differnt people and
	"highly optimistic" is about different things
*/
```
