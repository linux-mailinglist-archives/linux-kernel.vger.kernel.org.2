Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4001232536E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhBYQYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:24:34 -0500
Received: from foss.arm.com ([217.140.110.172]:39490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230201AbhBYQY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:24:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A71CD6E;
        Thu, 25 Feb 2021 08:23:43 -0800 (PST)
Received: from e124901.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81EBD3F73D;
        Thu, 25 Feb 2021 08:23:41 -0800 (PST)
Date:   Thu, 25 Feb 2021 16:23:46 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, qperret@google.com,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com
Subject: Re: [PATCH v2 1/2] sched/fair: Fix task utilization accountability
 in compute_energy()
Message-ID: <20210225162346.GB1345245@e124901.cambridge.arm.com>
References: <20210225083612.1113823-1-vincent.donnefort@arm.com>
 <20210225083612.1113823-2-vincent.donnefort@arm.com>
 <f2f5cf8e-3a0b-7192-5293-bad576e7066b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2f5cf8e-3a0b-7192-5293-bad576e7066b@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 12:45:06PM +0100, Dietmar Eggemann wrote:
> On 25/02/2021 09:36, vincent.donnefort@arm.com wrote:
> > From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> [...]
> 
> > cpu_util_next() estimates the CPU utilization that would happen if the
> > task was placed on dst_cpu as follows:
> > 
> >   max(cpu_util + task_util, cpu_util_est + _task_util_est)
> > 
> > The task contribution to the energy delta can then be either:
> > 
> >   (1) _task_util_est, on a mostly idle CPU, where cpu_util is close to 0
> >       and _task_util_est > cpu_util.
> >   (2) task_util, on a mostly busy CPU, where cpu_util > _task_util_est.
> > 
> >   (cpu_util_est doesn't appear here. It is 0 when a CPU is idle and
> >    otherwise must be small enough so that feec() takes the CPU as a
> >    potential target for the task placement)
> 
> I still don't quite get the reasoning for (2) why task_util is used as
> task contribution.
> 
> So we use 'cpu_util + task_util' instead of 'cpu_util_est +
> _task_util_est' in (2).
> 
> I.e. since _task_util_est is always >= task_util during wakeup, cpu_util
> must be > cpu_util_est (by more than _task_util_est - task_util).
> 
> I can see it for a CPU whose cpu_util has a fair amount of contributions
> from blocked tasks which cpu_util_est wouldn't have.
> 
> [...]

Yes exactly. I discovered this issue in a trace where an overutilized happened.
Many tasks were migrated to the biggest CPU, but once EAS was back on, it was too
late. The big CPU had a high util_avg and the task_util _task_util_est
unfairness kept placing tasks on that one, despite being inefficient. All the
tasks enqueued on that CPU were enough to keep util_avg high enough and that
situation wasn't resolving.

> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 7043bb0f2621..146ac9fec4b6 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6573,8 +6573,24 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
> >  	 * its pd list and will not be accounted by compute_energy().
> >  	 */
> >  	for_each_cpu_and(cpu, pd_mask, cpu_online_mask) {
> > -		unsigned long cpu_util, util_cfs = cpu_util_next(cpu, p, dst_cpu);
> > -		struct task_struct *tsk = cpu == dst_cpu ? p : NULL;
> > +		unsigned long util_freq = cpu_util_next(cpu, p, dst_cpu);
> > +		unsigned long cpu_util, util_running = util_freq;
> > +		struct task_struct *tsk = NULL;
> > +
> > +		/*
> > +		 * When @p is placed on @cpu:
> > +		 *
> > +		 * util_running = max(cpu_util, cpu_util_est) +
> > +		 *		  max(task_util, _task_util_est)
> > +		 *
> > +		 * while cpu_util_next is: max(cpu_util + task_util,
> > +		 *			       cpu_util_est + _task_util_est)
> > +		 */
> 
> Nit pick:
> 
> s/on @cpu/on @dst_cpu ?

I meant @cpu. When dst_cpu == cpu, it means that we simulate the task being
placed on cpu. That's what I wanted to highlight. But I can remove it if you
think this is not necessary.

> 
> s/while cpu_util_next is/while cpu_util_next(cpu, p, cpu) would be
> 
> If dst_cpu != cpu (including dst_cpu == -1) task_util and _task_util_est
> are not added to util resp. util_est.
> 
> Not sure if this is clear from the source code here?
> 
> [...]
> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
