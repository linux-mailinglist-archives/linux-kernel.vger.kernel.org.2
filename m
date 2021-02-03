Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2815030E130
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 18:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhBCRgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 12:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhBCRgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 12:36:37 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176A7C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 09:35:57 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id h12so310055lfp.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 09:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rdbvr6q1AUF3w3UA5/GMptlQ7CkT3De3JWK5P1u/uhA=;
        b=T0BxF/7ecPd29IlU7GmgX7mXSdM64fMLqsJAdK2bv8d37r2z+WL4/72qANVI8dntjB
         y0Zp0DXmcpcjuzJaYde+20K7pe9nbW6Ma3X/vlZfC+t71S0bQ7WKsB3BesCKn944ZBtX
         GSHFDsuwx6yf3KasR8G00T86SigEp5xhJCrNJJSJr9S9//K7cBF2F2B+CGG11N8iEVq0
         8pIf/HVNGWog9HwrFf9x4TwtHwuXum5CRRAtTfaDF/r4SKQ4XatxSNM/QS7x7SNbjbZr
         cFv5Qprlo4xPAt4MGytL7j7EiXDkt0yUwXmKgsNmqH2/dugCNJa0FWLB6CQRQaAbuhNN
         iIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rdbvr6q1AUF3w3UA5/GMptlQ7CkT3De3JWK5P1u/uhA=;
        b=Zyi5Z0huBr/B/Y2fjkFHIxNVoA6EHJo8MD81xSiZHJI5eBX6R6/Gi93mbCwF24jxFQ
         hUsX8zwsQmysam+jcIjRro2fAIwpCwn0d4ZaLYKB4eeCfhtCxVYpPqV8vRszRe98ZE0Z
         2v1l7SSod81CQSzVRDFviteLPpVhUQ9U8iec09Djr+TMeuRXwkM+sigiKy6j/GxpbZcC
         JyvPU7KK4f2U3wRHBM0Gtw2hJQcfchxPQoOMUwaP3bJITAt+34onKHvt+sf1qofICzPs
         zhH1pPuvrDPwPLwUm48sj9LfOlAWZLRbPUhkmI2w+W/OqzUQYK/IrYfPl6LHv8rEcsvr
         3Khw==
X-Gm-Message-State: AOAM533w7jFPUciik78GrDBMWnVb32zi/RhliCOMw3ycMIycp/GNWuMh
        g96HyARdTsDQvzK/aPnyml0s30Gf8NLtX3VHm0dHXw==
X-Google-Smtp-Source: ABdhPJwgW8lH2ra3EiCeODfXvdVRzNwGjaylsLVN/OtcqQHhkqKXsUwN/O79o5mjKv5zAuKvewt3ZDkxntJIs7FD78M=
X-Received: by 2002:ac2:42d5:: with SMTP id n21mr2365780lfl.154.1612373755465;
 Wed, 03 Feb 2021 09:35:55 -0800 (PST)
MIME-Version: 1.0
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
 <YAsjOqmo7TEeXjoj@google.com> <CAKfTPtBWoRuwwkaqQKNgHTnQBE4fevyYqEoeGc5RpCsBbOS1sQ@mail.gmail.com>
 <YBG0W5PFGtGRCEuB@google.com> <CAKfTPtBqj5A_7QmxhhmkNTc3+VT6+AqWgw1GDYrgy1V5+PJMmQ@mail.gmail.com>
 <CAEXW_YRrhEfGcLN5yrLJZm6HrB15M_R5xfpMReG2wE2rSmVWdA@mail.gmail.com>
 <CAKfTPtBvwm9vZb5C=2oTF6N-Ht6Rvip4Lv18yi7O3G8e-_ZWdg@mail.gmail.com>
 <20210129172727.GA30719@vingu-book> <20210203170916.ows7d2b56t34i2w4@e107158-lin>
