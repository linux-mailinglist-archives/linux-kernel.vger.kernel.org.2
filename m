Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174B0412FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 10:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhIUIIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 04:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhIUIFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 04:05:36 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF8FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 01:04:08 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id bk29so51498111qkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 01:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m+R8v/1YNqRlw4JzZztH0CpyfkC2dJ66ke1a0lmGTRI=;
        b=ap00EeWleFTCIOIF5iN/5KB4x3oXCnRJ6cYWiEoBbx4gPjNT7+uETrIaGA4ITr9BdN
         4AOvUbquzWPkDk7JrCfcyIBHokpeAWUKQIusPu1rauqSwNPF4tMRENC0sWa0eUFkNVI1
         n9GkY5hNJi8CCevr67/YXsXu5/m1pTq2C768rf1xGrL6/t63GDKUen2DsW7/mcz4O5FR
         GSRVbhc5GVi2vJD4LQjSYBLzNvng2esuaXEK7EeyQfQvGeDStJH3hd9oYwY9n5FHfwvI
         XzBWZkk3ZwzKe2J5E2jhVAe0p46B9uQQ2TgKI2ODWVI7hy3b9O2D+3bIp4PFch13zL45
         ATqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m+R8v/1YNqRlw4JzZztH0CpyfkC2dJ66ke1a0lmGTRI=;
        b=B3ajAfVq3oDl+0FuEQFRkDfj2FIl3e5c1ot5MLQhSiVDUdWIlVgdaPY4ZwcgSaXoqJ
         ox6NAJrZpHJySlR/YS/L8mSQID4zP/P9JP6DboIGxZtSgWrLd7/jjdNoB9cAOgt5CwZg
         6SNP1G1/+KXEitog0PiiAQhs55wLzFnMLi6B5mlct3vPG1HRSLItEr0IwGkspbLDo5bI
         RLPtbCGYDYee8UnMk5XF2RhDYCLc7JLYQpdjo1nNmewmlDRo1hYpbEOgtHCudgCkfbHF
         aKjOZoJS8/CA0j2FIWlCc0nhOGs0y7g5nbPtDhRgUpS/nrr/5U5T86Z1CMntfuREKL6q
         6hXw==
X-Gm-Message-State: AOAM530rTNj3KG2UPqSnjCAi6NHuImnIyelVrmy3WD1FyjX0kJ/MelA7
        HL07g1RnFZrwgpFcpBOdrepq35F8rjSTwzmXvBRUQ/+2c5sQlWLD
X-Google-Smtp-Source: ABdhPJxvQlCAuWAyKkZ+ZfDrnIWbMWrC5x5iAyuDQw8STUiLNhSQhvZOiymn0FV5vZQZol8obsF3Gz7cH1jJ47CuRu8=
X-Received: by 2002:a25:d9c8:: with SMTP id q191mr38365769ybg.61.1632211447649;
 Tue, 21 Sep 2021 01:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210920142614.4891-1-mgorman@techsingularity.net> <20210920142614.4891-3-mgorman@techsingularity.net>
In-Reply-To: <20210920142614.4891-3-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 21 Sep 2021 10:03:56 +0200
Message-ID: <CAKfTPtAhb=mryigtxgwETg4FuJ0s5X8XFjyTaCbnxjpgZXmyng@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to nr_running
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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

On Mon, 20 Sept 2021 at 16:26, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> Commit 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs") moved
> the kernel.sched_wakeup_granularity_ns sysctl under debugfs.  One of the
> reasons why this sysctl may be used may be for "optimising for throughput",
> particularly when overloaded. The tool TuneD sometimes alters this for two
> profiles e.g. "mssql" and "throughput-performance". At least version 2.9
> does but it changed in master where it also will poke at debugfs instead.
>
> During task migration or wakeup, a decision is made on whether
> to preempt the current task or not. To limit over-scheduled,
> sysctl_sched_wakeup_granularity delays the preemption to allow at least 1ms
> of runtime before preempting. However, when a domain is heavily overloaded
> (e.g. hackbench), the degree of over-scheduling is still severe. This is

sysctl_sched_wakeup_granularity =  1 msec * (1 + ilog(ncpus))
AFAIK, a 2-socket CascadeLake has 56 cpus which means that
sysctl_sched_wakeup_granularity is 6ms for your platform

> problematic as a lot of time can be wasted rescheduling tasks that could
> instead be used by userspace tasks.
>
> This patch scales the wakeup granularity based on the number of running
> tasks on the CPU up to a max of 8ms by default.  The intent is to

This becomes 8*6=48ms on your platform which is far more than the 15ms
below. Also 48ms is quite a long time to wait for a newly woken task
especially when this task is a bottleneck.

