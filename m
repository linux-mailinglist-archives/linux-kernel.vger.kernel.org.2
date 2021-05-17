Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A8E383D88
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhEQTfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbhEQTfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:35:07 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050BDC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:33:50 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id h202so10031005ybg.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AyjSqF4OoTlJgbD+co2Y6A6lMQr2dK7Nnrmcg5+fa3A=;
        b=Qnyutz6DBkj5MMbtehNMBGL3ewb5ECdM9T4RjQQwMqlyOtl0cKfOqs0gkVP65NiT5V
         BlTakS9ZbaFZBBi2HK3sNXvGJrScdZbPNw+kOwBVdRHh0WAnAbB2KATv016/MWU3h74H
         NNNzqAEo0Mozchs7cOYChs0cd0t37sk4uZdkeug8vUaTRU6mrg97cycHvD4m5Az5da74
         wJfJlfv0bETjpOlrjWbif/O1Id7v0EiIPUhlYrrMdGBIvgZR8Z+qb6wILWusRZ+uMctj
         dQn19a2RLgyYwvWz7+zStKkMQS5bRW1kxT9pLEEN/c7w21Cxr+zk5gYR14/7oIyIsnjv
         eaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AyjSqF4OoTlJgbD+co2Y6A6lMQr2dK7Nnrmcg5+fa3A=;
        b=Xy3XUsjDZODdMTQudC73lEFMj6qbhXHBSRyjFKVGqpGBPNZ5Ziw3TQVf7xGZaJ4Q/4
         4xdCiLFuN/+6cfXEXNhn+hWZh6N60tCKZ38s1nEp0rSG31PCfyIStEPMkMk+MnX7N+Ml
         tYNf7E5l7x2MQXIQNe9c/sIlZHi/S8T+7J1IIuJlRkGQYoI1WzwG/m+Fq9vJhvEZeaYG
         U2uKiF45zU9u6xO8Y6b5nTpQgyMzBhe5Oj4RlXBUWhNcsVhRXtAp9GBeMsLNx9XvFy8H
         G/DBUJhL6pGwGS/Cf1dywR0fOTcp6L/3ZRD8aWeyNoNnlc4I4nT5cHkWxqsPkNCaIeqi
         X3pw==
X-Gm-Message-State: AOAM53057SpwNZdFtBusTPgwqqpMvHbDIudKYGCrwBtLnZ15Hpb2a7qp
        CF4bC29Z9PZbK4grWcAMwmBsPr64EVFyvgn0wpRS+Q==
X-Google-Smtp-Source: ABdhPJwgl4g4QDw5oqvQQDnNdD9v6GWBmbiTAq/bkWEwrThI867EgtFAOGMJ67U3uCU0Cg9VYrhgtmE1v8c8+QLh/iw=
X-Received: by 2002:a05:6902:1026:: with SMTP id x6mr1863049ybt.23.1621280029123;
 Mon, 17 May 2021 12:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <1621242249-8314-1-git-send-email-huangzhaoyang@gmail.com> <YKK3wgrhqzaiE7rQ@cmpxchg.org>
In-Reply-To: <YKK3wgrhqzaiE7rQ@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 17 May 2021 12:33:38 -0700
Message-ID: <CAJuCfpGLTkvH6CzQXz4oD39_xtArBt3upk-F=gf4-LPoswagGg@mail.gmail.com>
Subject: Re: [[RFC]PATCH] psi: fix race between psi_trigger_create and psimon
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Huangzhaoyang <huangzhaoyang@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, Ke Wang <ke.wang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 11:36 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> CC Suren

Thanks!

>
> On Mon, May 17, 2021 at 05:04:09PM +0800, Huangzhaoyang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Race detected between psimon_new and psimon_old as shown below, which
> > cause panic by accessing invalid psi_system->poll_wait->wait_queue_entry
> > and psi_system->poll_timer->entry->next. It is not necessary to reinit
> > resource of psi_system when psi_trigger_create.

resource of psi_system will not be reinitialized because
init_waitqueue_head(&group->poll_wait) and friends are initialized
only during the creation of the first trigger for that group (see this
condition: https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L1119).

> >
> > psi_trigger_create      psimon_new     psimon_old
> >  init_waitqueue_head                    finish_wait
> >                                           spin_lock(lock_old)
> >       spin_lock_init(lock_new)
> >  wake_up_process(psimon_new)
> >
> >                         finish_wait
> >                           spin_lock(lock_new)
> >                             list_del       list_del

Could you please clarify this race a bit? I'm having trouble
deciphering this diagram. I'm guessing psimon_new/psimon_old refer to
a new trigger being created while an old one is being deleted, so it
seems like a race between psi_trigger_create/psi_trigger_destroy. The
combination of trigger_lock and RCU should be protecting us from that
but maybe I missed something?
I'm excluding a possibility of a race between psi_trigger_create with
another existing trigger on the same group because the codepath
calling init_waitqueue_head(&group->poll_wait) happens only when the
first trigger for that group is created. Therefore if there is an
existing trigger in that group that codepath will not be taken.

> >
> > Signed-off-by: ziwei.dai <ziwei.dai@unisoc.com>
> > Signed-off-by: ke.wang <ke.wang@unisoc.com>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  kernel/sched/psi.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index cc25a3c..d00e585 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -182,6 +182,8 @@ struct psi_group psi_system = {
> >
> >  static void psi_avgs_work(struct work_struct *work);
> >
> > +static void poll_timer_fn(struct timer_list *t);
> > +
> >  static void group_init(struct psi_group *group)
> >  {
> >       int cpu;
> > @@ -201,6 +203,8 @@ static void group_init(struct psi_group *group)
> >       memset(group->polling_total, 0, sizeof(group->polling_total));
> >       group->polling_next_update = ULLONG_MAX;
> >       group->polling_until = 0;
> > +     init_waitqueue_head(&group->poll_wait);
> > +     timer_setup(&group->poll_timer, poll_timer_fn, 0);
>
> This makes sense.

Well, this means we initialize resources for triggers in each psi
group even if the user never creates any triggers. Current logic
initializes them when the first trigger in the group gets created.

>
> >       rcu_assign_pointer(group->poll_task, NULL);
> >  }
> >
> > @@ -1157,7 +1161,6 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
> >                       return ERR_CAST(task);
> >               }
> >               atomic_set(&group->poll_wakeup, 0);
> > -             init_waitqueue_head(&group->poll_wait);
> >               wake_up_process(task);
> >               timer_setup(&group->poll_timer, poll_timer_fn, 0);
>
> This looks now unncessary?
>
> >               rcu_assign_pointer(group->poll_task, task);
> > @@ -1233,7 +1236,6 @@ static void psi_trigger_destroy(struct kref *ref)
> >                * But it might have been already scheduled before
> >                * that - deschedule it cleanly before destroying it.
> >                */
> > -             del_timer_sync(&group->poll_timer);
>
> And this looks wrong. Did you mean to delete the timer_setup() line
> instead?

I would like to get more details about this race before trying to fix
it. Please clarify.
Thanks!
