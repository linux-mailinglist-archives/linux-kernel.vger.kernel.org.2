Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C0438BC47
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 04:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbhEUCMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 22:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhEUCMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 22:12:42 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F8BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 19:11:20 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id y2so25434184ybq.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 19:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uyq3WBjxTp4JSh2iQhpcP8eqsbVU8+ekz9fQST+TGgk=;
        b=vBz9cvwKVWjtbCbpDJoTDsu7vl2xWoU6iW9RktT0FGu+NdKX3wIAtlYEDf46ltizQW
         aINOFBq8tSO+m/T+n1NWq2vps/j+VLXpUZBTf9NdAqFDWT3p+6JpmHS1rZNQTplZXuUe
         2V69iKvzUUC72UyQkqNiI00HXe8w9NR6uKeqnBiR9ZRocthFQcnCz3Qp+dpgOguju51b
         ajqWMJfz0yckeQI4WuOghdDYeT3T3DPb6Un0AeP3+L826+ZYouvMLiGDSBo9ymPYQcfS
         DQ/YKMhr23skI30DJVYMkF0fjxR+KJ7igil8bxI4fIRC2bJ3BPVB0SkJ1J/h4r9C6Sy6
         VAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uyq3WBjxTp4JSh2iQhpcP8eqsbVU8+ekz9fQST+TGgk=;
        b=BcKpihdcxcUiezh9P5c198HehVWkucBg0GMb0fZzpmJD+/W1eNHcaw7WL1RYwbltm6
         rS9pOaucXZoSHE7bs6D3ixL6QDzouNuO8vj7RmH5IiJ8komdaPBrYjw8qRDAfYeJKth+
         vbTq+zVepLxCtPXzGdzVwBmnGT+MGNofFQ6tfgEdPC/2lMzbllrg94Zx1FJ26CBZGyza
         /LL0LGP05rZE5AVp6fSQIEJXJqwSQW5SEpvXfZxotGqpwkTEeiEwO3YKjeV+V+SGrjUb
         193iDXdGtGlKPe48xTiN4beoGKrJarJ3jAztblmoJSFzJ7h9Op+EJ6gudI4z9M/qseuE
         EFEg==
X-Gm-Message-State: AOAM530wB/dpCMDHO+dqxRgR5gNt8X27USM8IzcX8pk/5Sn00H4valdj
        PGLfs0EZStG0IQHOMrjrKnL+jHus16LR/fCePu4LP9eLusE=
X-Google-Smtp-Source: ABdhPJy2l5z2C/KHxEXh4CetkuJQYsjVdHwrxHaM88x1VgfuEHt/1Gj7dUn+wX4Tlu6C9+Xepfc7mrvrZTGlMYr5QKg=
X-Received: by 2002:a25:ba08:: with SMTP id t8mr7052624ybg.111.1621563079230;
 Thu, 20 May 2021 19:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <1621562754-8158-1-git-send-email-huangzhaoyang@gmail.com>
In-Reply-To: <1621562754-8158-1-git-send-email-huangzhaoyang@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 20 May 2021 19:11:08 -0700
Message-ID: <CAJuCfpFOXgN8gQUv2RkqMNbDBEjHs3uaxDPWd3wD-qM6zXeAsQ@mail.gmail.com>
Subject: Re: [PATCH v6] psi: fix race between psi_trigger_create/destroy
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

On Thu, May 20, 2021 at 7:07 PM Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Race detected between psi_trigger_destroy/create as shown below, which
> cause panic by accessing invalid psi_system->poll_wait->wait_queue_entry
> and psi_system->poll_timer->entry->next. Under this modification, the
> race window is removed by initialising poll_wait and poll_timer in
> group_init which are executed only once at beginning.
>
> psi_trigger_destroy                      psi_trigger_create
> mutex_lock(trigger_lock);
> rcu_assign_pointer(poll_task, NULL);
> mutex_unlock(trigger_lock);
>                                         mutex_lock(trigger_lock);
>                                         if (!rcu_access_pointer(group->poll_task)) {
>
>                                                 timer_setup(poll_timer, poll_timer_fn, 0);
>
>                                                 rcu_assign_pointer(poll_task, task);
>                                         }
>                                         mutex_unlock(trigger_lock);
>
> synchronize_rcu();
> del_timer_sync(poll_timer); <-- poll_timer has been reinitialized by
> psi_trigger_create
>
> So, trigger_lock/RCU correctly protects destruction of group->poll_task but
> misses this race affecting poll_timer and poll_wait.
>
> Fixes: 461daba06bdc ("psi: eliminate kthread_worker from psi trigger
> scheduling mechanism")
>
> Signed-off-by: ziwei.dai <ziwei.dai@unisoc.com>
> Signed-off-by: ke.wang <ke.wang@unisoc.com>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Looks good. Thanks!
Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
> v2: change del_timer_sync to del_timer in psi_trigger_destroy
> v3: remove timer_setup within psi_tirgger_create
>     protect del_timer by extending the critical section of mutex_lock
> v4: amend fix information on comment
> v5: delete the poll_timer while assigning the task to NULL
> v6: update subject and comments as Suren's suggestion
> ---
> ---
>  kernel/sched/psi.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index cc25a3c..58b36d1 100644
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
> +        * Stop kthread 'psimon' after releasing trigger_lock to prevent a
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
