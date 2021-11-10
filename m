Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492EB44B9F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 02:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhKJBkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 20:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbhKJBkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 20:40:08 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29815C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 17:37:22 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id j17so712838qtx.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 17:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFSvIXLvuM5WjGRK19uU3La2y2+mphjkkQvNxDEReck=;
        b=MjbowGEkIBxR3fNlzyzLDUyz/7KxvRAEMfqE+K5RzoWnB2aX/RYLRgWb7ocRe7I5jb
         uUQnpbiV37I2O63es1OsESl8qEcdSlG3YKo2k5SOoE2LMZLvbqu6PBZZZbJRSPezUDET
         Dj/1HmKaU5gYinTY7QvPwwjUhDpjHxPXIKSCad1ygzXLIKIU3kBlUVEAbNhwyqNUxVIg
         0OfD+yEvQZtDeoyggjC/RvTlCl3P5qWY3Q+8Tq9BTMoDG9AcMvYyj/KodABo0kll2EYE
         J5YXc2ncolES1hwRPW5HPI/2PlAgXWO+Xm17SJcqUDuPF3K/glgrDzfv2ANCXfDuhk4d
         En7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFSvIXLvuM5WjGRK19uU3La2y2+mphjkkQvNxDEReck=;
        b=rE9reBNqKf4TOJNz4jwoKcn7UFtGaAwsr4jQdBkwVOwNtnU5fIK+iO14nPxjuslPYe
         eEBuOyuKtvkzGJiYb11klWlnsGJtEY2cl4KtEBG+2lHZiYwWmzlbgeIiXq2fIcvHUWKD
         Tz0a8KmjXDu5RRwsdMRucwuje50ZfYOFatG8Uo39uU3AAKTadm7xiRjBSKw1tZNHrfKh
         s5WYPdNZJ8s6xMbYJpMdWeqhmrNKiaNGSMv2dHYPGkYRWbuXsUGqDHi5Ro5AY9/fwmfn
         X1HRZkREwQggmtnePgJV9mYsX9k7FG25Z5xRCD7Jx0+osT4fNdd1X90te28PVTWJ46nZ
         V1BQ==
X-Gm-Message-State: AOAM5317Nd5+BDMW5Yw8jBIUtol4TLySWiPFELzAkzCfpwNtEWBPNUuP
        uw7zzNpNIjSQTPlIUCknKZCSYhgia2ye4E9aLoY=
X-Google-Smtp-Source: ABdhPJxe01kC/jo6H85bZ52e7Vud7jVAEE7fdwfh4ocPE8ivOcLUrQW87+wnvtG4mjZbs1jEgLD6SFrRWJk+RAOzksg=
X-Received: by 2002:ac8:580b:: with SMTP id g11mr13279957qtg.272.1636508241235;
 Tue, 09 Nov 2021 17:37:21 -0800 (PST)
MIME-Version: 1.0
References: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
 <YYGV1TxsZXzGXFmx@cmpxchg.org> <YYqMJLXcQ4a+Lh/4@hirez.programming.kicks-ass.net>
In-Reply-To: <YYqMJLXcQ4a+Lh/4@hirez.programming.kicks-ass.net>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 10 Nov 2021 09:37:00 +0800
Message-ID: <CAGWkznHGZeAeQzpuwi-ZH50R_fm4Nw5r8TSonk8AQatZaB_xSA@mail.gmail.com>
Subject: Re: [Resend PATCH] psi : calc cfs task memstall time more precisely
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ke Wang <ke.wang@unisoc.com>, xuewen.yan@unisoc.com
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 10:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 02, 2021 at 03:47:33PM -0400, Johannes Weiner wrote:
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
>
> It ignores preemption full-stop. I don't see why RT/IRQ should be
> special cased here.
As Johannes comments, what we are trying to solve is mainly the
preempted time of the CFS task by RT/IRQ, NOT the RT/IRQ themselves.
Could you please catch up the recent reply of Dietmar, which maybe
provide more information.
>
> > > With these two constraints, the percpu nonidle time would be mainly consumed by
> > > none CFS tasks and couldn't be averaged. Eliminating them by calc the time growth
> > > via the proportion of cfs_rq's utilization on the whole rq.
>
>
> > > +static unsigned long psi_memtime_fixup(u32 growth)
> > > +{
> > > +   struct rq *rq = task_rq(current);
> > > +   unsigned long growth_fixed = (unsigned long)growth;
> > > +
> > > +   if (!(current->policy == SCHED_NORMAL || current->policy == SCHED_BATCH))
> > > +           return growth_fixed;
> > > +
> > > +   if (current->in_memstall)
> > > +           growth_fixed = div64_ul((1024 - rq->avg_rt.util_avg - rq->avg_dl.util_avg
> > > +                                   - rq->avg_irq.util_avg + 1) * growth, 1024);
> > > +
> > > +   return growth_fixed;
> > > +}
> > > +
> > >  static void init_triggers(struct psi_group *group, u64 now)
> > >  {
> > >     struct psi_trigger *t;
> > > @@ -658,6 +675,7 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
> > >     }
> > >
> > >     if (groupc->state_mask & (1 << PSI_MEM_SOME)) {
> > > +           delta = psi_memtime_fixup(delta);
> >
> > Ok, so we want to deduct IRQ and RT preemption time from the memstall
> > period of an active reclaimer, since it's technically not stalled on
> > memory during this time but on CPU.
> >
> > However, we do NOT want to deduct IRQ and RT time from memstalls that
> > are sleeping on refaults swapins, since they are not affected by what
> > is going on on the CPU.
>
> I think that focus on RT/IRQ is mis-guided here, and the implementation
> is horrendous.
>
> So the fundamental question seems to be; and I think Johannes is the one
> to answer that: What time-base do these metrics want to use?
>
> Do some of these states want to account in task-time instead of
> wall-time perhaps? I can't quite remember, but vague memories are
> telling me most of the PSI accounting was about blocked tasks, not
> running tasks, which makes all this rather more complicated.
memstall time is counted as exit - enter, which include both blocked
and running stat. However, we think the blocked time introduced by
preemption of RT/IRQ/DL are memstall irrelevant(should be eliminated),
while the ones between CFS tasks could be. Thanks for the mechanism of
load tracking, the implementation could be simple by calculating the
proportion of CFS_UTIL among the whole core's capacity.
>
> Randomly scaling time as proposed seems almost certainly wrong. What
> would that make the stats mean?
It is NOT randomly scaling, but scales in each record_times for CFS tasks.
