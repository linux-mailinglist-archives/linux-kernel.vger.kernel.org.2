Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E9C30E44B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhBCUxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 15:53:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:57850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232180AbhBCUv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:51:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF33064F72;
        Wed,  3 Feb 2021 20:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612385009;
        bh=LDpnowjaCV5J1z4IIF/cufund++wHUH7ZzQ8TG3uXNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QPYeaqhMCUwwkwWVMevZQGK5lBLUDuPdCVdWy3WOygEaOZ8i227jx4NRLSOXOvAer
         vCFdj5KyrW7R12Gqt/RfswrLo/6Eih8UEYamfz/iKJNuEbmkkYn3d4flB10Z/+jWKr
         N2iiuxKjPl7CoTkDfX2vbj40EF3C7PLBjjRko5PHb+SltjNl9PfQDNpBVUs64wHnJ8
         OQ2h5zv1MhI8s6osBUtVI15nqJTg8wv3MQzqYG66PDVz6heGmJfmw0q+gJ/CidItJz
         2kwIRRtj+rzEJeeS05S32HC583GVWqJWmMSfKRG/v1r/EfZT2cg9YXMLBehiy5Ohif
         yu4eIxtHdZ51Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BA68940513; Wed,  3 Feb 2021 17:43:25 -0300 (-03)
Date:   Wed, 3 Feb 2021 17:43:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, eranian@google.com, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        maddy@linux.vnet.ibm.com
Subject: Re: [PATCH 6/9] perf report: Support instruction latency
Message-ID: <20210203204325.GK854763@kernel.org>
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
 <1612296553-21962-7-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612296553-21962-7-git-send-email-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 02, 2021 at 12:09:10PM -0800, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The instruction latency information can be recorded on some platforms,
> e.g., the Intel Sapphire Rapids server. With both memory latency
> (weight) and the new instruction latency information, users can easily
> locate the expensive load instructions, and also understand the time
> spent in different stages. The users can optimize their applications
> in different pipeline stages.
> 
> The 'weight' field is shared among different architectures. Reusing the
> 'weight' field may impacts other architectures. Add a new field to store
> the instruction latency.
> 
> Like the 'weight' support, introduce a 'ins_lat' for the global
> instruction latency, and a 'local_ins_lat' for the local instruction
> latency version.

This one also had to be fixed up wrt code page size.
 
