Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3699A32F05D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 17:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhCEQt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 11:49:27 -0500
Received: from foss.arm.com ([217.140.110.172]:56948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229882AbhCEQsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 11:48:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6535C12FC;
        Fri,  5 Mar 2021 08:48:54 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 499293F766;
        Fri,  5 Mar 2021 08:48:52 -0800 (PST)
Date:   Fri, 5 Mar 2021 16:48:50 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, swood@redhat.com,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: Re: [PATCH v4 15/19] sched: Fix migrate_disable() vs rt/dl balancing
Message-ID: <20210305164850.zhjh7ho3uk4ulvov@e107158-lin.cambridge.arm.com>
References: <20201023101158.088940906@infradead.org>
 <20201023102347.499155098@infradead.org>
 <20201226135445.gkxfn5lmbxhblnj4@e107158-lin>
 <YEJGq3aKM9lfYked@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YEJGq3aKM9lfYked@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/21 15:56, Peter Zijlstra wrote:
> On Sat, Dec 26, 2020 at 01:54:45PM +0000, Qais Yousef wrote:
> > Hi Peter
> > 
> > Apologies for the late comments on the patch.
> 
> Ha!, it seems I too need to apologize for never having actually found
> your reply ;-)

No worries, thanks for taking the time to answer! :-)

> 
> > On 10/23/20 12:12, Peter Zijlstra wrote:
> > 
> > [...]
> > 
> > > + * When a preempted task becomes elegible to run under the ideal model (IOW it
> > > + * becomes one of the M highest priority tasks), it might still have to wait
> > > + * for the preemptee's migrate_disable() section to complete. Thereby suffering
> > > + * a reduction in bandwidth in the exact duration of the migrate_disable()
> > > + * section.
> > > + *
> > > + * Per this argument, the change from preempt_disable() to migrate_disable()
> > > + * gets us:
> > > + *
> > > + * - a higher priority tasks gains reduced wake-up latency; with preempt_disable()
> > > + *   it would have had to wait for the lower priority task.
> > > + *
> > > + * - a lower priority tasks; which under preempt_disable() could've instantly
> > > + *   migrated away when another CPU becomes available, is now constrained
> > > + *   by the ability to push the higher priority task away, which might itself be
> > > + *   in a migrate_disable() section, reducing it's available bandwidth.
> > > + *
> > > + * IOW it trades latency / moves the interference term, but it stays in the
> > > + * system, and as long as it remains unbounded, the system is not fully
> > > + * deterministic.
> > 
> > The idea makes sense but I'm worried about some implementation details.
> > 
> > Specifically:
> > 
> > 	* There's no guarantee the target CPU we're pushing to doesn't have
> > 	  a lower priority task in migration_disabled too. So we could end up
> > 	  having to push the task again. 
> 
> I'm not sure I follow, if the CPU we're pushing to has a
> migrate_disable() task of lower priority we'll simply preempt it.
> 
> IIRC there's conditions for this push:
> 
>  1) we just did migrate_enable();
>  2) the task below us also has migrate_disable();
>  3) the task below us is actually higher priority than
>     the lowest priority task currently running.
> 
> So at that point we shoot our high prio task away, and we aim it at the
> lowest prio task.
> 
> In order to then shoot it away again, someone else needs to block to
> make lower prio task we just preempted elegible again.

Okay. I missed that 3rd condition. I understood only 1 and 2 are required.
So we have to have 3 tasks of different priorities on the rq, the middle being
in migrate_disabled.

It is less of a problem in that case.

> 
> Still, possible I suppose.
> 
> >		Although unlikely in practice, but as
> > 	  I see it the worst case scenario is unbounded here. The planets could
> > 	  align perfectly for the higher priority task to spend the majority of
> > 	  its time migrating between cpus that have low priority RT tasks in
> > 	  migration_disabled regions.
> 
> I'm thinking it might be limited by the range of priorities. You need to
> drop the prio on every round, and you can't keep on dropping priority
> levels, at some point we've reached bottom.

With that 3rd condition in mind, there has to be an element of bad design to
end up with 3 tasks of different priorities on 1 rq that continuously. The
system has to be in some sort of overloaded state, which is a bigger problem to
address first.

> > > +static inline struct task_struct *get_push_task(struct rq *rq)
> > > +{
> > > +	struct task_struct *p = rq->curr;
> > 
> > Shouldn't we verify the class of the task here? The RT task in migration
> > disabled could have been preempted by a dl or stopper task. Similarly, the dl
> > task could have been preempted by a stopper task.
> > 
> > I don't think an RT task should be allowed to push a dl task under any
> > circumstances?
> 
> Hmm, quite. Fancy doing a patch?

I had one. Let me revive and post it next week.

Thanks

--
Qais Yousef
