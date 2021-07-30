Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154723DBB65
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239274AbhG3OxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239244AbhG3Ow6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:52:58 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE073C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:52:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id yk17so9579366ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GaPqfOnmM2OkUansSDl7biIxF+dUimvAler8p4dIeuw=;
        b=C9mqIBwii0F7VvQlys97D2ef+OMcF1PaEjFF0Y5wEZvfM3ALVqp4Zam3+2xYn5BEiF
         FxVlHGwpyHoRVYwWkqUqnMKRha4U+Xts00UMTqvSOFAeNYr7krltMCFq3kthq4PGnafq
         McPTHSOYIO24lzKKkkAA18LEqEe93S3yo/Ed0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GaPqfOnmM2OkUansSDl7biIxF+dUimvAler8p4dIeuw=;
        b=RG9Fsz0BdJSMZkxDa7DZKsE4lwIFYnSdmaDRkDvvjfdGfyuW9kWpAxKaUU6pA27eax
         SOdc1ybzgNzEx1JiGeMeCLUu2F0dygS57P0AAnXD4HbQ9hDrmCFxRXI7AoCCZXK4DLJk
         BEDt1JUXlq8hcxePTRqkEEvVlLrYUjCzLRNz16s2hzIHhaxlY9wX2DySpSpq5+IBQINT
         PaTbv2YOS+ICzQzNqupoZ/pyp9hZdqT5+YLzCJpVO9bUbCX5Nox9ab3kOv2ntJD1lbQY
         CQArJIUVaPAXXXJoCXPJSRIjLVD1zC5/tWSQsUtacOtx44Z5JZ7N4G2xCU+aBcjEY/HZ
         Stpw==
X-Gm-Message-State: AOAM533jC4+weD6k8BBpgCsxUtSz4ZeJUhCCDyNbCFk7L2XqDD/n6f8n
        QPioZvYrXkzj1ZTN5yECfU8mO2spKOL1VeiLClx6Ow==
X-Google-Smtp-Source: ABdhPJwr9hg1Rq4q5yJmGf6P9EYB0WfXsANC15eg15H/lahmPyYAgm7UbK88A4bpYPx4NC9bH/bK0d28p8q1r4c4jus=
X-Received: by 2002:a17:906:705:: with SMTP id y5mr2813460ejb.149.1627656771406;
 Fri, 30 Jul 2021 07:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJqdLrov0VBzHamSvMRKBHSJX+NROUx0TUsRD9U0zEWUn5XxDA@mail.gmail.com>
 <20210714173005.491941-1-alexander.mikhalitsyn@virtuozzo.com> <bd0a1f71-4624-d88a-98a8-6550926349b3@colorfullife.com>
In-Reply-To: <bd0a1f71-4624-d88a-98a8-6550926349b3@colorfullife.com>
From:   Alexander Mihalicyn <alexander@mihalicyn.com>
Date:   Fri, 30 Jul 2021 17:52:40 +0300
Message-ID: <CAJqdLrrn5U7XY4H6_kHgXZ4hnxHPyNnzMn1iRVj02CLXYysccg@mail.gmail.com>
Subject: Re: [RFC PATCH] shm: extend forced shm destroy to support objects
 from several IPC nses
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Manfred,

I'm sorry for the long delay with the answer.
Bug hunting season is open, so I tried to catch another one last week :)

I will return to work on that problem next week.

Thank you very much for your review, suggestions and fixes. I will
take your fixes
and, if you allow, add your Co-developed-by tag ;)

I've left some comments below.

On Thu, Jul 22, 2021 at 9:46 PM Manfred Spraul <manfred@colorfullife.com> wrote:
>
> Hi Alexander,
>
> A few more remarks.
>
> On 7/14/21 7:30 PM, Alexander Mikhalitsyn wrote:
> > This is total rework of fix.
> > Thanks to Eric Biederman for suggestions (but may be I've misunderstood some of them :))
> >
> > I've tested it with reproducer of the original problem. But of course it needs
> > detailed testing. I hope that I get some general comments about design and implementation.
> >
> > ToDo: remove unneeded "ns" argument from shm_destroy, shm_rmid and other functions.
>
> What ensures the that shp->ns is not destroyed prematurely?
>
> I did some tests, and it seems that shmat() acquires a namespace
> refcount, and shm_release() puts it again, and the shm_release is late
> enough to ensure that the ns cannot go out of scope.
>
> But I haven't checked all combinations (with/without shm_rmid_forced,
> delete via exit(), shmctl(), shmdt(), mmap()).
>
> And: This should be documented somewhere.
>
>
> > --- a/ipc/shm.c
> > +++ b/ipc/shm.c
> > @@ -65,6 +65,7 @@ struct shmid_kernel /* private to the kernel */
> >       /* The task created the shm object.  NULL if the task is dead. */
> >       struct task_struct      *shm_creator;
> >       struct list_head        shm_clist;      /* list by creator */
>
> I think the comments are wrong/outdated.
>
> Some parts of the new code checks with list_empty(shm_clist), not by
> looking at shm_creator.
>
> > +     struct ipc_namespace    *ns;
> >   } __randomize_layout;
> >
> >   /* shm_mode upper byte flags */
> > @@ -115,6 +116,7 @@ static void do_shm_rmid(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp)
> >       struct shmid_kernel *shp;
> >
> >       shp = container_of(ipcp, struct shmid_kernel, shm_perm);
> > +     BUG_ON(shp->ns && ns != shp->ns);
>
> Is shp->ns == NULL allowed/possible? From what I see, it is impossible.

