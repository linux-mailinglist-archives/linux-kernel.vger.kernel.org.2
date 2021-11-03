Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB534443D8F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 08:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhKCHLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 03:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhKCHLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 03:11:12 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07C6C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 00:08:36 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id u25so1984971qve.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 00:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ttRK9jhUfRsR37wv0FMnPjvaQAeGbLSUMSc2dK17DwM=;
        b=AQYl/WVLl6K4JhlsVJAj0S0QriZMgR3JogNW0AiBQWKPu1V2FMi1JhlCE44FYYSD8V
         +8fdEa0dMK3BkBe/13iHOD1XnxUGxyLzJciAhKfo4Y3SDNIu3r6y6CzgVxZbNjbFMa/f
         c517lwdd1GJ+U/Xz3/QvkOjaS/DzAzTsrCiPeOFZhdehgGhWkkJYr7e77Zo5qPxmJhPt
         cgZDCagWrv6bBPrXkVFReN0G5rWSKqjQyNFFSM4tmPbd10VEkM9ZcLbz1nGQw3G1TUEx
         4rwPKgGQjKPtmt816V/an99GloslpuSYEI3oaRTJk70JJ3UDTbEo126gHfOJUMZehdmG
         BU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ttRK9jhUfRsR37wv0FMnPjvaQAeGbLSUMSc2dK17DwM=;
        b=swTgS22nJ4t2FtK1bU7mVL1TLsoiKao4b47BZlFenwZShZqS/jSL16z0K7FdIfGY7z
         6H00zqMXiIaJbmvSxWpb/Ko9lQeOQMd9z64tHtXvmR598EnYcN/MKfSAuNGMuKFS10NZ
         4LS+m42HFXEozATIo+7CSTwvnHXhaYaTcLMr/4YUThyTWlWGU4QkYxYOLQ/hMfhNa7tU
         PwdtQUHNKw5+m/h892q12Z+4Bghw0hyuu6N9XeZoFnk50NKsHL0OLEYTGLWi/4kVKP8v
         rWJ50OLtrrCKG8i+DuBAIYOr1XMv28gfqhSOxy5mRtc/PsKNr/XXUbNzZoTO1Zs9+Q/b
         MoPg==
X-Gm-Message-State: AOAM5318hMniO5a1pA6o/cww+xeYPYezkTl809HAjKiJVAPNjpLMcwme
        NtaVqthoxzC6cpELPC+RhGrV4pMHsaQ4a/RZ+og=
X-Google-Smtp-Source: ABdhPJzH8UZanVAfKauDGAl2d+HeXHUgZdlmeFWd9l6TekjjfWRmiWD5CcGs3u2liEAYpB5r3jSz1ajPdK2F5x8FSuo=
X-Received: by 2002:a05:6214:2b0f:: with SMTP id jx15mr20586340qvb.62.1635923316054;
 Wed, 03 Nov 2021 00:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
 <YYGV1TxsZXzGXFmx@cmpxchg.org> <CAGWkznEaEEz=m5UmPXRECiizwht7+8Zw_xH9V7Wwyd__10eJDA@mail.gmail.com>
In-Reply-To: <CAGWkznEaEEz=m5UmPXRECiizwht7+8Zw_xH9V7Wwyd__10eJDA@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 3 Nov 2021 15:08:14 +0800
Message-ID: <CAGWkznFuX=6mSnj7J7=t7et5QO-GB2BKCMRiHoU37jcH9dPhLA@mail.gmail.com>
Subject: Re: [Resend PATCH] psi : calc cfs task memstall time more precisely
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Vincent Guittot

