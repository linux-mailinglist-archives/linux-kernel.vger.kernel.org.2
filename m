Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A74415A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 10:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240027AbhIWImd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 04:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240054AbhIWImc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 04:42:32 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73D1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 01:41:00 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id b65so19151516qkc.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 01:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8oGhgVkawMnRHXxCUXlx6Q2c+rolf6rCe4TA6ccp79o=;
        b=yZ2gBZPjfyvxK8VLKmsI3dBvCkVOBS72PjytH1Liz9z7mHlhV0DYtwOEc7NFXV+BlY
         4PzCg816ucgTyCd2t86zPr3A7XAYgvq+NweoV72w0Ft/1RhWXdTxUsaLq+40XV344bRK
         fTeFLcA4+HGZNeIbF2oepyOl+3yIdDjOWUlkBaM4K3ocyq/IG6IOm04959jnCOFIuwyx
         Av6CqPc1z9EvYeVnxWYvH3EfD1IGemOWnP/m8Uy7S7EHrVwLfH5g57xP5v6Ns0uIWoKt
         qzWY/ARiFrXg1Lmz1akTHCUr/UG7OiofGf+K2ZmuTpejgy3MswLgIDZYXsOllxKLnE68
         P5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8oGhgVkawMnRHXxCUXlx6Q2c+rolf6rCe4TA6ccp79o=;
        b=kktru9skNbhp5/oXE75/TILtiJQq2hKmd7TOlDA0hAIXiioU/8//wOjKxJaylJ6R/X
         xEtYTCrXIxrxoRbl+UXsL8mns6p+mV8vh1A/usLco/Jx5zWXlPUEFX2+3bJiRhlQ+zaq
         lLIMOfoy9Mj8OxmVNxCzRx0cd2BO7fGhHwoclUc8Su2oqEnYP6PDQrRB72rlmMlWvTMr
         mK6SjPj/rQnT8EN/RtMQH5r3k6MUmvJdajMhufNsbor60usoldRaprYIilQVeLNZpB6x
         LtWqCyw1DB1PgfycrkIaVasHnUr4UkjVRIH2VoiDA7eBXwDSg5X0fcODxuPie0ngC1ck
         f7lw==
X-Gm-Message-State: AOAM53005v+jQm0BYi89/Y1XKC6cQfr2OucMZ+1QrgXKi1R7bKxhTv6C
        PTfAH9rf+Dfnu/s/CJtWcPVWRkwRavzHpNclycjm0WQ2DpuMG9K9
X-Google-Smtp-Source: ABdhPJyB086T6+NQMg7p6Vni1fNsTfU8tIjCQB5sGc1UoTm+LJs3Y6ydd6qC7337oy2yl8H5QWutb4fUC7rKybySGSc=
X-Received: by 2002:a25:c753:: with SMTP id w80mr4282867ybe.245.1632386460044;
 Thu, 23 Sep 2021 01:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210920142614.4891-1-mgorman@techsingularity.net>
 <20210920142614.4891-3-mgorman@techsingularity.net> <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
 <20210921103621.GM3959@techsingularity.net> <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
 <20210922132002.GX3959@techsingularity.net> <CAKfTPtCxhzz1XgNXM8jaQC2=tGHm0ap88HneUgWTpCSeWVZwsw@mail.gmail.com>
 <20210922150457.GA3959@techsingularity.net> <CAKfTPtB3tXwBZ_tVaDdiwMt-=sGH1iV6eUV6Rsnpw7q=tEpBwA@mail.gmail.com>
 <20210922173853.GB3959@techsingularity.net> <CAKfTPtDc39fCLbQqA2BhC6dsb+MyYYMdk9HUvrU0fRqULuQB-g@mail.gmail.com>
 <ba60262d15891702cae0d59122388c6a18caaf53.camel@gmx.de>
