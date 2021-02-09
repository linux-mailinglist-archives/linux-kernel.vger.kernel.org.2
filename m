Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDA9314B20
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhBIJIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhBIJAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:00:55 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B22CC0617AB
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 00:59:12 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id f23so10095422lfk.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 00:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I5zYeQPovXs8nGKhMynXz+pQyxifPP3M7S9lJqMlxB0=;
        b=ID/vWfsk8tNcjgO6Jg/papNCJEgaFV2QrXykJphrIHaeE8EYeDTlYxl74ZbDSnsmyp
         MJqqztlindsOBw+WdoBhxzVdqsEDts/i9LezzEGS6VvkOVDo2n5UQ2J//doBa/O/o/UP
         KwRXSqD/UP85ntOH+1hZcnR6tQuH9+i3wRHuy1hBK9HvdtvLVdbv8xldPc8XVtk3jLdu
         M88WnBgRAq8XCuBFkn0xyPnZaorBkErmXQUNPjUYnNk4fYLaz5f8pW7+dbh4o/IN0Ecy
         xy/w2uiLMbK/PBC73rMgb3PDtwaU8Rdzn0WvP2PkGpUey8/Mbl79uBj49qmdXsj7rs4h
         y0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I5zYeQPovXs8nGKhMynXz+pQyxifPP3M7S9lJqMlxB0=;
        b=C+EZTN2yIwofpjssueV9Z79NT8zf6w+CCKwA2lHustp/g6egHtgtP9Se+cfjFgdCnR
         V8iSCseAPjOV5rZSgxcYRkwQd5X9eU5wqpPZpGIFD41NuIlhMBnb1FqROJeGir9Ucvnr
         ydGfYPM/4z2fv9NJo0Hf10C/vDVeo+QNb2l++GH5NEk4RNrc3HXR5I/Tlwa9Cf2JIrJ6
         SecCy4REr2biy9n7/sicyD8zxWSYZGkP1I9/xv01YFheAh7APuWyk/Wflt119BaYUq6y
         VFnf1W26Mf5KeoMLZnVhrhJnifBnnvWgg/4HENPglWalPjT6dezRRRuCTF+W4ye6iGLH
         Mt6g==
X-Gm-Message-State: AOAM531SVy4dKJrf/mO1mq9Av/L9bReGIy8hJx5mGZM3ijp1uHPKFl9B
        kZJ9r521IJxVkMjBLoTUj9nV9vJF5+/6oSWhPvKQ7w==
X-Google-Smtp-Source: ABdhPJwPyrKn1QP+HsIkgEykl8uncq/lFty4v139FbmvkZubP+JF4xTo8V3M/+mEUuk6Gld7xE5gQndGHIMZT3DralE=
X-Received: by 2002:a05:6512:3457:: with SMTP id j23mr9443054lfr.305.1612861150502;
 Tue, 09 Feb 2021 00:59:10 -0800 (PST)
MIME-Version: 1.0
References: <20210128183141.28097-1-valentin.schneider@arm.com> <20210128183141.28097-8-valentin.schneider@arm.com>
In-Reply-To: <20210128183141.28097-8-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 9 Feb 2021 09:58:59 +0100
Message-ID: <CAKfTPtBSkg2tBH5U+GvRWHBe3qxCqdB3w6WPJsZPADDbVQCc0w@mail.gmail.com>
Subject: Re: [PATCH 7/8] sched/fair: Attempt misfit active balance when
 migration_type != migrate_misfit
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
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

On Thu, 28 Jan 2021 at 19:32, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Consider a 4-CPU big.LITTLE system with CPUs 0-1 as LITTLEs and CPUs 2-3 as
> bigs. The resulting sched_domain hierarchy is:
>
>   DIE [          ]
>   MC  [    ][    ]
>        0  1  2  3
>
> When running a multithreaded CPU-bound workload (i.e. 1 hog per CPU), the
> expected behaviour is to have the about-to-idle big CPUs pull a hog from
> the LITTLEs, since bigs will complete their work sooner than LITTLEs.
>
> Further Consider a scenario where:
> - CPU0 is idle (e.g. its hog got migrated to one of the big CPUs)
> - CPU1 is currently executing a per-CPU kworker, preempting the CPU hog
> - CPU2 and CPU3 are executing CPU-hogs
>
> CPU0 goes through load_balance() at MC level, and tries to pick stuff from
> CPU1, but:
> - the hog can't be pulled, because it's task_hot()
> - the kworker can't be pulled, because it's pinned to CPU1, which sets
>   LBF_SOME_PINNED
>
> This load balance attempts ends with no load pulled, LBF_SOME_PINNED set,
> and as a consequence we set the imbalance flag of DIE's [0, 1]
> sched_group_capacity.
>
> Shortly after, CPU2 completes its work and is about to go idle. It goes
> through the newidle_balance(), and we would really like it to active
> balance the hog running on CPU1 (which is a misfit task). However,
> sgc->imbalance is set for the LITTLE group at DIE level, so the group gets
> classified as group_imbalanced rather than group_misfit_task.
>
> Unlike group_misfit_task (via migrate_misfit), the active balance logic
> doesn't have any specific case for group_imbalanced, so CPU2 ends up going
> idle. We'll have to wait for a load balance on CPU0 or CPU1 to happen and
> clear the imbalance flag, and then for another DIE-level load-balance on
> CPU2 to happen to pull the task off of CPU1. That's several precious
> milliseconds wasted down the drain.
>
> Giving group_misfit_task a higher group_classify() priority than
> group_imbalance doesn't seem like the right thing to do. Instead, make

Could you explain why ?

> need_active_balance() return true for any migration_type when the
> destination CPU is idle and the source CPU has a misfit task.
>
> While at it, add an sd_has_asym_cpucapacity() guard in
> need_active_balance().
>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0ac2f876b86f..cba9f97d9beb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9557,9 +9557,22 @@ static int need_active_balance(struct lb_env *env)
>                         return 1;
>         }
>
> +       if (!sd_has_asym_cpucapacity(sd))
> +               return 0;
> +
>         if (env->migration_type == migrate_misfit)
>                 return 1;
>
> +       /*
> +        * If we failed to pull anything and the src_rq has a misfit task, but
> +        * the busiest group_type was higher than group_misfit_task, try to
> +        * go for a misfit active balance anyway.
> +        */
> +       if ((env->idle != CPU_NOT_IDLE) &&
> +           env->src_rq->misfit_task_load &&
> +           cpu_capacity_greater(env->dst_cpu, env->src_cpu))
> +               return 1;
> +
>         return 0;
>  }
>
> --
> 2.27.0
>
