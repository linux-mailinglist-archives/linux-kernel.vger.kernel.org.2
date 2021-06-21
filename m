Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FC53AE8B0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhFUMGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhFUMGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:06:16 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D60AC0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:03:58 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a11so16720299lfg.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RLBw6jzZUcoWFnQv/t5zCIfg8AsSPtdCtp9Y9odX5Lg=;
        b=AQ13Yui/xEP4So25jkuK4rRwl5qKLjSBDp06GcVsEGi6ToCQ7D4//qsla1l49Az/4N
         jbwhYTuI5cmQGYrQsW/e1tOKqRX0x4oiTUn34xPDqN+wlNDQLWtCKN5WG/jC9iC9aV+L
         iPzo53iTiSf3Qf4bKYjHNsMlIk3UVBopmxsxIU00x6OK7PlSPBo5zhuCcaaG9RCCbOWK
         SqrfnODO7Uo+bcEajCOezrd4sUtGiV7Mun1WlQ/6FO+MaJYHag64tHkQO3ZKi4BLdF0e
         TMbRTxmw1E0dW4e+W3s/BiQ7cmkm1TlBmbWbV9UC7K9V/0gI1aZAc+yUoNLsOfhF/KXM
         dmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RLBw6jzZUcoWFnQv/t5zCIfg8AsSPtdCtp9Y9odX5Lg=;
        b=NCuvTu4l0/cboua8cBsejLOw8bZ5Yg3XvDEzIYE4DJh4aW6ewambiP7qnVjftjvuOY
         STYfVljlbVd6UXRDyswvPmiyn1gjI6yKX83L8U5YoRNGI5bCRh1bjc/QYYkb4BiN0DEw
         dByk4OXMb2lwyHKV/+hC187cKMvu9mVp+TKR9VkloyehP9R/OULN4sN14uGYOQK96j6y
         SkPeBGgihoCw58B+09pP9KDMxJOdYgqkBfkY34lESQY/VhLMa6c995uXwg0pBAcdkiPa
         ZPNnpS65qBIq6iSChaH0Qfs7j+OPQmZ8vNCEzbyYWPNq/SVqUxzuuMqUGSbYBQjNzFan
         4UGw==
X-Gm-Message-State: AOAM533NSmK5atKsFUQrlGxS3lVIDhk9NiyLAgyNTYPenFMX2C5yjMBW
        f9i29EHbcwY2ORSU1lD4xmiYsx/L6MlImprU6bkzx5a/OKsGJg==
X-Google-Smtp-Source: ABdhPJxYhe7DliOGJ+tJEAWxs82QT9MWlX5E8txmMItm54JOr3ubw0dp1miJR5MFxsenCi1afhHCbt3zSRj3qANxhNA=
X-Received: by 2002:ac2:4949:: with SMTP id o9mr14150436lfi.254.1624277036416;
 Mon, 21 Jun 2021 05:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <1624271872-211872-1-git-send-email-vincent.donnefort@arm.com> <1624271872-211872-2-git-send-email-vincent.donnefort@arm.com>
In-Reply-To: <1624271872-211872-2-git-send-email-vincent.donnefort@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 21 Jun 2021 14:03:43 +0200
Message-ID: <CAKfTPtD5bn-DnOZOcYfesFm+mP7urCiaeEsF+gd-e=jtpCK96A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/rt: Fix RT utilization tracking during
 policy change
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

On Mon, 21 Jun 2021 at 12:39, Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> RT keeps track of the utilization on a per-rq basis with the structure
> avg_rt. This utilization is updated during task_tick_rt(),
> put_prev_task_rt() and set_next_task_rt(). However, when the current
> running task changes its policy, set_next_task_rt() which would usually
> take care of updating the utilization when the rq starts running RT tasks,
> will not see a such change, leaving the avg_rt structure outdated. When
> that very same task will be dequeued later, put_prev_task_rt() will then
> update the utilization, based on a wrong last_update_time, leading to a
> huge spike in the RT utilization signal.
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

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index a525447..3daf42a 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2341,13 +2341,20 @@ void __init init_sched_rt_class(void)
>  static void switched_to_rt(struct rq *rq, struct task_struct *p)
>  {
>         /*
> -        * If we are already running, then there's nothing
> -        * that needs to be done. But if we are not running
> -        * we may need to preempt the current running task.
> -        * If that current running task is also an RT task
> +        * If we are running, update the avg_rt tracking, as the running time
> +        * will now on be accounted into the latter.
> +        */
> +       if (task_current(rq, p)) {
> +               update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
> +               return;
> +       }
> +
> +       /*
> +        * If we are not running we may need to preempt the current
> +        * running task. If that current running task is also an RT task
>          * then see if we can move to another run queue.
>          */
> -       if (task_on_rq_queued(p) && rq->curr != p) {
> +       if (task_on_rq_queued(p)) {
>  #ifdef CONFIG_SMP
>                 if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
>                         rt_queue_push_tasks(rq);
> --
> 2.7.4
>
