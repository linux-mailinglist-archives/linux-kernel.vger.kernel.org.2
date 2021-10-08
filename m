Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3601B426F86
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 19:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhJHR1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 13:27:22 -0400
Received: from foss.arm.com ([217.140.110.172]:37642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229606AbhJHR1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 13:27:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0151C1063;
        Fri,  8 Oct 2021 10:25:25 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.27.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80B7F3F766;
        Fri,  8 Oct 2021 10:25:20 -0700 (PDT)
Date:   Fri, 8 Oct 2021 18:25:13 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/5] arm64/entry-common: push the judgement of nmi ahead
Message-ID: <20211008172513.GD976@C02TD0UTHF1T.local>
References: <20210924132837.45994-1-kernelfans@gmail.com>
 <20210924132837.45994-2-kernelfans@gmail.com>
 <20210924175306.GB42068@C02TD0UTHF1T.local>
 <YU9Cy9kTew4ySeGZ@piliu.users.ipa.redhat.com>
 <20210930133257.GB18258@lakrids.cambridge.arm.com>
 <YV/ClUNWvMga3qud@piliu.users.ipa.redhat.com>
 <YWBbyPJPpt5zgj+b@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWBbyPJPpt5zgj+b@piliu.users.ipa.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 10:55:04PM +0800, Pingfan Liu wrote:
> On Fri, Oct 08, 2021 at 12:01:25PM +0800, Pingfan Liu wrote:
> > Sorry that I missed this message and I am just back from a long
> > festival.
> > 
> > Adding Paul for RCU guidance.
> > 
> > On Thu, Sep 30, 2021 at 02:32:57PM +0100, Mark Rutland wrote:
> > > On Sat, Sep 25, 2021 at 11:39:55PM +0800, Pingfan Liu wrote:
> > > > On Fri, Sep 24, 2021 at 06:53:06PM +0100, Mark Rutland wrote:
> > > > > On Fri, Sep 24, 2021 at 09:28:33PM +0800, Pingfan Liu wrote:
> > > > > > In enter_el1_irq_or_nmi(), it can be the case which NMI interrupts an
> > > > > > irq, which makes the condition !interrupts_enabled(regs) fail to detect
> > > > > > the NMI. This will cause a mistaken account for irq.
> > > > > 
> > > > Sorry about the confusing word "account", it should be "lockdep/rcu/.."
> > > > 
> > > > > Can you please explain this in more detail? It's not clear which
> > > > > specific case you mean when you say "NMI interrupts an irq", as that
> > > > > could mean a number of distinct scenarios.
> > > > > 
> > > > > AFAICT, if we're in an IRQ handler (with NMIs unmasked), and an NMI
> > > > > causes a new exception we'll do the right thing. So either I'm missing a
> > > > > subtlety or you're describing a different scenario..
> > > > > 
> > > > > Note that the entry code is only trying to distinguish between:
> > > > > 
> > > > > a) This exception is *definitely* an NMI (because regular interrupts
> > > > >    were masked).
> > > > > 
> > > > > b) This exception is *either* and IRQ or an NMI (and this *cannot* be
> > > > >    distinguished until we acknowledge the interrupt), so we treat it as
> > > > >    an IRQ for now.
> > > > > 
> > > > b) is the aim.
> > > > 
> > > > At the entry, enter_el1_irq_or_nmi() -> enter_from_kernel_mode()->rcu_irq_enter()/rcu_irq_enter_check_tick() etc.
> > > > While at irqchip level, gic_handle_irq()->gic_handle_nmi()->nmi_enter(),
> > > > which does not call rcu_irq_enter_check_tick(). So it is not proper to
> > > > "treat it as an IRQ for now"
> > > 
> > > I'm struggling to understand the problem here. What is "not proper", and
> > > why?
> > > 
> > > Do you think there's a correctness problem, or that we're doing more
> > > work than necessary? 
> > > 
> > I had thought it just did redundant accounting. But after revisiting RCU
> > code, I think it confronts a real bug.
> > 
> > > If you could give a specific example of a problem, it would really help.
> > > 
> > Refer to rcu_nmi_enter(), which can be called by
> > enter_from_kernel_mode():
> > 
> > ||noinstr void rcu_nmi_enter(void)
> > ||{
> > ||        ...
> > ||        if (rcu_dynticks_curr_cpu_in_eqs()) {
> > ||
> > ||                if (!in_nmi())
> > ||                        rcu_dynticks_task_exit();
> > ||
> > ||                // RCU is not watching here ...
> > ||                rcu_dynticks_eqs_exit();
> > ||                // ... but is watching here.
> > ||
> > ||                if (!in_nmi()) {
> > ||                        instrumentation_begin();
> > ||                        rcu_cleanup_after_idle();
> > ||                        instrumentation_end();
> > ||                }
> > ||
> > ||                instrumentation_begin();
> > ||                // instrumentation for the noinstr rcu_dynticks_curr_cpu_in_eqs()
> > ||                instrument_atomic_read(&rdp->dynticks, sizeof(rdp->dynticks));
> > ||                // instrumentation for the noinstr rcu_dynticks_eqs_exit()
> > ||                instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
> > ||
> > ||                incby = 1;
> > ||        } else if (!in_nmi()) {
> > ||                instrumentation_begin();
> > ||                rcu_irq_enter_check_tick();
> > ||        } else  {
> > ||                instrumentation_begin();
> > ||        }
> > ||        ...
> > ||}
> > 
> 
> Forget to supplement the context for understanding the case:
>   On arm64, at present, a pNMI (akin to NMI) may call rcu_nmi_enter()
>   without calling "__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);".
>   As a result it can be mistaken as an normal interrupt in
>   rcu_nmi_enter().

