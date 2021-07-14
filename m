Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624333C89F5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbhGNRpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhGNRpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:45:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5E9C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 10:42:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id v20so4615659eji.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 10:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8W9wNCZ5eBVxpIY3o1tdz22v0K2eck/Y97I36pZwNc=;
        b=dyyJAnIFlOGXJoHBm3JnefCj0bf9BTHEDTP/DgJRLqyrdY+UU9jOiWUmZJRbde8WMm
         AngaX5tfGcR4i0b4cVAv1WttioqrVpPytSkmg9HEgEPlO6lgikvlEkMUGw+EEQvilneA
         IjnLXk1kZA5HIOAKTrS21/G8D1nkaqGlUjPzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8W9wNCZ5eBVxpIY3o1tdz22v0K2eck/Y97I36pZwNc=;
        b=g65Fko3sPQe4wVaP7YPtK7ZOOei8XgL+SkSJTIL2i0CNlCXOOaM3FXNwsdagiDCNhQ
         m6HDT8mP6x510UF+Fza8uudwEVxbxalucOJIhichyuqnUA0xNgM+TXj8LqRokIph4iMP
         CBvNcpxM+yRM8OM6vtzkQ8khmwL7eRcdxIbaLfxtnTudkm5eQsQxT/YVqc9tm5IHDe4V
         8RebGpDnlpGO5gKzoSt/TXJ3+uXUc3zVgCebbrJaJTTXryEig9HPmZ7uRUh0MN+I+K22
         rO4hOiLNwit4d5CBcu868cRiaZy/15vake+Pd7sJ9nzoL0DHP/bY8OBe0UTiU141lorm
         Z0AA==
X-Gm-Message-State: AOAM530HXGvV4JKIL+xDoOuh+XsF5Dj5V7NB5A2Ki2CL8N88UJSDR2Gn
        3cK0okcqAF5hmb3Fp1iVEuiFLgm62QfGJOLJKNd89w==
X-Google-Smtp-Source: ABdhPJzVwDON3BkPT9xaQ2dLRY0U5GHlF7yeotFc9tZEdh3f58Vd0U/S8n6CDJuDI4T6IoUs7MqndDrZ4pzfcCjjKvk=
X-Received: by 2002:a17:907:990f:: with SMTP id ka15mr13596086ejc.132.1626284570889;
 Wed, 14 Jul 2021 10:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210706132259.71740-1-alexander.mikhalitsyn@virtuozzo.com>
 <20210709181241.cca57cf83c52964b2cd0dcf0@linux-foundation.org>
 <CAJqdLrpx+xEMGQLZo7jS5BTAw-k2sWPrv9fCt0x8t=6Nbn7u+w@mail.gmail.com>
 <CALgW_8VUk0us_umLncUv2DUMkOi3qixmT+YkHV4Dhpt_nNMZHw@mail.gmail.com>
 <CAJqdLrofd76x_hziq7F3wY3jqZfE1LNZbQ8sD6MUFXbPHVcdVw@mail.gmail.com>
 <CALgW_8WHq051ifcYPta5reoVZ10=fA5Rb1EZuyaievK+OUw99Q@mail.gmail.com>
 <CAJqdLrpxnMThqersqiVsTNr1Y25V8jmDcW_sKWi0ziJXCsi2gw@mail.gmail.com>
 <87y2ab9w8u.fsf@disp2133> <CAJqdLrov0VBzHamSvMRKBHSJX+NROUx0TUsRD9U0zEWUn5XxDA@mail.gmail.com>
In-Reply-To: <CAJqdLrov0VBzHamSvMRKBHSJX+NROUx0TUsRD9U0zEWUn5XxDA@mail.gmail.com>
From:   Alexander Mihalicyn <alexander@mihalicyn.com>
Date:   Wed, 14 Jul 2021 20:42:39 +0300
Message-ID: <CAJqdLrqUmY02fPPFzdq_cUM-U4vDHneQ-RDQbCpDErdsLcNNfQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] shm: omit forced shm destroy if task IPC namespace
 was changed
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Manfred Spraul <manfred@colorfullife.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        alexander.mikhalitsyn@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

I've sent the RFC patch "shm: extend forced shm destroy to support
objects from", please take a look once time permits.

A few words about design:
1. In the exit_shm() function I'm using a temporary list to collect
shm's before destroying because I can't take semaphore (which protects
ns idr structure) under spinlock (which protects list on task)
2. I've to take IPC ns refcounter in exit_shm() to prevent possible
race with shm_exit_ns().
3. I haven't added list_del_init(&shp->shm_clist) into shmat() syscall
because I can't understand why this is safe. But maybe I've to think
more about that.
4. I need to remove the extra "ns" argument (todo).

Thanks,
Alex