On Wed, Nov 3, 2021 at 3:07 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> On Wed, Nov 3, 2021 at 3:47 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > CC peterz as well for rt and timekeeping magic
> >
> > On Fri, Oct 15, 2021 at 02:16:52PM +0800, Huangzhaoyang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > In an EAS enabled system, there are two scenarios discordant to current design,
> > >
> > > 1. workload used to be heavy uneven among cores for sake of scheduler policy.
> > > RT task usually preempts CFS task in little core.
> > > 2. CFS task's memstall time is counted as simple as exit - entry so far, which
> > > ignore the preempted time by RT, DL and Irqs.
> > >
> > > With these two constraints, the percpu nonidle time would be mainly consumed by
> > > none CFS tasks and couldn't be averaged. Eliminating them by calc the time growth
> > > via the proportion of cfs_rq's utilization on the whole rq.
> > >
> > > eg.
> > > Here is the scenario which this commit want to fix, that is the rt and irq consume
> > > some utilization of the whole rq. This scenario could be typical in a core
> > > which is assigned to deal with all irqs. Furthermore, the rt task used to run on
> > > little core under EAS.
> > >
> > > Binder:305_3-314    [002] d..1   257.880195: psi_memtime_fixup: original:30616,adjusted:25951,se:89,cfs:353,rt:139,dl:0,irq:18
> > > droid.phone-1525    [001] d..1   265.145492: psi_memtime_fixup: original:61616,adjusted:53492,se:55,cfs:225,rt:121,dl:0,irq:15
> > >
> > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > ---
> > >  kernel/sched/psi.c | 20 +++++++++++++++++++-
> > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > > index cc25a3c..754a836 100644
> > > --- a/kernel/sched/psi.c
> > > +++ b/kernel/sched/psi.c
> > > @@ -182,6 +182,8 @@ struct psi_group psi_system = {
> > >
> > >  static void psi_avgs_work(struct work_struct *work);
> > >
> > > +static unsigned long psi_memtime_fixup(u32 growth);
> > > +
> > >  static void group_init(struct psi_group *group)
> > >  {
> > >       int cpu;
> > > @@ -492,6 +494,21 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
> > >       return growth;
> > >  }
> > >
> > > +static unsigned long psi_memtime_fixup(u32 growth)
> > > +{
> > > +     struct rq *rq = task_rq(current);
> > > +     unsigned long growth_fixed = (unsigned long)growth;
> > > +
> > > +     if (!(current->policy == SCHED_NORMAL || current->policy == SCHED_BATCH))
> > > +             return growth_fixed;
> > > +
> > > +     if (current->in_memstall)
> > > +             growth_fixed = div64_ul((1024 - rq->avg_rt.util_avg - rq->avg_dl.util_avg
> > > +                                     - rq->avg_irq.util_avg + 1) * growth, 1024);
> > > +
> > > +     return growth_fixed;
> > > +}
> > > +
> > >  static void init_triggers(struct psi_group *group, u64 now)
> > >  {
> > >       struct psi_trigger *t;
> > > @@ -658,6 +675,7 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
> > >       }
> > >
> > >       if (groupc->state_mask & (1 << PSI_MEM_SOME)) {
> > > +             delta = psi_memtime_fixup(delta);
> >
> add vincent for advise on cpu load mechanism
>
> > Ok, so we want to deduct IRQ and RT preemption time from the memstall
> > period of an active reclaimer, since it's technically not stalled on
> > memory during this time but on CPU.
> >
> > However, we do NOT want to deduct IRQ and RT time from memstalls that
> > are sleeping on refaults swapins, since they are not affected by what
> > is going on on the CPU.
> >
> > Does util_avg capture that difference? I'm not confident it does - but
> > correct me if I'm wrong. We need length of time during which and IRQ
> > or an RT task preempted the old rq->curr, not absolute irq/rt length.
> As far as my understanding, core's capacity = IRQ + DEADLINE + RT +
> CFS. For a certain time period, all cfs tasks preempt each other
> inside CFS's utilization. So the sleeping on refaults is counted in.
> >
> > (Btw, such preemption periods, in addition to being deducted from
> > memory stalls, should probably also be added to CPU contention stalls,
> > to make CPU pressure reporting more accurate as well.)
