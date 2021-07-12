Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41ACE3C63B5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 21:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbhGLTaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 15:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbhGLTaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:30:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59401C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 12:27:12 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t3so29643835edc.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 12:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H0SY2i5T1uLLAwEBIZLwQwYm4iQHs9xRAcgGeCt9wm0=;
        b=d2i8zhWU+ABwbaJYLb0m14Y/YxocoioWmFCc0dl/kvA4WR1l/q13Xy7Uuh/UJ4zwBL
         p9ToZOjUSLeJq7ZfmTikTPUfuLrmyIRtXiaPVqHZ6/BLdI1bCR0iQ+NcvMjZNmireEpd
         CqJmkqaR248eK3RPTCMfUTCTlE0NK83DrGBmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H0SY2i5T1uLLAwEBIZLwQwYm4iQHs9xRAcgGeCt9wm0=;
        b=h94sPHw9QG/QhIAvPuttjJbNsY/ya/l/fFkzB1djXYP2+H6+MkryK4j6Rpp3jIEFtu
         V58hkW7D/DYorYeSs9gp46hFa03hiJ8y42f9qYVkKqLLbXWRMteQTNN1nVoEHb/BB/D4
         2DrH6DbWPO2xkZANFl4c4P8DhttER2zf50ESdXrjhKGJJk+GhsiIZR106fK3zaQK/l0o
         kBAG9KNhLno2L5VS/Sx+SA7Q9DeTLBNfDSMf4SCzwpX+wHZSyBFmGFSyfa4Mdy94tWps
         k3z4RQckwlqklHul7bOn1tQ9NBstwwht5yq6Eh0bcathfWxQbi7SugM1MAETzoiaGAx8
         2Aiw==
X-Gm-Message-State: AOAM530bKnTIO5c2pZnsoB6jj1LoPepZWw0LYs/Kujdx+CYSVRofn2YT
        HEJS/ZGRyZx7xM5M+mr66u6M9uO9NFTcGlDbl2jCoA==
X-Google-Smtp-Source: ABdhPJzBTlCjnE0Boj137sr2XNOzYq7UmZhmd29OYyEVxs/Rvi+S37nfo42yC3p503T4yhsk9aeQPKknMWMv6HNiWKw=
X-Received: by 2002:a05:6402:498:: with SMTP id k24mr536302edv.25.1626118030895;
 Mon, 12 Jul 2021 12:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210706132259.71740-1-alexander.mikhalitsyn@virtuozzo.com>
 <20210709181241.cca57cf83c52964b2cd0dcf0@linux-foundation.org>
 <CAJqdLrpx+xEMGQLZo7jS5BTAw-k2sWPrv9fCt0x8t=6Nbn7u+w@mail.gmail.com>
 <CALgW_8VUk0us_umLncUv2DUMkOi3qixmT+YkHV4Dhpt_nNMZHw@mail.gmail.com>
 <CAJqdLrofd76x_hziq7F3wY3jqZfE1LNZbQ8sD6MUFXbPHVcdVw@mail.gmail.com>
 <CALgW_8WHq051ifcYPta5reoVZ10=fA5Rb1EZuyaievK+OUw99Q@mail.gmail.com>
 <CAJqdLrpxnMThqersqiVsTNr1Y25V8jmDcW_sKWi0ziJXCsi2gw@mail.gmail.com> <87y2ab9w8u.fsf@disp2133>
