Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F973C5DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 15:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbhGLOAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 10:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbhGLOAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 10:00:06 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A68C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:57:18 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a6so24407883ljq.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HMWIu4g4i+bUr3Ety5zKlIKMgzh+fzfR0B/BYTDcgxc=;
        b=xARQ7qLKABA/ujmqMAp+1IqKiFgOdlmQ2vskEGLuUFHWYNQVHG8ef9JWd44I+asoOA
         beZBnLMslA04SIZgV2EwXRmFyB5E9Kp0W/g9odRIz3CctcMv0YuE1roDQH/N8QD5Qhhp
         0DVTkHbEFAWDFXyttrlSQDad4QmN6nVSaggC57s3IqYySNI+EjIivUzttPHWGQ2USx8T
         CqGmkXYExUP8D4sIMxiEArj2oQcl9/Ign2E/3JPpOPf99N0BgPtoMDQUYpmZr8BzI4xg
         2jrnqfo5yc/PQtA68xkqJfp09yUCKjU3i/o144NmbNolmTSpLDnvcJPI1QJmgR50lq+0
         cUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HMWIu4g4i+bUr3Ety5zKlIKMgzh+fzfR0B/BYTDcgxc=;
        b=GyiOnio21LdTN6RwSyjg6iobeSiEl72vDXO46HtOpPGCwLOkQMZBA7urm99/JNGT0g
         650QVV7t5Hv1M11LOfvNTQoyYGiYncIUTTRsX7K/pVzF+g9sZUyhFTUbdjZ7CNlrH5X6
         NY7+63wo30e9LDWDod3j0qpfXGgaOJhj1qknswZ4ucElnvEjrFeS6xAl+iQC8sIIK80I
         lat4t8iCdAaZLjeXObvlhEBPyL77BqIDw6wnEXZzX9BDsRyNre0QH0vri66SOgixZLmX
         cUski+ZAhBQ+w2Od+pHGITvRVU86bW3yVDndw937TpHG2ir9sGgnvoX/0s3pX35TcUj6
         IIOQ==
X-Gm-Message-State: AOAM5308k1GkWQK30NTd+flZDjbib7h+e6vUfG8zPul552S/GrqZuIaZ
        tMh1le/lROwSGV+SDWwcJUMpMBL0zdjTHV0QqPGYIQ==
X-Google-Smtp-Source: ABdhPJytbdNSNbgOfMtV+F9B0TaG0Vq3T07cVTtwPYazUAElTHburVuFBV+sAIze+UjDwVo9e+nwBLeNimFk+1GfmWo=
X-Received: by 2002:a2e:824e:: with SMTP id j14mr41975824ljh.445.1626098236264;
 Mon, 12 Jul 2021 06:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210701055323.2199175-1-npiggin@gmail.com> <CAKfTPtDexxEHeFxV-KwZFCZcitPn0x-Q+Kp3s_9-Ctv-6gpZ5g@mail.gmail.com>
In-Reply-To: <CAKfTPtDexxEHeFxV-KwZFCZcitPn0x-Q+Kp3s_9-Ctv-6gpZ5g@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 12 Jul 2021 15:57:02 +0200
Message-ID: <CAKfTPtCMBCeaRQjEQL3OC949J+PPdBps2wQ_i+u5OfsreKWs_A@mail.gmail.com>
Subject: Re: [PATCH] nohz: nohz idle balancing per node
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2021 at 09:50, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> On Thu, 1 Jul 2021 at 07:53, Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > Currently a single nohz idle CPU is designated to perform balancing on
> > behalf of all other nohz idle CPUs in the system. Implement a per node
> > nohz balancer to minimize cross-node memory accesses and runqueue lock
> > acquisitions.
> >
> > On a 4 node system, this improves performance by 9.3% on a 'pgbench -N'
> > with 32 clients/jobs (which is about where throughput maxes out due to
> > IO and contention in postgres).
> >
> > Performance consistency and drop-off after peak is much improved:
> >
> > https://user-images.githubusercontent.com/19833002/124070985-0e923a80-da82-11eb-81c8-6788be27dfdb.png

I run some perf tests with the patch.

For hackbench, I see significant improvement with only 1 group  and
other tests with more groups don't show any difference. I don't know
if the root cause of the improvement is that the ilb happens on the
local node or if we can run some ilb in parallel on each node
tip                 + patch
13.683(+/- 3.91%)   12.306(+/- 1.59%) +10.06%

I was about to say that I have a regression for tbench with high
number of client but one iteration failed during the test and a new
run doesn't show any egression.

> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  kernel/sched/core.c |  3 ++
> >  kernel/sched/fair.c | 90 +++++++++++++++++++++++++++++++--------------
> >  2 files changed, 65 insertions(+), 28 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index cf16f8fda9a6..52681f11e98c 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -9067,6 +9067,9 @@ void __init sched_init(void)
> >          */
> >         init_idle(current, smp_processor_id());
> >
> > +       /* Must run before init_sched_fair_class(), which tests housekeeping */
> > +       housekeeping_init();
>
> You keep calling it after sched_init() in start_kernel()
>
> > +
> >         calc_load_update = jiffies + LOAD_FREQ;
> >
> >  #ifdef CONFIG_SMP
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index fb469b26b00a..832f8673bba1 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5722,13 +5722,27 @@ DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
> >
> >  #ifdef CONFIG_NO_HZ_COMMON
> >
> > -static struct {
> > +struct nohz {
> >         cpumask_var_t idle_cpus_mask;
> >         atomic_t nr_cpus;
> >         int has_blocked;                /* Idle CPUS has blocked load */
> >         unsigned long next_balance;     /* in jiffy units */
> >         unsigned long next_blocked;     /* Next update of blocked load in jiffies */
> > -} nohz ____cacheline_aligned;
> > +} ____cacheline_aligned;
> > +
> > +static struct nohz **nohz_nodes __ro_after_init;
> > +
> > +static struct nohz *get_nohz(void)
> > +{
> > +#ifdef CONFIG_CPU_ISOLATION
> > +       /*
> > +        * May not have a house keeping CPU per node, do global idle balancing.
> > +        */
> > +       if (static_branch_unlikely(&housekeeping_overridden))
> > +               return nohz_nodes[0];
> > +#endif
> > +       return nohz_nodes[numa_node_id()];
>
> This assumes that we call get_nohz() from local cpu or at least local
> node. Have you checked that this is always the case ?
>
> > +}
> >
> >  #endif /* CONFIG_NO_HZ_COMMON */
> >
> > @@ -10217,7 +10231,7 @@ static inline int find_new_ilb(void)
> >  {
> >         int ilb;
> >
> > -       for_each_cpu_and(ilb, nohz.idle_cpus_mask,
> > +       for_each_cpu_and(ilb, get_nohz()->idle_cpus_mask,
> >                               housekeeping_cpumask(HK_FLAG_MISC)) {
> >
> >                 if (ilb == smp_processor_id())
> > @@ -10243,7 +10257,7 @@ static void kick_ilb(unsigned int flags)
> >          * not if we only update stats.
> >          */
> >         if (flags & NOHZ_BALANCE_KICK)
> > -               nohz.next_balance = jiffies+1;
> > +               get_nohz()->next_balance = jiffies+1;
> >
> >         ilb_cpu = find_new_ilb();
> >
> > @@ -10291,14 +10305,14 @@ static void nohz_balancer_kick(struct rq *rq)
> >          * None are in tickless mode and hence no need for NOHZ idle load
> >          * balancing.
> >          */
> > -       if (likely(!atomic_read(&nohz.nr_cpus)))
> > +       if (likely(!atomic_read(&get_nohz()->nr_cpus)))
> >                 return;
> >
> > -       if (READ_ONCE(nohz.has_blocked) &&
> > -           time_after(now, READ_ONCE(nohz.next_blocked)))
> > +       if (READ_ONCE(get_nohz()->has_blocked) &&
> > +           time_after(now, READ_ONCE(get_nohz()->next_blocked)))
> >                 flags = NOHZ_STATS_KICK;
> >
> > -       if (time_before(now, nohz.next_balance))
> > +       if (time_before(now, get_nohz()->next_balance))
> >                 goto out;
> >
> >         if (rq->nr_running >= 2) {
> > @@ -10328,7 +10342,7 @@ static void nohz_balancer_kick(struct rq *rq)
> >                  * currently idle; in which case, kick the ILB to move tasks
> >                  * around.
> >                  */
> > -               for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
> > +               for_each_cpu_and(i, sched_domain_span(sd), get_nohz()->idle_cpus_mask) {
> >                         if (sched_asym_prefer(i, cpu)) {
> >                                 flags = NOHZ_KICK_MASK;
> >                                 goto unlock;
> > @@ -10405,8 +10419,8 @@ void nohz_balance_exit_idle(struct rq *rq)
> >                 return;
> >
> >         rq->nohz_tick_stopped = 0;
> > -       cpumask_clear_cpu(rq->cpu, nohz.idle_cpus_mask);
> > -       atomic_dec(&nohz.nr_cpus);
> > +       cpumask_clear_cpu(rq->cpu, get_nohz()->idle_cpus_mask);
> > +       atomic_dec(&get_nohz()->nr_cpus);
> >
> >         set_cpu_sd_state_busy(rq->cpu);
> >  }
> > @@ -10467,8 +10481,8 @@ void nohz_balance_enter_idle(int cpu)
> >
> >         rq->nohz_tick_stopped = 1;
> >
> > -       cpumask_set_cpu(cpu, nohz.idle_cpus_mask);
> > -       atomic_inc(&nohz.nr_cpus);
> > +       cpumask_set_cpu(cpu, get_nohz()->idle_cpus_mask);
> > +       atomic_inc(&get_nohz()->nr_cpus);
> >
> >         /*
> >          * Ensures that if nohz_idle_balance() fails to observe our
> > @@ -10484,7 +10498,7 @@ void nohz_balance_enter_idle(int cpu)
> >          * Each time a cpu enter idle, we assume that it has blocked load and
> >          * enable the periodic update of the load of idle cpus
> >          */
> > -       WRITE_ONCE(nohz.has_blocked, 1);
> > +       WRITE_ONCE(get_nohz()->has_blocked, 1);
> >  }
> >
> >  static bool update_nohz_stats(struct rq *rq)
> > @@ -10494,7 +10508,7 @@ static bool update_nohz_stats(struct rq *rq)
> >         if (!rq->has_blocked_load)
> >                 return false;
> >
> > -       if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
> > +       if (!cpumask_test_cpu(cpu, get_nohz()->idle_cpus_mask))
> >                 return false;
> >
> >         if (!time_after(jiffies, READ_ONCE(rq->last_blocked_load_update_tick)))
> > @@ -10532,7 +10546,7 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
> >          * setting the flag, we are sure to not clear the state and not
> >          * check the load of an idle cpu.
> >          */
> > -       WRITE_ONCE(nohz.has_blocked, 0);
> > +       WRITE_ONCE(get_nohz()->has_blocked, 0);
> >
> >         /*
> >          * Ensures that if we miss the CPU, we must see the has_blocked
> > @@ -10544,10 +10558,7 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
> >          * Start with the next CPU after this_cpu so we will end with this_cpu and let a
> >          * chance for other idle cpu to pull load.
> >          */
> > -       for_each_cpu_wrap(balance_cpu,  nohz.idle_cpus_mask, this_cpu+1) {
> > -               if (!idle_cpu(balance_cpu))
> > -                       continue;
> > -
> > +       for_each_cpu_wrap(balance_cpu,  get_nohz()->idle_cpus_mask, this_cpu+1) {
> >                 /*
> >                  * If this CPU gets work to do, stop the load balancing
> >                  * work being done for other CPUs. Next load
> > @@ -10558,6 +10569,9 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
> >                         goto abort;
> >                 }
> >
> > +               if (!idle_cpu(balance_cpu))
> > +                       continue;
>
> The move of this test seems to be out of the scope of the patch subject
>
> > +
> >                 rq = cpu_rq(balance_cpu);
> >
> >                 has_blocked_load |= update_nohz_stats(rq);
> > @@ -10589,15 +10603,15 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
> >          * updated.
> >          */
> >         if (likely(update_next_balance))
> > -               nohz.next_balance = next_balance;
> > +               get_nohz()->next_balance = next_balance;
> >
> > -       WRITE_ONCE(nohz.next_blocked,
> > +       WRITE_ONCE(get_nohz()->next_blocked,
> >                 now + msecs_to_jiffies(LOAD_AVG_PERIOD));
> >
> >  abort:
> >         /* There is still blocked load, enable periodic update */
> >         if (has_blocked_load)
> > -               WRITE_ONCE(nohz.has_blocked, 1);
> > +               WRITE_ONCE(get_nohz()->has_blocked, 1);
> >  }
> >
> >  /*
> > @@ -10655,8 +10669,8 @@ static void nohz_newidle_balance(struct rq *this_rq)
> >                 return;
> >
> >         /* Don't need to update blocked load of idle CPUs*/
> > -       if (!READ_ONCE(nohz.has_blocked) ||
> > -           time_before(jiffies, READ_ONCE(nohz.next_blocked)))
> > +       if (!READ_ONCE(get_nohz()->has_blocked) ||
> > +           time_before(jiffies, READ_ONCE(get_nohz()->next_blocked)))
> >                 return;
> >
> >         /*
> > @@ -11573,9 +11587,29 @@ __init void init_sched_fair_class(void)
> >         open_softirq(SCHED_SOFTIRQ, run_rebalance_domains);
> >
> >  #ifdef CONFIG_NO_HZ_COMMON
> > -       nohz.next_balance = jiffies;
> > -       nohz.next_blocked = jiffies;
> > -       zalloc_cpumask_var(&nohz.idle_cpus_mask, GFP_NOWAIT);
> > +       if (static_branch_unlikely(&housekeeping_overridden)) {
> > +               struct nohz *nohz;
> > +
> > +               nohz_nodes = kcalloc(1, sizeof(struct nohz *), GFP_NOWAIT);
> > +               nohz = kmalloc(sizeof(struct nohz), GFP_NOWAIT);
> > +               nohz->next_balance = jiffies;
> > +               nohz->next_blocked = jiffies;
> > +               zalloc_cpumask_var(&nohz->idle_cpus_mask, GFP_NOWAIT);
> > +               nohz_nodes[0] = nohz;
> > +       } else {
> > +               int n;
> > +
> > +               nohz_nodes = kcalloc(nr_node_ids, sizeof(struct nohz *), GFP_NOWAIT);
> > +               for_each_node(n) {
> > +                       struct nohz *nohz;
> > +
> > +                       nohz = kmalloc_node(sizeof(struct nohz), GFP_NOWAIT, n);
> > +                       nohz->next_balance = jiffies;
> > +                       nohz->next_blocked = jiffies;
> > +                       zalloc_cpumask_var_node(&nohz->idle_cpus_mask, GFP_NOWAIT, n);
> > +                       nohz_nodes[n] = nohz;
> > +               }
> > +       }
> >  #endif
> >  #endif /* SMP */
> >
> > --
> > 2.23.0
> >
