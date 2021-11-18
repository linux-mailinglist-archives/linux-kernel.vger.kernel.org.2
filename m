Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF900455646
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 09:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244215AbhKRIKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 03:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244231AbhKRIKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 03:10:17 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62932C061764
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 00:07:17 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id g17so15495819ybe.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 00:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hkqZszksCPfdoMA4dVxWxQYRXohLRAwtScm0q+eUA3M=;
        b=QvsFwj+ZAyHsl0500EaI8rvipLSi0IQj5t0GcVuIoyhY1+sQmhOyWFXyYbIL3vjue+
         aFeGMacDOtuV4nnWHyjL935isTFcXBlFIgTcE0qIeZJD8FWiA45algYV4Us0wV45szvJ
         BNaz5XlbvChUErdZmJ4NgoY5AU4bJ5MoN4k2VqULZqc96zw7qWXEwppnAuGKvDUZrHb6
         PHlB3MFii3yzlXwfrLlhKo1EH7ptAHAOUm3/9p1JQVt2d6eyCEazPNhyTf6VWTMEV6Rd
         5jVO/guqwVJBBVhJQjv6J+s/2dcV9snHwVJtxY0DWh3fodI47oROy345F3wO6AfHVSfg
         jSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hkqZszksCPfdoMA4dVxWxQYRXohLRAwtScm0q+eUA3M=;
        b=CV1KpdPHE5cg90JgW7cCHXqyrUK9FmncA2Nd0Ax0SdOkf6m/jKj3saz3OQKlPjodKZ
         u7Soy2g93ceSAmnyiyWOqXXKth+mMcVbK5hEi38xTUItidASqFlXgryPPweDwLyk30Hd
         dQGdiMITXN2/9wVbreshKoR2N/BcC9gixLLjMM8/IX/x4QJQL9g7DR6/uP1yLps2QlNU
         ZTlp/64Bw5cSrcpOWyvVOA2JuCQNqGdbt6ywausfdOZWnrtABznJUn2nLIzWDZVUURby
         xryIUcjr35gSPx9opxRDNNAqlPjeVLbChCj83Ne2Eq63FPKBdOol8WZjQPoV/XntKSln
         LA9g==
X-Gm-Message-State: AOAM531/6prHY2PAzxeKm7100c7ad5HWMPti9rjgqdN98oWV+9sFYvau
        XujPmoTwj0Lmu5kSbLKivSFsPzztSAYds23mfZAyxQ==
X-Google-Smtp-Source: ABdhPJxb35h0OvrEjfMzStmsMc1Zm/PxZ9nJwGQashhT0NJNstl5z5l6eijMkhbfJsoX0fs3mSBrSi07ZEsmUNR7UfI=
X-Received: by 2002:a25:d707:: with SMTP id o7mr25852466ybg.546.1637222836604;
 Thu, 18 Nov 2021 00:07:16 -0800 (PST)
MIME-Version: 1.0
References: <20211112141349.155713-1-dietmar.eggemann@arm.com>
 <CAKfTPtCzP_Xgos-yAiUxnKw_BvP22P5CH3xJjLiUQLeg0a-AxQ@mail.gmail.com> <4ecdc3bf-9a20-c6a8-0aff-8bb7e55a7d34@arm.com>
