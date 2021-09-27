Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD44419177
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 11:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbhI0JZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 05:25:13 -0400
Received: from foss.arm.com ([217.140.110.172]:35794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233668AbhI0JZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 05:25:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D6C1D6E;
        Mon, 27 Sep 2021 02:23:34 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C61363F70D;
        Mon, 27 Sep 2021 02:23:31 -0700 (PDT)
Date:   Mon, 27 Sep 2021 10:23:18 +0100
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
Message-ID: <20210927092303.GC1131@C02TD0UTHF1T.local>
References: <20210924132837.45994-1-kernelfans@gmail.com>
 <20210924173615.GA42068@C02TD0UTHF1T.local>
 <20210924225954.GN880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924225954.GN880162@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 03:59:54PM -0700, Paul E. McKenney wrote:
> On Fri, Sep 24, 2021 at 06:36:15PM +0100, Mark Rutland wrote:
> > [Adding Paul for RCU, s390 folk for entry code RCU semantics]
> > 
> > On Fri, Sep 24, 2021 at 09:28:32PM +0800, Pingfan Liu wrote:
> > > After introducing arm64/kernel/entry_common.c which is akin to
> > > kernel/entry/common.c , the housekeeping of rcu/trace are done twice as
> > > the following:
> > >     enter_from_kernel_mode()->rcu_irq_enter().
> > > And
> > >     gic_handle_irq()->...->handle_domain_irq()->irq_enter()->rcu_irq_enter()
> > >
> > > Besides redundance, based on code analysis, the redundance also raise
> > > some mistake, e.g.  rcu_data->dynticks_nmi_nesting inc 2, which causes
> > > rcu_is_cpu_rrupt_from_idle() unexpected.
> > 
> > Hmmm...
> > 
> > The fundamental questionss are:
> > 
> > 1) Who is supposed to be responsible for doing the rcu entry/exit?
> > 
> > 2) Is it supposed to matter if this happens multiple times?
> > 
> > For (1), I'd generally expect that this is supposed to happen in the
> > arch/common entry code, since that itself (or the irqchip driver) could
> > depend on RCU, and if that's the case thatn handle_domain_irq()
> > shouldn't need to call rcu_irq_enter(). That would be consistent with
> > the way we handle all other exceptions.
> > 
> > For (2) I don't know whether the level of nesting is suppoosed to
> > matter. I was under the impression it wasn't meant to matter in general,
> > so I'm a little surprised that rcu_is_cpu_rrupt_from_idle() depends on a
> > specific level of nesting.
> > 
> > >From a glance it looks like this would cause rcu_sched_clock_irq() to
> > skip setting TIF_NEED_RESCHED, and to not call invoke_rcu_core(), which
> > doesn't sound right, at least...
> > 
> > Thomas, Paul, thoughts?
> 
> It is absolutely required that rcu_irq_enter() and rcu_irq_exit() calls
> be balanced.  Normally, this is taken care of by the fact that irq_enter()
> invokes rcu_irq_enter() and irq_exit() invokes rcu_irq_exit().  Similarly,
> nmi_enter() invokes rcu_nmi_enter() and nmi_exit() invokes rcu_nmi_exit().

Sure; I didn't mean to suggest those weren't balanced! The problem here
is *nesting*. Due to the structure of our entry code and the core IRQ
code, when handling an IRQ we have a sequence:

	irq_enter() // arch code
	irq_enter() // irq code

	< irq handler here >

	irq_exit() // irq code
	irq_exit() // arch code

... and if we use something like rcu_is_cpu_rrupt_from_idle() in the
middle (e.g. as part of rcu_sched_clock_irq()), this will not give the
expected result because of the additional nesting, since
rcu_is_cpu_rrupt_from_idle() seems to expect that dynticks_nmi_nesting
is only incremented once per exception entry, when it does:

	/* Are we at first interrupt nesting level? */
	nesting = __this_cpu_read(rcu_data.dynticks_nmi_nesting);
	if (nesting > 1)
		return false;

