Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691173C3B85
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 12:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhGKKgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 06:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhGKKgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 06:36:22 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F86C0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 03:33:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id c17so27025396ejk.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 03:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=66BLxugFoZqs32+cjec7ut7cucLB/jHItPYdDOsXDYk=;
        b=G90e1S3cXf1kWiZ74XhXxxfdOKsUS1sZGM7hQXBshakpmGjtWy7Ena4gleugHqAMec
         UbrqQREdu2RGoyt0VfSOPyqdONJJo0e3rDWobPecP8FsR5E2G1pkyX9YdSvE4DFT+JEq
         RXwnMly25gzHoSgwcCoBrNtHT9CXiQAqDkVmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66BLxugFoZqs32+cjec7ut7cucLB/jHItPYdDOsXDYk=;
        b=sfAKSLqGv0zfzeepTJsUPExAvyVQ8ofME48kJi9CDx/siqlGDT4PxIzoDT85B2oFeR
         b+g/tTcnfYjUH2Xywq6TQGOfqckzZJEdSeeol10WW+sYnsjn6mGdrU2+htB3rMGnJ+k+
         E8ogOz+RFweH6MRyHLLLOxguxzL8s8P4PkUIKpHci/CwwVSJ+9V78L+sbNDDPv5YDjGA
         0ygX2X+NIvSfg4xoojjKWb63Gre/wEEMQWmGpZQ9pvNDZPdzqeIyQ2jANyXwXLu81aEe
         JaiPucT+FKgkD1c7TZtmB8xfJ84FNmxeffKXuyZnZGLOepsujv4pBMFUXgCHGuHIaaLv
         V+xw==
X-Gm-Message-State: AOAM533uZYYF1i9FSv3MSZ39Z7jICc3bJ9bsCVz2dxC9xY+CeGBhibav
        FZEJIjd9gOhmKNDudAtB2fhOThjQnCZOMXT1N2itbg==
X-Google-Smtp-Source: ABdhPJw/ZsbxummGzr+kGJtqaXkucIHRZmN2OIKAHz89fU7twn4G0NIkjQLhhhGb15LiV7Avec5HJpYAvN0G4+mpTjI=
X-Received: by 2002:a17:907:990f:: with SMTP id ka15mr47949357ejc.132.1625999613868;
 Sun, 11 Jul 2021 03:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210706132259.71740-1-alexander.mikhalitsyn@virtuozzo.com>
 <20210709181241.cca57cf83c52964b2cd0dcf0@linux-foundation.org>
 <CAJqdLrpx+xEMGQLZo7jS5BTAw-k2sWPrv9fCt0x8t=6Nbn7u+w@mail.gmail.com> <CALgW_8VUk0us_umLncUv2DUMkOi3qixmT+YkHV4Dhpt_nNMZHw@mail.gmail.com>
In-Reply-To: <CALgW_8VUk0us_umLncUv2DUMkOi3qixmT+YkHV4Dhpt_nNMZHw@mail.gmail.com>
From:   Alexander Mihalicyn <alexander@mihalicyn.com>
Date:   Sun, 11 Jul 2021 13:33:22 +0300
Message-ID: <CAJqdLrofd76x_hziq7F3wY3jqZfE1LNZbQ8sD6MUFXbPHVcdVw@mail.gmail.com>
Subject: Re: [PATCH 0/2] shm: omit forced shm destroy if task IPC namespace
 was changed
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milton Miller <miltonm@bga.com>,
        Jack Miller <millerjo@us.ibm.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
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

Hi, Manfred,

On Sun, Jul 11, 2021 at 12:13 PM Manfred Spraul
<manfred@colorfullife.com> wrote:
>
> Hi,
>
>
> Am Samstag, 10. Juli 2021 schrieb Alexander Mihalicyn <alexander@mihalicyn.com>:
>>
>>
>> Now, using setns() syscall, we can construct situation when on
>> task->sysvshm.shm_clist list
>> we have shm items from several (!) IPC namespaces.
>>
>>
> Does this imply that locking ist affected as well? According to the initial patch, accesses to shm_clist are protected by "the" IPC shm namespace rwsem. This can't work if the list contains objects from several namespaces.

