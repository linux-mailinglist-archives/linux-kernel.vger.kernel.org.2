Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25D541AAA2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbhI1IeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 04:34:14 -0400
Received: from foss.arm.com ([217.140.110.172]:41204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239549AbhI1IeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:34:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD6C86D;
        Tue, 28 Sep 2021 01:32:33 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.23.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51DD63F7B4;
        Tue, 28 Sep 2021 01:32:30 -0700 (PDT)
Date:   Tue, 28 Sep 2021 09:32:22 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCHv2 0/5] arm64/irqentry: remove duplicate housekeeping of
Message-ID: <20210928083222.GA1924@C02TD0UTHF1T.local>
References: <20210924132837.45994-1-kernelfans@gmail.com>
 <20210924173615.GA42068@C02TD0UTHF1T.local>
 <20210924225954.GN880162@paulmck-ThinkPad-P17-Gen-1>
 <20210927092303.GC1131@C02TD0UTHF1T.local>
 <20210928000922.GY880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928000922.GY880162@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 05:09:22PM -0700, Paul E. McKenney wrote:
> On Mon, Sep 27, 2021 at 10:23:18AM +0100, Mark Rutland wrote:
> > On Fri, Sep 24, 2021 at 03:59:54PM -0700, Paul E. McKenney wrote:
> > > On Fri, Sep 24, 2021 at 06:36:15PM +0100, Mark Rutland wrote:
> > > > [Adding Paul for RCU, s390 folk for entry code RCU semantics]
> > > > 
> > > > On Fri, Sep 24, 2021 at 09:28:32PM +0800, Pingfan Liu wrote:
> > > > > After introducing arm64/kernel/entry_common.c which is akin to
> > > > > kernel/entry/common.c , the housekeeping of rcu/trace are done twice as
> > > > > the following:
> > > > >     enter_from_kernel_mode()->rcu_irq_enter().
> > > > > And
> > > > >     gic_handle_irq()->...->handle_domain_irq()->irq_enter()->rcu_irq_enter()
> > > > >
> > > > > Besides redundance, based on code analysis, the redundance also raise
> > > > > some mistake, e.g.  rcu_data->dynticks_nmi_nesting inc 2, which causes
> > > > > rcu_is_cpu_rrupt_from_idle() unexpected.
> > > > 
> > > > Hmmm...
> > > > 
> > > > The fundamental questionss are:
> > > > 
> > > > 1) Who is supposed to be responsible for doing the rcu entry/exit?
> > > > 
> > > > 2) Is it supposed to matter if this happens multiple times?
> > > > 
> > > > For (1), I'd generally expect that this is supposed to happen in the
> > > > arch/common entry code, since that itself (or the irqchip driver) could
> > > > depend on RCU, and if that's the case thatn handle_domain_irq()
> > > > shouldn't need to call rcu_irq_enter(). That would be consistent with
> > > > the way we handle all other exceptions.
> > > > 
> > > > For (2) I don't know whether the level of nesting is suppoosed to
> > > > matter. I was under the impression it wasn't meant to matter in general,
> > > > so I'm a little surprised that rcu_is_cpu_rrupt_from_idle() depends on a
> > > > specific level of nesting.
> > > > 
> > > > >From a glance it looks like this would cause rcu_sched_clock_irq() to
> > > > skip setting TIF_NEED_RESCHED, and to not call invoke_rcu_core(), which
> > > > doesn't sound right, at least...
> > > > 
> > > > Thomas, Paul, thoughts?
> > > 
> > > It is absolutely required that rcu_irq_enter() and rcu_irq_exit() calls
> > > be balanced.  Normally, this is taken care of by the fact that irq_enter()
> > > invokes rcu_irq_enter() and irq_exit() invokes rcu_irq_exit().  Similarly,
> > > nmi_enter() invokes rcu_nmi_enter() and nmi_exit() invokes rcu_nmi_exit().
> > 
> > Sure; I didn't mean to suggest those weren't balanced! The problem here
> > is *nesting*. Due to the structure of our entry code and the core IRQ
> > code, when handling an IRQ we have a sequence:
> > 
> > 	irq_enter() // arch code
> > 	irq_enter() // irq code
> > 
> > 	< irq handler here >
> > 
> > 	irq_exit() // irq code
> > 	irq_exit() // arch code
> > 
> > ... and if we use something like rcu_is_cpu_rrupt_from_idle() in the
> > middle (e.g. as part of rcu_sched_clock_irq()), this will not give the
> > expected result because of the additional nesting, since
> > rcu_is_cpu_rrupt_from_idle() seems to expect that dynticks_nmi_nesting
> > is only incremented once per exception entry, when it does:
> > 
> > 	/* Are we at first interrupt nesting level? */
> > 	nesting = __this_cpu_read(rcu_data.dynticks_nmi_nesting);
> > 	if (nesting > 1)
> > 		return false;
> > 
> > What I'm trying to figure out is whether that expectation is legitimate,
> > and assuming so, where the entry/exit should happen.
> 
> Oooh...
> 
> The penalty for fooling rcu_is_cpu_rrupt_from_idle() is that RCU will
> be unable to detect a userspace quiescent state for a non-nohz_full
> CPU.  That could result in RCU CPU stall warnings if a user task runs
> continuously on a given CPU for more than 21 seconds (60 seconds in
> some distros).  And this can easily happen if the user has a CPU-bound
> thread that is the only runnable task on that CPU.
> 
> So, yes, this does need some sort of resolution.
> 
> The traditional approach is (as you surmise) to have only a single call
> to irq_enter() on exception entry and only a single call to irq_exit()
> on exception exit.  If this is feasible, it is highly recommended.

