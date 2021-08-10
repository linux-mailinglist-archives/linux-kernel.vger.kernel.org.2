Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093AC3D981A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 00:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhG1WBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 18:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231668AbhG1WBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 18:01:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BF6E60F5E;
        Wed, 28 Jul 2021 22:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627509699;
        bh=eT1ZYBz1kwcqDTxbLvzyK/4f/qPZ0QCHOcZMPByW5y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=abA7RTUyN/hXppfCfRb6ywSxGoiOkGSVe/n0+PWvd8OLQkmiM691COMzZYC/qO9cU
         z5VtYefEq9b8ZJpuZ4yKPSuvr5k/B0PK8KLFlGF3hiRH4o8e/qR0p2TgUixgromYnF
         RYgM9pbxUFXo4d8Rn2Acw/W1emcZyOFThFMzVufoQyyuddm/3IrGj6evxNQ+NU19Ek
         iXdgSSyYvpaNzTZshWBz8KyZpFn6IpF23c07BS5MHlfEwiknl0msaTRww6zDSFTJ5U
         dpldAlQo9OkIBsw0pObRlvcv4Wxjj8aLEobuVyLfczrKfUIP/uhPNMPgkw/YTgUqMT
         5NJdXY7/Rx8cw==
Date:   Thu, 29 Jul 2021 00:01:37 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/3] rcu/nocb: Check for migratability rather than pure
 preemptability
Message-ID: <20210728220137.GD293265@lothringen>
References: <20210721115118.729943-1-valentin.schneider@arm.com>
 <20210721115118.729943-3-valentin.schneider@arm.com>
 <20210727230814.GC283787@lothringen>
 <87pmv2kzbd.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmv2kzbd.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 08:34:14PM +0100, Valentin Schneider wrote:
> On 28/07/21 01:08, Frederic Weisbecker wrote:
> > On Wed, Jul 21, 2021 at 12:51:17PM +0100, Valentin Schneider wrote:
> >> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> >> ---
> >>  kernel/rcu/tree_plugin.h | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> >> index ad0156b86937..6c3c4100da83 100644
> >> --- a/kernel/rcu/tree_plugin.h
> >> +++ b/kernel/rcu/tree_plugin.h
> >> @@ -70,8 +70,7 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
> >>              !(lockdep_is_held(&rcu_state.barrier_mutex) ||
> >>                (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
> >>                rcu_lockdep_is_held_nocb(rdp) ||
> >> -		  (rdp == this_cpu_ptr(&rcu_data) &&
> >> -		   !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
> >> +		  (rdp == this_cpu_ptr(&rcu_data) && is_pcpu_safe()) ||
> >
> > I fear that won't work. We really need any caller of rcu_rdp_is_offloaded()
> > on the local rdp to have preemption disabled and not just migration disabled,
> > because we must protect against concurrent offloaded state changes.
> >
> > The offloaded state is changed by a workqueue that executes on the target rdp.
> >
> > Here is a practical example where it matters:
> >
> >            CPU 0
> >            -----
> >            // =======> task rcuc running
> >            rcu_core {
> >              rcu_nocb_lock_irqsave(rdp, flags) {
> >                    if (!rcu_segcblist_is_offloaded(rdp->cblist)) {
> >                      // is not offloaded right now, so it's going
> >                        // to just disable IRQs. Oh no wait:
> >            // preemption
> >            // ========> workqueue running
> >            rcu_nocb_rdp_offload();
> >            // ========> task rcuc resume
> >                      local_irq_disable();
> >                    }
> >                }
> >              ....
> >                      rcu_nocb_unlock_irqrestore(rdp, flags) {
> >                    if (rcu_segcblist_is_offloaded(rdp->cblist)) {
> >                        // is offloaded right now so:
> >                        raw_spin_unlock_irqrestore(rdp, flags);
> >
> > And that will explode because that's an impaired unlock on nocb_lock.
> 
> Harumph, that doesn't look good, thanks for pointing this out.
> 
> AFAICT PREEMPT_RT doesn't actually require to disable softirqs here (since
> it forces RCU callbacks on the RCU kthreads), but disabled softirqs seem to
> be a requirement for much of the underlying functions and even some of the
> callbacks (delayed_put_task_struct() ~> vfree() pays close attention to
> in_interrupt() for instance).
> 
> Now, if the offloaded state was (properly) protected by a local_lock, do
> you reckon we could then keep preemption enabled?

I guess we could take such a local lock on the update side
(rcu_nocb_rdp_offload) and then take it on rcuc kthread/softirqs
and maybe other places.

But we must make sure that rcu_core() is preempt-safe from a general perspective
in the first place. From a quick glance I can't find obvious issues...yet.

Paul maybe you can see something?

> 
> From a naive outsider PoV, rdp->nocb_lock looks like a decent candidate,
> but it's a *raw* spinlock (I can't tell right now whether changing this is
> a horrible idea or not), and then there's

Yeah that's not possible, nocb_lock is too low level and has to be called with
IRQs disabled. So if we take that local_lock solution, we need a new lock.

Thanks.
