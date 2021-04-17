Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153B6362CC3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 04:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbhDQCC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 22:02:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17351 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDQCC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 22:02:27 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FMbqZ4n1Jz7vcG;
        Sat, 17 Apr 2021 09:59:38 +0800 (CST)
Received: from [10.67.110.136] (10.67.110.136) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 17 Apr 2021 10:01:54 +0800
Subject: Re: [RFC PATCH] irqchip/gic-v3: Do not enable irqs when handling
 spurious interrups
To:     Marc Zyngier <maz@kernel.org>
CC:     <tglx@linutronix.de>, <julien.thierry.kdev@gmail.com>,
        <catalin.marinas@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20210416062217.25157-1-heying24@huawei.com>
 <87y2dis4d7.wl-maz@kernel.org>
From:   He Ying <heying24@huawei.com>
Message-ID: <cc4a6eee-8bdc-0fd1-66cb-365340f7405e@huawei.com>
Date:   Sat, 17 Apr 2021 10:01:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87y2dis4d7.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.136]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marc,


在 2021/4/16 22:15, Marc Zyngier 写道:
> [+ Mark]
>
> On Fri, 16 Apr 2021 07:22:17 +0100,
> He Ying <heying24@huawei.com> wrote:
>> We found this problem in our kernel src tree:
>>
>> [   14.816231] ------------[ cut here ]------------
>> [   14.816231] kernel BUG at irq.c:99!
>> [   14.816232] Internal error: Oops - BUG: 0 [#1] SMP
>> [   14.816232] Process swapper/0 (pid: 0, stack limit = 0x(____ptrval____))
>> [   14.816233] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O      4.19.95-1.h1.AOS2.0.aarch64 #14
>> [   14.816233] Hardware name: evb (DT)
>> [   14.816234] pstate: 80400085 (Nzcv daIf +PAN -UAO)
>> [   14.816234] pc : asm_nmi_enter+0x94/0x98
>> [   14.816235] lr : asm_nmi_enter+0x18/0x98
>> [   14.816235] sp : ffff000008003c50
>> [   14.816235] pmr_save: 00000070
>> [   14.816237] x29: ffff000008003c50 x28: ffff0000095f56c0
>> [   14.816238] x27: 0000000000000000 x26: ffff000008004000
>> [   14.816239] x25: 00000000015e0000 x24: ffff8008fb916000
>> [   14.816240] x23: 0000000020400005 x22: ffff0000080817cc
>> [   14.816241] x21: ffff000008003da0 x20: 0000000000000060
>> [   14.816242] x19: 00000000000003ff x18: ffffffffffffffff
>> [   14.816243] x17: 0000000000000008 x16: 003d090000000000
>> [   14.816244] x15: ffff0000095ea6c8 x14: ffff8008fff5ab40
>> [   14.816244] x13: ffff8008fff58b9d x12: 0000000000000000
>> [   14.816245] x11: ffff000008c8a200 x10: 000000008e31fca5
>> [   14.816246] x9 : ffff000008c8a208 x8 : 000000000000000f
>> [   14.816247] x7 : 0000000000000004 x6 : ffff8008fff58b9e
>> [   14.816248] x5 : 0000000000000000 x4 : 0000000080000000
>> [   14.816249] x3 : 0000000000000000 x2 : 0000000080000000
>> [   14.816250] x1 : 0000000000120000 x0 : ffff0000095f56c0
>> [   14.816251] Call trace:
>> [   14.816251]  asm_nmi_enter+0x94/0x98
>> [   14.816251]  el1_irq+0x8c/0x180
>> [   14.816252]  gic_handle_irq+0xbc/0x2e4
>> [   14.816252]  el1_irq+0xcc/0x180
>> [   14.816253]  arch_timer_handler_virt+0x38/0x58
>> [   14.816253]  handle_percpu_devid_irq+0x90/0x240
>> [   14.816253]  generic_handle_irq+0x34/0x50
>> [   14.816254]  __handle_domain_irq+0x68/0xc0
>> [   14.816254]  gic_handle_irq+0xf8/0x2e4
>> [   14.816255]  el1_irq+0xcc/0x180
>> [   14.816255]  arch_cpu_idle+0x34/0x1c8
>> [   14.816255]  default_idle_call+0x24/0x44
>> [   14.816256]  do_idle+0x1d0/0x2c8
>> [   14.816256]  cpu_startup_entry+0x28/0x30
>> [   14.816256]  rest_init+0xb8/0xc8
>> [   14.816257]  start_kernel+0x4c8/0x4f4
>> [   14.816257] Code: 940587f1 d5384100 b9401001 36a7fd01 (d4210000)
>> [   14.816258] Modules linked in: start_dp(O) smeth(O)
>> [   15.103092] ---[ end trace 701753956cb14aa8 ]---
>> [   15.103093] Kernel panic - not syncing: Fatal exception in interrupt
>> [   15.103099] SMP: stopping secondary CPUs
>> [   15.103100] Kernel Offset: disabled
>> [   15.103100] CPU features: 0x36,a2400218
>> [   15.103100] Memory Limit: none
> Urgh...
>
>> Our kernel src tree is based on 4.19.95 and backports arm64 pseudo-NMI
>> patches but doesn't support nested NMI. Its top relative commit is
>> commit 17ce302f3117 ("arm64: Fix interrupt tracing in the presence of NMIs").
> Can you please reproduce it with mainline and without any backport?
> It is hard to reason about something that isn't a vanilla kernel.

I think our kernel is quite like v5.3 mainline. Reproducing it in v5.3 
mainline may

be a little difficult for us because our product needs some more self 
developed

patches to work.

>
>> I look into this issue and find that it's caused by 'BUG_ON(in_nmi())'
>> in nmi_enter(). From the call trace, we find two 'el1_irqs' which
>> means an interrupt preempts the other one and the new one is an NMI.
>> Furthermore, by adding some prints, we find the first irq also calls
>> nmi_enter(), but its priority is not GICD_INT_NMI_PRI and its irq number
>> is 1023. It enables irq by calling gic_arch_enable_irqs() in
>> gic_handle_irq(). At this moment, the second irq preempts the first irq
>> and it's an NMI but current context is already in nmi. So that may be
>> the problem.
> I'm not sure I get it. From the stack trace, I see this:
>
> [   14.816251]  asm_nmi_enter+0x94/0x98
> [   14.816251]  el1_irq+0x8c/0x180			(C)
> [   14.816252]  gic_handle_irq+0xbc/0x2e4
> [   14.816252]  el1_irq+0xcc/0x180			(B)
> [   14.816253]  arch_timer_handler_virt+0x38/0x58
> [   14.816253]  handle_percpu_devid_irq+0x90/0x240
> [   14.816253]  generic_handle_irq+0x34/0x50
> [   14.816254]  __handle_domain_irq+0x68/0xc0
> [   14.816254]  gic_handle_irq+0xf8/0x2e4
> [   14.816255]  el1_irq+0xcc/0x180			(A)
>
> which indicates that we preempted a timer interrupt (A) with another
> IRQ (B), itself immediately preempted by another IRQ (C)? That's
> indeed at least one too many.
>
> Can you please describe for each of (A), (B) and (C) whether they are
> spurious or not, what their priorities are if they aren't spurious?

Yes. I ignored interrupt (A). (B) is spurious and its priority is 0xa0 
and PMR is 0x70.

(C) is an NMI and its priority is 0x20. Note that GIC_PRIO_IRQON is 0xe0,

GIC_PRIO_IRQOFF is 0x60, GICD_INT_DEF_PRI is 0xa0 and GICD_INT_NMI_PRI is

0x20 in our kernel.

>> In my opinion, when handling spurious interrupts, we shouldn't enable irqs.
>> My reason is that for spurious interrupts we may enter nmi context in
>> el1_irq() because current PMR may be GIC_PRIO_IRQOFF. If we enable irqs
>> at this time, another NMI may happen and preempt this spurious interrupt
>> but the context is already in nmi. That causes a bug on if nested NMI is
>> not supported. Even for nested nmi, I think it's not a normal scenario.
> I would tend to agree that this isn't great. Actually, I'd probably
> move the check for a spurious interrupt right after the read of
> ICC_IAR1_EL1, because there is no real need to do anything else at
> that point.

So, we don't need to check NMI for spurious interrupts? Do you mean that 
spurious

interrupts' can't be NMIs? Or even spurious interrups are NMIs, we 
shouldn't do

anything for them? If so, I will move the check after the read of 
ICC_IAR1_EL1 and

send a V2.

>
> However, upstream is quite different from 4.19 in that respect, and
> I'm not sure if what I am looking at is what you are seeing with your
> older kernel.

I know that. And I look into all patches about arm64 pseudo NMIs. As I 
said before,

our kernel is very quite like v5.3 mainline. I think we are talking 
about the same thing.


In my opinion, since commit 17ce302f3117 ("arm64: Fix interrupt tracing 
in the presence of NMIs"),

spurious interrups can enter nmi context in interrupt entry because PMR 
can be GIC_PRIO_IRQOFF

for spurious interrupts. That means test_irqs_unmasked is not 0 and 
asm_nmi_enter is called.

    (some el1_irq entry code from v5.3)

    test_irqs_unmasked  res=x0, pmr=x20

    cbz x0, 1f

    bl asm_nmi_enter


And it then calls gic_handle_irq(). It doesn't call gic_handle_nmi() 
because its priority is not GICD_INT_NMI_PRI.

Then it enables irqs. If at that point another NMI comes and preempts 
it, which means NMI occurs in nmi

context. That may cause a bug on if nested NMI is not supported.

    (some gic_handle_irq code from v5.3)

    irqnr = gic_read_iar();

    if (gic_supports_nmi() &&
        unlikely(gic_read_rpr() == GICD_INT_NMI_PRI)) {
            gic_handle_nmi(irqnr, 
regs);                                   (C)
            return;
    }

    if (gic_prio_masking_enabled()) {
          gic_pmr_mask_irqs();
gic_arch_enable_irqs(); (D)
    }

>
> Thanks,
>
> 	M.
>
>> Fixes: 17ce302f3117 ("arm64: Fix interrupt tracing in the presence of NMIs")
>> Signed-off-by: He Ying <heying24@huawei.com>
>> ---
>>   drivers/irqchip/irq-gic-v3.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index 94b89258d045..d3b52734a2c5 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -654,15 +654,15 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
>>   		return;
>>   	}
>>   
>> +	/* Check for special IDs first */
>> +	if ((irqnr >= 1020 && irqnr <= 1023))
>> +		return;
>> +
>>   	if (gic_prio_masking_enabled()) {
>>   		gic_pmr_mask_irqs();
>>   		gic_arch_enable_irqs();
>>   	}
>>   
>> -	/* Check for special IDs first */
>> -	if ((irqnr >= 1020 && irqnr <= 1023))
>> -		return;
>> -
>>   	if (static_branch_likely(&supports_deactivate_key))
>>   		gic_write_eoir(irqnr);
>>   	else
>> -- 
>> 2.17.1
>>
>>
