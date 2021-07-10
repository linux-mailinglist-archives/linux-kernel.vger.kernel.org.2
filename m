Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436B33C343F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 13:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhGJK6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 06:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhGJK6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 06:58:32 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30731C0613DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 03:55:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h8so4792886eds.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 03:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ByFVcUaAGe1Rb6HqOSzOj9JWWPxEVOQXRYO3t6bXJI=;
        b=iAkiJ4jWknbMvuqKzCFBi8C2Q/On7oSVj2FXIzUGlr99wKImh1JlJhxgtGM2wt6tyJ
         FqDrQXmcdy3w7GpPGWFtk0jc1GqWBGMzxyj0TfWCTSZDgoqGQuh7Btn5CTAx6/wzzfEe
         mxN4YFBpbQwnZqVpeGmJyyCIA8/85OhrP5t/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ByFVcUaAGe1Rb6HqOSzOj9JWWPxEVOQXRYO3t6bXJI=;
        b=aXTa4Q+f81KSOf+v+bJdAiv+fmLwMKf5UWOSV186T9/BRNttu8IAZ1PVR/2gwUqVnN
         FqOEb9tg808p8c5hcGLinhv2Kg8C7Y1oNAyQMs01vT+NBzU6+4gI1bGNl/2JcAKK4L/I
         0zfu1YBqXF/wSBwdBl2ZlSTmzuqe+ymDRlB27KtpoD8mhDX/6cdjaCfuPoFtp9Fzk6bX
         EjR6n66LG+Xd7hBKi4qCeWlLVwLo8FvRrgUfcIlVLOjnnDdav3QzKhXGK4TRAbTKaDTQ
         ZGb4TYkj77zicz5lvm6v6Bbp8LeVmslibPAHcfN0a8QLeJf5gIppITP/VhwqnE43k3IM
         67Tw==
X-Gm-Message-State: AOAM533zgGXyEgRQA3MfsjyLRtdmpw5KCLPCOnVOPCoohCUHSocK3Q53
        xR2wZaJid7RUWtJ2/hWlxH3kyhVh1UhV6dI6SlnI/w==
X-Google-Smtp-Source: ABdhPJzFd87Wruz8+MnTciPkGuNRiOmuzMEqglt/Jlv7WEo/NPHl66gIBdQYSU0toGkMKYHDr4ljvC7Laf8SDiySl8I=
X-Received: by 2002:a05:6402:2044:: with SMTP id bc4mr25069679edb.307.1625914544719;
 Sat, 10 Jul 2021 03:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210706132259.71740-1-alexander.mikhalitsyn@virtuozzo.com> <20210709181241.cca57cf83c52964b2cd0dcf0@linux-foundation.org>
In-Reply-To: <20210709181241.cca57cf83c52964b2cd0dcf0@linux-foundation.org>
From:   Alexander Mihalicyn <alexander@mihalicyn.com>
Date:   Sat, 10 Jul 2021 13:55:33 +0300
Message-ID: <CAJqdLrpx+xEMGQLZo7jS5BTAw-k2sWPrv9fCt0x8t=6Nbn7u+w@mail.gmail.com>
Subject: Re: [PATCH 0/2] shm: omit forced shm destroy if task IPC namespace
 was changed
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
        Jack Miller <millerjo@us.ibm.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2021 at 4:12 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue,  6 Jul 2021 16:22:57 +0300 Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com> wrote:
>
> > Hello,
> >
> > Task IPC namespace shm's has shm_rmid_forced feature which is per IPC namespace
> > and controlled by kernel.shm_rmid_forced sysctl. When feature is turned on,
> > then during task exit (and unshare(CLONE_NEWIPC)) all sysvshm's will be destroyed
> > by exit_shm(struct task_struct *task) function. But there is a problem if task
> > was changed IPC namespace since shmget() call. In such situation exit_shm() function
> > will try to call
> > shm_destroy(<new_ipc_namespace_ptr>, <sysvshmem_from_old_ipc_namespace>)
> > which leads to the situation when sysvshm object still attached to old
> > IPC namespace but freed; later during old IPC namespace cleanup we will try to
> > free such sysvshm object for the second time and will get the problem :)
> >
> > First patch solves this problem by postponing shm_destroy to the moment when
> > IPC namespace cleanup will be called.
> > Second patch is useful to prevent (or easy catch) such bugs in the future by
> > adding corresponding WARNings.
> >

