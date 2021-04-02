Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A4A352AD8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 14:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbhDBMxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 08:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbhDBMxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 08:53:06 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B402C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 05:53:04 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id r20so5531026ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 05:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ITHBpPNI9mScRxW4IGgJ2yHfhsrtVI/8yUZPC3ccK28=;
        b=qFkv+bqNQ4vcOLB5gWCn/g+T8gf2KnYT7FwMEOkcLbffWWfc7aVNu7rRJvJFDvq0Tv
         1OZrMYPtJkh3YNOeQH+eG3r51ztDpw9MTLSFL04++0wAhsMBfCPExI6WIZCUSsGiL2hZ
         lHl18HkEivwZSgblAjPUvSd4bYy/tRrKwLeGpw0VO5J4BeEA30GS1NF/AzPwReKX5SO8
         ucACFFwncvi1cg/XWs76t3ctnebWx6DMqj6ikAuT4QtnIlF27Go+GGbu8bRk2Y4Dunq2
         77EgVD169wugg7+HNnofyx6KuzGD9V7j9vV6lAwGaFoiFUDWKQo/joL0EHXf6ubhH2Ph
         eFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ITHBpPNI9mScRxW4IGgJ2yHfhsrtVI/8yUZPC3ccK28=;
        b=H8SYc5vh1OIrNwQ4ANKByduLTpMIvIpwrjIr9poM1HlfLp6dal7BoDCGLgYpHK2Z4L
         YXZYKnUqtN38BattlxVIk/1LiYdK5WY7Rdh8QlhcU2RZbBj+8BxBedlAAb2RDKaGxlYb
         pkv6MqwL6eTVeJSgBqFDzzqvt+PF8w0YZoudDR+mf4Gk+kmidrCvVl8ppVYT2ofwBZgd
         KYv7wfk1rBhbCCSDSXE8PP87gilBEudX1zycd7JX4pglrjoHA1TPWTJVVSkFHbb43FUs
         jnzUa4XBvTUlXYOqFUHODAzkhXfFlPfNmoHQVYOEciDd+uIFZaL+uvqbG7lz/waBcaia
         C1ZQ==
X-Gm-Message-State: AOAM530tMXXvroZ7SKyT0O+sr+H9pFO3CJlKJ718Z+4eNbqZEyWsvat9
        QEWcbhsiZ2rxgWfS7fqm4KSoIm3BhtsRg/V/edSd7A==
X-Google-Smtp-Source: ABdhPJz7Uu3uZiiv/7Mjdv5xuYcbkW/1fkZzdwGzMor5Yho54R6geqLxpJnBVr2uP5E344JYB+AnwNZ283BB05UFZ5M=
X-Received: by 2002:a2e:730b:: with SMTP id o11mr8183629ljc.221.1617367982640;
 Fri, 02 Apr 2021 05:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210401193006.3392788-1-valentin.schneider@arm.com> <20210401193006.3392788-2-valentin.schneider@arm.com>
In-Reply-To: <20210401193006.3392788-2-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 2 Apr 2021 14:52:51 +0200
Message-ID: <CAKfTPtDtacSrrYaFFx=BsytweW+-6a3NaEn8Ks3WXr=gvqHBBA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] sched/fair: Ignore percpu threads for imbalance pulls
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2021 at 21:30, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> From: Lingutla Chandrasekhar <clingutla@codeaurora.org>
>
> During load balance, LBF_SOME_PINNED will bet set if any candidate task
> cannot be detached due to CPU affinity constraints. This can result in
> setting env->sd->parent->sgc->group_imbalance, which can lead to a group
> being classified as group_imbalanced (rather than any of the other, lower
> group_type) when balancing at a higher level.
>
> In workloads involving a single task per CPU, LBF_SOME_PINNED can often be
> set due to per-CPU kthreads being the only other runnable tasks on any
> given rq. This results in changing the group classification during
> load-balance at higher levels when in reality there is nothing that can be
> done for this affinity constraint: per-CPU kthreads, as the name implies,
> don't get to move around (modulo hotplug shenanigans).
>
> It's not as clear for userspace tasks - a task could be in an N-CPU cpuset
> with N-1 offline CPUs, making it an "accidental" per-CPU task rather than
> an intended one. KTHREAD_IS_PER_CPU gives us an indisputable signal which
> we can leverage here to not set LBF_SOME_PINNED.
>
> Note that the aforementioned classification to group_imbalance (when
> nothing can be done) is especially problematic on big.LITTLE systems, which
> have a topology the likes of:
>
>   DIE [          ]
>   MC  [    ][    ]
>        0  1  2  3
>        L  L  B  B
>
>   arch_scale_cpu_capacity(L) < arch_scale_cpu_capacity(B)
>
> Here, setting LBF_SOME_PINNED due to a per-CPU kthread when balancing at MC
> level on CPUs [0-1] will subsequently prevent CPUs [2-3] from classifying
> the [0-1] group as group_misfit_task when balancing at DIE level. Thus, if
> CPUs [0-1] are running CPU-bound (misfit) tasks, ill-timed per-CPU kthreads
> can significantly delay the upgmigration of said misfit tasks. Systems
> relying on ASYM_PACKING are likely to face similar issues.
>
> Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
> [Use kthread_is_per_cpu() rather than p->nr_cpus_allowed]
> [Reword changelog]
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6d73bdbb2d40..04d5e14fa261 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7567,6 +7567,10 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>         if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
>                 return 0;
>
> +       /* Disregard pcpu kthreads; they are where they need to be. */
> +       if ((p->flags & PF_KTHREAD) && kthread_is_per_cpu(p))
> +               return 0;
> +
>         if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
>                 int cpu;
>
> --
> 2.25.1
>
