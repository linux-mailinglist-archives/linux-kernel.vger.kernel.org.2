Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61FC41CB25
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 19:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344909AbhI2RnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 13:43:15 -0400
Received: from foss.arm.com ([217.140.110.172]:58080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244589AbhI2RnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 13:43:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31AF9D6E;
        Wed, 29 Sep 2021 10:41:25 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.21.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C3823F793;
        Wed, 29 Sep 2021 10:41:22 -0700 (PDT)
Date:   Wed, 29 Sep 2021 18:41:16 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pingfan Liu <piliu@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, Pingfan Liu <kernelfans@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 4/5] irqchip/GICv3: let gic_handle_irq() utilize
 irqentry on arm64
Message-ID: <20210929173937.GA44397@C02TD0UTHF1T.local>
References: <20210924132837.45994-1-kernelfans@gmail.com>
 <20210924132837.45994-5-kernelfans@gmail.com>
 <20210928091053.GD1924@C02TD0UTHF1T.local>
 <YVPZEwfi8OFkzcd1@piliu.users.ipa.redhat.com>
 <87mtnvu9to.wl-maz@kernel.org>
 <YVQjX7GfuFKdW9hm@piliu.users.ipa.redhat.com>
 <20210929092358.GB33284@C02TD0UTHF1T.local>
 <YVR4Nf70XNiNNH/j@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVR4Nf70XNiNNH/j@piliu.users.ipa.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 10:29:09PM +0800, Pingfan Liu wrote:
> On Wed, Sep 29, 2021 at 10:23:58AM +0100, Mark Rutland wrote:
> > On Wed, Sep 29, 2021 at 04:27:11PM +0800, Pingfan Liu wrote:
> > > On Wed, Sep 29, 2021 at 08:20:35AM +0100, Marc Zyngier wrote:
> > > > On Wed, 29 Sep 2021 04:10:11 +0100,
> > > > Pingfan Liu <piliu@redhat.com> wrote:
> > > > > 
> > > > > On Tue, Sep 28, 2021 at 10:10:53AM +0100, Mark Rutland wrote:
> > > > > > On Fri, Sep 24, 2021 at 09:28:36PM +0800, Pingfan Liu wrote:
> > > > > > > The call to rcu_irq_enter() originated from gic_handle_irq() is
> > > > > > > redundant now, since arm64 has enter_from_kernel_mode() akin to
> > > > > > > irqenter_entry(), which has already called rcu_irq_enter().
> > > > > > 
> > > > > > Here I think you're referring to the call in handle_domain_irq(), but
> > > > > > that isn't clear from the commit message.
> > > > > > 
> > > > > Yes, and I will make it clear in V2.
> > > > > 
> > > > > > > Based on code analysis, the redundant can raise some mistake, e.g.
> > > > > > > rcu_data->dynticks_nmi_nesting inc 2, which causes
> > > > > > > rcu_is_cpu_rrupt_from_idle() unexpected.
> > > > > > > 
> > > > > > > So eliminate the call to irq_enter() in handle_domain_irq(). And
> > > > > > > accordingly supplementing irq_enter_rcu().
> > > > > > 
> > > > > > We support many more irqchips on arm64, and GICv3 can be used on regular
> > > > > > 32-bit arm, so this isn't right. Moving the irq_enter_rcu() call
> > > > > > into the GICv3 driver specifically breaks other drivers on arm64 by
> > > > > > removing the call, and breaks the GICv3 driver on arm by adding a
> > > > > > duplicate call.
> > > > > > 
> > > > > Oops. I forgot to protect the code in GICv3 with CONFIG_HAVE_ARCH_IRQENTRY
> > > > > 
> > > > > > It looks like this should live in do_interrupt_handler() in
> > > > > > arch/arm64/kernel/entry-common.c, e.g.
> > > > > > 
> > > > > > | static void do_interrupt_handler(struct pt_regs *regs,
> > > > > > | 				 void (*handler)(struct pt_regs *)) 
> > > > > > | {
> > > > > > | 	irq_enter_rcu();
> > > > > > | 	if (on_thread_stack())
> > > > > > | 		call_on_irq_stack(regs, handler);
> > > > > > | 	else
> > > > > > | 		handler(regs);
> > > > > > | 	irq_exit_rcu();
> > > > > > | }
> > > > > > 
> > > > > > ... unless there's some problem with that?
> > > > > > 
> > > > > Yeah, do_interrupt_handler() is a more suitable place. But to resolve
> > > > > the performance regression of rescheduling IPI [1], it is badly demanded to
> > > > > distinguish irqnr before calling irq_enter_rcu() (please see 5/5 and [2]
> > > > > for the context). So it is a compromise to host the code in GICv3.
> > > > > 
> > > > > Any good idea?
> > > > 
> > > > There is no way we are going to single out a particular interrupt
> > > > controller. As for the "regression", we'll have to look at the numbers
> > > > once we have fixed the whole infrastructure.
> > > > 
> > > But I just realize that at present, gic_handle_nmi() sits behind
> > > gic_handle_irq().  So it will make an mistaken for accounting of normal
> > > interrupt if calling irq_enter_rcu() in do_interrupt_handler().
> > 
> > We can restructure entry-common.c to avoid that if necessary.
> > 
> > TBH, the more I see problems in this area the more I want to rip out the
> > pNMI bits...
> > 
> 
> Overlook the undetermined pNMI, what about the partial patch like the following:
> 
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 32f9796c4ffe..3c46f8fd0e2e 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -219,17 +219,20 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
>  		lockdep_hardirqs_on(CALLER_ADDR0);
>  }
>  
> -static void noinstr enter_el1_irq_or_nmi(struct pt_regs *regs)
> +static bool noinstr enter_el1_irq_or_nmi(struct pt_regs *regs)
>  {
> -	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
> +	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs)) {
>  		arm64_enter_nmi(regs);
> -	else
> +		return false;
> +	} else {
>  		enter_from_kernel_mode(regs);
> +		return true;
> +	}
>  }
>  
> -static void noinstr exit_el1_irq_or_nmi(struct pt_regs *regs)
> +static void noinstr exit_el1_irq_or_nmi(struct pt_regs *regs, bool is_irq)
>  {
> -	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
> +	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !is_irq)
>  		arm64_exit_nmi(regs);
>  	else
>  		exit_to_kernel_mode(regs);
> @@ -261,12 +264,19 @@ static void __sched arm64_preempt_schedule_irq(void)
>  }
>  
>  static void do_interrupt_handler(struct pt_regs *regs,
> -				 void (*handler)(struct pt_regs *))
> +				 void (*handler)(struct pt_regs *),
> +				 bool is_irq)
>  {
> +	if (likely(is_irq))
> +		irq_enter_rcu();
> +
>  	if (on_thread_stack())
>  		call_on_irq_stack(regs, handler);
>  	else
>  		handler(regs);
> +
> +	if (likely(is_irq))
> +		irq_exit_rcu();
>  }

