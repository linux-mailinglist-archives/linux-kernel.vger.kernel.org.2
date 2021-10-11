Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8693428AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 12:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbhJKKkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 06:40:49 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:46085 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235602AbhJKKkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 06:40:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UrPbEfO_1633948724;
Received: from 30.225.27.248(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0UrPbEfO_1633948724)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Oct 2021 18:38:44 +0800
Subject: Re: [PATCH] firmware: arm_sdei: pass sdei_api_event_register right
 parameters
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210910040117.98736-1-zhangliguang@linux.alibaba.com>
 <3fb354d1-bdc1-8aa2-aa90-4fd92e9a2e9a@arm.com>
From:   =?UTF-8?B?5Lmx55+z?= <zhangliguang@linux.alibaba.com>
Message-ID: <07f80973-9310-60d4-9828-4d3ae2112ad3@linux.alibaba.com>
Date:   Mon, 11 Oct 2021 18:37:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <3fb354d1-bdc1-8aa2-aa90-4fd92e9a2e9a@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

在 2021/10/9 1:39, James Morse 写道:
> Hello!
>
> (sorry for the delayed response)
>
> On 10/09/2021 05:01, Liguang Zhang wrote:
>> Function _local_event_enable is used for private sdei event
>> registeration called by sdei_event_register. We should pass
> (registration)
>
>> sdei_api_event_register right flag and mpidr parameters, otherwise atf
>> may trigger assert errors.
>> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
>> index a7e762c352f9..0736752dadde 100644
>> --- a/drivers/firmware/arm_sdei.c
>> +++ b/drivers/firmware/arm_sdei.c
>> @@ -558,14 +558,16 @@ static int sdei_api_event_register(u32 event_num, unsigned long entry_point,
>>   static void _local_event_register(void *data)
>>   {
>>   	int err;
>> +	u64 mpidr;
>>   	struct sdei_registered_event *reg;
>>   	struct sdei_crosscall_args *arg = data;
>>   
>>   	WARN_ON(preemptible());
>>   
>> +	mpidr = read_cpuid_mpidr();
>>   	reg = per_cpu_ptr(arg->event->private_registered, smp_processor_id());
>>   	err = sdei_api_event_register(arg->event->event_num, sdei_entry_point,
>> -				      reg, 0, 0);
>> +				      reg, SDEI_EVENT_REGISTER_RM_PE, mpidr);
> Hmmm, this looks like a bug in TFA.
>
> 5.1.2.2 "Parameters" of DEN 0054B has:
> | Routing mode is valid only for a shared event. For a private event, the routing mode is
> | ignored.
>
> Worse, the mpidr field has:
> | Currently the format is defined only when the selected routing mode is RM_PE.

or a private event, we route SDEI_EVENT_REGISTER_RM_PE and mpidr 
parameters may be more rationable.


>
>
> Over in trusted firmware land:
>
> https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/services/std_svc/sdei/sdei_main.c?h=v2.5#n361
>
> | static int64_t sdei_event_register(int ev_num,
> | 				uint64_t ep,
> | 				uint64_t arg,
> | 				uint64_t flags,
> |				uint64_t mpidr)
> | {
>
> |	/* Private events always target the PE */
> |	if (is_event_private(map))
> |		flags = SDEI_REGF_RM_PE;
>
> It looks like this re-uses the 'caller specified the routing' code, but didn't update the
> mpidr.
>
>
> You mention TFA takes an assert failure, I assume that brings the machine down.
> (Presumably you don't have a CPU with an affinity of zero.)

Yes, that brings the machine down. In opensource ATF, CPU with an 
affinity of zero.

The problem backaround:

we use local secure arch timer as sdei watchdog timer for hardlockup 
detection, in  os panic flow, we mask sdei event, then trigger the assert


if (se->reg_flags == SDEI_REGF_RM_PE)

     assert(se->affinity == my_mpidr);


Thanks,

Liguang

>
> Does this mean no-one relies on this, and we can fix the firmware?
> (I'll go report this to the relevant folk)
>
>
> Thanks!
>
> James
>
>
>>   
>>   	sdei_cross_call_return(arg, err);
>>   }
>>
