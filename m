Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507F030F3B6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 14:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbhBDNMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:12:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236234AbhBDNMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:12:15 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 114D7Nel011200;
        Thu, 4 Feb 2021 08:11:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=q5jBs5DKb+vJTUQOPLx4JET98mkHXKMoUIPTBNSBniQ=;
 b=BChSCwjhmuPiI+IZhITQhQBLAxtBKan1yChipVfHDNP9W1QE3Nw8kv8b6ht4Hn8J1WmJ
 fMrHoN4FVFoxh2OZNAxbwDYiTwWP7OM9oW+nYoCIPP/1n939+rChdGTXDDEWSLTXgTiU
 /f0gh7CweS25L5ID9dji3yn+8O3phbhPiuElrumrQ/cITCenEgx88PJRI/6zVfRI9UR1
 p+T6POpjgPWO2EmDiFNVqMALMWhOLRE2FPDVimvv9jyV6G0wkuSFPcb2P0ii54PJNDxn
 +3y1yjeNfx2RWnqw8d0w9SzUhThMlVsLvwdll3LRDthgqCeO1sbbwXQ7UcSn0dea9y0B zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36gh56rsgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 08:11:26 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 114D7kqZ013406;
        Thu, 4 Feb 2021 08:11:25 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36gh56rses-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 08:11:25 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 114D6fir031818;
        Thu, 4 Feb 2021 13:11:22 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 36cy38ak9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 13:11:22 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 114DBKDM39321998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Feb 2021 13:11:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49EE84C040;
        Thu,  4 Feb 2021 13:11:20 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7767A4C044;
        Thu,  4 Feb 2021 13:11:17 +0000 (GMT)
Received: from [9.79.225.8] (unknown [9.79.225.8])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  4 Feb 2021 13:11:17 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 6/9] perf report: Support instruction latency
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <1612296553-21962-7-git-send-email-kan.liang@linux.intel.com>
Date:   Thu, 4 Feb 2021 18:41:15 +0530
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, eranian@google.com,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, maddy@linux.vnet.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A90940CE-3DFB-4774-BA46-0C5FEB4953A0@linux.vnet.ibm.com>
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
 <1612296553-21962-7-git-send-email-kan.liang@linux.intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_07:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 03-Feb-2021, at 1:39 AM, kan.liang@linux.intel.com wrote:
