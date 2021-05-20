Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B023E389BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 05:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhETDWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 23:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhETDWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 23:22:45 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09A9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 20:21:24 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b13so7593692pfv.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 20:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ySyAIJOA8yL5i3ppp3Xxnij0FaG8O8nOsMQ7pMgLJCg=;
        b=uov/0El+n/1jEIno2w28xQw/x82WvmHT9lmBdEVPnkPXwJBW+7CR4EqcE1fEo+qtHR
         eeJwafIEr327mUNPh2HWx1sNO50Qq1aosD1nPM3aj4vN9eusXVUgNWkxxc4D0emJQNm9
         8xh8Dyqiz+u7q6vbCcHQPv/25xwGmYQb6/diwgY/7mdqekhJ7bjepSbG4GXNJOmZwF4M
         URlrJ0EuC/a/OP0E6j9+iRe4A1NNtazmhGfSTd6upoEGS48XUahwpi8nEC/XUduyrcKE
         23KlQsqSiWaDAAL7fMQ1hGmfhJTYNXcXEMA8jxaJktrPnSnVjnYEejC349IFilv8ip5c
         nfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ySyAIJOA8yL5i3ppp3Xxnij0FaG8O8nOsMQ7pMgLJCg=;
        b=lb4I0NoeF8yExsDfSXLDJi8nOYznyStsrnmal2X1LdYD8nvYo+LNy8y9C8F6tOM/IX
         TsDk2t8X0cz1fiDNMC//h1nALlS/QqjQie4gLA7+8BV61gvUaAKTRQkMbriykcxUTaK7
         AfoCy8QWxYH9QTEU+WAyGDwnUFwRNFzwnttsXQXMVPDQZGqpKJhba8kbvSN7zG+dHWiE
         aayB4o9Cdf3Mr5UPrJmtfSAfWIs22fZ02OpKWzOxd4S2zBxg8QRS2Rc9yOLCisJbHaoc
         vMvtRLWEY1QkWn6dVyVIzfOI8BrkAo1/op2PaI0NIYAEXSXp5yxuL1pgocys2+j3OpY7
         2Pqw==
X-Gm-Message-State: AOAM532iPpZWEeq3Q7eHs4nKo9nFvNkRVY5yO+yjF80ivb9+wJiTJUY2
        V5zuMItEzT1YQVzPPfl/jnlBfIva+IbOyYTeiPoIdg==
X-Google-Smtp-Source: ABdhPJxHo3V/ZzFVFIaDISL+PNBvFWcjnkBCT0auv6KthfMidWelGLrWOs4qXAn91I+eld3X89NwXns05BL9KfceujU=
X-Received: by 2002:a63:1953:: with SMTP id 19mr2359640pgz.273.1621480884100;
 Wed, 19 May 2021 20:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210421070059.69361-1-songmuchun@bytedance.com>
 <CAMZfGtUiKcM8WmP88J3K5edwLhJhsUkAUQo6rnkqx4BBOEY2SA@mail.gmail.com> <34366052-8A39-4E8E-A076-8B64AB4D015D@fb.com>
In-Reply-To: <34366052-8A39-4E8E-A076-8B64AB4D015D@fb.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 20 May 2021 11:20:47 +0800
Message-ID: <CAMZfGtXC_UG9gUD58ezL02a+Gyry_d7WfEwKup6UMQjvNi3HdQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH v3 00/12] Use obj_cgroup APIs to charge
 the LRU pages
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        "fam.zheng@bytedance.com" <fam.zheng@bytedance.com>,
        "Singh, Balbir" <bsingharora@gmail.com>,
        Yang Shi <shy828301@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 10:17 PM Roman Gushchin <guro@fb.com> wrote:
>
> Hi Muchun!
>
> It looks like the writeback problem will be solved in a different way, wh=
ich will not require generalization of the obj_cgroup api to the cgroup lev=
el. It=E2=80=99s not fully confirmed yet though. We still might wanna do th=
is generalization lingn-term, but as now I have no objections for continuin=
g the work on your patchset. I=E2=80=99m on pto this week, but will take a =
deeper look at your patches early next week. Sorry for the delay.

Waiting on your review. Thanks Roman.

>
> Thanks!
>
> Sent from my iPhone
>
> > On May 18, 2021, at 06:50, Muchun Song <songmuchun@bytedance.com> wrote=
:
> >
> > =EF=BB=BFPing...
> >
> > Hi Johannes and Roman,
> >
> > Any suggestions on this patch set?
> >
> > Thanks.
> >
> >> On Wed, Apr 21, 2021 at 3:01 PM Muchun Song <songmuchun@bytedance.com>=
 wrote:
