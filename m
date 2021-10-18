Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FC1431157
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 09:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhJRHXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 03:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhJRHXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 03:23:32 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17BC860FDC;
        Mon, 18 Oct 2021 07:21:22 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mcMxT-00HTN0-TN; Mon, 18 Oct 2021 08:21:20 +0100
MIME-Version: 1.0
Date:   Mon, 18 Oct 2021 08:21:19 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Samuel Holland <samuel@sholland.org>, guoren@kernel.org
Cc:     anup@brainfault.org, atish.patra@wdc.com, tglx@linutronix.de,
        palmer@dabbelt.com, heiko@sntech.de, robh@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V4 1/3] irqchip/sifive-plic: Add thead,c900-plic support
In-Reply-To: <8be1bdbd-365d-cd28-79d7-b924908f9e39@sholland.org>
References: <20211016032200.2869998-1-guoren@kernel.org>
 <20211016032200.2869998-2-guoren@kernel.org>
 <8be1bdbd-365d-cd28-79d7-b924908f9e39@sholland.org>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <f850af365f2ac77af79ec59f92e6434a@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: samuel@sholland.org, guoren@kernel.org, anup@brainfault.org, atish.patra@wdc.com, tglx@linutronix.de, palmer@dabbelt.com, heiko@sntech.de, robh@kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, guoren@linux.alibaba.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-18 06:17, Samuel Holland wrote:
> On 10/15/21 10:21 PM, guoren@kernel.org wrote:
>> From: Guo Ren <guoren@linux.alibaba.com>
>> 
>> 1) The irq_mask/unmask() is used by handle_fasteoi_irq() is mostly

Drop this useless numbering.

>> for ONESHOT irqs and there is no limitation in the RISC-V PLIC driver
>> due to use of irq_mask/unmask() callbacks. In fact, a lot of irqchip
>> drivers using handle_fasteoi_irq() also implement irq_mask/unmask().

This paragraph doesn't provide any useful information in the context
of this patch. That's at best cover-letter material.

>> 2) The C9xx PLIC does not comply with the interrupt claim/completion
>> process defined by the RISC-V PLIC specification because C9xx PLIC
>> will mask an IRQ when it is claimed by PLIC driver (i.e. readl(claim)
>> and the IRQ will be unmasked upon completion by PLIC driver (i.e.
>> writel(claim). This behaviour breaks the handling of IRQS_ONESHOT by
>> the generic handle_fasteoi_irq() used in the PLIC driver.
>> 
>> 3) This patch adds an errata fix for IRQS_ONESHOT handling on

s/fix/workaround/

>> C9xx PLIC by using irq_enable/disable() callbacks instead of
>> irq_mask/unmask().

 From Documentation/process/submitting-patches.rst:

<quote>
Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour.
</quote>

>> 
>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> Cc: Anup Patel <anup@brainfault.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Atish Patra <atish.patra@wdc.com>
>> 
>> ---
>> 
>> Changes since V4:
>>  - Update comment by Anup
>> 
>> Changes since V3:
>>  - Rename "c9xx" to "c900"
>>  - Add sifive_plic_chip and thead_plic_chip for difference
>> 
>> Changes since V2:
>>  - Add a separate compatible string "thead,c9xx-plic"
>>  - set irq_mask/unmask of "plic_chip" to NULL and point
>>    irq_enable/disable of "plic_chip" to plic_irq_mask/unmask
>>  - Add a detailed comment block in plic_init() about the
>>    differences in Claim/Completion process of RISC-V PLIC and C9xx
>>    PLIC.
>> ---
>>  drivers/irqchip/irq-sifive-plic.c | 34 
>> +++++++++++++++++++++++++++++--
>>  1 file changed, 32 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/irqchip/irq-sifive-plic.c 
>> b/drivers/irqchip/irq-sifive-plic.c
>> index cf74cfa82045..960b29d02070 100644
>> --- a/drivers/irqchip/irq-sifive-plic.c
>> +++ b/drivers/irqchip/irq-sifive-plic.c
>> @@ -166,7 +166,7 @@ static void plic_irq_eoi(struct irq_data *d)
>>  	writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
>>  }
>> 
>> -static struct irq_chip plic_chip = {
>> +static struct irq_chip sifive_plic_chip = {
>>  	.name		= "SiFive PLIC",
>>  	.irq_mask	= plic_irq_mask,
>>  	.irq_unmask	= plic_irq_unmask,
>> @@ -176,12 +176,32 @@ static struct irq_chip plic_chip = {
>>  #endif
>>  };
>> 
>> +/*
>> + * The C9xx PLIC does not comply with the interrupt claim/completion
>> + * process defined by the RISC-V PLIC specification because C9xx PLIC
>> + * will mask an IRQ when it is claimed by PLIC driver (i.e. 
>> readl(claim)
>> + * and the IRQ will be unmasked upon completion by PLIC driver (i.e.
>> + * writel(claim). This behaviour breaks the handling of IRQS_ONESHOT 
>> by
>> + * the generic handle_fasteoi_irq() used in the PLIC driver.
>> + */
>> +static struct irq_chip thead_plic_chip = {
>> +	.name		= "T-Head PLIC",
>> +	.irq_disable	= plic_irq_mask,
>> +	.irq_enable	= plic_irq_unmask,
>> +	.irq_eoi	= plic_irq_eoi,
>> +#ifdef CONFIG_SMP
>> +	.irq_set_affinity = plic_set_affinity,
>> +#endif
> I tested this, and it doesn't work. Without IRQCHIP_EOI_THREADED,
> .irq_eoi is called at the end of the hard IRQ handler. This unmasks the
> IRQ before the irqthread has a chance to run, so it causes an interrupt
> storm for any threaded level IRQ (I saw this happen for sun8i_thermal).
> 
> With IRQCHIP_EOI_THREADED, .irq_eoi is delayed until after the 
> irqthread
> runs. This is good. Except that the call to unmask_threaded_irq() is
> inside a check for IRQD_IRQ_MASKED. And IRQD_IRQ_MASKED will never be
> set because .irq_mask is NULL. So the end result is that the IRQ is
> never EOI'd and is masked permanently.
> 
> If you set .flags = IRQCHIP_EOI_THREADED, and additionally set 
> .irq_mask
> and .irq_unmask to a dummy function that does nothing, the IRQ core 
> will
> properly set/unset IRQD_IRQ_MASKED, and the IRQs will flow as expected.
> But adding dummy functions seems not so ideal, so I am not sure if this
> is the best solution.

This series is totally broken indeed, because it assumes that
enable/disable are a substitute to mask/unmask. Nothing could be further
from the truth. mask/unmask must be implemented, and enable/disable
supplement them if the HW requires something different at startup time.

If you have an 'automask' behaviour and yet the HW doesn't record this
in a separate bit, then you need to track this by yourself in the
irq_eoi() callback instead. I guess that you would skip the write to
the CLAIM register in this case, though I have no idea whether this 
breaks
the HW interrupt state or not.

There is an example of this in the Apple AIC driver.

         M.
-- 
Jazz is not dead. It just smells funny...
