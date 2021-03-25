Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D83A3492BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhCYNIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:08:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230241AbhCYNIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:08:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4ACA61A26;
        Thu, 25 Mar 2021 13:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616677680;
        bh=ay7jHy+IN5DJK2Ax+Lw0U4zg5VZ6z8995EDoxgwUap8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aAoN7G0XPC2i3xWqxeozi2xY6sA83W+izDswsLNWoRZfjY4ZabKMWBtyMm9b2L+3j
         B7PFDYPOCKXTj6M5lSwXdXNvNx6jbaqH1Fzsx3cCpFIpafCVZcs8jqogPqFyBXGBNm
         l4TNQ5IfRrN/zs5cCaNYJ++K0/u9R5rIU0W3Fk1uU1jXjfWjL+C2j1wxE6iI76+g3Z
         RHt8vtT3GXaXeMLAaTXbaX+DrMR4NjbKYUPERO/q9vvPrExQ3LQOZwXAqnMB5aXtix
         Yj5pcmfB6OM7ekwaFFPF/8Q4nyvY3LcM7Jth2bgXFFsk+cOHmYn5NKGmD1Rfhnh0uB
         OD/nqMKoLlPcw==
Date:   Thu, 25 Mar 2021 14:07:57 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ti Zhou <x2019cwm@stfx.ca>, Yunfeng Ye <yeyunfeng@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 06/10] timer: Report ignored local enqueue in nohz mode
Message-ID: <20210325130757.GA938196@lothringen>
References: <20210311123708.23501-1-frederic@kernel.org>
 <20210311123708.23501-7-frederic@kernel.org>
 <YFDOfEsr07LN++YD@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFDOfEsr07LN++YD@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 04:27:56PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 11, 2021 at 01:37:04PM +0100, Frederic Weisbecker wrote:
> > Enqueuing a local timer after the tick has been stopped will result in
> > the timer being ignored until the next random interrupt.
> > 
> > Perform sanity checks to report these situations.
> > 
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/sched/core.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index ca2bb629595f..24552911f92b 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -674,6 +674,22 @@ int get_nohz_timer_target(void)
> >  	return cpu;
> >  }
> >  
> > +/* Make sure the timer won't be ignored in dynticks-idle case */
> > +static void wake_idle_assert_possible(void)
> > +{
> > +#ifdef CONFIG_SCHED_DEBUG
> > +	/*
> > +	 * Timers are re-evaluated after idle IRQs. In case of softirq,
> > +	 * we assume IRQ tail. Ksoftirqd shouldn't reach here as the
> > +	 * timer base wouldn't be idle. And inline softirq processing
> > +	 * after a call to local_bh_enable() within idle loop sound too
> > +	 * fun to be considered here.
> > +	 */
> > +	WARN_ONCE(in_task(),
> > +		  "Late timer enqueue may be ignored\n");
> > +#endif
> > +}
> > +
> >  /*
> >   * When add_timer_on() enqueues a timer into the timer wheel of an
> >   * idle CPU then this timer might expire before the next timer event
> > @@ -688,8 +704,10 @@ static void wake_up_idle_cpu(int cpu)
> >  {
> >  	struct rq *rq = cpu_rq(cpu);
> >  
> > -	if (cpu == smp_processor_id())
> > +	if (cpu == smp_processor_id()) {
> > +		wake_idle_assert_possible();
> >  		return;
> > +	}
> >  
> >  	if (set_nr_and_not_polling(rq->idle))
> >  		smp_send_reschedule(cpu);
> 
> I'm not entirely sure I understand this one. What's the callchain that
> leads to this?

That's while calling add_timer*() or mod_timer() on an idle target.

Now the issue is only relevant when these timer functions are called
after cpuidle_select(), which arguably makes a small vulnerable window
that could be spotted in the future if the timer functions are called
after instrumentation_end()?

Thanks.
