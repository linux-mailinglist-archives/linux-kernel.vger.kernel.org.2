Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F203117B2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhBFAPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:15:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56820 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232403AbhBEM7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:59:12 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 115CZaMf095664;
        Fri, 5 Feb 2021 07:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=oY4xUQ+2n+iHAsp8961L0Fk0TIvpcy2B8VW2QFk9Gys=;
 b=e6LeFFa5qnlocMCvjpfh0Q/+CzTWJFRE+6IVI4yZ1K3zNBhnTbQNSeaOymfxoVL/u5+8
 B0KDYyq1AUZYuowWcj8LbTMNQPsOkyMIVitWIG4Z1+z9day94D18asbQJeyWMW1zvOO3
 PE+3WFi5Alw89hh/EwNo6ULWoD0n0+AzgIClLaIg3YKF+0v7cGsgNaJiAORUHjrEMRvs
 Egcr50m4xmxN4M9AJsjbsoubj7L7Wq/sBzo4ILgG1JP/A2NBRbfPM7sKZr1fXqm45nD2
 2xtt6pp3VJe3DS11wACkuaLZcCsA7PTAHx+6uOkB5RdeYAm0xf810mI3EB+SwTN+fm7Y LA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36h494mmc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Feb 2021 07:58:20 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 115CZdZF095857;
        Fri, 5 Feb 2021 07:58:19 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36h494mmbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Feb 2021 07:58:19 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 115CXEjk011692;
        Fri, 5 Feb 2021 12:58:17 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 36g8kerrym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Feb 2021 12:58:17 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 115CwFkP40698214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Feb 2021 12:58:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61D1BAE056;
        Fri,  5 Feb 2021 12:58:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A51CAE045;
        Fri,  5 Feb 2021 12:58:12 +0000 (GMT)
Received: from [9.79.253.219] (unknown [9.79.253.219])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  5 Feb 2021 12:58:12 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 6/9] perf report: Support instruction latency
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <27633871-eda5-7faa-8783-84dd49f8a6cd@linux.intel.com>
Date:   Fri, 5 Feb 2021 18:25:49 +0530
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, eranian@google.com,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, maddy@linux.vnet.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <6F377E9D-89F8-414F-A2CC-C96797697159@linux.vnet.ibm.com>
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
 <1612296553-21962-7-git-send-email-kan.liang@linux.intel.com>
 <A90940CE-3DFB-4774-BA46-0C5FEB4953A0@linux.vnet.ibm.com>
 <27633871-eda5-7faa-8783-84dd49f8a6cd@linux.intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_07:2021-02-05,2021-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 04-Feb-2021, at 8:49 PM, Liang, Kan <kan.liang@linux.intel.com> =
