Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BD9387E20
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 19:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351026AbhERRDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 13:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbhERRDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 13:03:04 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29089C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 10:01:46 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id r8so14200623ybb.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 10:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0CR5GS0yklUP9nXe0pNR781mHawMh3qYttyaLEOoMqU=;
        b=baMp5ZMlrmt6EDnzDI3A7c6TlnrOSl9m1h8nt5LdpoQug/HI6PYaUXaCF2E12cNPFd
         yT1sitRHprcmLrlHnKambMfG+EIdsqAYu3t93EDSavetQjLm3hdKABVj46NRNFN/ddHY
         S/muB12aoMK0miXSgcBh+ggiGOcd7Uup/kn5Gij+gZdBv98qF3XnZ3IemyJSIpK5iwn6
         HD019s9/KEMS2uaLiT416hRIIrqLMvCm0/JhuycOkkm+UJrhFOFp2+bOGjUxRZbUDoZk
         J54M5D2Yq5nrrDW/Kmhi78ABnoW66DkAQUzo0emrYzabuOxXVXbOXXMzD6hyO+d2I1IM
         QnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0CR5GS0yklUP9nXe0pNR781mHawMh3qYttyaLEOoMqU=;
        b=kciH9ZuixxIFY/+h/2+d7mxgMBuOmhJyTClMNourcoDvmycfPyDdL3OflFjqfnEoA/
         l8rtrq4EsN9XvanoC+tLI0SZTou/1dvi/QGUFAHML5tnUjjuWW1VcW02hgn+F8lMPdPS
         lk3p0Zjvjr8oqo06DDU1VrcVFb4XCAynNxWgHTxOCya+QucseE6r9x75JmLuM7f7gqXy
         YoWhL2g6L21UdHszB+racPcDJc5sCuM/yDtJ5B5z3RC2ww+JoLV3sNzcpoVeFGU0SDov
         KaTt/Q3ipzQj5RMGkOWKz/vByu8irEEY+A7JC6/Wd/VO19VygSaabPloyBvVgr7Pp1/F
         Ip6A==
X-Gm-Message-State: AOAM5330TQ0zQj6XE79Hfcn4MonT6Rsxy1lvVebAaun2U+2mUBIC9cEG
        g/2p3i8pZZNj4mo9R6Glr5wB5johNg18lDKgidUM/w==
X-Google-Smtp-Source: ABdhPJxHklA4Zf9KxZLsDdm9Hm98RXfUD1wXEzqcvi2wrk0WNHNKWauO+wt/ZGOCAX4SvXaGBPIZzXTnm/thIalQt6s=
X-Received: by 2002:a25:7ec4:: with SMTP id z187mr8453664ybc.136.1621357305156;
 Tue, 18 May 2021 10:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <1621328816-21332-1-git-send-email-huangzhaoyang@gmail.com>
In-Reply-To: <1621328816-21332-1-git-send-email-huangzhaoyang@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 18 May 2021 10:01:34 -0700
Message-ID: <CAJuCfpG5HtD6f_Wg10Ty=4UEq7O91KAAqjR6gyWcG1Bu0hP2zg@mail.gmail.com>
Subject: Re: [PATCH v3] psi: fix race between psi_trigger_create and psimon
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

On Tue, May 18, 2021 at 2:09 AM Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
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

Please add this line in your description (see my comment in
https://lore.kernel.org/patchwork/patch/1430982/#1627215):

Fixes: 461daba06bdc ("psi: eliminate kthread_worker from psi trigger
scheduling mechanism")

Generally, before posting a new version of your patch please follow these rules:
1. Read all the comments you already received and address all of them.
2. If you are unclear or disagree with a comment you need to reply to
it instead of posting a new version.

> Signed-off-by: ziwei.dai <ziwei.dai@unisoc.com>
> Signed-off-by: ke.wang <ke.wang@unisoc.com>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> v2: change del_timer_sync to del_timer in psi_trigger_destroy
> v3: remove timer_setup within psi_tirgger_create
>     protect del_timer by extending the critical section of mutex_lock
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

Why are you refactoring the code instead of just moving del_timer()
into the trigger_lock protected area like I suggested in
https://lore.kernel.org/patchwork/patch/1429498/#1627196 ? Please
avoid unnecessary complexity and churn.

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
>
> --
> 1.9.1
>
