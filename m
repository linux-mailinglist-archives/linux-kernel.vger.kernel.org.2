Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BE041ACEB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240169AbhI1K15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:27:57 -0400
Received: from foss.arm.com ([217.140.110.172]:49032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240172AbhI1K1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:27:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79D186D;
        Tue, 28 Sep 2021 03:26:12 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.23.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 261A63F7B4;
        Tue, 28 Sep 2021 03:26:07 -0700 (PDT)
Date:   Tue, 28 Sep 2021 11:26:04 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCHv2 0/5] arm64/irqentry: remove duplicate housekeeping of
Message-ID: <20210928102604.GE1924@C02TD0UTHF1T.local>
References: <20210924132837.45994-1-kernelfans@gmail.com>
 <20210924173615.GA42068@C02TD0UTHF1T.local>
 <20210924225954.GN880162@paulmck-ThinkPad-P17-Gen-1>
 <20210927092303.GC1131@C02TD0UTHF1T.local>
 <20210928000922.GY880162@paulmck-ThinkPad-P17-Gen-1>
 <20210928083222.GA1924@C02TD0UTHF1T.local>
 <yt9dtui53u30.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dtui53u30.fsf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 11:52:51AM +0200, Sven Schnelle wrote:
> Mark Rutland <mark.rutland@arm.com> writes:
> 
> > On Mon, Sep 27, 2021 at 05:09:22PM -0700, Paul E. McKenney wrote:
> >> On Mon, Sep 27, 2021 at 10:23:18AM +0100, Mark Rutland wrote:
> >> > Sure; I didn't mean to suggest those weren't balanced! The problem here
> >> > is *nesting*. Due to the structure of our entry code and the core IRQ
> >> > code, when handling an IRQ we have a sequence:
> >> > 
> >> > 	irq_enter() // arch code
> >> > 	irq_enter() // irq code
> >> > 
> >> > 	< irq handler here >
> >> > 
> >> > 	irq_exit() // irq code
> >> > 	irq_exit() // arch code
> >> > 
> >> > ... and if we use something like rcu_is_cpu_rrupt_from_idle() in the
> >> > middle (e.g. as part of rcu_sched_clock_irq()), this will not give the
> >> > expected result because of the additional nesting, since
> >> > rcu_is_cpu_rrupt_from_idle() seems to expect that dynticks_nmi_nesting
> >> > is only incremented once per exception entry, when it does:
> >> > 
> >> > 	/* Are we at first interrupt nesting level? */
> >> > 	nesting = __this_cpu_read(rcu_data.dynticks_nmi_nesting);
> >> > 	if (nesting > 1)
> >> > 		return false;
> >> > 
> >> > What I'm trying to figure out is whether that expectation is legitimate,
> >> > and assuming so, where the entry/exit should happen.
> >> 
> >> Oooh...
> >> 
> >> The penalty for fooling rcu_is_cpu_rrupt_from_idle() is that RCU will
> >> be unable to detect a userspace quiescent state for a non-nohz_full
> >> CPU.  That could result in RCU CPU stall warnings if a user task runs
> >> continuously on a given CPU for more than 21 seconds (60 seconds in
> >> some distros).  And this can easily happen if the user has a CPU-bound
> >> thread that is the only runnable task on that CPU.
> >> 
> >> So, yes, this does need some sort of resolution.
> >> 
> >> The traditional approach is (as you surmise) to have only a single call
> >> to irq_enter() on exception entry and only a single call to irq_exit()
> >> on exception exit.  If this is feasible, it is highly recommended.
> >
> > Cool; that's roughly what I was expecting / hoping to hear!
> >
> >> In theory, we could have that "1" in "nesting > 1" be a constant supplied
> >> by the architecture (you would want "3" if I remember correctly) but
> >> in practice could we please avoid this?  For one thing, if there is
> >> some other path into the kernel for your architecture that does only a
> >> single irq_enter(), then rcu_is_cpu_rrupt_from_idle() just doesn't stand
> >> a chance.  It would need to compare against a different value depending
> >> on what exception showed up.  Even if that cannot happen, it would be
> >> better if your architecture could remain in blissful ignorance of the
> >> colorful details of ->dynticks_nmi_nesting manipulations.
> >
> > I completely agree. I think it's much harder to keep that in check than
> > to enforce a "once per architectural exception" policy in the arch code.
> >
> >> Another approach would be for the arch code to supply RCU a function that
> >> it calls.  If there is such a function (or perhaps better, if some new
> >> Kconfig option is enabled), RCU invokes it.  Otherwise, it compares to
> >> "1" as it does now.  But you break it, you buy it!  ;-)
> >
> > I guess we could look at the exception regs and inspect the original
> > context, but it sounds overkill...
> >
> > I think the cleanest thing is to leave this to arch code, and have the
> > common IRQ code stay well clear. Unfortunately most architectures
> > (including arch/arm) still need the common IRQ code to handle this, so
> > we'll have to make that conditional on Kconfig, something like the below
> > (build+boot tested only).
> >
> > If there are no objections, I'll go check who else needs the same
> > treatment (IIUC at least s390 will), and spin that as a real
> > patch/series.
> 
> Hmm, s390 doesn't use handle_domain_irq() and doesn't have
> HANDLE_DOMAIN_IRQ set. So i don't think the patch below applies to s390.
> However, i'll follow the code to make sure we're not calling
> irq_enter/irq_exit twice.

I wasn't clear, but for s390, my concern was that in do_io_irq() and
do_ext_irq() you have the sequence:

	irqentry_enter()	// calls rcu_irq_enter()
	irq_enter();		// calls rcu_irq_enter() then irq_enter_rcu();

	< handler>

	irq_exit();		// calls __irq_exit_rcu then rcu_irq_exit();
	irqentry_exit();	// calls rcu_irq_exit()

... and so IIUC you call rcu_irq_enter() and rcu_irq_exit() twice,
getting the same double-increment of `dynticks_nmi_nesting` per
interrupt, and the same potential problem with
rcu_is_cpu_rrupt_from_idle().

Thanks,
Mark.
