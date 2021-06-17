Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253CE3AB0D7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 12:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhFQKFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 06:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhFQKFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:05:18 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80C0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 03:03:09 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id l4so8223411ljg.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxrUvnrKIgTp/Wf1aqDt7Zrjkx9ax1KfNrS+HVsQG+8=;
        b=xMcW+FMPqlvdNNwrkpUGFlhLsZ3eSJsWpF7A/0ZYEOAZj/+gmu9vWydoo6yrWU+jc7
         kay+T2JSbLyL/t13/Wym6l6WQC8vE38sJQTHstYoJwAnupeaErbG698QbihSXdw3C/Up
         0XS3fxxxodik7zV20H+lrNL5QiDSdae/S4vA7QUdSL3hV0moWjG1odmd0CHE/9hEQ7mb
         T9e1fyM3YAqH/ktGlrqWJoPSjrkYuZqUIahCUow8sCDvDNmY3cqmZggoY8NmOEQ3GBqF
         oNmdULt69p55TjXUv0EKfhLPHDq9z4JAwjEro3PmLfb+1BElY/xzOC3dmx+pTmhxuVbK
         sL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxrUvnrKIgTp/Wf1aqDt7Zrjkx9ax1KfNrS+HVsQG+8=;
        b=WWFdBHIydm7RHbTSc8mL1sXTabZ4r7J2d99ihRrS2QJWSHJ7R8UQbvSSjfrV4ZRLRP
         5E0pTQlUtaEz5z398Iwy9No7J0MfkHmemF1a7wmYpl2+hAnGQHMSCEzhzbJSShPtD1ut
         4+W6IYiUi3gWx6IZWQNb625iSDRm8rIaML0DEhB3UhjrUZIphSWbmFyF5MEyQapawzP/
         vIopwDLGxYuGf2a4h+hTIp92UTA7QiCErlvRn2tHyh2urk8uwRzZxY2ehYYQTwvF3g0V
         7JjLiY7oAi03yVHO4BNbAenztKgPIp89Q++I5/WOLGLqHeepGPCOVfiaR2XFecRLlsgy
         PvBQ==
X-Gm-Message-State: AOAM533tteZtZ48y+9O8JP8ExtyIozkEdZwPYn4V7YnXoxZGoAsoBnQH
        xskRnvLcK+HwxZaL+QqmRg8wb+fSrFMm3OO1T+qFdQ==
X-Google-Smtp-Source: ABdhPJzW1vothIWBO9gTxAJNsbqxMV/WYH4630+BZu/PKCuAIS+WIOuJE37NJt1m65eId3pplGQDLlGaDSq5OOmfTso=
X-Received: by 2002:a2e:90ca:: with SMTP id o10mr3780165ljg.299.1623924188106;
 Thu, 17 Jun 2021 03:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210615111611.GH30378@techsingularity.net> <20210615204228.GB4272@worktop.programming.kicks-ass.net>
 <CAKfTPtAZ_Aq_S-O2qh5LPyxExkBq3G0kxh51fT7sSC_z8He4+w@mail.gmail.com>
 <20210617074401.GL30378@techsingularity.net> <CAKfTPtC8d37ZrXfDF2jkgg=tDPb1qAvFQQGXHhTf9LLR59hd8Q@mail.gmail.com>
 <20210617094040.GM30378@techsingularity.net>
In-Reply-To: <20210617094040.GM30378@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 17 Jun 2021 12:02:56 +0200
Message-ID: <CAKfTPtB-UCduEiQ5e8NxbOwsfjYGj3ron5rAg4_5ag2Fne7v3A@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Age the average idle time
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 at 11:40, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Thu, Jun 17, 2021 at 10:30:09AM +0200, Vincent Guittot wrote:
> > > > > I'm tempted to give it a go.. anyone object?
> > > >
> > > > Just finished running some tests on my large arm64 system.
> > > > Tbench tests are a mixed between small gain and loss
> > > >
> > >
> > > Same for tbench on three x86 machines I reran tests for
> > >
> > > <SNIP>
> > >
> > > For your arm machine, how many logical CPUs are online, what is the level
> > > of SMT if any and is the machine NUMA?
> >
> > It's a SMT4 x 28 cores x 2 NUMA nodes = 224 CPUs
> >
>
> Ok, SMT4 is what I was interested in. I suspected this was the case but
> was not sure. I wondered about the possibility that SMT4 should be
> accounted for in the scan depth.
>
> > >
> > > Fundamentally though, as the changelog notes "due to the nature of the
> > > patch, this is a regression magnet". There are going to be examples
> > > where a deep search is better even if a machine is fully busy or
> > > overloaded and examples where cutting off the search is better. I think
> > > it's better to have an idle estimate that gets updated if CPUs are fully
> > > busy even if it's not a universal win.
> >
> > Although I agree that using a stall average idle time value of local
> > is not good, I'm not sure this proposal is better. The main problem is
> > that we use the avg_idle of the local CPU to estimate how many times
> > we should loop and try to find another idle CPU. But there is no
> > direct relation between both.
>
> This is true. The idle time of the local CPU is used to estimate the
> idle time of the domain which is inevitably going to be inaccurate but

