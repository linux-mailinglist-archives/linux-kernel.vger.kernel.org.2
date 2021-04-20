Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15953654C2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 11:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhDTJGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 05:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhDTJFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 05:05:43 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA6BC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 02:05:10 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u20so42642148lja.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 02:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dTfebTCdkJsfaBHlBAbb2gOwkmWwTivYnNWsMmybnGM=;
        b=MkajPfAVIUfmpmnjtH4b+lxj2mrll/yJ9ptk+r9D4cMt49AVd+qutswdDNXlznclvQ
         gNtE/CRkOsHD5RcmLlLudL1/PFEzEa1al1visZLB8G/hUIA7ZifkQAX2tK+sXGzfu+UU
         XubcVEOGwJHWxRo5/pY56REnMSZoUVM7DIp9aU8puRtwHQDuH9flCAuhGvL+pDOSZYHh
         PuYDeevNf7uBW30q1osEZdIhDOdkEAA0v6S/sV5IuE0XROgyf160ZHJxVYzLfXHp8B1m
         W0OYS6DE9PydaE0Tyf+LDLooYFexWvbthdtswYNy49p+FdNthXn2ftU9kApYAROuNBEs
         X+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dTfebTCdkJsfaBHlBAbb2gOwkmWwTivYnNWsMmybnGM=;
        b=QA6ZxzxUbDqubwCXOFRNBMUGKy3aq3IqgeEGZnThkbAdyjTvKRXKDz88Q8TgqxaY9c
         pQiaDgsS5T8zVp7cgzbDhyX1ucBtGkoHEt8OiLuLKmT03uTpNjVPZpFeavX5pSuEzyqZ
         6KT4u4rwZs50ESxCFIWD9MOe9JBVo8GDVeEP/Ttq0J1cV2CEfR/FebEsIsWxg2m3+4T8
         K+X9E7xFzzJRrExhTQj4FwdOI8VDeEd9zrrPXYqy4OYEvpiKhpSmoyeKS4leY21+NpVA
         wagEjC4qMLJ31o/FSSUED8i4zDCQBcfZ/0mKda4CpSpx74w3L+EzNR9fsixSU7N7prtR
         NBug==
X-Gm-Message-State: AOAM533QbhGwRHGSYfXH5B//UuAy3R2aNzjfxLFE+hMRGUwHLiRbBIZm
        r3gkjNl1rmjM+dz0kue0jTIp3AA4gVkJWoDpDp85KQ==
X-Google-Smtp-Source: ABdhPJzRt2OHzt8UYJ5wLD8V0GFvUS50wmaJPPFFCifb4B4gj98+MCE9YbSrvbq1fMSjlG7oW2FMeaMvYF2hBH5eBdY=
X-Received: by 2002:a05:651c:335:: with SMTP id b21mr792258ljp.299.1618909508950;
 Tue, 20 Apr 2021 02:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210419125134.5cab12ea@imladris.surriel.com>
In-Reply-To: <20210419125134.5cab12ea@imladris.surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 20 Apr 2021 11:04:57 +0200
Message-ID: <CAKfTPtDjEMJeoZgE1an9Nh9QZPc2gJetsZHL+8QAWzqX5_znvw@mail.gmail.com>
Subject: Re: [PATCH v2] sched,fair: skip newidle_balance if a wakeup is pending
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

On Mon, 19 Apr 2021 at 18:51, Rik van Riel <riel@surriel.com> wrote:
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
> and p99 and p95 application response time by 2-3% on average.
> The schedstats run_delay number shows a similar improvement.
>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
> v2:
>  - fix !SMP build error and prev-not-CFS case by moving check into newidle_balance
>  - fix formatting of if condition
>  - audit newidle_balance return value use to make sure we get that right
>  - reset idle_stamp when breaking out of the loop due to ->ttwu_pending
>
>  kernel/sched/fair.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 69680158963f..5e26f013e182 100644
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
> @@ -10688,7 +10697,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>         if (this_rq->nr_running != this_rq->cfs.h_nr_running)
>                 pulled_task = -1;
>
> -       if (pulled_task)
> +       if (pulled_task || this_rq->ttwu_pending)

This needs at least a comment to explain why we must clear
this_rq->idle_stamp when this_rq->ttwu_pending is set whereas it is
also done during sched_ttwu_pending()

>                 this_rq->idle_stamp = 0;
>
>         rq_repin_lock(this_rq, rf);
> --
> 2.25.4
>
>
