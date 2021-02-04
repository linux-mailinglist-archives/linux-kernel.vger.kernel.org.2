Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AE930F632
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbhBDPXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:23:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:40405 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237245AbhBDPVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:21:24 -0500
IronPort-SDR: jcNa8fwHmM+HyeQu8zkYkqmH7Y8G8Ijvaat7wb1aTSmBMX9JwFMK8UkES6xzvJpXsJRlz2SbNG
 XdyP3ptcnfuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="177754008"
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="177754008"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 07:19:37 -0800
IronPort-SDR: ltUyQwyzRkUYMZImBiv7vG2c5Xn3iIa3pz8AFjYdLAdQu8fXdMRTdlK5cqj5UaETTvrFOn7Rn2
 MJ6Ur+V0oMpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="393216673"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 04 Feb 2021 07:19:37 -0800
Received: from [10.251.24.66] (kliang2-MOBL.ccr.corp.intel.com [10.251.24.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 4DE1258087A;
        Thu,  4 Feb 2021 07:19:36 -0800 (PST)
Subject: Re: [PATCH 6/9] perf report: Support instruction latency
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, eranian@google.com,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, maddy@linux.vnet.ibm.com
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
 <1612296553-21962-7-git-send-email-kan.liang@linux.intel.com>
 <A90940CE-3DFB-4774-BA46-0C5FEB4953A0@linux.vnet.ibm.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <27633871-eda5-7faa-8783-84dd49f8a6cd@linux.intel.com>
Date:   Thu, 4 Feb 2021 10:19:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <A90940CE-3DFB-4774-BA46-0C5FEB4953A0@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/2021 8:11 AM, Athira Rajeev wrote:
> 
> 
>> On 03-Feb-2021, at 1:39 AM, kan.liang@linux.intel.com wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The instruction latency information can be recorded on some platforms,
>> e.g., the Intel Sapphire Rapids server. With both memory latency
>> (weight) and the new instruction latency information, users can easily
>> locate the expensive load instructions, and also understand the time
>> spent in different stages. The users can optimize their applications
>> in different pipeline stages.
>>
>> The 'weight' field is shared among different architectures. Reusing the
>> 'weight' field may impacts other architectures. Add a new field to store
>> the instruction latency.
>>
>> Like the 'weight' support, introduce a 'ins_lat' for the global
>> instruction latency, and a 'local_ins_lat' for the local instruction
>> latency version.
>>
>> Add new sort functions, INSTR Latency and Local INSTR Latency,
>> accordingly.
>>
>> Add local_ins_lat to the default_mem_sort_order[].
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>> tools/perf/Documentation/perf-report.txt |  6 +++-
>> tools/perf/util/event.h                  |  1 +
>> tools/perf/util/evsel.c                  |  4 ++-
>> tools/perf/util/hist.c                   | 12 ++++++--
>> tools/perf/util/hist.h                   |  2 ++
>> tools/perf/util/intel-pt.c               |  5 ++--
>> tools/perf/util/session.c                |  8 ++++--
>> tools/perf/util/sort.c                   | 47 +++++++++++++++++++++++++++++++-
>> tools/perf/util/sort.h                   |  3 ++
>> tools/perf/util/synthetic-events.c       |  4 ++-
>> 10 files changed, 81 insertions(+), 11 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
>> index 826b5a9..0565b7c 100644
>> --- a/tools/perf/Documentation/perf-report.txt
>> +++ b/tools/perf/Documentation/perf-report.txt
>> @@ -108,6 +108,9 @@ OPTIONS
>> 	- period: Raw number of event count of sample
>> 	- time: Separate the samples by time stamp with the resolution specified by
>> 	--time-quantum (default 100ms). Specify with overhead and before it.
>> +	- ins_lat: Instruction latency in core cycles. This is the global
>> +	instruction latency
>> +	- local_ins_lat: Local instruction latency version
>>
>> 	By default, comm, dso and symbol keys are used.
>> 	(i.e. --sort comm,dso,symbol)
>> @@ -154,7 +157,8 @@ OPTIONS
>> 	- blocked: reason of blocked load access for the data at the time of the sample
>>
>> 	And the default sort keys are changed to local_weight, mem, sym, dso,
>> -	symbol_daddr, dso_daddr, snoop, tlb, locked, blocked, see '--mem-mode'.
>> +	symbol_daddr, dso_daddr, snoop, tlb, locked, blocked, local_ins_lat,
>> +	see '--mem-mode'.
>>
>> 	If the data file has tracepoint event(s), following (dynamic) sort keys
>> 	are also available:
>> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
>> index ff403ea..5d50a49 100644
>> --- a/tools/perf/util/event.h
>> +++ b/tools/perf/util/event.h
>> @@ -141,6 +141,7 @@ struct perf_sample {
>> 	u16 insn_len;
>> 	u8  cpumode;
>> 	u16 misc;
>> +	u16 ins_lat;
>> 	bool no_hw_idx;		/* No hw_idx collected in branch_stack */
>> 	char insn[MAX_INSN];
>> 	void *raw_data;
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index 0a2a307..24c0b59 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -2337,8 +2337,10 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>> 		weight.full = *array;
>> 		if (type & PERF_SAMPLE_WEIGHT)
>> 			data->weight = weight.full;
>> -		else
>> +		else {
>> 			data->weight = weight.var1_dw;
>> +			data->ins_lat = weight.var2_w;
>> +		}
>> 		array++;
>> 	}
>>
>> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
>> index 6866ab0..8a432f8 100644
>> --- a/tools/perf/util/hist.c
>> +++ b/tools/perf/util/hist.c
>> @@ -209,6 +209,8 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
>> 	hists__new_col_len(hists, HISTC_LOCAL_WEIGHT, 12);
>> 	hists__new_col_len(hists, HISTC_GLOBAL_WEIGHT, 12);
>> 	hists__new_col_len(hists, HISTC_MEM_BLOCKED, 10);
>> +	hists__new_col_len(hists, HISTC_LOCAL_INS_LAT, 13);
>> +	hists__new_col_len(hists, HISTC_GLOBAL_INS_LAT, 13);
>> 	if (symbol_conf.nanosecs)
>> 		hists__new_col_len(hists, HISTC_TIME, 16);
>> 	else
>> @@ -286,12 +288,13 @@ static long hist_time(unsigned long htime)
>> }
>>
>> static void he_stat__add_period(struct he_stat *he_stat, u64 period,
>> -				u64 weight)
>> +				u64 weight, u64 ins_lat)
>> {
>>
>> 	he_stat->period		+= period;
>> 	he_stat->weight		+= weight;
>> 	he_stat->nr_events	+= 1;
>> +	he_stat->ins_lat	+= ins_lat;
>> }
>>
>> static void he_stat__add_stat(struct he_stat *dest, struct he_stat *src)
>> @@ -303,6 +306,7 @@ static void he_stat__add_stat(struct he_stat *dest, struct he_stat *src)
>> 	dest->period_guest_us	+= src->period_guest_us;
>> 	dest->nr_events		+= src->nr_events;
>> 	dest->weight		+= src->weight;
>> +	dest->ins_lat		+= src->ins_lat;
>> }
>>
>> static void he_stat__decay(struct he_stat *he_stat)
>> @@ -591,6 +595,7 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
>> 	int64_t cmp;
>> 	u64 period = entry->stat.period;
>> 	u64 weight = entry->stat.weight;
>> +	u64 ins_lat = entry->stat.ins_lat;
>> 	bool leftmost = true;
>>
>> 	p = &hists->entries_in->rb_root.rb_node;
>> @@ -609,11 +614,11 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
>>
>> 		if (!cmp) {
>> 			if (sample_self) {
>> -				he_stat__add_period(&he->stat, period, weight);
>> +				he_stat__add_period(&he->stat, period, weight, ins_lat);
>> 				hist_entry__add_callchain_period(he, period);
>> 			}
>> 			if (symbol_conf.cumulate_callchain)
>> -				he_stat__add_period(he->stat_acc, period, weight);
>> +				he_stat__add_period(he->stat_acc, period, weight, ins_lat);
>>
>> 			/*
>> 			 * This mem info was allocated from sample__resolve_mem
>> @@ -723,6 +728,7 @@ __hists__add_entry(struct hists *hists,
>> 			.nr_events = 1,
>> 			.period	= sample->period,
>> 			.weight = sample->weight,
>> +			.ins_lat = sample->ins_lat,
>> 		},
>> 		.parent = sym_parent,
>> 		.filtered = symbol__parent_filter(sym_parent) | al->filtered,
>> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
>> index 522486b..36bca33 100644
>> --- a/tools/perf/util/hist.h
>> +++ b/tools/perf/util/hist.h
>> @@ -72,6 +72,8 @@ enum hist_column {
>> 	HISTC_DSO_SIZE,
>> 	HISTC_SYMBOL_IPC,
>> 	HISTC_MEM_BLOCKED,
>> +	HISTC_LOCAL_INS_LAT,
>> +	HISTC_GLOBAL_INS_LAT,
>> 	HISTC_NR_COLS, /* Last entry */
>> };
>>
>> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
>> index a929f6d..c9477d0 100644
>> --- a/tools/perf/util/intel-pt.c
>> +++ b/tools/perf/util/intel-pt.c
>> @@ -1871,9 +1871,10 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
>> 			 * cycles. Use latency >> 32 to distinguish the
>> 			 * different format of the mem access latency field.
>> 			 */
>> -			if (weight > 0)
>> +			if (weight > 0) {
>> 				sample.weight = weight & 0xffff;
>> -			else
>> +				sample.ins_lat = items->mem_access_latency & 0xffff;
>> +			} else
>> 				sample.weight = items->mem_access_latency;
>> 		}
>> 		if (!sample.weight && items->has_tsx_aux_info) {
>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>> index a35d8c2..330e591 100644
>> --- a/tools/perf/util/session.c
>> +++ b/tools/perf/util/session.c
>> @@ -1297,8 +1297,12 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
>> 	if (sample_type & PERF_SAMPLE_STACK_USER)
>> 		stack_user__printf(&sample->user_stack);
>>
>> -	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE)
>> -		printf("... weight: %" PRIu64 "\n", sample->weight);
>> +	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
>> +		printf("... weight: %" PRIu64 "", sample->weight);
>> +			if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT)
>> +				printf(",0x%"PRIx16"", sample->ins_lat);
>> +		printf("\n");
>> +	}
>>
>> 	if (sample_type & PERF_SAMPLE_DATA_SRC)
>> 		printf(" . data_src: 0x%"PRIx64"\n", sample->data_src);
>> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
>> index 249a03c..e0529f2 100644
>> --- a/tools/perf/util/sort.c
>> +++ b/tools/perf/util/sort.c
>> @@ -36,7 +36,7 @@ const char	default_parent_pattern[] = "^sys_|^do_page_fault";
>> const char	*parent_pattern = default_parent_pattern;
>> const char	*default_sort_order = "comm,dso,symbol";
>> const char	default_branch_sort_order[] = "comm,dso_from,symbol_from,symbol_to,cycles";
>> -const char	default_mem_sort_order[] = "local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked";
>> +const char	default_mem_sort_order[] = "local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked,local_ins_lat";
>> const char	default_top_sort_order[] = "dso,symbol";
>> const char	default_diff_sort_order[] = "dso,symbol";
>> const char	default_tracepoint_sort_order[] = "trace";
>> @@ -1365,6 +1365,49 @@ struct sort_entry sort_global_weight = {
>> 	.se_width_idx	= HISTC_GLOBAL_WEIGHT,
>> };
>>
>> +static u64 he_ins_lat(struct hist_entry *he)
>> +{
>> +		return he->stat.nr_events ? he->stat.ins_lat / he->stat.nr_events : 0;
>> +}
>> +
>> +static int64_t
>> +sort__local_ins_lat_cmp(struct hist_entry *left, struct hist_entry *right)
>> +{
>> +		return he_ins_lat(left) - he_ins_lat(right);
>> +}
>> +
>> +static int hist_entry__local_ins_lat_snprintf(struct hist_entry *he, char *bf,
>> +					      size_t size, unsigned int width)
>> +{
>> +		return repsep_snprintf(bf, size, "%-*u", width, he_ins_lat(he));
>> +}
>> +
>> +struct sort_entry sort_local_ins_lat = {
>> +	.se_header	= "Local INSTR Latency",
>> +	.se_cmp		= sort__local_ins_lat_cmp,
>> +	.se_snprintf	= hist_entry__local_ins_lat_snprintf,
>> +	.se_width_idx	= HISTC_LOCAL_INS_LAT,
>> +};
> 
> Hi Kan Liang,
> 
> Currently with this changes, perf will display "Local INSTR Latency”  for the new column in ‘perf mem report’
> 
> Can we make this header string to be Architecture Specific ?

