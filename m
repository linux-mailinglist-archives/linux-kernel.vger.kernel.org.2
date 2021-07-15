Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD893C9F08
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 15:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhGONEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 09:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhGONEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 09:04:21 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E1AC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 06:01:27 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r16so8678998ljk.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 06:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qgjG+VmOg62wB3+7tY5M7lgrcHCWQtXRGsmqDwvz/k=;
        b=cUwCGOGor/3UZRgPKnLEsv+ZthjT7SbE5ERYwcfm40FaFHYP5bu+9LexBTGa/hZWXn
         DTZ72IlAmuQ21MEOC0SgO/HQPIfZltuX9rGgbU3myKpiv1EkPj/7xGMyhCibGK2/Wzb3
         ulz+5i+4GFDcnWP78AGgcyrWbHClMy745h8+U84aJSe5yWtOVxbPwr/n7xJEgTNn5DaA
         Xh6MZH+Xm5ZsAReWHwXjsS5rrcWOhzUSYe3eFKCL6LUVXgSsx7O04zvcVo3f9l0mypSt
         4OBnlulWrY1SVLumKVC85r0OnYID3MCkHjfomlpIBYYUcUJKAGd0T3y7UubbjEtxCmIz
         NIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qgjG+VmOg62wB3+7tY5M7lgrcHCWQtXRGsmqDwvz/k=;
        b=LHzbmUIrWGebUB8LWYz2mews5HwiIWOvVO7crXDPCfbYO+3pxlnLXVLLaSRx5dvUj8
         1usHaI6MpsrK8tmsDcx808RtTEnYe4GtPSjDeQJl4f3AReRJuqszUpkdM/IT4sLt8CBB
         qQvnSoOEfzJHFXMSIQ1zJnTRcY0nyyna9rtvLQa9M7DYZ506B2W8+68HKTYhbYPIAurE
         NNenocmAdVBxrlzNm3GU+RsA4KpuTuvSm7JvaUntrHiOsMawwBmXeWxqCZoco1c91Bji
         QsmOmGYreJGv5E4YLPmn2WSf473ScYZgjOs8aFVjyGHgDvrNPrGZFME3HOOlCqMFrroU
         uafg==
X-Gm-Message-State: AOAM530Kuojk5NT+hmNjkinkshJGwWYAHXwNxpbVOUB+EK0ME4WRFJ+Y
        jKDncClCM6kxFdtJVOiG2VAHh37FQWn9cbWO7Jv8VA==
X-Google-Smtp-Source: ABdhPJwQyYxyUToYgPSRIBF4a92iZ8u30ZqIsOG6Elso2p10ejPne+eptCnbPf34HZlwsomcwTXTlgBqG044BmjcIIg=
X-Received: by 2002:a2e:9c02:: with SMTP id s2mr3898697lji.299.1626354080019;
 Thu, 15 Jul 2021 06:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210714113928.2795632-1-valentin.schneider@arm.com>
 <CAKfTPtCKJEgm=hXkKz0pHDE2d3Bz+6wp1kkNB+P+OpzWcR1+wg@mail.gmail.com> <87lf67n63p.mognet@arm.com>
