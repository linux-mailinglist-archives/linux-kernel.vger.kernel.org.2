Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C56432359
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhJRPyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbhJRPyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:54:10 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34242C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 08:51:59 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so326000pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 08:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dbsqgl5Zdd6kyJjAcuiZCPoayu2Y1/REj0RPfEE1I9A=;
        b=tuuF7RfI5Gb0A82IpRQaF2pv5kHiieCynnxJx/gd0w/OmRGHWtFJMcm+4EyM9FVIaQ
         iSF7QT6d8G5umY1xPm3OJ8Levrp1HwKSY40FSqR3l5AYob489x3/RN5RcIm6xkEkNqv6
         dDV8toceQkTTQAwzgqfDbi4I9apQEQVaikrJ9z2QQvs8FHIm/nenDOYH/8g3hIwvSPD4
         8EAzWcOXrthUTYdrU+PIYdRebaDCGjzGhKfVgm9BZ6gq9iXuwx4e6PFNBY6UN81bkIjm
         uXn14d/set6LDoywz3lH2RUBWdoeAm4toPIKo2nkriIilEO9GHFZQTqFkUgEVWkZtZ5N
         OoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dbsqgl5Zdd6kyJjAcuiZCPoayu2Y1/REj0RPfEE1I9A=;
        b=u3XIPR4ci7wxyO+S2gHRXcOJHRR0gO91XrbGjhxAs6x0M74Xm5VR69LYboa/syW27r
         Vks8769ZmDu4MmONLqsi7/JvREp6B0zl8ZGAh/vy3qoQw/HMOOCxCzll3QIadFb6V9sM
         HT0IIj1GPx3+Th0WBqrDelIB/TNA2KFf8i0PWyA2yQlesvFggZ9SIoQR6j/GXoz2U+RW
         t1PLqhNeY3R0lZrat/qHQRF7Bd/nMGl+py/B9eO6juxMhFrr+lev/2ksZfRsVA7f2iFX
         B/AFND+411YiGzni8XmUXerhrHFuLnooe8tFyt+so5LrgH0CenmPXBYgnNLtJ2lFV+Kt
         MPBw==
X-Gm-Message-State: AOAM530hsGnN+f3oMw8xr84KzqRHcHhpjNDs0uNzccomJxE5tK4F2gJS
        welU9VJPyt0Z044Xu/m+M4v7mA==
X-Google-Smtp-Source: ABdhPJxLYjZQvkctz6oqmifxbjO03cinuT4Qi/iwYar6vEoa31Sa4qnFkDOYX/bOxbXWUqa+mIJ4Tw==
X-Received: by 2002:a17:903:228c:b0:13e:f389:4ca9 with SMTP id b12-20020a170903228c00b0013ef3894ca9mr27882040plh.80.1634572318571;
        Mon, 18 Oct 2021 08:51:58 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id o26sm14105240pfp.177.2021.10.18.08.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 08:51:56 -0700 (PDT)
Date:   Mon, 18 Oct 2021 09:51:54 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     will@kernel.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/15] coresight: trbe: Workaround TRBE errata
 overwrite in FILL mode
Message-ID: <20211018155154.GB3163131@p14s>
References: <20211014223125.2605031-1-suzuki.poulose@arm.com>
 <20211014223125.2605031-11-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014223125.2605031-11-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 11:31:20PM +0100, Suzuki K Poulose wrote:
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

Here too I get a checkpatch warning...

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
> -- 
> 2.25.4
> 
