Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A994B44FD24
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 03:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbhKOC21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 21:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhKOC1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 21:27:49 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D9EC061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 18:24:55 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id gu12so10341144qvb.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 18:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKSWxpIr3zViMwXzWHpUhtajLyKeIiM7AaaIXOUY46E=;
        b=HAAHptK8yUr2RfCi7gFPbSimiuK/fL1EYdE7BD/IG3IEovGjABrTVPWul9pG6OQkuA
         veE6s+FHeIs90EVkBISga89t/jvFzWEIJKHwcpi111dUEagYLCsT32hjA6WqYjtCOzT5
         mHX2sBSut3b95xd6KjS4AM8pevSsUbbCiBEXjBdtS93QgEPwiYiGC+lYG2vLbSnTQHkX
         m/dT3g9BJ0ZQFIy4VZjo902PtGh2EQP4E2M3bV+BuXK5oVOd35V5UWJjTW3Dt2oMelA9
         cbgzoq5mScnLjGLe67GhP2VT1VsOtz7dBCwF05CbcgMKKnUfg34SQhB+Dd4wsbjuugr4
         V04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKSWxpIr3zViMwXzWHpUhtajLyKeIiM7AaaIXOUY46E=;
        b=NQUJwZkYqlRxBv2lsvhD5Zq2vIVUc+mwkWV0k0+yLiilXjVdtIEa9fDq0EpLpHfyw1
         vVdtEhp2JQg532k5wNdFoTZDKQw5CBfl7DmVtX8tENZKbXIRz91ssuxwqbxT0Dbk3TfK
         1wTEqD0DpxxC9hjwZD8p+qUU29tPzoUbm6RR6RiWvIwX+XoSKkm6z5s03KASetmxEMU0
         F8tb4N4tGgN0ZaibaaY19KnS6z/2PdktKuWxYmPpiPQZFI1YCAX9lJBMT9ZsrEwvO06Q
         iSLkOrVbUocBHIpttdjN9nxj3Ph0nv0MoWdLd340otWxNYPcHitEqy6T6T9ihKSj9yef
         kM7Q==
X-Gm-Message-State: AOAM533fwFhFlTYNIYdVBVX0qGaUVa/O+PSJjEFR5Wv7yXjTZFqkTebJ
        kawCLWowVNWGkhJSBS9i4B6++PVAefDyC5+sROsW8eGZJqs=
X-Google-Smtp-Source: ABdhPJzlQFx8l1W2SjZV/u/Gduhwanko3nQFvNcW70G59NFPIFI/K5+MaLKYAy4DFfyoVsbaPVVGJ+XfIQDOg5duPQU=
X-Received: by 2002:a05:6214:d8e:: with SMTP id e14mr33545375qve.37.1636943093860;
 Sun, 14 Nov 2021 18:24:53 -0800 (PST)
MIME-Version: 1.0
References: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
 <YYGV1TxsZXzGXFmx@cmpxchg.org> <YYqMJLXcQ4a+Lh/4@hirez.programming.kicks-ass.net>
 <YY6X+HPS8A4sLEiO@cmpxchg.org>
In-Reply-To: <YY6X+HPS8A4sLEiO@cmpxchg.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 15 Nov 2021 10:24:32 +0800
Message-ID: <CAGWkznGhF4SNO9M8m=fNO78yqbVhQGmHLzcUqT0SLXeeNC4M7g@mail.gmail.com>
Subject: Re: [Resend PATCH] psi : calc cfs task memstall time more precisely
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, xuewen.yan@unisoc.com,
        Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2021 at 12:36 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Nov 09, 2021 at 03:56:36PM +0100, Peter Zijlstra wrote:
