Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B8840471D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 10:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhIIIiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 04:38:23 -0400
Received: from foss.arm.com ([217.140.110.172]:57530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231691AbhIIIiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 04:38:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75CE06D;
        Thu,  9 Sep 2021 01:37:12 -0700 (PDT)
Received: from [10.57.94.84] (unknown [10.57.94.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5130C3F5A1;
        Thu,  9 Sep 2021 01:37:10 -0700 (PDT)
Subject: Re: [PATCH 08/10] coresight: trbe: Workaround TRBE errat overwrite in
 FILL mode
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, mark.rutland@arm.com
References: <20210728135217.591173-1-suzuki.poulose@arm.com>
 <20210728135217.591173-9-suzuki.poulose@arm.com>
 <7edeb6de-5de6-e9b1-c684-a7f5782d9a7b@arm.com>
 <ede246ee-6648-bb32-57b5-4a983d983736@arm.com>
 <3b20c016-446a-1556-745f-7d8a6a2c47e3@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <17d7cd6e-0a56-7636-2154-5b45c1e25955@arm.com>
Date:   Thu, 9 Sep 2021 09:37:08 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3b20c016-446a-1556-745f-7d8a6a2c47e3@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2021 05:21, Anshuman Khandual wrote:
> 
> 
> On 9/7/21 3:28 PM, Suzuki K Poulose wrote:
>> On 03/08/2021 11:25, Anshuman Khandual wrote:
>>> 
>>> 
>>> On 7/28/21 7:22 PM, Suzuki K Poulose wrote:
>>>> ARM Neoverse-N2 (#2139208) and Cortex-A710(##2119858) suffers
>>>> from an erratum, which when triggered, might cause the TRBE to
>>>> overwrite the trace data already collected in FILL mode, in the
>>>> event of a WRAP. i.e, the TRBE doesn't stop writing the data,
>>>> instead wraps to the base and could write upto 3 cache line
>>>> size worth trace. Thus, this could corrupt the trace at the
>>>> "BASE" pointer.
>>>> 
>>>> The workaround is to program the write pointer 256bytes from
>>>> the base, such that if the erratum is triggered, it doesn't
>>>> overwrite the trace data that was captured. This skipped region
>>>> could be padded with ignore packets at the end of the session,
>>>> so that the decoder sees a continuous buffer with some padding
>>>> at the beginning. The trace data written at the base is
>>>> considered lost as the limit could have been in the middle of
>>>> the perf ring buffer, and jumping to the "base" is not
>>>> acceptable.
>>> 
>>> If the write pointer is guaranteed to have always started beyond 
>>> [base + 256] and then wraps around. Why cannot the initial trace 
>>> at [base .. base + 256] not to be considered for perf ?
>> 
>> Remember that we could be dealing with a region within the larger 
>> ring buffer.
>> 
>> Ring buffer
>> 
>> | write (head + 256) v 
>> \---------xxxxx----------------------------------/ ^
>> ^                   ^ head |                 | Limit
>> Ring buffer end
>> 
>> In this case, you are talking about the area marked as "xxx", which
>> ideally should be appearing just after Limit, in the normal course
>> of the trace without the erratum.
> 
> Right.
> 
>> 
>> Thus leaving the data at [base.. base+256] should be ideally moved
>> to the end (after limit ptr). And :
>> 
>> 1) We don't always have space after the "limit" in the ring
>> buffer. 2) We don't know if the erratum was triggered at all, under
>> the micro architectural conditions.
>> 
>> So, it is ideal to live with this ignoring the trace for now.
> 
> But could not we just do something like this instead.
> 
> - While re-configuring and before starting the trace, pad the entire 
> area i.e [base .. base + 256] with ignore packets.
> 

Ok, we do that now.

> - After an wrap event, push [base .. base + 256] into the perf ring 
> buffer via perf_aux_output_begin()/end() just after normal trace data
> capture (perf ring buffer indices would have got adjusted to accept
> some new buffer data).

How ? The TRBE *is* writing to the perf ring buffer. When the erratum
is triggered, the trace data written at [base ... base + 256] was
supposed to be written to [Limit .. Limit + 256] by the TRBE. So
if at all we want to push those 256bytes into the ring buffer, we have
to *move* 256bytes from "base" to the "Limit" (and pad the buffer at
[base...base + 256]). Now, the Limit was chosen based on the available
space in the ring buffer (or the wakeup). And thus we may not have space
beyond (i.e is outside the head..head+size) the "Limit".

> 
> Afterwards, if the erratum is triggered, real trace is captured. But 
> otherwise, there is always ignore packets for the decoder to parse.

The erratum is only triggered at WRAP what you describe above is 
combined with the above step. Userspace dealing with 256bytes
of Ignore for each record is still acceptable, given the benefit of
being able to use the TRBE on such affected systems.

>> 
>>> 
>>>> We set the flags already to indicate that some amount of trace 
>>>> was lost during the FILL event IRQ. So this is fine.
>>> 
>>> Right, from perf data flag point of view it is not a problem. But
>>> I am still wondering why cannot the trace at the base can not be
>>> consumed by perf.
>>> 
>> 
>> Please see above.
>> 
>>>> 
>>>> One important change with the work around is, we program the 
>>>> TRBBASER_EL1 to current page where we are allowed to write. 
>>>> Otherwise, it could overwrite a region that may be consumed by
>>>> the perf. Towards this, we always make sure that the
>>> 
>>> While enabling TRBE after required reconfiguration, this will 
>>> cause both TRBBASER_EL1 and TRBPTR_EL1 to change each time around
>>> (basically TRBBASER_EL1 follows handle->head) ?
>> 
>> Yes. This is to ensure that the TRBE doesn't corrupt the "trace 
>> data" at the "start" of the actual ring buffer (not the area that
>> we are allowed to write). In a nutshell, TRBE is only allowed to
>> write within the area [head ... head + size].
> 
> Okay.
> 
>> 
>>> 
>>>> "handle->head" and thus the trbe_write is PAGE_SIZE aligned, so
>>>> that we can set the BASE to the PAGE base and move the TRBPTR
>>>> to the 256bytes offset.
>>> 
>>> Now that base needs to follow handle->head, both needs to be 
>>> PAGE_SIZE aligned (including the write pointer) because base 
>>> pointer needs to be PAGE_SIZE aligned ?
>> 
>> Base must always be page aligned for TRBE. Now, with the erratum, 
>> the Base must be within [ head ... head + size ]. Thus we cannot 
>> put TRBPTR (write ptr) outside [TRBBASER ... TRBLIMITR], the write
>> ptr follows the base and it is shifted by 256byte to allow the
>> scratch space for overwrite, when the erratum triggers.
> 
> Okay.
> 
>> 
>>> 
>>>> 
>>>> Cc: Mike Leach <mike.leach@linaro.org> Cc: Mathieu Poirier
>>>> <mathieu.poirier@linaro.org> Cc: Anshuman Khandual
>>>> <anshuman.khandual@arm.com> Cc: Leo Yan <leo.yan@linaro.org> 
>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com> --- 
>>>> drivers/hwtracing/coresight/coresight-trbe.c | 111
>>>> +++++++++++++++++-- 1 file changed, 102 insertions(+), 9
>>>> deletions(-)
>>>> 
>>>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c
>>>> b/drivers/hwtracing/coresight/coresight-trbe.c index
>>>> 9ea28813182b..cd997ed5d918 100644 ---
>>>> a/drivers/hwtracing/coresight/coresight-trbe.c +++
>>>> b/drivers/hwtracing/coresight/coresight-trbe.c @@ -17,6 +17,7
>>>> @@ #include <asm/barrier.h> #include <asm/cputype.h> +#include
>>>> <asm/cpufeature.h> #include "coresight-self-hosted-trace.h" 
>>>> #include "coresight-trbe.h" @@ -84,9 +85,17 @@ struct trbe_buf
>>>> { * per TRBE instance, we keep track of the list of errata
>>>> that * affects the given instance of the TRBE. */ -#define
>>>> TRBE_ERRATA_MAX            0 +#define
>>>> TRBE_WORKAROUND_OVERWRITE_FILL_MODE    0 +#define
>>>> TRBE_ERRATA_MAX                1
>>> 
>>> Although I am not sure how to achieve it, TRBE_ERRATA_MAX should
>>> be derived from errata cpucap start and end markers which
>>> identify all TRBE specific erratas. The hard coding above could
>>> be avoided.
>> 
>> This lets us hand pick the TRBE errata and avoid having to do 
>> something you say is hard to achieve. What do you think is 
>> problematic with this approach ?
> 
> No problem as such.
> 
> Now that we know the arm64 erratums are not linear and might also 
> have non-TRBE erratums in-between its range. Hence there might not be
> any ARM64_TRBE_ERRATA_START and ARM64_TRBE_ERRATA_END markers, which
> I was hoping for. The original thought was those potential markers
> could have helped derive TRBE_ERRATA_MAX automatically.
> 
>> 
>>> 
>>>> + +/* + * Safe limit for the number of bytes that may be
>>>> overwritten + * when the erratum is triggered.
>>> 
>>> Specify which errata ?
>> 
>> There are two distinct CPU errata. I will try to make it a bit
>> more clear.
>> 
>>> 
>>>> + */ +#define TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP    256
>>> 
>>> Needs to have _BYTES. TRBE_ERRATA_OVERWRITE_FILL_MODE_SKIP_BYTES
>>> ?
>>> 
>>>> static unsigned long trbe_errata_cpucaps[TRBE_ERRATA_MAX] = { +
>>>> [TRBE_WORKAROUND_OVERWRITE_FILL_MODE] =
>>>> ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
>>> 
>>> s/TRBE_WORKAROUND_OVERWRITE_FILL_MODE/TRBE_ERRATA_OVERWRITE_FILL_MODE
>>> instead ?
>>> 
>>> ARM64_WORKAROUND_TRBE_XXX -----> TRBE_ERRATA_XXX
>> 
>> I think WORKAROUND still makes it clear, and is inline with what we
>> follow in generic arm64 and I would prefer to keep that.
> 
> Sure.
> 
>> 
>>> 
>>>> }; /* @@ -531,10 +540,13 @@ static enum trbe_fault_action
>>>> trbe_get_fault_act(u64 trbsr) if ((ec == TRBE_EC_STAGE1_ABORT)
>>>> || (ec == TRBE_EC_STAGE2_ABORT)) return TRBE_FAULT_ACT_FATAL; -
>>>> if (is_trbe_wrap(trbsr) && (ec == TRBE_EC_OTHERS) && (bsc ==
>>>> TRBE_BSC_FILLED)) { -        if (get_trbe_write_pointer() ==
>>>> get_trbe_base_pointer()) -            return
>>>> TRBE_FAULT_ACT_WRAP; -    } +    /* +     * It is not necessary
>>>> to verify the TRBPTR == TRBBASER to detect +     * a FILL
>>>> event. Moreover, CPU errata could make this check invalid. +
>>>> */
>>> 
>>> Why should the check be dropped for CPU instances which dont have
>>> the errata ?
>> 
>> Good point.  On the other hand, if the TRBPTR != TRBBASER, that
>> indicates a TRBE erratum. So, I don't see too much value in it. I
>> could keep that back in bypassed by the erratum check.
> 
> If (TRBPTR != TRBBASER) is a definitive indicator for the erratum's
> presence this could also be used for capturing [base .. base + 256]
> in the perf ring buffer as mentioned before.
> 
>> 
>>> 
>>>> +    if (is_trbe_wrap(trbsr) && (ec == TRBE_EC_OTHERS) && (bsc
>>>> == TRBE_BSC_FILLED)) +        return TRBE_FAULT_ACT_WRAP; + 
>>>> return TRBE_FAULT_ACT_SPURIOUS; } @@ -544,6 +556,7 @@ static
>>>> unsigned long trbe_get_trace_size(struct perf_output_handle
>>>> *handle, { u64 write; u64 start_off, end_off; +    u64 size; 
>>>> /* * If the TRBE has wrapped around the write pointer has @@
>>>> -559,7 +572,18 @@ static unsigned long
>>>> trbe_get_trace_size(struct perf_output_handle *handle, if
>>>> (WARN_ON_ONCE(end_off < start_off)) return 0; -    return
>>>> (end_off - start_off); + +    size = end_off - start_off; +
>>>> /* +     * If the TRBE is affected by the following erratum, we
>>>> must fill +     * the space we skipped with IGNORE packets. And
>>>> we are always +     * guaranteed to have at least a PAGE_SIZE
>>>> space in the buffer. +     */ +    if
>>>> (trbe_has_erratum(TRBE_WORKAROUND_OVERWRITE_FILL_MODE,
>>>> buf->cpudata) && +        !WARN_ON(size <
>>>> TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP))
>>> 
>>> Why warn here ? The skid can some times be less than 256 bytes.
>>> OR because now write pointer alignment is PAGE_SIZE (from later
>>> code), size too needs to be always a PAGE_SIZE multiple ?
>> 
>> Because, we expect at least a page size worth space before we run. 
>> (Since BASE, WRITE and LIMIT are page aligned). If that guarantee
>> is broken, we have serious problem with the size calculation
>> logic.
> 
> Okay.
> 
>> 
>>> 
>>>> +        __trbe_pad_buf(buf, start_off,
>>>> TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP); + +    return size; 
>>>> } static void *arm_trbe_alloc_buffer(struct coresight_device
>>>> *csdev, @@ -704,20 +728,73 @@ static unsigned long
>>>> arm_trbe_update_buffer(struct coresight_device *csdev, return
>>>> size; } + +static int
>>>> trbe_apply_work_around_before_enable(struct trbe_buf *buf) +{ +
>>>> /* +     * TRBE_WORKAROUND_OVERWRITE_FILL_MODE causes the TRBE
>>>> to overwrite a few cache +     * line size from the
>>>> "TRBBASER_EL1" in the event of a "FILL". +     * Thus, we could
>>>> loose some amount of the trace at the base. +     * +     * To
>>>> work around this: +     * - Software must leave 256bytes of
>>>> space from the base, so that +     *   the trace collected now
>>>> is not overwritten. +     * - Fill the first 256bytes with
>>>> IGNORE packets for the decoder +     *   to ignore at the end
>>>> of the session, so that the decoder ignores +     *   this
>>>> gap. +     * +     * This also means that, the TRBE driver must
>>>> set the TRBBASER_EL1 +     * such that, when the erratum is
>>>> triggered, it doesn't overwrite +     * the "area" outside the
>>>> area marked by (handle->head, +size). +     * So, we make sure
>>>> that the handle->head is always PAGE aligned, +     * by
>>>> tweaking the required alignment for the TRBE (trbe_align). +
>>>> * And when we enable the TRBE, +     * +     *   - move the
>>>> TRBPTR_EL1 to 256bytes past the starting point. +     *     So
>>>> that any trace collected in this run is not overwritten. +
>>>> * +     *   - set the TRBBASER_EL1 to the original trbe_write.
>>>> This will +     *     ensure that, if the TRBE hits the
>>>> erratum, it would only +     *     write within the region
>>>> allowed for the TRBE. +     * +     * At the trace collection
>>>> time, we always pad the skipped bytes +     * with IGNORE
>>>> packets to make sure the decoder doesn't see any +     *
>>>> overwritten packets. +     */ +    if
>>>> (trbe_has_erratum(TRBE_WORKAROUND_OVERWRITE_FILL_MODE,
>>>> buf->cpudata)) { +        if
>>>> (WARN_ON(!IS_ALIGNED(buf->trbe_write, PAGE_SIZE))) +
>>>> return -EINVAL; +        buf->trbe_hw_base = buf->trbe_write; +
>>>> buf->trbe_write += TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP;
>>> 
>>> Not sure if I really understood this correctly, but would not
>>> the above keep on reducing the usable buffer space for TRBE each
>>> time around ? BTW buffer adjustment complexity here requires a
>>> proper
>> 
>> Yes, unfortunately, we have to make sure every time the TRBE is 
>> turned ON, we leave this space. We always recaculate the offsets 
>> anyway, before turning it ON and this additional step makes sure
>> that the WRITE ptr is moved 256bytes (and also the BASE is moved to
>> the "head").
>> 
>> I don't think this adjustment changes much. It is only shifting
>> the write pointer within the region [head ... limit]. The
>> calculation of the head and the limit still remains the same.
> 
> Okay, got it.
> 
>> 
>>> ASCII diagram based illustration like before.
>>> 
>>>> +    } + +    return 0; +} + static int
>>>> __arm_trbe_enable(struct trbe_buf *buf, struct
>>>> perf_output_handle *handle) { +    int ret = 0; + 
>>>> buf->trbe_limit = compute_trbe_buffer_limit(handle); 
>>>> buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head,
>>>> buf); if (buf->trbe_limit == buf->trbe_base) { -
>>>> trbe_stop_and_truncate_event(handle); -        return -ENOSPC; 
>>>> +        ret = -ENOSPC; +        goto err; } /* Set the base of
>>>> the TRBE to the buffer base */ buf->trbe_hw_base =
>>>> buf->trbe_base; + +    ret =
>>>> trbe_apply_work_around_before_enable(buf); +    if (ret) +
>>>> goto err; + *this_cpu_ptr(buf->cpudata->drvdata->handle) =
>>>> handle; trbe_enable_hw(buf); return 0; +err: +
>>>> trbe_stop_and_truncate_event(handle); +    return ret; } static
>>>> int arm_trbe_enable(struct coresight_device *csdev, u32 mode,
>>>> void *data) @@ -1003,7 +1080,23 @@ static void
>>>> arm_trbe_probe_cpu(void *info) pr_err("Unsupported alignment on
>>>> cpu %d\n", cpu); goto cpu_clear; } -    cpudata->trbe_align =
>>>> cpudata->trbe_hw_align; + +    /* +     * If the TRBE is
>>>> affected by erratum TRBE_WORKAROUND_OVERWRITE_FILL_MODE,
>>> 
>>> Better to address it with the original errata name i.e 
>>> ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE instead. But not a big
>>> issue though.
>> 
>> We deal with the TRBE_xx name everywhere, for even checking the
>> erratum, so using the other one is going to confuse the code
>> reading.
> 
> Okay.
> 
>> 
>>> 
>>>> +     * we must always program the TBRPTR_EL1, 256bytes from a
>>>> page +     * boundary, with TRBBASER_EL1 set to the page, to
>>>> prevent +     * TRBE over-writing 256bytes at TRBBASER_EL1 on
>>>> FILL event. +     * +     * Thus make sure we always align our
>>>> write pointer to a PAGE_SIZE, +     * which also guarantees
>>>> that we have at least a PAGE_SIZE space in +     * the buffer
>>>> (TRBLIMITR is PAGE aligned) and thus we can skip +     * the
>>>> required bytes at the base. +     */
>>> 
>>> Should not TRBPTR_EL1 be aligned to 256 bytes instead, as
>>> TRBBASER_EL1 is always at PAGE_SIZE boundary. Hence TRBPTR_EL1
>>> could never be in between base and [base + 256 bytes]. Why
>>> alignment needs to go all the way upto PAGE_SIZE instead ? OR am
>>> I missing something here ?
>> 
>> Please see the diagram above. When the TRBE wraps, it jumps to the 
>> TRBBASER, and if that is outside the region permitted for TRBE, i.e
>> [head... head + size], we risk corrupting data potentially consumed
>> by the userspace. So, we must make sure that the TRBBASER is within
>> the [head...head+size], which is why we update the hw_base
>> accordingly when we detect the erratum.
> 
> Okay, got it.
> 
>> 
>>> 
>>>> +    if (trbe_has_erratum(TRBE_WORKAROUND_OVERWRITE_FILL_MODE,
>>>> cpudata)) +        cpudata->trbe_align = PAGE_SIZE; +    else +
>>>> cpudata->trbe_align = cpudata->trbe_hw_align; + 
>>>> cpudata->trbe_flag = get_trbe_flag_update(trbidr); cpudata->cpu
>>>> = cpu; cpudata->drvdata = drvdata;
>>>> 
>>> 
>>> I will visit this patch again. Not sure if I really understand
>>> all this changes correctly enough.
>> 
>> Please let me know if you have further questions.
> 
> Sure, will do.
> 
>> 
>> Thanks for taking a look
>> 
>> Suzuki
>>> 
>> 

