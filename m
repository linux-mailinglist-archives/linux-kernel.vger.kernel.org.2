Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753C230E417
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhBCUcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 15:32:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232145AbhBCUbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:31:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B905164F6C;
        Wed,  3 Feb 2021 20:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612384268;
        bh=rJa3nJViSBYTyEesjvzYnArCfLS5tvzCz+uPq6mHBQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CnODdZlz/V2GuuoGoU6DDhZrCz7s4ypBqh8lXUwseSjYSNNJ/cBPkx+7kHpqrpHAs
         VTKhI900QNL05cOscNIlh/WivDyPq3bjIHkA6J0UcvimPW1OFM0Jote67Lh6B79pqn
         aJ5VToGbjymK2AhfKKNzg5I/vT9m4YjDG+iK1Jgf+NqYIVoMaFSRdyrx8egdqv5mgv
         x6G+3feJ0DC0/wZCutGDlU/+K588pDPdS55pXy+VQcdiGaG2/TVAr42Hceu/RuDmpH
         8FTrfBz6zcrzbrOK0nVWad4TLfw5nKG02gwOiuZ5XG439bXuHOMyOTcOBaP9ZOc18A
         IvFzB8WMerz4Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3879840513; Wed,  3 Feb 2021 17:31:05 -0300 (-03)
Date:   Wed, 3 Feb 2021 17:31:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, eranian@google.com, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        maddy@linux.vnet.ibm.com
Subject: Re: [PATCH 5/9] perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT
Message-ID: <20210203203105.GJ854763@kernel.org>
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
 <1612296553-21962-6-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612296553-21962-6-git-send-email-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 02, 2021 at 12:09:09PM -0800, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The new sample type, PERF_SAMPLE_WEIGHT_STRUCT, is an alternative of the