I appreciate that there's a window where we treat the pNMI like an IRQ,
but that's by design, and we account for this in gic_handle_irq() and
gic_handle_nmi() where we "upgrade" to NMI context with
nmi_enter()..nmi_exit().

The idea is that we have two cases: 

1) If we take a pNMI from a context where IRQs were masked, we know it
   must be a pNMI, and perform the NMI entry immediately to avoid
   reentrancy problems. 

   I think we're all happy with this case.

2) If we take a pNMI from a context where IRQs were unmasked, we don't know
   whether the trigger was a pNMI/IRQ until we read from the GIC, and
   since we *could* have taken an IRQ, this is equivalent to taking a
   spurious IRQ, and while handling that, taking the NMI, e.g.
   
   < run with IRQs unmasked >
     ~~~ take IRQ ~~~
     < enter IRQ >
       ~~~ take NMI exception ~~~
       < enter NMI >
       < handle NMI >
       < exit NMI > 
       ~~~ return from NMI exception ~~~
     < handle IRQ / spurious / do-nothing >
     < exit IRQ >
     ~~~ return from IRQ exception ~~~
   < continue running with IRQs unmasked >

   ... except that we don't do the HW NMI exception entry/exit, just all
   the necessary SW accounting.


Note that case (2) can *never* nest within itself or within case (1).

Do you have a specific example of something that goes wrong with the
above? e.g. something that's inconsistent with that rationale?

> And this may cause the following issue:
> > There is 3 pieces of code put under the
> > protection of if (!in_nmi()). At least the last one
> > "rcu_irq_enter_check_tick()" can trigger a hard lock up bug. Because it
> > is supposed to hold a spin lock with irqoff by
> > "raw_spin_lock_rcu_node(rdp->mynode)", but pNMI can breach it. The same
> > scenario in rcu_nmi_exit()->rcu_prepare_for_idle().
> > 
> > As for the first two "if (!in_nmi())", I have no idea of why, except
> > breaching spin_lock_irq() by NMI. Hope Paul can give some guide.

That code (in enter_from_kernel_mode()) only runs in case 2, where it
cannot be nested within a pNMI, so I struggle to see how this can
deadlock. It it can, then I would expect the general case of a pNMI
nesting within and IRQ would be broken?

Can you give a concrete example of a sequence that would lockup?
Currently I can't see how that's possible.

Thanks,
Mark.
