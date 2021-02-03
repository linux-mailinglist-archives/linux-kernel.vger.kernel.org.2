Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB2430DAC4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhBCNNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhBCNNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:13:43 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5EFC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 05:13:03 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id f2so28190177ljp.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 05:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z+dkbl6T4z+R7b8FTGLPujhZ/RM2EN7Df6fbF55KFk8=;
        b=sC+eYfG5dEALRACZYrgOtVwHqWYFOYPWEg2wo0vm6FKRcophbUUYQWtCaA/iPIlM8D
         w9gKOtz/KimlRQyWQu3ii1uKK5wrERGEXLzNHANBksEiYI4VSwX4LE5kCA6ykFFUPJrA
         ec/O14fKb4stxOXsHdN9v3VKlJ2Or3p20wr+0jwDnSbvIe+YFx62L6i26cGqoHBHW7Ry
         6q4OrDiAqCFkguI85tB3UFwKnM5nEqm1UN5V5aR+I+X/zUeHRETja+OCMlHdqVyCwMnJ
         c6Pz/gggj6uDkffPcg6Hsz4jaZ5CJGXALa8Hy2uIq43F3myiNrCfLD+S5P+4gH18erv1
         euTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z+dkbl6T4z+R7b8FTGLPujhZ/RM2EN7Df6fbF55KFk8=;
        b=tuIwrHmpeyaplyqLZoXldhWkU706LwaEvIcCaajfDdNeQuVcDf2kl0N0cx6QKFWFvM
         PeU+2QvKvz0bD9kdVqc+tXgNoJF5wnspClZ1h4IS1XAbmuSPTFwDoXX2RRkV/JAWq9qp
         J2rSvi8rUDQfywzhNvj7Zibc2FT6dsDtgLqlUFhanfg6Zgn7f+CQi5yny6EFzR/nPXrt
         z7hIz4xnLFwiz0f5Zo8cz35JLIzmQ+h7PoeFOVDDiR3ZfBn0ZlkRv1Gy0EdBfMlXIcxZ
         oUxqF0zKhB2e0HnPmMjTei06MrI9dMkqV6Ho9u/b9a1IaRR6u5y3CNOheBIsmW8QIKOL
         CPLg==
X-Gm-Message-State: AOAM533ISaAoI0pXWzDpBgeATgoyHC+dODJV9V75XCVgXhgCvnifi2g0
        sXD6Ijcs5MovhI8Fm4nbutPakWhMmtwxLlUpyJStazLvUSHSwA==
X-Google-Smtp-Source: ABdhPJwTMppGUexiCLr9BGDewDfA32wFqd/b8sEPcgbCPfDobrASbX6U+bntb6VNgzFmt8R1rHODGYfy4AS24GadtdA=
X-Received: by 2002:a2e:988d:: with SMTP id b13mr1671354ljj.176.1612357981438;
 Wed, 03 Feb 2021 05:13:01 -0800 (PST)
MIME-Version: 1.0
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
 <YAsjOqmo7TEeXjoj@google.com> <CAKfTPtBWoRuwwkaqQKNgHTnQBE4fevyYqEoeGc5RpCsBbOS1sQ@mail.gmail.com>
 <YBG0W5PFGtGRCEuB@google.com> <CAKfTPtBqj5A_7QmxhhmkNTc3+VT6+AqWgw1GDYrgy1V5+PJMmQ@mail.gmail.com>
 <CAEXW_YRrhEfGcLN5yrLJZm6HrB15M_R5xfpMReG2wE2rSmVWdA@mail.gmail.com>
 <CAKfTPtBvwm9vZb5C=2oTF6N-Ht6Rvip4Lv18yi7O3G8e-_ZWdg@mail.gmail.com>
 <20210129172727.GA30719@vingu-book> <09367fac-5184-56d1-3c86-998b5f2af838@arm.com>