In-Reply-To: <87lf67n63p.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 15 Jul 2021 15:01:08 +0200
Message-ID: <CAKfTPtCdKK97_6m5C9Jp1yDLraJqm7PF-XL+0h64Bmab-4Px+g@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Update nohz.next_balance for newly NOHZ-idle CPUs
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2021 at 13:56, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Hi Vincent,
>
> Thanks for taking a look.
>
> On 15/07/21 09:42, Vincent Guittot wrote:
> > On Wed, 14 Jul 2021 at 13:39, Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> >>
> >> Consider a system with some NOHZ-idle CPUs, such that
> >>
> >>   nohz.idle_cpus_mask = S
> >>   nohz.next_balance = T
> >>
> >> When a new CPU k goes NOHZ idle (nohz_balance_enter_idle()), we end up
> >> with:
> >>
> >>   nohz.idle_cpus_mask = S \U {k}
> >>   nohz.next_balance = T
> >>
> >> Note that the nohz.next_balance hasn't changed - it won't be updated until
> >> a NOHZ balance is triggered. This is problematic if the newly NOHZ idle CPU
> >> has an earlier rq.next_balance than the other NOHZ idle CPUs, IOW if:
> >>
> >>   cpu_rq(k).next_balance < nohz.next_balance
> >>
> >> In such scenarios, the existing nohz.next_balance will prevent any NOHZ
> >> balance from happening, which itself will prevent nohz.next_balance from
> >> being updated to this new cpu_rq(k).next_balance. Unnecessary load balance
> >> delays of over 12ms caused by this were observed on an arm64 RB5 board.
> >
> > How many CPUs has the arm64 RB5 ?
>
> That's an 8 CPU DynamIQ system - 4 littles, 3 bigs and one "huge". That
> should give us a regular balance_interval of 8ms, but our tests have picked
> up CPUs staying idle for >20ms when they really have stuff to pull. In this
> case balance_interval increases are involved.
>
> >> @@ -10351,6 +10354,13 @@ static void nohz_balancer_kick(struct rq *rq)
> >>  unlock:
> >>         rcu_read_unlock();
> >>  out:
> >> +       /*
> >> +        * Some CPUs have recently gone into NOHZ idle; kick a balance to
> >> +        * collate the proper next balance interval.
> >> +        */
> >> +       if (!cpumask_subset(nohz.idle_cpus_mask, nohz.last_balance_mask))
> >
> > I don't really like having to manipulate a cpumask just to trigger an
> > ILB and force the update of nohz.next_balance. Could we use something
> > similar to nohz.has_blocked and introduce a nohz.force_update.
> > manipulating cpumask will even be more complex if we start to have a
> > per node idle_cpus_mask like proposed here:
> > https://lore.kernel.org/lkml/20210701055323.2199175-1-npiggin@gmail.com/
> >
> > Also
> >
> >
> > Something like below is simpler
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 44e44c235f1f..91c314f58982 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10657,6 +10657,9 @@ static void nohz_newidle_balance(struct rq *this_rq)
> >         if (this_rq->avg_idle < sysctl_sched_migration_cost)
> >                 return;
> >
> > +       if (time_before(this_rq->next_balance, READ_ONCE(nohz.next_balance))
> > +               WRITE_ONCE(nohz.need_update, 1);
> > +
>
> I think we have to do this unconditionally, as we can observe the old
> nohz.next_balance while a NOHZ balance is ongoing (which will update
> nohz.next_balance without taking into account this newly idle CPU).

so maybe add this in nohz_balance_enter_idle() after the
smp_mb__after_atomic(). Ilb will see the cpu in the idle_cpus_mask so
even if nohz.next_balance is updated, it will take into account this
newly idle cpu

My goal was to use mechanism similar to what is used of nohz.has_blocked


>
>
> >         /* Don't need to update blocked load of idle CPUs*/
> >         if (!READ_ONCE(nohz.has_blocked) ||
> >             time_before(jiffies, READ_ONCE(nohz.next_blocked)))
> >
> >
> > Then we have to test nohz.need_update in nohz_balancer_kick()
> >
>
> But then, when can we safely clear this new nohz.need_update? We can't do
> it unconditionally in nohz_idle_balance() as this could race with a new CPU
> going NOHZ idle.

not with the proposal above

>
> Perhaps instead we could have a single nohz.needs_update_mask, the CPU is
> set in nohz_newidle_balance(), cleared when iterated over in
> _nohz_idle_balance(), and nohz_balancer_kick() can trigger an
> e.g. NOHZ_UPDATE_KICK if this new cpumask is non-empty.
>
> >> +               flags |= NOHZ_STATS_KICK;
> >
> > people complain that an update of blocked load is time consuming so we
> > should not kick this update unnecessarily.
> > We should introduce a new bit like NOHZ_NEXT_KICK that will only go
> > through idle cpus and update nohz.next_balance
> >
>
> That sounds reasonable.
>
> >> +
> >>         if (flags)
> >>                 kick_ilb(flags);
> >>  }
> >> @@ -10487,6 +10497,7 @@ static bool update_nohz_stats(struct rq *rq)
> >>  static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
> >>                                enum cpu_idle_type idle)
> >>  {
> >> +       struct cpumask *cpus = this_cpu_cpumask_var_ptr(nohz_balance_mask);
> >>         /* Earliest time when we have to do rebalance again */
> >>         unsigned long now = jiffies;
> >>         unsigned long next_balance = now + 60*HZ;
> >> @@ -10518,7 +10529,8 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
> >>          * Start with the next CPU after this_cpu so we will end with this_cpu and let a
> >>          * chance for other idle cpu to pull load.
> >>          */
> >> -       for_each_cpu_wrap(balance_cpu,  nohz.idle_cpus_mask, this_cpu+1) {
> >> +       cpumask_copy(cpus, nohz.idle_cpus_mask);
> >
> > we are not sure to go through all idle cpus and ilb can abort
> >
>
> Right, this is missing something to re-kick an update, but I think we can
> get rid of that entirely...
