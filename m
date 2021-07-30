Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8BE3DB8EF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 14:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbhG3M54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 08:57:56 -0400
Received: from foss.arm.com ([217.140.110.172]:41734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230328AbhG3M5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 08:57:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B110F6D;
        Fri, 30 Jul 2021 05:57:50 -0700 (PDT)
Received: from [10.57.86.111] (unknown [10.57.86.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B80E3F70D;
        Fri, 30 Jul 2021 05:57:49 -0700 (PDT)
Subject: Re: [PATCH v2 06/10] coresight: trbe: Fix handling of spurious
 interrupts
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        coresight@lists.linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tamas.zsoldos@arm.com, al.grant@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org,
        jinlmao@qti.qualcomm.com
References: <20210723124611.3828908-1-suzuki.poulose@arm.com>
 <20210723124611.3828908-7-suzuki.poulose@arm.com>
 <5a8f30f2-188c-427f-98e5-5c1ec5ad0626@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <5b7cd17f-77e0-0a8e-29f4-3eda082c5a67@arm.com>
Date:   Fri, 30 Jul 2021 13:57:47 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <5a8f30f2-188c-427f-98e5-5c1ec5ad0626@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2021 06:15, Anshuman Khandual wrote:
> 
> 
> On 7/23/21 6:16 PM, Suzuki K Poulose wrote:
>> On a spurious IRQ, right now we disable the TRBE and then re-enable
>> it back, resetting the "buffer" pointers(i.e BASE, LIMIT and more
>> importantly WRITE) to the original pointers from the AUX handle.
>> This implies that we overwrite any trace that was written so far,
>> (by overwriting TRBPTR) while we should have ignored the IRQ.
> 
> The ideas was that a state (pointers) reset would improve the chances
> of not getting the spurious IRQ once again. This is assuming that some
> thing during this current state machine, had caused the spurious IRQ.
> Hence just restart it back from the beginning. Yes, it does lose some
> trace data but whats the real possibility of such spurious IRQs in the
> first place ?
> 
>>
>> This patch cleans the behavior, by only stopping the TRBE if the
>> IRQ was indeed raised, as we can read the TRBSR without stopping
>> the TRBE (Only writes to the TRBSR requires the TRBE disabled).
>> And also, on detecting a spurious IRQ after examining the TRBSR,
>> we simply re-enable the TRBE without touching the other parameters.
> 
> This makes sense. I was not sure if TRBSR could be safely read without
> actually stopping the TRBE.
> 
>>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-trbe.c | 29 ++++++++++----------
>>   1 file changed, 15 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>> index 62e1a08f73ff..503bea0137ae 100644
>> --- a/drivers/hwtracing/coresight/coresight-trbe.c
>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>> @@ -679,15 +679,16 @@ static int arm_trbe_disable(struct coresight_device *csdev)
>>   
>>   static void trbe_handle_spurious(struct perf_output_handle *handle)
>>   {
>> -	struct trbe_buf *buf = etm_perf_sink_config(handle);
>> +	u64 limitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
>>   
>> -	buf->trbe_limit = compute_trbe_buffer_limit(handle);
>> -	buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
>> -	if (buf->trbe_limit == buf->trbe_base) {
>> -		trbe_drain_and_disable_local();
>> -		return;
>> -	}
>> -	trbe_enable_hw(buf);
>> +	/*
>> +	 * If the IRQ was spurious, simply re-enable the TRBE
>> +	 * back without modifiying the buffer parameters to
> 
> Typo here 		^^^^^^ s/modifiying/modifying
> 
>> +	 * retain the trace collected so far.
>> +	 */
>> +	limitr |= TRBLIMITR_ENABLE;
>> +	write_sysreg_s(limitr, SYS_TRBLIMITR_EL1);
>> +	isb();
>>   }
>>   
>>   static void trbe_handle_overflow(struct perf_output_handle *handle)
>> @@ -760,12 +761,7 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
>>   	enum trbe_fault_action act;
>>   	u64 status;
>>   
>> -	/*
>> -	 * Ensure the trace is visible to the CPUs and
>> -	 * any external aborts have been resolved.
>> -	 */
>> -	trbe_drain_and_disable_local();
>> -
>> +	/* Reads to TRBSR_EL1 is fine when TRBE is active */
>>   	status = read_sysreg_s(SYS_TRBSR_EL1);
>>   	/*
>>   	 * If the pending IRQ was handled by update_buffer callback
>> @@ -774,6 +770,11 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
>>   	if (!is_trbe_irq(status))
> 
> Warn here that a non-related IRQ has been delivered to this handler ?
> But moving the trbe_drain_and_disable_local() later, enables it to
> return back immediately after detecting an unrelated IRQ.

Not really. There could be race with the update_buffer(), see the 
comment right above that. When that happens, we have disabled the
TRBE in the update_buffer(). Either case, we have nothing to do.

> 
>>   		return IRQ_NONE;
>>   
>> +	/*
>> +	 * Ensure the trace is visible to the CPUs and
>> +	 * any external aborts have been resolved.
>> +	 */
>> +	trbe_drain_and_disable_local();
>>   	clr_trbe_irq();
>>   	isb();
>>   
>>
> 
> Actually there are two types of spurious interrupts here.
> 
> 1. Non-TRBE spurious interrupt
> 
> Fails is_trbe_irq() test and needs to be returned immediately from
> arm_trbe_irq_handler(), after an warning for the platform IRQ
> delivery wiring.

Not necessarily warrant a WARNING. See above.

> 
> 2. TRBE spurious interrupt
> 
> Clears is_trbe_irq() and get handled in trbe_handle_spurious(). I
> still think leaving this unchanged might be better as it reduces
> the chance of getting further spurious TRBE interrupts.

How does it reduce the chances of getting another spurious interrupt ?
If the TRBE gets a spurious IRQ, that we cannot decode, I would rather
leave it as NOP.

Suzuki

