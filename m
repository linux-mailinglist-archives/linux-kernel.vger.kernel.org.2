Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF5832ED89
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 15:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhCEO6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 09:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCEO5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 09:57:44 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF19C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 06:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KjvStrDj1hJmi/Ln7oZnXQejmbNwdt1RwNl7hE4wctM=; b=i8JzMNfYYpCtOBWNtYG8KSEqPD
        sAAEWqY9qCLiZb8fkcaQ1+4/iBP4C9GEca3OrZinUCELz/CZj3My37g/gO6Nj29KvLxR+C00pT3rD
        kAq6HVghFJFFrU/HMCAejUvOXjkOzpMwmbWjux0LJE2lTdMRvmr3+qwchN6qDT+R8j1l9unqw+g3q
        TIyr/xsHm8WnjJFkvn8KSsQLSy3eo9/GOWN1yBuQkfSBds0Emppp/KRw9I5gAsgU3Yw85jdMOZ/lO
        WJlLvj7V0TtTKLLj11jWnhbt4iXHBSjaAmDkd3B65gWc/0yz/ZkP6euJow4+LIAZHAKjDNkasVUZy
        MZQHU6Dg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lIBsi-00FMro-V7; Fri, 05 Mar 2021 14:56:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9E0A630011C;
        Fri,  5 Mar 2021 15:56:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F09A203D8A49; Fri,  5 Mar 2021 15:56:43 +0100 (CET)
Date:   Fri, 5 Mar 2021 15:56:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, swood@redhat.com,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: Re: [PATCH v4 15/19] sched: Fix migrate_disable() vs rt/dl balancing
Message-ID: <YEJGq3aKM9lfYked@hirez.programming.kicks-ass.net>
References: <20201023101158.088940906@infradead.org>
 <20201023102347.499155098@infradead.org>
 <20201226135445.gkxfn5lmbxhblnj4@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201226135445.gkxfn5lmbxhblnj4@e107158-lin>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 26, 2020 at 01:54:45PM +0000, Qais Yousef wrote:
> Hi Peter
> 
> Apologies for the late comments on the patch.

Ha!, it seems I too need to apologize for never having actually found
your reply ;-)

> On 10/23/20 12:12, Peter Zijlstra wrote:
> 
> [...]
> 
> > + * When a preempted task becomes elegible to run under the ideal model (IOW it
> > + * becomes one of the M highest priority tasks), it might still have to wait
> > + * for the preemptee's migrate_disable() section to complete. Thereby suffering
> > + * a reduction in bandwidth in the exact duration of the migrate_disable()
> > + * section.
> > + *
> > + * Per this argument, the change from preempt_disable() to migrate_disable()
> > + * gets us:
> > + *
> > + * - a higher priority tasks gains reduced wake-up latency; with preempt_disable()
> > + *   it would have had to wait for the lower priority task.
> > + *
> > + * - a lower priority tasks; which under preempt_disable() could've instantly
> > + *   migrated away when another CPU becomes available, is now constrained
> > + *   by the ability to push the higher priority task away, which might itself be
> > + *   in a migrate_disable() section, reducing it's available bandwidth.
> > + *
> > + * IOW it trades latency / moves the interference term, but it stays in the
> > + * system, and as long as it remains unbounded, the system is not fully
> > + * deterministic.
> 
> The idea makes sense but I'm worried about some implementation details.
> 
> Specifically:
> 
> 	* There's no guarantee the target CPU we're pushing to doesn't have
> 	  a lower priority task in migration_disabled too. So we could end up
> 	  having to push the task again. 

I'm not sure I follow, if the CPU we're pushing to has a
migrate_disable() task of lower priority we'll simply preempt it.

IIRC there's conditions for this push:

 1) we just did migrate_enable();
 2) the task below us also has migrate_disable();
 3) the task below us is actually higher priority than
    the lowest priority task currently running.

So at that point we shoot our high prio task away, and we aim it at the
lowest prio task.

In order to then shoot it away again, someone else needs to block to
make lower prio task we just preempted elegible again.

Still, possible I suppose.

>		Although unlikely in practice, but as
> 	  I see it the worst case scenario is unbounded here. The planets could
> 	  align perfectly for the higher priority task to spend the majority of
> 	  its time migrating between cpus that have low priority RT tasks in
> 	  migration_disabled regions.