Cool; that's roughly what I was expecting / hoping to hear!

> In theory, we could have that "1" in "nesting > 1" be a constant supplied
> by the architecture (you would want "3" if I remember correctly) but
> in practice could we please avoid this?  For one thing, if there is
> some other path into the kernel for your architecture that does only a
> single irq_enter(), then rcu_is_cpu_rrupt_from_idle() just doesn't stand
> a chance.  It would need to compare against a different value depending
> on what exception showed up.  Even if that cannot happen, it would be
> better if your architecture could remain in blissful ignorance of the
> colorful details of ->dynticks_nmi_nesting manipulations.

I completely agree. I think it's much harder to keep that in check than
to enforce a "once per architectural exception" policy in the arch code.

> Another approach would be for the arch code to supply RCU a function that
> it calls.  If there is such a function (or perhaps better, if some new
> Kconfig option is enabled), RCU invokes it.  Otherwise, it compares to
> "1" as it does now.  But you break it, you buy it!  ;-)

I guess we could look at the exception regs and inspect the original
context, but it sounds overkill...

I think the cleanest thing is to leave this to arch code, and have the
common IRQ code stay well clear. Unfortunately most architectures
(including arch/arm) still need the common IRQ code to handle this, so
we'll have to make that conditional on Kconfig, something like the below
(build+boot tested only).

If there are no objections, I'll go check who else needs the same
treatment (IIUC at least s390 will), and spin that as a real
patch/series.

Thanks,
Mark.

---->8----
diff --git a/arch/Kconfig b/arch/Kconfig
index 8df1c7102643..c59475e50e4c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -225,6 +225,12 @@ config GENERIC_SMP_IDLE_THREAD
 config GENERIC_IDLE_POLL_SETUP
        bool
 
+config ARCH_ENTERS_IRQ
+       bool
+       help
+         An architecture should select this when it performs irq entry
+         management itself (e.g. calling irq_enter() and irq_exit()).
+
 config ARCH_HAS_FORTIFY_SOURCE
        bool
        help
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5c7ae4c3954b..fa6476bf2b4d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -16,6 +16,7 @@ config ARM64
        select ARCH_ENABLE_MEMORY_HOTREMOVE
        select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
        select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
+       select ARCH_ENTERS_IRQ
        select ARCH_HAS_CACHE_LINE_SIZE
        select ARCH_HAS_DEBUG_VIRTUAL
        select ARCH_HAS_DEBUG_VM_PGTABLE
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 4e3c29bb603c..6affa12222e0 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -677,6 +677,15 @@ int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq)
 EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
 
 #ifdef CONFIG_HANDLE_DOMAIN_IRQ
+
+#ifdef ARCH_ENTERS_IRQ
+#define handle_irq_enter()
+#define handle_irq_exit()
+#else
+#define handle_irq_enter()     irq_enter()
+#define handle_irq_exit()      irq_exit()
+#endif
+
 /**
  * handle_domain_irq - Invoke the handler for a HW irq belonging to a domain,
  *                     usually for a root interrupt controller
@@ -693,7 +702,7 @@ int handle_domain_irq(struct irq_domain *domain,
        struct irq_desc *desc;
        int ret = 0;
 
-       irq_enter();
+       handle_irq_enter();
 
        /* The irqdomain code provides boundary checks */
        desc = irq_resolve_mapping(domain, hwirq);
@@ -702,7 +711,7 @@ int handle_domain_irq(struct irq_domain *domain,
        else
                ret = -EINVAL;
 
-       irq_exit();
+       handle_irq_exit();
        set_irq_regs(old_regs);
        return ret;
 }