wrote:
>=20
>=20
>=20
> On 2/4/2021 8:11 AM, Athira Rajeev wrote:
>>> On 03-Feb-2021, at 1:39 AM, kan.liang@linux.intel.com wrote:
>>>=20
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>=20
>>> The instruction latency information can be recorded on some =
platforms,
>>> e.g., the Intel Sapphire Rapids server. With both memory latency
>>> (weight) and the new instruction latency information, users can =
easily
>>> locate the expensive load instructions, and also understand the time
>>> spent in different stages. The users can optimize their applications
>>> in different pipeline stages.
>>>=20
>>> The 'weight' field is shared among different architectures. Reusing =
the
>>> 'weight' field may impacts other architectures. Add a new field to =
store
>>> the instruction latency.
>>>=20
>>> Like the 'weight' support, introduce a 'ins_lat' for the global
>>> instruction latency, and a 'local_ins_lat' for the local instruction
>>> latency version.
>>>=20
>>> Add new sort functions, INSTR Latency and Local INSTR Latency,
>>> accordingly.
>>>=20
>>> Add local_ins_lat to the default_mem_sort_order[].
>>>=20
>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>> ---
>>> tools/perf/Documentation/perf-report.txt |  6 +++-
>>> tools/perf/util/event.h                  |  1 +
>>> tools/perf/util/evsel.c                  |  4 ++-
>>> tools/perf/util/hist.c                   | 12 ++++++--
>>> tools/perf/util/hist.h                   |  2 ++
>>> tools/perf/util/intel-pt.c               |  5 ++--
>>> tools/perf/util/session.c                |  8 ++++--
>>> tools/perf/util/sort.c                   | 47 =
+++++++++++++++++++++++++++++++-
>>> tools/perf/util/sort.h                   |  3 ++
>>> tools/perf/util/synthetic-events.c       |  4 ++-
>>> 10 files changed, 81 insertions(+), 11 deletions(-)
>>>=20
>>> diff --git a/tools/perf/Documentation/perf-report.txt =
b/tools/perf/Documentation/perf-report.txt
>>> index 826b5a9..0565b7c 100644
>>> --- a/tools/perf/Documentation/perf-report.txt
>>> +++ b/tools/perf/Documentation/perf-report.txt
>>> @@ -108,6 +108,9 @@ OPTIONS
>>> 	- period: Raw number of event count of sample
>>> 	- time: Separate the samples by time stamp with the resolution =
specified by
>>> 	--time-quantum (default 100ms). Specify with overhead and before =
it.
>>> +	- ins_lat: Instruction latency in core cycles. This is the =
global
>>> +	instruction latency
>>> +	- local_ins_lat: Local instruction latency version
>>>=20
>>> 	By default, comm, dso and symbol keys are used.
>>> 	(i.e. --sort comm,dso,symbol)
>>> @@ -154,7 +157,8 @@ OPTIONS
>>> 	- blocked: reason of blocked load access for the data at the =
time of the sample
>>>=20
>>> 	And the default sort keys are changed to local_weight, mem, sym, =
dso,
>>> -	symbol_daddr, dso_daddr, snoop, tlb, locked, blocked, see =
'--mem-mode'.
>>> +	symbol_daddr, dso_daddr, snoop, tlb, locked, blocked, =
local_ins_lat,
>>> +	see '--mem-mode'.
>>>=20
>>> 	If the data file has tracepoint event(s), following (dynamic) =
sort keys
>>> 	are also available:
>>> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
>>> index ff403ea..5d50a49 100644
>>> --- a/tools/perf/util/event.h
>>> +++ b/tools/perf/util/event.h
>>> @@ -141,6 +141,7 @@ struct perf_sample {
>>> 	u16 insn_len;
>>> 	u8  cpumode;
>>> 	u16 misc;
>>> +	u16 ins_lat;
>>> 	bool no_hw_idx;		/* No hw_idx collected in branch_stack =
*/
>>> 	char insn[MAX_INSN];
>>> 	void *raw_data;
>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>> index 0a2a307..24c0b59 100644
>>> --- a/tools/perf/util/evsel.c
>>> +++ b/tools/perf/util/evsel.c
>>> @@ -2337,8 +2337,10 @@ int evsel__parse_sample(struct evsel *evsel, =
union perf_event *event,
>>> 		weight.full =3D *array;
>>> 		if (type & PERF_SAMPLE_WEIGHT)
>>> 			data->weight =3D weight.full;
>>> -		else
>>> +		else {
>>> 			data->weight =3D weight.var1_dw;
>>> +			data->ins_lat =3D weight.var2_w;
>>> +		}
>>> 		array++;
>>> 	}
>>>=20
>>> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
>>> index 6866ab0..8a432f8 100644
>>> --- a/tools/perf/util/hist.c
>>> +++ b/tools/perf/util/hist.c
>>> @@ -209,6 +209,8 @@ void hists__calc_col_len(struct hists *hists, =
struct hist_entry *h)
>>> 	hists__new_col_len(hists, HISTC_LOCAL_WEIGHT, 12);
>>> 	hists__new_col_len(hists, HISTC_GLOBAL_WEIGHT, 12);
>>> 	hists__new_col_len(hists, HISTC_MEM_BLOCKED, 10);
>>> +	hists__new_col_len(hists, HISTC_LOCAL_INS_LAT, 13);
>>> +	hists__new_col_len(hists, HISTC_GLOBAL_INS_LAT, 13);
>>> 	if (symbol_conf.nanosecs)
>>> 		hists__new_col_len(hists, HISTC_TIME, 16);
>>> 	else
>>> @@ -286,12 +288,13 @@ static long hist_time(unsigned long htime)
>>> }
>>>=20
>>> static void he_stat__add_period(struct he_stat *he_stat, u64 period,
>>> -				u64 weight)
>>> +				u64 weight, u64 ins_lat)
>>> {
>>>=20
>>> 	he_stat->period		+=3D period;
>>> 	he_stat->weight		+=3D weight;
>>> 	he_stat->nr_events	+=3D 1;
>>> +	he_stat->ins_lat	+=3D ins_lat;
>>> }
>>>=20
>>> static void he_stat__add_stat(struct he_stat *dest, struct he_stat =
*src)
>>> @@ -303,6 +306,7 @@ static void he_stat__add_stat(struct he_stat =
*dest, struct he_stat *src)
>>> 	dest->period_guest_us	+=3D src->period_guest_us;
>>> 	dest->nr_events		+=3D src->nr_events;
>>> 	dest->weight		+=3D src->weight;
>>> +	dest->ins_lat		+=3D src->ins_lat;
>>> }
>>>=20
>>> static void he_stat__decay(struct he_stat *he_stat)
>>> @@ -591,6 +595,7 @@ static struct hist_entry =
*hists__findnew_entry(struct hists *hists,
>>> 	int64_t cmp;
>>> 	u64 period =3D entry->stat.period;
>>> 	u64 weight =3D entry->stat.weight;
>>> +	u64 ins_lat =3D entry->stat.ins_lat;
>>> 	bool leftmost =3D true;
>>>=20
>>> 	p =3D &hists->entries_in->rb_root.rb_node;
>>> @@ -609,11 +614,11 @@ static struct hist_entry =
*hists__findnew_entry(struct hists *hists,
>>>=20
>>> 		if (!cmp) {
>>> 			if (sample_self) {
>>> -				he_stat__add_period(&he->stat, period, =
weight);
>>> +				he_stat__add_period(&he->stat, period, =
weight, ins_lat);
>>> 				hist_entry__add_callchain_period(he, =
period);
>>> 			}
>>> 			if (symbol_conf.cumulate_callchain)
>>> -				he_stat__add_period(he->stat_acc, =
period, weight);
>>> +				he_stat__add_period(he->stat_acc, =
period, weight, ins_lat);
>>>=20
>>> 			/*
>>> 			 * This mem info was allocated from =
sample__resolve_mem
>>> @@ -723,6 +728,7 @@ __hists__add_entry(struct hists *hists,
>>> 			.nr_events =3D 1,
>>> 			.period	=3D sample->period,
>>> 			.weight =3D sample->weight,
>>> +			.ins_lat =3D sample->ins_lat,
>>> 		},
>>> 		.parent =3D sym_parent,
>>> 		.filtered =3D symbol__parent_filter(sym_parent) | =
al->filtered,
>>> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
>>> index 522486b..36bca33 100644
>>> --- a/tools/perf/util/hist.h
>>> +++ b/tools/perf/util/hist.h
>>> @@ -72,6 +72,8 @@ enum hist_column {
>>> 	HISTC_DSO_SIZE,
>>> 	HISTC_SYMBOL_IPC,
>>> 	HISTC_MEM_BLOCKED,
>>> +	HISTC_LOCAL_INS_LAT,
>>> +	HISTC_GLOBAL_INS_LAT,
>>> 	HISTC_NR_COLS, /* Last entry */
>>> };
>>>=20
>>> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
>>> index a929f6d..c9477d0 100644
>>> --- a/tools/perf/util/intel-pt.c
>>> +++ b/tools/perf/util/intel-pt.c
>>> @@ -1871,9 +1871,10 @@ static int intel_pt_synth_pebs_sample(struct =
intel_pt_queue *ptq)
>>> 			 * cycles. Use latency >> 32 to distinguish the
>>> 			 * different format of the mem access latency =
field.
>>> 			 */
>>> -			if (weight > 0)
>>> +			if (weight > 0) {
>>> 				sample.weight =3D weight & 0xffff;
>>> -			else
>>> +				sample.ins_lat =3D =
items->mem_access_latency & 0xffff;
>>> +			} else
>>> 				sample.weight =3D =
items->mem_access_latency;
>>> 		}
>>> 		if (!sample.weight && items->has_tsx_aux_info) {
>>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>>> index a35d8c2..330e591 100644
>>> --- a/tools/perf/util/session.c
>>> +++ b/tools/perf/util/session.c
>>> @@ -1297,8 +1297,12 @@ static void dump_sample(struct evsel *evsel, =
union perf_event *event,
>>> 	if (sample_type & PERF_SAMPLE_STACK_USER)
>>> 		stack_user__printf(&sample->user_stack);
>>>=20
>>> -	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE)
>>> -		printf("... weight: %" PRIu64 "\n", sample->weight);
>>> +	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
>>> +		printf("... weight: %" PRIu64 "", sample->weight);
>>> +			if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT)
>>> +				printf(",0x%"PRIx16"", sample->ins_lat);
>>> +		printf("\n");
>>> +	}
>>>=20
>>> 	if (sample_type & PERF_SAMPLE_DATA_SRC)
>>> 		printf(" . data_src: 0x%"PRIx64"\n", sample->data_src);
>>> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
>>> index 249a03c..e0529f2 100644
>>> --- a/tools/perf/util/sort.c
>>> +++ b/tools/perf/util/sort.c
>>> @@ -36,7 +36,7 @@ const char	default_parent_pattern[] =3D =
"^sys_|^do_page_fault";
>>> const char	*parent_pattern =3D default_parent_pattern;
>>> const char	*default_sort_order =3D "comm,dso,symbol";
>>> const char	default_branch_sort_order[] =3D =
"comm,dso_from,symbol_from,symbol_to,cycles";
>>> -const char	default_mem_sort_order[] =3D =
"local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked"=
;
>>> +const char	default_mem_sort_order[] =3D =
"local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked,=
local_ins_lat";
>>> const char	default_top_sort_order[] =3D "dso,symbol";
>>> const char	default_diff_sort_order[] =3D "dso,symbol";
>>> const char	default_tracepoint_sort_order[] =3D "trace";
>>> @@ -1365,6 +1365,49 @@ struct sort_entry sort_global_weight =3D {
>>> 	.se_width_idx	=3D HISTC_GLOBAL_WEIGHT,
>>> };
>>>=20
>>> +static u64 he_ins_lat(struct hist_entry *he)
>>> +{
>>> +		return he->stat.nr_events ? he->stat.ins_lat / =
he->stat.nr_events : 0;
>>> +}
>>> +
>>> +static int64_t
>>> +sort__local_ins_lat_cmp(struct hist_entry *left, struct hist_entry =
*right)
>>> +{
>>> +		return he_ins_lat(left) - he_ins_lat(right);
>>> +}
>>> +
>>> +static int hist_entry__local_ins_lat_snprintf(struct hist_entry =
*he, char *bf,
>>> +					      size_t size, unsigned int =
width)
>>> +{
>>> +		return repsep_snprintf(bf, size, "%-*u", width, =
he_ins_lat(he));
>>> +}
>>> +
>>> +struct sort_entry sort_local_ins_lat =3D {
>>> +	.se_header	=3D "Local INSTR Latency",
>>> +	.se_cmp		=3D sort__local_ins_lat_cmp,
>>> +	.se_snprintf	=3D hist_entry__local_ins_lat_snprintf,
>>> +	.se_width_idx	=3D HISTC_LOCAL_INS_LAT,
>>> +};
>> Hi Kan Liang,
>> Currently with this changes, perf will display "Local INSTR =
Latency=E2=80=9D  for the new column in =E2=80=98perf mem report=E2=80=99
>> Can we make this header string to be Architecture Specific ?
>=20
> I don't think current perf supports an arch specific header string. It =
sounds like a new feature. I think it's a good feature.
>=20
> Besides the instruction latency, we also introduce a 'block' field for =
perf mem. I'm not sure if the field applies for PowerPC. You may want to =
check it as well.