In-Reply-To: <20210203170916.ows7d2b56t34i2w4@e107158-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 3 Feb 2021 18:35:43 +0100
Message-ID: <CAKfTPtAZNLCfnuzFTU1DedL6EqpVWD6KjUZDGNQOOQwV7AfiVA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Rate limit calls to update_blocked_averages()
 for NOHZ
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Dietmar Eggeman <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Feb 2021 at 18:09, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 01/29/21 18:27, Vincent Guittot wrote:
> > The patch below moves the update of the blocked load of CPUs outside newidle_balance().
> >
> > Instead, the update is done with the usual idle load balance update. I'm working on an
> > additonnal patch that will select this cpu that is about to become idle, instead of a
> > random idle cpu but this 1st step fixe the problem of lot of update in newly idle.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 32 +++-----------------------------
> >  1 file changed, 3 insertions(+), 29 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 197a51473e0c..8200b1d4df3d 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7421,8 +7421,6 @@ enum migration_type {
> >  #define LBF_NEED_BREAK       0x02
> >  #define LBF_DST_PINNED  0x04
> >  #define LBF_SOME_PINNED      0x08
> > -#define LBF_NOHZ_STATS       0x10
> > -#define LBF_NOHZ_AGAIN       0x20
> >
> >  struct lb_env {
> >       struct sched_domain     *sd;
> > @@ -8426,9 +8424,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >       for_each_cpu_and(i, sched_group_span(group), env->cpus) {
> >               struct rq *rq = cpu_rq(i);
> >
> > -             if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq, false))
> > -                     env->flags |= LBF_NOHZ_AGAIN;
> > -
> >               sgs->group_load += cpu_load(rq);
> >               sgs->group_util += cpu_util(i);
> >               sgs->group_runnable += cpu_runnable(rq);
> > @@ -8969,11 +8964,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> >       struct sg_lb_stats tmp_sgs;
> >       int sg_status = 0;
> >
> > -#ifdef CONFIG_NO_HZ_COMMON
> > -     if (env->idle == CPU_NEWLY_IDLE && READ_ONCE(nohz.has_blocked))
> > -             env->flags |= LBF_NOHZ_STATS;
> > -#endif
> > -
> >       do {
> >               struct sg_lb_stats *sgs = &tmp_sgs;
> >               int local_group;
> > @@ -9010,15 +9000,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> >       /* Tag domain that child domain prefers tasks go to siblings first */
> >       sds->prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
> >
> > -#ifdef CONFIG_NO_HZ_COMMON
> > -     if ((env->flags & LBF_NOHZ_AGAIN) &&
> > -         cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd))) {
> > -
> > -             WRITE_ONCE(nohz.next_blocked,
> > -                        jiffies + msecs_to_jiffies(LOAD_AVG_PERIOD));
> > -     }
> > -#endif
> > -
> >       if (env->sd->flags & SD_NUMA)
> >               env->fbq_type = fbq_classify_group(&sds->busiest_stat);
> >
> > @@ -10547,14 +10528,7 @@ static void nohz_newidle_balance(struct rq *this_rq)
> >               return;
> >
> >       raw_spin_unlock(&this_rq->lock);
> > -     /*
> > -      * This CPU is going to be idle and blocked load of idle CPUs
> > -      * need to be updated. Run the ilb locally as it is a good
> > -      * candidate for ilb instead of waking up another idle CPU.
> > -      * Kick an normal ilb if we failed to do the update.
> > -      */
> > -     if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
>
> Since we removed the call to this function (which uses this_rq)
>
> > -             kick_ilb(NOHZ_STATS_KICK);
> > +     kick_ilb(NOHZ_STATS_KICK);
>
> And unconditionally call kick_ilb() which will find a suitable cpu to run the
> lb at regardless what this_rq is.
>
> Doesn't the below become unnecessary now?

The end goal is to keep running on this cpu that is about to become idle.

This patch is mainly  there to check that Joel's problem disappears if
the update of the blocked load of the cpus is not done in the
newidle_balance context. I'm preparing few other patches on top to
clean up the full path

>
>           10494         /*
>           10495          * This CPU doesn't want to be disturbed by scheduler
>           10496          * housekeeping
>           10497          */
>           10498         if (!housekeeping_cpu(this_cpu, HK_FLAG_SCHED))
>           10499                 return;
>           10500
>           10501         /* Will wake up very soon. No time for doing anything else*/
>           10502         if (this_rq->avg_idle < sysctl_sched_migration_cost)
>           10503                 return;
>
> And we can drop this_rq arg altogether?
>
> >       raw_spin_lock(&this_rq->lock);
> >  }
> >
> > @@ -10616,8 +10590,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >                       update_next_balance(sd, &next_balance);
> >               rcu_read_unlock();
> >
> > -             nohz_newidle_balance(this_rq);
> > -
> >               goto out;
> >       }
> >
> > @@ -10683,6 +10655,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >
> >       if (pulled_task)
> >               this_rq->idle_stamp = 0;
> > +     else
> > +             nohz_newidle_balance(this_rq);
>
> Since nohz_newidle_balance() will not do any real work now, I couldn't figure
> out what moving this here achieves. Fault from my end to parse the change most
> likely :-)

The goal is to schedule the update only if we are about to be idle and
nothing else has been queued in the meantime

>
> Joel can still test this patch as is of course. This is just an early review
> since I already spent the time trying to understand it.
>
> Thanks
>
> --
> Qais Yousef
>
> >
> >       rq_repin_lock(this_rq, rf);
> >
> > --
> > 2.17.1