I'm not keen on having a bunch of conditional calls like this, since
it's easy to get wrong and static analyzers are liable to complain if
they don't accurately track the stat of the condition variable across
multiple blocks, and tbh I wasn't too keen on the *_irq_or_nmi() helpers
after I wrote them.

I reckon structurally the below would be better; we can add the
irq_{enter,exit}_rcu() calls in __el1_interrupt() and el0_interrupt(),
around the calls to do_interrupt_handler(), and it makes it clearer by
that we won't preempt if IRQs were masked in the interrupted context
(which the preempt_count manipulation in __nmi_{enter,exit} ensures
today).

Thanks,
Mark.

---->8----
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 32f9796c4ffe..7af7ddbea4b6 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -219,22 +219,6 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
                lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
-static void noinstr enter_el1_irq_or_nmi(struct pt_regs *regs)
-{
-       if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
-               arm64_enter_nmi(regs);
-       else
-               enter_from_kernel_mode(regs);
-}
-
-static void noinstr exit_el1_irq_or_nmi(struct pt_regs *regs)
-{
-       if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
-               arm64_exit_nmi(regs);
-       else
-               exit_to_kernel_mode(regs);
-}
-
 static void __sched arm64_preempt_schedule_irq(void)
 {
        lockdep_assert_irqs_disabled();
@@ -432,12 +416,18 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
        }
 }
 
-static void noinstr el1_interrupt(struct pt_regs *regs,
-                                 void (*handler)(struct pt_regs *))
+static __always_inline void
+__el1_pnmi(struct pt_regs *regs, void (*handler)(struct pt_regs *))
 {
-       write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
+       arm64_enter_nmi(regs);
+       do_interrupt_handler(regs, handler);
+       arm64_exit_nmi(regs);
+}
 
-       enter_el1_irq_or_nmi(regs);
+static __always_inline void
+__el1_interrupt(struct pt_regs *regs, void (*handler)(struct pt_regs *))
+{
+       enter_from_kernel_mode(regs);
        do_interrupt_handler(regs, handler);
 
        /*
@@ -449,7 +439,18 @@ static void noinstr el1_interrupt(struct pt_regs *regs,
            READ_ONCE(current_thread_info()->preempt_count) == 0)
                arm64_preempt_schedule_irq();
 
-       exit_el1_irq_or_nmi(regs);
+       exit_to_kernel_mode(regs);
+}
+
+static void noinstr el1_interrupt(struct pt_regs *regs,
+                                 void (*handler)(struct pt_regs *))
+{
+       write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
+
+       if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
+               __el1_pnmi(regs, handler);
+       else
+               __el1_interrupt(regs, handler);
 }
 
 asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs) 
