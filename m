Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC31638B642
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbhETSpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 14:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236026AbhETSpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:45:42 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41FBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 11:44:15 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id n4so5711550ybf.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 11:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=amtSNXl8HLBpjElh9eiGyVH9ZwKi9e1S6mpIdLJ/Xyg=;
        b=fRdHRfc5zQq5RqCGyUyHIoMb2oovD8s3V+s8N6Asv4ahwyEPKkheMdc8ppf0r1R9r5
         n2OjlzSYiYhybUJ+pTYClv7ihHHrOMfd7VtXv42bPtdU1JkMwlk/aItXR+dcLYMZzJKh
         RSv+Oy+2Cq5o6Jsni9F99kckJ/PvDXh+aX5DvvTRPa4lP7ZoRCBU5DL8KazK3ys/B8we
         W2Q5z8ubqZ3W2omKb6bq07xbpfA8K6xBJ3XQR7FmsV/XA/gj5dXLGfrO/LDBrB32UDzy
         s/MrEeLjC0sD3S6xZb6AYgAr/A/mnyrte5kruXOoPEOHpCQJ31EGNecqeI3eQZOqHgdw
         Bicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=amtSNXl8HLBpjElh9eiGyVH9ZwKi9e1S6mpIdLJ/Xyg=;
        b=SVZQ5m8S1st2jFsjSyRIntWECp+43W1fpGIgCT2SnLbJvJCbk50OgqTQUI9B6pdXb1
         XhrmHxuxNptwA9cEJ4qSdwJaMhshLWEoElZZdE90qtp1ggTubD6hEBFCg0rB9dh04Srg
         EsO6GBd0IPpqDBa8/MB86YI3JQI/1o1zEhLtDj5FEiHBncxNAYTTdQ1uyPwQpT2hcE2B
         wbJfUzTtPdiNmWYmq/THXc6SmaeUolWUkQDIfUbkwshzIC/tou2PmT386xLRuI0s+jJ7
         p924H99CjU3kGkB/1dqXdyu2O4sXrRnr2hKPWbu+jnoFi5/I86AphoquMsvbp4XZgZ90
         K3rg==
X-Gm-Message-State: AOAM5334jVy7ir3gJee46cf41KSd8lrXQVYxyDs6nNGWZUWJZD8wyLKY
        /T7ZYXLRxjGe9coEIiJTy4XDfttzqLRrznp1DF0X0w==
X-Google-Smtp-Source: ABdhPJzWP+G+N2nHnvUVk2nOkRvPe34ZSpOYv1VRcCnh4E2Gme/QDe1HgdRemwy1h50S1BbtoPMCRLc7GMNmxWj/N9o=
X-Received: by 2002:a25:7ec4:: with SMTP id z187mr9085138ybc.136.1621536254783;
 Thu, 20 May 2021 11:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <1621475729-22857-1-git-send-email-huangzhaoyang@gmail.com>
In-Reply-To: <1621475729-22857-1-git-send-email-huangzhaoyang@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 20 May 2021 11:44:03 -0700
Message-ID: <CAJuCfpFc3R-tfqkt3NrW5H+E4GGCN-fb_5qrvJHtXbJaHRsMrw@mail.gmail.com>
Subject: Re: [PATCH v5] psi: fix race between psi_trigger_create and psimon
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, Ke Wang <ke.wang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks! The code looks good to me, just a couple nits below.

On Wed, May 19, 2021 at 6:56 PM Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Race detected between psimon_new and psimon_old as shown below, which
> cause panic by accessing invalid psi_system->poll_wait->wait_queue_entry
> and psi_system->poll_timer->entry->next. Under this modification, the
> race window is removed by initialising poll_wait and poll_timer in
> group_init which are executed only once at beginning.

I still think describing this as a race between psi_trigger_create and
psi_trigger_destroy would be better. Description in abstract terms
like "psimon_new" and "psimon_old" is not very clear IMO. Feel free to
borrow from my reply at
https://lore.kernel.org/patchwork/patch/1429498/#1627054, but I won't
object to the current version as well.

>
> psi_trigger_create      psimon_new     psimon_old
>  init_waitqueue_head                    finish_wait
>                                           spin_lock(lock_old)
>   spin_lock_init(lock_new)
>  wake_up_process(psimon_new)
>
>                         finish_wait
>                           spin_lock(lock_new)
>                             list_del       list_del
>
> Fixes: 461daba06bdc ("psi: eliminate kthread_worker from psi trigger
> scheduling mechanism")
>
> Signed-off-by: ziwei.dai <ziwei.dai@unisoc.com>
> Signed-off-by: ke.wang <ke.wang@unisoc.com>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
> v2: change del_timer_sync to del_timer in psi_trigger_destroy
> v3: remove timer_setup within psi_tirgger_create
>     protect del_timer by extending the critical section of mutex_lock
> v4: amend fix information on comment
> v5: delete the poll_timer while assigning the task to NULL
> ---
> ---
>  kernel/sched/psi.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index cc25a3c..075501e 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -182,6 +182,8 @@ struct psi_group psi_system = {
>
>  static void psi_avgs_work(struct work_struct *work);
>
> +static void poll_timer_fn(struct timer_list *t);
> +
>  static void group_init(struct psi_group *group)
>  {
>         int cpu;
> @@ -201,6 +203,8 @@ static void group_init(struct psi_group *group)
>         memset(group->polling_total, 0, sizeof(group->polling_total));
>         group->polling_next_update = ULLONG_MAX;
>         group->polling_until = 0;
> +       init_waitqueue_head(&group->poll_wait);
> +       timer_setup(&group->poll_timer, poll_timer_fn, 0);
>         rcu_assign_pointer(group->poll_task, NULL);
>  }
>
> @@ -1157,9 +1161,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
>                         return ERR_CAST(task);
>                 }
>                 atomic_set(&group->poll_wakeup, 0);
> -               init_waitqueue_head(&group->poll_wait);
>                 wake_up_process(task);
> -               timer_setup(&group->poll_timer, poll_timer_fn, 0);
>                 rcu_assign_pointer(group->poll_task, task);
>         }
>
> @@ -1211,6 +1213,7 @@ static void psi_trigger_destroy(struct kref *ref)
>                                         group->poll_task,
>                                         lockdep_is_held(&group->trigger_lock));
>                         rcu_assign_pointer(group->poll_task, NULL);
> +                       del_timer(&group->poll_timer);
>                 }
>         }
>
> @@ -1223,17 +1226,14 @@ static void psi_trigger_destroy(struct kref *ref)
>          */
>         synchronize_rcu();
>         /*
> -        * Destroy the kworker after releasing trigger_lock to prevent a
> +        * Destroy psimon after releasing trigger_lock to prevent a

Technically this should read as "Stop kthread" instead of "Destroy psimon".

>          * deadlock while waiting for psi_poll_work to acquire trigger_lock
>          */
>         if (task_to_destroy) {
>                 /*
>                  * After the RCU grace period has expired, the worker
>                  * can no longer be found through group->poll_task.
> -                * But it might have been already scheduled before
> -                * that - deschedule it cleanly before destroying it.
>                  */
> -               del_timer_sync(&group->poll_timer);
>                 kthread_stop(task_to_destroy);
>         }
>         kfree(t);
> --
> 1.9.1
>
