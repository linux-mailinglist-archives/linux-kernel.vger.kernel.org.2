Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADE13A2605
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhFJIDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:03:33 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:40870 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhFJIC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:02:59 -0400
Received: by mail-lj1-f169.google.com with SMTP id x14so3566763ljp.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 01:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnj374tBN1u0+7qzi9RKeRcyClGo5IdIx87fr4lI2T4=;
        b=nqcO9g0E4Qf3YS7ABNZtJzHFbs6Xy34fW1S4RMW7INVdY2S2dJUQwa4MGPys+j4iZ2
         1hZfHyQ4x1DMc9DaryQ8C3U2ZyJCikaCzD0ZNFNuIg/bCHh+K4CV/yInNNA+4FPwoRJw
         y27fIdieonmaslTYC9fhiPSDCxUs7J5XhCVpAHdbbLQ/Gi4h4DWE20YQ1NopfnO+iV1w
         q/n70V4CR1RrixxYGS7u9oV3Ck5T3dtfW/gWOJLYaGoho5oLgNpC+Vow0jkIkfJK65Wl
         qtw3bXSDYKgjmsuoZ69n+R+h9itRC9rKu4kV2YYtiaTm61kKIioUXs+UmIhrRbr9Adk4
         r2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnj374tBN1u0+7qzi9RKeRcyClGo5IdIx87fr4lI2T4=;
        b=YmKVQ046F/R985mqtaBNqB5eHzUt6UsIus/2O4Jehto165c+vJ0nySY/BrQRXxz4cK
         sIQ/2HCG8XERyEjgN7I3XARLrFy86TKsbahIe5wXCIhar55bRDVRoXULfhdl0911igfn
         HWmi7WSO02HlL0/aXeYNW0iXX+ZX6+/atYXoCD9rA2kQsLY9Y9Rt83cgpfVfxQuGmRL7
         9KHIZp7/QR8BelYuBN+ECCHfRwe89dRWYbp82dh4DxmWrdCNrS5c2V+NFy6RLyyA07nW
         QAT56mMFXnLa0JFIcUBINjxRmAldKzTRRutzTT2X2YP5YZwNf6i9LKdRL7toNyIbeX09
         7rMw==
X-Gm-Message-State: AOAM530rsR2s42ov4vmEn7LloS3SCOFNs7dZuWh5EIQawtX+bz7OIEh6
        78ZG4GvTgBlJ7Vwes3L/crghsN8ttwGYjj+vqt3BOQ==
X-Google-Smtp-Source: ABdhPJz05kC51ip+oetI/9VPzB8Yy8WyxSKGzbYUkHB4rkOAkgNKdyqgm+ow5Df5e9CdZj6h6Zb7iQ6EUkrSdDrOL5M=
X-Received: by 2002:a05:651c:4cf:: with SMTP id e15mr1180751lji.401.1623312002168;
 Thu, 10 Jun 2021 01:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210604080954.13915-1-lukasz.luba@arm.com> <20210604080954.13915-2-lukasz.luba@arm.com>
In-Reply-To: <20210604080954.13915-2-lukasz.luba@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 10 Jun 2021 09:59:51 +0200
Message-ID: <CAKfTPtA0j-hgXC2_LUcbRcWLkLsAB6H_EYewEHJJW+3dVu_hLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/fair: Take thermal pressure into account
 while estimating energy
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021 at 10:10, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Energy Aware Scheduling (EAS) needs to be able to predict the frequency
> requests made by the SchedUtil governor to properly estimate energy used
> in the future. It has to take into account CPUs utilization and forecast
> Performance Domain (PD) frequency. There is a corner case when the max
> allowed frequency might be reduced due to thermal. SchedUtil is aware of
> that reduced frequency, so it should be taken into account also in EAS
> estimations.
>
> SchedUtil, as a CPUFreq governor, knows the maximum allowed frequency of
> a CPU, thanks to cpufreq_driver_resolve_freq() and internal clamping
> to 'policy::max'. SchedUtil is responsible to respect that upper limit
> while setting the frequency through CPUFreq drivers. This effective
> frequency is stored internally in 'sugov_policy::next_freq' and EAS has
> to predict that value.
>
> In the existing code the raw value of arch_scale_cpu_capacity() is used
> for clamping the returned CPU utilization from effective_cpu_util().
> This patch fixes issue with too big single CPU utilization, by introducing
> clamping to the allowed CPU capacity. The allowed CPU capacity is a CPU
> capacity reduced by thermal pressure signal. We rely on this load avg
> geometric series in similar way as other mechanisms in the scheduler.
>
> Thanks to knowledge about allowed CPU capacity, we don't get too big value
> for a single CPU utilization, which is then added to the util sum. The
> util sum is used as a source of information for estimating whole PD energy.
> To avoid wrong energy estimation in EAS (due to capped frequency), make
> sure that the calculation of util sum is aware of allowed CPU capacity.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/sched/fair.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 161b92aa1c79..1aeddecabc20 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6527,6 +6527,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>         struct cpumask *pd_mask = perf_domain_span(pd);
>         unsigned long cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
>         unsigned long max_util = 0, sum_util = 0;
> +       unsigned long _cpu_cap = cpu_cap;
>         int cpu;
>
>         /*
> @@ -6558,14 +6559,24 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>                                 cpu_util_next(cpu, p, -1) + task_util_est(p);
>                 }
>
> +               /*
> +                * Take the thermal pressure from non-idle CPUs. They have
> +                * most up-to-date information. For idle CPUs thermal pressure
> +                * signal is not updated so often.

What do you mean by "not updated so often" ? Do you have a value ?

Thermal pressure is updated at the same rate as other PELT values of
an idle CPU. Why is it a problem there ?

> +                */
> +               if (!idle_cpu(cpu))
> +                       _cpu_cap = cpu_cap - thermal_load_avg(cpu_rq(cpu));
> +
>                 /*
>                  * Busy time computation: utilization clamping is not
>                  * required since the ratio (sum_util / cpu_capacity)
>                  * is already enough to scale the EM reported power
>                  * consumption at the (eventually clamped) cpu_capacity.
>                  */
> -               sum_util += effective_cpu_util(cpu, util_running, cpu_cap,
> -                                              ENERGY_UTIL, NULL);
> +               cpu_util = effective_cpu_util(cpu, util_running, cpu_cap,
> +                                             ENERGY_UTIL, NULL);
> +
> +               sum_util += min(cpu_util, _cpu_cap);
>
>                 /*
>                  * Performance domain frequency: utilization clamping
> @@ -6576,7 +6587,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>                  */
>                 cpu_util = effective_cpu_util(cpu, util_freq, cpu_cap,
>                                               FREQUENCY_UTIL, tsk);
> -               max_util = max(max_util, cpu_util);
> +               max_util = max(max_util, min(cpu_util, _cpu_cap));
>         }
>
>         return em_cpu_energy(pd->em_pd, max_util, sum_util);
> --
> 2.17.1
>