> Add new sort functions, INSTR Latency and Local INSTR Latency,
> accordingly.
> 
> Add local_ins_lat to the default_mem_sort_order[].
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-report.txt |  6 +++-
>  tools/perf/util/event.h                  |  1 +
>  tools/perf/util/evsel.c                  |  4 ++-
>  tools/perf/util/hist.c                   | 12 ++++++--
>  tools/perf/util/hist.h                   |  2 ++
>  tools/perf/util/intel-pt.c               |  5 ++--
>  tools/perf/util/session.c                |  8 ++++--
>  tools/perf/util/sort.c                   | 47 +++++++++++++++++++++++++++++++-
>  tools/perf/util/sort.h                   |  3 ++
>  tools/perf/util/synthetic-events.c       |  4 ++-
>  10 files changed, 81 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index 826b5a9..0565b7c 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -108,6 +108,9 @@ OPTIONS
>  	- period: Raw number of event count of sample
>  	- time: Separate the samples by time stamp with the resolution specified by
>  	--time-quantum (default 100ms). Specify with overhead and before it.
> +	- ins_lat: Instruction latency in core cycles. This is the global
> +	instruction latency
> +	- local_ins_lat: Local instruction latency version
>  
>  	By default, comm, dso and symbol keys are used.
>  	(i.e. --sort comm,dso,symbol)
> @@ -154,7 +157,8 @@ OPTIONS
>  	- blocked: reason of blocked load access for the data at the time of the sample
>  
>  	And the default sort keys are changed to local_weight, mem, sym, dso,
> -	symbol_daddr, dso_daddr, snoop, tlb, locked, blocked, see '--mem-mode'.
> +	symbol_daddr, dso_daddr, snoop, tlb, locked, blocked, local_ins_lat,
> +	see '--mem-mode'.
>  
>  	If the data file has tracepoint event(s), following (dynamic) sort keys
>  	are also available:
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index ff403ea..5d50a49 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -141,6 +141,7 @@ struct perf_sample {
>  	u16 insn_len;
>  	u8  cpumode;
>  	u16 misc;
> +	u16 ins_lat;
>  	bool no_hw_idx;		/* No hw_idx collected in branch_stack */
>  	char insn[MAX_INSN];
>  	void *raw_data;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 0a2a307..24c0b59 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2337,8 +2337,10 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  		weight.full = *array;
>  		if (type & PERF_SAMPLE_WEIGHT)
>  			data->weight = weight.full;
> -		else
> +		else {
>  			data->weight = weight.var1_dw;
> +			data->ins_lat = weight.var2_w;
> +		}
>  		array++;
>  	}
>  
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 6866ab0..8a432f8 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -209,6 +209,8 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
>  	hists__new_col_len(hists, HISTC_LOCAL_WEIGHT, 12);
>  	hists__new_col_len(hists, HISTC_GLOBAL_WEIGHT, 12);
>  	hists__new_col_len(hists, HISTC_MEM_BLOCKED, 10);
> +	hists__new_col_len(hists, HISTC_LOCAL_INS_LAT, 13);
> +	hists__new_col_len(hists, HISTC_GLOBAL_INS_LAT, 13);
>  	if (symbol_conf.nanosecs)
>  		hists__new_col_len(hists, HISTC_TIME, 16);
>  	else
> @@ -286,12 +288,13 @@ static long hist_time(unsigned long htime)
>  }
>  
>  static void he_stat__add_period(struct he_stat *he_stat, u64 period,
> -				u64 weight)
> +				u64 weight, u64 ins_lat)
>  {
>  
>  	he_stat->period		+= period;
>  	he_stat->weight		+= weight;
>  	he_stat->nr_events	+= 1;
> +	he_stat->ins_lat	+= ins_lat;
>  }
>  
>  static void he_stat__add_stat(struct he_stat *dest, struct he_stat *src)
> @@ -303,6 +306,7 @@ static void he_stat__add_stat(struct he_stat *dest, struct he_stat *src)
>  	dest->period_guest_us	+= src->period_guest_us;
>  	dest->nr_events		+= src->nr_events;
>  	dest->weight		+= src->weight;
> +	dest->ins_lat		+= src->ins_lat;
>  }
>  
>  static void he_stat__decay(struct he_stat *he_stat)
> @@ -591,6 +595,7 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
>  	int64_t cmp;
>  	u64 period = entry->stat.period;
>  	u64 weight = entry->stat.weight;
> +	u64 ins_lat = entry->stat.ins_lat;
>  	bool leftmost = true;
>  
>  	p = &hists->entries_in->rb_root.rb_node;
> @@ -609,11 +614,11 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
>  
>  		if (!cmp) {
>  			if (sample_self) {
> -				he_stat__add_period(&he->stat, period, weight);
> +				he_stat__add_period(&he->stat, period, weight, ins_lat);
>  				hist_entry__add_callchain_period(he, period);
>  			}
>  			if (symbol_conf.cumulate_callchain)
> -				he_stat__add_period(he->stat_acc, period, weight);
> +				he_stat__add_period(he->stat_acc, period, weight, ins_lat);
>  
>  			/*
>  			 * This mem info was allocated from sample__resolve_mem
> @@ -723,6 +728,7 @@ __hists__add_entry(struct hists *hists,
>  			.nr_events = 1,
>  			.period	= sample->period,
>  			.weight = sample->weight,
> +			.ins_lat = sample->ins_lat,
>  		},
>  		.parent = sym_parent,
>  		.filtered = symbol__parent_filter(sym_parent) | al->filtered,
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 522486b..36bca33 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -72,6 +72,8 @@ enum hist_column {
>  	HISTC_DSO_SIZE,
>  	HISTC_SYMBOL_IPC,
>  	HISTC_MEM_BLOCKED,
> +	HISTC_LOCAL_INS_LAT,
> +	HISTC_GLOBAL_INS_LAT,
>  	HISTC_NR_COLS, /* Last entry */
>  };
>  
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index a929f6d..c9477d0 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -1871,9 +1871,10 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
>  			 * cycles. Use latency >> 32 to distinguish the
>  			 * different format of the mem access latency field.
>  			 */
> -			if (weight > 0)
> +			if (weight > 0) {
>  				sample.weight = weight & 0xffff;
> -			else
> +				sample.ins_lat = items->mem_access_latency & 0xffff;
> +			} else
>  				sample.weight = items->mem_access_latency;
>  		}
>  		if (!sample.weight && items->has_tsx_aux_info) {
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index a35d8c2..330e591 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1297,8 +1297,12 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
>  	if (sample_type & PERF_SAMPLE_STACK_USER)
>  		stack_user__printf(&sample->user_stack);
>  
> -	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE)
> -		printf("... weight: %" PRIu64 "\n", sample->weight);
> +	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
> +		printf("... weight: %" PRIu64 "", sample->weight);
> +			if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT)
> +				printf(",0x%"PRIx16"", sample->ins_lat);
> +		printf("\n");
> +	}
>  
>  	if (sample_type & PERF_SAMPLE_DATA_SRC)
>  		printf(" . data_src: 0x%"PRIx64"\n", sample->data_src);
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 249a03c..e0529f2 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -36,7 +36,7 @@ const char	default_parent_pattern[] = "^sys_|^do_page_fault";
>  const char	*parent_pattern = default_parent_pattern;
>  const char	*default_sort_order = "comm,dso,symbol";
>  const char	default_branch_sort_order[] = "comm,dso_from,symbol_from,symbol_to,cycles";
> -const char	default_mem_sort_order[] = "local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked";
> +const char	default_mem_sort_order[] = "local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked,local_ins_lat";
>  const char	default_top_sort_order[] = "dso,symbol";
>  const char	default_diff_sort_order[] = "dso,symbol";
>  const char	default_tracepoint_sort_order[] = "trace";
> @@ -1365,6 +1365,49 @@ struct sort_entry sort_global_weight = {
>  	.se_width_idx	= HISTC_GLOBAL_WEIGHT,
>  };
>  
> +static u64 he_ins_lat(struct hist_entry *he)
> +{
> +		return he->stat.nr_events ? he->stat.ins_lat / he->stat.nr_events : 0;
> +}
> +
> +static int64_t
> +sort__local_ins_lat_cmp(struct hist_entry *left, struct hist_entry *right)
> +{
> +		return he_ins_lat(left) - he_ins_lat(right);
> +}
> +
> +static int hist_entry__local_ins_lat_snprintf(struct hist_entry *he, char *bf,
> +					      size_t size, unsigned int width)
> +{
> +		return repsep_snprintf(bf, size, "%-*u", width, he_ins_lat(he));
> +}
> +
> +struct sort_entry sort_local_ins_lat = {
> +	.se_header	= "Local INSTR Latency",
> +	.se_cmp		= sort__local_ins_lat_cmp,
> +	.se_snprintf	= hist_entry__local_ins_lat_snprintf,
> +	.se_width_idx	= HISTC_LOCAL_INS_LAT,
> +};
> +
> +static int64_t
> +sort__global_ins_lat_cmp(struct hist_entry *left, struct hist_entry *right)
> +{
> +		return left->stat.ins_lat - right->stat.ins_lat;
> +}
> +
> +static int hist_entry__global_ins_lat_snprintf(struct hist_entry *he, char *bf,
> +					       size_t size, unsigned int width)
> +{
> +		return repsep_snprintf(bf, size, "%-*u", width, he->stat.ins_lat);
> +}
> +
> +struct sort_entry sort_global_ins_lat = {
> +	.se_header	= "INSTR Latency",
> +	.se_cmp		= sort__global_ins_lat_cmp,
> +	.se_snprintf	= hist_entry__global_ins_lat_snprintf,
> +	.se_width_idx	= HISTC_GLOBAL_INS_LAT,
> +};
> +
>  struct sort_entry sort_mem_daddr_sym = {
>  	.se_header	= "Data Symbol",
>  	.se_cmp		= sort__daddr_cmp,
> @@ -1770,6 +1813,8 @@ static struct sort_dimension common_sort_dimensions[] = {
>  	DIM(SORT_CGROUP_ID, "cgroup_id", sort_cgroup_id),
>  	DIM(SORT_SYM_IPC_NULL, "ipc_null", sort_sym_ipc_null),
>  	DIM(SORT_TIME, "time", sort_time),
> +	DIM(SORT_LOCAL_INS_LAT, "local_ins_lat", sort_local_ins_lat),
> +	DIM(SORT_GLOBAL_INS_LAT, "ins_lat", sort_global_ins_lat),
>  };
>  
>  #undef DIM
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index 2b2645b..c92ca15 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -50,6 +50,7 @@ struct he_stat {
>  	u64			period_guest_sys;
>  	u64			period_guest_us;
>  	u64			weight;
> +	u64			ins_lat;
>  	u32			nr_events;
>  };
>  
> @@ -229,6 +230,8 @@ enum sort_type {
>  	SORT_CGROUP_ID,
>  	SORT_SYM_IPC_NULL,
>  	SORT_TIME,
> +	SORT_LOCAL_INS_LAT,
> +	SORT_GLOBAL_INS_LAT,
>  
>  	/* branch stack specific sort keys */
>  	__SORT_BRANCH_STACK,
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index bc16268..95401c9 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1557,8 +1557,10 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
>  
>  	if (type & PERF_SAMPLE_WEIGHT_TYPE) {
>  		*array = sample->weight;
> -		if (type & PERF_SAMPLE_WEIGHT_STRUCT)
> +		if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
>  			*array &= 0xffffffff;
> +			*array |= ((u64)sample->ins_lat << 32);
> +		}
>  		array++;
>  	}
>  
> -- 
> 2.7.4
> 

-- 

- Arnaldo