I don't think current perf supports an arch specific header string. It 
sounds like a new feature. I think it's a good feature.

Besides the instruction latency, we also introduce a 'block' field for 
perf mem. I'm not sure if the field applies for PowerPC. You may want to 
check it as well.

Could you please propose a patch to implement the feature? I think we 
can have a further discussion based on it.

> Because in other archs, the var2_w of ‘perf_sample_weight’ could be used to capture something else than the Local INSTR Latency.
> Can we have some weak function to populate the header string ?
> 

I agree that the var2_w has different meanings among architectures. We 
should not force it to data->ins_lat.

The patch as below should fix it. Does it work for you?

diff --git a/tools/perf/arch/x86/util/event.c 
b/tools/perf/arch/x86/util/event.c
index 047dc00..9b31734 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -75,3 +75,28 @@ int perf_event__synthesize_extra_kmaps(struct 
perf_tool *tool,
  }

  #endif
+
+void arch_perf_parse_sample_weight(struct perf_sample *data,
+				   const __u64 *array, u64 type)
+{
+	union perf_sample_weight weight;
+
+	weight.full = *array;
+	if (type & PERF_SAMPLE_WEIGHT)
+		data->weight = weight.full;
+	else {
+		data->weight = weight.var1_dw;
+		data->ins_lat = weight.var2_w;
+	}
+}
+
+void arch_perf_synthesize_sample_weight(const struct perf_sample *data,
+					__u64 *array, u64 type)
+{
+	*array = data->weight;
+
+	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
+		*array &= 0xffffffff;
+		*array |= ((u64)data->ins_lat << 32);
+	}
+}
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 60752e4..9f123aa 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -414,4 +414,7 @@ extern unsigned int proc_map_timeout;
  #define PAGE_SIZE_NAME_LEN	32
  char *get_page_size_name(u64 size, char *str);

