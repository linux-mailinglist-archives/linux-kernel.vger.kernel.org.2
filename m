Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2D632F6CB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 00:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhCEXsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 18:48:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhCEXsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 18:48:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8809F650A1;
        Fri,  5 Mar 2021 23:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614988086;
        bh=VPGxS7+wg8uWi3LiT2LzPvYVeiCOBQQnkwZ8HwkSlc0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HtNiJOZkNbYV3zjG03tyL3+IQuWya3hxSw1enZ2KlY1LlwZO4FmWL8OMQqmvxtHUv
         uOujviPOkWvQECpqsNhVEWcw9cN8KvkGCrCZXYtwrClwPUubu2Pr27l/IJoKxCsS9U
         jS1cOoIQ1nk7gvS5RvkdKmUnSurr+bzVxCkthUjqtYVpSs1QTllw60klva6Kb8s7ma
         3KADXacKxAbI0Ey5xceTZmiJjTqfLFvSMClHxr/pJFF4UGfcKEUZ0npYGpY9YW8l8v
         gVrSqI7BhaOFy/lGYLOfp6wCUradiMFRPpBo0Yew4hVC98XmtfA/KZEFCw4vM2SZgA
         NVjwaTb5syC/A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 59FE835237A1; Fri,  5 Mar 2021 15:48:06 -0800 (PST)
Date:   Fri, 5 Mar 2021 15:48:06 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org
Subject: Re: timer: Report ignored local enqueue in nohz mode?
Message-ID: <20210305234806.GH2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210303194945.GA20866@paulmck-ThinkPad-P72>
 <20210305134111.GA142352@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305134111.GA142352@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 02:41:11PM +0100, Frederic Weisbecker wrote:
> On Wed, Mar 03, 2021 at 11:49:45AM -0800, Paul E. McKenney wrote:
> > Hello, Frederic!
> > 
> > I don't see the following commit in mainline, but figured I should
> > check with you guys to see if the problem got solved in some other way.
> > Unless I hear otherwise, I will continue to carry this patch in -rcu
> > and will send it along for the v5.13 merge window.
> 
> I have it included in a nohz series I'm about to post but since RCU is the
> motivation behind doing this, it's fine if you carry it.

Actually, please feel free to run this up the normal nohz path.
I will remove my version once yours hits mainline, as I did with
the others.

I was just curious.  ;-)

							Thanx, Paul

> I've just modified it a bit after a review from Peter:
> 
> ---
> >From 7876725b8631147967bb9e65158ef1cb2bb94372 Mon Sep 17 00:00:00 2001
> From: Frederic Weisbecker <frederic@kernel.org>
> Date: Fri, 8 Jan 2021 13:50:12 +0100
> Subject: [PATCH] timer: Report ignored local enqueue in nohz mode
> 
> Enqueuing a local timer after the tick has been stopped will result in
> the timer being ignored until the next random interrupt.
> 
> Perform sanity checks to report these situations.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar<mingo@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/sched/core.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ca2bb629595f..24552911f92b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -674,6 +674,22 @@ int get_nohz_timer_target(void)
>  	return cpu;
>  }
>  
> +/* Make sure the timer won't be ignored in dynticks-idle case */
> +static void wake_idle_assert_possible(void)
> +{
> +#ifdef CONFIG_SCHED_DEBUG
> +	/*
> +	 * Timers are re-evaluated after idle IRQs. In case of softirq,
> +	 * we assume IRQ tail. Ksoftirqd shouldn't reach here as the
> +	 * timer base wouldn't be idle. And inline softirq processing
> +	 * after a call to local_bh_enable() within idle loop sound too
> +	 * fun to be considered here.
> +	 */
> +	WARN_ONCE(in_task(),
> +		  "Late timer enqueue may be ignored\n");
> +#endif
> +}
> +
>  /*
>   * When add_timer_on() enqueues a timer into the timer wheel of an
>   * idle CPU then this timer might expire before the next timer event
> @@ -688,8 +704,10 @@ static void wake_up_idle_cpu(int cpu)
>  {
>  	struct rq *rq = cpu_rq(cpu);
>  
> -	if (cpu == smp_processor_id())
> +	if (cpu == smp_processor_id()) {
> +		wake_idle_assert_possible();
>  		return;
> +	}
>  
>  	if (set_nr_and_not_polling(rq->idle))
>  		smp_send_reschedule(cpu);
> -- 
> 2.25.1
> 
