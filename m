Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63AC308B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 18:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhA2RaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 12:30:02 -0500
Received: from mga09.intel.com ([134.134.136.24]:2734 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231169AbhA2R1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:27:24 -0500
IronPort-SDR: sCr5sZwO7RKdebNEj4zuiljChhNIzuuk/tDmxKEJd4EfHiUGySJ9lGFsX4tCs39Q7g0aQfrCZq
 YhBHyUcebOhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="180595589"
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="180595589"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 09:25:36 -0800
IronPort-SDR: BT4g1fWF5iS69LRRalkDIZW2ZT4OVApM6LbkA8keqMB23HVCznuz6GHXEXKuiX0xRONYVno0qh
 qpLeBVx/HgIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,386,1602572400"; 
   d="scan'208";a="576535452"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jan 2021 09:25:35 -0800
Received: from [10.252.131.63] (kliang2-MOBL.ccr.corp.intel.com [10.252.131.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D7ECF580716;
        Fri, 29 Jan 2021 09:25:33 -0800 (PST)
Subject: Re: [PATCH V3 1/5] perf/core: Add PERF_SAMPLE_WEIGHT_STRUCT
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, mpe@ellerman.id.au,
        maddy@linux.vnet.ibm.com
References: <1611873611-156687-1-git-send-email-kan.liang@linux.intel.com>
 <1611873611-156687-2-git-send-email-kan.liang@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <b970c739-6783-34d6-8676-44632c7c9428@linux.intel.com>
Date:   Fri, 29 Jan 2021 12:25:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1611873611-156687-2-git-send-email-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/28/2021 5:40 PM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Current PERF_SAMPLE_WEIGHT sample type is very useful to expresses the
> cost of an action represented by the sample. This allows the profiler
> to scale the samples to be more informative to the programmer. It could
> also help to locate a hotspot, e.g., when profiling by memory latencies,
> the expensive load appear higher up in the histograms. But current
> PERF_SAMPLE_WEIGHT sample type is solely determined by one factor. This
> could be a problem, if users want two or more factors to contribute to
> the weight. For example, Golden Cove core PMU can provide both the
> instruction latency and the cache Latency information as factors for the
> memory profiling.
> 
> For current X86 platforms, although meminfo::latency is defined as a
> u64, only the lower 32 bits include the valid data in practice (No
> memory access could last than 4G cycles). The higher 32 bits can be used
> to store new factors.
> 
> Add a new sample type, PERF_SAMPLE_WEIGHT_STRUCT, to indicate the new
> sample weight structure. It shares the same space as the
> PERF_SAMPLE_WEIGHT sample type.
> 
> Users can apply either the PERF_SAMPLE_WEIGHT sample type or the
> PERF_SAMPLE_WEIGHT_STRUCT sample type to retrieve the sample weight, but
> they cannot apply both sample types simultaneously.
> 
> Currently, only X86 and PowerPC use the PERF_SAMPLE_WEIGHT sample type.
> - For PowerPC, there is nothing changed for the PERF_SAMPLE_WEIGHT
>    sample type. There is no effect for the new PERF_SAMPLE_WEIGHT_STRUCT
>    sample type. PowerPC can re-struct the weight field similarly later.
> - For X86, the same value will be dumped for the PERF_SAMPLE_WEIGHT
>    sample type or the PERF_SAMPLE_WEIGHT_STRUCT sample type for now.
>    The following patches will apply the new factors for the
>    PERF_SAMPLE_WEIGHT_STRUCT sample type.
> 
> The field in the union perf_sample_weight should be shared among
> different architectures. A generic name is required, but it's hard to
> abstract a name that applies to all architectures. For example, on X86,
> the fields are to store all kinds of latency. While on PowerPC, it
> stores MMCRA[TECX/TECM], which should not be latency. So a general name
> prefix 'var$NUM' is used here.
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>   arch/powerpc/perf/core-book3s.c |  2 +-
>   arch/x86/events/intel/ds.c      | 17 +++++++-------
>   include/linux/perf_event.h      |  4 ++--
>   include/uapi/linux/perf_event.h | 49 +++++++++++++++++++++++++++++++++++++++--
>   kernel/events/core.c            | 11 +++++----
>   5 files changed, 66 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index 28206b1..869d999 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -2195,7 +2195,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
>   
>   		if (event->attr.sample_type & PERF_SAMPLE_WEIGHT &&
>   						ppmu->get_mem_weight)
> -			ppmu->get_mem_weight(&data.weight);
> +			ppmu->get_mem_weight(&data.weight.full);
>   
>   		if (perf_event_overflow(event, &data, regs))
>   			power_pmu_stop(event, 0);
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 67dbc91..2f54b1f 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -960,7 +960,8 @@ static void adaptive_pebs_record_size_update(void)
>   }
>   
>   #define PERF_PEBS_MEMINFO_TYPE	(PERF_SAMPLE_ADDR | PERF_SAMPLE_DATA_SRC |   \
> -				PERF_SAMPLE_PHYS_ADDR | PERF_SAMPLE_WEIGHT | \
> +				PERF_SAMPLE_PHYS_ADDR |			     \
> +				PERF_SAMPLE_WEIGHT_TYPE |		     \
>   				PERF_SAMPLE_TRANSACTION |		     \
>   				PERF_SAMPLE_DATA_PAGE_SIZE)
>   
> @@ -987,7 +988,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
>   	gprs = (sample_type & PERF_SAMPLE_REGS_INTR) &&
>   	       (attr->sample_regs_intr & PEBS_GP_REGS);
>   
> -	tsx_weight = (sample_type & PERF_SAMPLE_WEIGHT) &&
> +	tsx_weight = (sample_type & PERF_SAMPLE_WEIGHT_TYPE) &&
>   		     ((attr->config & INTEL_ARCH_EVENT_MASK) ==
>   		      x86_pmu.rtm_abort_event);
>   
> @@ -1369,8 +1370,8 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
>   	/*
>   	 * Use latency for weight (only avail with PEBS-LL)
>   	 */
> -	if (fll && (sample_type & PERF_SAMPLE_WEIGHT))
> -		data->weight = pebs->lat;
> +	if (fll && (sample_type & PERF_SAMPLE_WEIGHT_TYPE))
> +		data->weight.full = pebs->lat;
>   
>   	/*
>   	 * data.data_src encodes the data source
> @@ -1462,8 +1463,8 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
>   
>   	if (x86_pmu.intel_cap.pebs_format >= 2) {
>   		/* Only set the TSX weight when no memory weight. */
> -		if ((sample_type & PERF_SAMPLE_WEIGHT) && !fll)
> -			data->weight = intel_get_tsx_weight(pebs->tsx_tuning);
> +		if ((sample_type & PERF_SAMPLE_WEIGHT_TYPE) && !fll)
> +			data->weight.full = intel_get_tsx_weight(pebs->tsx_tuning);
>   
>   		if (sample_type & PERF_SAMPLE_TRANSACTION)
>   			data->txn = intel_get_tsx_transaction(pebs->tsx_tuning,
> @@ -1577,8 +1578,8 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
>   	}
>   
>   	if (format_size & PEBS_DATACFG_MEMINFO) {
> -		if (sample_type & PERF_SAMPLE_WEIGHT)
> -			data->weight = meminfo->latency ?:
> +		if (sample_type & PERF_SAMPLE_WEIGHT_TYPE)
> +			data->weight.full = meminfo->latency ?:
>   				intel_get_tsx_weight(meminfo->tsx_tuning);
>   
>   		if (sample_type & PERF_SAMPLE_DATA_SRC)
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 9a38f57..fab42cf 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -998,7 +998,7 @@ struct perf_sample_data {
>   	struct perf_raw_record		*raw;
>   	struct perf_branch_stack	*br_stack;
>   	u64				period;
> -	u64				weight;
> +	union perf_sample_weight	weight;
>   	u64				txn;
>   	union  perf_mem_data_src	data_src;
>   
> @@ -1047,7 +1047,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
>   	data->raw  = NULL;
>   	data->br_stack = NULL;
>   	data->period = period;
> -	data->weight = 0;
> +	data->weight.full = 0;
>   	data->data_src.val = PERF_MEM_NA;
>   	data->txn = 0;
>   }
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index b15e344..c50718a 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -145,12 +145,14 @@ enum perf_event_sample_format {
>   	PERF_SAMPLE_CGROUP			= 1U << 21,
>   	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
>   	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 23,
> +	PERF_SAMPLE_WEIGHT_STRUCT		= 1U << 24,
>   
> -	PERF_SAMPLE_MAX = 1U << 24,		/* non-ABI */
> +	PERF_SAMPLE_MAX = 1U << 25,		/* non-ABI */
>   
>   	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
>   };
>   
> +#define PERF_SAMPLE_WEIGHT_TYPE	(PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGHT_STRUCT)
>   /*
>    * values to program into branch_sample_type when PERF_SAMPLE_BRANCH is set
>    *
> @@ -890,7 +892,25 @@ enum perf_event_type {
>   	 * 	  char			data[size];
>   	 * 	  u64			dyn_size; } && PERF_SAMPLE_STACK_USER
>   	 *
> -	 *	{ u64			weight;   } && PERF_SAMPLE_WEIGHT
> +	 *	{ union perf_sample_weight
> +	 *	 {
> +	 *		u64		full; && PERF_SAMPLE_WEIGHT
> +	 *	#if defined(__LITTLE_ENDIAN_BITFIELD)
> +	 *		struct {
> +	 *			u32	var1_dw;
> +	 *			u16	var2_w;
> +	 *			u16	var3_w;
> +	 *		} && PERF_SAMPLE_WEIGHT_STRUCT
> +	 *	#elif defined(__BIG_ENDIAN_BITFIELD)
> +	 *		struct {
> +	 *			u16	var3_w;
> +	 *			u16	var2_w;
> +	 *			u32	var1_dw;
> +	 *		} && PERF_SAMPLE_WEIGHT_STRUCT
> +	 *	#endif
> +	 *
> +	 *	 }
> +	 *	}
>   	 *	{ u64			data_src; } && PERF_SAMPLE_DATA_SRC
>   	 *	{ u64			transaction; } && PERF_SAMPLE_TRANSACTION
>   	 *	{ u64			abi; # enum perf_sample_regs_abi
> @@ -1248,4 +1268,29 @@ struct perf_branch_entry {
>   		reserved:40;
>   };
>   
> +#if defined(__LITTLE_ENDIAN_BITFIELD)
> +union perf_sample_weight {
> +	__u64		full;
> +	struct {
> +		__u32	var1_dw;
> +		__u16	var2_w;
> +		__u16	var3_w;
> +	};
> +};
> +
> +#elif defined(__BIG_ENDIAN_BITFIELD)
> +
> +union perf_sample_weight {
> +	__u64		full;
> +	struct {
> +		__u16	var3_dw;
> +		__u16	var2_w;
> +		__u32	var1_w;
> +	};
> +};

Ah, a typo.

Should be

+#elif defined(__BIG_ENDIAN_BITFIELD)
+
+union perf_sample_weight {
+	__u64		full;
+	struct {
+		__u16	var3_w;
+		__u16	var2_w;
+		__u32	var1_dw;
+	};
+};

Sorry for that. Resend the V3 patch.


 From adef7c5dbe963d1e111c7e3700fd8b53a891d1ed Mon Sep 17 00:00:00 2001
From: Kan Liang <kan.liang@linux.intel.com>
Date: Thu, 28 Jan 2021 08:40:08 -0800
Subject: [PATCH V3 1/5] perf/core: Add PERF_SAMPLE_WEIGHT_STRUCT

Current PERF_SAMPLE_WEIGHT sample type is very useful to expresses the
cost of an action represented by the sample. This allows the profiler
to scale the samples to be more informative to the programmer. It could
also help to locate a hotspot, e.g., when profiling by memory latencies,
the expensive load appear higher up in the histograms. But current
PERF_SAMPLE_WEIGHT sample type is solely determined by one factor. This
could be a problem, if users want two or more factors to contribute to
the weight. For example, Golden Cove core PMU can provide both the
instruction latency and the cache Latency information as factors for the
memory profiling.

For current X86 platforms, although meminfo::latency is defined as a
u64, only the lower 32 bits include the valid data in practice (No
memory access could last than 4G cycles). The higher 32 bits can be used
to store new factors.

Add a new sample type, PERF_SAMPLE_WEIGHT_STRUCT, to indicate the new
sample weight structure. It shares the same space as the
PERF_SAMPLE_WEIGHT sample type.

Users can apply either the PERF_SAMPLE_WEIGHT sample type or the
PERF_SAMPLE_WEIGHT_STRUCT sample type to retrieve the sample weight, but
they cannot apply both sample types simultaneously.

Currently, only X86 and PowerPC use the PERF_SAMPLE_WEIGHT sample type.
- For PowerPC, there is nothing changed for the PERF_SAMPLE_WEIGHT
   sample type. There is no effect for the new PERF_SAMPLE_WEIGHT_STRUCT
   sample type. PowerPC can re-struct the weight field similarly later.
- For X86, the same value will be dumped for the PERF_SAMPLE_WEIGHT
   sample type or the PERF_SAMPLE_WEIGHT_STRUCT sample type for now.
   The following patches will apply the new factors for the
   PERF_SAMPLE_WEIGHT_STRUCT sample type.

The field in the union perf_sample_weight should be shared among
different architectures. A generic name is required, but it's hard to
abstract a name that applies to all architectures. For example, on X86,
the fields are to store all kinds of latency. While on PowerPC, it
stores MMCRA[TECX/TECM], which should not be latency. So a general name
prefix 'var$NUM' is used here.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
  arch/powerpc/perf/core-book3s.c |  2 +-
  arch/x86/events/intel/ds.c      | 17 +++++++-------
  include/linux/perf_event.h      |  4 ++--
  include/uapi/linux/perf_event.h | 49 
+++++++++++++++++++++++++++++++++++++++--
  kernel/events/core.c            | 11 +++++----
  5 files changed, 66 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c 
b/arch/powerpc/perf/core-book3s.c
index 28206b1..869d999 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2195,7 +2195,7 @@ static void record_and_restart(struct perf_event 
*event, unsigned long val,

  		if (event->attr.sample_type & PERF_SAMPLE_WEIGHT &&
  						ppmu->get_mem_weight)
-			ppmu->get_mem_weight(&data.weight);
+			ppmu->get_mem_weight(&data.weight.full);

  		if (perf_event_overflow(event, &data, regs))
  			power_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 67dbc91..2f54b1f 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -960,7 +960,8 @@ static void adaptive_pebs_record_size_update(void)
  }

  #define PERF_PEBS_MEMINFO_TYPE	(PERF_SAMPLE_ADDR | 
PERF_SAMPLE_DATA_SRC |   \
-				PERF_SAMPLE_PHYS_ADDR | PERF_SAMPLE_WEIGHT | \
+				PERF_SAMPLE_PHYS_ADDR |			     \
+				PERF_SAMPLE_WEIGHT_TYPE |		     \
  				PERF_SAMPLE_TRANSACTION |		     \
  				PERF_SAMPLE_DATA_PAGE_SIZE)

@@ -987,7 +988,7 @@ static u64 pebs_update_adaptive_cfg(struct 
perf_event *event)
  	gprs = (sample_type & PERF_SAMPLE_REGS_INTR) &&
  	       (attr->sample_regs_intr & PEBS_GP_REGS);

-	tsx_weight = (sample_type & PERF_SAMPLE_WEIGHT) &&
+	tsx_weight = (sample_type & PERF_SAMPLE_WEIGHT_TYPE) &&
  		     ((attr->config & INTEL_ARCH_EVENT_MASK) ==
  		      x86_pmu.rtm_abort_event);

@@ -1369,8 +1370,8 @@ static void setup_pebs_fixed_sample_data(struct 
perf_event *event,
  	/*
  	 * Use latency for weight (only avail with PEBS-LL)
  	 */
-	if (fll && (sample_type & PERF_SAMPLE_WEIGHT))
-		data->weight = pebs->lat;
+	if (fll && (sample_type & PERF_SAMPLE_WEIGHT_TYPE))
+		data->weight.full = pebs->lat;

  	/*
  	 * data.data_src encodes the data source
@@ -1462,8 +1463,8 @@ static void setup_pebs_fixed_sample_data(struct 
perf_event *event,

  	if (x86_pmu.intel_cap.pebs_format >= 2) {
  		/* Only set the TSX weight when no memory weight. */
-		if ((sample_type & PERF_SAMPLE_WEIGHT) && !fll)
-			data->weight = intel_get_tsx_weight(pebs->tsx_tuning);
+		if ((sample_type & PERF_SAMPLE_WEIGHT_TYPE) && !fll)
+			data->weight.full = intel_get_tsx_weight(pebs->tsx_tuning);

  		if (sample_type & PERF_SAMPLE_TRANSACTION)
  			data->txn = intel_get_tsx_transaction(pebs->tsx_tuning,
@@ -1577,8 +1578,8 @@ static void setup_pebs_adaptive_sample_data(struct 
perf_event *event,
  	}

  	if (format_size & PEBS_DATACFG_MEMINFO) {
-		if (sample_type & PERF_SAMPLE_WEIGHT)
-			data->weight = meminfo->latency ?:
+		if (sample_type & PERF_SAMPLE_WEIGHT_TYPE)
+			data->weight.full = meminfo->latency ?:
  				intel_get_tsx_weight(meminfo->tsx_tuning);

  		if (sample_type & PERF_SAMPLE_DATA_SRC)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 9a38f57..fab42cf 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -998,7 +998,7 @@ struct perf_sample_data {
  	struct perf_raw_record		*raw;
  	struct perf_branch_stack	*br_stack;
  	u64				period;
-	u64				weight;
+	union perf_sample_weight	weight;
  	u64				txn;
  	union  perf_mem_data_src	data_src;

@@ -1047,7 +1047,7 @@ static inline void perf_sample_data_init(struct 
perf_sample_data *data,
  	data->raw  = NULL;
  	data->br_stack = NULL;
  	data->period = period;
-	data->weight = 0;
+	data->weight.full = 0;
  	data->data_src.val = PERF_MEM_NA;
  	data->txn = 0;
  }
diff --git a/include/uapi/linux/perf_event.h 
b/include/uapi/linux/perf_event.h
index b15e344..c50718a 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -145,12 +145,14 @@ enum perf_event_sample_format {
  	PERF_SAMPLE_CGROUP			= 1U << 21,
  	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
  	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 23,
+	PERF_SAMPLE_WEIGHT_STRUCT		= 1U << 24,

-	PERF_SAMPLE_MAX = 1U << 24,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 25,		/* non-ABI */

  	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
  };

+#define PERF_SAMPLE_WEIGHT_TYPE	(PERF_SAMPLE_WEIGHT | 
PERF_SAMPLE_WEIGHT_STRUCT)
  /*
   * values to program into branch_sample_type when PERF_SAMPLE_BRANCH 
is set
   *
@@ -890,7 +892,25 @@ enum perf_event_type {
  	 * 	  char			data[size];
  	 * 	  u64			dyn_size; } && PERF_SAMPLE_STACK_USER
  	 *
-	 *	{ u64			weight;   } && PERF_SAMPLE_WEIGHT
+	 *	{ union perf_sample_weight
+	 *	 {
+	 *		u64		full; && PERF_SAMPLE_WEIGHT
+	 *	#if defined(__LITTLE_ENDIAN_BITFIELD)
+	 *		struct {
+	 *			u32	var1_dw;
+	 *			u16	var2_w;
+	 *			u16	var3_w;
+	 *		} && PERF_SAMPLE_WEIGHT_STRUCT
+	 *	#elif defined(__BIG_ENDIAN_BITFIELD)
+	 *		struct {
+	 *			u16	var3_w;
+	 *			u16	var2_w;
+	 *			u32	var1_dw;
+	 *		} && PERF_SAMPLE_WEIGHT_STRUCT
+	 *	#endif
+	 *
+	 *	 }
+	 *	}
  	 *	{ u64			data_src; } && PERF_SAMPLE_DATA_SRC
  	 *	{ u64			transaction; } && PERF_SAMPLE_TRANSACTION
  	 *	{ u64			abi; # enum perf_sample_regs_abi
@@ -1248,4 +1268,29 @@ struct perf_branch_entry {
  		reserved:40;
  };

+#if defined(__LITTLE_ENDIAN_BITFIELD)
+union perf_sample_weight {
+	__u64		full;
+	struct {
+		__u32	var1_dw;
+		__u16	var2_w;
+		__u16	var3_w;
+	};
+};
+
+#elif defined(__BIG_ENDIAN_BITFIELD)
+
+union perf_sample_weight {
+	__u64		full;
+	struct {
+		__u16	var3_w;
+		__u16	var2_w;
+		__u32	var1_dw;
+	};
+};
+
+#else
+#error "Unknown endianness"
+#endif
+
  #endif /* _UAPI_LINUX_PERF_EVENT_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 55d1879..5206097 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1879,8 +1879,8 @@ static void __perf_event_header_size(struct 
perf_event *event, u64 sample_type)
  	if (sample_type & PERF_SAMPLE_PERIOD)
  		size += sizeof(data->period);

-	if (sample_type & PERF_SAMPLE_WEIGHT)
-		size += sizeof(data->weight);
+	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE)
+		size += sizeof(data->weight.full);

  	if (sample_type & PERF_SAMPLE_READ)
  		size += event->read_size;
@@ -6907,8 +6907,8 @@ void perf_output_sample(struct perf_output_handle 
*handle,
  					  data->regs_user.regs);
  	}

-	if (sample_type & PERF_SAMPLE_WEIGHT)
-		perf_output_put(handle, data->weight);
+	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE)
+		perf_output_put(handle, data->weight.full);

  	if (sample_type & PERF_SAMPLE_DATA_SRC)
  		perf_output_put(handle, data->data_src.val);
@@ -11564,6 +11564,9 @@ static int perf_copy_attr(struct perf_event_attr 
__user *uattr,
  	if (attr->sample_type & PERF_SAMPLE_CGROUP)
  		return -EINVAL;
  #endif
+	if ((attr->sample_type & PERF_SAMPLE_WEIGHT) &&
+	    (attr->sample_type & PERF_SAMPLE_WEIGHT_STRUCT))
+		return -EINVAL;

  out:
  	return ret;
-- 
2.7.4





