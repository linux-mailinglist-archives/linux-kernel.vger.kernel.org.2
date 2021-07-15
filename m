Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60C93C96B5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 05:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbhGOD4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 23:56:16 -0400
Received: from foss.arm.com ([217.140.110.172]:46282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231378AbhGOD4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 23:56:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FEA2D6E;
        Wed, 14 Jul 2021 20:53:21 -0700 (PDT)
Received: from [10.163.66.71] (unknown [10.163.66.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C44BC3F774;
        Wed, 14 Jul 2021 20:53:17 -0700 (PDT)
Subject: Re: [PATCH 3/5] coresight: trbe: Keep TRBE disabled on overflow irq
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        al.grant@arm.com, leo.yan@linaro.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, peterz@infradead.org, Tamas.Zsoldos@arm.com,
        will@kernel.org
References: <20210712113830.2803257-1-suzuki.poulose@arm.com>
 <20210712113830.2803257-4-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <4ea6e548-db54-a3cc-751e-42700d76704f@arm.com>
Date:   Thu, 15 Jul 2021 09:24:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210712113830.2803257-4-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/21 5:08 PM, Suzuki K Poulose wrote:
> When an AUX buffer is marked TRUNCATED, the kernel will disable
> the event (via irq_work) and can only be re-enabled by the
> userspace tool.

Will it be renabled via normal perf event enable callback OR an
explicit perf event restart is required upon the TRUNCATED flag ?

> 
> Also, since we *always* mark the buffer as TRUNCATED (which is
> needs to be reconsidered, see below), we need not re-enable the
> TRBE as the event is going to be now disabled. This follows the
> SPE driver behavior.
> 
> Without this change, we could leave the event disabled for
> ever under certain conditions. i.e, when we try to re-enable
> in the IRQ handler, if there is no space left in the buffer,
> we "TRUNCATE" the buffer and create a record of size 0.
> The perf tool skips such records and the event will remain
> disabled forever.

Why ? Should not the user space tool explicitly start back the
tracing event after detecting zero sized record with buffer
marked with TRUNCATE flag ? What prevents it to restart the
event ?

> 
> Regarding the use of TRUNCATED flag:
> With FILL mode, the TRBE stops collection when the buffer is
> full, raising the IRQ. Now, since the IRQ is asynchronous,
> we could loose some amount of trace, after the buffer was
> full until the IRQ is handled. Also the last packet may
> have been trimmed. The decoder can figure this out and
> cope with this. The side effect of this approach is:
> 
>  We always disable the event when there is an IRQ, even
>  when the other half of the ring buffer is free ! This
>  is not ideal.
> 
> Now, we should switch to using PARTIAL to indicate that there
> was potentially some partial trace packets in the buffer and
> some data was lost. We should use TRUNCATED only when there
> is absolutely no space in the ring buffer. This change would
> also require some additional changes in the CoreSight PMU
> framework to allow, sinks to "close" the handle (rather
> than the PMU driver closing the handle upon event_stop).
> So, until that is sorted, let us keep the TRUNCATED flag
> and the rework can be addressed separately.

But I guess this is a separate problem all together.

> 
> Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
> Reported-by: Tamas Zsoldos <Tamas.Zsoldos@arm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 34 +++++++-------------
>  1 file changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 176868496879..ec38cf17b693 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -696,10 +696,8 @@ static void trbe_handle_spurious(struct perf_output_handle *handle)
>  
>  static void trbe_handle_overflow(struct perf_output_handle *handle)
>  {
> -	struct perf_event *event = handle->event;
>  	struct trbe_buf *buf = etm_perf_sink_config(handle);
>  	unsigned long offset, size;
> -	struct etm_event_data *event_data;
>  
>  	offset = get_trbe_limit_pointer() - get_trbe_base_pointer();
>  	size = offset - PERF_IDX2OFF(handle->head, buf);
> @@ -709,30 +707,22 @@ static void trbe_handle_overflow(struct perf_output_handle *handle)
>  	/*
>  	 * Mark the buffer as truncated, as we have stopped the trace
>  	 * collection upon the WRAP event, without stopping the source.
> +	 *
> +	 * We don't re-enable the TRBE here, as the event is
> +	 * bound to be disabled due to the TRUNCATED flag.
> +	 * This is not ideal, as we could use the available space in
> +	 * the ring buffer and continue the tracing.
> +	 *
> +	 * TODO: Revisit the use of TRUNCATED flag and may be instead use
> +	 * PARTIAL, to indicate trace may contain partial packets.
> +	 * And TRUNCATED can be used only if we do not have enough space
> +	 * in the buffer. This would need additional changes in
> +	 * etm_event_stop() to allow the sinks to leave a closed
> +	 * aux_handle.
>  	 */
>  	perf_aux_output_flag(handle, PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW |
>  				     PERF_AUX_FLAG_TRUNCATED);
>  	perf_aux_output_end(handle, size);
> -	event_data = perf_aux_output_begin(handle, event);
> -	if (!event_data) {
> -		/*
> -		 * We are unable to restart the trace collection,
> -		 * thus leave the TRBE disabled. The etm-perf driver
> -		 * is able to detect this with a disconnected handle
> -		 * (handle->event = NULL).
> -		 */
> -		trbe_drain_and_disable_local();
> -		*this_cpu_ptr(buf->cpudata->drvdata->handle) = NULL;
> -		return;
> -	}
> -	buf->trbe_limit = compute_trbe_buffer_limit(handle);
> -	buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
> -	if (buf->trbe_limit == buf->trbe_base) {
> -		trbe_stop_and_truncate_event(handle);
> -		return;
> -	}
> -	*this_cpu_ptr(buf->cpudata->drvdata->handle) = handle;
> -	trbe_enable_hw(buf);
>  }

The change here just stops the event restart after handling the IRQ
and marking the buffer with PERF_AUX_FLAG_TRUNCATED which helps the
event from being disabled for ever (still need to understand how !).

I guess it might be better to separate out the problems with using
PERF_AUX_FLAG_TRUNCATED and related aspects, in a subsequent patch
which just updates the code with the above TODO comment ?

>  
>  static bool is_perf_trbe(struct perf_output_handle *handle)
> 