> PERF_SAMPLE_WEIGHT sample type. Users can apply either the
> PERF_SAMPLE_WEIGHT sample type or the PERF_SAMPLE_WEIGHT_STRUCT sample
> type to retrieve the sample weight, but they cannot apply both sample
> types simultaneously. The new sample type shares the same space as the
> PERF_SAMPLE_WEIGHT sample type. The lower 32 bits are exactly the same
> for both sample type. The higher 32 bits may be different for different
> architecture.
> 
> Add arch specific arch_evsel__set_sample_weight() to set the new sample
> type for X86. Only store the lower 32 bits for the sample->weight if the
> new sample type is applied. In practice, no memory access could last
> than 4G cycles. No data will be lost.
> 
> If the kernel doesn't support the new sample type. Fall back to the
> PERF_SAMPLE_WEIGHT sample type.
> 
> There is no impact for other architectures.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/Build            |  1 +
>  tools/perf/arch/x86/util/evsel.c          |  8 ++++++++
>  tools/perf/util/evsel.c                   | 28 ++++++++++++++++++++++++----
>  tools/perf/util/evsel.h                   |  3 +++
>  tools/perf/util/intel-pt.c                | 22 +++++++++++++++++++---
>  tools/perf/util/perf_event_attr_fprintf.c |  2 +-
>  tools/perf/util/session.c                 |  2 +-
>  tools/perf/util/synthetic-events.c        |  6 ++++--
>  8 files changed, 61 insertions(+), 11 deletions(-)
>  create mode 100644 tools/perf/arch/x86/util/evsel.c
> 
> diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
> index d73f548..18848b3 100644
> --- a/tools/perf/arch/x86/util/Build
> +++ b/tools/perf/arch/x86/util/Build
> @@ -7,6 +7,7 @@ perf-y += topdown.o
>  perf-y += machine.o
>  perf-y += event.o
>  perf-y += mem-events.o
> +perf-y += evsel.o
>  
>  perf-$(CONFIG_DWARF) += dwarf-regs.o
>  perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> new file mode 100644
> index 0000000..2f733cd
> --- /dev/null
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +#include "util/evsel.h"
> +
> +void arch_evsel__set_sample_weight(struct evsel *evsel)
> +{
> +	evsel__set_sample_bit(evsel, WEIGHT_STRUCT);
> +}
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index c48f6de..0a2a307 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1012,6 +1012,11 @@ struct evsel_config_term *__evsel__get_config_term(struct evsel *evsel, enum evs
>  	return found_term;
>  }
>  
> +void __weak arch_evsel__set_sample_weight(struct evsel *evsel)
> +{
> +	evsel__set_sample_bit(evsel, WEIGHT);
> +}
> +
>  /*
>   * The enable_on_exec/disabled value strategy:
>   *
> @@ -1166,7 +1171,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
>  	}
>  
>  	if (opts->sample_weight)
> -		evsel__set_sample_bit(evsel, WEIGHT);
> +		arch_evsel__set_sample_weight(evsel);
>  
>  	attr->task  = track;
>  	attr->mmap  = track;
> @@ -1735,6 +1740,10 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	}
>  
>  fallback_missing_features:
> +	if (perf_missing_features.weight_struct) {
> +		evsel__set_sample_bit(evsel, WEIGHT);
> +		evsel__reset_sample_bit(evsel, WEIGHT_STRUCT);
> +	}
>  	if (perf_missing_features.clockid_wrong)
>  		evsel->core.attr.clockid = CLOCK_MONOTONIC; /* should always work */
>  	if (perf_missing_features.clockid) {
> @@ -1873,7 +1882,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	 * Must probe features in the order they were added to the
>  	 * perf_event_attr interface.
>  	 */
> -        if (!perf_missing_features.data_page_size &&
> +	if (!perf_missing_features.weight_struct &&
> +	    (evsel->core.attr.sample_type & PERF_SAMPLE_WEIGHT_STRUCT)) {
> +		perf_missing_features.weight_struct = true;
> +		pr_debug2("switching off weight struct support\n");
> +		goto fallback_missing_features;
> +	} else if (!perf_missing_features.data_page_size &&
>  	    (evsel->core.attr.sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)) {
>  		perf_missing_features.data_page_size = true;
>  		pr_debug2_peo("Kernel has no PERF_SAMPLE_DATA_PAGE_SIZE support, bailing out\n");
> @@ -2316,9 +2330,15 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  		}
>  	}
>  
> -	if (type & PERF_SAMPLE_WEIGHT) {
> +	if (type & PERF_SAMPLE_WEIGHT_TYPE) {
> +		union perf_sample_weight weight;
> +
>  		OVERFLOW_CHECK_u64(array);
> -		data->weight = *array;
> +		weight.full = *array;
> +		if (type & PERF_SAMPLE_WEIGHT)
> +			data->weight = weight.full;
> +		else
> +			data->weight = weight.var1_dw;
>  		array++;
>  	}
>  
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index cd1d8dd..5c161a2 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -145,6 +145,7 @@ struct perf_missing_features {
>  	bool branch_hw_idx;
>  	bool cgroup;
>  	bool data_page_size;
> +	bool weight_struct;
>  };
>  
>  extern struct perf_missing_features perf_missing_features;
> @@ -239,6 +240,8 @@ void __evsel__reset_sample_bit(struct evsel *evsel, enum perf_event_sample_forma
>  
>  void evsel__set_sample_id(struct evsel *evsel, bool use_sample_identifier);
>  
> +void arch_evsel__set_sample_weight(struct evsel *evsel);
> +
>  int evsel__set_filter(struct evsel *evsel, const char *filter);
>  int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
>  int evsel__append_addr_filter(struct evsel *evsel, const char *filter);
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 60214de..a929f6d 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -1853,13 +1853,29 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
>  	if (sample_type & PERF_SAMPLE_ADDR && items->has_mem_access_address)
>  		sample.addr = items->mem_access_address;
>  
> -	if (sample_type & PERF_SAMPLE_WEIGHT) {
> +	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
>  		/*
>  		 * Refer kernel's setup_pebs_adaptive_sample_data() and
>  		 * intel_hsw_weight().
>  		 */
> -		if (items->has_mem_access_latency)
> -			sample.weight = items->mem_access_latency;
> +		if (items->has_mem_access_latency) {
> +			u64 weight = items->mem_access_latency >> 32;
> +
> +			/*
> +			 * Starts from SPR, the mem access latency field
> +			 * contains both cache latency [47:32] and instruction
> +			 * latency [15:0]. The cache latency is the same as the
> +			 * mem access latency on previous platforms.
> +			 *
> +			 * In practice, no memory access could last than 4G
> +			 * cycles. Use latency >> 32 to distinguish the
> +			 * different format of the mem access latency field.
> +			 */
> +			if (weight > 0)
> +				sample.weight = weight & 0xffff;
> +			else
> +				sample.weight = items->mem_access_latency;
> +		}
>  		if (!sample.weight && items->has_tsx_aux_info) {
>  			/* Cycles last block */
>  			sample.weight = (u32)items->tsx_aux_info;
> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
> index fb0bb66..e972e63 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -35,7 +35,7 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
>  		bit_name(BRANCH_STACK), bit_name(REGS_USER), bit_name(STACK_USER),
>  		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
>  		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(AUX),
> -		bit_name(CGROUP), bit_name(DATA_PAGE_SIZE),
> +		bit_name(CGROUP), bit_name(DATA_PAGE_SIZE), bit_name(WEIGHT_STRUCT),

I have CODE_PAGE_SIZE in my perf/core branch, was this somehow removed?

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=c1de7f3d84ca324c7cda85c3ce27b11741af2124

I see, you did this patchkit on top of upstream, that has just
DATA_PAGE_SIZE, while my perf/core branch has CODE_PAGE_SIZE. I'm
adjusting it, please next time do tooling development on acme/perf/core.

- Arnaldo

>  		{ .name = NULL, }
>  	};
>  #undef bit_name
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 25adbcc..a35d8c2 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1297,7 +1297,7 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
>  	if (sample_type & PERF_SAMPLE_STACK_USER)
>  		stack_user__printf(&sample->user_stack);
>  
> -	if (sample_type & PERF_SAMPLE_WEIGHT)
> +	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE)
>  		printf("... weight: %" PRIu64 "\n", sample->weight);
>  
>  	if (sample_type & PERF_SAMPLE_DATA_SRC)
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 2947e3f..bc16268 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1384,7 +1384,7 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
>  		}
>  	}
>  
> -	if (type & PERF_SAMPLE_WEIGHT)
> +	if (type & PERF_SAMPLE_WEIGHT_TYPE)
>  		result += sizeof(u64);
>  
>  	if (type & PERF_SAMPLE_DATA_SRC)
> @@ -1555,8 +1555,10 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
>  		}
>  	}
>  
> -	if (type & PERF_SAMPLE_WEIGHT) {
> +	if (type & PERF_SAMPLE_WEIGHT_TYPE) {
>  		*array = sample->weight;
> +		if (type & PERF_SAMPLE_WEIGHT_STRUCT)
> +			*array &= 0xffffffff;
>  		array++;
>  	}
>  
> -- 
> 2.7.4
> 

-- 

- Arnaldo
