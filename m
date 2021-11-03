Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7197443D8E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 08:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhKCHKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 03:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhKCHKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 03:10:18 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3432C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 00:07:42 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id ay20so1419641qkb.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 00:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l3e7hSY9hjXPwcRoDEJWhG4H/EA/b7wozMqgqdSGJBc=;
        b=AWpaWYmJe7awerKfVmRPOyssoDJKr6r7BJAicm1PzkeNB60V2QF2ott4R6spg1kE2I
         8PCmi9bgRmYj7k96FehrF4eFLQfYaejYC5hJg3/2nl899oa+lsfw1w3S+d+F/LSvavJb
         ms7r1Q7VYXXVr1cGixMNnZfiX2XuL4zpC5w7VY3rLO78/LGmXCvBmv/kBVfdm1mMH7DD
         ASpdLLu3zMQyJKi5fsGEvC2W3O1kBbz1bECwg7zAHXtWHQTCc0o+9eJMrCRm16DK5zIY
         iljh+wRlQC0b/IUuBXRdJy7bR3q3Ar0664aqk6F6qv+RkqytIn5tLeBQUskL9wvTnWTg
         lApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3e7hSY9hjXPwcRoDEJWhG4H/EA/b7wozMqgqdSGJBc=;
        b=FGJiCbZ1Ks8XsEckymtTM1XjkoXrJqd69XXTIxPPWVHW4cTufvYRFl24OyMT1nXEAh
         JEzL4I8S+fWUd2HsnlDWsH+8uoHCFDW6ceBQPH+akPU+H044Jl5V+msyFiQ0K9EYO76d
         Qu6Q5gRMDhxqysgUOp4JCkHm7s3SN5YPmFzt3z9ZsKETp06y1fIUwWWJ4mkP8H0guq5i
         mnIb94JfDculZzT+8eWcfXtWfvAniKNRXMpV6ZWR02wMZ/UGlXUkCUS65QQwrWRBCowk
         FZI8e4RZCGc+kE09+o6bD8WqWPmXTsczfYRBh6nPtk0LGhO6ArSW7cunnOLBTcmvFbqw
         Du2A==
X-Gm-Message-State: AOAM532S2oYh3CwS4V2D2VW7OWj0ufk1lF9yE0IPgT+mghUhg9F2M1DQ
        o90N9JkV1NOUeCAbNLByfxOomgVumthdjQTG55Q=
X-Google-Smtp-Source: ABdhPJxNMCXpCkHhdFkSiYH5qQOJU7XYNkGDydw/RKbI1js4Mfux06N8bc73FHNSfy8DtiAQxVWA6z2uFYzRfkshpGk=
X-Received: by 2002:a05:620a:2442:: with SMTP id h2mr34537308qkn.298.1635923262095;
 Wed, 03 Nov 2021 00:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com> <YYGV1TxsZXzGXFmx@cmpxchg.org>
In-Reply-To: <YYGV1TxsZXzGXFmx@cmpxchg.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 3 Nov 2021 15:07:21 +0800
Message-ID: <CAGWkznEaEEz=m5UmPXRECiizwht7+8Zw_xH9V7Wwyd__10eJDA@mail.gmail.com>
Subject: Re: [Resend PATCH] psi : calc cfs task memstall time more precisely
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 3:47 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> CC peterz as well for rt and timekeeping magic
>
> On Fri, Oct 15, 2021 at 02:16:52PM +0800, Huangzhaoyang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > In an EAS enabled system, there are two scenarios discordant to current design,
> >
> > 1. workload used to be heavy uneven among cores for sake of scheduler policy.
> > RT task usually preempts CFS task in little core.
> > 2. CFS task's memstall time is counted as simple as exit - entry so far, which
> > ignore the preempted time by RT, DL and Irqs.
> >
> > With these two constraints, the percpu nonidle time would be mainly consumed by
> > none CFS tasks and couldn't be averaged. Eliminating them by calc the time growth
> > via the proportion of cfs_rq's utilization on the whole rq.
> >
> > eg.
> > Here is the scenario which this commit want to fix, that is the rt and irq consume
> > some utilization of the whole rq. This scenario could be typical in a core
> > which is assigned to deal with all irqs. Furthermore, the rt task used to run on
> > little core under EAS.
> >
> > Binder:305_3-314    [002] d..1   257.880195: psi_memtime_fixup: original:30616,adjusted:25951,se:89,cfs:353,rt:139,dl:0,irq:18
> > droid.phone-1525    [001] d..1   265.145492: psi_memtime_fixup: original:61616,adjusted:53492,se:55,cfs:225,rt:121,dl:0,irq:15
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  kernel/sched/psi.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index cc25a3c..754a836 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -182,6 +182,8 @@ struct psi_group psi_system = {
> >
> >  static void psi_avgs_work(struct work_struct *work);
> >
> > +static unsigned long psi_memtime_fixup(u32 growth);
> > +
> >  static void group_init(struct psi_group *group)
> >  {
> >       int cpu;
> > @@ -492,6 +494,21 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
> >       return growth;
> >  }
> >
> > +static unsigned long psi_memtime_fixup(u32 growth)
> > +{
> > +     struct rq *rq = task_rq(current);
> > +     unsigned long growth_fixed = (unsigned long)growth;
> > +
> > +     if (!(current->policy == SCHED_NORMAL || current->policy == SCHED_BATCH))
> > +             return growth_fixed;
> > +
> > +     if (current->in_memstall)
> > +             growth_fixed = div64_ul((1024 - rq->avg_rt.util_avg - rq->avg_dl.util_avg
> > +                                     - rq->avg_irq.util_avg + 1) * growth, 1024);
> > +
> > +     return growth_fixed;
> > +}
> > +
> >  static void init_triggers(struct psi_group *group, u64 now)
> >  {
> >       struct psi_trigger *t;
> > @@ -658,6 +675,7 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
> >       }
> >
> >       if (groupc->state_mask & (1 << PSI_MEM_SOME)) {
> > +             delta = psi_memtime_fixup(delta);
>
add vincent for advise on cpu load mechanism

> Ok, so we want to deduct IRQ and RT preemption time from the memstall
> period of an active reclaimer, since it's technically not stalled on
> memory during this time but on CPU.
>
> However, we do NOT want to deduct IRQ and RT time from memstalls that
> are sleeping on refaults swapins, since they are not affected by what
> is going on on the CPU.
>
> Does util_avg capture that difference? I'm not confident it does - but
> correct me if I'm wrong. We need length of time during which and IRQ
> or an RT task preempted the old rq->curr, not absolute irq/rt length.
As far as my understanding, core's capacity = IRQ + DEADLINE + RT +
CFS. For a certain time period, all cfs tasks preempt each other
inside CFS's utilization. So the sleeping on refaults is counted in.
>
> (Btw, such preemption periods, in addition to being deducted from
> memory stalls, should probably also be added to CPU contention stalls,
> to make CPU pressure reporting more accurate as well.)
