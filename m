Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CB83A27FB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhFJJOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:14:32 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:43993 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhFJJOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:14:25 -0400
Received: by mail-lj1-f181.google.com with SMTP id r14so3820134ljd.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 02:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VVMbJej1FTbaisAevh80awqWcvyycTYvDnQBtjJT+Jw=;
        b=xvDSK3zQYTWu+tGyKmSO1rvDbhMaQ1BxliXpbV1+uIYNpywe93R/nEjL8R2GaJ34Nj
         6FvG1S3oCcquNM6s+a3E1hran9fupMpALCJgPkGqyNT8Jjc6zlMjfrspjbO2BEBupyaz
         lY2Ky0j9DQLYsRqabHOWngp9Rx/BL1P7dLewd5evK6vRUwgY8LLC7/5Tmd9fjcKf1u9T
         zV4Vn/sOjCcr9dSl1iW5MPgihRuyqVIKLFAG0IwXEB7Icr8hxwzX7Xzzig5uaNjWlYPS
         EaviYRqekOZXgoy8r8tWU/JlFVu8T055ecy7WwNRQKlwRkws+2UxpkKyu6WE+us68lxp
         kx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVMbJej1FTbaisAevh80awqWcvyycTYvDnQBtjJT+Jw=;
        b=WbcR0h5pAZ0TgwZBiX6s6gtbx4lsHM+VFyNrAZ63qi7Bc6NGM3hOMn5WkXjPMUQgCS
         xt+KdrrgLuqqfPbLyEF1/FQOQ0KauiRq6qqVV4XB+Zpwu7eAyHTfIr0vWAAFJaaseXcv
         wUwMYkgqr3M+K88LRdcs0kQGajC4aqK1WkXf2StBSDGIFu2LdDDriix6jbsWpA0h+sSi
         GGlDTMctgLkdzRovUhnHGZlcLwrqvLoBsIHzdXSzCwX0ZtU2Ly8vaO0/gzZI819YyLha
         u7m4QnFtkcUW++O/U6G+3BNHyBhzIiSOaPCEmShWw8fLvJGrxdGIUrmoDWQtOyk2o1X1
         aZiQ==
X-Gm-Message-State: AOAM532eMTtjTsbd+xgUss9Ksrq22ni8mjToucvIogqnZ2KhpbbtQAPn
        8PHH+mzwGDXCh3VGXgG7TdCsJaYOocTmsnfdwyL84w==
X-Google-Smtp-Source: ABdhPJx2IxVWiTgbv+LyFheEGzSV011jB0bKXGxjeo+B9g+EDNVXRQNcUpopCAqMGvPEc828UnDBSckzsFyIq4+w5rA=
X-Received: by 2002:a05:651c:4cf:: with SMTP id e15mr1370170lji.401.1623316273623;
 Thu, 10 Jun 2021 02:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210604080954.13915-1-lukasz.luba@arm.com> <20210604080954.13915-2-lukasz.luba@arm.com>
 <CAKfTPtA0j-hgXC2_LUcbRcWLkLsAB6H_EYewEHJJW+3dVu_hLQ@mail.gmail.com> <b01020e5-9f52-87aa-30e3-284e8f86a9df@arm.com>
In-Reply-To: <b01020e5-9f52-87aa-30e3-284e8f86a9df@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 10 Jun 2021 11:11:02 +0200
Message-ID: <CAKfTPtCA0svSBp=GG2XjLFqAdNY1FRFmsWNNOVADZf_CVqyORw@mail.gmail.com>
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

