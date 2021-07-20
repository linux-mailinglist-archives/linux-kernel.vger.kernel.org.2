Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F85D3CF69B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 11:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbhGTIZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 04:25:34 -0400
Received: from foss.arm.com ([217.140.110.172]:53892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234672AbhGTIUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 04:20:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 512106D;
        Tue, 20 Jul 2021 01:53:59 -0700 (PDT)
Received: from [10.57.36.145] (unknown [10.57.36.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A33D63F73D;
        Tue, 20 Jul 2021 01:53:57 -0700 (PDT)
Subject: Re: [PATCH 3/5] coresight: trbe: Keep TRBE disabled on overflow irq
To:     linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        al.grant@arm.com, anshuman.khandual@arm.com, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        peterz@infradead.org, Tamas.Zsoldos@arm.com, will@kernel.org
References: <20210712113830.2803257-1-suzuki.poulose@arm.com>
 <20210712113830.2803257-4-suzuki.poulose@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <97ddc527-9750-5604-201d-eb86206bca63@arm.com>
Date:   Tue, 20 Jul 2021 09:53:56 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210712113830.2803257-4-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2021 12:38, Suzuki K Poulose wrote:
> When an AUX buffer is marked TRUNCATED, the kernel will disable
> the event (via irq_work) and can only be re-enabled by the
> userspace tool.
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
> 
> Regarding the use of TRUNCATED flag:
> With FILL mode, the TRBE stops collection when the buffer is
> full, raising the IRQ. Now, since the IRQ is asynchronous,
> we could loose some amount of trace, after the buffer was
> full until the IRQ is handled. Also the last packet may
> have been trimmed. The decoder can figure this out and
> cope with this. The side effect of this approach is:
> 
>   We always disable the event when there is an IRQ, even
>   when the other half of the ring buffer is free ! This
>   is not ideal.
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

Based on an offline discussion, we have decided to drop the
TRUNCATED flag and use PARTIAL to indicate the IRQ fired
and some trace packets may be trimmed. So, I will rework
the fix to accommodate these changes and resend the series.
Please ignore the patches 3-5 in the series.

The first two patches are still valid, but I will send them
in as separate for ease of merging.

Kind regards
Suzuki


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
>   drivers/hwtracing/coresight/coresight-trbe.c | 34 +++++++-------------
>   1 file changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 176868496879..ec38cf17b693 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -696,10 +696,8 @@ static void trbe_handle_spurious(struct perf_output_handle *handle)
>   
>   static void trbe_handle_overflow(struct perf_output_handle *handle)
>   {
> -	struct perf_event *event = handle->event;
>   	struct trbe_buf *buf = etm_perf_sink_config(handle);
>   	unsigned long offset, size;
> -	struct etm_event_data *event_data;
>   
>   	offset = get_trbe_limit_pointer() - get_trbe_base_pointer();
>   	size = offset - PERF_IDX2OFF(handle->head, buf);
> @@ -709,30 +707,22 @@ static void trbe_handle_overflow(struct perf_output_handle *handle)
>   	/*
>   	 * Mark the buffer as truncated, as we have stopped the trace
>   	 * collection upon the WRAP event, without stopping the source.
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
>   	 */
>   	perf_aux_output_flag(handle, PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW |
>   				     PERF_AUX_FLAG_TRUNCATED);
>   	perf_aux_output_end(handle, size);
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
>   }
>   
>   static bool is_perf_trbe(struct perf_output_handle *handle)
> 

