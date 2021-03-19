Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061973420BF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhCSPUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhCSPTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:19:50 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B04C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:19:49 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id q13so10560116lfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ncWrOnVnU/iyl10p812Veh9IldWzIz1WfAKlRZzqbkE=;
        b=HbECOAG1VJ8mWtyLDQ1KLTTieuK1gl9bvgJuJhklKkkAIOwQ3ATPJ3Jr4douTHIQMg
         erI69WjEwE/YRjZ1vUU0/VhF5p80u+xW/WfQeVQ5HueWh+a1gHUUDKC+Zds9Ock2/Di6
         dN/UnniXn0pRQNrkG2SE2oR/3xpO1mc5f2GC617QH1MMbG+Pe3RMfm5KYQiBrEyhUliW
         rD4jdw69dVx847XzllIPqijuc4OSk/wD7CX+XoX9U3CtARaOmlYFnVDBqlCojEvpz0Be
         XIBJwMxVWqrlpt/KnqWRLrfTsaubdCHs6sCCfAPokl7eCLbRxHXLaDNXPfEBh+ijVZbX
         NWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncWrOnVnU/iyl10p812Veh9IldWzIz1WfAKlRZzqbkE=;
        b=s/UW9tGJ8yOT7u3nR//WS0dPgaIyhRZ3hggPDq+Dg4vTxd7A4YCTqDqaDhjemrRPaK
         O7ulkpmLpqqDs8tm+dk5SDRCacqklEgCUXd/4296USN+chHuwTH3os/qFOGUuWwo/rGs
         UY7zgY+J7Xqgi24udc5Je7SjKcsXAygB8S3mG3lhGW2zFn/gcuUP4fJrAehx8xdm9BdF
         dOrT2ckZDKpCjj+PQOOcZz4Roq7DjxO86LK+7/tcCGVAKvDDz/ceMxkq0IYD780HKsVa
         3pUR9vigjoswMvGNzo+BkoCcxUDkzsVHnlLkUeg8DWRN95D5Qm0PlvTlF2MNA+3XCoDr
         t8wg==
X-Gm-Message-State: AOAM532g7THCVfsd1S3K25E1AlIT0WNlIRmLGCMsLIYc0DOJP5179Zfl
        U8KpF63PMgh5NUzsTT/LQgtrsC0raJzA9TsPRXcOxA==
X-Google-Smtp-Source: ABdhPJxedP5lztTY3qqhcmY7GMWB9+FQxF2/+ILzFHgClP6Qt1OFcJW1ULQwdVjOoxEvsPwE0CpOEtxC+HE/N2OAhA4=
X-Received: by 2002:a19:f812:: with SMTP id a18mr1167994lff.254.1616167188283;
 Fri, 19 Mar 2021 08:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210311120527.167870-1-valentin.schneider@arm.com>
 <20210311120527.167870-7-valentin.schneider@arm.com> <CAKfTPtAZmOp+c4LR0jKSP=cSUOnu0O_ubGUMnpEKh-cPc89qZw@mail.gmail.com>
 <87v99srztf.mognet@arm.com>
