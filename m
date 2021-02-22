Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A17322042
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhBVTgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbhBVTfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:35:53 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE697C06178A;
        Mon, 22 Feb 2021 11:35:11 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8B43C419B4;
        Mon, 22 Feb 2021 19:35:05 +0000 (UTC)
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-16-marcan@marcan.st> <87sg5xp5ic.wl-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 15/25] irqchip/apple-aic: Add support for the Apple
 Interrupt Controller
Message-ID: <2862340c-e26c-2243-500f-d5060e74f088@marcan.st>
Date:   Tue, 23 Feb 2021 04:35:03 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87sg5xp5ic.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2021 03.09, Marc Zyngier wrote:
> On Mon, 15 Feb 2021 12:17:03 +0000,
> Hector Martin <marcan@marcan.st> wrote:
>> This patch introduces basic UP irqchip support, without SMP/IPI support.
> 
> This last comment seems outdated now.

Heh, I forgot to reword this one. Thanks :)

>> +config APPLE_AIC
>> +	bool "Apple Interrupt Controller (AIC)"
>> +	depends on ARM64
>> +	default ARCH_APPLE
>> +	select IRQ_DOMAIN
>> +	select IRQ_DOMAIN_HIERARCHY
> 
> arm64 selects GENERIC_IRQ_IPI, which selects IRQ_DOMAIN_HIERARCHY,
> which selects IRQ_DOMAIN. So these two lines are superfluous.

Ack, removing these for v3.

>> + * In addition, this driver also handles FIQs, as these are routed to the same IRQ vector. These
>> + * are used for Fast IPIs (TODO), the ARMv8 timer IRQs, and performance counters (TODO).
>> + *
> 
> nit: A bit of comment formatting could be helpful.

Wrapped this to 80 columns for v3.

>> +#include <linux/bits.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/cpuhotplug.h>
>> +#include <linux/io.h>
>> +#include <linux/irqchip.h>
>> +#include <linux/irqchip/arm-gic-v3.h>
> 
> I'd rather you move the ICH_HCR_* definitions to sysreg.h rather than
> including the GICv3 stuff. They are only there for historical reasons
> (such as supporting KVM on 32bit systems), none of which apply anymore.

Just ICH_HCR, or should I bring all of the ICH_ and ICC_ defines along 
with it?

>> +	aic_ic_write(ic, AIC_TARGET_CPU + hwirq * 4, BIT(cpu));
>> +	irq_data_update_effective_affinity(d, cpumask_of(cpu));
> 
> It is fine to pick a single CPU out of the whole affinity set, but you
> should tell the kernel that this is the case (irqd_set_single_target()).

>> +
>> +	irq_set_status_flags(irq, IRQ_LEVEL);
> 
> I'm definitely not keen on this override, and the trigger information
> should be the one coming from the DT, which is already set for you.
> It'd probably be useful to provide an irq_set_type() callback that
> returns an error when fed an unsupported trigger.
> 

>> +	irq_set_noprobe(irq);
> 
> This seems to be cargo-culted, and I don't believe this is necessary.

>> +static const struct irq_domain_ops aic_irq_domain_ops = {
>> +	.map = aic_irq_domain_map,
>> +	.unmap = aic_irq_domain_unmap,
>> +	.xlate = aic_irq_domain_xlate,
>> +};
> 
> You are mixing two APIs: the older OF-specific one, and the newer one
> that uses fwnode_handle for hierarchical support. That's OK for older
> drivers that were forcefully converted to using generic IPIs, but as
> this is a brand new driver, I'd rather it consistently used the new
> API. See a proposed rework at [1] (compile tested only).

Applying your fixups for these, thanks! :)

>> +	atomic_and(~irq_bit, &aic_vipi_mask[this_cpu]);
> 
> atomic_andnot()?
> 
>> +
>> +	if (!atomic_read(&aic_vipi_mask[this_cpu]))
>> +		aic_ic_write(ic, AIC_IPI_MASK_SET, AIC_IPI_OTHER);
> 
> This is odd. It means that you still perform the MMIO write if the bit
> was already clear. I think this could be written as:
> 
> 	u32 val;
> 	val = atomic_fetch_andnot(irq_bit, &aic_vipi_mask[this_cpu]);
> 	if (val && !(val & ~irq_bit))
> 		aic_ic_write();

