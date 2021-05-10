Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F628378A82
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 14:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbhEJLp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 07:45:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232425AbhEJK6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:58:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 050B96194E;
        Mon, 10 May 2021 10:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620643941;
        bh=zisSpLmXvGj0wWL2cVNivIspnQewVlGp4zkqiChOCjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PMl1HMKs+oMX21taoygwNCfen2Egc6IDsYYZ0bNbgAkv15NcmAKYVtr6Kq+THXKM5
         40JpnSq58+sitaPVb+pLJUtcqivHfbErETauEPF1PPjwEOVnpy0CdUEFXsZz7JrJeU
         5MS6PF1n4Fpr2fWDuyXVoa7j9790GFR9tcJ42XkcePPJPVSHmkCg3/HVvgYMTdGwfY
         WO7VLiJ2ac+zwHTFI/A+ZVOft5oYRke8Sm0xwLnJxX+sZIKboEj9m3mVS58vJ6vzlA
         zEHJTMjPUUckEKNxZbB8LFQUNnOw9+WR+ea0HMegeDbjz1j9z21X7zsnjwsWiW/s4T
         5TFBkqWpiggdQ==
Date:   Mon, 10 May 2021 12:52:19 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>
Subject: Re: [PATCH 8/8] tick/nohz: Kick only _queued_ task whose tick
 dependency is updated
Message-ID: <20210510105219.GB97481@lothringen>
References: <20210422120158.33629-1-frederic@kernel.org>
 <20210422120158.33629-9-frederic@kernel.org>
 <YJKkNJTQFtmQPv1u@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJKkNJTQFtmQPv1u@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 03:57:08PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 22, 2021 at 02:01:58PM +0200, Frederic Weisbecker wrote:
> 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 98191218d891..08526227d200 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1580,6 +1580,11 @@ static inline void uclamp_post_fork(struct task_struct *p) { }
> >  static inline void init_uclamp(void) { }
> >  #endif /* CONFIG_UCLAMP_TASK */
> >  
> > +bool sched_task_on_rq(struct task_struct *p)
> > +{
> > +	return task_on_rq_queued(p);
> > +}
> > +
> >  static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
> >  {
> >  	if (!(flags & ENQUEUE_NOCLOCK))
> 
> That's a wee bit sad..

I know... But I couldn't find a better way.

> 
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index ad5c3905196a..faba7881048f 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -324,8 +324,6 @@ void tick_nohz_full_kick_cpu(int cpu)
> >  
> >  static void tick_nohz_kick_task(struct task_struct *tsk)
> >  {
> > -	int cpu = task_cpu(tsk);
> > -
> >  	/*
> >  	 * If the task concurrently migrates to another cpu,
> >  	 * we guarantee it sees the new tick dependency upon
> > @@ -340,6 +338,23 @@ static void tick_nohz_kick_task(struct task_struct *tsk)
> >  	 *   tick_nohz_task_switch()            smp_mb() (atomic_fetch_or())
> >  	 *      LOAD p->tick_dep_mask           LOAD p->cpu
> >  	 */
> > +	int cpu = task_cpu(tsk);
> > +
> > +	/*
> > +	 * If the task is not running, run_posix_cpu_timers
> > +	 * has nothing to elapsed, can spare IPI in that
> > +	 * case.
> > +	 *
> > +	 * activate_task()                      STORE p->tick_dep_mask
> > +	 * STORE p->on_rq
> > +	 * __schedule() (switch to task 'p')    smp_mb() (atomic_fetch_or())
> > +	 * LOCK rq->lock                        LOAD p->on_rq
> > +	 * smp_mb__after_spin_lock()
> > +	 * tick_nohz_task_switch()
> > +	 *	LOAD p->tick_dep_mask
> > +	 */
> 
> That needs indenting, the style is distinctly different from the comment
> right above it.

Ok, I'll fix that.

> 
> > +	if (!sched_task_on_rq(tsk))
> > +		return;
> 
> I'm too tired, but do we really need the task_cpu() load to be before
> this?

Nope, it should be fine to put it after.

Thanks!

> 
> >  
> >  	preempt_disable();
> >  	if (cpu_online(cpu))
> > -- 
> > 2.25.1
> > 