What I'm trying to figure out is whether that expectation is legitimate,
and assuming so, where the entry/exit should happen.

Thanks,
Mark.

> But if you are doing some special-case exception where the handler needs
> to use RCU readers, but where the rest of the work is not needed, then
> the resulting calls to rcu_irq_enter() and rcu_irq_exit() must be in
> the architecture-specific code and must be properly balanced.
> 
> So if exception entry invokes rcu_irq_enter() twice, then exception
> exit also needs to invoke rcu_irq_exit() twice.
> 
> There are some constraints on where calls to these functions are place.
> For example, any exception-entry code prior to the call to rcu_irq_enter()
> must consist solely of functions marked noinstr, but Thomas can tell
> you more.
> 
> Or am I missing the point of your question?
> 
> 							Thanx, Paul
> 
> > AFAICT, s390 will have a similar flow on its IRQ handling path, so if
> > this is a real issue they'll be affected too.
> > 
> > Thanks,
> > Mark.
> > 
> > > Nmi also faces duplicate accounts. This series aims to address these
> > > duplicate issues.
> > > [1-2/5]: address nmi account duplicate
> > > [3-4/5]: address rcu housekeeping duplicate in irq
> > > [5/5]: as a natural result of [3-4/5], address a history issue. [1]
> > > 
> > > 
> > > History:
> > > v1 -> v2:
> > >     change the subject as the motivation varies.
> > >     add the fix for nmi account duplicate
> > > 
> > > The subject of v1 is "[PATCH 1/3] kernel/irq: __handle_domain_irq()
> > > makes irq_enter/exit arch optional". [2] It is brought up to fix [1].
> > > 
> > > There have been some tries to enable crash-stop-NMI on arm64, one by me,
> > > the other by Yuichi's [4].  I hope after this series, they can advance,
> > > as Marc said in [3] "No additional NMI patches will make it until we
> > > have resolved the issues"
> > > 
> > > [1] https://lore.kernel.org/linux-arm-kernel/87lfewnmdz.fsf@nanos.tec.linutronix.de/
> > > [2] https://lore.kernel.org/linux-arm-kernel/1607912752-12481-1-git-send-email-kernelfans@gmail.com
> > > [3] https://lore.kernel.org/linux-arm-kernel/afd82be798cb55fd2f96940db7be78c0@kernel.org
> > > [4] https://lore.kernel.org/linux-arm-kernel/20201104080539.3205889-1-ito-yuichi@fujitsu.com
> > > 
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > Cc: Joey Gouly <joey.gouly@arm.com>
> > > Cc: Sami Tolvanen <samitolvanen@google.com>
> > > Cc: Julien Thierry <julien.thierry@arm.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
> > > Cc: linux-kernel@vger.kernel.org
> > > To: linux-arm-kernel@lists.infradead.org
> > > 
> > > 
> > > Pingfan Liu (5):
> > >   arm64/entry-common: push the judgement of nmi ahead
> > >   irqchip/GICv3: expose handle_nmi() directly
> > >   kernel/irq: make irq_{enter,exit}() in handle_domain_irq() arch
> > >     optional
> > >   irqchip/GICv3: let gic_handle_irq() utilize irqentry on arm64
> > >   irqchip/GICv3: make reschedule-ipi light weight
> > > 
> > >  arch/arm64/Kconfig               |  1 +
> > >  arch/arm64/include/asm/irq.h     |  7 ++++
> > >  arch/arm64/kernel/entry-common.c | 45 +++++++++++++++-------
> > >  arch/arm64/kernel/irq.c          | 29 ++++++++++++++
> > >  drivers/irqchip/irq-gic-v3.c     | 66 ++++++++++++++++++++------------
> > >  kernel/irq/Kconfig               |  3 ++
> > >  kernel/irq/irqdesc.c             |  4 ++
> > >  7 files changed, 116 insertions(+), 39 deletions(-)
> > > 
> > > -- 
> > > 2.31.1
> > > 