> 
> 	val  = atomic_fetch_or(irq_bit, &aic_vipi_mask[this_cpu]);
> 	if (!val)
> 		aic_ic_write();

This makes more sense to avoid the redundant MMIO writes. I need to get 
more familiar with all the available atomic ops... lots of useful stuff 
in there I didn't know about.

>> +	for_each_cpu(cpu, mask) {
>> +		if (atomic_read(&aic_vipi_mask[cpu]) & irq_bit) {
>> +			atomic_or(irq_bit, &aic_vipi_flag[cpu]);
>> +			send |= AIC_IPI_SEND_CPU(cpu);
> 
> That's really odd. A masked IPI should be made pending, and delivered
> on unmask. I think this all works because we never mask individual
> IPIs, as this would otherwise drop interrupts on the floor.

I wasn't really sure whether IPIs are supposed to end up pending like 
that; indeed if that's how it's supposed to work, then I also need logic 
at mask/unmask time to fire off any pending IPIs. I'll do it like that 
for v3.

Now I wonder how other drivers do it... I'm guessing this never gets 
tested, since the IPI code only exercises a fraction of the irq features...

>> +static void aic_handle_ipi(struct pt_regs *regs)
>> +{
>> +	int this_cpu = smp_processor_id();
>> +	int i;
>> +	unsigned long firing;
>> +
>> +	aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_OTHER);
>> +
>> +	/*
>> +	 * Ensure that we've received and acked the IPI before we load the vIPI
>> +	 * flags. This pairs with the second wmb() above.
>> +	 */
>> +	mb();
> 
> I don't get your ordering here.
> 
> If you are trying to order against something that has happened on
> another CPU (which is pretty likely in the case of an IPI), why isn't
> this a smp_mb_before_atomic() (and conversely smp_mb_after_atomic() in
> aic_ipi_send_mask())?
> 
> Although this looks to me like a good case for _acquire/_release
> semantics.

This is trying to order the atomic ops with the IPI IRQ itself, in 
particular the ACK in the preceding line. If they execute in reverse 
order (or more precisely if the ACK takes effect after the xchg), this 
happens and we lose an IPI:

CPU1              CPU2
set vIPI #0
fire IPI
                   IPI IRQ
                   read EVENT
                   / xchg vIPI
set vIPI #1       X
fire IPI          |
                   \ ACK IPI

The converse race can also happen in the CPU1 path, of course, if the 
IPI ends up fired before the vIPI is set, hence the barrier there.

What I'm not sure is how the smp_ ops order with regard to 
writel_relaxed. It seems like mb() is dsb(sy) and smp_mb() is dmb(ish) 
and the atomic versions just default to aliasing smp_mb()). An 
inner-sharable dmb doesn't sound like it would safely satisfy this 
requirement, as MMIO out to AIC is involved (and we don't know if it's 
in the inner sharable domain or not for these purposes). Since the MMIO 
is nGnRnE, I would expect that a dsb(sy) would satisfy this requirement, 
as then the write op really shouldn't complete until it has taken effect 
in AIC.

>> +	/*
>> +	 * Make sure the kernel's idea of logical CPU order is the same as AIC's
>> +	 * If we ever end up with a mismatch here, we will have to introduce
>> +	 * a mapping table similar to what other irqchip drivers do.
>> +	 */
>> +	WARN_ON(aic_ic_read(aic_irqc, AIC_WHOAMI) != smp_processor_id());
> 
> This is unlikely to work as soon as you get kexec up and running. You
> may not have to worry about this for some time...

Ah, can kexec randomly shuffle CPUs around?

The solution here is obvious, but at this point I'm more keen on punting 
this to a future patch instead of introducing more complexity into the 
initial series; gotta leave behind some bugs to fix later :)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
