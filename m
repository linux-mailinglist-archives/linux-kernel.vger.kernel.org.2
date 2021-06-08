Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6013A0534
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 22:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbhFHUn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 16:43:26 -0400
Received: from mail-yb1-f180.google.com ([209.85.219.180]:42774 "EHLO
        mail-yb1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbhFHUnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 16:43:22 -0400
Received: by mail-yb1-f180.google.com with SMTP id g142so12787591ybf.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 13:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G5rt0SuV4v7HioKPjTFjsxj4kEbwteAs2JcYkML14m8=;
        b=bQYUegfmqqQTD4hYvYL9VlKvkTAVaf8zqi+SrxfSvcBvwIPq7S+QpRyqxwsejqv7rf
         COASdedYItD7EdJ5TDMohqNB0NCfFU8NNkoFRM0EL/YvcNr/+mowmQ3Ctuujr5bnx5QD
         rY5Hy4wBcgWdfLSCblG9fFDkI6ELzyBfwCTIB3LnTuEqitVmqjzgBt9RJfGaGg3VFesF
         5WIKEQdINL9nq3RwQPc/ORsZhuiS4tQpSFPNF7YYLLptyOEZffyGK+Im2X/nNDfUpq0d
         r1nFWrc9vISr2E4Z8Qrl2Q8KQ3FvKZVxINMtZVW5NTiQ4jKIxrCt5rex2ms4uKtcv258
         +jTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G5rt0SuV4v7HioKPjTFjsxj4kEbwteAs2JcYkML14m8=;
        b=X4b/y/pNXKvRu16djQWYnf5GkC97KAXnX88IpXxPRr9rrZ9iQEKutACDad7dhkEBWH
         QvrgZLOVGGEpcuk8vfLENKiE3xkMf0XgQOWgF4EMrsWF7oZw6btTcMr44DgUbGojDGBP
         dD0GQWhubzkh7B+IHHFxslyMvbW4ODX8A38euOVVbSDIYmTxnvyIr5caa/GQMevh0sSU
         fdKbkqc6xVUr+yA+SEnPsIzPJ4/PzhIxFs9IB48xktLhqMfSPTa5zSmFv0jvkpv2IhyB
         OH5cQwIqJeNxKvBxJ4fDvTtKgDMxmLXHN+kwTNs1jySHlTvJiqKjm5zkLYoz7YzQ0vlK
         WfxQ==
X-Gm-Message-State: AOAM533uxwFpFTZAMMT2LozlaXHA3KRcJHVl2OTheNRDwcMJ1ezLSneS
        0C7A1Kco2pf7zSCSz+nkHfi9cOlsMf7ZT80bcmrpk8nn5qU=
X-Google-Smtp-Source: ABdhPJwlO8LYVjwOc0QYpj/Rmf9RP2Sw03lwpE0L3/J+PO1muXVT45xI/OjeU130cY7E5bLIUFZrZD5R6+3liipzkSY=
X-Received: by 2002:a25:1ec2:: with SMTP id e185mr33876545ybe.23.1623184828403;
 Tue, 08 Jun 2021 13:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210608190452.77486-1-hannes@cmpxchg.org>
In-Reply-To: <20210608190452.77486-1-hannes@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 8 Jun 2021 13:40:17 -0700
Message-ID: <CAJuCfpH_AAgGdgpCuCaz9b511FSoN9F7r-WWE18DhdusHkau-w@mail.gmail.com>
Subject: Re: [PATCH] psi: clean up time collection functions
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 12:04 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> The functions to read the per-cpu time buckets and aggregate them
> don't have the greatest names and an awkward calling convention. Clean
> this up to make things a bit more readable:
>
> - Rename get_recent_times() to read_cpu_states() to make it clearer
>   this is about extracting psi state from one cpu, and not just the
>   times, either. Remove the pchanged_states return parameter and make
>   it the function's return value; rename the local variable 'states',
>   as it doesn't reflect changed states, but currently active ones.
>
> - rename collect_percpu_times() to aggregate_cpus(), to indicate that
>   actual data processing happens there
>
> - move calc_avgs() out of the way, closer to where it's being used.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  kernel/sched/psi.c | 90 ++++++++++++++++++++++------------------------
>  1 file changed, 42 insertions(+), 48 deletions(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 9d647d974f55..1faf383f6ec4 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -238,17 +238,15 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
>         }
>  }
>
> -static void get_recent_times(struct psi_group *group, int cpu,
> -                            enum psi_aggregators aggregator, u32 *times,
> -                            u32 *pchanged_states)
> +static u32 snapshot_cpu_states(struct psi_group *group, int cpu,
> +                              enum psi_aggregators aggregator, u32 *times)
>  {
>         struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
>         u64 now, state_start;
>         enum psi_states s;
>         unsigned int seq;
>         u32 state_mask;
> -
> -       *pchanged_states = 0;
> +       u32 states = 0;
>
>         /* Snapshot a coherent view of the CPU state */
>         do {
> @@ -279,37 +277,18 @@ static void get_recent_times(struct psi_group *group, int cpu,
>
>                 times[s] = delta;
>                 if (delta)
> -                       *pchanged_states |= (1 << s);
> +                       states |= (1 << s);
>         }
> -}
>
> -static void calc_avgs(unsigned long avg[3], int missed_periods,
> -                     u64 time, u64 period)
> -{
> -       unsigned long pct;
> -
> -       /* Fill in zeroes for periods of no activity */
> -       if (missed_periods) {
> -               avg[0] = calc_load_n(avg[0], EXP_10s, 0, missed_periods);
> -               avg[1] = calc_load_n(avg[1], EXP_60s, 0, missed_periods);
> -               avg[2] = calc_load_n(avg[2], EXP_300s, 0, missed_periods);
> -       }
> -
> -       /* Sample the most recent active period */
> -       pct = div_u64(time * 100, period);
> -       pct *= FIXED_1;
> -       avg[0] = calc_load(avg[0], EXP_10s, pct);
> -       avg[1] = calc_load(avg[1], EXP_60s, pct);
> -       avg[2] = calc_load(avg[2], EXP_300s, pct);
> +       return states;
>  }
>
> -static void collect_percpu_times(struct psi_group *group,
> -                                enum psi_aggregators aggregator,
> -                                u32 *pchanged_states)
> +static u32 aggregate_cpus(struct psi_group *group,
> +                         enum psi_aggregators aggregator)
>  {
>         u64 deltas[NR_PSI_STATES - 1] = { 0, };
>         unsigned long nonidle_total = 0;
> -       u32 changed_states = 0;
> +       u32 states = 0;
>         int cpu;
>         int s;
>
> @@ -324,11 +303,8 @@ static void collect_percpu_times(struct psi_group *group,
>         for_each_possible_cpu(cpu) {
>                 u32 times[NR_PSI_STATES];
>                 u32 nonidle;
> -               u32 cpu_changed_states;
>
> -               get_recent_times(group, cpu, aggregator, times,
> -                               &cpu_changed_states);
> -               changed_states |= cpu_changed_states;
> +               states |= snapshot_cpu_states(group, cpu, aggregator, times);
>
>                 nonidle = nsecs_to_jiffies(times[PSI_NONIDLE]);
>                 nonidle_total += nonidle;
> @@ -354,15 +330,34 @@ static void collect_percpu_times(struct psi_group *group,
>                 group->total[aggregator][s] +=
>                                 div_u64(deltas[s], max(nonidle_total, 1UL));
>
> -       if (pchanged_states)
> -               *pchanged_states = changed_states;
> +       return states;
> +}
> +
> +static void calc_avgs(unsigned long avg[3], int missed_periods,
> +                     u64 time, u64 period)
> +{
> +       unsigned long pct;
> +
> +       /* Fill in zeroes for periods of no activity */
> +       if (missed_periods) {
> +               avg[0] = calc_load_n(avg[0], EXP_10s, 0, missed_periods);
> +               avg[1] = calc_load_n(avg[1], EXP_60s, 0, missed_periods);
> +               avg[2] = calc_load_n(avg[2], EXP_300s, 0, missed_periods);
> +       }
> +
> +       /* Sample the most recent active period */
> +       pct = div_u64(time * 100, period);
> +       pct *= FIXED_1;
> +       avg[0] = calc_load(avg[0], EXP_10s, pct);
> +       avg[1] = calc_load(avg[1], EXP_60s, pct);
> +       avg[2] = calc_load(avg[2], EXP_300s, pct);
>  }
>
>  static void update_averages(struct psi_group *group)
>  {
>         unsigned long missed_periods = 0;
>         u64 now, expires, period;
> -       u32 changed_states;
> +       u32 states;
>         int s;
>
>         /* avgX= */
> @@ -402,7 +397,7 @@ static void update_averages(struct psi_group *group)
>         group->avg_last_update = now;
>         group->avg_next_update = expires + ((1 + missed_periods) * psi_period);
>
> -       collect_percpu_times(group, PSI_AVGS, &changed_states);
> +       states = aggregate_cpus(group, PSI_AVGS);
>         for (s = 0; s < NR_PSI_STATES - 1; s++) {
>                 u32 sample;
>
> @@ -430,7 +425,7 @@ static void update_averages(struct psi_group *group)
>                 calc_avgs(group->avg[s], missed_periods, sample, period);
>         }
>
> -       if (changed_states & (1 << PSI_NONIDLE)) {
> +       if (states & (1 << PSI_NONIDLE)) {
>                 unsigned long delay;
>
>                 delay = nsecs_to_jiffies(group->avg_next_update - now) + 1;
> @@ -585,24 +580,24 @@ static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay)
>
>  static void psi_poll_work(struct psi_group *group)
>  {
> -       u32 changed_states;
> +       unsigned long delay;
> +       u32 states;
>         u64 now;
>
>         mutex_lock(&group->trigger_lock);
>
>         now = sched_clock();
> +       states = aggregate_cpus(group, PSI_POLL);
>
> -       collect_percpu_times(group, PSI_POLL, &changed_states);
> -
> -       if (changed_states & group->poll_states) {
> +       if (states & group->poll_states) {
>                 /* Initialize trigger windows when entering polling mode */
>                 if (now > group->polling_until)
>                         init_triggers(group, now);
>
>                 /*
> -                * Keep the monitor active for at least the duration of the
> -                * minimum tracking window as long as monitor states are
> -                * changing.
> +                * Keep the monitor active for at least the duration
> +                * of the minimum tracking window after a polled state
> +                * has been observed.
>                  */
>                 group->polling_until = now +
>                         group->poll_min_period * UPDATES_PER_WINDOW;
> @@ -616,9 +611,8 @@ static void psi_poll_work(struct psi_group *group)
>         if (now >= group->polling_next_update)
>                 group->polling_next_update = update_triggers(group, now);
>
> -       psi_schedule_poll_work(group,
> -               nsecs_to_jiffies(group->polling_next_update - now) + 1);
> -
> +       delay = nsecs_to_jiffies(group->polling_next_update - now) + 1;
> +       psi_schedule_poll_work(group, delay);
>  out:
>         mutex_unlock(&group->trigger_lock);
>  }
> --
> 2.32.0
>
