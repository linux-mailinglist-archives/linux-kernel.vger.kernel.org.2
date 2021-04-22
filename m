Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243AC367CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbhDVIiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbhDVIiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:38:08 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56CDC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:37:32 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x20so40594998lfu.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5bNWGj0MtDwouVYiT6igwnQInlIcaj9lEKQchN4rGfQ=;
        b=EK39SN42ItaMbxrG+9TFGUjIRQwf2ZkofzLSuI57bhVQl80+so3aPUXpXv6umA3y4j
         3oaKI7ZIjDDWU3BUOuBjOaZj2InXk+vCb+/T1pUlpqy9mWjYAiWkj76HUnbbZ3ywJRm8
         g504hnVzopm/0VLtyXtULFtBeW8P5twXYsHTtGW06HPQA8b1/C1M+XRP1dPIyja32lDu
         q5Cy/1t4+zdvGvIzfrrdnCNxtbYbKLgJkTyZg/+xgghX+J00IKuDbJrNPAz/6R7mN3QI
         XeJc1RHME8HPQeaIy1TRm3+FxneHI763PvuvD79GJIfbebWFAeS5YFIm7+NvGvwrpSim
         gxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5bNWGj0MtDwouVYiT6igwnQInlIcaj9lEKQchN4rGfQ=;
        b=sqaoWcQ63w+mSE5DU/pTLBk0275I3l78637y5CiRM8Ta0dQaAP8s+9Ogx9pFEhgr0y
         qcUqdAaeubaH4rIUT+sX2ilFL4f7fDOk3EtpUOqig9hm0AFKhGKd/Q4p7MWBiGXL/LaQ
         VcjNAUZyuXKcWnb1HuzU4WW52mpYZBg1UYpwGBHuyHqVTqd97Xx0TYDPtiql7wB0XrQX
         PyWttDIAxhN72OGFhovf6AhSKjzwVrlMWPgv6cHw9TlAZsaVvEjV0SCjMWJS0uJ88zYK
         3oXfY+ePw/2WzBhVU0IkSSH0uvp29rWaucd9fDFRIYwWJfOwCTrHSygK+ELf/k00ejBx
         btiw==
X-Gm-Message-State: AOAM533jPxTfz5Pw34aMR4+tqftbM8X4SV/ksq0xab09BdXx8YkkhB+J
        wYGHDrOpchm7dS5mTUicktsOLZFE7HUqa3CryKs9oM1GSlIO8w==
X-Google-Smtp-Source: ABdhPJwDlFg6lL+aVXfidcykqKyth+wJUrAT2mk4+mPp/bQm9CkSGTtG+IpY1EE8qtriGbgT5vTNia+/Nc2PUpE9s20=
X-Received: by 2002:ac2:560b:: with SMTP id v11mr1741453lfd.254.1619080651393;
 Thu, 22 Apr 2021 01:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210420120705.5c705d4b@imladris.surriel.com> <CAKfTPtCcS_bNUi-KwspHssabORupj9K8Y=+Hc7nOzr9JBK-8AA@mail.gmail.com>
In-Reply-To: <CAKfTPtCcS_bNUi-KwspHssabORupj9K8Y=+Hc7nOzr9JBK-8AA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 22 Apr 2021 10:37:19 +0200
Message-ID: <CAKfTPtBogNs1uVoTmiNj0Xw57ZsJ0DS-pas-gA67E79CXvHR5w@mail.gmail.com>
Subject: Re: [PATCH v3] sched,fair: skip newidle_balance if a wakeup is pending
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 at 19:27, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Hi Rik,
>
> On Tue, 20 Apr 2021 at 18:07, Rik van Riel <riel@surriel.com> wrote:
> >
> > The try_to_wake_up function has an optimization where it can queue
> > a task for wakeup on its previous CPU, if the task is still in the
> > middle of going to sleep inside schedule().
> >
> > Once schedule() re-enables IRQs, the task will be woken up with an
> > IPI, and placed back on the runqueue.
> >
> > If we have such a wakeup pending, there is no need to search other
> > CPUs for runnable tasks. Just skip (or bail out early from) newidle
> > balancing, and run the just woken up task.
> >
> > For a memcache like workload test, this reduces total CPU use by
> > about 2%, proportionally split between user and system time,
> > and p99 and p95 application response time by 10% on average.
> > The schedstats run_delay number shows a similar improvement.
> >
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > ---
> >  kernel/sched/fair.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 69680158963f..fd80175c3b3e 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10594,6 +10594,14 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >         u64 curr_cost = 0;
> >
> >         update_misfit_status(NULL, this_rq);
> > +
> > +       /*
> > +        * There is a task waiting to run. No need to search for one.
> > +        * Return 0; the task will be enqueued when switching to idle.
> > +        */
> > +       if (this_rq->ttwu_pending)
> > +               return 0;
> > +
> >         /*
> >          * We must set idle_stamp _before_ calling idle_balance(), such that we
> >          * measure the duration of idle_balance() as idle time.
> > @@ -10661,7 +10669,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >                  * Stop searching for tasks to pull if there are
> >                  * now runnable tasks on this rq.
> >                  */
> > -               if (pulled_task || this_rq->nr_running > 0)
> > +               if (pulled_task || this_rq->nr_running > 0 ||
> > +                   this_rq->ttwu_pending)
> >                         break;
> >         }
> >         rcu_read_unlock();
> > @@ -10688,7 +10697,12 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >         if (this_rq->nr_running != this_rq->cfs.h_nr_running)
> >                 pulled_task = -1;
> >
> > -       if (pulled_task)
> > +       /*
> > +        * If we are no longer idle, do not let the time spent here pull
> > +        * down this_rq->avg_idle. That could lead to newidle_balance not
> > +        * doing enough work, and the CPU actually going idle.
> > +        */
> > +       if (pulled_task || this_rq->ttwu_pending)
>
> I'm still running some benchmarks to evaluate the impact of your patch
> and more especially the line above which clears this_rq->idle_stamp
> and skips the time spent in newidle_balance from being accounted for
> in avg_idle. I have some results which  show some regression because
> of this test especially with hackbench.
> On large system, the time spent in newidle_balance can be significant
> and we can't ignore it just because this_rq->ttwu_pending is set while
> looping the domains because without newidle_balance the idle time
> would have been large and we end up screwing up the metric

I confirmed that the line above generate hackbench regression on my
large arm64 system (2 * 112 CPUs)
I'm testing hackbench with various number of group : 1, 2, 4, 16, 32,
64, 128, 256 but I have only put the 2 results which significantly
regress. The other ones are in the +/-1% variation range

hackbench -g $group

group    v5.12-rc8+tip    w/ this patch          w/ this patch without
the line above
64       2.862(+/- 9%)    2.952(+/-11%) -3%      2.807(+/- 7%) +2%
128      3.334(+/-10%)    3.561-+/-13%) -7%      3.181(+/- 6%) +4%



>
> >                 this_rq->idle_stamp = 0;
> >
> >         rq_repin_lock(this_rq, rf);
> > --
> > 2.25.4
> >
> >
