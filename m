Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF06414FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 20:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237029AbhIVSY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 14:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbhIVSYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 14:24:25 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121FBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 11:22:55 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id d207so13298620qkg.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 11:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eltljisKCMoPGIKmO0hGRHj57MDUQIDS35Vhb3w01jI=;
        b=joDkyWxucYTKljQkiS9DPgrT78MIAiSHrAUg/kTGDPEqZ4ZkuH5XxF+YaD/JcngIbp
         WcL0NPbSD6wdVk1KQWFmiebUOeRNi/udYS0AjAhT+RhXGuAab+0cdx3CuuftDAhrR6uQ
         MvuSB2lcc+2opf93hRmyLK7pA7IYeAFV1PLzgbP8c3d0er+893IkKs3VPIlFquw2h/lx
         ghNK7vyKv3N0kWwObmy+nxr3X9E9FUk7hrkd8Tpmhb7b+OAeJBsDAj4egjrWDCo4JPyH
         ymWnZztVerewFAI7z2wzyfQ6q0LS43kt+YgqBCVxQzR/mK5i4G5PqhDo2UqH1HJtGJYB
         OC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eltljisKCMoPGIKmO0hGRHj57MDUQIDS35Vhb3w01jI=;
        b=MXe8RvfF2p4Twzhqw7Ft07Ju/TL0etEIIw5LQzVCI5/dnSvE4TSeswt32zfgVHL6aC
         4LKb+oRwSVJDQBsWgo29gVcqpSCLt27le8RHoyUJ1S5I7yXsFDKgp4gzFeH7rXfIctEO
         KyznUJrG+6zXc/dC32EyhKGyJJKTtFnfMn+QNIsz4k4cHeHDAlpv/Bc8iyHcFnBas9rA
         2+p2Mev9CmH/NY1BW3mQFvwIqIdKNe57IDPdgMcNOnAPucK29XXYkk0STuMIdgh3zcH1
         LXk6tdeHD9SMarxeb1u86Kd+4xIM8ght5RyHPOCZbv5I9jr7J0uAcvNipZ5haokBzIR3
         HIVw==
X-Gm-Message-State: AOAM533w5vZ8II9Q25nfURS2kROep9jW1mcwlEk0vKTrog7sZN1s+t/L
        RZoMgE5gyQliOTxBH94qYif5JKMKVNQCtUII4num7Q==
X-Google-Smtp-Source: ABdhPJz9PL1sK8PIQoxWIdAFwDZg4Xa42glDku7g02opgSpic30z9q6cAc9oRD+CROphtr3l+3nsUOrmoPgTIUwW5mQ=
X-Received: by 2002:a25:9001:: with SMTP id s1mr622262ybl.191.1632334974079;
 Wed, 22 Sep 2021 11:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210920142614.4891-1-mgorman@techsingularity.net>
 <20210920142614.4891-3-mgorman@techsingularity.net> <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
 <20210921103621.GM3959@techsingularity.net> <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
 <20210922132002.GX3959@techsingularity.net> <CAKfTPtCxhzz1XgNXM8jaQC2=tGHm0ap88HneUgWTpCSeWVZwsw@mail.gmail.com>
 <20210922150457.GA3959@techsingularity.net> <CAKfTPtB3tXwBZ_tVaDdiwMt-=sGH1iV6eUV6Rsnpw7q=tEpBwA@mail.gmail.com>
 <20210922173853.GB3959@techsingularity.net>
In-Reply-To: <20210922173853.GB3959@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 22 Sep 2021 20:22:43 +0200
Message-ID: <CAKfTPtDc39fCLbQqA2BhC6dsb+MyYYMdk9HUvrU0fRqULuQB-g@mail.gmail.com>
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