Hi Kan Liang,

Sure, we will check this.
>=20
> Could you please propose a patch to implement the feature? I think we =
can have a further discussion based on it.


Ok, We will look into this and come back with an RFC patch.
>=20
>> Because in other archs, the var2_w of =E2=80=98perf_sample_weight=E2=80=
=99 could be used to capture something else than the Local INSTR =
Latency.
>> Can we have some weak function to populate the header string ?
>=20
> I agree that the var2_w has different meanings among architectures. We =
should not force it to data->ins_lat.
>=20
> The patch as below should fix it. Does it work for you?

My point about weak function was actually for the arch specific header =
string. But I guess we should not force it to data->ins_lat
as you mentioned. I checked the below patch defining an =
=E2=80=98arch_perf_parse_sample_weight' for powerpc and it works.

But one observation is that, for cases with kernel having support for =
PERF_SAMPLE_WEIGHT_STRUCT but missing arch specific support for  =
=E2=80=98arch_perf_parse_sample_weight', it will report =E2=80=98Local =
Weight=E2=80=99 wrongly since weak function takes it as 64 bit. Not sure =
if that is a valid case to consider though.

Thanks
Athira
>=20
> diff --git a/tools/perf/arch/x86/util/event.c =
b/tools/perf/arch/x86/util/event.c
> index 047dc00..9b31734 100644
> --- a/tools/perf/arch/x86/util/event.c
> +++ b/tools/perf/arch/x86/util/event.c
> @@ -75,3 +75,28 @@ int perf_event__synthesize_extra_kmaps(struct =
perf_tool *tool,
> }
>=20
> #endif
> +
> +void arch_perf_parse_sample_weight(struct perf_sample *data,
> +				   const __u64 *array, u64 type)
> +{
> +	union perf_sample_weight weight;
> +
> +	weight.full =3D *array;
> +	if (type & PERF_SAMPLE_WEIGHT)
> +		data->weight =3D weight.full;
> +	else {
> +		data->weight =3D weight.var1_dw;
> +		data->ins_lat =3D weight.var2_w;
> +	}
> +}
> +
> +void arch_perf_synthesize_sample_weight(const struct perf_sample =
*data,
> +					__u64 *array, u64 type)
> +{
> +	*array =3D data->weight;
> +
> +	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
> +		*array &=3D 0xffffffff;
> +		*array |=3D ((u64)data->ins_lat << 32);
> +	}
> +}
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index 60752e4..9f123aa 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -414,4 +414,7 @@ extern unsigned int proc_map_timeout;
> #define PAGE_SIZE_NAME_LEN	32
> char *get_page_size_name(u64 size, char *str);
>=20
> +void arch_perf_parse_sample_weight(struct perf_sample *data, const =
__u64 *array, u64 type);
> +void arch_perf_synthesize_sample_weight(const struct perf_sample =
*data, __u64 *array, u64 type);
> +
> #endif /* __PERF_RECORD_H */
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 30b5452..1da8903 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2106,6 +2106,13 @@ perf_event__check_size(union perf_event *event, =
unsigned int sample_size)
> 	return 0;
> }
>=20
> +void __weak arch_perf_parse_sample_weight(struct perf_sample *data,
> +					  const __u64 *array,
> +					  u64 type __maybe_unused)
> +{
> +	data->weight =3D *array;
> +}
> +
> int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
> 			struct perf_sample *data)
> {
> @@ -2347,16 +2354,8 @@ int evsel__parse_sample(struct evsel *evsel, =
union perf_event *event,
> 	}
>=20
> 	if (type & PERF_SAMPLE_WEIGHT_TYPE) {
> -		union perf_sample_weight weight;
> -
> 		OVERFLOW_CHECK_u64(array);
> -		weight.full =3D *array;
> -		if (type & PERF_SAMPLE_WEIGHT)
> -			data->weight =3D weight.full;
> -		else {
> -			data->weight =3D weight.var1_dw;
> -			data->ins_lat =3D weight.var2_w;
> -		}
> +		arch_perf_parse_sample_weight(data, array, type);
> 		array++;
> 	}
>=20
> diff --git a/tools/perf/util/synthetic-events.c =
b/tools/perf/util/synthetic-events.c
> index c6f9db3..412f4c3 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1507,6 +1507,12 @@ size_t perf_event__sample_event_size(const =
struct perf_sample *sample, u64 type,
> 	return result;
> }
>=20
> +void __weak arch_perf_synthesize_sample_weight(const struct =
perf_sample *data,
> +					       __u64 *array, u64 type =
__maybe_unused)
> +{
> +	*array =3D data->weight;
> +}
> +
> int perf_event__synthesize_sample(union perf_event *event, u64 type, =
u64 read_format,
> 				  const struct perf_sample *sample)
> {
> @@ -1643,11 +1649,7 @@ int perf_event__synthesize_sample(union =
perf_event *event, u64 type, u64 read_fo
> 	}
>=20
> 	if (type & PERF_SAMPLE_WEIGHT_TYPE) {
> -		*array =3D sample->weight;
> -		if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
> -			*array &=3D 0xffffffff;
> -			*array |=3D ((u64)sample->ins_lat << 32);
> -		}
> +		arch_perf_synthesize_sample_weight(sample, array, type);
> 		array++;
> 	}
>=20
> Thanks,
> Kan