In-Reply-To: <87v99srztf.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 19 Mar 2021 16:19:36 +0100
Message-ID: <CAKfTPtDiNKpVWM4Tw2z+z6g+G1nf5SK5wbdsdnyAhAK5=q+OBg@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] sched/fair: Filter out locally-unsolvable misfit imbalances
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 at 20:18, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 15/03/21 16:13, Vincent Guittot wrote:
> > On Thu, 11 Mar 2021 at 13:05, Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> >>
> >> Consider the following (hypothetical) asymmetric CPU capacity topology,
> >> with some amount of capacity pressure (RT | DL | IRQ | thermal):
> >>
> >>   DIE [          ]
> >>   MC  [    ][    ]
> >>        0  1  2  3
> >>
> >>   | CPU | capacity_orig | capacity |
> >>   |-----+---------------+----------|
> >>   |   0 |           870 |      860 |
> >>   |   1 |           870 |      600 |
> >>   |   2 |          1024 |      850 |
> >>   |   3 |          1024 |      860 |
> >>
> >> If CPU1 has a misfit task, then CPU0, CPU2 and CPU3 are valid candidates to
> >> grant the task an uplift in CPU capacity. Consider CPU0 and CPU3 as
> >> sufficiently busy, i.e. don't have enough spare capacity to accommodate
> >> CPU1's misfit task. This would then fall on CPU2 to pull the task.
> >>
> >> This currently won't happen, because CPU2 will fail
> >>
> >>   capacity_greater(capacity_of(CPU2), sg->sgc->max_capacity)
> >
> > which has been introduced by the previous patch: patch5
> >
> >>
> >> in update_sd_pick_busiest(), where 'sg' is the [0, 1] group at DIE
> >> level. In this case, the max_capacity is that of CPU0's, which is at this
> >> point in time greater than that of CPU2's. This comparison doesn't make
> >> much sense, given that the only CPUs we should care about in this scenario
> >> are CPU1 (the CPU with the misfit task) and CPU2 (the load-balance
> >> destination CPU).
> >>
> >> Aggregate a misfit task's load into sgs->group_misfit_task_load only if
> >> env->dst_cpu would grant it a capacity uplift. Separately track whether a
> >> sched_group contains a misfit task to still classify it as
> >> group_misfit_task and not pick it as busiest group when pulling from a
> >
> > Could you give more details about why we should keep tracking the
> > group as misfit ? Do you have a UC in mind ?
> >
>
> As stated the current behaviour is to classify groups as group_misfit_task
> regardless of the dst_cpu's capacity. When we see a group_misfit_task
> candidate group misfit task with higher per-CPU capacity than the local
> group, we don't pick it as busiest.
>
> I initially thought not marking those as group_misfit_task was the right
> thing to do, as they could then be classified as group_fully_busy or
> group_has_spare. Consider:
>
>   DIE [          ]
>   MC  [    ][    ]
>        0  1  2  3
>        L  L  B  B
>
>   arch_scale_capacity(L) < arch_scale_capacity(B)
>
>   CPUs 0-1 are idle / lightly loaded
>   CPU2 has a misfit task and a few very small tasks
>   CPU3 has a few very small tasks
>
> When CPU0 is running load_balance() at DIE level, right now we'll classify
> the [2-3] group as group_misfit_task and not pick it as busiest because the
> local group has a lower CPU capacity.
>
> If we didn't do that, we could leave the misfit task alone and pull some
> small task(s) from CPU2 or CPU3, which would be a good thing to

Are you sure? the last check in update_sd_pick_busiest() should
already filter this. So it should be enough to let it be classify
correctly

A group should be classified as group_misfit_task when there is a task
to migrate in priority compared to some other groups. In your case,
you tag it as group_misfit_task but in order to do the opposite, i.e.
make sure to not select it. As mentioned above, this will be filter in
the last check in update_sd_pick_busiest()

> do. However, by allowing a group containing a misfit task to be picked as
> the busiest group when a CPU of lower capacity is pulling, we run the risk
> of the misfit task itself being downmigrated - e.g. if we repeatedly
> increment the sd->nr_balance_failed counter and do an active balance (maybe
> because the small tasks were unfortunately cache_hot()).
>
> It's less than ideal, but I considered not downmigrating misfit tasks was
> the thing to prioritize (and FWIW it also maintains current behaviour).
>
>
> Another approach would be to add task utilization vs CPU capacity checks in
> detach_tasks() and need_active_balance() to prevent downmigration when
> env->imbalance_type < group_misfit_task. This may go against the busiest
> group selection heuristics however (misfit tasks could be the main
> contributors to the imbalance, but we end up not moving them).
>
>
> >> lower-capacity CPU (which is the current behaviour and prevents
> >> down-migration).
> >>
> >> Since find_busiest_queue() can now iterate over CPUs with a higher capacity
> >> than the local CPU's, add a capacity check there.
> >>
> >> Reviewed-by: Qais Yousef <qais.yousef@arm.com>
> >> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>
> >> @@ -8447,10 +8454,21 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >>                         continue;
> >>
> >>                 /* Check for a misfit task on the cpu */
> >> -               if (sd_has_asym_cpucapacity(env->sd) &&
> >> -                   sgs->group_misfit_task_load < rq->misfit_task_load) {
> >> -                       sgs->group_misfit_task_load = rq->misfit_task_load;
> >> -                       *sg_status |= SG_OVERLOAD;
> >> +               if (!sd_has_asym_cpucapacity(env->sd) ||
> >> +                   !rq->misfit_task_load)
> >> +                       continue;
> >> +
> >> +               *sg_status |= SG_OVERLOAD;
> >> +               sgs->group_has_misfit_task = true;
> >> +
> >> +               /*
> >> +                * Don't attempt to maximize load for misfit tasks that can't be
> >> +                * granted a CPU capacity uplift.
> >> +                */
> >> +               if (cpu_capacity_greater(env->dst_cpu, i)) {
> >> +                       sgs->group_misfit_task_load = max(
> >> +                               sgs->group_misfit_task_load,
> >> +                               rq->misfit_task_load);
> >
> > Please encapsulate all this misfit specific code in a dedicated
> > function which will be called from update_sg_lb_stats
> >
>
> Will do.
