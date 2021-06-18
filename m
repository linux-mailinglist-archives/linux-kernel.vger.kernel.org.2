Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BED13AC1C7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhFREJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhFREJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:09:36 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281BDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 21:07:28 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id i17so7302877ilj.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 21:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LkpUeknumT+lya9nj9Pnc2UEoDHGq1JLyIqcGGzy3aU=;
        b=fC2k/Xf7sOC3kVJkN/Io3bUi0IhpTQwd8W1IbkrzVQIsqBfyrI0vedc65gDun3hfP9
         PCgjCTdhvlYxReA4hT57NAyWiz8eJFOKc1tF9ypUWe9xegW7F8r1ZWicLaJOzwsXQBZe
         pkIiraz1mtbDTisxcV0gH3PY4dLPlk7Ds1rl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LkpUeknumT+lya9nj9Pnc2UEoDHGq1JLyIqcGGzy3aU=;
        b=WmSwBA7+8m4HFfoTKkx1vUMvNSJN1ZTuf1iDu4y9VFdBqSC36CX2/obmDFb9y/NqV6
         cFRU9ZIHT3Zka1E00lP40uLyk8efx8+V84aT45dN2UPczcaBC9oceG0GVlL2dMtaURFX
         BxVaWj3O32nQRLMfowAjglDJmEGpw8mW0hOuQs/xGjWzgT35dTNRClPsouiHrb7N6H9F
         AXNRBHSNbpf5E2Lte6tDu8hnviw1/PaGCwODtb+ahJNgvGIWsIHZYM/bsG7SGEtfLZ5N
         gS6fwKGRO6FwT6/vq/2QIHrlN4K6d5zXfjCuARGTjOBTDonX1dHF15aXmLF3ZYSH7Z0b
         dDPA==
X-Gm-Message-State: AOAM530mTBQLI2V0o5KHYZjyPUqkuTkQxhKjPGzr45MN9MQ4380QCw/c
        GJr4H1A3VWn5o8GiGcRo6OHzbF5O1O/K1RL2A1b7MJCdkTs=
X-Google-Smtp-Source: ABdhPJwG1DOWp/Ss6IPQexAOE5dT6143NgvctNIx2Lil6bbePyuHFHscKKKwD67cER8ZlrvoNJV7tRsZW1z5ODnVbK0=
X-Received: by 2002:a05:6e02:1047:: with SMTP id p7mr1999642ilj.171.1623989247172;
 Thu, 17 Jun 2021 21:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210618040639.3113489-1-joel@joelfernandes.org>
In-Reply-To: <20210618040639.3113489-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 18 Jun 2021 00:07:16 -0400
Message-ID: <CAEXW_YR-1M9QSicpq4YHTR0NVsv0t4QXKAvthtUNeQKNe81zjw@mail.gmail.com>
Subject: Re: [RFC] schedutil: Fix iowait boost issues for slow I/O devices
To:     LKML <linux-kernel@vger.kernel.org>,
        Beata Michalska <beata.michalska@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Josh Don <joshdon@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to CC +Beata Michalska , sorry.