I'm more and more convinced that using average idle time  (of the
local cpu or the full domain) is not the right metric. In
select_idle_cpu(), we looks for an idle CPU but we don't care about
how long it will be idle. Even more, we can scan all CPUs whatever the
avg idle time if there is a chance that there is an idle core.

> tracking idle time for the domain will be cache write intensive and
> potentially very expensive. I think this was discussed before but maybe
> it is my imaginaction.
>
> > Typically, a short average idle time on
> > the local CPU doesn't mean that there are less idle CPUs and that's
> > why we have a mix a gain and loss
> >
>
> Can you evaluate if scanning proportional to cores helps if applied on
> top? The patch below is a bit of pick&mix and has only seen a basic build

I will queue it for some test later today

> test with a distro config. While I will queue this, I don't expect it to
> have an impact on SMT2.
>
> --8--
> sched/fair: Make select_idle_cpu() proportional to cores
>
> From: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Instead of calculating how many (logical) CPUs to scan, compute how
> many cores to scan.
>
> This changes behaviour for anything !SMT2.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  kernel/sched/core.c  | 17 ++++++++++++-----
>  kernel/sched/fair.c  | 11 +++++++++--
>  kernel/sched/sched.h |  2 ++
>  3 files changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 6a3fdb9f4380..1773e0707a5d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7846,11 +7846,18 @@ int sched_cpu_activate(unsigned int cpu)
>         balance_push_set(cpu, false);
>
>  #ifdef CONFIG_SCHED_SMT
> -       /*
> -        * When going up, increment the number of cores with SMT present.
> -        */
> -       if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
> -               static_branch_inc_cpuslocked(&sched_smt_present);
> +       do {
> +               int weight = cpumask_weight(cpu_smt_mask(cpu));
> +
> +               if (weight > sched_smt_weight)
> +                       sched_smt_weight = weight;
> +
> +               /*
> +                * When going up, increment the number of cores with SMT present.
> +                */
> +               if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
> +                       static_branch_inc_cpuslocked(&sched_smt_present);
> +       } while (0);
>  #endif
>         set_cpu_active(cpu, true);
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cc7d1144a356..4fc4e1f2eaae 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6037,6 +6037,8 @@ static inline int __select_idle_cpu(int cpu)
>  DEFINE_STATIC_KEY_FALSE(sched_smt_present);
>  EXPORT_SYMBOL_GPL(sched_smt_present);
>
> +int __read_mostly sched_smt_weight = 1;
> +
>  static inline void set_idle_cores(int cpu, int val)
>  {
>         struct sched_domain_shared *sds;
> @@ -6151,6 +6153,8 @@ static inline bool test_idle_cores(int cpu, bool def)
>         return def;
>  }
>
> +#define sched_smt_weight 1
> +
>  static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
>  {
>         return __select_idle_cpu(core);
> @@ -6163,6 +6167,8 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
>
>  #endif /* CONFIG_SCHED_SMT */
>
> +#define sis_min_cores  2
> +
>  /*
>   * Scan the LLC domain for idle CPUs; this is dynamically regulated by
>   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
> @@ -6203,11 +6209,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>                 avg_cost = this_sd->avg_scan_cost + 1;
>
>                 span_avg = sd->span_weight * avg_idle;
> -               if (span_avg > 4*avg_cost)
> +               if (span_avg > sis_min_cores * avg_cost)
>                         nr = div_u64(span_avg, avg_cost);
>                 else
> -                       nr = 4;
> +                       nr = sis_min_cores;
>
> +               nr *= sched_smt_weight;
>                 time = cpu_clock(this);
>         }
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 7bc20e5541cf..440a2bbc19d5 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1119,6 +1119,8 @@ static inline bool is_migration_disabled(struct task_struct *p)
>  #ifdef CONFIG_SCHED_SMT
>  extern void __update_idle_core(struct rq *rq);
>
> +extern int sched_smt_weight;
> +
>  static inline void update_idle_core(struct rq *rq)
>  {
>         if (static_branch_unlikely(&sched_smt_present))
