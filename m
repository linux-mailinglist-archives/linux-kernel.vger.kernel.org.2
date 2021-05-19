Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A4A3894C1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 19:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhESRn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 13:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhESRn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 13:43:27 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56870C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 10:42:06 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 191so13267192ybn.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hp4MCSJ/HnQRCHZiMKyXNBSroPBbdwD4UpB78p/G3Qo=;
        b=eaQWmg+a5hDOQC5oaoB/htVAeNV3O+lXOf5YdRBEOH8XOcW/QP+UVktk1D8PSa0Taj
         6oCQyNpJRveg2NpSdPhuvcgIKuWJo1X1W+5NEyH9/lWv+n0jVQGAmWEhZW1roA1c0+Gc
         OVjyQvVTRSmCICRpNdiK7g3niSD5XRJbZcX4Ef92i0PuUXOeevRhs28nRiPo2kllKuKS
         hzUuYGDt4Vdays0qPN4j5vFVJ2l9Fv9C+AKUpVqFsMGFAw1IWjUqG+Y8WwL3cpTeZcET
         V+NlVSyqZ7NX887dbcUMHCI2Zjc2QA1cxKUNALYKjPMv4oFjMAFpIEnhs0QsVg9Z9Roj
         PBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hp4MCSJ/HnQRCHZiMKyXNBSroPBbdwD4UpB78p/G3Qo=;
        b=GpFD8CaO+aR2/q1zaZTbC17hByPtKU0wjvmfuO1VU+K587b+UYrl10bUDuIO0QlH6l
         7mhaP/j3Kg4zb4ymI9OMu1GJThitg8R3IViCKvzpahMvzdZh28uX4mfBnb255Yni1odr
         0vyEAh6BMkAwas5Gf9FITICoroC6I8ZHffWXDXBPw0wBUTj33SJF+J4kwJyEW1KXg7sh
         rGb5JbyEi6feqnPWxVZWFZ1bqJQUiR68DGGCUHN/RJDUYn+aBi806TzTIIieWPSDI1cf
         RL9ViBcx7tqDrHGPGBBxDzjYVNVTaxZaQgSalF6VFIRskSGzhblFMt2bvrmcCoNmfMBD
         pwCw==
X-Gm-Message-State: AOAM532jJSq8PsCHmTdJJH05DvVfi+m9pn42fnnDRyIqL0MSCJ6YPlMg
        E1G9/R2gRcZJnKNQUVLm5xZAZX5L1iyIs4TUbaZk0Q==
X-Google-Smtp-Source: ABdhPJzGMMyf9e5DvklCk6x5x2jX1ev+MnLlWrDD0LE8yBC77a0GtErRK57+yxzDmobGTkOg0zTmPZ5/XyftBM+ofmE=
X-Received: by 2002:a5b:7c5:: with SMTP id t5mr1005352ybq.190.1621446125263;
 Wed, 19 May 2021 10:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <1621390860-6350-1-git-send-email-huangzhaoyang@gmail.com>
In-Reply-To: <1621390860-6350-1-git-send-email-huangzhaoyang@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 19 May 2021 10:41:54 -0700
Message-ID: <CAJuCfpH_qNn-_hqdmpy0GUyfqrh2eKaWeOBnbkGyK1H6Ev-4fw@mail.gmail.com>
Subject: Re: [PATCH v4] psi: fix race between psi_trigger_create and psimon
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

On Tue, May 18, 2021 at 7:22 PM Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Race detected between psimon_new and psimon_old as shown below, which
> cause panic by accessing invalid psi_system->poll_wait->wait_queue_entry
> and psi_system->poll_timer->entry->next. Under this modification, the
> race window is removed by initialising poll_wait and poll_timer in
> group_init which are executed only once at beginning.
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
> ---
> v2: change del_timer_sync to del_timer in psi_trigger_destroy
> v3: remove timer_setup within psi_tirgger_create
>     protect del_timer by extending the critical section of mutex_lock
> v4: amend fix information on comment
> ---
> ---
>  kernel/sched/psi.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index cc25a3c..7b53217 100644
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
> @@ -1214,16 +1216,8 @@ static void psi_trigger_destroy(struct kref *ref)
>                 }
>         }
>
> -       mutex_unlock(&group->trigger_lock);
> -
> -       /*
> -        * Wait for both *trigger_ptr from psi_trigger_replace and
> -        * poll_task RCUs to complete their read-side critical sections
> -        * before destroying the trigger and optionally the poll_task
> -        */
> -       synchronize_rcu();
>         /*
> -        * Destroy the kworker after releasing trigger_lock to prevent a
> +        * Destroy psimon after releasing trigger_lock to prevent a
>          * deadlock while waiting for psi_poll_work to acquire trigger_lock
>          */
>         if (task_to_destroy) {
> @@ -1233,9 +1227,20 @@ static void psi_trigger_destroy(struct kref *ref)
>                  * But it might have been already scheduled before
>                  * that - deschedule it cleanly before destroying it.
>                  */
> -               del_timer_sync(&group->poll_timer);
> +               del_timer(&group->poll_timer);
> +               mutex_unlock(&group->trigger_lock);
>                 kthread_stop(task_to_destroy);
> +       } else {
> +               mutex_unlock(&group->trigger_lock);
>         }
> +
> +       /*
> +        * Wait for both *trigger_ptr from psi_trigger_replace and
> +        * poll_task RCUs to complete their read-side critical sections
> +        * before destroying the trigger and optionally the poll_task
> +        */
> +       synchronize_rcu();
> +
>         kfree(t);
>  }

There is no need to move mutex_unlock() and synchronize_rcu() in
psi_trigger_destroy(). The only change in psi_trigger_destroy() that
is needed is this:

@@ -1211,6 +1212,7 @@ static void psi_trigger_destroy(struct kref *ref)
                                         group->poll_task,
                                         lockdep_is_held(&group->trigger_lock));
                         rcu_assign_pointer(group->poll_task, NULL);
+                        del_timer(&group->poll_timer);
                 }
         }

@@ -1230,10 +1232,7 @@ static void psi_trigger_destroy(struct kref *ref)
                 /*
                  * After the RCU grace period has expired, the worker
                  * can no longer be found through group->poll_task.
-                 * But it might have been already scheduled before
-                 * that - deschedule it cleanly before destroying it.
                  */
-                del_timer_sync(&group->poll_timer);
                 kthread_stop(task_to_destroy);
         }
         kfree(t);

>
> --
> 1.9.1
>
