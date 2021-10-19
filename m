Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F3A432D5D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhJSFo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:44:58 -0400
Received: from foss.arm.com ([217.140.110.172]:44636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhJSFoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:44:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 881842F;
        Mon, 18 Oct 2021 22:42:43 -0700 (PDT)
Received: from [10.163.74.241] (unknown [10.163.74.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 405673F73D;
        Mon, 18 Oct 2021 22:42:39 -0700 (PDT)
Subject: Re: [PATCH v5 10/15] coresight: trbe: Workaround TRBE errata
 overwrite in FILL mode
To:     Suzuki K Poulose <suzuki.poulose@arm.com>, will@kernel.org,
        mathieu.poirier@linaro.org
Cc:     catalin.marinas@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        maz@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211014223125.2605031-1-suzuki.poulose@arm.com>
 <20211014223125.2605031-11-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <b985d493-054e-6482-76ed-f28d9fe73192@arm.com>
Date:   Tue, 19 Oct 2021 11:12:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211014223125.2605031-11-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/21 4:01 AM, Suzuki K Poulose wrote:
> ARM Neoverse-N2 (#2139208) and Cortex-A710(##2119858) suffers from
> an erratum, which when triggered, might cause the TRBE to overwrite
> the trace data already collected in FILL mode, in the event of a WRAP.
> i.e, the TRBE doesn't stop writing the data, instead wraps to the base
> and could write upto 3 cache line size worth trace. Thus, this could
> corrupt the trace at the "BASE" pointer.
> 
> The workaround is to program the write pointer 256bytes from the
> base, such that if the erratum is triggered, it doesn't overwrite
> the trace data that was captured. This skipped region could be
> padded with ignore packets at the end of the session, so that
> the decoder sees a continuous buffer with some padding at the
> beginning. The trace data written at the base is considered
> lost as the limit could have been in the middle of the perf
> ring buffer, and jumping to the "base" is not acceptable.
> We set the flags already to indicate that some amount of trace
> was lost during the FILL event IRQ. So this is fine.
> 
> One important change with the work around is, we program the
> TRBBASER_EL1 to current page where we are allowed to write.
> Otherwise, it could overwrite a region that may be consumed
> by the perf. Towards this, we always make sure that the
> "handle->head" and thus the trbe_write is PAGE_SIZE aligned,
> so that we can set the BASE to the PAGE base and move the
> TRBPTR to the 256bytes offset.
> 
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
> Changes since v2:
>  - Updated the ASCII art to include better description of
>    all the steps in the work around
> Change since v1:
>  - Updated comment with ASCII art
>  - Add _BYTES suffix for the space to skip for the work around.
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 169 +++++++++++++++++--
>  1 file changed, 158 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 314e5e7374c7..b56b166b2dec 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -16,6 +16,7 @@
>  #define pr_fmt(fmt) DRVNAME ": " fmt
>  
>  #include <asm/barrier.h>
> +#include <asm/cpufeature.h>
>  
>  #include "coresight-self-hosted-trace.h"
>  #include "coresight-trbe.h"
> @@ -88,14 +89,22 @@ struct trbe_buf {
>   *   - Not duplicating the detection logic
>   *   - Streamlined detection of erratum across the system
>   */
> +#define TRBE_WORKAROUND_OVERWRITE_FILL_MODE	0
>  
>  static int trbe_errata_cpucaps[] = {
> +	[TRBE_WORKAROUND_OVERWRITE_FILL_MODE] = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
>  	-1,		/* Sentinel, must be the last entry */
>  };
>  
>  /* The total number of listed errata in trbe_errata_cpucaps */
>  #define TRBE_ERRATA_MAX			(ARRAY_SIZE(trbe_errata_cpucaps) - 1)
>  
> +/*
> + * Safe limit for the number of bytes that may be overwritten
> + * when ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE is triggered.
> + */
> +#define TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP_BYTES	256
> +
>  /*
>   * struct trbe_cpudata: TRBE instance specific data
>   * @trbe_flag		- TRBE dirty/access flag support
> @@ -146,6 +155,11 @@ static inline bool trbe_has_erratum(struct trbe_cpudata *cpudata, int i)
>  	return (i < TRBE_ERRATA_MAX) && test_bit(i, cpudata->errata);
>  }
>  
> +static inline bool trbe_may_overwrite_in_fill_mode(struct trbe_cpudata *cpudata)
> +{
> +	return trbe_has_erratum(cpudata, TRBE_WORKAROUND_OVERWRITE_FILL_MODE);
> +}
> +
>  static int trbe_alloc_node(struct perf_event *event)
>  {
>  	if (event->cpu == -1)
> @@ -549,10 +563,13 @@ static void trbe_enable_hw(struct trbe_buf *buf)
>  	set_trbe_limit_pointer_enabled(buf->trbe_limit);
>  }
>  
> -static enum trbe_fault_action trbe_get_fault_act(u64 trbsr)
> +static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *handle,
> +						 u64 trbsr)
>  {
>  	int ec = get_trbe_ec(trbsr);
>  	int bsc = get_trbe_bsc(trbsr);
> +	struct trbe_buf *buf = etm_perf_sink_config(handle);
> +	struct trbe_cpudata *cpudata = buf->cpudata;
>  
>  	WARN_ON(is_trbe_running(trbsr));
>  	if (is_trbe_trg(trbsr) || is_trbe_abort(trbsr))
> @@ -561,10 +578,16 @@ static enum trbe_fault_action trbe_get_fault_act(u64 trbsr)
>  	if ((ec == TRBE_EC_STAGE1_ABORT) || (ec == TRBE_EC_STAGE2_ABORT))
>  		return TRBE_FAULT_ACT_FATAL;
>  
> -	if (is_trbe_wrap(trbsr) && (ec == TRBE_EC_OTHERS) && (bsc == TRBE_BSC_FILLED)) {
> -		if (get_trbe_write_pointer() == get_trbe_base_pointer())
> -			return TRBE_FAULT_ACT_WRAP;
> -	}
> +	/*
> +	 * If the trbe is affected by TRBE_WORKAROUND_OVERWRITE_FILL_MODE,
> +	 * it might write data after a WRAP event in the fill mode.
> +	 * Thus the check TRBPTR == TRBBASER will not be honored.
> +	 */
> +	if ((is_trbe_wrap(trbsr) && (ec == TRBE_EC_OTHERS) && (bsc == TRBE_BSC_FILLED)) &&
> +	    (trbe_may_overwrite_in_fill_mode(cpudata) ||
> +	     get_trbe_write_pointer() == get_trbe_base_pointer()))
> +		return TRBE_FAULT_ACT_WRAP;
> +
>  	return TRBE_FAULT_ACT_SPURIOUS;
>  }
>  
> @@ -573,6 +596,8 @@ static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
>  {
>  	u64 write;
>  	u64 start_off, end_off;
> +	u64 size;
> +	u64 overwrite_skip = TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP_BYTES;
>  
>  	/*
>  	 * If the TRBE has wrapped around the write pointer has
> @@ -593,7 +618,18 @@ static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
>  
>  	if (WARN_ON_ONCE(end_off < start_off))
>  		return 0;
> -	return (end_off - start_off);
> +
> +	size = end_off - start_off;
> +	/*
> +	 * If the TRBE is affected by the following erratum, we must fill
> +	 * the space we skipped with IGNORE packets. And we are always
> +	 * guaranteed to have at least a PAGE_SIZE space in the buffer.
> +	 */
> +	if (trbe_has_erratum(buf->cpudata, TRBE_WORKAROUND_OVERWRITE_FILL_MODE) &&
> +	    !WARN_ON(size < overwrite_skip))
> +		__trbe_pad_buf(buf, start_off, overwrite_skip);
> +
> +	return size;
>  }
>  
>  static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
> @@ -712,7 +748,7 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
>  		clr_trbe_irq();
>  		isb();
>  
> -		act = trbe_get_fault_act(status);
> +		act = trbe_get_fault_act(handle, status);
>  		/*
>  		 * If this was not due to a WRAP event, we have some
>  		 * errors and as such buffer is empty.
> @@ -736,21 +772,117 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
>  	return size;
>  }
>  
> +
> +static int trbe_apply_work_around_before_enable(struct trbe_buf *buf)
> +{
> +	/*
> +	 * TRBE_WORKAROUND_OVERWRITE_FILL_MODE causes the TRBE to overwrite a few cache
> +	 * line size from the "TRBBASER_EL1" in the event of a "FILL".
> +	 * Thus, we could loose some amount of the trace at the base.
> +	 *
> +	 * Before Fix:
> +	 *
> +	 *  normal-BASE     head (normal-TRBPTR)         tail (normal-LIMIT)
> +	 *  |                   \/                       /
> +	 *   -------------------------------------------------------------
> +	 *  |   Pg0      |   Pg1       |           |          |  PgN     |
> +	 *   -------------------------------------------------------------
> +	 *
> +	 * In the normal course of action, we would set the TRBBASER to the
> +	 * beginning of the ring-buffer (normal-BASE). But with the erratum,
> +	 * the TRBE could overwrite the contents at the "normal-BASE", after
> +	 * hitting the "normal-LIMIT", since it doesn't stop as expected. And
> +	 * this is wrong. This could result in overwriting trace collected in
> +	 * one of the previous runs, being consumed by the user. So we must
> +	 * always make sure that the TRBBASER is within the region
> +	 * [head, head+size]. Note that TRBBASER must be PAGE aligned,
> +	 *
> +	 *  After moving the BASE:
> +	 *
> +	 *  normal-BASE     head (normal-TRBPTR)         tail (normal-LIMIT)
> +	 *  |                   \/                       /
> +	 *   -------------------------------------------------------------
> +	 *  |         |          |xyzdef.     |..   tuvw|                |
> +	 *   -------------------------------------------------------------
> +	 *                      /
> +	 *              New-BASER
> +	 *
> +	 * Also, we would set the TRBPTR to head (after adjusting for
> +	 * alignment) at normal-PTR. This would mean that the last few bytes
> +	 * of the trace (say, "xyz") might overwrite the first few bytes of
> +	 * trace written ("abc"). More importantly they will appear in what
> +	 * userspace sees as the beginning of the trace, which is wrong. We may
> +	 * not always have space to move the latest trace "xyz" to the correct
> +	 * order as it must appear beyond the LIMIT. (i.e, [head..head+size]).
> +	 * Thus it is easier to ignore those bytes than to complicate the
> +	 * driver to move it, assuming that the erratum was triggered and
> +	 * doing additional checks to see if there is indeed allowed space at
> +	 * TRBLIMITR.LIMIT.
> +	 *
> +	 *  Thus the full workaround will move the BASE and the PTR and would
> +	 *  look like (after padding at the skipped bytes at the end of
> +	 *  session) :
> +	 *
> +	 *  normal-BASE     head (normal-TRBPTR)         tail (normal-LIMIT)
> +	 *  |                   \/                       /
> +	 *   -------------------------------------------------------------
> +	 *  |         |          |///abc..     |..  rst|                |
> +	 *   -------------------------------------------------------------
> +	 *                      /    |
> +	 *              New-BASER    New-TRBPTR
> +	 *
> +	 * To summarize, with the work around:
> +	 *
> +	 *  - We always align the offset for the next session to PAGE_SIZE
> +	 *    (This is to ensure we can program the TRBBASER to this offset
> +	 *    within the region [head...head+size]).
> +	 *
> +	 *  - At TRBE enable:
> +	 *     - Set the TRBBASER to the page aligned offset of the current
> +	 *       proposed write offset. (which is guaranteed to be aligned
> +	 *       as above)
> +	 *     - Move the TRBPTR to skip first 256bytes (that might be
> +	 *       overwritten with the erratum). This ensures that the trace
> +	 *       generated in the session is not re-written.
> +	 *
> +	 *  - At trace collection:
> +	 *     - Pad the 256bytes skipped above again with IGNORE packets.
> +	 */
> +	if (trbe_has_erratum(buf->cpudata, TRBE_WORKAROUND_OVERWRITE_FILL_MODE)) {
> +		if (WARN_ON(!IS_ALIGNED(buf->trbe_write, PAGE_SIZE)))
> +			return -EINVAL;
> +		buf->trbe_hw_base = buf->trbe_write;
> +		buf->trbe_write += TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP_BYTES;
> +	}
> +
> +	return 0;
> +}
> +
>  static int __arm_trbe_enable(struct trbe_buf *buf,
>  			     struct perf_output_handle *handle)
>  {
> +	int ret = 0;
> +
>  	perf_aux_output_flag(handle, PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW);
>  	buf->trbe_limit = compute_trbe_buffer_limit(handle);
>  	buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
>  	if (buf->trbe_limit == buf->trbe_base) {
> -		trbe_stop_and_truncate_event(handle);
> -		return -ENOSPC;
> +		ret = -ENOSPC;
> +		goto err;
>  	}
>  	/* Set the base of the TRBE to the buffer base */
>  	buf->trbe_hw_base = buf->trbe_base;
> +
> +	ret = trbe_apply_work_around_before_enable(buf);
> +	if (ret)
> +		goto err;
> +
>  	*this_cpu_ptr(buf->cpudata->drvdata->handle) = handle;
>  	trbe_enable_hw(buf);
>  	return 0;
> +err:
> +	trbe_stop_and_truncate_event(handle);
> +	return ret;
>  }
>  
>  static int arm_trbe_enable(struct coresight_device *csdev, u32 mode, void *data)
> @@ -890,7 +1022,7 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
>  	if (!is_perf_trbe(handle))
>  		return IRQ_NONE;
>  
> -	act = trbe_get_fault_act(status);
> +	act = trbe_get_fault_act(handle, status);
>  	switch (act) {
>  	case TRBE_FAULT_ACT_WRAP:
>  		truncated = !!trbe_handle_overflow(handle);
> @@ -1038,7 +1170,22 @@ static void arm_trbe_probe_cpu(void *info)
>  	 */
>  	trbe_check_errata(cpudata);
>  
> -	cpudata->trbe_align = cpudata->trbe_hw_align;
> +	/*
> +	 * If the TRBE is affected by erratum TRBE_WORKAROUND_OVERWRITE_FILL_MODE,
> +	 * we must always program the TBRPTR_EL1, 256bytes from a page
> +	 * boundary, with TRBBASER_EL1 set to the page, to prevent
> +	 * TRBE over-writing 256bytes at TRBBASER_EL1 on FILL event.
> +	 *
> +	 * Thus make sure we always align our write pointer to a PAGE_SIZE,
> +	 * which also guarantees that we have at least a PAGE_SIZE space in
> +	 * the buffer (TRBLIMITR is PAGE aligned) and thus we can skip
> +	 * the required bytes at the base.
> +	 */
> +	if (trbe_may_overwrite_in_fill_mode(cpudata))
> +		cpudata->trbe_align = PAGE_SIZE;
> +	else
> +		cpudata->trbe_align = cpudata->trbe_hw_align;
> +
>  	cpudata->trbe_flag = get_trbe_flag_update(trbidr);
>  	cpudata->cpu = cpu;
>  	cpudata->drvdata = drvdata;
> 
