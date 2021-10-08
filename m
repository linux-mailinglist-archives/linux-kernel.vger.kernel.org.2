Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57002426DFD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243247AbhJHPrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:47:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243073AbhJHPrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:47:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 621C26101A;
        Fri,  8 Oct 2021 15:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633707923;
        bh=MKXFIqcB87xB3g54OhwzxzavC4tbqq259N9A9C5dUX4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=q+3Oxjlo54UFrXeM7UGZCThf9cr76myGOK0EJj5LGxbH06P6gZLP7M75NVwZ8Z5HB
         Rjg2L8lwb/y+lAZOYOQgsEYsw9zkG6B2vgRwvWN5q11EC/nu0PTA8YdZal4loZieGM
         y3u4B0TE9wN+Y9wInT0uKTPSu0sbvxJQ+Z9iyaqWc1KPUWE7AFtdX81xn91TKXr2Ol
         K8u5SJ7FlZ+O41Bqm3CD0yO0ePQ8Spm7RlPygKQfm33l12Kmw2JC/4xuK1ZXkjdkl7
         Ba43LhMeZZdO8h/V58p69kRWkItssd19DOfChHZlx2fK3vM+leNLcNe02qjSSZif4L
         UAoi+A/GBm/nA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 35E2C5C06B9; Fri,  8 Oct 2021 08:45:23 -0700 (PDT)
Date:   Fri, 8 Oct 2021 08:45:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <20211008154523.GP880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210924132837.45994-1-kernelfans@gmail.com>
 <20210924132837.45994-2-kernelfans@gmail.com>
 <20210924175306.GB42068@C02TD0UTHF1T.local>
 <YU9Cy9kTew4ySeGZ@piliu.users.ipa.redhat.com>
 <20210930133257.GB18258@lakrids.cambridge.arm.com>
 <YV/ClUNWvMga3qud@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV/ClUNWvMga3qud@piliu.users.ipa.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 12:01:25PM +0800, Pingfan Liu wrote:
> Sorry that I missed this message and I am just back from a long
> festival.
> 
> Adding Paul for RCU guidance.

Didn't the recent patch series cover this, or is this a new problem?

							Thanx, Paul

> On Thu, Sep 30, 2021 at 02:32:57PM +0100, Mark Rutland wrote:
> > On Sat, Sep 25, 2021 at 11:39:55PM +0800, Pingfan Liu wrote:
> > > On Fri, Sep 24, 2021 at 06:53:06PM +0100, Mark Rutland wrote:
> > > > On Fri, Sep 24, 2021 at 09:28:33PM +0800, Pingfan Liu wrote:
> > > > > In enter_el1_irq_or_nmi(), it can be the case which NMI interrupts an
> > > > > irq, which makes the condition !interrupts_enabled(regs) fail to detect
> > > > > the NMI. This will cause a mistaken account for irq.
> > > > 
> > > Sorry about the confusing word "account", it should be "lockdep/rcu/.."
> > > 
> > > > Can you please explain this in more detail? It's not clear which
> > > > specific case you mean when you say "NMI interrupts an irq", as that
> > > > could mean a number of distinct scenarios.
> > > > 
> > > > AFAICT, if we're in an IRQ handler (with NMIs unmasked), and an NMI
> > > > causes a new exception we'll do the right thing. So either I'm missing a
> > > > subtlety or you're describing a different scenario..
> > > > 
> > > > Note that the entry code is only trying to distinguish between:
> > > > 
> > > > a) This exception is *definitely* an NMI (because regular interrupts
> > > >    were masked).
> > > > 
> > > > b) This exception is *either* and IRQ or an NMI (and this *cannot* be
> > > >    distinguished until we acknowledge the interrupt), so we treat it as
> > > >    an IRQ for now.
> > > > 
> > > b) is the aim.
> > > 
> > > At the entry, enter_el1_irq_or_nmi() -> enter_from_kernel_mode()->rcu_irq_enter()/rcu_irq_enter_check_tick() etc.
> > > While at irqchip level, gic_handle_irq()->gic_handle_nmi()->nmi_enter(),
> > > which does not call rcu_irq_enter_check_tick(). So it is not proper to
> > > "treat it as an IRQ for now"
> > 
> > I'm struggling to understand the problem here. What is "not proper", and
> > why?
> > 
> > Do you think there's a correctness problem, or that we're doing more
> > work than necessary? 
> > 
> I had thought it just did redundant accounting. But after revisiting RCU
> code, I think it confronts a real bug.
> 
> > If you could give a specific example of a problem, it would really help.
> > 
> Refer to rcu_nmi_enter(), which can be called by
> enter_from_kernel_mode():
> 
> ||noinstr void rcu_nmi_enter(void)
> ||{
> ||        ...
> ||        if (rcu_dynticks_curr_cpu_in_eqs()) {
> ||
> ||                if (!in_nmi())
> ||                        rcu_dynticks_task_exit();
> ||
> ||                // RCU is not watching here ...
> ||                rcu_dynticks_eqs_exit();
> ||                // ... but is watching here.
> ||
> ||                if (!in_nmi()) {
> ||                        instrumentation_begin();
> ||                        rcu_cleanup_after_idle();
> ||                        instrumentation_end();
> ||                }
> ||
> ||                instrumentation_begin();
> ||                // instrumentation for the noinstr rcu_dynticks_curr_cpu_in_eqs()
> ||                instrument_atomic_read(&rdp->dynticks, sizeof(rdp->dynticks));
> ||                // instrumentation for the noinstr rcu_dynticks_eqs_exit()
> ||                instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
> ||
> ||                incby = 1;
> ||        } else if (!in_nmi()) {
> ||                instrumentation_begin();
> ||                rcu_irq_enter_check_tick();
> ||        } else  {
> ||                instrumentation_begin();
> ||        }
> ||        ...
> ||}
> 
> There is 3 pieces of code put under the
> protection of if (!in_nmi()). At least the last one
> "rcu_irq_enter_check_tick()" can trigger a hard lock up bug. Because it
> is supposed to hold a spin lock with irqoff by
> "raw_spin_lock_rcu_node(rdp->mynode)", but pNMI can breach it. The same
> scenario in rcu_nmi_exit()->rcu_prepare_for_idle().
> 
> As for the first two "if (!in_nmi())", I have no idea of why, except
> breaching spin_lock_irq() by NMI. Hope Paul can give some guide.
> 
> 
> Thanks,
> 
> 	Pingfan
> 
> 
> > I'm aware that we do more work than strictly necessary when we take a
> > pNMI from a context with IRQs enabled, but that's how we'd intended this
> > to work, as it's vastly simpler to manage the state that way. Unless
> > there's a real problem with that approach I'd prefer to leave it as-is.
> > 
> > Thanks,
> > Mark.
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