In-Reply-To: <09367fac-5184-56d1-3c86-998b5f2af838@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 3 Feb 2021 14:12:49 +0100
Message-ID: <CAKfTPtCg9pTU6JFpV7+skRXT7gacJzJ5eLJwnOdEFQPuf6vKOw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Rate limit calls to update_blocked_averages()
 for NOHZ
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Qais Yousef <qais.yousef@arm.com>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Feb 2021 at 12:54, Dietmar Eggemann <dietmar.eggemann@arm.com> wr=
ote:
>
> On 29/01/2021 18:27, Vincent Guittot wrote:
> > Le vendredi 29 janv. 2021 =C3=AF=C2=BF=C2=BD 11:33:00 (+0100), Vincent =
Guittot a =C3=AF=C2=BF=C2=BDcrit :
> >> On Thu, 28 Jan 2021 at 16:09, Joel Fernandes <joel@joelfernandes.org> =
wrote:
> >>>
> >>> Hi Vincent,
> >>>
> >>> On Thu, Jan 28, 2021 at 8:57 AM Vincent Guittot
> >>> <vincent.guittot@linaro.org> wrote:
> >>>>> On Mon, Jan 25, 2021 at 03:42:41PM +0100, Vincent Guittot wrote:
> >>>>>> On Fri, 22 Jan 2021 at 20:10, Joel Fernandes <joel@joelfernandes.o=
rg> wrote:
> >>>>>>> On Fri, Jan 22, 2021 at 05:56:22PM +0100, Vincent Guittot wrote:
> >>>>>>>> On Fri, 22 Jan 2021 at 16:46, Joel Fernandes (Google)
> >>>>>>>> <joel@joelfernandes.org> wrote:
>
> [...]
>
> >> The only point that I agree with, is that running
> >> update_blocked_averages with preempt and irq off is not a good thing
> >> because we don't manage the number of csf_rq to update and I'm going
> >> to provide a patchset for this
> >
> > The patch below moves the update of the blocked load of CPUs outside ne=
widle_balance().
> >
> > Instead, the update is done with the usual idle load balance update. I'=
m working on an
> > additonnal patch that will select this cpu that is about to become idle=
, instead of a
> > random idle cpu but this 1st step fixe the problem of lot of update in =
newly idle.
>
> I'm trying to understand the need for this extra patch.
>
> The patch below moves away from doing update_blocked_averages() (1) for
> all CPUs in sched groups of the sched domain:
>
> newidle_balance()->load_balance()->
> find_busiest_group()->update_sd_lb_stats()->update_sg_lb_stats()
>
> to:
>
> calling (1) for CPUs in nohz.idle_cpus_mask in _nohz_idle_balance() via
> update_nohz_stats() and for the ilb CPU.
>
> newidle_balance() calls (1) for newidle CPU already.
>
> What would be the benefit to choose newidle CPU as ilb CPU?

To prevent waking up another idle cpu to run the update whereas
newidle cpu is already woken up and about to be idle so the best
candidate.
All the aim of the removed code was to prevent waking up an idle cpu
for doing something that could be done by the newidle cpu before it
enters idle state

>
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
> > @@ -8426,9 +8424,6 @@ static inline void update_sg_lb_stats(struct lb_e=
nv *env,
> >       for_each_cpu_and(i, sched_group_span(group), env->cpus) {
> >               struct rq *rq =3D cpu_rq(i);
> >
> > -             if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq=
, false))
> > -                     env->flags |=3D LBF_NOHZ_AGAIN;
> > -
> >               sgs->group_load +=3D cpu_load(rq);
> >               sgs->group_util +=3D cpu_util(i);
> >               sgs->group_runnable +=3D cpu_runnable(rq);
> > @@ -8969,11 +8964,6 @@ static inline void update_sd_lb_stats(struct lb_=
env *env, struct sd_lb_stats *sd
> >       struct sg_lb_stats tmp_sgs;
> >       int sg_status =3D 0;
> >
> > -#ifdef CONFIG_NO_HZ_COMMON
> > -     if (env->idle =3D=3D CPU_NEWLY_IDLE && READ_ONCE(nohz.has_blocked=
))
> > -             env->flags |=3D LBF_NOHZ_STATS;
> > -#endif
> > -
> >       do {
> >               struct sg_lb_stats *sgs =3D &tmp_sgs;
> >               int local_group;
> > @@ -9010,15 +9000,6 @@ static inline void update_sd_lb_stats(struct lb_=
env *env, struct sd_lb_stats *sd
> >       /* Tag domain that child domain prefers tasks go to siblings firs=
t */
> >       sds->prefer_sibling =3D child && child->flags & SD_PREFER_SIBLING=
;
> >
> > -#ifdef CONFIG_NO_HZ_COMMON
> > -     if ((env->flags & LBF_NOHZ_AGAIN) &&
> > -         cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd=
))) {
> > -
> > -             WRITE_ONCE(nohz.next_blocked,
> > -                        jiffies + msecs_to_jiffies(LOAD_AVG_PERIOD));
> > -     }
> > -#endif
> > -
> >       if (env->sd->flags & SD_NUMA)
> >               env->fbq_type =3D fbq_classify_group(&sds->busiest_stat);
> >
> > @@ -10547,14 +10528,7 @@ static void nohz_newidle_balance(struct rq *th=
is_rq)
> >               return;
> >
> >       raw_spin_unlock(&this_rq->lock);
> > -     /*
> > -      * This CPU is going to be idle and blocked load of idle CPUs
> > -      * need to be updated. Run the ilb locally as it is a good
> > -      * candidate for ilb instead of waking up another idle CPU.
> > -      * Kick an normal ilb if we failed to do the update.
> > -      */
> > -     if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE)=
)
> > -             kick_ilb(NOHZ_STATS_KICK);
> > +     kick_ilb(NOHZ_STATS_KICK);
> >       raw_spin_lock(&this_rq->lock);
> >  }
> >
> > @@ -10616,8 +10590,6 @@ static int newidle_balance(struct rq *this_rq, =
struct rq_flags *rf)
> >                       update_next_balance(sd, &next_balance);
> >               rcu_read_unlock();
> >
> > -             nohz_newidle_balance(this_rq);
> > -
> >               goto out;
> >       }
> >
> > @@ -10683,6 +10655,8 @@ static int newidle_balance(struct rq *this_rq, =
struct rq_flags *rf)
> >
> >       if (pulled_task)
> >               this_rq->idle_stamp =3D 0;
> > +     else
> > +             nohz_newidle_balance(this_rq);
> >
> >       rq_repin_lock(this_rq, rf);