> allow tasks to run for longer while overloaded so that some tasks may
> complete faster and reduce the degree a domain is overloaded. Note that
> the TuneD throughput-performance profile allows up to 15ms but there
> is no explanation why such a long period was necessary so this patch is
> conservative and uses the value that check_preempt_wakeup() also takes
> into account.  An internet search for instances where this parameter are
> tuned to high values offer either no explanation or a broken one.
>
> This improved hackbench on a range of machines when communicating via
> pipes (sockets show little to no difference). For a 2-socket CascadeLake
> machine, the results were
>
> hackbench-process-pipes
>                           5.15.0-rc1             5.15.0-rc1
>                              vanilla sched-scalewakegran-v1r4
> Amean     1        0.3253 (   0.00%)      0.3337 (  -2.56%)
> Amean     4        0.8300 (   0.00%)      0.7983 (   3.82%)
> Amean     7        1.1003 (   0.00%)      1.1600 *  -5.42%*
> Amean     12       1.7263 (   0.00%)      1.6457 *   4.67%*
> Amean     21       3.0063 (   0.00%)      2.7933 *   7.09%*
> Amean     30       4.2323 (   0.00%)      3.8010 *  10.19%*
> Amean     48       6.5657 (   0.00%)      5.6453 *  14.02%*
> Amean     79      10.4867 (   0.00%)      8.5960 *  18.03%*
> Amean     110     14.8880 (   0.00%)     11.4173 *  23.31%*
> Amean     141     19.2083 (   0.00%)     14.3850 *  25.11%*
> Amean     172     23.4847 (   0.00%)     17.1980 *  26.77%*
> Amean     203     27.3763 (   0.00%)     20.1677 *  26.33%*
> Amean     234     31.3707 (   0.00%)     23.4053 *  25.39%*
> Amean     265     35.4663 (   0.00%)     26.3513 *  25.70%*
> Amean     296     39.2380 (   0.00%)     29.3670 *  25.16%*
>
> For Zen 3;
>
> hackbench-process-pipes
>                           5.15.0-rc1             5.15.0-rc1
>                              vanillasched-scalewakegran-v1r4
> Amean     1        0.3780 (   0.00%)      0.4080 (  -7.94%)
> Amean     4        0.5393 (   0.00%)      0.5217 (   3.28%)
> Amean     7        0.5480 (   0.00%)      0.5577 (  -1.76%)
> Amean     12       0.5803 (   0.00%)      0.5667 (   2.35%)
> Amean     21       0.7073 (   0.00%)      0.6543 *   7.49%*
> Amean     30       0.8663 (   0.00%)      0.8290 (   4.31%)
> Amean     48       1.2720 (   0.00%)      1.1337 *  10.88%*
> Amean     79       1.9403 (   0.00%)      1.7247 *  11.11%*
> Amean     110      2.6827 (   0.00%)      2.3450 *  12.59%*
> Amean     141      3.6863 (   0.00%)      3.0253 *  17.93%*
> Amean     172      4.5853 (   0.00%)      3.4987 *  23.70%*
> Amean     203      5.4893 (   0.00%)      3.9630 *  27.81%*
> Amean     234      6.6017 (   0.00%)      4.4230 *  33.00%*
> Amean     265      7.3850 (   0.00%)      4.8317 *  34.57%*
> Amean     296      8.5823 (   0.00%)      5.3327 *  37.86%*
>
> For other workloads, the benefits were marginal as the extreme overloaded
> case is not hit to the same extent.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  kernel/sched/fair.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 038edfaaae9e..8e12aeebf4ce 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4511,7 +4511,8 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  }
>
>  static int
> -wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se);
> +wakeup_preempt_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr,
> +                                               struct sched_entity *se);
>
>  /*
>   * Pick the next process, keeping these things in mind, in this order:
> @@ -4550,16 +4551,16 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>                                 second = curr;
>                 }
>
> -               if (second && wakeup_preempt_entity(second, left) < 1)
> +               if (second && wakeup_preempt_entity(NULL, second, left) < 1)
>                         se = second;
>         }
>
> -       if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1) {
> +       if (cfs_rq->next && wakeup_preempt_entity(NULL, cfs_rq->next, left) < 1) {
>                 /*
>                  * Someone really wants this to run. If it's not unfair, run it.
>                  */
>                 se = cfs_rq->next;
> -       } else if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1) {
> +       } else if (cfs_rq->last && wakeup_preempt_entity(NULL, cfs_rq->last, left) < 1) {
>                 /*
>                  * Prefer last buddy, try to return the CPU to a preempted task.
>                  */
> @@ -7044,10 +7045,22 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  }
>  #endif /* CONFIG_SMP */
>
> -static unsigned long wakeup_gran(struct sched_entity *se)
> +static unsigned long
> +wakeup_gran(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
>         unsigned long gran = sysctl_sched_wakeup_granularity;
>
> +       /*
> +        * If rq is specified, scale the granularity relative to the number
> +        * of running tasks but no more than 8ms with default
> +        * sysctl_sched_wakeup_granularity settings. The wakeup gran
> +        * reduces over-scheduling but if tasks are stacked then the
> +        * domain is likely overloaded and over-scheduling may
> +        * prolong the overloaded state.
> +        */
> +       if (cfs_rq && cfs_rq->nr_running > 1)
> +               gran *= min(cfs_rq->nr_running >> 1, sched_nr_latency);
> +
>         /*
>          * Since its curr running now, convert the gran from real-time
>          * to virtual-time in his units.
> @@ -7079,14 +7092,15 @@ static unsigned long wakeup_gran(struct sched_entity *se)
>   *
>   */
>  static int
> -wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
> +wakeup_preempt_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr,
> +                                               struct sched_entity *se)
>  {
>         s64 gran, vdiff = curr->vruntime - se->vruntime;
>
>         if (vdiff <= 0)
>                 return -1;
>
> -       gran = wakeup_gran(se);
> +       gran = wakeup_gran(cfs_rq, se);
>         if (vdiff > gran)
>                 return 1;
>
> @@ -7191,7 +7205,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>                 return;
>
>         update_curr(cfs_rq);
> -       if (wakeup_preempt_entity(se, pse) == 1) {
> +       if (wakeup_preempt_entity(cfs_rq, se, pse) == 1) {
>                 /*
>                  * Bias pick_next to pick the sched entity that is
>                  * triggering this preemption.
> --
> 2.31.1
>