On Mon, Jul 12, 2021 at 10:27 PM Alexander Mihalicyn
<alexander@mihalicyn.com> wrote:
>
> Hi Eric,
>
> On Mon, Jul 12, 2021 at 10:18 PM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
> >
> > Alexander Mihalicyn <alexander@mihalicyn.com> writes:
> >
> > > Hello Manfred,
> > >
> > > On Sun, Jul 11, 2021 at 2:47 PM Manfred Spraul <manfred@colorfullife.com> wrote:
> > >>
> > >> Hi Alex,
> > >>
> > >>
> > >> Am Sonntag, 11. Juli 2021 schrieb Alexander Mihalicyn <alexander@mihalicyn.com>:
> > >> >
> > >> > Hi, Manfred,
> > >> >
> > >> > On Sun, Jul 11, 2021 at 12:13 PM Manfred Spraul
> > >> > <manfred@colorfullife.com> wrote:
> > >> > >
> > >> > > Hi,
> > >> > >
> > >> > >
> > >> > > Am Samstag, 10. Juli 2021 schrieb Alexander Mihalicyn <alexander@mihalicyn.com>:
> > >> > >>
> > >> > >>
> > >> > >> Now, using setns() syscall, we can construct situation when on
> > >> > >> task->sysvshm.shm_clist list
> > >> > >> we have shm items from several (!) IPC namespaces.
> > >> > >>
> > >> > >>
> > >> > > Does this imply that locking ist affected as well? According to the initial patch, accesses to shm_clist are protected by "the" IPC shm namespace rwsem. This can't work if the list contains objects from several namespaces.
> > >> >
> > >> > Of course, you are right. I've to rework this part -> I can add check into
> > >> > static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
> > >> > function and before adding new shm into task list check that list is empty OR
> > >> > an item which is present on the list from the same namespace as
> > >> > current->nsproxy->ipc_ns.
> > >> >
> > >> Ok. (Sorry, I have only smartphone internet, thus I could not check
> > >> the patch fully)
> > >>
> > >> > >> I've proposed a change which keeps the old behaviour of setns() but
> > >> > >> fixes double free.
> > >> > >>
> > >> > > Assuming that locking works, I would consider this as a namespace design question: Do we want to support that a task contains shm objects from several ipc namespaces?
> > >> >
> > >> > This depends on what we mean by "task contains shm objects from
> > >> > several ipc namespaces". There are two meanings:
> > >> >
> > >> > 1. Task has attached shm object from different ipc namespaces
> > >> >
> > >> > We already support that by design. When we doing a change of namespace
> > >> > using unshare(CLONE_NEWIPC) even with
> > >> > sysctl shm_rmid_forced=1 we not detach all ipc's from task!
> > >>
> > >> OK. Thus shm and sem have different behavior anyways.
> > >>
> > >> >
> > >> > 2. Task task->sysvshm.shm_clist list has items from different IPC namespaces.
> > >> >
> > >> > I'm not sure, do we need that or not. But I'm ready to prepare a patch
> > >> > for any of the options which we choose:
> > >> > a) just add exit_shm(current)+shm_init_task(current);
> > >> > b) prepare PATCHv2 with appropriate check in the newseg() to prevent
> > >> > adding new items from different namespace to the list
> > >> > c) rework algorithm so we can safely have items from different
> > >> > namespaces in task->sysvshm.shm_clist
> > >> >
> > >> Before you write something, let's wait what the others say. I don't
> > >> qualify AS shm expert
> > >>
> > >> a) is user space visible, without any good excuse
> > >
> > > yes, but maybe we decide that this is not so critical?
> > > We need more people here :)
> >
> > It is barely visible.  You have to do something very silly
> > to see this happening.  It is probably ok, but the work to
> > verify that nothing cares so that we can safely backport
> > the change is probably much more work than just updating
> > the list to handle shmid's for multiple namespaces.
> >
> >
> > >> c) is probably highest amount of Changes
> > >
> > > yep. but ok, I will prepare patches fast.
> >
> > Given that this is a bug I think c) is the safest option.
> >
> > A couple of suggestions.
> > 1) We can replace the test "shm_creator != NULL" with
> >    "list_empty(&shp->shm_clist)" and remove shm_creator.
> >
> >    Along with replacing "shm_creator = NULL" with
> >    "list_del_init(&shp->shm_clist)".
> >
> > 2) We can update shmat to do "list_del_init(&shp->shm_clist)"
> >    upon shmat.  The last unmap will still shm_destroy the
> >    shm segment as ns->shm_rmid_forced is set.
> >
> >    For a multi-threaded process I think this will nicely clean up
> >    the clist, and make it clear that the clist only cares about
> >    those segments that have been created but never attached.
> >
> > 3) Put a non-reference counted struct ipc_namespace in struct
> >    shmid_kernel, and use it to remove the namespace parameter
> >    from shm_destroy.
>
> Thanks for your detailed suggestions! ;)
> I will prepare a patch tomorrow for kernel + test what's happening with
> CRIU and will prepare a fix for it.
>
> >
> > I think that is enough to fix this bug with no changes in semantics,
> > no additional memory consumed, and an implementation that is easier
> > to read and perhaps a little faster.
> >
> > Eric
>
> Regards,
> Alex
