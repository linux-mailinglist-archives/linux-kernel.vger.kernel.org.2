Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5673934CE6D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 13:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhC2LDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 07:03:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15382 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbhC2LDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 07:03:16 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F88lc5xc7zlW22;
        Mon, 29 Mar 2021 19:01:32 +0800 (CST)
Received: from [10.174.187.192] (10.174.187.192) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Mon, 29 Mar 2021 19:03:03 +0800
Subject: Re: [RFC PATCH 3/3] arm/arm64: Use gic_ipi_send_single() to inject
 single IPI
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <tglx@linutronix.de>,
        <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>,
        <zhukeqian1@huawei.com>
References: <20210329085210.11524-1-wangjingyi11@huawei.com>
 <20210329085210.11524-4-wangjingyi11@huawei.com>
 <87v99aqnmg.wl-maz@kernel.org>
From:   Jingyi Wang <wangjingyi11@huawei.com>
Message-ID: <1476b457-f23c-1913-05c5-3a9b13319f6b@huawei.com>
Date:   Mon, 29 Mar 2021 19:03:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87v99aqnmg.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.192]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/29/2021 6:07 PM, Marc Zyngier wrote:
> On Mon, 29 Mar 2021 09:52:10 +0100,
> Jingyi Wang <wangjingyi11@huawei.com> wrote:
>>
>> Currently, arm use gic_ipi_send_mask() to inject single IPI, which
>> make the procedure a little complex. We use gic_ipi_send_single()
>> instead as some other archs.
>>
>> Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
>> ---
>>   arch/arm/kernel/smp.c   | 16 +++++++++++++---
>>   arch/arm64/kernel/smp.c | 16 +++++++++++++---
>>   2 files changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
>> index 74679240a9d8..369ce529cdd8 100644
>> --- a/arch/arm/kernel/smp.c
>> +++ b/arch/arm/kernel/smp.c
>> @@ -534,6 +534,8 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
>>   };
>>   
>>   static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
>> +static void smp_cross_call_single(const struct cpumask *target, int cpu,
>> +				  unsigned int ipinr);
> 
> Why does this function need to take both a cpumask *and* a cpu, given
> that they represent the same thing?
> I was intended to use the extra param to reuse trace_ipi_raise_rcuidle.

>>
>>   void show_ipi_list(struct seq_file *p, int prec)
>>   {
>> @@ -564,14 +566,15 @@ void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
>>   
>>   void arch_send_call_function_single_ipi(int cpu)
>>   {
>> -	smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC);
>> +	smp_cross_call_single(cpumask_of(cpu), cpu, IPI_CALL_FUNC);
>>   }
>>   
>>   #ifdef CONFIG_IRQ_WORK
>>   void arch_irq_work_raise(void)
>>   {
>> +	int cpu = smp_processor_id();
>>   	if (arch_irq_work_has_interrupt())
>> -		smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
>> +		smp_cross_call(cpumask_of(cpu), cpu, IPI_IRQ_WORK);
> 
> Why isn't that a call to smp_cross_call_single()?
> 
I ignored that, thanks.

>>   }
>>   #endif
>>   
>> @@ -707,6 +710,13 @@ static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
>>   	__ipi_send_mask(ipi_desc[ipinr], target);
>>   }
>>   
>> +static void smp_cross_call_single(const struct cpumask *target, int cpu,
>> +				  unsigned int ipinr)
>> +{
>> +	trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
> 
> Why don't you compute the cpumask here^^?
> 
>> +	__ipi_send_single(ipi_desc[ipinr], cpu);
>> +}
>> +
>>   static void ipi_setup(int cpu)
>>   {
>>   	int i;
>> @@ -744,7 +754,7 @@ void __init set_smp_ipi_range(int ipi_base, int n)
>>   
>>   void smp_send_reschedule(int cpu)
>>   {
>> -	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
>> +	smp_cross_call_single(cpumask_of(cpu), cpu, IPI_RESCHEDULE);
>>   }
>>   
>>   void smp_send_stop(void)
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index 357590beaabb..d290b6dc5a6e 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
> 
> Similar comments for the arm64 side.
> 
> Overall, this needs to be backed by data that indicates that there is
> an actual benefit for this extra complexity.
> 
> Thanks,
> 
> 	M.
> 

Firstly, I implemented exitless-IPIs to reduce VM trap caused by sending
IPI as what x86 does here:
https://patchwork.kernel.org/project/kvm/cover/1532327996-17619-1-git-send-email-wanpengli@tencent.com/
Then I realized that sending ipi mask usually cause sending IPIs all
but self as IRM bit defines.
So do you think we can use IRM if we can avoid extra cost like computing
mask, or using broadcast IPIs is just meaningless for now?

Thanks,
Jingyi