On Fri, Jun 18, 2021 at 12:06 AM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> The iowait boost code is currently broken. Following are the issues and
> possible solitions:
>
> Issue #1: If a CPU requests iowait boost in a cluster, another CPU can
> go ahead and decay it very quickly if it thinks there's no new request
> for the iowait boosting CPU in the meanwhile. To fix this, track when
> the iowait boost was last applied to a policy.  This happens when
> should_update_freq() returns true. I have made the code wait for at
> least 10 ticks between 2 different iowait_boost_apply() for any decay to
> happen, and made it configurable via sysctl.
>
> Issue #2: If the iowait is longer than a tick, then successive iowait
> boost doubling does not happen. So I/O waiting tasks for slow devices
> never gets a boost. This is much worse if the tick rate is high since we
> use ticks to measure if no new I/O completion happened. To workaround
> this, be liberal about how many ticks should elapse before resetting the
> boost. I have chosen a conservative number of 20, and made it
> configurable via sysctl.
>
> Tested on a 6+2 ARM64 device, running dd:
> dd if=zeros of=/dev/null bs=1M count=64 iflag=direct
> Throughput improves from 180MB/s to 200MB/s (~5 percent).
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> ---
> NOTE: This RFC patch is for discussion of the issues and I am posting for
> comments. Beata and Vince are also working on an alternate solution.
>
>  include/linux/sched/sysctl.h     |  3 +++
>  kernel/sched/core.c              |  3 +++
>  kernel/sched/cpufreq_schedutil.c | 22 +++++++++++++++++++---
>  kernel/sched/sched.h             |  3 +++
>  kernel/sysctl.c                  | 14 ++++++++++++++
>  5 files changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index db2c0f34aaaf..03ac66b45406 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -53,6 +53,9 @@ extern int sysctl_resched_latency_warn_ms;
>  extern int sysctl_resched_latency_warn_once;
>  #endif
>
> +extern unsigned int sysctl_iowait_reset_ticks;
> +extern unsigned int sysctl_iowait_apply_ticks;
> +
>  /*
>   *  control realtime throttling:
>   *
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index adea0b1e8036..e44985fb6a93 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -76,6 +76,9 @@ __read_mostly int sysctl_resched_latency_warn_once = 1;
>   */
>  const_debug unsigned int sysctl_sched_nr_migrate = 32;
>
> +unsigned int sysctl_iowait_reset_ticks = 20;
> +unsigned int sysctl_iowait_apply_ticks = 10;
> +
>  /*
>   * period over which we measure -rt task CPU usage in us.
>   * default: 1s
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 4f09afd2f321..4e4e1b0aec6c 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -27,6 +27,7 @@ struct sugov_policy {
>         struct list_head        tunables_hook;
>
>         raw_spinlock_t          update_lock;
> +       u64                     last_update;
>         u64                     last_freq_update_time;
>         s64                     freq_update_delay_ns;
>         unsigned int            next_freq;
> @@ -186,9 +187,13 @@ static bool sugov_iowait_reset(struct sugov_cpu *sg_cpu, u64 time,
>                                bool set_iowait_boost)
>  {
>         s64 delta_ns = time - sg_cpu->last_update;
> +       unsigned int ticks = TICK_NSEC;
> +
> +       if (sysctl_iowait_reset_ticks)
> +               ticks = sysctl_iowait_reset_ticks * TICK_NSEC;
>
> -       /* Reset boost only if a tick has elapsed since last request */
> -       if (delta_ns <= TICK_NSEC)
> +       /* Reset boost only if enough ticks has elapsed since last request. */
> +       if (delta_ns <= ticks)
>                 return false;
>
>         sg_cpu->iowait_boost = set_iowait_boost ? IOWAIT_BOOST_MIN : 0;
> @@ -260,6 +265,7 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
>   */
>  static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time)
>  {
> +       struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>         unsigned long boost;
>
>         /* No boost currently required */
> @@ -270,7 +276,9 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time)
>         if (sugov_iowait_reset(sg_cpu, time, false))
>                 return;
>
> -       if (!sg_cpu->iowait_boost_pending) {
> +       if (!sg_cpu->iowait_boost_pending &&
> +           (!sysctl_iowait_apply_ticks ||
> +            (time - sg_policy->last_update > (sysctl_iowait_apply_ticks * TICK_NSEC)))) {
>                 /*
>                  * No boost pending; reduce the boost value.
>                  */
> @@ -449,6 +457,14 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
>                 if (!sugov_update_next_freq(sg_policy, time, next_f))
>                         goto unlock;
>
> +               /*
> +                * Required for ensuring iowait decay does not happen too
> +                * quickly.  This can happen, for example, if a neighboring CPU
> +                * does a cpufreq update immediately after a CPU that just
> +                * completed I/O.
> +                */
> +               sg_policy->last_update = time;
> +
>                 if (sg_policy->policy->fast_switch_enabled)
>                         cpufreq_driver_fast_switch(sg_policy->policy, next_f);
>                 else
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 8f0194cee0ba..2b9c6d5091f7 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2381,6 +2381,9 @@ extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
>  extern const_debug unsigned int sysctl_sched_nr_migrate;
>  extern const_debug unsigned int sysctl_sched_migration_cost;
>
> +extern unsigned int sysctl_iowait_reset_ticks;
> +extern unsigned int sysctl_iowait_apply_ticks;
> +
>  #ifdef CONFIG_SCHED_HRTICK
>
>  /*
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 0afbfc83157a..83f9c5223ba4 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1717,6 +1717,20 @@ static struct ctl_table kern_table[] = {
>                 .mode           = 0644,
>                 .proc_handler   = proc_dointvec,
>         },
> +       {
> +               .procname       = "iowait_reset_ticks",
> +               .data           = &sysctl_iowait_reset_ticks,
> +               .maxlen         = sizeof(unsigned int),
> +               .mode           = 0644,
> +               .proc_handler   = proc_dointvec,
> +       },
> +       {
> +               .procname       = "iowait_apply_ticks",
> +               .data           = &sysctl_iowait_apply_ticks,
> +               .maxlen         = sizeof(unsigned int),
> +               .mode           = 0644,
> +               .proc_handler   = proc_dointvec,
> +       },
>  #ifdef CONFIG_SCHEDSTATS
>         {
>                 .procname       = "sched_schedstats",
> --
> 2.32.0.288.g62a8d224e6-goog
>