In-Reply-To: <4ecdc3bf-9a20-c6a8-0aff-8bb7e55a7d34@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 18 Nov 2021 09:07:05 +0100
Message-ID: <CAKfTPtBZdpxMPP4-uRqmCxavKosf4NL14SF1S6=mrKJjVfX+Pw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Replace CFS internal cpu_util() with cpu_util_cfs()
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 at 18:26, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 12.11.21 17:20, Vincent Guittot wrote:
> > On Fri, 12 Nov 2021 at 15:14, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> cpu_util_cfs() was created by commit d4edd662ac16 ("sched/cpufreq: Use
> >> the DEADLINE utilization signal") to enable the access to CPU
> >> utilization from the Schedutil CPUfreq governor.
> >>
> >> Commit a07630b8b2c1 ("sched/cpufreq/schedutil: Use util_est for OPP
> >> selection") added util_est support later.
> >>
> >> The only thing cpu_util() is doing on top of what cpu_util_cfs() already
> >> does is to clamp the return value to the [0..capacity_orig] capacity
> >> range of the CPU. Integrating this into cpu_util_cfs() is not harming
> >> the existing users (Schedutil and CPUfreq cooling (latter via
> >> sched_cpu_util() wrapper)).
> >
> > Could you to update cpu_util_cfs() to use cpu as a parameter instead of rq ?
>
> I could but I decided to use use `struct rq *rq` instead.
>
> (A) We already know the rq in the following functions where we call
>     cpu_util_cfs():

The only user of cpu_util_cfs() is sugov_get_util() and it does
cpu_util_cfs(cpu_rq(sg_cpu->cpu)) because rq is only used as a
parameter of cpu_util_cfs()

all other ones are using cpu_util() which already uses cpu as a
parameter so it's more straight forward to keep using cpu

>
>   update_sg_lb_stats()
>   find_busiest_queue()
>   update_numa_stats()
>   sugov_get_util() (existing cpu_util_cfs() call *)
>
> (B) For the following three functions we would call cpu_rq() outside
>     cpu_util_cfs():
>
>   cpu_overutilized()
>   cpu_util_without()
>   sched_cpu_util() (*)
>
> So for (A) we wouldn't call cpu_rq(cpu) twice, avoiding issues with the
> RELOC_HIDE() thing in per_cpu(runqueues, cpu).
>
>
> And cpu_util_cfs()'s PELT counterparts, cpu_load() and cpu_runnable()
> also use rq.
>
> >> Remove cpu_util().
> >>
> >> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> >> ---
> >>
> >> I deliberately got rid of the comment on top of cpu_util(). It's from
> >> the early days of using PELT utilization, it describes CPU utilization
> >> behaviour before PELT time-scaling and talks about current capacity
> >> which we don't maintain.
> >
> > would be good to keep an updated version in this case. There are lot
> > of interesting informations in the comment
>
> Yes, can do.
>
> Something like this:
>
> /**
>  * cpu_util_cfs() - Estimates the amount of CPU capacity used by CFS tasks.
>  * @cpu: the CPU to get the utilization for.

cpu is clearly the right parameter ;-)

>  *
>  * The unit of the return value must be the same as the one of CPU capacity
>  * so that CPU utilization can be compared with CPU capacity.
>  *
>  * CPU utilization is the sum of running time of runnable tasks plus the
>  * recent utilization of currently non-runnable tasks on that CPU.
>  * It represents the amount of CPU capacity currently used by CFS tasks in
>  * the range [0..max CPU capacity] with max CPU capacity being the CPU
>  * capacity at f_max.
>  *
>  * The estimated CPU utilization is defined as the maximum between CPU
>  * utilization and sum of the estimated utilization of the currently
>  * runnable tasks on that CPU. It preserves a utilization "snapshot" of
>  * previously-executed tasks, which helps better deduce how busy a CPU will
>  * be when a long-sleeping task wake up. Such task's contribution to CPU
>  * utilization would be decayed significantly at this point of time.
>  *
>  * CPU utilization can be higher than the current CPU capacity
>  * (f_curr/f_max * max CPU capacity) or even the max CPU capacity because
>  * of rounding errors as well as task migrations or wakeups of new tasks.
>  * CPU utilization has to be capped to fit into the [0..max CPU capacity]
>  * range. Otherwise a group of CPUs (CPU0 util = 121% + CPU1 util = 80%)
>  * could be seen as over-utilized even though CPU1 has 20% of spare CPU
>  * capacity. CPU utilization is allowed to overshoot current CPU capacity
>  * though since this is useful for predicting the CPU capacity required
>  * after task migrations (scheduler-driven DVFS).
>  *
>  * Return: (Estimated) utilization for the specified CPU.
>  */
>
> [...]
