Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D6F386FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 04:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345187AbhERCKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 22:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238402AbhERCK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 22:10:28 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13893C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 19:09:11 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id c14so11180462ybr.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 19:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Ny5lIy3pJwNbIsx+jbPo64u2eYbS5hv3YL9/m46a60=;
        b=nGB7yTMo3luYrv4PggfMl6ZQh7jVQCszv1QFwsbzkXImQkn6hxYluV+o8mdXJyxtod
         U56V3JXibStDJY71weIi8O06n9ohTsB2/EfpnggSBd4YoAu0GCCfKIOa/9gHru8a0xHe
         MddVzicSXB8EYPrIlb1kbvqnhzuGFBObYdkzLWEnr7CWYGeTzNIxXcw3C/7gUqpZ5ROs
         6C6DJZ1Cv62qB9v4PnTmM8QT9K+4VuEjsgc8DJdxo82oWp2kThoIpVHnXTQX9UXgOyuS
         4aCWR7f88W1jzT5ZzwR1Ps44ZtvTjXt65owZylH0XHY/R8Eve630FYHlzisO8LLp/W6H
         E5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Ny5lIy3pJwNbIsx+jbPo64u2eYbS5hv3YL9/m46a60=;
        b=MQVIeaVttxKHEUll2jqRX82zE/g9MFWVOfo6qCYwlgrS7+bpIP31Rr7VzS/I1+6MHg
         v83GviFonrxX8EmoycYla4OoNH8cAsvnQGwe6K17I4FcBKL/x/9EiOg/0O8dWyMpk1+5
         /eOXJj9wfnvpYtbuL9CmHTuQMS6biHuJIXPwKL/Tr2PgySPZDQgBWM6J7Pw4VBiQvsnr
         1f1sD/OEQFUleeztcvEDqFdry5YMyxk8B4oBHzVIF6ztpOND1CPpuHE795OVwY03MNIR
         rNJ8IkOQtzhnvSUjzaxeonPfP+t0N2F/5NxEUt6iCl2U1Jc4ccumPJ5wW0EGL3Ow+1Tf
         ZBaQ==
X-Gm-Message-State: AOAM532zcT18vqA/GJmkVvV7ZY4aVe+lC0ocxF/HVHFtIia+Lziq4ZWW
        kTd0tf7XdBPfGjsu3ewxbKszsKHjkGsq2koD92+j2g==
X-Google-Smtp-Source: ABdhPJwMso5Az/gcr/sg15FsjOk/LLXX+j/2rj+2M2yTnbBsat5x3RjTQ9UPddRPlVP82p71SdLHyRgg4A8Cl/1Shv8=
X-Received: by 2002:a25:8e0e:: with SMTP id p14mr4326862ybl.84.1621303750134;
 Mon, 17 May 2021 19:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <1621242249-8314-1-git-send-email-huangzhaoyang@gmail.com>
 <YKK3wgrhqzaiE7rQ@cmpxchg.org> <CAJuCfpGLTkvH6CzQXz4oD39_xtArBt3upk-F=gf4-LPoswagGg@mail.gmail.com>
 <CAJuCfpE+Z3O_5PfDg8rEB7Cj+nMbsGPp_eWF6rRz8h2YJhy+PA@mail.gmail.com>
 <CAGWkznEMxa7BL3hih+adOEhOg5p5qiSgNaERdLjDqk_JNMv1Hg@mail.gmail.com> <CAJuCfpEZvDt-xO1fGTDJqt9RW87S7yQZ0P1=Yz-ySko_qxeX0A@mail.gmail.com>
In-Reply-To: <CAJuCfpEZvDt-xO1fGTDJqt9RW87S7yQZ0P1=Yz-ySko_qxeX0A@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 17 May 2021 19:08:59 -0700
Message-ID: <CAJuCfpH64cQZ0axOcFGtcwM2UxV_mRwx6O1US+xQyBmeODwOEQ@mail.gmail.com>
Subject: Re: [[RFC]PATCH] psi: fix race between psi_trigger_create and psimon
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, Ke Wang <ke.wang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 6:47 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Mon, May 17, 2021 at 5:41 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> >
> > On Tue, May 18, 2021 at 5:30 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Mon, May 17, 2021 at 12:33 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > On Mon, May 17, 2021 at 11:36 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > >
> > > > > CC Suren
> > > >
> > > > Thanks!

