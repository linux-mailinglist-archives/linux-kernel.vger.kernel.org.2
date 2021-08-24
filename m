Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C49A3F5C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbhHXK0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236308AbhHXKZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:25:50 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9879C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 03:25:06 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso12874724otv.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 03:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oYTru8I+DDjfRp1LkPC96zydErwEcqzIMqakRkOEbpg=;
        b=OYQxiYWyv1/zGbNXPAofD1TrFv0GUMt9BexZjUK0PD1vq8BfJ3EJmhBRvdZ15wAcf8
         GXM8O+cyrbhMoajxeg+dCGgfEt5d8arNSCYzpEb9gSDLNjbC6bjGBT3qyKjhnKDbk6+X
         QCLn55qcHehIs3TDuaicx8acSMoCK4PkjcIHjEMpXvstkB7ZOu3Wad78sDEV29cso4OT
         MqgzOHQSVkeQnhiklqKcI64PK+qrnmbQTB+bRFqR3VSgXN9EKBPTLZgWxHydieN/yyYM
         DK1AsvgQvn8dkS81+r9/AR3zdMI985wAsHWFlM+2XX54nEJ21eqxvt0kSnJ5bndJ7PcP
         6+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYTru8I+DDjfRp1LkPC96zydErwEcqzIMqakRkOEbpg=;
        b=gb2iUs0kEYahe9BKsP175WSaRj6Tg/L2GCxPdDhRTpkk2ChHn4JitbXAdhjNiLZWN2
         yv2vIlzc4Raiy1tO8amKuLFhY8LWa71KFtkYjLh+mI8/TjZBDMxdr57dNl57ZRYa4tPu
         NolDEIHrcR3UpsDYhU5MLwPZ1j0HF5dQkbu8uCZOe52D8xogb/1rl8oiZKiHlv5YDq7P
         EdfGeLZHT44gjQN+KSWnxLppPySdUE+AbrI5xi37ts5ILGkx6ccn1/z6feItUbe/4bKs
         eEhN3YRELEv1KqZIVlSUWFVpIS4C8hfuiXk/binXM75pYbt66/ZKHWldttcnWn/7FbwO
         DMTw==
X-Gm-Message-State: AOAM533B2aQNrUYrvKhYANBYZpOpVApI5pcO7KlEuqx/dHl7VkEDUtRR
        3dhY0xj/YcZVzAhXM6P73PqqsFCEibd1LblVdME=
X-Google-Smtp-Source: ABdhPJzcnrmOylktriP3yn7v9bJ1yfCJskDMi6jUY+/+958OQerlGTHB0XbTYAhhsN7nEkL/ryO6LommbakShiL1fDk=
X-Received: by 2002:a9d:36d:: with SMTP id 100mr30910281otv.237.1629800706198;
 Tue, 24 Aug 2021 03:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210820010403.946838-1-joshdon@google.com> <20210820010403.946838-4-joshdon@google.com>
In-Reply-To: <20210820010403.946838-4-joshdon@google.com>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Tue, 24 Aug 2021 18:24:55 +0800
Message-ID: <CAPJCdBm1vkbkK_0WqYTpw7dCWbW2dkE=ygTu5UxyHvwCRpUAJQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] sched: reduce sched slice for SCHED_IDLE entities
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 20 Aug 2021 at 09:08, Josh Don <joshdon@google.com> wrote:
>
> Use a small, non-scaled min granularity for SCHED_IDLE entities, when
> competing with normal entities. This reduces the latency of getting
> a normal entity back on cpu, at the expense of increased context
> switch frequency of SCHED_IDLE entities.
>
> The benefit of this change is to reduce the round-robin latency for
> normal entities when competing with a SCHED_IDLE entity.
Why not just ignore min granularity when normal entities compete with
a SCHED_IDLE entity? something like this,

@@ -697,8 +710,14 @@ static u64 sched_slice(struct cfs_rq *cfs_rq,
struct sched_entity *se)
                 slice = __calc_delta(slice, se->load.weight, load);
         }

 -       if (sched_feat(BASE_SLICE))
 -               slice = max(slice, (u64)sysctl_sched_min_granularity);
 +       if (sched_feat(BASE_SLICE)
 +          && (!se_is_idle(init_se) || sched_idle_cfs_rq(cfs_rq)))
 +               slice = max(slice, (u64)sysctl_sched_min_granularity);

         return slice;
  }
If so, there seems no need to introduce sysctl_sched_idle_min_granularity? :)

>
> Example: on a machine with HZ=1000, spawned two threads, one of which is
> SCHED_IDLE, and affined to one cpu. Without this patch, the SCHED_IDLE
> thread runs for 4ms then waits for 1.4s. With this patch, it runs for
> 1ms and waits 340ms (as it round-robins with the other thread).
In that way, the SCHED_IDLE task could be preempted more likely by the
normal task, because the ideal_runtime should be less than
750us(non-scaled sysctl_sched_idle_min_granularity) in this case. And
scaled sysctl_sched_min_granularity could be guaranteed normally
between SCHED_IDLE tasks when only SCHED_IDLE tasks compete with each
other.

