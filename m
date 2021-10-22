Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F24437C63
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbhJVSBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 14:01:23 -0400
Received: from foss.arm.com ([217.140.110.172]:57334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233975AbhJVSBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 14:01:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1B6B1063;
        Fri, 22 Oct 2021 10:59:02 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.73.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DC623F73D;
        Fri, 22 Oct 2021 10:58:57 -0700 (PDT)
Date:   Fri, 22 Oct 2021 18:58:54 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        maz@kernel.org, nickhu@andestech.com, palmer@dabbelt.com,
        paulmck@kernel.org, paul.walmsley@sifive.com, peterz@infradead.org,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        tsbogend@alpha.franken.de, vgupta@kernel.org, will@kernel.org
Subject: Re: [PATCH 09/15] irq: arm: perform irqentry in entry code
Message-ID: <20211022175854.GK86184@C02TD0UTHF1T.local>
References: <20211021180236.37428-1-mark.rutland@arm.com>
 <20211021180236.37428-10-mark.rutland@arm.com>
 <0efc4465-12b5-a568-0228-c744ec0509a3@arm.com>
 <20211022153602.GE86184@C02TD0UTHF1T.local>
 <1dc39ac9-1a05-cf8d-2aef-633903a6338d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dc39ac9-1a05-cf8d-2aef-633903a6338d@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 05:34:20PM +0100, Vladimir Murzin wrote:
> On 10/22/21 4:36 PM, Mark Rutland wrote:
> > On Fri, Oct 22, 2021 at 04:18:18PM +0100, Vladimir Murzin wrote:
> >> Hi Mark,
> >>
> >> On 10/21/21 7:02 PM, Mark Rutland wrote:
> >>> +/*
> >>> + * TODO: restructure the ARMv7M entry logic so that this entry logic can live
> >>> + * in arch code.
> >>> + */
> >>> +asmlinkage void __exception_irq_entry
> >>> +static void nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
> >>
> >> I'm seeing build time failure...
> >>
> >> drivers/irqchip/irq-nvic.c:50:8: error: two or more data types in declaration specifiers
> >>  static void nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
> >>         ^~~~
> >> drivers/irqchip/irq-nvic.c:50:13: warning: 'nvic_handle_irq' defined but not used [-Wunused-function]
> >>  static void nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
> >>
> >> I've fixed that locally and planing to give it a go...
> > 
> > Ah, whoops. I've removed the extraneous `static void` from
> > nvic_handle_irq() and build tested that as part of stm32_defconfig.
> > 
> > The updated version is in my irq/handle-domain-irq branch at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
> > 
> 
> $ cat /proc/interrupts
>            CPU0       
>  16:         24  nvic_irq   4 Edge      mps2-clkevt
>  17:          0  nvic_irq  32 Edge      mps2-uart-rx
>  18:          6  nvic_irq  33 Edge      mps2-uart-tx
>  19:          0  nvic_irq  47 Edge      mps2-uart-overrun
> Err:          0
> 
> So if it helps feel free to add my 
> 
> Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # ARMv7M

Thanks!

I've folded that in and uppdated the branch.

> As for TODO, is [1] look something you have been thinking of? IIUC,
> the show stopper is that hwirq is being passed from exception entry
> which retrieved via xPSR (IPSR to be precise). OTOH hwirq also available
> via Interrupt Controller Status Register (ICSR) thus can be used in
> driver itself... I gave [1] a go and it runs fine, yet I admit I might
> be missing something...

I hadn't thought about it in much detail, but that looks good!

I was wondering if we needed something like a
handle_arch_vectored_irq(), but if we can rely on the ICSR that seems
simpler overall. I'm not at all familiar with M-class, so I'm not sure
if there are pitfalls in this area.

Thanks,
Mark.

> 
> [1] 
> 
> ---
>  arch/arm/include/asm/v7m.h  |  3 ++-
>  arch/arm/kernel/entry-v7m.S | 10 +++-------
>  drivers/irqchip/Kconfig     |  1 +
>  drivers/irqchip/irq-nvic.c  | 21 +++++----------------
>  4 files changed, 11 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/include/asm/v7m.h b/arch/arm/include/asm/v7m.h
> index b1bad30b15d2..f047629887e7 100644
> --- a/arch/arm/include/asm/v7m.h
> +++ b/arch/arm/include/asm/v7m.h
> @@ -13,6 +13,7 @@
>  #define V7M_SCB_ICSR_PENDSVSET			(1 << 28)
>  #define V7M_SCB_ICSR_PENDSVCLR			(1 << 27)
>  #define V7M_SCB_ICSR_RETTOBASE			(1 << 11)
> +#define V7M_SCB_ICSR_VECTACTIVE			0x000001ff
>  
>  #define V7M_SCB_VTOR			0x08
>  
> @@ -38,7 +39,7 @@
>  #define V7M_SCB_SHCSR_MEMFAULTENA		(1 << 16)
>  
>  #define V7M_xPSR_FRAMEPTRALIGN			0x00000200
> -#define V7M_xPSR_EXCEPTIONNO			0x000001ff
> +#define V7M_xPSR_EXCEPTIONNO			V7M_SCB_ICSR_VECTACTIVE
>  
>  /*
>   * When branching to an address that has bits [31:28] == 0xf an exception return
> diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
> index 2e872a248e31..901c7cd1b1ce 100644
> --- a/arch/arm/kernel/entry-v7m.S
> +++ b/arch/arm/kernel/entry-v7m.S
> @@ -72,14 +72,10 @@ __irq_entry:
>  	@
>  	@ Invoke the IRQ handler
>  	@
> -	mrs	r0, ipsr
> -	ldr	r1, =V7M_xPSR_EXCEPTIONNO
> -	and	r0, r1
> -	sub	r0, #16
> -	mov	r1, sp
> +	mov	r0, sp
>  	stmdb	sp!, {lr}
> -	@ routine called with r0 = irq number, r1 = struct pt_regs *
> -	bl	nvic_handle_irq
> +	@ routine called with r0 = struct pt_regs *
> +	bl	generic_handle_arch_irq
>  
>  	pop	{lr}
>  	@
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index aca7b595c4c7..b59a0bc0cd80 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -58,6 +58,7 @@ config ARM_NVIC
>  	bool
>  	select IRQ_DOMAIN_HIERARCHY
>  	select GENERIC_IRQ_CHIP
> +	select GENERIC_IRQ_MULTI_HANDLER
>  
>  config ARM_VIC
>  	bool
> diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
> index 63bac3f78863..52ff0ed19f2f 100644
> --- a/drivers/irqchip/irq-nvic.c
> +++ b/drivers/irqchip/irq-nvic.c
> @@ -37,25 +37,13 @@
>  
>  static struct irq_domain *nvic_irq_domain;
>  
> -static void __nvic_handle_irq(irq_hw_number_t hwirq)
> +static void __irq_entry nvic_handle_irq(struct pt_regs *regs)
>  {
> -	generic_handle_domain_irq(nvic_irq_domain, hwirq);
> -}
> +	unsigned long icsr = readl_relaxed(BASEADDR_V7M_SCB + V7M_SCB_ICSR);
> +	irq_hw_number_t hwirq =  (icsr & V7M_SCB_ICSR_VECTACTIVE) - 16;
>  
> -/*
> - * TODO: restructure the ARMv7M entry logic so that this entry logic can live
> - * in arch code.
> - */
> -asmlinkage void __exception_irq_entry
> -nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
> -{
> -	struct pt_regs *old_regs;
>  
> -	irq_enter();
> -	old_regs = set_irq_regs(regs);
> -	__nvic_handle_irq(hwirq);
> -	set_irq_regs(old_regs);
> -	irq_exit();
> +	generic_handle_domain_irq(nvic_irq_domain, hwirq);
>  }
>  
>  static int nvic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> @@ -141,6 +129,7 @@ static int __init nvic_of_init(struct device_node *node,
>  	for (i = 0; i < irqs; i += 4)
>  		writel_relaxed(0, nvic_base + NVIC_IPR + i);
>  
> +	set_handle_irq(nvic_handle_irq);
>  	return 0;
>  }
>  IRQCHIP_DECLARE(armv7m_nvic, "arm,armv7m-nvic", nvic_of_init);
> 
> > Thanks,
> > Mark.
> > 
> 