Andrew,

thanks for your attention to the patches!

>
> (cc's added)
>
> I assume that a
>
> Fixes: b34a6b1da371ed8af ("ipc: introduce shm_rmid_forced sysctl") is
> appropriate here?

Really not, this patch looks fully safe because it always takes
objects to free from
concrete IPC namespace idr with appropriate locking. For example
/* Destroy all already created segments, but not mapped yet */
down_write(&shm_ids(ns).rw_mutex);
idr_for_each(&shm_ids(ns).ipcs_idr, &shm_try_destroy_current, ns);
up_write(&shm_ids(ns).rw_mutex);
here we take ns from current->nsproxy, lock idr, and destroy only shms
from this particular IPC ns.

But after b34a6b1da ("shm: make exit_shm work proportional to task
activity") we introduced
new field (struct sysv_shm sysvshm) on task_struct. exit_shm()
function was changed so:

list_for_each_entry_safe(shp, n, &task->sysvshm.shm_clist, shm_clist)
    shm_mark_orphan(shp, ns);

instead of previous idr_for_each(&shm_ids(ns).ipcs_idr,
&shm_try_destroy_current, ns);

Now, using setns() syscall, we can construct situation when on
task->sysvshm.shm_clist list
we have shm items from several (!) IPC namespaces. Before this patch
we always destroying
shmems only from current->nsproxy->ipc_ns, but now we can do something
like this:

shmget(0xAAAA, 4096, IPC_CREAT|0700); <-- add item to task->sysvshm.shm_clist
setns(fd, CLONE_NEWIPC);
shmget(0xAAAA, 4096, IPC_CREAT|0700); <-- add item to task->sysvshm.shm_clist
*now we have two items in task->sysvshm.shm_clist but from different
IPC namespaces*

(I've reproducer program and can send it privately)

That's a problem. If we take a look on
int ksys_unshare(unsigned long unshare_flags)

we can see following part:

if (unshare_flags & CLONE_NEWIPC) {
   /* Orphan segments in old ns (see sem above). */
   exit_shm(current);
   shm_init_task(current);
}

here we cleaning up this list BEFORE changing IPC namespace. So, if we
do something like:
shmget(0xAAAA, 4096, IPC_CREAT|0700); <-- add item to task->sysvshm.shm_clist
unshare(CLONE_NEWIPC); <-- task->sysvshm.shm_clist is cleaned and
reinitialized here
shmget(0xAAAA, 4096, IPC_CREAT|0700); <-- add item to task->sysvshm.shm_clist

and all fine!

So, semantics of setns() and unshare() is different here. We can fix
this problem by adding
analogical calls to exit_shm(), shm_init_task() into

static void commit_nsset(struct nsset *nsset)
...
#ifdef CONFIG_IPC_NS
if (flags & CLONE_NEWIPC) {
     exit_sem(me);
+   shm_init_task(current);
+  exit_shm(current);
}
#endif

with this change semantics of unshare() and setns() will be equal in
terms of the shm_rmid_forced
feature. But this may break some applications which using setns() and
IPC resources not destroying
after that syscall. (CRIU using setns() extensively and we have to
change our IPC ns C/R implementation
a little bit if we take this way of fixing the problem).

I've proposed a change which keeps the old behaviour of setns() but
fixes double free.

>
> A double-free is serious.  Should this fix be backported into earlier
> kernels?

Yes, the IPC namespace code was not changed seriously, so it means
that we can easily apply this patch to older kernels.
(I've CCed stable lists in the patch where the fix was)

CCed: Andrei Vagin and Christian Brauner

Regards,
Alex