+void arch_perf_parse_sample_weight(struct perf_sample *data, const 
__u64 *array, u64 type);
+void arch_perf_synthesize_sample_weight(const struct perf_sample *data, 
__u64 *array, u64 type);
+
  #endif /* __PERF_RECORD_H */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 30b5452..1da8903 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2106,6 +2106,13 @@ perf_event__check_size(union perf_event *event, 
unsigned int sample_size)
  	return 0;
  }

+void __weak arch_perf_parse_sample_weight(struct perf_sample *data,
+					  const __u64 *array,
+					  u64 type __maybe_unused)
+{
+	data->weight = *array;
+}
+
  int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
  			struct perf_sample *data)
  {
@@ -2347,16 +2354,8 @@ int evsel__parse_sample(struct evsel *evsel, 
union perf_event *event,
  	}

  	if (type & PERF_SAMPLE_WEIGHT_TYPE) {
-		union perf_sample_weight weight;
-
  		OVERFLOW_CHECK_u64(array);
-		weight.full = *array;
-		if (type & PERF_SAMPLE_WEIGHT)
-			data->weight = weight.full;
-		else {
-			data->weight = weight.var1_dw;
-			data->ins_lat = weight.var2_w;
-		}
+		arch_perf_parse_sample_weight(data, array, type);
  		array++;
  	}

diff --git a/tools/perf/util/synthetic-events.c 
b/tools/perf/util/synthetic-events.c
index c6f9db3..412f4c3 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1507,6 +1507,12 @@ size_t perf_event__sample_event_size(const struct 
perf_sample *sample, u64 type,
  	return result;
  }

+void __weak arch_perf_synthesize_sample_weight(const struct perf_sample 
*data,
+					       __u64 *array, u64 type __maybe_unused)
+{
+	*array = data->weight;
+}
+
  int perf_event__synthesize_sample(union perf_event *event, u64 type, 
u64 read_format,
  				  const struct perf_sample *sample)
  {
@@ -1643,11 +1649,7 @@ int perf_event__synthesize_sample(union 
perf_event *event, u64 type, u64 read_fo
  	}

  	if (type & PERF_SAMPLE_WEIGHT_TYPE) {
-		*array = sample->weight;
-		if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
-			*array &= 0xffffffff;
-			*array |= ((u64)sample->ins_lat << 32);
-		}
+		arch_perf_synthesize_sample_weight(sample, array, type);
  		array++;
  	}

Thanks,
Kan
