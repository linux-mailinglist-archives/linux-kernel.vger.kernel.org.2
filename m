Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192B03F4DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhHWPiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:38:54 -0400
Received: from out0.migadu.com ([94.23.1.103]:15762 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231179AbhHWPix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 11:38:53 -0400
Date:   Mon, 23 Aug 2021 23:38:57 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629733089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eh7cu7Eq0oe0cp5p+Ppsk5n54fMptYk4xtgignXy5j8=;
        b=DB35P0zm9n8C6eJIiXhw8wWqMa55ySfGYqG3DSBg7AXevsonpgVfO4sgC7Ml3KitOpmpg+
        WR4U1RXX8u5/ulIF5TukTXNVit5DameSF3rkXBGXjnCBjvvUXkHCQqrTQosten//fY+jX7
        9MFVbH00s+GPmhuYsDnR4QGLxuyBm/U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        linux-kernel@vger.kernel.org, tao.zhou@linux.dev
Subject: Re: [PATCH] sched/core: fix pick_next_task 'max' tracking
Message-ID: <YSPBEYLS64i7c7Dy@geo.homenetwork>
References: <20210818005615.138527-1-joshdon@google.com>
 <YSODqN9G7VuV+kNR@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSODqN9G7VuV+kNR@hirez.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Aug 23, 2021 at 01:16:56PM +0200, Peter Zijlstra wrote:

> On Tue, Aug 17, 2021 at 05:56:15PM -0700, Josh Don wrote:
> > For core-sched, pick_next_task will update the 'max' task if there is a
> > cookie mismatch (since in this case the new task must be of higher
> > priority than the current max). However, we fail to update 'max' if
> > we've found a task with a matching cookie and higher priority than
> > 'max'.
> > 
> > This can result in extra iterations on SMT-X machines, where X > 2.
> > 
> > As an example, on a machine with SMT=3, on core 0, SMT-0 might pick
> > the following, in order:
> > 
> > - SMT-0: p1, with cookie A, and priority 10 (max = p1)
> > - SMT-1: p2, with cookie A, and priority 30 (max not updated here)
> > - SMT-2: p3, with cookie B, and priority 20 (max = p2)
> > 	> invalidate the other picks and retry
> > 
> > Here, we should have instead updated 'max' when picking for SMT-1. Note
> > that this code would eventually have righted itself, since the retry
> > loop would re-pick p2, and update 'max' accordingly. However, this patch
> > avoids the extra round-trip.
> 
> Going with the observation Tao made; how about we rewrite the whole lot
> to not be mind-bending complicated :-)
> 
> How's this? It seems to build and pass the core-sched selftest thingy
> (so it must be perfect, right? :-)
> 
> ---
>  kernel/sched/core.c  | 147 ++++++++++++++-------------------------------------
>  kernel/sched/sched.h |   1 +
>  2 files changed, 41 insertions(+), 107 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ceae25ea8a0e..e896250c2fb8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5404,66 +5404,18 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
>  	return a->core_cookie == b->core_cookie;
>  }
>  
> -// XXX fairness/fwd progress conditions
> -/*
> - * Returns
> - * - NULL if there is no runnable task for this class.
> - * - the highest priority task for this runqueue if it matches
> - *   rq->core->core_cookie or its priority is greater than max.
> - * - Else returns idle_task.
> - */
> -static struct task_struct *
> -pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max, bool in_fi)
> -{
> -	struct task_struct *class_pick, *cookie_pick;
> -	unsigned long cookie = rq->core->core_cookie;
> -
> -	class_pick = class->pick_task(rq);
> -	if (!class_pick)
> -		return NULL;
> -
> -	if (!cookie) {
> -		/*
> -		 * If class_pick is tagged, return it only if it has
> -		 * higher priority than max.
> -		 */
> -		if (max && class_pick->core_cookie &&
> -		    prio_less(class_pick, max, in_fi))
> -			return idle_sched_class.pick_task(rq);
> -
> -		return class_pick;
> -	}
> -
> -	/*
> -	 * If class_pick is idle or matches cookie, return early.
> -	 */
> -	if (cookie_equals(class_pick, cookie))
> -		return class_pick;
> -
> -	cookie_pick = sched_core_find(rq, cookie);
> -
> -	/*
> -	 * If class > max && class > cookie, it is the highest priority task on
> -	 * the core (so far) and it must be selected, otherwise we must go with
> -	 * the cookie pick in order to satisfy the constraint.
> -	 */
> -	if (prio_less(cookie_pick, class_pick, in_fi) &&
> -	    (!max || prio_less(max, class_pick, in_fi)))
> -		return class_pick;
> -
> -	return cookie_pick;
> -}
> -
>  extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
>  
>  static struct task_struct *
>  pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
> -	struct task_struct *next, *max = NULL;
> +	struct task_struct *next, *p, *max = NULL;
>  	const struct sched_class *class;
>  	const struct cpumask *smt_mask;
>  	bool fi_before = false;
> -	int i, j, cpu, occ = 0;
> +	unsigned long cookie;
> +	int i, cpu, occ = 0;
> +	struct rq *rq_i;
>  	bool need_sync;
>  
>  	if (!sched_core_enabled(rq))
> @@ -5554,76 +5506,57 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  		}
>  	}
>  
> -	for_each_cpu(i, smt_mask) {
> -		struct rq *rq_i = cpu_rq(i);
> -
> +	/*
> +	 * For each thread: do the regular task pick and find the max prio task
> +	 * amongst them.
> +	 *
> +	 * Tie-break prio towards the current CPU
> +	 */
> +	for_each_cpu_wrap(i, smt_mask, cpu) {
> +		rq_i = cpu_rq(i);
>  		rq_i->core_pick = NULL;
>  
>  		if (i != cpu)
>  			update_rq_clock(rq_i);
> +
> +		for_each_class(class) {
> +			p = rq_i->core_temp = class->pick_task(rq_i);
> +			if (p)
> +				break;
> +		}
> +
> +		if (!max || prio_less(max, p, fi_before))

The above 'prio_less(max, p, fi_before)' condition covers the
case of Josh's fix if I'm not wrong.

The rewriting code looks clarity and simpler..

> +			max = p;
>  	}
>  
> +	cookie = rq->core->core_cookie = max->core_cookie;
> +
>  	/*
> -	 * Try and select tasks for each sibling in descending sched_class
> -	 * order.
> +	 * For each thread: try and find a runnable task that matches @max or
> +	 * force idle.
>  	 */
> -	for_each_class(class) {
> -again:
> -		for_each_cpu_wrap(i, smt_mask, cpu) {
> -			struct rq *rq_i = cpu_rq(i);
> -			struct task_struct *p;
> -
> -			if (rq_i->core_pick)
> -				continue;
> +	for_each_cpu(i, smt_mask) {
> +		rq_i = cpu_rq(i);
> +		p = rq_i->core_temp;
>  
> -			/*
> -			 * If this sibling doesn't yet have a suitable task to
> -			 * run; ask for the most eligible task, given the
> -			 * highest priority task already selected for this
> -			 * core.
> -			 */
> -			p = pick_task(rq_i, class, max, fi_before);
> +		if (!cookie_equals(p, cookie)) {
> +			p = NULL;
> +			if (cookie)
> +				p = sched_core_find(rq_i, cookie);
>  			if (!p)
> -				continue;
> +				p = idle_sched_class.pick_task(rq_i);
> +		}
>  
> -			if (!is_task_rq_idle(p))
> -				occ++;
> +		rq_i->core_pick = p;
>  
> -			rq_i->core_pick = p;
> -			if (rq_i->idle == p && rq_i->nr_running) {
> +		if (p == rq_i->idle) {
> +			if (rq_i->nr_running) {
>  				rq->core->core_forceidle = true;
>  				if (!fi_before)
>  					rq->core->core_forceidle_seq++;
>  			}
> -
> -			/*
> -			 * If this new candidate is of higher priority than the
> -			 * previous; and they're incompatible; we need to wipe
> -			 * the slate and start over. pick_task makes sure that
> -			 * p's priority is more than max if it doesn't match
> -			 * max's cookie.
> -			 *
> -			 * NOTE: this is a linear max-filter and is thus bounded
> -			 * in execution time.
> -			 */
> -			if (!max || !cookie_match(max, p)) {
> -				struct task_struct *old_max = max;
> -
> -				rq->core->core_cookie = p->core_cookie;
> -				max = p;
> -
> -				if (old_max) {
> -					rq->core->core_forceidle = false;
> -					for_each_cpu(j, smt_mask) {
> -						if (j == i)
> -							continue;
> -
> -						cpu_rq(j)->core_pick = NULL;
> -					}
> -					occ = 1;
> -					goto again;
> -				}
> -			}
> +		} else {
> +			occ++;
>  		}
>  	}
>  
> @@ -5643,7 +5576,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  	 * non-matching user state.
>  	 */
>  	for_each_cpu(i, smt_mask) {
> -		struct rq *rq_i = cpu_rq(i);
> +		rq_i = cpu_rq(i);
>  
>  		/*
>  		 * An online sibling might have gone offline before a task
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index d9f8d73a1d84..0760b460903a 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1091,6 +1091,7 @@ struct rq {
>  	/* per rq */
>  	struct rq		*core;
>  	struct task_struct	*core_pick;
> +	struct task_struct	*core_temp;
>  	unsigned int		core_enabled;
>  	unsigned int		core_sched_seq;
>  	struct rb_root		core_tree;




Thanks,
Tao
