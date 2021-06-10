Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F0F3A22D6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 05:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhFJDgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 23:36:00 -0400
Received: from mail-yb1-f174.google.com ([209.85.219.174]:39733 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhFJDf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 23:35:58 -0400
Received: by mail-yb1-f174.google.com with SMTP id n133so38635359ybf.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 20:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qzSAXRjKH3O+mH9NFlypHY0IEGP5i5bv4cjKhj9mCw4=;
        b=XJd//JzbOWsBig7SqXjsTt2Dqk/QijXi8+J1uepKEBD3TPbKfcpJx9oIDGRaicAtTd
         0fL3KASdC+S0yrJ+kWBLKvugvrDURvqrI902f6+rJ3idaX4TiQgyrqkbzD3WcPe5jnMa
         IsIxba6H5KXfFrwZLip06z/qlGsoi+qCaPX59ttMVxU4qmPsnmzR8qr+fXvgnaCBSoBD
         r44n0I98DFIHFM9GCc9VvstsCkbrzJsrBfBzD6nqfMwgOK1n+WI+fB7JgsO19za+znYi
         000zALfbXSmYZwkFbFrY3qYIgzB8XaZIzi2n1R9Vm7/eZ3Xal906JsjJqGZlYPHGLIFo
         UaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qzSAXRjKH3O+mH9NFlypHY0IEGP5i5bv4cjKhj9mCw4=;
        b=ESXyUdCfSA1BiOo/aBNMjkFOSlfR2Q9/wNPXm0/ou/MWUNVgIYh0MdyVdoBT29LQOD
         2L8P2SSybM3K4Dzb+W+QtY1N4FzE18e5y3xYCu20owOt1WXuETAJ5CK8WY9skr5/VINa
         MhWTjm2i/pFR0Dgb1dVz01Wb+9D5vNBpzgevCwsBQHwX7Gs+qsutRMFBwh4MYlnIDsr8
         +m0VyatUxtIw2m/LtZkf/MMqyfZUsj8eT8m3LJTNaasLyRYdsGBGX6ov+1573n+E6kOQ
         8k7CN5JTn18gg+D/33ZuOti1zxJwe8+tIGLN/HHFbiOfwwyxpABK7ds9cJKBjHZtX++w
         b9dg==
X-Gm-Message-State: AOAM530Cr9+P5CIuinXjj/uNAFKxUsvtjKy9fDbmv7PdUYiSGDnWqoaD
        NLbWdo/HemfIxKg/4kEnPd0XdxC7afDjKOc/RBCk2w==
X-Google-Smtp-Source: ABdhPJw23c1/2hamtSBsFiwLWMZ/sSCyDME0iq+6mzdj5ZM2t8+Lz9dLO9MS/Gu0IMqmaBmuJsIgVIxUj+6FEDipTO4=
X-Received: by 2002:a25:74c6:: with SMTP id p189mr4585914ybc.84.1623295982271;
 Wed, 09 Jun 2021 20:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210608190336.77380-1-hannes@cmpxchg.org>
In-Reply-To: <20210608190336.77380-1-hannes@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 9 Jun 2021 20:32:51 -0700
Message-ID: <CAJuCfpHkug8t+yR+dtudANjJgzGs_T4v8_5fEoR0tg7Tw3h3bQ@mail.gmail.com>
Subject: Re: [PATCH] psi: fix sampling artifact from pressure file read frequency
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jared Pochtar <jpochtar@fb.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 12:03 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Currently, every time a psi pressure file is read, the per-cpu states
> are collected and aggregated according to the CPU's non-idle time
> weight. This dynamically changes the sampling period, which means read
> frequency can introduce variance into the observed results. This is
> somewhat unexpected for users and can be confusing, when e.g. two
> nested cgroups with the same workload report different pressure levels
> just because they have different consumers reading the pressure files.
>
> Consider the following two CPU timelines:
>
>         CPU0: [ STALL ] [ SLEEP ]
>         CPU1: [  RUN  ] [  RUN  ]
>
> If we sample and aggregate once for the whole period, we get the
> following total stall time for CPU0:
>
>         CPU0 = stall(1) + nonidle(1) / nonidle_total(3) = 0.3
>
> But if we sample twice, the total for the period is higher:
>
>         CPU0 = stall(1) + nonidle(1) / nonidle_total(2) = 0.5
>         CPU0 = stall(0) + nonidle(0) / nonidle_total(1) = 0
>                                                           ---
>                                                           0.5
>
> Neither answer is inherently wrong: if the user asks for pressure
> after half the period, we can't know yet that the CPU will go to sleep
> right after and its weight would be lower over the combined period.
>
> We could normalize the weight averaging to a fixed window regardless
> of how often stall times themselves are sampled. But that would make
> reporting less adaptive to sudden changes when the user intentionally
> uses poll() with short intervals in order to get a higher resolution.
>
> For now, simply limit sampling of the pressure file contents to the
> fixed two-second period already used by the aggregation worker.

Hmm. This is tricky. So, userspace-visible effect of this change is
that totals will not update when the psi file is read unless the
psi_period expires. We used to postpone updating only the averages and
now the totals will follow suit. Not sure if presenting stale data is
better than having this dependency on timing of the read. As you
noted, the value we get is not inherently wrong. But one could argue
both ways I guess... Having this "quantum" effect when the act of
observation changes the state of the object is indeed weird, to say
the least.
In the paragraph above you say "For now". Do you have an idea that
could solve the issue with totals being stale while removing this
dependency on the timing of reads?

>
> psi_show() still needs to force a catch-up run in case the workload
> went idle and periodic aggregation shut off. Since that can race with
> periodic aggregation, worker and psi_show() need to fully serialize.
> And with sampling becoming exclusive, whoever wins the race must also
> requeue the worker if necessary. Move the locking, the aggregation
> work, and the worker scheduling logic into update_averages(); use that
> from the worker and psi_show().
>
> poll() continues to use the proportional weight sampling window.
>
> Reported-by: Jared Pochtar <jpochtar@fb.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  kernel/sched/psi.c | 83 ++++++++++++++++++++++++----------------------
>  1 file changed, 43 insertions(+), 40 deletions(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index cc25a3cff41f..9d647d974f55 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -358,17 +358,36 @@ static void collect_percpu_times(struct psi_group *group,
>                 *pchanged_states = changed_states;
>  }
>
> -static u64 update_averages(struct psi_group *group, u64 now)
> +static void update_averages(struct psi_group *group)
>  {
>         unsigned long missed_periods = 0;
> -       u64 expires, period;
> -       u64 avg_next_update;
> +       u64 now, expires, period;
> +       u32 changed_states;
>         int s;
>
>         /* avgX= */
> +       mutex_lock(&group->avgs_lock);
> +
> +       now = sched_clock();
>         expires = group->avg_next_update;
> -       if (now - expires >= psi_period)
> -               missed_periods = div_u64(now - expires, psi_period);
> +
> +       /*
> +        * Periodic aggregation.
> +        *
> +        * When tasks in the group are active, we make sure to
> +        * aggregate per-cpu samples and calculate the running
> +        * averages at exactly once per PSI_FREQ period.
> +        *
> +        * When tasks go idle, there is no point in keeping the
> +        * workers running, so we shut them down too. Once restarted,
> +        * we backfill zeroes for the missed periods in calc_avgs().
> +        *
> +        * We can get here from inside the aggregation worker, but
> +        * also from psi_show() as userspace may query pressure files
> +        * of an idle group whose aggregation worker shut down.
> +        */
> +       if (now < expires)
> +               goto unlock;
>
>         /*
>          * The periodic clock tick can get delayed for various
> @@ -377,10 +396,13 @@ static u64 update_averages(struct psi_group *group, u64 now)
>          * But the deltas we sample out of the per-cpu buckets above
>          * are based on the actual time elapsing between clock ticks.
>          */
> -       avg_next_update = expires + ((1 + missed_periods) * psi_period);
> +       if (now - expires >= psi_period)
> +               missed_periods = div_u64(now - expires, psi_period);
>         period = now - (group->avg_last_update + (missed_periods * psi_period));
>         group->avg_last_update = now;
> +       group->avg_next_update = expires + ((1 + missed_periods) * psi_period);
>
> +       collect_percpu_times(group, PSI_AVGS, &changed_states);
>         for (s = 0; s < NR_PSI_STATES - 1; s++) {
>                 u32 sample;
>
> @@ -408,42 +430,25 @@ static u64 update_averages(struct psi_group *group, u64 now)
>                 calc_avgs(group->avg[s], missed_periods, sample, period);
>         }
>
> -       return avg_next_update;
> +       if (changed_states & (1 << PSI_NONIDLE)) {
> +               unsigned long delay;
> +
> +               delay = nsecs_to_jiffies(group->avg_next_update - now) + 1;
> +               schedule_delayed_work(&group->avgs_work, delay);
> +       }
> +unlock:
> +       mutex_unlock(&group->avgs_lock);
>  }
>
>  static void psi_avgs_work(struct work_struct *work)
>  {
>         struct delayed_work *dwork;
>         struct psi_group *group;
> -       u32 changed_states;
> -       bool nonidle;
> -       u64 now;
>
>         dwork = to_delayed_work(work);
>         group = container_of(dwork, struct psi_group, avgs_work);
>
> -       mutex_lock(&group->avgs_lock);
> -
> -       now = sched_clock();
> -
> -       collect_percpu_times(group, PSI_AVGS, &changed_states);
> -       nonidle = changed_states & (1 << PSI_NONIDLE);
> -       /*
> -        * If there is task activity, periodically fold the per-cpu
> -        * times and feed samples into the running averages. If things
> -        * are idle and there is no data to process, stop the clock.
> -        * Once restarted, we'll catch up the running averages in one
> -        * go - see calc_avgs() and missed_periods.
> -        */
> -       if (now >= group->avg_next_update)
> -               group->avg_next_update = update_averages(group, now);
> -
> -       if (nonidle) {
> -               schedule_delayed_work(dwork, nsecs_to_jiffies(
> -                               group->avg_next_update - now) + 1);
> -       }
> -
> -       mutex_unlock(&group->avgs_lock);
> +       update_averages(group);
>  }
>
>  /* Trigger tracking window manipulations */
> @@ -1029,18 +1034,16 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
>  int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
>  {
>         int full;
> -       u64 now;
>
>         if (static_branch_likely(&psi_disabled))
>                 return -EOPNOTSUPP;
>
> -       /* Update averages before reporting them */
> -       mutex_lock(&group->avgs_lock);
> -       now = sched_clock();
> -       collect_percpu_times(group, PSI_AVGS, NULL);
> -       if (now >= group->avg_next_update)
> -               group->avg_next_update = update_averages(group, now);
> -       mutex_unlock(&group->avgs_lock);
> +       /*
> +        * Periodic aggregation should do all the sampling for us, but
> +        * if the workload goes idle, the worker goes to sleep before
> +        * old stalls may have averaged out. Backfill any idle zeroes.
> +        */
> +       update_averages(group);
>
>         for (full = 0; full < 2; full++) {
>                 unsigned long avg[3];
> --
> 2.32.0
>