>=20
> From: Kan Liang <kan.liang@linux.intel.com>
>=20
> The instruction latency information can be recorded on some platforms,
> e.g., the Intel Sapphire Rapids server. With both memory latency
> (weight) and the new instruction latency information, users can easily
> locate the expensive load instructions, and also understand the time
> spent in different stages. The users can optimize their applications
> in different pipeline stages.
>=20
> The 'weight' field is shared among different architectures. Reusing =
the
> 'weight' field may impacts other architectures. Add a new field to =
store
> the instruction latency.
>=20
> Like the 'weight' support, introduce a 'ins_lat' for the global
> instruction latency, and a 'local_ins_lat' for the local instruction
> latency version.
>=20
> Add new sort functions, INSTR Latency and Local INSTR Latency,
> accordingly.
>=20
> Add local_ins_lat to the default_mem_sort_order[].
>=20
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
> tools/perf/Documentation/perf-report.txt |  6 +++-
> tools/perf/util/event.h                  |  1 +
> tools/perf/util/evsel.c                  |  4 ++-
> tools/perf/util/hist.c                   | 12 ++++++--
> tools/perf/util/hist.h                   |  2 ++
> tools/perf/util/intel-pt.c               |  5 ++--
> tools/perf/util/session.c                |  8 ++++--
> tools/perf/util/sort.c                   | 47 =
+++++++++++++++++++++++++++++++-
> tools/perf/util/sort.h                   |  3 ++
> tools/perf/util/synthetic-events.c       |  4 ++-
> 10 files changed, 81 insertions(+), 11 deletions(-)
>=20
> diff --git a/tools/perf/Documentation/perf-report.txt =
b/tools/perf/Documentation/perf-report.txt
> index 826b5a9..0565b7c 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -108,6 +108,9 @@ OPTIONS
> 	- period: Raw number of event count of sample
> 	- time: Separate the samples by time stamp with the resolution =
specified by
> 	--time-quantum (default 100ms). Specify with overhead and before =
it.
> +	- ins_lat: Instruction latency in core cycles. This is the =
global
> +	instruction latency
> +	- local_ins_lat: Local instruction latency version
>=20
> 	By default, comm, dso and symbol keys are used.
> 	(i.e. --sort comm,dso,symbol)
> @@ -154,7 +157,8 @@ OPTIONS
> 	- blocked: reason of blocked load access for the data at the =
time of the sample
>=20
> 	And the default sort keys are changed to local_weight, mem, sym, =
dso,
> -	symbol_daddr, dso_daddr, snoop, tlb, locked, blocked, see =
'--mem-mode'.
> +	symbol_daddr, dso_daddr, snoop, tlb, locked, blocked, =
local_ins_lat,
> +	see '--mem-mode'.
>=20
> 	If the data file has tracepoint event(s), following (dynamic) =
sort keys
> 	are also available:
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index ff403ea..5d50a49 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -141,6 +141,7 @@ struct perf_sample {
> 	u16 insn_len;
> 	u8  cpumode;
> 	u16 misc;
> +	u16 ins_lat;
> 	bool no_hw_idx;		/* No hw_idx collected in branch_stack =
*/
> 	char insn[MAX_INSN];
> 	void *raw_data;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 0a2a307..24c0b59 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2337,8 +2337,10 @@ int evsel__parse_sample(struct evsel *evsel, =
union perf_event *event,
> 		weight.full =3D *array;
> 		if (type & PERF_SAMPLE_WEIGHT)
> 			data->weight =3D weight.full;
> -		else
> +		else {
> 			data->weight =3D weight.var1_dw;
> +			data->ins_lat =3D weight.var2_w;
> +		}
> 		array++;
> 	}
>=20
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 6866ab0..8a432f8 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -209,6 +209,8 @@ void hists__calc_col_len(struct hists *hists, =
struct hist_entry *h)
> 	hists__new_col_len(hists, HISTC_LOCAL_WEIGHT, 12);
> 	hists__new_col_len(hists, HISTC_GLOBAL_WEIGHT, 12);
> 	hists__new_col_len(hists, HISTC_MEM_BLOCKED, 10);
> +	hists__new_col_len(hists, HISTC_LOCAL_INS_LAT, 13);
> +	hists__new_col_len(hists, HISTC_GLOBAL_INS_LAT, 13);
> 	if (symbol_conf.nanosecs)
> 		hists__new_col_len(hists, HISTC_TIME, 16);
> 	else
> @@ -286,12 +288,13 @@ static long hist_time(unsigned long htime)
> }
>=20
> static void he_stat__add_period(struct he_stat *he_stat, u64 period,
> -				u64 weight)
> +				u64 weight, u64 ins_lat)
> {
>=20
> 	he_stat->period		+=3D period;
> 	he_stat->weight		+=3D weight;
> 	he_stat->nr_events	+=3D 1;
> +	he_stat->ins_lat	+=3D ins_lat;
> }
>=20
> static void he_stat__add_stat(struct he_stat *dest, struct he_stat =
*src)
> @@ -303,6 +306,7 @@ static void he_stat__add_stat(struct he_stat =
*dest, struct he_stat *src)
> 	dest->period_guest_us	+=3D src->period_guest_us;
> 	dest->nr_events		+=3D src->nr_events;
> 	dest->weight		+=3D src->weight;
> +	dest->ins_lat		+=3D src->ins_lat;
> }
>=20
> static void he_stat__decay(struct he_stat *he_stat)
> @@ -591,6 +595,7 @@ static struct hist_entry =
*hists__findnew_entry(struct hists *hists,
> 	int64_t cmp;
> 	u64 period =3D entry->stat.period;
> 	u64 weight =3D entry->stat.weight;
> +	u64 ins_lat =3D entry->stat.ins_lat;
> 	bool leftmost =3D true;
>=20
> 	p =3D &hists->entries_in->rb_root.rb_node;
> @@ -609,11 +614,11 @@ static struct hist_entry =
*hists__findnew_entry(struct hists *hists,
>=20
> 		if (!cmp) {
> 			if (sample_self) {
> -				he_stat__add_period(&he->stat, period, =
weight);
> +				he_stat__add_period(&he->stat, period, =
weight, ins_lat);
> 				hist_entry__add_callchain_period(he, =
period);
> 			}
> 			if (symbol_conf.cumulate_callchain)
> -				he_stat__add_period(he->stat_acc, =
period, weight);
> +				he_stat__add_period(he->stat_acc, =
period, weight, ins_lat);
>=20
> 			/*
> 			 * This mem info was allocated from =
sample__resolve_mem
> @@ -723,6 +728,7 @@ __hists__add_entry(struct hists *hists,
> 			.nr_events =3D 1,
> 			.period	=3D sample->period,
> 			.weight =3D sample->weight,
> +			.ins_lat =3D sample->ins_lat,
> 		},
> 		.parent =3D sym_parent,
> 		.filtered =3D symbol__parent_filter(sym_parent) | =
al->filtered,
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 522486b..36bca33 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -72,6 +72,8 @@ enum hist_column {
> 	HISTC_DSO_SIZE,
> 	HISTC_SYMBOL_IPC,
> 	HISTC_MEM_BLOCKED,
> +	HISTC_LOCAL_INS_LAT,
> +	HISTC_GLOBAL_INS_LAT,
> 	HISTC_NR_COLS, /* Last entry */
> };
>=20
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index a929f6d..c9477d0 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -1871,9 +1871,10 @@ static int intel_pt_synth_pebs_sample(struct =
intel_pt_queue *ptq)
> 			 * cycles. Use latency >> 32 to distinguish the
> 			 * different format of the mem access latency =
field.
> 			 */
> -			if (weight > 0)
> +			if (weight > 0) {
> 				sample.weight =3D weight & 0xffff;
> -			else
> +				sample.ins_lat =3D =
items->mem_access_latency & 0xffff;
> +			} else
> 				sample.weight =3D =
items->mem_access_latency;
> 		}
> 		if (!sample.weight && items->has_tsx_aux_info) {
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index a35d8c2..330e591 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1297,8 +1297,12 @@ static void dump_sample(struct evsel *evsel, =
union perf_event *event,
> 	if (sample_type & PERF_SAMPLE_STACK_USER)
> 		stack_user__printf(&sample->user_stack);
>=20
> -	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE)
> -		printf("... weight: %" PRIu64 "\n", sample->weight);
> +	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
> +		printf("... weight: %" PRIu64 "", sample->weight);
> +			if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT)
> +				printf(",0x%"PRIx16"", sample->ins_lat);
> +		printf("\n");
> +	}
>=20
> 	if (sample_type & PERF_SAMPLE_DATA_SRC)
> 		printf(" . data_src: 0x%"PRIx64"\n", sample->data_src);
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 249a03c..e0529f2 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -36,7 +36,7 @@ const char	default_parent_pattern[] =3D =
"^sys_|^do_page_fault";
> const char	*parent_pattern =3D default_parent_pattern;
> const char	*default_sort_order =3D "comm,dso,symbol";
> const char	default_branch_sort_order[] =3D =
"comm,dso_from,symbol_from,symbol_to,cycles";
> -const char	default_mem_sort_order[] =3D =
"local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked"=
;
> +const char	default_mem_sort_order[] =3D =
"local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked,=
local_ins_lat";
> const char	default_top_sort_order[] =3D "dso,symbol";
> const char	default_diff_sort_order[] =3D "dso,symbol";
> const char	default_tracepoint_sort_order[] =3D "trace";
> @@ -1365,6 +1365,49 @@ struct sort_entry sort_global_weight =3D {
> 	.se_width_idx	=3D HISTC_GLOBAL_WEIGHT,
> };
>=20
> +static u64 he_ins_lat(struct hist_entry *he)
> +{
> +		return he->stat.nr_events ? he->stat.ins_lat / =
he->stat.nr_events : 0;
> +}
> +
> +static int64_t
> +sort__local_ins_lat_cmp(struct hist_entry *left, struct hist_entry =
*right)
> +{
> +		return he_ins_lat(left) - he_ins_lat(right);
> +}
> +
> +static int hist_entry__local_ins_lat_snprintf(struct hist_entry *he, =
char *bf,
> +					      size_t size, unsigned int =
width)
> +{
> +		return repsep_snprintf(bf, size, "%-*u", width, =
he_ins_lat(he));
> +}
> +
> +struct sort_entry sort_local_ins_lat =3D {
> +	.se_header	=3D "Local INSTR Latency",
> +	.se_cmp		=3D sort__local_ins_lat_cmp,
> +	.se_snprintf	=3D hist_entry__local_ins_lat_snprintf,
> +	.se_width_idx	=3D HISTC_LOCAL_INS_LAT,
> +};

