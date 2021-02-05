Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EFC310C42
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 14:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhBENzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 08:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhBENwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:52:19 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767B3C0613D6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 05:52:04 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id m22so7826356ljj.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 05:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ASWzAhi2cG2TQHse+1Zu4lZ0A7tCAPhy+TIzDjmHLkM=;
        b=FEqiqBbxKRc+F3Poiwa4vl81wMLAfV5VxyFnHYaiBpWou6UpR48cfY/ZenWXMwZdYB
         P+emTgcsLNav6sEWDDyew051HRnkdlw+6FT1g/ZvWWZaxaDsa2Q9j2xxe+cS9/uIuWQ2
         WUJ+tQeUiu2ab0oydkYcSnXQEltmnMogmmkBMRsUFGQ8n24B2JIXAjeen7qUlZSr3Sme
         +OkTRhfP7vmAZwDZGBr5GxJ0FZ3qr+2fM+psINYQjp45D2jlnVfDc6IdlldkjZ1hXQJn
         s5/A1MPgdy0yYF22EEdxIMWKMJ1UR8/R98GwjGNRQjWH0zGUhTDSqXK+Y2QNsWMk8Gl/
         F9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ASWzAhi2cG2TQHse+1Zu4lZ0A7tCAPhy+TIzDjmHLkM=;
        b=Ow18enNcrBw3rFhLEgfPvwZAecgfud2C7aAQHfs1i/EAi6BvaGEDvwkWuQOeRfl+k2
         EEUHC6b3gWxrqobPMPpdP0LK04/4SQBQSe1F1FhGBDO5cv1W0eGSUK+QnySWeuyy/sJo
         mubP/CnG9vYNFvccYuhzBpQ+7zgJ2ENtsAq+ZriI5hu23NPk0+AlxzGz8Hi5fF0OL526
         Uh0+K0/2mOyxqQjwrZ5Z5OgSgSwnbsZ43X5AbQeNTl/wx1P7RSvCGptPJxsWfwPnUtEl
         zDFajzn4+Tjs8rfqLrLYNW0lq+vFJtPRJCfrzTvFER3CHLbR5qGbJ5+gFQPutQHseA9V
         +/1g==
X-Gm-Message-State: AOAM532qas0Xohg4JWEHkmIr7/wUIZx8YCi+rekNe5X9SeFvvPu/tc1c
        90W3FnqdrWoPoeoTcyYL+bwQbHyyQvUGEU9J8ARv/g==
X-Google-Smtp-Source: ABdhPJz9WT4HEzFe+20unEq6h9V4ChSVF0OJxUZ0UilIi/mReWhYWQYl7T4ycCEjOI02KwEZ4eKlGSct7l2Wd4Ca+Rw=
X-Received: by 2002:a2e:9857:: with SMTP id e23mr2697903ljj.209.1612533122884;
 Fri, 05 Feb 2021 05:52:02 -0800 (PST)
MIME-Version: 1.0
References: <20210128183141.28097-1-valentin.schneider@arm.com> <20210128183141.28097-2-valentin.schneider@arm.com>
In-Reply-To: <20210128183141.28097-2-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 5 Feb 2021 14:51:51 +0100
Message-ID: <CAKfTPtDrKrkZBQuaFSGvRo=aQAdF0vugxWervQpWeza21XL=yw@mail.gmail.com>
Subject: Re: [PATCH 1/8] sched/fair: Clean up active balance nr_balance_failed trickery
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
> When triggering an active load balance, sd->nr_balance_failed is set to
> such a value that any further can_migrate_task() using said sd will ignore
> the output of task_hot().
>
> This behaviour makes sense, as active load balance intentionally preempts a
> rq's running task to migrate it right away, but this asynchronous write is
> a bit shoddy, as the stopper thread might run active_load_balance_cpu_stop
> before the sd->nr_balance_failed write either becomes visible to the
> stopper's CPU or even happens on the CPU that appended the stopper work.
>
> Add a struct lb_env flag to denote active balancing, and use it in
> can_migrate_task(). Remove the sd->nr_balance_failed write that served the
> same purpose.
>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 197a51473e0c..0f6a4e58ce3c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7423,6 +7423,7 @@ enum migration_type {
>  #define LBF_SOME_PINNED        0x08
>  #define LBF_NOHZ_STATS 0x10
>  #define LBF_NOHZ_AGAIN 0x20
> +#define LBF_ACTIVE_LB  0x40
>
>  struct lb_env {
>         struct sched_domain     *sd;
> @@ -7608,10 +7609,14 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>
>         /*
>          * Aggressive migration if:
> -        * 1) destination numa is preferred
> -        * 2) task is cache cold, or
> -        * 3) too many balance attempts have failed.
> +        * 1) active balance
> +        * 2) destination numa is preferred
> +        * 3) task is cache cold, or
> +        * 4) too many balance attempts have failed.
>          */
> +       if (env->flags & LBF_ACTIVE_LB)
> +               return 1;
> +

This changes the behavior for numa system because it skips
migrate_degrades_locality() which can return 1 and prevent active
migration whatever nr_balance_failed

Is that intentional ?

>         tsk_cache_hot = migrate_degrades_locality(p, env);
>         if (tsk_cache_hot == -1)
>                 tsk_cache_hot = task_hot(p, env);
> @@ -9805,9 +9810,6 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>                                         active_load_balance_cpu_stop, busiest,
>                                         &busiest->active_balance_work);
>                         }
> -
> -                       /* We've kicked active balancing, force task migration. */
> -                       sd->nr_balance_failed = sd->cache_nice_tries+1;
>                 }
>         } else {
>                 sd->nr_balance_failed = 0;
> @@ -9963,7 +9965,8 @@ static int active_load_balance_cpu_stop(void *data)
>                          * @dst_grpmask we need to make that test go away with lying
>                          * about DST_PINNED.
>                          */
> -                       .flags          = LBF_DST_PINNED,
> +                       .flags          = LBF_DST_PINNED |
> +                                         LBF_ACTIVE_LB,
>                 };
>
>                 schedstat_inc(sd->alb_count);
> --
> 2.27.0
>
