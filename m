Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBA636714C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241087AbhDUR1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 13:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240745AbhDUR1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:27:47 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF5EC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 10:27:13 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id o16so48621817ljp.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 10:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+AYbK2ewnyqJA4Ppt5z67NuX99hMx2pvf+UJ7JiaSo0=;
        b=srP1LfQTFL4piTgxdFMK6Ma/ReO7E91WnmsdiIw87h+T+YWtKFxj1WN9FazN+8kFCU
         8+o9Cd42GW3nW5JOAJOcA0LOECMoG+EeLxMu2TU0XKzoJCHxxmkN+UZuOgqYI3Pfp6tE
         F3VsrS+t2t9vv1lsHCz0hVRjiE7n1TEG5fPqlz4ZvmjLTHoEl6uanAF0wu6VRrT0GxDz
         EpvwwYNFfUrdCS1iN4EXaKe95dLK3BQNyrnT7KRlRAWWQDjPOz49ndi4/PR1cGXeedMz
         eC5F+hZeAnuG1rULLkfwq2QUuFhMInR+xQpFiqxpgkpc/qOhAGrA6oN2rB1LqoNLbb9c
         iP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+AYbK2ewnyqJA4Ppt5z67NuX99hMx2pvf+UJ7JiaSo0=;
        b=XUpn8WVZ5H/Mg2y3Axe+qk5ndP1F2ibp8SEdCoRcX+EDBpBQ7828JH22KoR68TjNBu
         P4ZnbVbSBaCrwO7sXRT3A5B4zjTxTOaLUsg4tpg/DgPohQ2Mx6qqj5oU3fu8S1u5M2b6
         fZaR66AN4iJ7/ewZGBPO6qRGtP9r1lgzi3NVGivihJ8lwqMwW/c8LyFqYTfhjPg1GCh4
         feKUKdKcBQKezNt9zBasvY7LOITAYr+2wynnKXBUvoOtW6ueJT7ZePB7KvHnExaMTrbC
         GDEZnDE55tMeCKy20YzIAFN4Z0Spccekml+yQrY41k1vY/RpImSioAeHSA1YpWj6fHMH
         Ga9w==
X-Gm-Message-State: AOAM530/PO7R8ENmzSVYqrs/i5GXSNXp0/r/FjbjXNTlpnOBaIjTSzvp
        XeTEvVbnp6TnEL3rA8gLHTF50vNVVHuXbLU6ip21Zw==
X-Google-Smtp-Source: ABdhPJyH7/djGxEtDaSlmPglwq6jZ/zKYRw457memmoW1ue7gH3gQuREoD8VTN9+DdQXeydAwtdeLpN/voeGGz8EVjM=
X-Received: by 2002:a2e:b8d1:: with SMTP id s17mr19144304ljp.209.1619026032105;
 Wed, 21 Apr 2021 10:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210420120705.5c705d4b@imladris.surriel.com>
In-Reply-To: <20210420120705.5c705d4b@imladris.surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 21 Apr 2021 19:27:00 +0200
Message-ID: <CAKfTPtCcS_bNUi-KwspHssabORupj9K8Y=+Hc7nOzr9JBK-8AA@mail.gmail.com>
Subject: Re: [PATCH v3] sched,fair: skip newidle_balance if a wakeup is pending
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

On Tue, 20 Apr 2021 at 18:07, Rik van Riel <riel@surriel.com> wrote:
>
> The try_to_wake_up function has an optimization where it can queue
> a task for wakeup on its previous CPU, if the task is still in the
> middle of going to sleep inside schedule().
>
> Once schedule() re-enables IRQs, the task will be woken up with an
> IPI, and placed back on the runqueue.
>
> If we have such a wakeup pending, there is no need to search other
> CPUs for runnable tasks. Just skip (or bail out early from) newidle
> balancing, and run the just woken up task.
>
> For a memcache like workload test, this reduces total CPU use by
> about 2%, proportionally split between user and system time,
> and p99 and p95 application response time by 10% on average.
> The schedstats run_delay number shows a similar improvement.
>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  kernel/sched/fair.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 69680158963f..fd80175c3b3e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10594,6 +10594,14 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>         u64 curr_cost = 0;
>
>         update_misfit_status(NULL, this_rq);
> +
> +       /*
> +        * There is a task waiting to run. No need to search for one.
> +        * Return 0; the task will be enqueued when switching to idle.
> +        */
> +       if (this_rq->ttwu_pending)
> +               return 0;
> +
>         /*
>          * We must set idle_stamp _before_ calling idle_balance(), such that we
>          * measure the duration of idle_balance() as idle time.
> @@ -10661,7 +10669,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>                  * Stop searching for tasks to pull if there are
>                  * now runnable tasks on this rq.
>                  */
> -               if (pulled_task || this_rq->nr_running > 0)
> +               if (pulled_task || this_rq->nr_running > 0 ||
> +                   this_rq->ttwu_pending)
>                         break;
>         }
>         rcu_read_unlock();
> @@ -10688,7 +10697,12 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>         if (this_rq->nr_running != this_rq->cfs.h_nr_running)
>                 pulled_task = -1;
>
> -       if (pulled_task)
> +       /*
> +        * If we are no longer idle, do not let the time spent here pull
> +        * down this_rq->avg_idle. That could lead to newidle_balance not
> +        * doing enough work, and the CPU actually going idle.
> +        */
> +       if (pulled_task || this_rq->ttwu_pending)

I'm still running some benchmarks to evaluate the impact of your patch
and more especially the line above which clears this_rq->idle_stamp
and skips the time spent in newidle_balance from being accounted for
in avg_idle. I have some results which  show some regression because
of this test especially with hackbench.
On large system, the time spent in newidle_balance can be significant
and we can't ignore it just because this_rq->ttwu_pending is set while
looping the domains because without newidle_balance the idle time
would have been large and we end up screwing up the metric

>                 this_rq->idle_stamp = 0;
>
>         rq_repin_lock(this_rq, rf);
> --
> 2.25.4
>
>
