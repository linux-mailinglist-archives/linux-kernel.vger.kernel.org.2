Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F9334CE06
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 12:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhC2Ki2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 06:38:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15032 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhC2KiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 06:38:18 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F889j5xQyzNrLs;
        Mon, 29 Mar 2021 18:35:37 +0800 (CST)
Received: from [10.174.187.192] (10.174.187.192) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Mon, 29 Mar 2021 18:38:04 +0800
Subject: Re: [RFC PATCH 1/3] irqchip/gic-v3: Make use of ICC_SGI1R IRM bit
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <tglx@linutronix.de>,
        <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>,
        <zhukeqian1@huawei.com>
References: <20210329085210.11524-1-wangjingyi11@huawei.com>
 <20210329085210.11524-2-wangjingyi11@huawei.com>
 <87wntqqo6s.wl-maz@kernel.org>
From:   Jingyi Wang <wangjingyi11@huawei.com>
Message-ID: <7e44b7a1-4a12-86bf-4651-aa6a03c4f832@huawei.com>
Date:   Mon, 29 Mar 2021 18:38:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87wntqqo6s.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.192]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/29/2021 5:55 PM, Marc Zyngier wrote:
> On Mon, 29 Mar 2021 09:52:08 +0100,
> Jingyi Wang <wangjingyi11@huawei.com> wrote:
>>
>> IRM, bit[40] in ICC_SGI1R, determines how the generated SGIs
>> are distributed to PEs. If the bit is set, interrupts are routed
>> to all PEs in the system excluding "self". We use cpumask to
>> determine if this bit should be set and make use of that.
>>
>> This will reduce vm trap when broadcast IPIs are sent.
> 
> I remember writing similar code about 4 years ago, only to realise
> what:
> 
> - the cost of computing the resulting mask is pretty high for large
> machines
> - Linux almost never sends broadcast IPIs, so the complexity was all
> in vain
> 
> What changed? Please provide supporting data showing how many IPIs we
> actually save, and for which workload.
Maybe we can implement send_IPI_allbutself hooks as other some other 
archs instead of computing cpumask here?

>>
>> Signed-off-by: Jingyi Wang <wangjingyi11@huawei.com>
>> ---
>>   drivers/irqchip/irq-gic-v3.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index eb0ee356a629..8ecc1b274ea8 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -1127,6 +1127,7 @@ static void gic_send_sgi(u64 cluster_id, u16 tlist, unsigned int irq)
>>   static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
>>   {
>>   	int cpu;
>> +	cpumask_t tmp;
>>   
>>   	if (WARN_ON(d->hwirq >= 16))
>>   		return;
>> @@ -1137,6 +1138,17 @@ static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
>>   	 */
>>   	wmb();
>>   
>> +	if (!cpumask_and(&tmp, mask, cpumask_of(smp_processor_id()))) {
> 
> Are you sure this does the right thing? This is checking that the
> current CPU is not part of the mask. But it not checking that the mask
> is actually "all but self".
> 
> This means you are potentially sending IPIs to CPUs that are not part
> of the mask, making performance potentially worse.
> 
> Thanks,
> 
> 	M.
> 
I will fix that,thanks.

>> +		/* Set Interrupt Routing Mode bit */
>> +		u64 val;
>> +		val = (d->hwirq) << ICC_SGI1R_SGI_ID_SHIFT;
>> +		val |= BIT_ULL(ICC_SGI1R_IRQ_ROUTING_MODE_BIT);
>> +		gic_write_sgi1r(val);
>> +
>> +		isb();
>> +		return;
>> +	}
>> +
>>   	for_each_cpu(cpu, mask) {
>>   		u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));
>>   		u16 tlist;
>> -- 
>> 2.19.1
>>
>>
> 