Hi Kan Liang,

Currently with this changes, perf will display "Local INSTR Latency=E2=80=9D=
  for the new column in =E2=80=98perf mem report=E2=80=99

Can we make this header string to be Architecture Specific ?
Because in other archs, the var2_w of =E2=80=98perf_sample_weight=E2=80=99=
 could be used to capture something else than the Local INSTR Latency.
Can we have some weak function to populate the header string ?


Thanks
Athira Rajeev
> +
> +static int64_t
> +sort__global_ins_lat_cmp(struct hist_entry *left, struct hist_entry =
*right)
> +{
> +		return left->stat.ins_lat - right->stat.ins_lat;
> +}
> +
> +static int hist_entry__global_ins_lat_snprintf(struct hist_entry *he, =
char *bf,
> +					       size_t size, unsigned int =
width)
> +{
> +		return repsep_snprintf(bf, size, "%-*u", width, =
he->stat.ins_lat);
> +}
> +
> +struct sort_entry sort_global_ins_lat =3D {
> +	.se_header	=3D "INSTR Latency",
> +	.se_cmp		=3D sort__global_ins_lat_cmp,
> +	.se_snprintf	=3D hist_entry__global_ins_lat_snprintf,
> +	.se_width_idx	=3D HISTC_GLOBAL_INS_LAT,

> +};
> +
> struct sort_entry sort_mem_daddr_sym =3D {
> 	.se_header	=3D "Data Symbol",
> 	.se_cmp		=3D sort__daddr_cmp,
> @@ -1770,6 +1813,8 @@ static struct sort_dimension =
common_sort_dimensions[] =3D {
> 	DIM(SORT_CGROUP_ID, "cgroup_id", sort_cgroup_id),
> 	DIM(SORT_SYM_IPC_NULL, "ipc_null", sort_sym_ipc_null),
> 	DIM(SORT_TIME, "time", sort_time),
> +	DIM(SORT_LOCAL_INS_LAT, "local_ins_lat", sort_local_ins_lat),
> +	DIM(SORT_GLOBAL_INS_LAT, "ins_lat", sort_global_ins_lat),
> };
>=20
> #undef DIM
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index 2b2645b..c92ca15 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -50,6 +50,7 @@ struct he_stat {
> 	u64			period_guest_sys;
> 	u64			period_guest_us;
> 	u64			weight;
> +	u64			ins_lat;
> 	u32			nr_events;
> };
>=20
> @@ -229,6 +230,8 @@ enum sort_type {
> 	SORT_CGROUP_ID,
> 	SORT_SYM_IPC_NULL,
> 	SORT_TIME,
> +	SORT_LOCAL_INS_LAT,
> +	SORT_GLOBAL_INS_LAT,
>=20
> 	/* branch stack specific sort keys */
> 	__SORT_BRANCH_STACK,
> diff --git a/tools/perf/util/synthetic-events.c =
b/tools/perf/util/synthetic-events.c
> index bc16268..95401c9 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1557,8 +1557,10 @@ int perf_event__synthesize_sample(union =
perf_event *event, u64 type, u64 read_fo
>=20
> 	if (type & PERF_SAMPLE_WEIGHT_TYPE) {
> 		*array =3D sample->weight;
> -		if (type & PERF_SAMPLE_WEIGHT_STRUCT)
> +		if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
> 			*array &=3D 0xffffffff;
> +			*array |=3D ((u64)sample->ins_lat << 32);
> +		}
> 		array++;
> 	}
>=20
> --=20
> 2.7.4
>=20
>=20
>=20

