Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18686414DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 18:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbhIVQCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 12:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhIVQCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 12:02:39 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BC6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 09:01:09 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b65so10953525qkc.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RPv2WZicrR5YMPpzmRMa8NxYQjR5omyRRthly9yS2vM=;
        b=fkr9rvYkK2n6nj58ct+a1C4vSEiHt1lCZ32XNOP2aPfM9EnqcAS4kVq6aaLADmlP2J
         C58dFlx+B1Nv+9BlIBulbFRaMMIrv1uF9m8z4PHUzYCcsh4ILyD8kbG2zhNFrYw+RD4A
         IC4Dmh/bzTExxw5ZKE1Fiqe1fY7xf/wtRptkEcT1attAanJvQ2IAUf7qsQKKI9gvKOrB
         RlzNAewR7RZ00Tl4rAJbqeY2EWzVwuhsg4M3nyh2i/49EH/f2ZfTanR14WaMhltq8bHv
         wR83QypCN21/TQG8m/uPyENZoDIjiGG+u0MIz2OnET1GukE4xcxBgI0WW2U6zteQFo4T
         u+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RPv2WZicrR5YMPpzmRMa8NxYQjR5omyRRthly9yS2vM=;
        b=tv0hg1aDUGX2Rby9Egs9Cgn9VZOlTWcoTYHcEgsGkgpGyWNAJL6rrjy6Y2NlkyxUc9
         42Nb3CMlwJWKXL8vAmxWcTVIG8MFIHPNn0UbfIKWeCaqeTz/2U8tdPuEAuFMjpn3YL5A
         neRArs22phuG9xUojPtzymmgy0Tn3bx6Fnk3qrdOfc0L4elKy3FrPKlJ0q5x1yfYDQE8
         Th3H6dWCt0adj7YQBEa551609mu9iuVf7M6K0V95W7hzT9U+r0w8NbZ0vb725Go4gKfO
         c486uOWKUahudWmVKfXcvZ8zgEqspIOLgui4OjrYoHe2Lbks34+HPasV8sn8wpYPTMbp
         ZAgw==
X-Gm-Message-State: AOAM531EGX/n0OSHbEUPzJYC+KPTgWt3Hs5odH5Y1XNxEg6MIhmC7h1P
        5jZUZ7Z/iRN1De+OxnFZNd4blOMB3UrefbalMKGX0w==
X-Google-Smtp-Source: ABdhPJzZwxmUEQV5hmUKUqrOAGfr26vwOSItNhZ4DqK8+6+joBIGm6Ck6R2+YGkt9uf094FRE2f+OIfm+fbALtK0TXQ=
X-Received: by 2002:a25:94e:: with SMTP id u14mr646165ybm.425.1632326468187;
 Wed, 22 Sep 2021 09:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210920142614.4891-1-mgorman@techsingularity.net>
 <20210920142614.4891-3-mgorman@techsingularity.net> <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
 <20210921103621.GM3959@techsingularity.net> <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
 <20210922132002.GX3959@techsingularity.net> <CAKfTPtCxhzz1XgNXM8jaQC2=tGHm0ap88HneUgWTpCSeWVZwsw@mail.gmail.com>
 <20210922150457.GA3959@techsingularity.net>
In-Reply-To: <20210922150457.GA3959@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 22 Sep 2021 18:00:56 +0200
Message-ID: <CAKfTPtB3tXwBZ_tVaDdiwMt-=sGH1iV6eUV6Rsnpw7q=tEpBwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to nr_running
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sept 2021 at 17:04, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Wed, Sep 22, 2021 at 04:15:27PM +0200, Vincent Guittot wrote:
> > > ---8<---
> > > sched/fair: Scale wakeup granularity relative to nr_running
> > >
> > > Commit 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs") moved
> > > the kernel.sched_wakeup_granularity_ns sysctl under debugfs.  One of the
> > > reasons why this sysctl may be used may be for "optimising for throughput",
> > > particularly when overloaded. The tool TuneD sometimes alters this for two
> > > profiles e.g. "mssql" and "throughput-performance". At least version 2.9
> > > does but it changed in master where it also will poke at debugfs instead.
> > >
> > > Internal parameters like sysctl_sched_wakeup_granularity are scaled
> > > based on the number of CPUs due to sysctl_sched_tunable_scaling. For
> > > simplicity, the timing figures in this changelog are based on
> > > SCHED_TUNABLESCALING_NONE.
> >
> > This is a bit misleading because the platform that you used to
> > highlight the problem has a 7ms sysctl_sched_wakeup_granularity. which
> > is far more than your tick which should be 1ms
> >
>
> Tick on the test machines is 4ms (HZ=250).
>
> The reason I used SCHED_TUNABLESCALING_NONE for the changelog is that
> the exact values depend on the number of CPUs so values are not even
> the same across the range of machines I'm using. sysctl_sched_latency,
> sysctl_sched_min_granularity sysctl_sched_wakeup_granularity are all
> scaled but the ratios remain constant.