>
> Signed-off-by: Josh Don <joshdon@google.com>
> ---
>  kernel/sched/debug.c |  2 ++
>  kernel/sched/fair.c  | 29 ++++++++++++++++++++++++-----
>  kernel/sched/sched.h |  1 +
>  3 files changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 33538579db9a..317ef560aa63 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -305,6 +305,7 @@ static __init int sched_init_debug(void)
>
>         debugfs_create_u32("latency_ns", 0644, debugfs_sched, &sysctl_sched_latency);
>         debugfs_create_u32("min_granularity_ns", 0644, debugfs_sched, &sysctl_sched_min_granularity);
> +       debugfs_create_u32("idle_min_granularity_ns", 0644, debugfs_sched, &sysctl_sched_idle_min_granularity);
>         debugfs_create_u32("wakeup_granularity_ns", 0644, debugfs_sched, &sysctl_sched_wakeup_granularity);
>
>         debugfs_create_u32("latency_warn_ms", 0644, debugfs_sched, &sysctl_resched_latency_warn_ms);
> @@ -806,6 +807,7 @@ static void sched_debug_header(struct seq_file *m)
>         SEQ_printf(m, "  .%-40s: %Ld.%06ld\n", #x, SPLIT_NS(x))
>         PN(sysctl_sched_latency);
>         PN(sysctl_sched_min_granularity);
> +       PN(sysctl_sched_idle_min_granularity);
>         PN(sysctl_sched_wakeup_granularity);
>         P(sysctl_sched_child_runs_first);
>         P(sysctl_sched_features);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 19a9244c140f..31f40aa005b9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -59,6 +59,14 @@ unsigned int sysctl_sched_tunable_scaling = SCHED_TUNABLESCALING_LOG;
>  unsigned int sysctl_sched_min_granularity                      = 750000ULL;
>  static unsigned int normalized_sysctl_sched_min_granularity    = 750000ULL;
>
> +/*
> + * Minimal preemption granularity for CPU-bound SCHED_IDLE tasks.
> + * Applies only when SCHED_IDLE tasks compete with normal tasks.
> + *
> + * (default: 0.75 msec)
> + */
> +unsigned int sysctl_sched_idle_min_granularity                 = 750000ULL;
> +
>  /*
>   * This value is kept at sysctl_sched_latency/sysctl_sched_min_granularity
>   */
> @@ -665,6 +673,8 @@ static u64 __sched_period(unsigned long nr_running)
>                 return sysctl_sched_latency;
>  }
>
> +static bool sched_idle_cfs_rq(struct cfs_rq *cfs_rq);
> +
>  /*
>   * We calculate the wall-time slice from the period by taking a part
>   * proportional to the weight.
> @@ -674,6 +684,8 @@ static u64 __sched_period(unsigned long nr_running)
>  static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
>         unsigned int nr_running = cfs_rq->nr_running;
> +       struct sched_entity *init_se = se;
> +       unsigned int min_gran;
>         u64 slice;
>
>         if (sched_feat(ALT_PERIOD))
> @@ -684,12 +696,13 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
>         for_each_sched_entity(se) {
>                 struct load_weight *load;
>                 struct load_weight lw;
> +               struct cfs_rq *qcfs_rq;
>
> -               cfs_rq = cfs_rq_of(se);
> -               load = &cfs_rq->load;
> +               qcfs_rq = cfs_rq_of(se);
> +               load = &qcfs_rq->load;
>
>                 if (unlikely(!se->on_rq)) {
> -                       lw = cfs_rq->load;
> +                       lw = qcfs_rq->load;
>
>                         update_load_add(&lw, se->load.weight);
>                         load = &lw;
> @@ -697,8 +710,14 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
>                 slice = __calc_delta(slice, se->load.weight, load);
>         }
>
> -       if (sched_feat(BASE_SLICE))
> -               slice = max(slice, (u64)sysctl_sched_min_granularity);
> +       if (sched_feat(BASE_SLICE)) {
> +               if (se_is_idle(init_se) && !sched_idle_cfs_rq(cfs_rq))
> +                       min_gran = sysctl_sched_idle_min_granularity;
> +               else
> +                       min_gran = sysctl_sched_min_granularity;
> +
> +               slice = max_t(u64, slice, min_gran);
> +       }
>
>         return slice;
>  }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 6af039e433fb..29846da35861 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2399,6 +2399,7 @@ extern const_debug unsigned int sysctl_sched_migration_cost;
>  #ifdef CONFIG_SCHED_DEBUG
>  extern unsigned int sysctl_sched_latency;
>  extern unsigned int sysctl_sched_min_granularity;
> +extern unsigned int sysctl_sched_idle_min_granularity;
>  extern unsigned int sysctl_sched_wakeup_granularity;
>  extern int sysctl_resched_latency_warn_ms;
>  extern int sysctl_resched_latency_warn_once;
> --
> 2.33.0.rc2.250.ged5fa647cd-goog
>
