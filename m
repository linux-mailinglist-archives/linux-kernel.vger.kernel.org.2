Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838E43BE361
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 09:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhGGHK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 03:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhGGHK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 03:10:27 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA56CC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 00:07:47 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f30so2340601lfj.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 00:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BHnTE/QFYQZHh20pE9wE1rlUNOipEknvqGx1MJV4EDE=;
        b=gs9kCQhOSLJ7qweK7CEP5kSHCQcxtUbFKdWoAB3SCPw8fQDOldqWIYIsph9MyJCxdk
         lk+x/3lq7bhMqp3IjfTeDaKfWOoFn0jQdp1CTFV2qt8Fj3CaaXW6ql1MzOTHma+2bKEK
         EkjtBhX9mNd2bX7sVgoC8b7GQ76lMRakD2Idq4kIE3ewy9j6oauIao4vTNw1pX/0/el8
         j/mA9dKCdWH/RhUriG33dlyLqYWIIseZ5m7H4Xx0CdJidQrGbBam7quLzQZYt5FCR7du
         wH3Vq5p6RIV1xPblhxECw0BrcPgr2p3t83y80uwlW3BuOyhT4PKr+Wr5J+oB8ps1hm5P
         PVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BHnTE/QFYQZHh20pE9wE1rlUNOipEknvqGx1MJV4EDE=;
        b=E8vRPMADwUdU/ek9T7QZFQBNpkMfOdmc5iOGYiN2HUXYfOTzGlFuAkVKRlAgEgxyai
         diCuDrmy7Zjmoovz8hBTBiffthF/nrBJlfrrc8/PHWqTsFSy0y2ky3+v7miL+8FqSJbY
         3IccWNM+bcs0whyUIAZCfbpSnDE1g+6jRXI/J/UXyYJvJ+RJrQ7YULrPWFEsYT1VIn/5
         Hf+49oXgrf2Gr1ZC4W7iPCqxCfMny2FtB2mNhaUI3JMGCsK1gXil4sSZy651oRH/hYSN
         py3lUvHh2tQj6debGhGQEf5ZYBNgvKZmxpy0J6agBwseU9+HuBqrYIeiA18Q/PgaC2BH
         W0OA==
X-Gm-Message-State: AOAM531r63t6uiCL0IwRJjSj5eRTtgyHBXYrRkGYM0nVSNjEuWAPAyAn
        KhBgBjFNw0uFw09OgmHuee+UHdQMS596L5WJBCQ/DQ==
X-Google-Smtp-Source: ABdhPJzeLrNZscHzD67zgs/F4p/lOcTNmR0qpjNQdj0k8V66CDTTyDxlU1kFNJbRWHdsIrF/23LK0VeARXwLUQdXn8w=
X-Received: by 2002:a05:6512:50e:: with SMTP id o14mr16490498lfb.286.1625641666115;
 Wed, 07 Jul 2021 00:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210625152603.25960-1-lukasz.luba@arm.com> <20210625152603.25960-2-lukasz.luba@arm.com>
In-Reply-To: <20210625152603.25960-2-lukasz.luba@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 7 Jul 2021 09:07:35 +0200
Message-ID: <CAKfTPtAV9GjQaXc2FV0OuEzTGQw9hFiKpwMfAxP-JQ_QFCUC3w@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched/fair: Prepare variables for increased precision
 of EAS estimated energy
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        CCj.Yeh@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021 at 17:26, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> The Energy Aware Scheduler (EAS) tries to find best CPU for a waking up
> task. It probes many possibilities and compares the estimated energy values
> for different scenarios. For calculating those energy values it relies on
> Energy Model (EM) data and em_cpu_energy(). The precision which is used in
> EM data is in milli-Watts (or abstract scale), which sometimes is not
> sufficient. In some cases it might happen that two CPUs from different
> Performance Domains (PDs) get the same calculated value for a given task
> placement, but in more precised scale, they might differ. This rounding
> error has to be addressed. This patch prepares EAS code for better
> precision in the coming EM improvements.

Could you explain why 32bits results are not enough and you need to
move to 64bits ?

Right now the result is in the range [0..2^32[ mW. If you need more
precision and you want to return uW instead, you will have a result in
the range  [0..4kW[ which seems to be still enough

>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/sched/fair.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7b8990fd4896..b517c9e79768 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6582,7 +6582,7 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
>   * to compute what would be the energy if we decided to actually migrate that
>   * task.
>   */
> -static long
> +static u64
>  compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>  {
>         struct cpumask *pd_mask = perf_domain_span(pd);
> @@ -6689,12 +6689,13 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>   */
>  static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  {
> -       unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
>         struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
> +       u64 prev_delta = ULLONG_MAX, best_delta = ULLONG_MAX;
>         int cpu, best_energy_cpu = prev_cpu, target = -1;
> -       unsigned long cpu_cap, util, base_energy = 0;
> +       unsigned long cpu_cap, util;
>         struct sched_domain *sd;
>         struct perf_domain *pd;
> +       u64 base_energy = 0;
>
>         rcu_read_lock();
>         pd = rcu_dereference(rd->pd);
> @@ -6718,9 +6719,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                 goto unlock;
>
>         for (; pd; pd = pd->next) {
> -               unsigned long cur_delta, spare_cap, max_spare_cap = 0;
> +               unsigned long spare_cap, max_spare_cap = 0;
>                 bool compute_prev_delta = false;
> -               unsigned long base_energy_pd;
> +               u64 base_energy_pd, cur_delta;
>                 int max_spare_cap_cpu = -1;
>
>                 for_each_cpu_and(cpu, perf_domain_span(pd), sched_domain_span(sd)) {
> @@ -6790,7 +6791,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>          * Pick the best CPU if prev_cpu cannot be used, or if it saves at
>          * least 6% of the energy used by prev_cpu.
>          */
> -       if ((prev_delta == ULONG_MAX) ||
> +       if ((prev_delta == ULLONG_MAX) ||
>             (prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
>                 target = best_energy_cpu;
>
> --
> 2.17.1
>
