Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6703AE513
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFUIlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhFUIlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:41:04 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E525C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 01:38:49 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j2so28839520lfg.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 01:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9jMYLUrrOI1yaw5ImE3JnFJ+Mx0Uew0rm/8NPXZZUEk=;
        b=kOFVOPXadYeTHKcLOLKNgnVDouO/dLcue3Tr1+MF1hCKDbi+q3aHuowH/yb4mZ7Rsu
         BEqLlD13HdMs14gSuYcqNKZlfAA+OWk/rBtHgH9MH7t7FfQXEJYx5oe4MxvbKnfWy6fv
         tnZ8F1WNK3BF/3Cyk29hoUx3f/GpTvCX9I8IsMOJhecZJpcaCaPi0Ie8q62v84bHau4f
         E6ZPUPvqcbelmAV9NJ+8pxctJfJBSrNy9by4y80yjxgGBBvkBd6JJ0WchKJcm0yPBIxM
         /8AlJFMvKG6ROuqW0xAEGtQY1Us/2piwlLG8VQjQbQ9ikkZkN6ve2c06lXT1rsPgl8U4
         4QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jMYLUrrOI1yaw5ImE3JnFJ+Mx0Uew0rm/8NPXZZUEk=;
        b=eLYsle9lYtG/zi/6NIWuQ8bd38M/3Xu7LEZELsLLOvJZkVvkhAcss+BFw6XgxFk69Z
         +AvEfluBoGswsEwAddcojjrKHrsb6M0g1Fus5dq86xn49+dwcnNxpA4bj8aRLDpcY3Lw
         VEgGteiubian7KdSkIfKh1Enj7I0T8Nngc59dlU5yDT8G5rpgIgDEkgbFCXF/eZlUyax
         Rit7fE54iDyZShcdjlziSFuvIIyLk9ZKKziTkbLAK1+Reqjzbw8ybSlCNXnFAz8mQKtW
         CA5ucI1pPON5qHnQDJbsALNkuCX/w2peFGNV5OdJNwmn27Xpo3Q+UTgJo8E7ghEPU0cB
         kdwQ==
X-Gm-Message-State: AOAM5338drceCKg4JVmc17HMvuLnbay1UAIVawpKAbzR5vfJxCeqvqRc
        Al2bTFhP2hieqYQsip/SNYuzVOaUJ9vqcssaqlrZqA==
X-Google-Smtp-Source: ABdhPJzw/R5ylqqLGqr1L6eUykOtn1MXcH6tahCP0eop/XnUlB8Ik7TiwZjinUBNFALW2Yz72STh3R/NfPm5rOM2E4A=
X-Received: by 2002:a05:6512:3603:: with SMTP id f3mr13756623lfs.470.1624264727525;
 Mon, 21 Jun 2021 01:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <1624023139-66147-1-git-send-email-vincent.donnefort@arm.com>
In-Reply-To: <1624023139-66147-1-git-send-email-vincent.donnefort@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 21 Jun 2021 10:38:36 +0200
Message-ID: <CAKfTPtDgLRYdFNY_A3=yXk-LXi-eH21xApAaYfYk_RbG4k61EQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/rt: Fix RT utilization tracking during policy change
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 at 15:32, Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> RT keeps track of the utilization on a per-rq basis with the structure
> avg_rt. This utilization is updated during task_tick_rt(),
> put_prev_task_rt() and set_next_task_rt(). However, when the current
> running task changes its policy, set_next_task_rt() which would usually
> take care of updating the utilization when the rq starts running RT tasks,
> will not see a such change, leaving the avg_rt structure outdated. When
> that very same task will be dequeued later, put_prev_task_rt() will then
> update the utilization, based on a wrong last_update_time, leading a huge
> spike in the RT utilization signal.
>
> The signal would eventually recover from this issue after few ms. Even if
> no RT tasks are run, avg_rt is also updated in __update_blocked_others().
> But as the CPU capacity depends partly on the avg_rt, this issue has
> nonetheless a significant impact on the scheduler.
>
> Fix this issue by ensuring a load update when a running task changes
> its policy to RT.
>
> Fixes: 371bf427 ("sched/rt: Add rt_rq utilization tracking")
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
>
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index a525447..5ac0f31 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2341,10 +2341,8 @@ void __init init_sched_rt_class(void)
>  static void switched_to_rt(struct rq *rq, struct task_struct *p)
>  {
>         /*
> -        * If we are already running, then there's nothing
> -        * that needs to be done. But if we are not running
> -        * we may need to preempt the current running task.
> -        * If that current running task is also an RT task
> +        * If we are not running we may need to preempt the current
> +        * running task. If that current running task is also an RT task
>          * then see if we can move to another run queue.
>          */
>         if (task_on_rq_queued(p) && rq->curr != p) {
> @@ -2355,6 +2353,13 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
>                 if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
>                         resched_curr(rq);
>         }
> +
> +       /*
> +        * If we are running, update the avg_rt tracking, as the running time
> +        * will now on be accounted into the latter.
> +        */
> +       if (task_current(rq, p))

task_current(rq,p) equals the "rq->curr != p" above. Having 2
different ways to get the same value in the function is a bit
confusing.

And call it once

Otherwise, the fix looks good to me

> +               update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
>  }
>
>  /*
> --
> 2.7.4
>