Yep, it's leftover from debugging.

>
> I think we should not have  NULL check in a few codepaths, but not in
> other codepaths. Either everywhere, or nowhere.
>
>
> >
> >       if (shp->shm_nattch) {
> >               shp->shm_perm.mode |= SHM_DEST;
> > @@ -225,9 +227,32 @@ static void shm_rcu_free(struct rcu_head *head)
> >       kfree(shp);
> >   }
> >
> > +static inline void task_shm_clist_lock(struct task_struct *task)
> > +{
> > +     spin_lock(&task->sysvshm.shm_clist_lock);
> > +}
> > +
> > +static inline void task_shm_clist_unlock(struct task_struct *task)
> > +{
> > +     spin_unlock(&task->sysvshm.shm_clist_lock);
> > +}
> > +
> > +void shm_clist_rm(struct shmid_kernel *shp)
> > +{
> > +     if (!shp->shm_creator)
> > +             return;
> > +
> > +     task_shm_clist_lock(shp->shm_creator);
> > +     list_del_init(&shp->shm_clist);
> > +     task_shm_clist_unlock(shp->shm_creator);
> > +     shp->shm_creator = NULL;
> > +}
> > +
> >   static inline void shm_rmid(struct ipc_namespace *ns, struct shmid_kernel *s)
> >   {
> > -     list_del(&s->shm_clist);
> > +     WARN_ON(s->ns && ns != s->ns);
> > +     //list_del_init(&s->shm_clist);
> > +     shm_clist_rm(s);
> >       ipc_rmid(&shm_ids(ns), &s->shm_perm);
> >   }
> >
> > @@ -306,10 +331,10 @@ static void shm_destroy(struct ipc_namespace *ns, struct shmid_kernel *shp)
> >    *
> >    * 2) sysctl kernel.shm_rmid_forced is set to 1.
> >    */
> > -static bool shm_may_destroy(struct ipc_namespace *ns, struct shmid_kernel *shp)
> > +static bool shm_may_destroy(struct shmid_kernel *shp)
> >   {
> >       return (shp->shm_nattch == 0) &&
> > -            (ns->shm_rmid_forced ||
> > +            (shp->ns->shm_rmid_forced ||
> >               (shp->shm_perm.mode & SHM_DEST));
> >   }
> >
> As written before: what ensures that shp->ns->shm_rmid_forced was not
> released already?

As far as I understand, if we have locked struct shmid_kernel it means
that someone (task)
holds IPC namespace. But I will check and describe this.

> > @@ -340,7 +365,7 @@ static void shm_close(struct vm_area_struct *vma)
> >       ipc_update_pid(&shp->shm_lprid, task_tgid(current));
> >       shp->shm_dtim = ktime_get_real_seconds();
> >       shp->shm_nattch--;
> > -     if (shm_may_destroy(ns, shp))
> > +     if (shm_may_destroy(shp))
> >               shm_destroy(ns, shp);
> >       else
> >               shm_unlock(shp);
> > @@ -361,10 +386,10 @@ static int shm_try_destroy_orphaned(int id, void *p, void *data)
> >        *
> >        * As shp->* are changed under rwsem, it's safe to skip shp locking.
> >        */
> > -     if (shp->shm_creator != NULL)
> > +     if (!list_empty(&shp->shm_clist))
> >               return 0;
> >
> This collides with the comment above: here, list_empty() is used.
> > -     if (shm_may_destroy(ns, shp)) {
> > +     if (shm_may_destroy(shp)) {
> >               shm_lock_by_ptr(shp);
> >               shm_destroy(ns, shp);
> >       }
> > @@ -379,51 +404,77 @@ void shm_destroy_orphaned(struct ipc_namespace *ns)
> >       up_write(&shm_ids(ns).rwsem);
> >   }
> >
> > +void shm_init_task(struct task_struct *task)
> > +{
> > +     INIT_LIST_HEAD(&(task)->sysvshm.shm_clist);
> > +     spin_lock_init(&task->sysvshm.shm_clist_lock);
> > +}
> > +
> >   /* Locking assumes this will only be called with task == current */
> >   void exit_shm(struct task_struct *task)
> >   {
> > -     struct ipc_namespace *ns = task->nsproxy->ipc_ns;
> > +     LIST_HEAD(tmp);
> >       struct shmid_kernel *shp, *n;
> >
> >       if (list_empty(&task->sysvshm.shm_clist))
> >               return;
> >
> > -     /*
> > -      * If kernel.shm_rmid_forced is not set then only keep track of
> > -      * which shmids are orphaned, so that a later set of the sysctl
> > -      * can clean them up.
> > -      */
> > -     if (!ns->shm_rmid_forced) {
> > -             down_read(&shm_ids(ns).rwsem);
> > -             list_for_each_entry(shp, &task->sysvshm.shm_clist, shm_clist)
> > -                     shp->shm_creator = NULL;
> > -             /*
> > -              * Only under read lock but we are only called on current
> > -              * so no entry on the list will be shared.
> > -              */
> > -             list_del(&task->sysvshm.shm_clist);
> > -             up_read(&shm_ids(ns).rwsem);
> > -             return;
> > -     }
> > +     rcu_read_lock(); /* for refcount_inc_not_zero */
> > +     task_shm_clist_lock(task);
> >
> > -     /*
> > -      * Destroy all already created segments, that were not yet mapped,
> > -      * and mark any mapped as orphan to cover the sysctl toggling.
> > -      * Destroy is skipped if shm_may_destroy() returns false.
> > -      */
> > -     down_write(&shm_ids(ns).rwsem);
> >       list_for_each_entry_safe(shp, n, &task->sysvshm.shm_clist, shm_clist) {
> > +             struct ipc_namespace *ns = shp->ns;
> > +
> > +             /*
> > +              * Remove shm from task list and nullify shm_creator which
> > +              * marks object as orphaned.
> > +              *
> > +              * If kernel.shm_rmid_forced is not set then only keep track of
> > +              * which shmids are orphaned, so that a later set of the sysctl
> > +              * can clean them up.
> > +              */
> > +             list_del_init(&shp->shm_clist);
> >               shp->shm_creator = NULL;
> >
> > -             if (shm_may_destroy(ns, shp)) {
> > -                     shm_lock_by_ptr(shp);
> > -                     shm_destroy(ns, shp);
> > +             printk("exit_shm() %px refcnt=%u, id=%d,key=%x\n", shp,
> > +                     refcount_read(&shp->shm_perm.refcount),
> > +                     shp->shm_perm.id, shp->shm_perm.key
> > +             );
> > +
> > +             /*
> > +              * Will destroy all already created segments, that were not yet mapped,
> > +              * and mark any mapped as orphan to cover the sysctl toggling.
> > +              * Destroy is skipped if shm_may_destroy() returns false.
> > +              */
> > +             if (shp->ns->shm_rmid_forced && shm_may_destroy(shp)) {
> > +                     /*
> > +                      * We may race with shm_exit_ns() if refcounter
> > +                      * already zero. Let's skip shm_destroy() of such
> > +                      * shm object as it will be destroyed during shm_exit_ns()
> > +                      */
> > +                     if (!refcount_inc_not_zero(&ns->ns.count)) /* get_ipc_ns */
> > +                             continue;
> > +
> > +                     list_add(&shp->shm_clist, &tmp);
> >               }
> >       }
> >
> > -     /* Remove the list head from any segments still attached. */
> >       list_del(&task->sysvshm.shm_clist);
> > -     up_write(&shm_ids(ns).rwsem);
> > +     task_shm_clist_unlock(task);
> > +     rcu_read_unlock();
> > +
> > +     list_for_each_entry_safe(shp, n, &tmp, shm_clist) {
> > +             struct ipc_namespace *ns = shp->ns;
> > +
> > +             list_del_init(&shp->shm_clist);
> > +
> > +             down_write(&shm_ids(ns).rwsem);
> > +             shm_lock_by_ptr(shp);
> > +             /* will do put_ipc_ns(shp->ns) */
> > +             shm_destroy(ns, shp);
> > +             up_write(&shm_ids(ns).rwsem);
> > +             put_ipc_ns(ns); /* see refcount_inc_not_zero */
> > +     }
> >   }
> >
>
> I do not see the advantage of first collecting everything in a local
> list, and then destroying the elements.

Ah, I've got your idea. You lock the list inside a loop over the list
and ensure that it's not empty
and it allows you to split spin_lock and rwsem taking. I've tried to
do the same (split locks)
but using a temporary list head. :) Thanks!

>
> Attached is my current test case. Feel free to merge whatever you
> consider as useful into your change.
>
>
> --
>
>      Manfred
>

Regards,
Alex
