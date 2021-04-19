Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6F7364148
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 14:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbhDSMMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 08:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237650AbhDSMMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 08:12:44 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F847C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 05:12:14 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x19so25153744lfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 05:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jk8cUESaS2PhVsxT1qv4OEiuADnSJdzp/1nAVuneZ4w=;
        b=LRXX0Ypm6HKXqidAnD3jouMvuRBI7OADh9UGKK2esvIoz/t844O61CkGySvyMfqsPF
         CebNiHk0PeVAHBhD+nyRQ0WSIsqTbauQ2yyWmCl6c63YAX6tf5s2HJNLu8QoxG0oIZPD
         BNXT2rnb1OxXp/xh5JwaKJmJUM9Fjz3C8yyDt2xwfaquNfK2bT8esFX0yKobMiG2at4m
         4AxCN4JeCoTCakbHzdFFXb7v8ZjATPlSGMteo8vNy/tl4us6k1TrOxhvyNB4Ewt4TAH6
         jHJQ/W/Po9Cgoa82GAr6xqgK5XkRsXO9qulQrHZzjfHCeLbHNW7PFfWpDGCZ6ZtJmky0
         ym0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jk8cUESaS2PhVsxT1qv4OEiuADnSJdzp/1nAVuneZ4w=;
        b=idqSSEo9DlWDaI28INH5fONL3t8vnFR0FRUusVJ078JpWggn5ooP//BB74kilNWUXk
         4eKrSe0Gxg6oGEiZxRpRzmBBc+JVnlgPRsVh3Bu0ZmkPAX+MQaI8+CJvU1AZGY1wlkP0
         1DZI4GqIvnXZa9cIG+qy80dx1xNAKBTLOFNXPWC6Ehs10Wj4vO3tnl66OydNGMlijyY3
         WHTUXZQTqmXbzDg6BudTfhuFfOAdbMHXbt5h9g4dO84duIZBBlYBmdp97uOACYzpHUXh
         2HryiepB+1+NI/gzfljE0BiA9DmD0bfgywz+TccZca8pNX+7V3uZLuKgnkUffHZwz0IV
         jFpw==
X-Gm-Message-State: AOAM533iL/j0uvKglq61ORwwmGg+NFtMkIEhshuds5E3DazlmK3yjKUo
        Okc7IHpJQ/TfXa5Whqoj5Gj9SIy7P9RyPMaIzPkIyQ==
X-Google-Smtp-Source: ABdhPJytjgp9cOOzQUBu9t0sfZFVJxah60vwWZVXWD+3Gd86fEKvY5rV2iXwjIbrd7L22KcLwC06NmJnefYJdrE6/zI=
X-Received: by 2002:a19:4082:: with SMTP id n124mr12211144lfa.154.1618834332805;
 Mon, 19 Apr 2021 05:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210418221751.7edfc03b@imladris.surriel.com>
In-Reply-To: <20210418221751.7edfc03b@imladris.surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 19 Apr 2021 14:12:01 +0200
Message-ID: <CAKfTPtBJ7zv=2S+7xSOzidiBvsN9WZxFcPw5nUd+ANEMfLn_sg@mail.gmail.com>
Subject: Re: [PATCH] sched,fair: skip newidle_balance if a wakeup is pending
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2021 at 04:18, Rik van Riel <riel@surriel.com> wrote:
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
>  kernel/sched/fair.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 69680158963f..19a92c48939f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7163,6 +7163,14 @@ done: __maybe_unused;
>         if (!rf)
>                 return NULL;
>
> +       /*
> +        * We have a woken up task pending here. No need to search for ones
> +        * elsewhere. This task will be enqueued the moment we unblock irqs
> +        * upon exiting the scheduler.
> +        */
> +       if (rq->ttwu_pending)
> +               return NULL;

Would it be better to put this check at the beg of newidle_balance() ?
If prev is not a cfs task, we never reach this point but instead use the path:
class->balance => balance_fair => newidle_balance

and we will not check for rq->ttwu_pending

> +
>         new_tasks = newidle_balance(rq, rf);
>
>         /*
> @@ -10661,7 +10669,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>                  * Stop searching for tasks to pull if there are
>                  * now runnable tasks on this rq.
>                  */
> -               if (pulled_task || this_rq->nr_running > 0)
> +               if (pulled_task || this_rq->nr_running > 0 ||
> +                                               this_rq->ttwu_pending)
>                         break;
>         }
>         rcu_read_unlock();
> --
> 2.25.4
>
>
