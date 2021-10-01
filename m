Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBEB41ECEF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 14:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354286AbhJAMKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 08:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354146AbhJAMKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 08:10:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A61C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 05:08:58 -0700 (PDT)
Date:   Fri, 1 Oct 2021 14:08:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633090137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YRadpnlF9IdXzsOeCYMcs6XaQP+QKfoESUanVMWqulU=;
        b=4g8Fr3rNz1ZUZiKXcuvx2gdRODxVoBBjDRC+enAdQsHXrgNCh2AFLTR3ATdvBojb+9spOc
        2v3EbqkHcS+0SQif9eSP9i9Tmwvdpv1LB361lEp9omO7Q3dTpaRKqz2eJ9JCmHBQ0+2Fhh
        oU3bZCkwuxj1Dzp7atlPDpUqKFEW9pNdKw7IcL42o8Xz1ayG402KZkPFcPZSPxgGXaRJmy
        tTNrLtE0hqiVelWCsztDDatZA+8sVviqsbYD+QVM46JI8Srwjr0pLpBCwN4eV/I+WVL2uA
        +fu60NL3CmHjsx8q85ZyFFE28zCyVz8Z0M/jpQWsoswiy8zGmhx4rrjMQIVA8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633090137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YRadpnlF9IdXzsOeCYMcs6XaQP+QKfoESUanVMWqulU=;
        b=/klqx7sRYnwuv1sDUYkvK4/qwJb4hAMQRqbPw548h/SlCGSPGAi0/b440YUaJwtr4xY9Pu
        T4Iz3Fbo7BOZtGAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 4/5] irq_work: Handle some irq_work in SOFTIRQ on
 PREEMPT_RT
Message-ID: <20211001120855.hjjaqt5bpowit2r7@linutronix.de>
References: <20210927211919.310855-1-bigeasy@linutronix.de>
 <20210927211919.310855-5-bigeasy@linutronix.de>
 <YVV+RklIlsG6N2ic@hirez.programming.kicks-ass.net>
 <20210930095348.tud6jdcenfkfzugz@linutronix.de>
 <YVXMN5YzUmpX20ET@hirez.programming.kicks-ass.net>
 <20210930163858.orndmu5xfxue3zck@linutronix.de>
 <YVbjxjzVM5Dx4Mv4@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVbjxjzVM5Dx4Mv4@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-01 12:32:38 [+0200], Peter Zijlstra wrote:
> On Thu, Sep 30, 2021 at 06:38:58PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2021-09-30 16:39:51 [+0200], Peter Zijlstra wrote:
> 
> > > Runing them all at the same prio still sucks (much like the single
> > > net-RX thing), but at least a kthread is somewhat controllable.
> > 
> > I could replace the softirq processing with a per-CPU thread. This
> > should work. But I would have to (still) delay the wake-up of the thread
> > to the timer tick - or - we try the wake from the irqwork-self-IPI.
> 
> That, just wake the thread from the hardirq.

"just". Let me do that and see how bad it gets ;)

> > I
> > just don't know how many will arrive back-to-back. The RCU callback
> > (rcu_preempt_deferred_qs_handler()) pops up a lot. By my naive guesswork
> > I would say that the irqwork is not needed since preempt-enable
> > somewhere should do needed scheduling. But then commit
> >   0864f057b050b ("rcu: Use irq_work to get scheduler's attention in clean context")
> > 
> > claims it is not enough.
> 
> Oh gawd, that was something really nasty. I'm not sure that Changelog
> captures all (at least I'm not sure I fully understand the problem again
> reading it).
> 
> But basically that thing wants to reschedule, but suffers the same
> problem as:
> 
> 	preempt_disable();
> 
> 	<TIF_NEED_RESCHED gets set>
> 
> 	local_irq_disable();
> 	preempt_enable();
> 	  // cannea schedule because IRQs are disabled
> 	local_irq_enable();
> 	// lost a reschedule
> 
> 
> Yes, that will _eventually_ reschedule, but violates the PREEMPT rules
> because there is an unspecified amount of time until it does actually do
> reschedule.

Yeah but buh. We could let local_irq_enable/restore() check that
need-resched bit if the above is considered pretty and supported _or_
start to yell if it is not. A middle way would be to trigger that
self-IPI in such a case. I mean everyone suffers from that lost
reschedule and, if I'm not mistaken, you don't receive a remote wakeup
because the remote CPU notices need-resched bit and assumes that it is
about to be handled. So RCU isn't special here.

> So what RCU does there is basically trigger a self-IPI, which guarantees
> that we reschedule after IRQs are finally enabled, which then triggers a
> resched.
> 
> I see no problem marking that particular irq_work as HARD tho, it really
> doesn't do anything (other than tell RCU the GP is no longer blocked)
> and triggering the return-from-interrupt path.

Hmm. Your Highness. I'm going back to my peasant village to build the
thread you asked for. I will look into this. I see two of those irq-work
things that is the scheduler thingy and this.

Thanks.

> There's also a fun comment in perf_lock_task_context() that possibly
> predates the above RCU fix.

Sebastian
