Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF95417DF9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 00:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345767AbhIXXBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 19:01:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232123AbhIXXB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 19:01:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5314D610C7;
        Fri, 24 Sep 2021 22:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632524394;
        bh=rG5Tcp42J9XYgfx6smXoytRUgQB7PWMMqHoeUwH80D0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=exJt4UTDeu9FUyQjojZdPT/ob2QrtjlhNow6ehktfWIgAbQ1isHCYmoFJJ9IKQTIe
         h9WcWJyX3aJQak3qQ8J2IDQkk1fY9b3SX98QhamRJkz5cAV39aYU42v06IwTTegRIj
         AuHMehpYszINPJoUmO+cN7gukrfUian9RZUv+aXr0w2S6jAk2W1Y38lG+xWZ73siAN
         uNcE3+P3+FGd7Y1/2UF8WxMQM92C6aPZPBwKSRmhLF37XAYgpn/e0yM88+SBqvlpMO
         1qWuGuXBdkzhODfRb1uXQolINuLZZJv8tI2h2+Qk4miKJ0ELAcnz/aBI7sWTBwu6Lw
         eQAU8bBae2vtw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1F10B5C0800; Fri, 24 Sep 2021 15:59:54 -0700 (PDT)
Date:   Fri, 24 Sep 2021 15:59:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
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
Message-ID: <20210924225954.GN880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210924132837.45994-1-kernelfans@gmail.com>
 <20210924173615.GA42068@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924173615.GA42068@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 06:36:15PM +0100, Mark Rutland wrote:
> [Adding Paul for RCU, s390 folk for entry code RCU semantics]
> 
> On Fri, Sep 24, 2021 at 09:28:32PM +0800, Pingfan Liu wrote:
> > After introducing arm64/kernel/entry_common.c which is akin to
> > kernel/entry/common.c , the housekeeping of rcu/trace are done twice as
> > the following:
> >     enter_from_kernel_mode()->rcu_irq_enter().
> > And
> >     gic_handle_irq()->...->handle_domain_irq()->irq_enter()->rcu_irq_enter()
> >
> > Besides redundance, based on code analysis, the redundance also raise
> > some mistake, e.g.  rcu_data->dynticks_nmi_nesting inc 2, which causes
> > rcu_is_cpu_rrupt_from_idle() unexpected.
> 
> Hmmm...
> 
> The fundamental questionss are:
> 
> 1) Who is supposed to be responsible for doing the rcu entry/exit?
> 
> 2) Is it supposed to matter if this happens multiple times?
> 
> For (1), I'd generally expect that this is supposed to happen in the
> arch/common entry code, since that itself (or the irqchip driver) could
> depend on RCU, and if that's the case thatn handle_domain_irq()
> shouldn't need to call rcu_irq_enter(). That would be consistent with
> the way we handle all other exceptions.
> 
> For (2) I don't know whether the level of nesting is suppoosed to
> matter. I was under the impression it wasn't meant to matter in general,
> so I'm a little surprised that rcu_is_cpu_rrupt_from_idle() depends on a
> specific level of nesting.
> 
> >From a glance it looks like this would cause rcu_sched_clock_irq() to
> skip setting TIF_NEED_RESCHED, and to not call invoke_rcu_core(), which
> doesn't sound right, at least...
> 
> Thomas, Paul, thoughts?

It is absolutely required that rcu_irq_enter() and rcu_irq_exit() calls
be balanced.  Normally, this is taken care of by the fact that irq_enter()
invokes rcu_irq_enter() and irq_exit() invokes rcu_irq_exit().  Similarly,
nmi_enter() invokes rcu_nmi_enter() and nmi_exit() invokes rcu_nmi_exit().

But if you are doing some special-case exception where the handler needs
to use RCU readers, but where the rest of the work is not needed, then
the resulting calls to rcu_irq_enter() and rcu_irq_exit() must be in
the architecture-specific code and must be properly balanced.

So if exception entry invokes rcu_irq_enter() twice, then exception
exit also needs to invoke rcu_irq_exit() twice.

There are some constraints on where calls to these functions are place.
For example, any exception-entry code prior to the call to rcu_irq_enter()
must consist solely of functions marked noinstr, but Thomas can tell
you more.

Or am I missing the point of your question?

							Thanx, Paul

> AFAICT, s390 will have a similar flow on its IRQ handling path, so if
> this is a real issue they'll be affected too.
> 
> Thanks,
> Mark.
> 
> > Nmi also faces duplicate accounts. This series aims to address these
> > duplicate issues.
> > [1-2/5]: address nmi account duplicate
> > [3-4/5]: address rcu housekeeping duplicate in irq
> > [5/5]: as a natural result of [3-4/5], address a history issue. [1]
> > 
> > 
> > History:
> > v1 -> v2:
> >     change the subject as the motivation varies.
> >     add the fix for nmi account duplicate
> > 
> > The subject of v1 is "[PATCH 1/3] kernel/irq: __handle_domain_irq()
> > makes irq_enter/exit arch optional". [2] It is brought up to fix [1].
> > 
> > There have been some tries to enable crash-stop-NMI on arm64, one by me,
> > the other by Yuichi's [4].  I hope after this series, they can advance,
> > as Marc said in [3] "No additional NMI patches will make it until we
> > have resolved the issues"
> > 
> > [1] https://lore.kernel.org/linux-arm-kernel/87lfewnmdz.fsf@nanos.tec.linutronix.de/
> > [2] https://lore.kernel.org/linux-arm-kernel/1607912752-12481-1-git-send-email-kernelfans@gmail.com
> > [3] https://lore.kernel.org/linux-arm-kernel/afd82be798cb55fd2f96940db7be78c0@kernel.org
> > [4] https://lore.kernel.org/linux-arm-kernel/20201104080539.3205889-1-ito-yuichi@fujitsu.com
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Joey Gouly <joey.gouly@arm.com>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Julien Thierry <julien.thierry@arm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
> > Cc: linux-kernel@vger.kernel.org
> > To: linux-arm-kernel@lists.infradead.org
> > 
> > 
> > Pingfan Liu (5):
> >   arm64/entry-common: push the judgement of nmi ahead
> >   irqchip/GICv3: expose handle_nmi() directly
> >   kernel/irq: make irq_{enter,exit}() in handle_domain_irq() arch
> >     optional
> >   irqchip/GICv3: let gic_handle_irq() utilize irqentry on arm64
> >   irqchip/GICv3: make reschedule-ipi light weight
> > 
> >  arch/arm64/Kconfig               |  1 +
> >  arch/arm64/include/asm/irq.h     |  7 ++++
> >  arch/arm64/kernel/entry-common.c | 45 +++++++++++++++-------
> >  arch/arm64/kernel/irq.c          | 29 ++++++++++++++
> >  drivers/irqchip/irq-gic-v3.c     | 66 ++++++++++++++++++++------------
> >  kernel/irq/Kconfig               |  3 ++
> >  kernel/irq/irqdesc.c             |  4 ++
> >  7 files changed, 116 insertions(+), 39 deletions(-)
> > 
> > -- 
> > 2.31.1
> > 
