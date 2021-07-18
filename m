Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C427E3CC7F7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 08:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhGRGeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 02:34:03 -0400
Received: from foss.arm.com ([217.140.110.172]:34132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhGRGeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 02:34:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23C116D;
        Sat, 17 Jul 2021 23:31:05 -0700 (PDT)
Received: from [10.163.66.155] (unknown [10.163.66.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F8823F766;
        Sat, 17 Jul 2021 23:31:02 -0700 (PDT)
Subject: Re: [PATCH 5/5] coresight: trbe: Prohibit tracing while handling an
 IRQ
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        al.grant@arm.com, leo.yan@linaro.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, peterz@infradead.org, Tamas.Zsoldos@arm.com,
        will@kernel.org
References: <20210712113830.2803257-1-suzuki.poulose@arm.com>
 <20210712113830.2803257-6-suzuki.poulose@arm.com>
 <1837b3ae-cc0b-d4ba-7d26-1debdc60c016@arm.com>
 <5b5b20cd-0b2e-e911-5df7-da502d9230b6@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <1bbe77b1-6ca0-547c-64cd-89a4bcbd26e6@arm.com>
Date:   Sun, 18 Jul 2021 12:01:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5b5b20cd-0b2e-e911-5df7-da502d9230b6@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/21 2:22 PM, Suzuki K Poulose wrote:
> On 15/07/2021 04:09, Anshuman Khandual wrote:
>> A small nit. Paragraphs in the commit message do not seem to be aligned
>> properly to a maximum 75 characters width.
>>
>> On 7/12/21 5:08 PM, Suzuki K Poulose wrote:
>>> When the TRBE generates an IRQ, we stop the TRBE, collect the trace
>>> and then reprogram the TRBE with the updated buffer pointers in case
>>> of a spurious IRQ. We might also leave the TRBE disabled, on an
>>> overflow interrupt, without touching the ETE. This means the
>>> the ETE is only disabled when the event is disabled later (via irq_work).
>>> This is incorrect, as the ETE trace is still ON without actually being
>>> captured and may be routed to the ATB.
>>
>> I had an assumption that when the TRBE is stopped, ETE would also stop
>> implicitly given that the trace packets are not being accepted anymore.
>> But if that assumption does not always hold true, then yes trace must
>> be stopped upon a TRBE IRQ.
> 
> No, the ETE never stops, until it is stopped. The ETE doesn't care who
> is the consumer of the trace. Be it TRBE or ATB or any other sink.

Right. In that case, ETE must be stopped explicitly.

> 
>>
>>>
>>> So, we move the CPU into trace prohibited state (for all exception
>>> levels) upon entering the IRQ handler. The state is restored before
>>> enabling the TRBE back. Otherwise the trace remains prohibited.
>>> Since, the ETM/ETE driver controls the TRFCR_EL1 per session,
>>> (from commit "coresight: etm4x: Use Trace Filtering controls dynamically")
>>
>> commit SHA ID ?
>>
> 
> The patch is in this series, not committed yet.

Ahh missed, it might be better to address it like 'previous patch ("")
in the series' instead than 'commit ("")'.

> 
>>> the tracing can be restored/enabled back when the event is rescheduled
>>> in.
>>
>> Makes sense.
>>
>>>
>>> Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Cc: Mike Leach <mike.leach@linaro.org>
>>> Cc: Leo Yan <leo.yan@linaro.org>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-trbe.c | 43 ++++++++++++++++++--
>>>   1 file changed, 40 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>>> index c0c264264427..e4d88e0de2a8 100644
>>> --- a/drivers/hwtracing/coresight/coresight-trbe.c
>>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>>> @@ -83,6 +83,31 @@ struct trbe_drvdata {
>>>       struct platform_device *pdev;
>>>   };
>>>   +static inline void write_trfcr(u64 val)
>>> +{
>>> +    write_sysreg_s(val, SYS_TRFCR_EL1);
>>> +    isb();
>>> +}
>>> +
>>
>> There is another instance of write_trfcr() in coresight-etm4x-core.c and
>> some other writes into SYS_TRFCR_EL1 elsewhere. write_trfcr() should be
>> factored out and moved to a common place.
> 
> Agreed, but I couldn't find a right candidate for this. Welcome
> to suggestions. May be we could add something like:
> 
> asm/self-hosted.h

Why in asm ? Like other similar coresight headers, just creating 'self-hosted.h'
in the drivers/hwtracing/coresight/ path should do.

> 
>>
>>> +/*
>>> + * Prohibit the CPU tracing at all ELs, in preparation to collect
>>> + * the trace buffer.
>>> + *
>>> + * Returns the original value of the trfcr for restoring later.
>>> + */
>>> +static u64 cpu_prohibit_tracing(void)
>>> +{
>>> +    u64 trfcr = read_sysreg_s(SYS_TRFCR_EL1);
>>> +
>>> +    write_trfcr(trfcr & ~(TRFCR_ELx_ExTRE | TRFCR_ELx_E0TRE));
>>> +    return trfcr;
>>> +}
>>
>> This also should be factored out along with etm4x_prohibit_trace()
>> usage and moved to a common header instead.
>>
>>> +
>>> +static void cpu_restore_tracing(u64 trfcr)
>>> +{
>>> +    write_trfcr(trfcr);
>>> +}
>>> +
>>>   static int trbe_alloc_node(struct perf_event *event)
>>>   {
>>>       if (event->cpu == -1)
>>> @@ -681,7 +706,7 @@ static int arm_trbe_disable(struct coresight_device *csdev)
>>>       return 0;
>>>   }
>>>   -static void trbe_handle_spurious(struct perf_output_handle *handle)
>>> +static void trbe_handle_spurious(struct perf_output_handle *handle, u64 trfcr)
>>>   {
>>>       struct trbe_buf *buf = etm_perf_sink_config(handle);
>>>   @@ -691,6 +716,7 @@ static void trbe_handle_spurious(struct perf_output_handle *handle)
>>>           trbe_drain_and_disable_local();
>>>           return;
>>>       }
>>
>> A small comment here would be great because this will be the only
>> IRQ handler path, where it actually restores the tracing back.
> 
> Agreed
> 
>>
>>> +    cpu_restore_tracing(trfcr);
>>>       trbe_enable_hw(buf);
>>>   }
>>>   @@ -760,7 +786,18 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
>>>       struct perf_output_handle **handle_ptr = dev;
>>>       struct perf_output_handle *handle = *handle_ptr;
>>>       enum trbe_fault_action act;
>>> -    u64 status;
>>> +    u64 status, trfcr;
>>> +
>>> +    /*
>>> +     * Prohibit the tracing, while we process this. We turn
>>> +     * things back right, if we get to enabling the TRBE
>>> +     * back again. Otherwise, the tracing still remains
>>> +     * prohibited, until the perf event state changes
>>> +     * or another event is scheduled. This ensures that
>>> +     * the trace is not generated when it cannot be
>>> +     * captured.
>>> +     */
>>
>> Right.
>>
>> But a small nit though. Please keep the comments here formatted and
>> aligned with the existing ones.
>>
> 
> ok
> 
>>> +    trfcr = cpu_prohibit_tracing();
>>>         /*
>>>        * Ensure the trace is visible to the CPUs and
>>> @@ -791,7 +828,7 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
>>>           trbe_handle_overflow(handle);
>>>           break;
>>>       case TRBE_FAULT_ACT_SPURIOUS:
>>> -        trbe_handle_spurious(handle);
>>> +        trbe_handle_spurious(handle, trfcr);
>>>           break;
>>>       case TRBE_FAULT_ACT_FATAL:
>>>           trbe_stop_and_truncate_event(handle);
>>>
>>
>> But stopping the trace (even though from a sink IRQ handler) is a source
>> device action. Should not this be done via a new coresight_ops_source
>> callback instead ?
> 
> It is a valid point. But that has limitations.
> Here is the list:
> 
>   * Stopping the source is a heavy hammer, especially if we
>     are about to continue the trace soon. (e.g, spurious
>     interrupt and possibly soon for FILL events with reworking
>     the flags)
> 
>   * Stopping the source, via source_ops() is doing things
>     under the driving mode of the session, perf vs sysfs.
>     We only support perf though, but if there is another
>     user.
> 
>   * This is agnostic to the mode (as above), the TRBE driver
>     doesn't need to be taught, how to find the path and
>     stop the current session for the given mode.
> 
>   * If the tracing is enabled in kernel mode, the ETE still
>     generates the trace until we trigger the longer route
>     for disabling, which is not nice.
Okay, makes sense. But should not this be included in the commit message
as well - why a source_ops() is not being added for this operation, even
though it sounds intuitive.