On Thu, 10 Jun 2021 at 10:42, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 6/10/21 8:59 AM, Vincent Guittot wrote:
> > On Fri, 4 Jun 2021 at 10:10, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >> Energy Aware Scheduling (EAS) needs to be able to predict the frequency
> >> requests made by the SchedUtil governor to properly estimate energy used
> >> in the future. It has to take into account CPUs utilization and forecast
> >> Performance Domain (PD) frequency. There is a corner case when the max
> >> allowed frequency might be reduced due to thermal. SchedUtil is aware of
> >> that reduced frequency, so it should be taken into account also in EAS
> >> estimations.
> >>
> >> SchedUtil, as a CPUFreq governor, knows the maximum allowed frequency of
> >> a CPU, thanks to cpufreq_driver_resolve_freq() and internal clamping
> >> to 'policy::max'. SchedUtil is responsible to respect that upper limit
> >> while setting the frequency through CPUFreq drivers. This effective
> >> frequency is stored internally in 'sugov_policy::next_freq' and EAS has
> >> to predict that value.
> >>
> >> In the existing code the raw value of arch_scale_cpu_capacity() is used
> >> for clamping the returned CPU utilization from effective_cpu_util().
> >> This patch fixes issue with too big single CPU utilization, by introducing
> >> clamping to the allowed CPU capacity. The allowed CPU capacity is a CPU
> >> capacity reduced by thermal pressure signal. We rely on this load avg
> >> geometric series in similar way as other mechanisms in the scheduler.
> >>
> >> Thanks to knowledge about allowed CPU capacity, we don't get too big value
> >> for a single CPU utilization, which is then added to the util sum. The
> >> util sum is used as a source of information for estimating whole PD energy.
> >> To avoid wrong energy estimation in EAS (due to capped frequency), make
> >> sure that the calculation of util sum is aware of allowed CPU capacity.
> >>
> >> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >> ---
> >>   kernel/sched/fair.c | 17 ++++++++++++++---
> >>   1 file changed, 14 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 161b92aa1c79..1aeddecabc20 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -6527,6 +6527,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
> >>          struct cpumask *pd_mask = perf_domain_span(pd);
> >>          unsigned long cpu_cap = arch_scale_cpu_capacity(cpumask_first(pd_mask));
> >>          unsigned long max_util = 0, sum_util = 0;
> >> +       unsigned long _cpu_cap = cpu_cap;
> >>          int cpu;
> >>
> >>          /*
> >> @@ -6558,14 +6559,24 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
> >>                                  cpu_util_next(cpu, p, -1) + task_util_est(p);
> >>                  }
> >>
> >> +               /*
> >> +                * Take the thermal pressure from non-idle CPUs. They have
> >> +                * most up-to-date information. For idle CPUs thermal pressure
> >> +                * signal is not updated so often.
> >
> > What do you mean by "not updated so often" ? Do you have a value ?
> >
> > Thermal pressure is updated at the same rate as other PELT values of
> > an idle CPU. Why is it a problem there ?
> >
>
>
> For idle CPU the value is updated 'remotely' by some other CPU
> running nohz_idle_balance(). That goes into
> update_blocked_averages() if the flags and checks are OK inside
> update_nohz_stats(). Sometimes this is not called
> because other_have_blocked() returned false. It can happen for a long

So i miss that you were in a loop and the below was called for each
cpu and _cpu_cap was overwritten

+               if (!idle_cpu(cpu))
+                       _cpu_cap = cpu_cap - thermal_load_avg(cpu_rq(cpu));

But that also means that if the 1st cpus of the pd are idle, they will
use original capacity whereas the other ones will remove the thermal
pressure. Isn't this a problem  ?  You don't use the same capacity for
all cpus in the performance domain regarding the thermal pressure?

> idle CPU, which all signals in that function has 0 [1].
>
> This will cause that we don't check what is a new value stored by
> thermal cpufreq_cooling for the thermal pressure [2]. We should feed
> that value into the 'signal' machinery inside the
> __update_blocked_others() [3]. Unfortunately, in a corner case there's
> a flag (rq->has_blocked_load) which blocks the check of a
> raw thermal value and prevents feeding it into thermal pressure signal
> (since it's a long idle CPU, there is no load) [4].
>
> It has implication on this patch, because I cannot e.g. take first
> CPU from the PD mask and blindly check it's thermal pressure,
> because it can be idle for a long time. I don't want to have two
> loop, first just for taking the latest thermal pressure for the PD.
> Thus, I want to re-use the existing loop to take the latest information
> from non-idle CPU and pass use.
>
> Regards,
> Lukasz
>
>
> [1] https://elixir.bootlin.com/linux/latest/source/kernel/sched/fair.c#L7909
> [2]
> https://elixir.bootlin.com/linux/latest/source/drivers/thermal/cpufreq_cooling.c#L494
> [3] https://elixir.bootlin.com/linux/latest/source/kernel/sched/fair.c#L7958
> [4] https://elixir.bootlin.com/linux/latest/source/kernel/sched/fair.c#L8433