Of course, you are right. I've to rework this part -> I can add check into
static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
function and before adding new shm into task list check that list is empty OR
an item which is present on the list from the same namespace as
current->nsproxy->ipc_ns.

>
> From ipc/shm.c:
>
>  397                down_read(&shm_ids(ns).rwsem);
>  398                list_for_each_entry(shp, &task->sysvshm.shm_clist, shm_clist)
>  399                        shp->shm_creator = NULL;
>  400                /*
>  401                 * Only under read lock but we are only called on current
>  402                 * so no entry on the list will be shared.
>  403                 */
>  404                list_del(&task->sysvshm.shm_clist);
>  405                up_read(&shm_ids(ns).rwsem);
>
>
> Task A and B in same namespace
>
> - A: create shm object
>
> - A: setns()
>
> - in parallel B) does shmctl(IPC_RMID), A) does exit()

Yep.

>
>
>>
>>
>> So, semantics of setns() and unshare() is different here. We can fix
>> this problem by adding
>> analogical calls to exit_shm(), shm_init_task() into
>>
>> static void commit_nsset(struct nsset *nsset)
>> ...
>> #ifdef CONFIG_IPC_NS
>> if (flags & CLONE_NEWIPC) {
>>      exit_sem(me);
>> +   shm_init_task(current);
>> +  exit_shm(current);
>> }
>> #endif
>>
>> with this change semantics of unshare() and setns() will be equal in
>> terms of the shm_rmid_forced
>> feature.
>
> Additional advantage: exit_sem() and exit_shm() would appear as pairs, both in unshare () and setns().
>
>> But this may break some applications which using setns() and
>> IPC resources not destroying
>> after that syscall. (CRIU using setns() extensively and we have to
>> change our IPC ns C/R implementation
>> a little bit if we take this way of fixing the problem).
>>
>> I've proposed a change which keeps the old behaviour of setns() but
>> fixes double free.
>>
> Assuming that locking works, I would consider this as a namespace design question: Do we want to support that a task contains shm objects from several ipc namespaces?

This depends on what we mean by "task contains shm objects from
several ipc namespaces". There are two meanings:

1. Task has attached shm object from different ipc namespaces

We already support that by design. When we doing a change of namespace
using unshare(CLONE_NEWIPC) even with
sysctl shm_rmid_forced=1 we not detach all ipc's from task! Let see on
shm_exit() functio which is validly called
when we doing unshare():

if (shm_may_destroy(ns, shp)) { <--- (shp->shm_nattch == 0) &&
(ns->shm_rmid_forced || (shp->shm_perm.mode & SHM_DEST))
    shm_lock_by_ptr(shp);
    shm_destroy(ns, shp);
}

here all depends on shp->shm_nattch which will be non-zero if used
doing something like this:

int id = shmget(0xAAAA, 4096, IPC_CREAT|0700);
void *addr = shmat(id, NULL, 0); // <-- map shm to the task address space
unshare(CLONE_NEWIPC); // <--- task->sysvshm.shm_clist is cleared! But
shm 0xAAAA remains attached
id = shmget(0xBBBB, 4096, IPC_CREAT|0700); // <-- add item to the
task->sysvshm.shm_clist now it contains object only from new IPC
namespace
addr = shmat(id, NULL, 0);

So, this task->sysvshm.shm_clist list used only for shm_rmid_forced
feature. It doesn't affect any mm-related things like /proc/<pid>/maps
or something similar.

2. Task task->sysvshm.shm_clist list has items from different IPC namespaces.

I'm not sure, do we need that or not. But I'm ready to prepare a patch
for any of the options which we choose:
a) just add exit_shm(current)+shm_init_task(current);
b) prepare PATCHv2 with appropriate check in the newseg() to prevent
adding new items from different namespace to the list
c) rework algorithm so we can safely have items from different
namespaces in task->sysvshm.shm_clist

and, of course, prepare a test case with this particular bug
reproducer to prevent future degradations and increase coverage.
(I'm not publishing the reproducer program directly on the list at the
moment because it may be not fully safe.
But I think any of us already knows how to trigger the problem.)

>
> Does it work everywhere (/proc/{pid}, ...)?
> --
>    Manfred

Thanks,
Alex