> >>
> >> This is v3 based on the top of the series[1] (memcontrol code cleanup =
and
> >> simplification). Roman is working on the generalization of obj_cgroup =
API.
> >> But before that, hope someone can review this patches for correctness.
> >>
> >> Since the following patchsets applied. All the kernel memory are charg=
ed
> >> with the new APIs of obj_cgroup.
> >>
> >>        [v17,00/19] The new cgroup slab memory controller[2]
> >>        [v5,0/7] Use obj_cgroup APIs to charge kmem pages[3]
> >>
> >> But user memory allocations (LRU pages) pinning memcgs for a long time=
 -
> >> it exists at a larger scale and is causing recurring problems in the r=
eal
> >> world: page cache doesn't get reclaimed for a long time, or is used by=
 the
> >> second, third, fourth, ... instance of the same job that was restarted=
 into
> >> a new cgroup every time. Unreclaimable dying cgroups pile up, waste me=
mory,
> >> and make page reclaim very inefficient.
> >>
> >> We can convert LRU pages and most other raw memcg pins to the objcg di=
rection
> >> to fix this problem, and then the LRU pages will not pin the memcgs.
> >>
> >> This patchset aims to make the LRU pages to drop the reference to memo=
ry
> >> cgroup by using the APIs of obj_cgroup. Finally, we can see that the n=
umber
> >> of the dying cgroups will not increase if we run the following test sc=
ript.
> >>
> >> ```bash
> >> #!/bin/bash
> >>
> >> cat /proc/cgroups | grep memory
> >>
> >> cd /sys/fs/cgroup/memory
> >>
> >> for i in range{1..500}
> >> do
> >>        mkdir test
> >>        echo $$ > test/cgroup.procs
> >>        sleep 60 &
> >>        echo $$ > cgroup.procs
> >>        echo `cat test/cgroup.procs` > cgroup.procs
> >>        rmdir test
> >> done
> >>
> >> cat /proc/cgroups | grep memory
> >> ```
> >>
> >> Thanks.
> >>
> >> [1] https://lore.kernel.org/linux-mm/20210417043538.9793-1-songmuchun@=
bytedance.com/
> >> [2] https://lore.kernel.org/linux-mm/20200623015846.1141975-1-guro@fb.=
com/
> >> [3] https://lore.kernel.org/linux-mm/20210319163821.20704-1-songmuchun=
@bytedance.com/
> >>
> >> Changlogs in RFC v3:
> >>  1. Drop the code cleanup and simplification patches. Gather those pat=
ches
> >>     into a separate series[1].
> >>  2. Rework patch #1 suggested by Johannes.
> >>
> >> Changlogs in RFC v2:
> >>  1. Collect Acked-by tags by Johannes. Thanks.
> >>  2. Rework lruvec_holds_page_lru_lock() suggested by Johannes. Thanks.
> >>  3. Fix move_pages_to_lru().
> >>
> >> Muchun Song (12):
> >>  mm: memcontrol: move the objcg infrastructure out of CONFIG_MEMCG_KME=
M
> >>  mm: memcontrol: introduce compact_lock_page_lruvec_irqsave
> >>  mm: memcontrol: make lruvec lock safe when the LRU pages reparented
> >>  mm: vmscan: rework move_pages_to_lru()
> >>  mm: thp: introduce lock/unlock_split_queue{_irqsave}()
> >>  mm: thp: make deferred split queue lock safe when the LRU pages
> >>    reparented
> >>  mm: memcontrol: make all the callers of page_memcg() safe
> >>  mm: memcontrol: introduce memcg_reparent_ops
> >>  mm: memcontrol: use obj_cgroup APIs to charge the LRU pages
> >>  mm: memcontrol: rename {un}lock_page_memcg() to {un}lock_page_objcg()
> >>  mm: lru: add VM_BUG_ON_PAGE to lru maintenance function
> >>  mm: lru: use lruvec lock to serialize memcg changes
> >>
> >> Documentation/admin-guide/cgroup-v1/memory.rst |   2 +-
> >> fs/buffer.c                                    |  13 +-
> >> fs/fs-writeback.c                              |  23 +-
> >> fs/iomap/buffered-io.c                         |   4 +-
> >> include/linux/memcontrol.h                     | 182 ++++----
> >> include/linux/mm_inline.h                      |   6 +
> >> mm/compaction.c                                |  36 +-
> >> mm/filemap.c                                   |   2 +-
> >> mm/huge_memory.c                               | 171 ++++++--
> >> mm/memcontrol.c                                | 562 +++++++++++++++++=
+-------
> >> mm/migrate.c                                   |   4 +
> >> mm/page-writeback.c                            |  24 +-
> >> mm/page_io.c                                   |   5 +-
> >> mm/rmap.c                                      |  14 +-
> >> mm/swap.c                                      |  46 +-
> >> mm/vmscan.c                                    |  56 ++-
> >> 16 files changed, 795 insertions(+), 355 deletions(-)
> >>
> >> --
> >> 2.11.0
> >>