In-Reply-To: <ba60262d15891702cae0d59122388c6a18caaf53.camel@gmx.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 23 Sep 2021 10:40:48 +0200
Message-ID: <CAKfTPtBBqLghrXrayyoBQQyDqdv6+pdCjiZkmzLaGvdNtN=Aug@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to nr_running
To:     Mike Galbraith <efault@gmx.de>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
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

On Thu, 23 Sept 2021 at 03:47, Mike Galbraith <efault@gmx.de> wrote:
>
> On Wed, 2021-09-22 at 20:22 +0200, Vincent Guittot wrote:
> > On Wed, 22 Sept 2021 at 19:38, Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > >
> > > I'm not seeing an alternative suggestion that could be turned into
> > > an implementation. The current value for sched_wakeup_granularity
> > > was set 12 years ago was exposed for tuning which is no longer
> > > the case. The intent was to allow some dynamic adjustment between
> > > sysctl_sched_wakeup_granularity and sysctl_sched_latency to reduce
> > > over-scheduling in the worst case without disabling preemption entirely
> > > (which the first version did).
>
> I don't think those knobs were ever _intended_ for general purpose
> tuning, but they did get used that way by some folks.
>
> > >
> > > Should we just ignore this problem and hope it goes away or just let
> > > people keep poking silly values into debugfs via tuned?
> >
> > We should certainly not add a bandaid because people will continue to
> > poke silly value at the end. And increasing
> > sysctl_sched_wakeup_granularity based on the number of running threads
> > is not the right solution.
>
> Watching my desktop box stack up large piles of very short running
> threads, I agree, instantaneous load looks like a non-starter.
>
> >  According to the description of your
> > problem that the current task doesn't get enough time to move forward,
> > sysctl_sched_min_granularity should be part of the solution. Something
> > like below will ensure that current got a chance to move forward
>
> Nah, progress is guaranteed, the issue is a zillion very similar short
> running threads preempting each other with no win to be had, thus
> spending cycles in the scheduler that are utterly wasted.  It's a valid
> issue, trouble is teaching the scheduler to recognize that situation
> without mucking up other situations where there IS a win for even very
> short running threads say, doing a synchronous handoff; preemption is
> cheaper than scheduling off if the waker is going be awakened again in
> very short order.
>
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 9bf540f04c2d..39d4e4827d3d 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7102,6 +7102,7 @@ static void check_preempt_wakeup(struct rq *rq,
> > struct task_struct *p, int wake_
> >         int scale = cfs_rq->nr_running >= sched_nr_latency;
> >         int next_buddy_marked = 0;
> >         int cse_is_idle, pse_is_idle;
> > +       unsigned long delta_exec;
> >
> >         if (unlikely(se == pse))
> >                 return;
> > @@ -7161,6 +7162,13 @@ static void check_preempt_wakeup(struct rq *rq,
> > struct task_struct *p, int wake_
> >                 return;
> >
> >         update_curr(cfs_rq_of(se));
> > +       delta_exec = se->sum_exec_runtime - se->prev_sum_exec_runtime;
> > +       /*
> > +        * Ensure that current got a chance to move forward
> > +        */
> > +       if (delta_exec < sysctl_sched_min_granularity)
> > +               return;
> > +
> >         if (wakeup_preempt_entity(se, pse) == 1) {
> >                 /*
> >                  * Bias pick_next to pick the sched entity that is
>
> Yikes!  If you do that, you may as well go the extra nanometer and rip
> wakeup preemption out entirely, same result, impressive diffstat.

This patch is mainly there to show that there are other ways to ensure
progress without using some load heuristic.
sysctl_sched_min_granularity has the problem of scaling with the
number of cpus and this can generate large values. At least we should
use the normalized_sysctl_sched_min_granularity or even a smaller
value but wakeup preemption still happens with this change. It only
ensures that we don't waste time preempting each other without any
chance to do actual stuff.

a 100us value should even be enough to fix Mel's problem without
impacting common wakeup preemption cases.


>
>         -Mike