I'm thinking it might be limited by the range of priorities. You need to
drop the prio on every round, and you can't keep on dropping priority
levels, at some point we've reached bottom.

> 	  We need to track migration disabled at rq level to fix this.
> 	  It might be necessary to track the priority levels that are in
> 	  migration_disabled too :-/

As a tie breaker, not sure it's worth it.

> 	* Since this is a voluntary migration, I think we should ensure it is
> 	  restricted to cpus_share_cache() to guarantee the price is minimal
> 	  and acceptable.

That might create conflicting goals wrt the SMP invariant (run the N
highest prio tasks).

> 	* The push is done via the stopper task; which will steal run time
> 	  and could contribute to worst case latency. I think it'd fine in
> 	  practice, but PREEMPT_RT folks will know better.
> 
> I think the combined effect of above could end up throwing off RT system
> designers who could find their high-priority-hard-RT task is missing its
> deadline to be nice to lower priority tasks who go often to migration_disabled
> regions.
> 
> I seem to remember Clark saying in last LPC that few us latency is not unheard
> of now.

Those people that care _that_ much typically set hard affinity for their
tasks.

> > +int push_cpu_stop(void *arg)
> > +{
> > +	struct rq *lowest_rq = NULL, *rq = this_rq();
> > +	struct task_struct *p = arg;
> > +
> > +	raw_spin_lock_irq(&p->pi_lock);
> > +	raw_spin_lock(&rq->lock);
> > +
> > +	if (task_rq(p) != rq)
> > +		goto out_unlock;
> > +
> > +	if (is_migration_disabled(p)) {
> > +		p->migration_flags |= MDF_PUSH;
> > +		goto out_unlock;
> > +	}
> > +
> > +	p->migration_flags &= ~MDF_PUSH;
> > +
> > +	if (p->sched_class->find_lock_rq)
> > +		lowest_rq = p->sched_class->find_lock_rq(p, rq);
> > +
> > +	if (!lowest_rq)
> > +		goto out_unlock;
> > +
> > +	// XXX validate p is still the highest prio task
> 
> The task_rq(p) could have left the migration_disabled region by now too. If we
> track that at rq level we could be able to do last minute check to bale out of
> this voluntary push.
> 
> I think we should check that the lowest_rq is not in migration_disabled region
> too otherwise the same task could end up here again.
> 
> Need to think more about it, but we might be able to get away with verifying
> task_rq(p)->curr and lowest_rq->curr aren't in migration disabled. The only
> worry I can think of now is that rq->curr is a similar task to this one. That
> is: a higher priority task that has preempted a migration_disabled region.
> 
> Verifying that task_cpu(p) and lowest_rq->cpu are in the same llc will help
> avoid a costly migration. After all this is a voluntary migration.
> 
> Once we do all these bale outs; we might need to rate limit another PULL
> triggering this continuously. Need to dig more into that.

So we have:

	CPU0		CPU1

	M-preempted	L-running
	H-running

And normally we'd have pushed M, but it can't since it have
migration_disabled(). Moving H over L is the next best thing.

> > +	if (task_rq(p) == rq) {
> > +		deactivate_task(rq, p, 0);
> > +		set_task_cpu(p, lowest_rq->cpu);
> > +		activate_task(lowest_rq, p, 0);
> > +		resched_curr(lowest_rq);
> > +	}
> > +
> > +	double_unlock_balance(rq, lowest_rq);
> > +
> > +out_unlock:
> > +	rq->push_busy = false;
> > +	raw_spin_unlock(&rq->lock);
> > +	raw_spin_unlock_irq(&p->pi_lock);
> > +
> > +	put_task_struct(p);
> > +	return 0;
> > +}
> 
> [...]
> 
> > +static inline struct task_struct *get_push_task(struct rq *rq)
> > +{
> > +	struct task_struct *p = rq->curr;
> 
> Shouldn't we verify the class of the task here? The RT task in migration
> disabled could have been preempted by a dl or stopper task. Similarly, the dl
> task could have been preempted by a stopper task.
> 
> I don't think an RT task should be allowed to push a dl task under any
> circumstances?

Hmm, quite. Fancy doing a patch?
