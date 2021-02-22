Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF770321D13
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 17:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhBVQdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 11:33:54 -0500
Received: from foss.arm.com ([217.140.110.172]:55640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230349AbhBVQby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:31:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 204C91FB;
        Mon, 22 Feb 2021 08:31:08 -0800 (PST)
Received: from e124901.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41A3E3F73B;
        Mon, 22 Feb 2021 08:31:06 -0800 (PST)
Date:   Mon, 22 Feb 2021 16:31:08 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com
Subject: Re: [PATCH] sched/fair: Fix task utilization accountability in
 cpu_util_next()
Message-ID: <20210222163108.GA225035@e124901.cambridge.arm.com>
References: <20210222095401.37158-1-vincent.donnefort@arm.com>
 <YDODN1rnTqfTQOug@google.com>
 <20210222113602.GA286874@e120877-lin.cambridge.arm.com>
 <YDOiKH/XQDUKcrPU@google.com>
 <20210222150151.GA124800@e124901.cambridge.arm.com>
 <YDPUwKKYgZfzzCJm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDPUwKKYgZfzzCJm@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 03:58:56PM +0000, Quentin Perret wrote:
> On Monday 22 Feb 2021 at 15:01:51 (+0000), Vincent Donnefort wrote:
> > You mean that it could lead to a wrong frequency estimation when doing
> > freq = map_util_freq() in em_cpu_energy()?
> 
> I'm not too worried about the map_util_freq() part, I'm worried about
> the schedutil aggregation. Specifically, when a task is enqueued on a
> rq, we sum its util_avg to the rq's util_avg, and the _task_util_est()
> to the rq's util_est.enqueue member (as per util_est_enqueue()).
> 
> Now, in schedutil, sugov_get_util() calls cpu_util_cfs(), which does the
> following:
> 
> 	static inline unsigned long cpu_util_cfs(struct rq *rq)
> 	{
> 		unsigned long util = READ_ONCE(rq->cfs.avg.util_avg);
> 
> 		if (sched_feat(UTIL_EST)) {
> 			util = max_t(unsigned long, util,
> 				     READ_ONCE(rq->cfs.avg.util_est.enqueued));
> 		}
> 
> 		return util;
> 	}
> 
> And that value will be the base for frequency selection. cpu_util_next()
> tries to mimic this as accurately as possible, by doing the sums
> independently, and then computing the max, exactly as we will do when
> the task is enqueued and a freq update is generated.
> 
> > But in any case, the computed energy, being the product of sum_util with the
> > OPP's cost, it is directly affected by this util_avg/util_est difference.
> 
> Sure, but we're not going to fix it by messing up the OPP selection part ;-)
> 
> > In the case where the task placement doesn't change the OPP, which is often the
> > case, we can simplify the comparison and end-up with the following:
> > 
> >   delta_energy(CPU-3): OPP3 cost * (cpu_util_avg + task_util_avg - cpu_util_avg)
> >   delta_energy(CPU-2): OPP2 cost * (cpu_util_est + task_util_est - cpu_util_est)
> > 
> >   => OPP3 cost * task_util_avg < task_util_est * OPP2 cost
> > 
> > With the same example I described previously, if you add the scaled OPP cost of
> > 0.76 for CPU-3 and 0.65 for CPU-2 (real life OPP scaled costs), we have:
> > 
> >   2.3 (CPU-3) < 7.15 (CPU-2)
> > 
> > The task is placed on CPU-3, while it would have been much more efficient to use
> > CPU-2.
> 
> That should really be a transient state: having a util_avg much larger
> than util_est.enqueued is indicative of either a new task or a workload
> changing behaviour. And so, chances are all the estimations are wrong
> anyways -- it's hard to do good estimations when the present doesn't
> look like the recent past.

Not really a transient state sadly. This problem could happen with several tasks.
All of them ending-up on the same CPU, they'll keep its util_avg high enough,
while others will starve by being stuck with the task_util_est usage.

> 
> But in any case, if we're going to address this, I'm still not sure this
> patch will be what we want. As per my first comment we need to keep the
> frequency estimation right.

No indeed, there's still a util_est/util_avg mix-up in this proposal too. For a
CPU with util_avg > util_est, we would use the CPU's util_avg and the task's
util_est, which doesn't reflect the "real" util.

I suppose, a way of fixing this, is to keep cpu_util_next() the way it is to
get the appropriate frequency at which the CPU would run once the task has been
enqueued, for the 'max_util', and have 'sum_util' being the sum of the pd's util
(without the task) + task_util_est().

Thoughts?

--
Vincent

> 
> > > > When computing the energy
> > > > deltas, pd0's is likely to be higher than pd1's, only because the task
> > > > contribution is higher for one comparison than the other.
> > > 
> > > You mean the contribution to sum_util right? I think I see what you mean
> > > but I'm still not sure if this really is an issue. This is how util_est
> > > works, and the EM stuff is just consistent with that.
> > > 
> > > The issue you describe can only happen (I think) when a rq's util_avg is
> > > larger than its util-est emwa by some margin (that has to do with the
> > > ewma-util_avg delta for the task?). But that means the ewma is not to be
> > > trusted to begin with, so ...
> > 
> > cfs_rq->avg.util_est.ewma is not used. cpu_util() will only return the max
> > between ue.enqueued and util_avg.
> 
> Right, my bad, it was the 'enqueued' member. But the rest of the
> argument is still valid I think, but with s/ewma/enqueued :-)
> 
> Thanks,
> Quentin
