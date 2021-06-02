Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CFF3989C4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhFBMjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFBMjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:39:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9F0C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 05:37:23 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id f30so3173678lfj.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 05:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8PqULTBrsSuBQESuLaha+XAIqL+NLDB4pV3bb3Gk0Ns=;
        b=QrP6W7zXEaPvUGhYr1BOSwFbQm01sqAnALBeXeAJFOw9NyL6EOuHipcB0zqPA2G3A4
         fJhoBnfkZEVrp6GILxQC9agjxReOH/sxxvshpfkN7io08RjuGIuiign85xoaCcZvqPZ1
         XTJIJZHrtUoPvi9DZGb4C3e9WYUlL5yHswmKwVKZct8UCprvR/q3ISLIcU8K6Y0SvukG
         0laPn7Zei8HXCLcsBWLyWGfLuQvQLAnPsEJty36yNiCQIoT25UfMXp7n27R9h/6BHhLg
         SFPxlG/CJFc9wG7DsxOPHu2f1Si7vazCNLB+j7nXxvuIkQIqwjZhD9GqAtKpeyzw7KmL
         xRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8PqULTBrsSuBQESuLaha+XAIqL+NLDB4pV3bb3Gk0Ns=;
        b=NnrKxJ3jOV7dSnW+FrSRjcbFROiJxzDyD1F/4MSBtd3CQyF85mJC7Nf1pSr7SWq5DU
         CZIsx6IwF/mXfu82RmFYzuYz3+XuYPJGrtFdjjflkUKG0/eSUXdGKfqG4DtLBOJy1nBt
         mI3odGu+pwDV03uI+M+x4PAK2C3pRmIsJ0c8JtGPk9Es7OUn5bM3ZzLCqe8cNm7Yrp3H
         lV0oy+g8Cxqvty3yT4jbBbOexb6n8Z0u/BvfKZCmtompW/g/Mr0zPVS7WSYkIn5wlr0W
         2yxhoARdMQpUsCE4mkCDrCXh8lSULCzu7wSvZsRRg8qrPmDkyz6osj4fLqn6O/xKCo/r
         aE2Q==
X-Gm-Message-State: AOAM533RQPyyjlOB3PJVxmqpXL8bBoWkSrVUBNrA+yD1OqvQdutg6S49
        XqRxySx146MTN4xdrSdTg737DnpgRFpjMJr6QKfqlg==
X-Google-Smtp-Source: ABdhPJxwrSiAwHT/j9GBhQmA/pqqCgez0Dd2Wk15iJxfnaLhAKNu6pgB5vE6ptiTyS/WhQ4CQgphwMG6KhFm6gnOBRs=
X-Received: by 2002:a05:6512:3e12:: with SMTP id i18mr18386456lfv.286.1622637441915;
 Wed, 02 Jun 2021 05:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210602122555.10082-1-laoar.shao@gmail.com>
In-Reply-To: <20210602122555.10082-1-laoar.shao@gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 2 Jun 2021 14:37:10 +0200
Message-ID: <CAKfTPtCS6bVGK1EFUHygj+uZL5N2kEzyyEeoyT4Cuc7r-65yVw@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched: do active load balance on the new idle cpu
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.co>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 at 14:26, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> We monitored our latency-sensitive RT tasks are randomly preempted by the
> kthreads migration/n, which means to migrate tasks on CPUn to other new
> idle CPU. The logical as follows,
>
>   new idle CPU                          CPU n
>   (no task to run)                      (busy running)
>   wakeup migration/n                    (busy running)
>   (idle)                                migraion/n preempts current task
>   run the migrated task                 (busy running)

migration thread is only used when we want to migrate the currently
running task of the source cpu.
This doesn't seem to be your case as it's a RT thread that is
currently running so the migration thread should not be woken up as we
don't need it to migrate a runnable but not running cfs thread from
coin to new idle CPU

Do you have more details about the UC. Could it be a race between new
idle load balance starting migration thread to pull the cfs running
thread and the RT thread waking up and preempting cfs task before
migration threads which then preempt your RT threads



>
> As the new idle CPU is going to be idle, we'd better move the migration
> work on it instead of burdening the busy CPU. After this change, the
> logic is,
>  new idle CPU                           CPU n
>  (no task to run)                       (busy running)
>  migrate task from CPU n                (busy running)
>  run the migrated task                  (busy running)
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/sched/fair.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3248e24a90b0..3e8b98b982ff 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9807,13 +9807,11 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>                                 busiest->push_cpu = this_cpu;
>                                 active_balance = 1;
>                         }
> -                       raw_spin_unlock_irqrestore(&busiest->lock, flags);
>
> -                       if (active_balance) {
> -                               stop_one_cpu_nowait(cpu_of(busiest),
> -                                       active_load_balance_cpu_stop, busiest,
> -                                       &busiest->active_balance_work);
> -                       }
> +                       if (active_balance)
> +                               active_load_balance_cpu_stop(busiest);

this doesn't make sense because we reach this point if we want to
migrate the current running task of the busiest cpu and in order to do
this we need the preempt this current running thread

> +
> +                       raw_spin_unlock_irqrestore(&busiest->lock, flags);
>                 }
>         } else {
>                 sd->nr_balance_failed = 0;
> @@ -9923,7 +9921,6 @@ static int active_load_balance_cpu_stop(void *data)
>         struct task_struct *p = NULL;
>         struct rq_flags rf;
>
> -       rq_lock_irq(busiest_rq, &rf);
>         /*
>          * Between queueing the stop-work and running it is a hole in which
>          * CPUs can become inactive. We should not move tasks from or to
> @@ -9933,8 +9930,7 @@ static int active_load_balance_cpu_stop(void *data)
>                 goto out_unlock;
>
>         /* Make sure the requested CPU hasn't gone down in the meantime: */
> -       if (unlikely(busiest_cpu != smp_processor_id() ||
> -                    !busiest_rq->active_balance))
> +       if (unlikely(!busiest_rq->active_balance))
>                 goto out_unlock;
>
>         /* Is there any task to move? */
> @@ -9981,13 +9977,10 @@ static int active_load_balance_cpu_stop(void *data)
>         rcu_read_unlock();
>  out_unlock:
>         busiest_rq->active_balance = 0;
> -       rq_unlock(busiest_rq, &rf);
>
>         if (p)
>                 attach_one_task(target_rq, p);
>
> -       local_irq_enable();
> -
>         return 0;
>  }
>
> --
> 2.17.1
>