> > On Tue, Nov 02, 2021 at 03:47:33PM -0400, Johannes Weiner wrote:
> > > CC peterz as well for rt and timekeeping magic
> > >
> > > On Fri, Oct 15, 2021 at 02:16:52PM +0800, Huangzhaoyang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > In an EAS enabled system, there are two scenarios discordant to current design,
> > > >
> > > > 1. workload used to be heavy uneven among cores for sake of scheduler policy.
> > > > RT task usually preempts CFS task in little core.
> > > > 2. CFS task's memstall time is counted as simple as exit - entry so far, which
> > > > ignore the preempted time by RT, DL and Irqs.
> >
> > It ignores preemption full-stop. I don't see why RT/IRQ should be
> > special cased here.
> >
> > > > With these two constraints, the percpu nonidle time would be mainly consumed by
> > > > none CFS tasks and couldn't be averaged. Eliminating them by calc the time growth
> > > > via the proportion of cfs_rq's utilization on the whole rq.
> >
> >
> > > > +static unsigned long psi_memtime_fixup(u32 growth)
> > > > +{
> > > > + struct rq *rq = task_rq(current);
> > > > + unsigned long growth_fixed = (unsigned long)growth;
> > > > +
> > > > + if (!(current->policy == SCHED_NORMAL || current->policy == SCHED_BATCH))
> > > > +         return growth_fixed;
> > > > +
> > > > + if (current->in_memstall)
> > > > +         growth_fixed = div64_ul((1024 - rq->avg_rt.util_avg - rq->avg_dl.util_avg
> > > > +                                 - rq->avg_irq.util_avg + 1) * growth, 1024);
> > > > +
> > > > + return growth_fixed;
> > > > +}
> > > > +
> > > >  static void init_triggers(struct psi_group *group, u64 now)
> > > >  {
> > > >   struct psi_trigger *t;
> > > > @@ -658,6 +675,7 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
> > > >   }
> > > >
> > > >   if (groupc->state_mask & (1 << PSI_MEM_SOME)) {
> > > > +         delta = psi_memtime_fixup(delta);
> > >
> > > Ok, so we want to deduct IRQ and RT preemption time from the memstall
> > > period of an active reclaimer, since it's technically not stalled on
> > > memory during this time but on CPU.
> > >
> > > However, we do NOT want to deduct IRQ and RT time from memstalls that
> > > are sleeping on refaults swapins, since they are not affected by what
> > > is going on on the CPU.
> >
> > I think that focus on RT/IRQ is mis-guided here, and the implementation
> > is horrendous.
> >
> > So the fundamental question seems to be; and I think Johannes is the one
> > to answer that: What time-base do these metrics want to use?
> >
> > Do some of these states want to account in task-time instead of
> > wall-time perhaps? I can't quite remember, but vague memories are
> > telling me most of the PSI accounting was about blocked tasks, not
> > running tasks, which makes all this rather more complicated.
> >
> > Randomly scaling time as proposed seems almost certainly wrong. What
> > would that make the stats mean?
>
> It *could* be argued that IRQs and RT preemptions are CPU stalls.
>
> I'm less convinced we should subtract preemptions from memory stalls.
>
> Yes, when you're reclaiming and you get preempted for whatever reason,
> you're technically stalled on CPU in this moment. However, reclaim
> itself consumes CPU and walltime, and it could be what is causing
> those preemptions to begin with! For example, reclaim could eat up 90%
> of your scheduling timeslice and then cause a preemption when the
> thread is back in userspace and trying to be productive. By consuming
> time, it also drags out the overall timeline for userspace to finish
> its work, and a longer timeline will have more disruptions from
> independent events like IRQs and RT thread wakeups.
>
> So if you *were* to discount CPU contention from memory stalls, it
> would also mean that you'd have to count *memory stalls* when
> userspace experiences CPU contention caused by preceding reclaims. I
> don't think it makes sense to try to go down that road...
>
> They're dependent resources. Just like faster CPUs and faster IO
> devices mean less memory pressure for the same amount of reclaim and
> paging activity, it seems logical that contention of those underlying
> resources will result in longer memory stalls and higher pressure.
Imagine that two triggers created on CPU and MEMORY with one RT
non-memstall process consume 90% of the rq's util while a memstall CFS
process get the rest of 10%. The problem is we will be misguided as
both of the resources are busy under current mechanisms.