On Wed, 22 Sept 2021 at 19:38, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Wed, Sep 22, 2021 at 06:00:56PM +0200, Vincent Guittot wrote:
> > On Wed, 22 Sept 2021 at 17:04, Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > On Wed, Sep 22, 2021 at 04:15:27PM +0200, Vincent Guittot wrote:
> > > > > ---8<---
> > > > > sched/fair: Scale wakeup granularity relative to nr_running
> > > > >
> > > > > Commit 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs") moved
> > > > > the kernel.sched_wakeup_granularity_ns sysctl under debugfs.  One of the
> > > > > reasons why this sysctl may be used may be for "optimising for throughput",
> > > > > particularly when overloaded. The tool TuneD sometimes alters this for two
> > > > > profiles e.g. "mssql" and "throughput-performance". At least version 2.9
> > > > > does but it changed in master where it also will poke at debugfs instead.
> > > > >
> > > > > Internal parameters like sysctl_sched_wakeup_granularity are scaled
> > > > > based on the number of CPUs due to sysctl_sched_tunable_scaling. For
> > > > > simplicity, the timing figures in this changelog are based on
> > > > > SCHED_TUNABLESCALING_NONE.
> > > >
> > > > This is a bit misleading because the platform that you used to
> > > > highlight the problem has a 7ms sysctl_sched_wakeup_granularity. which
> > > > is far more than your tick which should be 1ms
> > > >
> > >
> > > Tick on the test machines is 4ms (HZ=250).
> > >
> > > The reason I used SCHED_TUNABLESCALING_NONE for the changelog is that
> > > the exact values depend on the number of CPUs so values are not even
> > > the same across the range of machines I'm using. sysctl_sched_latency,
> > > sysctl_sched_min_granularity sysctl_sched_wakeup_granularity are all
> > > scaled but the ratios remain constant.
> >
> > My point was mainly that sysctl_sched_wakeup_granularity is above the
> > tick period
> >
>
> Ok. sysctl_sched_wakeup_granularity is not related to the tick but I'm
> probably missing something else.
>
> > > > Also do you want to take into account only tasks in this cfs and its
> > > > children or on all cfs on this rq ?
> > > >
> > >
> > > Only this cfq I think to limit overhead.
> > >
> > > > > +                       return sysctl_sched_wakeup_granularity;
> > > > > +
> > > > > +               return sysctl_sched_latency;
> > > > > +       }
> > > > > +
> > > > > +       /* GENTLE_FAIR_SLEEPER has two overloaded thresholds. */
> > > > > +       nr_running = cfs_rq->nr_running;
> > > > > +       threshold = sched_nr_disable_gran >> 1;
> > > > > +
> > > > > +       /* No overload. */
> > > > > +       if (nr_running <= threshold)
> >
> > The comment was originally for this
> > nr_running does not reflect the number of task running on the cpu and
> > the associated overload state
> >
> > If you put 2 hackbench in their own cgroup, nr_running will be 2 but
> > you will have twice more runnable threads
> >
>
> Ok, that's understood. FWIW, I had switched to h_nr_running already.
>
> > > > > +
> > > > > +       /* Light overload. */
> > > > > +       if (nr_running <= sched_nr_disable_gran)
> > > > > +               return sysctl_sched_latency >> 1;
> > > > > +
> > > > > +       /* Heavy overload. */
> > > > > +       return sysctl_sched_latency;
> > > >
> > > > Why should a thread without any relationship with the curr,  not
> > > > preempt it because there are already a lot of running threads?
> > >
> > > Preemption is not free, without any knowledge of what the thread is
> > > doing, we cannot determine if an inappropriate amount of CPU time is
> > > being spent dequeueing/enqueuing tasks.
> >
> > That's exactly my point. The heuristic above doesn't give any clue if
> > the thread should or not preempt the current one. Most of the time
> > there is no relation with the number of the running threads but it is
> > define by the workload itself and its level of interactivity
> >
>
> Right albeit it ignores the possibility that there are multiple workloads
> overloading the machine wasting even more time preempting.  Whether that
> is due to a bad application, a bad configuration or a bad actor is anyones
> guess. I've seen applications with multiple worker threads which generally
> behaved ok, except when they didn't and too many worker threads were
> spawned due to a spike in server load. I'm not
>
> > >
> > > > In
> > > > your case, you want hackbench threads to not preempt each others
> > > > because they tries to use same resources so it's probably better to
> > > > let the current one to move forward but that's not a universal policy.
> > > >
> > >
> > > No, but have you a better suggestion? hackbench might be stupid but it's
> > > an example of where a workload can excessively preempt itself. While
> > > overloading an entire machine is stupid, it could also potentially occurs
> > > for applications running within a constrained cpumask.
> >
> > But this is property that is specific to each application. Some can
> > have a lot of running threads but few wakes up which have to preempt
> > current threads quickly but others just want the opposite
> > So because it is a application specific property we should define it
> > this way instead of trying to guess
>
> I'm not seeing an alternative suggestion that could be turned into
> an implementation. The current value for sched_wakeup_granularity
> was set 12 years ago was exposed for tuning which is no longer
> the case. The intent was to allow some dynamic adjustment between
> sysctl_sched_wakeup_granularity and sysctl_sched_latency to reduce
> over-scheduling in the worst case without disabling preemption entirely
> (which the first version did).
>
> Should we just ignore this problem and hope it goes away or just let
> people keep poking silly values into debugfs via tuned?

We should certainly not add a bandaid because people will continue to
poke silly value at the end. And increasing
sysctl_sched_wakeup_granularity based on the number of running threads
is not the right solution. According to the description of your
problem that the current task doesn't get enough time to move forward,
sysctl_sched_min_granularity should be part of the solution. Something
like below will ensure that current got a chance to move forward

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9bf540f04c2d..39d4e4827d3d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7102,6 +7102,7 @@ static void check_preempt_wakeup(struct rq *rq,
struct task_struct *p, int wake_
        int scale = cfs_rq->nr_running >= sched_nr_latency;
        int next_buddy_marked = 0;
        int cse_is_idle, pse_is_idle;
+       unsigned long delta_exec;

        if (unlikely(se == pse))
                return;
@@ -7161,6 +7162,13 @@ static void check_preempt_wakeup(struct rq *rq,
struct task_struct *p, int wake_
                return;

        update_curr(cfs_rq_of(se));
+       delta_exec = se->sum_exec_runtime - se->prev_sum_exec_runtime;
+       /*
+        * Ensure that current got a chance to move forward
+        */
+       if (delta_exec < sysctl_sched_min_granularity)
+               return;
+
        if (wakeup_preempt_entity(se, pse) == 1) {
                /*
                 * Bias pick_next to pick the sched entity that is


>
> --
> Mel Gorman
> SUSE Labs