In-Reply-To: <87y2ab9w8u.fsf@disp2133>
From:   Alexander Mihalicyn <alexander@mihalicyn.com>
Date:   Mon, 12 Jul 2021 22:27:00 +0300
Message-ID: <CAJqdLrov0VBzHamSvMRKBHSJX+NROUx0TUsRD9U0zEWUn5XxDA@mail.gmail.com>
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
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Mon, Jul 12, 2021 at 10:18 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Alexander Mihalicyn <alexander@mihalicyn.com> writes:
>
> > Hello Manfred,
> >
> > On Sun, Jul 11, 2021 at 2:47 PM Manfred Spraul <manfred@colorfullife.com> wrote:
> >>
> >> Hi Alex,
> >>
> >>
> >> Am Sonntag, 11. Juli 2021 schrieb Alexander Mihalicyn <alexander@mihalicyn.com>:
> >> >
> >> > Hi, Manfred,
> >> >
> >> > On Sun, Jul 11, 2021 at 12:13 PM Manfred Spraul
> >> > <manfred@colorfullife.com> wrote:
> >> > >
> >> > > Hi,
> >> > >
> >> > >
> >> > > Am Samstag, 10. Juli 2021 schrieb Alexander Mihalicyn <alexander@mihalicyn.com>:
> >> > >>
> >> > >>
> >> > >> Now, using setns() syscall, we can construct situation when on
> >> > >> task->sysvshm.shm_clist list
> >> > >> we have shm items from several (!) IPC namespaces.
> >> > >>
> >> > >>
> >> > > Does this imply that locking ist affected as well? According to the initial patch, accesses to shm_clist are protected by "the" IPC shm namespace rwsem. This can't work if the list contains objects from several namespaces.
> >> >
> >> > Of course, you are right. I've to rework this part -> I can add check into
> >> > static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
> >> > function and before adding new shm into task list check that list is empty OR
> >> > an item which is present on the list from the same namespace as
> >> > current->nsproxy->ipc_ns.
> >> >
> >> Ok. (Sorry, I have only smartphone internet, thus I could not check
> >> the patch fully)
> >>
> >> > >> I've proposed a change which keeps the old behaviour of setns() but
> >> > >> fixes double free.
> >> > >>
> >> > > Assuming that locking works, I would consider this as a namespace design question: Do we want to support that a task contains shm objects from several ipc namespaces?
> >> >
> >> > This depends on what we mean by "task contains shm objects from
> >> > several ipc namespaces". There are two meanings:
> >> >
> >> > 1. Task has attached shm object from different ipc namespaces
> >> >
> >> > We already support that by design. When we doing a change of namespace
> >> > using unshare(CLONE_NEWIPC) even with
> >> > sysctl shm_rmid_forced=1 we not detach all ipc's from task!
> >>
> >> OK. Thus shm and sem have different behavior anyways.
> >>
> >> >
> >> > 2. Task task->sysvshm.shm_clist list has items from different IPC namespaces.
> >> >
> >> > I'm not sure, do we need that or not. But I'm ready to prepare a patch
> >> > for any of the options which we choose:
> >> > a) just add exit_shm(current)+shm_init_task(current);
> >> > b) prepare PATCHv2 with appropriate check in the newseg() to prevent
> >> > adding new items from different namespace to the list
> >> > c) rework algorithm so we can safely have items from different
> >> > namespaces in task->sysvshm.shm_clist
> >> >
> >> Before you write something, let's wait what the others say. I don't
> >> qualify AS shm expert
> >>
> >> a) is user space visible, without any good excuse
> >
> > yes, but maybe we decide that this is not so critical?
> > We need more people here :)
>
> It is barely visible.  You have to do something very silly
> to see this happening.  It is probably ok, but the work to
> verify that nothing cares so that we can safely backport
> the change is probably much more work than just updating
> the list to handle shmid's for multiple namespaces.
>
>
> >> c) is probably highest amount of Changes
> >
> > yep. but ok, I will prepare patches fast.
>
> Given that this is a bug I think c) is the safest option.
>
> A couple of suggestions.
> 1) We can replace the test "shm_creator != NULL" with
>    "list_empty(&shp->shm_clist)" and remove shm_creator.
>
>    Along with replacing "shm_creator = NULL" with
>    "list_del_init(&shp->shm_clist)".
>
> 2) We can update shmat to do "list_del_init(&shp->shm_clist)"
>    upon shmat.  The last unmap will still shm_destroy the
>    shm segment as ns->shm_rmid_forced is set.
>
>    For a multi-threaded process I think this will nicely clean up
>    the clist, and make it clear that the clist only cares about
>    those segments that have been created but never attached.
>
> 3) Put a non-reference counted struct ipc_namespace in struct
>    shmid_kernel, and use it to remove the namespace parameter
>    from shm_destroy.

Thanks for your detailed suggestions! ;)
I will prepare a patch tomorrow for kernel + test what's happening with
CRIU and will prepare a fix for it.

>
> I think that is enough to fix this bug with no changes in semantics,
> no additional memory consumed, and an implementation that is easier
> to read and perhaps a little faster.
>
> Eric

Regards,
Alex