My point was mainly that sysctl_sched_wakeup_granularity is above the
tick period

>
> > > <SNIP>
> > >  static int
> > > -wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se);
> > > +wakeup_preempt_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr,
> > > +                                               struct sched_entity *se);
> > >
> > >  /*
> > >   * Pick the next process, keeping these things in mind, in this order:
> > > @@ -4550,16 +4562,16 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> > >                                 second = curr;
> > >                 }
> > >
> > > -               if (second && wakeup_preempt_entity(second, left) < 1)
> > > +               if (second && wakeup_preempt_entity(NULL, second, left) < 1)
> >
> > Why not applying the same policy here ? the tick can also prevent
> > current task to move forward
> >
>
> Because it was less clear if it was necessary and what the consequences
> would be if the skip buddy ran or the next buddy failed to run because
> preempt failed, how does it interact with yield_to etc.
>
> I ended up concluding that they should be separate patches and keep this
> patch to one topic.
>
>
> > >                         se = second;
> > >         }
> > >
> > > -       if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1) {
> > > +       if (cfs_rq->next && wakeup_preempt_entity(NULL, cfs_rq->next, left) < 1) {
> > >                 /*
> > >                  * Someone really wants this to run. If it's not unfair, run it.
> > >                  */
> > >                 se = cfs_rq->next;
> > > -       } else if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1) {
> > > +       } else if (cfs_rq->last && wakeup_preempt_entity(NULL, cfs_rq->last, left) < 1) {
> > >                 /*
> > >                  * Prefer last buddy, try to return the CPU to a preempted task.
> > >                  */
> > > @@ -7044,9 +7056,42 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > >  }
> > >  #endif /* CONFIG_SMP */
> > >
> > > -static unsigned long wakeup_gran(struct sched_entity *se)
> > > +static unsigned long
> > > +select_wakeup_gran(struct cfs_rq *cfs_rq)
> > > +{
> > > +       unsigned int nr_running, threshold;
> > > +
> > > +       if (!cfs_rq || !sched_feat(SCALE_WAKEUP_GRAN))
> > > +               return sysctl_sched_wakeup_granularity;
> > > +
> > > +       /* !GENTLE_FAIR_SLEEPERS has one overload threshold. */
> > > +       if (!sched_feat(GENTLE_FAIR_SLEEPERS)) {
> > > +               if (cfs_rq->nr_running <= sched_nr_disable_gran)
> >
> > cfs_rq->nr_running reflects the number of sched entities in the cfs
> > but not the number of running tasks which reflected in h_nr_running
> >
>
> Then check_preempt_wakeup may also have the same problem as it uses
> nr_running.

This comment was originally for the use of cfs_rq->nr_running a bit more below

>
> > Also do you want to take into account only tasks in this cfs and its
> > children or on all cfs on this rq ?
> >
>
> Only this cfq I think to limit overhead.
>
> > > +                       return sysctl_sched_wakeup_granularity;
> > > +
> > > +               return sysctl_sched_latency;
> > > +       }
> > > +
> > > +       /* GENTLE_FAIR_SLEEPER has two overloaded thresholds. */
> > > +       nr_running = cfs_rq->nr_running;
> > > +       threshold = sched_nr_disable_gran >> 1;
> > > +
> > > +       /* No overload. */
> > > +       if (nr_running <= threshold)

The comment was originally for this
nr_running does not reflect the number of task running on the cpu and
the associated overload state

If you put 2 hackbench in their own cgroup, nr_running will be 2 but
you will have twice more runnable threads

> > > +               return sysctl_sched_wakeup_granularity;
> >
> > TBH I don't like these "no overload", "light overload" ...  They don't
> > have any real meaning apart from that it might work for your platform
> > and your hackbench test.
>
> They are, at best, a proxy measure for overload but the alternative is
> scanning a bunch of runqueues similar to what is required when detecting
> if a domain is fully busy or overloaded.
>
> > We already had have people complaining that small cfs task does not
> > preempt fast enough curr task as an example
> >
>
> Is there a specific test case that demonstrates this?
>
> > There is no explanation why these values are the correct ones and not
> > but are just some random heuristic results and we are trying to remove
> > platform heuristic and to not add new
> >
>
> They are a heuristic yes, but I'm trying to remove the motivation for
> users trying to tune sysctl_sched_wakeup_granularity to stupid values
> because as it stands, tuned will happily poke into debugfs despite the
> fact they are meant for debugging only and the values are of dubious merit.
>
> > > +
> > > +       /* Light overload. */
> > > +       if (nr_running <= sched_nr_disable_gran)
> > > +               return sysctl_sched_latency >> 1;
> > > +
> > > +       /* Heavy overload. */
> > > +       return sysctl_sched_latency;
> >
> > Why should a thread without any relationship with the curr,  not
> > preempt it because there are already a lot of running threads?
>
> Preemption is not free, without any knowledge of what the thread is
> doing, we cannot determine if an inappropriate amount of CPU time is
> being spent dequeueing/enqueuing tasks.

That's exactly my point. The heuristic above doesn't give any clue if
the thread should or not preempt the current one. Most of the time
there is no relation with the number of the running threads but it is
define by the workload itself and its level of interactivity

>
> > In
> > your case, you want hackbench threads to not preempt each others
> > because they tries to use same resources so it's probably better to
> > let the current one to move forward but that's not a universal policy.
> >
>
> No, but have you a better suggestion? hackbench might be stupid but it's
> an example of where a workload can excessively preempt itself. While
> overloading an entire machine is stupid, it could also potentially occurs
> for applications running within a constrained cpumask.

But this is property that is specific to each application. Some can
have a lot of running threads but few wakes up which have to preempt
current threads quickly but others just want the opposite
So because it is a application specific property we should define it
this way instead of trying to guess
>
> > side question: Have you try to change the nice priority which also
> > impact whether a thread can preempt curr ?
> >
>
> No, I have not tried. I guess one would be constructed with cyclictest
> -S running hackbench in the background and measuring if it makes a
> difference to the amount of jitter cyclictest experiences but I'm not
> sure if that would cover the case you are concerned with.
>
> > > +}
> > > +
> > > +static unsigned long
> > > +wakeup_gran(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > >  {
> > > -       unsigned long gran = sysctl_sched_wakeup_granularity;
> > > +       unsigned long gran = select_wakeup_gran(cfs_rq);
> > >
> > >         /*
> > >          * Since its curr running now, convert the gran from real-time
> > > @@ -7079,14 +7124,15 @@ static unsigned long wakeup_gran(struct sched_entity *se)
> > >   *
> > >   */
> > >  static int
> > > -wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
> > > +wakeup_preempt_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr,
> > > +                                               struct sched_entity *se)
> > >  {
> > >         s64 gran, vdiff = curr->vruntime - se->vruntime;
> > >
> > >         if (vdiff <= 0)
> > >                 return -1;
> > >
> > > -       gran = wakeup_gran(se);
> > > +       gran = wakeup_gran(cfs_rq, se);
> > >         if (vdiff > gran)
> > >                 return 1;
> > >
> > > @@ -7191,7 +7237,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
> > >                 return;
> > >
> > >         update_curr(cfs_rq_of(se));
> > > -       if (wakeup_preempt_entity(se, pse) == 1) {
> > > +       if (wakeup_preempt_entity(cfs_rq, se, pse) == 1) {
> >
> > like for update_curr above, cfs_rq can be wrong because se could have changed
> >
>
> Crap, that was a stupid mistake based on earlier review. I'll fix it.
>
> --
> Mel Gorman
> SUSE Labs
