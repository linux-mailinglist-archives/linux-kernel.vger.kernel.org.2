Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F77C3CC7EB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 08:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhGRGQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 02:16:02 -0400
Received: from foss.arm.com ([217.140.110.172]:33904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhGRGQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 02:16:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B9CC6D;
        Sat, 17 Jul 2021 23:13:03 -0700 (PDT)
Received: from [10.163.66.155] (unknown [10.163.66.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9BFB3F766;
        Sat, 17 Jul 2021 23:12:59 -0700 (PDT)
Subject: Re: [PATCH 4/5] coresight: trbe: Move irq_work queue processing
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        al.grant@arm.com, leo.yan@linaro.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, peterz@infradead.org, Tamas.Zsoldos@arm.com,
        will@kernel.org
References: <20210712113830.2803257-1-suzuki.poulose@arm.com>
 <20210712113830.2803257-5-suzuki.poulose@arm.com>
 <390617ae-c5bd-b73a-c48c-e62b7f5330ca@arm.com>
 <c6f23f94-3ee1-c9ff-819c-18092c8cd660@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <03f13390-79e3-9a44-2a9b-f86c246a153a@arm.com>
Date:   Sun, 18 Jul 2021 11:43:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c6f23f94-3ee1-c9ff-819c-18092c8cd660@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/21 2:03 PM, Suzuki K Poulose wrote:
> On 15/07/2021 04:23, Anshuman Khandual wrote:
>>
>>
>> On 7/12/21 5:08 PM, Suzuki K Poulose wrote:
>>> The TRBE driver issues the irq_work_run() to ensure that
>>> any pending disable event callback has been processed. But this
>>> is done before we mark the AUX buffer as TRUNCATED, making
>>> the call pointless. Move the call after the current handle
>>> has been closed.
>>
>> So there is a possibility that a disable event gets missed before
>> the buffer is marked TRUNCATED ? But even then would not another
> 
> No, it is the other way around. A disable event is triggered
> in response to the TRUNCATED flag.
> 
>> disable event be triggered again subsequently ? Just trying to
>> understand what is the actual problem because of the current
>> placement of irq_work_run() ?
> 
> That begs the question, What is the purpose of irq_work_run() ?
> See below.
> 
>>
>>>
>>> Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
>>> Reported-by: Tamas Zsoldos <Tamas.Zsoldos@arm.com>
>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Cc: Mike Leach <mike.leach@linaro.org>
>>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> Cc: Leo Yan <leo.yan@linaro.org>
>>> Cc: Will Deacon <will@kernel.org>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-trbe.c | 14 ++++++++------
>>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>>> index ec38cf17b693..c0c264264427 100644
>>> --- a/drivers/hwtracing/coresight/coresight-trbe.c
>>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>>> @@ -723,6 +723,14 @@ static void trbe_handle_overflow(struct perf_output_handle *handle)
>>>       perf_aux_output_flag(handle, PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW |
>>>                        PERF_AUX_FLAG_TRUNCATED);
>>>       perf_aux_output_end(handle, size);
>>> +
>>> +    /*
>>> +     * Ensure perf callbacks have completed. Since we
>>> +     * always TRUNCATE the buffer on IRQ, the event
>>> +     * is scheduled to be disabled. Make sure that happens
>>> +     * as soon as possible.
>>> +     */
>>> +    irq_work_run();
>>>   }
>>>     static bool is_perf_trbe(struct perf_output_handle *handle)
>>> @@ -777,12 +785,6 @@ static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
>>>       if (!is_perf_trbe(handle))
>>>           return IRQ_NONE;
>>>   -    /*
>>> -     * Ensure perf callbacks have completed, which may disable
>>> -     * the trace buffer in response to a TRUNCATION flag.
>>> -     */
> 
> This comment here explains what the irq_work_run() is supposed to do.
> This clearly indicates that the event will be disabled in response
> to TRUNCATION. Now, we haven't updated the buffer flags yet here.
> It happens *after* this call, in handle_overflow(). So, this is placed
> incorrectly. The purpose of this patch is to make sure that we actually
> complete the callbacks in response to the TRUNCATED flag we set with
> this IRQ.

Got it.

> 
>>> -    irq_work_run();
>>> -
>>>       act = trbe_get_fault_act(status);
>>>       switch (act) {
>>>       case TRBE_FAULT_ACT_WRAP:
>>>
> 
> Suzuki
> 
