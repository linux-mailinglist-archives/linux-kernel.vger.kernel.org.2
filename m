Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16588365DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 18:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhDTQyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 12:54:21 -0400
Received: from foss.arm.com ([217.140.110.172]:38208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232767AbhDTQyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 12:54:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9AF31474;
        Tue, 20 Apr 2021 09:53:47 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0203D3F73B;
        Tue, 20 Apr 2021 09:53:45 -0700 (PDT)
Date:   Tue, 20 Apr 2021 17:53:40 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
        swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, qais.yousef@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched: Use cpu_dying() to fix balance_push vs
 hotplug-rollback
Message-ID: <20210420165340.GA231208@e120877-lin.cambridge.arm.com>
References: <YHQ3Iy7QfL+0UoM0@hirez.programming.kicks-ass.net>
 <87r1jfmn8d.mognet@arm.com>
 <YHU/a9HvGLYpOLKZ@hirez.programming.kicks-ass.net>
 <YHgAYef83VQhKdC2@hirez.programming.kicks-ass.net>
 <87a6pzmxec.mognet@arm.com>
 <20210419105541.GA40111@e120877-lin.cambridge.arm.com>
 <20210420094632.GA165360@e120877-lin.cambridge.arm.com>
 <YH7jSPZx0BhyHoLe@hirez.programming.kicks-ass.net>
 <YH7niBZDWjsz+jBa@hirez.programming.kicks-ass.net>
 <YH7r+AoQEReSvxBI@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH7r+AoQEReSvxBI@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 04:58:00PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 20, 2021 at 04:39:04PM +0200, Peter Zijlstra wrote:
> > On Tue, Apr 20, 2021 at 04:20:56PM +0200, Peter Zijlstra wrote:
> > > On Tue, Apr 20, 2021 at 10:46:33AM +0100, Vincent Donnefort wrote:
> > > 
> > > > Found the issue:
> > > > 
> > > > $ cat hotplug/states:
> > > > 219: sched:active
> > > > 220: online
> > > > 
> > > > CPU0: 
> > > > 
> > > > $ echo 219 > hotplug/fail
> > > > $ echo 0 > online
> > > > 
> > > > => cpu_active = 1 cpu_dying = 1
> > > > 
> > > > which means that later on, for another CPU hotunplug, in
> > > > __balance_push_cpu_stop(), the fallback rq for a kthread can select that
> > > > CPU0, but __migrate_task() would fail and we end-up in an infinite loop,
> > > > trying to migrate that task to CPU0.
> > > > 
> > > > The problem is that for a failure in sched:active, as "online" has no callback,
> > > > there will be no call to cpuhp_invoke_callback(). Hence, the cpu_dying bit would
> > > > not be reset.
> > > 
> > > Urgh! Good find.
> 
> > I seem to have triggered the BUG() in select_fallback_rq() with your recipie.
> > Have cpu0 fail on sched:active, then offline all other CPUs.
> > 
> > Now lemme add that patch.
> 
> (which obviously didn't actually build) seems to fix it.
> 
> ---
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 838dcf238f92..e538518556f4 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -63,6 +63,7 @@ struct cpuhp_cpu_state {
>  	bool			rollback;
>  	bool			single;
>  	bool			bringup;
> +	int			cpu;
>  	struct hlist_node	*node;
>  	struct hlist_node	*last;
>  	enum cpuhp_state	cb_state;
> @@ -160,9 +161,6 @@ static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
>  	int (*cb)(unsigned int cpu);
>  	int ret, cnt;
>  
> -	if (cpu_dying(cpu) != !bringup)
> -		set_cpu_dying(cpu, !bringup);
> -
>  	if (st->fail == state) {
>  		st->fail = CPUHP_INVALID;
>  		return -EAGAIN;
> @@ -467,13 +465,16 @@ static inline enum cpuhp_state
>  cpuhp_set_state(struct cpuhp_cpu_state *st, enum cpuhp_state target)
>  {
>  	enum cpuhp_state prev_state = st->state;
> +	bool bringup = st->state < target;
>  
>  	st->rollback = false;
>  	st->last = NULL;
>  
>  	st->target = target;
>  	st->single = false;
> -	st->bringup = st->state < target;
> +	st->bringup = bringup;
> +	if (cpu_dying(st->cpu) != !bringup)
> +		set_cpu_dying(st->cpu, !bringup);
>  
>  	return prev_state;
>  }
> @@ -481,6 +482,8 @@ cpuhp_set_state(struct cpuhp_cpu_state *st, enum cpuhp_state target)
>  static inline void
>  cpuhp_reset_state(struct cpuhp_cpu_state *st, enum cpuhp_state prev_state)
>  {
> +	bool bringup = !st->bringup;
> +
>  	st->target = prev_state;
>  
>  	/*
> @@ -503,7 +506,9 @@ cpuhp_reset_state(struct cpuhp_cpu_state *st, enum cpuhp_state prev_state)
>  			st->state++;
>  	}
>  
> -	st->bringup = !st->bringup;
> +	st->bringup = bringup;
> +	if (cpu_dying(st->cpu) != !bringup)
> +		set_cpu_dying(st->cpu, !bringup);
>  }
>  
>  /* Regular hotplug invocation of the AP hotplug thread */
> @@ -693,6 +698,7 @@ static void cpuhp_create(unsigned int cpu)
>  
>  	init_completion(&st->done_up);
>  	init_completion(&st->done_down);
> +	st->cpu = cpu;
>  }
>  
>  static int cpuhp_should_run(unsigned int cpu)

All good with that snippet on my end.

I wonder if balance_push() shouldn't use the cpu_of() accessor
instead of rq->cpu.

Otherwise,

+ Reviewed-by: Vincent Donnefort <vincent.donnefort@arm.com>