When resending the patch please run scripts/get_maintainer.pl against
your patch and CC reported recipients.
Thanks!

> > > >
> > > > >
> > > > > On Mon, May 17, 2021 at 05:04:09PM +0800, Huangzhaoyang wrote:
> > > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > >
> > > > > > Race detected between psimon_new and psimon_old as shown below, which
> > > > > > cause panic by accessing invalid psi_system->poll_wait->wait_queue_entry
> > > > > > and psi_system->poll_timer->entry->next. It is not necessary to reinit
> > > > > > resource of psi_system when psi_trigger_create.
> > > >
> > > > resource of psi_system will not be reinitialized because
> > > > init_waitqueue_head(&group->poll_wait) and friends are initialized
> > > > only during the creation of the first trigger for that group (see this
> > > > condition: https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L1119).
> > > >
> > > > > >
> > > > > > psi_trigger_create      psimon_new     psimon_old
> > > > > >  init_waitqueue_head                    finish_wait
> > > > > >                                           spin_lock(lock_old)
> > > > > >       spin_lock_init(lock_new)
> > > > > >  wake_up_process(psimon_new)
> > > > > >
> > > > > >                         finish_wait
> > > > > >                           spin_lock(lock_new)
> > > > > >                             list_del       list_del
> > > >
> > > > Could you please clarify this race a bit? I'm having trouble
> > > > deciphering this diagram. I'm guessing psimon_new/psimon_old refer to
> > > > a new trigger being created while an old one is being deleted, so it
> > > > seems like a race between psi_trigger_create/psi_trigger_destroy. The
> > > > combination of trigger_lock and RCU should be protecting us from that
> > > > but maybe I missed something?
> > > > I'm excluding a possibility of a race between psi_trigger_create with
> > > > another existing trigger on the same group because the codepath
> > > > calling init_waitqueue_head(&group->poll_wait) happens only when the
> > > > first trigger for that group is created. Therefore if there is an
> > > > existing trigger in that group that codepath will not be taken.
> > >
> > > Ok, looking at the current code I think you can hit the following race
> > > when psi_trigger_destroy is destroying the last trigger in a psi group
> > > while racing with psi_trigger_create:
> > >
> > > psi_trigger_destroy                      psi_trigger_create
> > > mutex_lock(trigger_lock);
> > > rcu_assign_pointer(poll_task, NULL);
> > > mutex_unlock(trigger_lock);
> > >                                                     mutex_lock(trigger_lock);
> > >                                                     if
> > > (!rcu_access_pointer(group->poll_task)) {
> > >
> > > timer_setup(poll_timer, poll_timer_fn, 0);
> > >
> > > rcu_assign_pointer(poll_task, task);
> > >                                                     }
> > >                                                     mutex_unlock(trigger_lock);
> > >
> > > synchronize_rcu();
> > > del_timer_sync(poll_timer); <-- poll_timer has been reinitialized by
> > > psi_trigger_create
> > >
> > > So, trigger_lock/RCU correctly protects destruction of
> > > group->poll_task but misses this race affecting poll_timer and
> > > poll_wait.
> > > Let me think if we can handle this without moving initialization into
> > > group_init().
> > Right, this is exactly what we met during a monkey test on an android
> > system, where the psimon will be destroyed/recreated by unref/recreate
> > the psi_trigger. IMHO,  poll_timer and poll_wait should exist during
> > whole period
>
> Ok, understood. I think it should be ok to initialize poll_wait and
> poll_timer at the group creation time. Looks like
> init_waitqueue_head() and timer_setup() initialize the fields but I
> don't think they allocate some additional resources. Johannes pointed
> to some issues in your original patch, so I've made some small
> modifications (see below). del_timer_sync() was important back when we
> used kthread_worker, now even if timer fires unnecessarily it should
> be harmless after we reset group->poll_task. So I think a del_timer()
> in psi_trigger_destroy() should be enough:
>
> @@ -181,6 +181,7 @@ struct psi_group psi_system = {
>  };
>
>  static void psi_avgs_work(struct work_struct *work);
> +static void poll_timer_fn(struct timer_list *t);
>
>  static void group_init(struct psi_group *group)
>  {
> @@ -202,6 +203,8 @@ static void group_init(struct psi_group *group)
>          group->polling_next_update = ULLONG_MAX;
>          group->polling_until = 0;
>          rcu_assign_pointer(group->poll_task, NULL);
> +        init_waitqueue_head(&group->poll_wait);
> +        timer_setup(&group->poll_timer, poll_timer_fn, 0);
>  }
>
>  void __init psi_init(void)
> @@ -1157,9 +1160,7 @@ struct psi_trigger *psi_trigger_create(struct
> psi_group *group,
>                          return ERR_CAST(task);
>                  }
>                  atomic_set(&group->poll_wakeup, 0);
> -                init_waitqueue_head(&group->poll_wait);
>                  wake_up_process(task);
> -                timer_setup(&group->poll_timer, poll_timer_fn, 0);
>                  rcu_assign_pointer(group->poll_task, task);
>          }
>
> @@ -1211,6 +1212,7 @@ static void psi_trigger_destroy(struct kref *ref)
>                                          group->poll_task,
>                                          lockdep_is_held(&group->trigger_lock));
>                          rcu_assign_pointer(group->poll_task, NULL);
> +                        del_timer(&group->poll_timer);
>                  }
>          }
>
> @@ -1230,10 +1232,7 @@ static void psi_trigger_destroy(struct kref *ref)
>                  /*
>                   * After the RCU grace period has expired, the worker
>                   * can no longer be found through group->poll_task.
> -                 * But it might have been already scheduled before
> -                 * that - deschedule it cleanly before destroying it.
>                   */
> -                del_timer_sync(&group->poll_timer);
>                  kthread_stop(task_to_destroy);
>          }
>          kfree(t);
>
> > >
> > > >
> > > > > >
> > > > > > Signed-off-by: ziwei.dai <ziwei.dai@unisoc.com>
> > > > > > Signed-off-by: ke.wang <ke.wang@unisoc.com>
> > > > > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > > ---
> > > > > >  kernel/sched/psi.c | 6 ++++--
> > > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > > > > > index cc25a3c..d00e585 100644
> > > > > > --- a/kernel/sched/psi.c
> > > > > > +++ b/kernel/sched/psi.c
> > > > > > @@ -182,6 +182,8 @@ struct psi_group psi_system = {
> > > > > >
> > > > > >  static void psi_avgs_work(struct work_struct *work);
> > > > > >
> > > > > > +static void poll_timer_fn(struct timer_list *t);
> > > > > > +
> > > > > >  static void group_init(struct psi_group *group)
> > > > > >  {
> > > > > >       int cpu;
> > > > > > @@ -201,6 +203,8 @@ static void group_init(struct psi_group *group)
> > > > > >       memset(group->polling_total, 0, sizeof(group->polling_total));
> > > > > >       group->polling_next_update = ULLONG_MAX;
> > > > > >       group->polling_until = 0;
> > > > > > +     init_waitqueue_head(&group->poll_wait);
> > > > > > +     timer_setup(&group->poll_timer, poll_timer_fn, 0);
> > > > >
> > > > > This makes sense.
> > > >
> > > > Well, this means we initialize resources for triggers in each psi
> > > > group even if the user never creates any triggers. Current logic
> > > > initializes them when the first trigger in the group gets created.
> > > >
> > > > >
> > > > > >       rcu_assign_pointer(group->poll_task, NULL);
> > > > > >  }
> > > > > >
> > > > > > @@ -1157,7 +1161,6 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
> > > > > >                       return ERR_CAST(task);
> > > > > >               }
> > > > > >               atomic_set(&group->poll_wakeup, 0);
> > > > > > -             init_waitqueue_head(&group->poll_wait);
> > > > > >               wake_up_process(task);
> > > > > >               timer_setup(&group->poll_timer, poll_timer_fn, 0);
> > > > >
> > > > > This looks now unncessary?
> > > > >
> > > > > >               rcu_assign_pointer(group->poll_task, task);
> > > > > > @@ -1233,7 +1236,6 @@ static void psi_trigger_destroy(struct kref *ref)
> > > > > >                * But it might have been already scheduled before
> > > > > >                * that - deschedule it cleanly before destroying it.
> > > > > >                */
> > > > > > -             del_timer_sync(&group->poll_timer);
> > > > >
> > > > > And this looks wrong. Did you mean to delete the timer_setup() line
> > > > > instead?
> > > >
> > > > I would like to get more details about this race before trying to fix
> > > > it. Please clarify.
> > > > Thanks!
