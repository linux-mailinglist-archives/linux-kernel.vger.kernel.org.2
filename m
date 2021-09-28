Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC8541AD2E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240249AbhI1Kme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:42:34 -0400
Received: from foss.arm.com ([217.140.110.172]:50038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240162AbhI1Kmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:42:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 044E26D;
        Tue, 28 Sep 2021 03:40:54 -0700 (PDT)
Received: from [10.57.95.68] (unknown [10.57.95.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E64493F7B4;
        Tue, 28 Sep 2021 03:40:51 -0700 (PDT)
Subject: Re: [PATCH v2 09/17] coresight: trbe: Workaround TRBE errata
 overwrite in FILL mode
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        leo.yan@linaro.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, will@kernel.org, lcherian@marvell.com,
        coresight@lists.linaro.org
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-10-suzuki.poulose@arm.com>
 <7ae6b3a6-1fa2-a655-9347-2263a1701c91@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <1e3e8f53-6e1e-75a9-af74-36b72a0f63d6@arm.com>
Date:   Tue, 28 Sep 2021 11:40:50 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <7ae6b3a6-1fa2-a655-9347-2263a1701c91@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2021 07:13, Anshuman Khandual wrote:
> 
> 
> On 9/21/21 7:11 PM, Suzuki K Poulose wrote:
>> ARM Neoverse-N2 (#2139208) and Cortex-A710(##2119858) suffers from
>> an erratum, which when triggered, might cause the TRBE to overwrite
>> the trace data already collected in FILL mode, in the event of a WRAP.
>> i.e, the TRBE doesn't stop writing the data, instead wraps to the base
>> and could write upto 3 cache line size worth trace. Thus, this could
>> corrupt the trace at the "BASE" pointer.
>>
>> The workaround is to program the write pointer 256bytes from the
> 
> 3 cache lines = 256 bytes on all implementation which might have TRBE ?
> OR this skid bytes should be derived from the platform cache line size
> instead.

256bytes is the aligned (to the power of 2) value for the safe guard.
Not 3 cache lines. Ideally, if there is another CPU that has larger
cache line size, affected by the erratum, yes, we must do that.
But for now this is sufficient.

> 
>> base, such that if the erratum is triggered, it doesn't overwrite
>> the trace data that was captured. This skipped region could be
>> padded with ignore packets at the end of the session, so that
>> the decoder sees a continuous buffer with some padding at the
>> beginning. The trace data written at the base is considered
>> lost as the limit could have been in the middle of the perf
>> ring buffer, and jumping to the "base" is not acceptable.
>> We set the flags already to indicate that some amount of trace
>> was lost during the FILL event IRQ. So this is fine.
> 
> Via PERF_AUX_FLAG_TRUNCATED ? Should be specified here to be clear.

Please note that setting the flag is not a side effect of the
work around. And as such I don't think this needs to be mentioned
here. e.g, we changed this to COLLISION recently for WRAP events.
It makes sense to keep the details to the driver.

> 
>>

>> One important change with the work around is, we program the
>> TRBBASER_EL1 to current page where we are allowed to write.
>> Otherwise, it could overwrite a region that may be consumed
>> by the perf. Towards this, we always make sure that the
>> "handle->head" and thus the trbe_write is PAGE_SIZE aligned,
>> so that we can set the BASE to the PAGE base and move the
>> TRBPTR to the 256bytes offset.
>>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Change since v1:
>>   - Updated comment with ASCII art
>>   - Add _BYTES suffix for the space to skip for the work around.
>> ---
>>   drivers/hwtracing/coresight/coresight-trbe.c | 144 +++++++++++++++++--
>>   1 file changed, 132 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>> index f569010c672b..983dd5039e52 100644
>> --- a/drivers/hwtracing/coresight/coresight-trbe.c
>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>> @@ -16,6 +16,7 @@
>>   #define pr_fmt(fmt) DRVNAME ": " fmt
>>   
>>   #include <asm/barrier.h>
>> +#include <asm/cpufeature.h>
>>   #include <asm/cputype.h>
>>   
>>   #include "coresight-self-hosted-trace.h"
>> @@ -84,9 +85,17 @@ struct trbe_buf {
>>    * per TRBE instance, we keep track of the list of errata that
>>    * affects the given instance of the TRBE.
>>    */
>> -#define TRBE_ERRATA_MAX			0
>> +#define TRBE_WORKAROUND_OVERWRITE_FILL_MODE	0
>> +#define TRBE_ERRATA_MAX				1
>> +
>> +/*
>> + * Safe limit for the number of bytes that may be overwritten
>> + * when the erratum is triggered.
>> + */
>> +#define TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP_BYTES	256
> 
> As mentioned earlier, does it depend on the platform cache line size ?
> Otherwise if the skip bytes is something platform independent, should
> be mentioned here in a comment.

I could add in a comment.

> 
>>   
>>   static unsigned long trbe_errata_cpucaps[TRBE_ERRATA_MAX] = {
>> +	[TRBE_WORKAROUND_OVERWRITE_FILL_MODE] = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
>>   };
>>   
>>   /*
>> @@ -519,10 +528,13 @@ static void trbe_enable_hw(struct trbe_buf *buf)
>>   	set_trbe_limit_pointer_enabled(buf->trbe_limit);
>>   }
>>   
>> -static enum trbe_fault_action trbe_get_fault_act(u64 trbsr)
>> +static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *handle,
>> +						 u64 trbsr)
>>   {
>>   	int ec = get_trbe_ec(trbsr);
>>   	int bsc = get_trbe_bsc(trbsr);
>> +	struct trbe_buf *buf = etm_perf_sink_config(handle);
>> +	struct trbe_cpudata *cpudata = buf->cpudata;
> 
> Passing down the perf handle to derive trbe_cpudata seems to be right.
> 
>>   
>>   	WARN_ON(is_trbe_running(trbsr));
>>   	if (is_trbe_trg(trbsr) || is_trbe_abort(trbsr))
>> @@ -531,10 +543,16 @@ static enum trbe_fault_action trbe_get_fault_act(u64 trbsr)
>>   	if ((ec == TRBE_EC_STAGE1_ABORT) || (ec == TRBE_EC_STAGE2_ABORT))
>>   		return TRBE_FAULT_ACT_FATAL;
>>   
>> -	if (is_trbe_wrap(trbsr) && (ec == TRBE_EC_OTHERS) && (bsc == TRBE_BSC_FILLED)) {
>> -		if (get_trbe_write_pointer() == get_trbe_base_pointer())
>> -			return TRBE_FAULT_ACT_WRAP;
>> -	}
>> +	/*
>> +	 * If the trbe is affected by TRBE_WORKAROUND_OVERWRITE_FILL_MODE,
>> +	 * it might write data after a WRAP event in the fill mode.
>> +	 * Thus the check TRBPTR == TRBBASER will not be honored.
>> +	 */
> 
> Needs bit formatting/alignment cleanup.
> 
>> +	if ((is_trbe_wrap(trbsr) && (ec == TRBE_EC_OTHERS) && (bsc == TRBE_BSC_FILLED)) &&
>> +	    (trbe_has_erratum(cpudata, TRBE_WORKAROUND_OVERWRITE_FILL_MODE) ||
>> +	     get_trbe_write_pointer() == get_trbe_base_pointer()))
>> +		return TRBE_FAULT_ACT_WRAP;
>> +
> 
> Right, TRBE without the errata should continue to have the write
> pointer = base pointer check. Could all TRBE errata checks like
> the following be shortened (without the workaround index) for
> better readability ? But not something very important.
> 
> trbe_has_erratum(cpudata, TRBE_WORKAROUND_OVERWRITE_FILL_MODE)

Do you mean something like :

trbe_has_erratum(cpudata, TRBE_WORKAROUND_OVERWRITE_FILL_MODE) ->
trbe_may_overwrite_in_fill_mode(cpudata) ?


> 
> 
>>   	return TRBE_FAULT_ACT_SPURIOUS;
>>   }
>>   
>> @@ -544,6 +562,8 @@ static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
>>   {
>>   	u64 write;
>>   	u64 start_off, end_off;
>> +	u64 size;
>> +	u64 overwrite_skip = TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP_BYTES;
>>   
>>   	/*
>>   	 * If the TRBE has wrapped around the write pointer has
>> @@ -559,7 +579,18 @@ static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
>>   
>>   	if (WARN_ON_ONCE(end_off < start_off))
>>   		return 0;
>> -	return (end_off - start_off);
>> +
>> +	size = end_off - start_off;
>> +	/*
>> +	 * If the TRBE is affected by the following erratum, we must fill
>> +	 * the space we skipped with IGNORE packets. And we are always
>> +	 * guaranteed to have at least a PAGE_SIZE space in the buffer.
>> +	 */
>> +	if (trbe_has_erratum(buf->cpudata, TRBE_WORKAROUND_OVERWRITE_FILL_MODE) &&
>> +	    !WARN_ON(size < overwrite_skip))
>> +		__trbe_pad_buf(buf, start_off, overwrite_skip);
>> +
>> +	return size;
>>   }
>>   
>>   static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
>> @@ -678,7 +709,7 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
>>   		clr_trbe_irq();
>>   		isb();
>>   
>> -		act = trbe_get_fault_act(status);
>> +		act = trbe_get_fault_act(handle, status);
>>   		/*
>>   		 * If this was not due to a WRAP event, we have some
>>   		 * errors and as such buffer is empty.
>> @@ -702,21 +733,95 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
>>   	return size;
>>   }
>>   
>> +
>> +static int trbe_apply_work_around_before_enable(struct trbe_buf *buf)
>> +{
>> +	/*
>> +	 * TRBE_WORKAROUND_OVERWRITE_FILL_MODE causes the TRBE to overwrite a few cache
> 
> few cache lines = 3 cache lines ?

Yes, upto 3.

> 
>> +	 * line size from the "TRBBASER_EL1" in the event of a "FILL".
>> +	 * Thus, we could loose some amount of the trace at the base.
>> +	 *
>> +	 * Before Fix:
>> +	 *
>> +	 *  normal-BASE     head  normal-PTR              tail normal-LIMIT
>> +	 *  |                   \/                       /
>> +	 *   -------------------------------------------------------------
>> +	 *  |         |          |xyzdefghij..|...  tuvw|                |
>> +	 *   -------------------------------------------------------------
>> +	 *                      /    |                   \
>> +	 * After Fix->  TRBBASER     TRBPTR              TRBLIMITR.LIMIT
>> +	 *
>> +	 * In the normal course of action, we would set the TRBBASER to the
>> +	 * beginning of the ring-buffer (normal-BASE). But with the erratum,
>> +	 * the TRBE could overwrite the contents at the "normal-BASE", after
>> +	 * hitting the "normal-LIMIT", since it doesn't stop as expected. And
>> +	 * this is wrong. So we must always make sure that the TRBBASER is
>> +	 * within the region [head, head+size].
>> +	 *
>> +	 * Also, we would set the TRBPTR to head (after adjusting for
>> +	 * alignment) at normal-PTR. This would mean that the last few bytes
>> +	 * of the trace (say, "xyz") might overwrite the first few bytes of
>> +	 * trace written ("abc"). More importantly they will appear in what\
>> +	 * userspace sees as the beginning of the trace, which is wrong. We may
>> +	 * not always have space to move the latest trace "xyz" to the correct
>> +	 * order as it must appear beyond the LIMIT. (i.e, [head..head+size].
>> +	 * Thus it is easier to ignore those bytes than to complicate the
>> +	 * driver to move it, assuming that the erratum was triggered and doing
>> +	 * additional checks to see if there is indeed allowed space at
>> +	 * TRBLIMITR.LIMIT.
>> +	 *
>> +	 * To summarize, with the work around:
>> +	 *
>> +	 *  - We always align the offset for the next session to PAGE_SIZE
>> +	 *    (This is to ensure we can program the TRBBASER to this offset
>> +	 *    within the region [head...head+size]).
>> +	 *
>> +	 *  - At TRBE enable:
>> +	 *     - Set the TRBBASER to the page aligned offset of the current
>> +	 *       proposed write offset. (which is guaranteed to be aligned
>> +	 *       as above)
>> +	 *     - Move the TRBPTR to skip first 256bytes (that might be
>> +	 *       overwritten with the erratum). This ensures that the trace
>> +	 *       generated in the session is not re-written.
>> +	 *
>> +	 *  - At trace collection:
>> +	 *     - Pad the 256bytes skipped above again with IGNORE packets.
>> +	 */
>> +	if (trbe_has_erratum(buf->cpudata, TRBE_WORKAROUND_OVERWRITE_FILL_MODE)) {
>> +		if (WARN_ON(!IS_ALIGNED(buf->trbe_write, PAGE_SIZE)))
>> +			return -EINVAL;
>> +		buf->trbe_hw_base = buf->trbe_write;
>> +		buf->trbe_write += TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP_BYTES;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int __arm_trbe_enable(struct trbe_buf *buf,
>>   			     struct perf_output_handle *handle)
>>   {
>> +	int ret = 0;
>> +
>>   	perf_aux_output_flag(handle, PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW);
>>   	buf->trbe_limit = compute_trbe_buffer_limit(handle);
>>   	buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
>>   	if (buf->trbe_limit == buf->trbe_base) {
>> -		trbe_stop_and_truncate_event(handle);
>> -		return -ENOSPC;
>> +		ret = -ENOSPC;
>> +		goto err;
>>   	}
>>   	/* Set the base of the TRBE to the buffer base */
>>   	buf->trbe_hw_base = buf->trbe_base;
>> +
>> +	ret = trbe_apply_work_around_before_enable(buf);
>> +	if (ret)
>> +		goto err;
>> +
>>   	*this_cpu_ptr(buf->cpudata->drvdata->handle) = handle;
>>   	trbe_enable_hw(buf);
>>   	return 0;
>> +err:
>> +	trbe_stop_and_truncate_event(handle);
>> +	return ret;
>>   }
>>   
>>   static int arm_trbe_enable(struct coresight_device *csdev, u32 mode, void *data)
>> @@ -860,7 +965,7 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
>>   	if (!is_perf_trbe(handle))
>>   		return IRQ_NONE;
>>   
>> -	act = trbe_get_fault_act(status);
>> +	act = trbe_get_fault_act(handle, status);
>>   	switch (act) {
>>   	case TRBE_FAULT_ACT_WRAP:
>>   		truncated = !!trbe_handle_overflow(handle);
>> @@ -1000,7 +1105,22 @@ static void arm_trbe_probe_cpu(void *info)
>>   	}
>>   
>>   	trbe_check_errata(cpudata);
>> -	cpudata->trbe_align = cpudata->trbe_hw_align;
>> +	/*
>> +	 * If the TRBE is affected by erratum TRBE_WORKAROUND_OVERWRITE_FILL_MODE,
>> +	 * we must always program the TBRPTR_EL1, 256bytes from a page
>> +	 * boundary, with TRBBASER_EL1 set to the page, to prevent
>> +	 * TRBE over-writing 256bytes at TRBBASER_EL1 on FILL event.
>> +	 *
>> +	 * Thus make sure we always align our write pointer to a PAGE_SIZE,
>> +	 * which also guarantees that we have at least a PAGE_SIZE space in
>> +	 * the buffer (TRBLIMITR is PAGE aligned) and thus we can skip
>> +	 * the required bytes at the base.
>> +	 */
>> +	if (trbe_has_erratum(cpudata, TRBE_WORKAROUND_OVERWRITE_FILL_MODE))
>> +		cpudata->trbe_align = PAGE_SIZE;
>> +	else
>> +		cpudata->trbe_align = cpudata->trbe_hw_align;
>> +
> 
> But like trbe_apply_work_around_before_enable(), trbe_align assignment
> should also be wrapped inside a new helper which should contain these
> comments and conditional block. Because it makes sense to have errata
> work arounds in the leaf level helper functions, rather than TRBE core
> operations.

That would imply we re-initialize the trbe_align in the new helper after
setting the value here for all other unaffected TRBEs. I would rather
leave it as it is, until we have more work arounds that touch this area.
This is one of code called per TRBE instance.

Suzuki
