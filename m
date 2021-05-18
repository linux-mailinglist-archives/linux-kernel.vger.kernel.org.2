Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E01386FD7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 04:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343882AbhERCSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 22:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237378AbhERCSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 22:18:06 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2117C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 19:16:49 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id t7so6427989qtn.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 19:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Deqwsl94N1axNtysM4lpZ1EFCtrsyNhFHn1vfFPcipM=;
        b=iFHsNgLkoCW/sJxTMJroMcefzjYSsfK6q4TQrG5bkkA4LjPu+B52K1PjWJTJiRx/gA
         db3F0JNOHjqWItAoc1EBSUKXk1UwWXbBXQqcaaJTKPs0vIXcq6s6xmTVkRhXm6JtU1bb
         9BqLKvUSFHD/sh1YkytXht1mECU//mI2gdXImag/jZc2Vifqz+Wg7WmQE2Vy6JayNtqz
         kCy3E0pH7wyqYnzoQg7b7/FddZaF8VUPQKEJq/CBdl2+3xeRUVVZWxlOXxbO4oTvk5T2
         v2Mbg48Nr80r0F/w3HhomaAwISZAMSBjR+LeAeI+O4BAxRCaJ1T88WsumiP8I3VFNwfO
         rHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Deqwsl94N1axNtysM4lpZ1EFCtrsyNhFHn1vfFPcipM=;
        b=NZIg4LaqhgwC62yLmvsQDubx3cy5cCEGG5dSfAeEf9wLzl4w+EFAztBe3kboG4kuni
         aUOIHTlENLhjmQ25qgeC//5r1mwMBkNjFd5vD3diw7VBx3vdP7dVL2qpjCD0HauAZhzF
         0qpvCJCCT7q/M5Nu0z77nblZkBYm01ZBXx28+CkDusc+906AV6xncbUdeQqPxovKjAQ+
         pd8+70PimuRGcYJPRYPomUchTcq8K2iS7WQrY8Pp9yQJuszTi7mcr7M5sGNgjQuk2Zow
         R+NMDedD7OFhyfDqkMiFPNCJKfwPnIzDw4RoCocCGa7LAWXKsFSXcsfgUtkgFXpttkXC
         5YqA==
X-Gm-Message-State: AOAM531imJG4RntCMcN9ZyL67UQxAQ0OpCbLdD9w7lHULeMSeNr/QcEs
        DhtnEIca5q6uslgpoZUH5sBu0RF8DSp+K1QWXzc=
X-Google-Smtp-Source: ABdhPJx5DLg8UglRK9utjp+OiGongk5R1xhDGL+++icEhneU+rqS3NXTEhxYsPUHx34FBRPD3dPEQBr/Z0noYmYGdB0=
X-Received: by 2002:a05:622a:486:: with SMTP id p6mr2540788qtx.98.1621304208812;
 Mon, 17 May 2021 19:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <1621303811-5716-1-git-send-email-huangzhaoyang@gmail.com>
In-Reply-To: <1621303811-5716-1-git-send-email-huangzhaoyang@gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 18 May 2021 10:15:21 +0800
Message-ID: <CAGWkznFGmQFieMe6=-APBG=ZAYdpWcc27o+W0s=4ZAF5Pzkvjg@mail.gmail.com>
Subject: Re: [PATCH v2] psi: fix race between psi_trigger_create and psimon
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, Ke Wang <ke.wang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
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

resend for adding other maintainers in cc

On Tue, May 18, 2021 at 10:11 AM Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Race detected between psimon_new and psimon_old as shown below, which
> cause panic by accessing invalid psi_system->poll_wait->wait_queue_entry
> and psi_system->poll_timer->entry->next. It is not necessary to reinit
> resource of psi_system when psi_trigger_create.
>
> psi_trigger_create      psimon_new     psimon_old
>  init_waitqueue_head                    finish_wait
>                                           spin_lock(lock_old)
>         spin_lock_init(lock_new)
>  wake_up_process(psimon_new)
>
>                         finish_wait
>                           spin_lock(lock_new)
>                             list_del       list_del
>
> Signed-off-by: ziwei.dai <ziwei.dai@unisoc.com>
> Signed-off-by: ke.wang <ke.wang@unisoc.com>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> +++
> v2: change del_timer_sync to del_timer in psi_trigger_destroy
> +++
> ---
>  kernel/sched/psi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index cc25a3c..fe29022 100644
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
> @@ -1157,7 +1161,6 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
>                         return ERR_CAST(task);
>                 }
>                 atomic_set(&group->poll_wakeup, 0);
> -               init_waitqueue_head(&group->poll_wait);
>                 wake_up_process(task);
>                 timer_setup(&group->poll_timer, poll_timer_fn, 0);
>                 rcu_assign_pointer(group->poll_task, task);
> @@ -1233,7 +1236,7 @@ static void psi_trigger_destroy(struct kref *ref)
>                  * But it might have been already scheduled before
>                  * that - deschedule it cleanly before destroying it.
>                  */
> -               del_timer_sync(&group->poll_timer);
> +               del_timer(&group->poll_timer);
>                 kthread_stop(task_to_destroy);
>         }
>         kfree(t);
> --
> 1.9.1
>
