# ootb_vllm



# ootb_vllm
model	latency	latency_per_tkn	tp	batch_size	input_len	output_len	dtype
Meta-Llama-3-8B	                       	1	1	2048	1	float16
Meta-Llama-3-8B	                       	1	2	2048	1	float16
Meta-Llama-3-8B	                       	1	4	2048	1	float16
Meta-Llama-3-8B	                       	1	8	2048	1	float16
Meta-Llama-3-8B	                       	1	16	2048	1	float16
Meta-Llama-3-8B	                       	1	32	2048	1	float16
Meta-Llama-3-8B	                       	1	1	1	128	float16
Meta-Llama-3-8B	                       	1	2	1	128	float16
Meta-Llama-3-8B	                       	1	4	1	128	float16
Meta-Llama-3-8B	                       	1	8	1	128	float16
Meta-Llama-3-8B	                       	1	16	1	128	float16
Meta-Llama-3-8B	                       	1	32	1	128	float16

# ootb_vllm
model	tot_throughput	gen_throughput	tp	requests	num_prompts	input_len	output_len
Meta-Llama-3-8B	            	1	100	128	128	float16
Meta-Llama-3-8B	            1	100	2048	128	float16
Meta-Llama-3-8B	            	1	100	128	2048	float16
Meta-Llama-3-8B	            	1	100	2048	2048	float16

