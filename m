Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E00387A66
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243622AbhERNvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhERNvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:51:19 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BEBC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 06:50:01 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b9-20020a17090a9909b029015cf9effaeaso1557902pjp.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 06:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMzjanRvTxOFun6wLQhMf9UNA1xRoh+s8K33AZQxhaw=;
        b=yKPiO/BRSkbwZJ73LXOPDi4E3HfJwj8qvz7uuDGkrBZCA+/i5Yi+FCdB1SRufrWUQG
         cOJO0nACzgkdki4NtXolzGWMY8jff/+nVblnW8YAK1XsyqamhiE3km224AiIuMdaeJM7
         ycuU3oSBqgMKws1jTrm/zZcOuO9hBu/STI1j5OMep52zX6nSflENEt+QHcEru2d2m4++
         GxDdJH0X+EsFsnoeNrVNPahZlH9jcQxMnXAsGnZLToU/IJKDuZbBbb9RugShmMI9F7EU
         RxAUFZQdhXxeeed2JERRO0VohqwttydinNRVm9DKoDCrIRwWfrNpGPgG1zlVKN5XA/+3
         qmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMzjanRvTxOFun6wLQhMf9UNA1xRoh+s8K33AZQxhaw=;
        b=E7JOeXZ/K4fpXaI4Fnw4hpF5Tgp96pdqIkz0qB9U0u6KIdNskJFWzPNaAABgDS/uTh
         1KHKyorsM2TPL6u5SfMmSF0yhfcKv33hzy6PG0z4ggQJU8qazq/bN5regjokA2tyySFG
         Uu8kvUz5AXSdzyDJS7Mobqx01Gg6WemWbOJCkhMBc4s9KI6e/JRqrsFbMpPMy1qgsEG9
         sZDbQyBJvorxkvKMpAH9BaFHS9dKsCK/NcbIW+0lyCQyldBiUMuxiT5aOO3jE94lBD9o
         v4q8AFK+Z7UwJNmJkpg/8h6g3HQOqC/yGRq8JpSLZ3DSSr6LTAuCMYA2dCxdIqrLF7Cr
         TKtw==
X-Gm-Message-State: AOAM533kMluQsmpYy2POdWeVlVS2tNzg1LmXq+BsTdAsChK4qaF1MyGC
        OHsdypFNTWK4oE9A3ghHP7HxeoqViKKZ4o52sZPuEA==
X-Google-Smtp-Source: ABdhPJzTSS4EOJ65sh1imZK2NFcw3ckUZ2WF8vWxq1SOrKvZ02VZqUche2kfk5T79aJVLEXyW3zff85PKP1Eof6D2KU=
X-Received: by 2002:a17:90a:3c8d:: with SMTP id g13mr5700502pjc.13.1621345800733;
 Tue, 18 May 2021 06:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210421070059.69361-1-songmuchun@bytedance.com>
In-Reply-To: <20210421070059.69361-1-songmuchun@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 18 May 2021 21:49:25 +0800
Message-ID: <CAMZfGtUiKcM8WmP88J3K5edwLhJhsUkAUQo6rnkqx4BBOEY2SA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/12] Use obj_cgroup APIs to charge the LRU pages
To:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, "Singh, Balbir" <bsingharora@gmail.com>,
        Yang Shi <shy828301@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...

Hi Johannes and Roman,

Any suggestions on this patch set?

Thanks.

On Wed, Apr 21, 2021 at 3:01 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> This is v3 based on the top of the series[1] (memcontrol code cleanup and
> simplification). Roman is working on the generalization of obj_cgroup API.
> But before that, hope someone can review this patches for correctness.
>
> Since the following patchsets applied. All the kernel memory are charged
> with the new APIs of obj_cgroup.
>
>         [v17,00/19] The new cgroup slab memory controller[2]
>         [v5,0/7] Use obj_cgroup APIs to charge kmem pages[3]
>
> But user memory allocations (LRU pages) pinning memcgs for a long time -
> it exists at a larger scale and is causing recurring problems in the real
> world: page cache doesn't get reclaimed for a long time, or is used by the
> second, third, fourth, ... instance of the same job that was restarted into
> a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
> and make page reclaim very inefficient.
>
> We can convert LRU pages and most other raw memcg pins to the objcg direction
> to fix this problem, and then the LRU pages will not pin the memcgs.
>
> This patchset aims to make the LRU pages to drop the reference to memory
> cgroup by using the APIs of obj_cgroup. Finally, we can see that the number
> of the dying cgroups will not increase if we run the following test script.
>
> ```bash
> #!/bin/bash
>
> cat /proc/cgroups | grep memory
>
> cd /sys/fs/cgroup/memory
>
> for i in range{1..500}
> do
>         mkdir test
>         echo $$ > test/cgroup.procs
>         sleep 60 &
>         echo $$ > cgroup.procs
>         echo `cat test/cgroup.procs` > cgroup.procs
>         rmdir test
> done
>
> cat /proc/cgroups | grep memory
> ```
>
> Thanks.
>
> [1] https://lore.kernel.org/linux-mm/20210417043538.9793-1-songmuchun@bytedance.com/
> [2] https://lore.kernel.org/linux-mm/20200623015846.1141975-1-guro@fb.com/
> [3] https://lore.kernel.org/linux-mm/20210319163821.20704-1-songmuchun@bytedance.com/
>
> Changlogs in RFC v3:
>   1. Drop the code cleanup and simplification patches. Gather those patches
>      into a separate series[1].
>   2. Rework patch #1 suggested by Johannes.
>
> Changlogs in RFC v2:
>   1. Collect Acked-by tags by Johannes. Thanks.
>   2. Rework lruvec_holds_page_lru_lock() suggested by Johannes. Thanks.
>   3. Fix move_pages_to_lru().
>
> Muchun Song (12):
>   mm: memcontrol: move the objcg infrastructure out of CONFIG_MEMCG_KMEM
>   mm: memcontrol: introduce compact_lock_page_lruvec_irqsave
>   mm: memcontrol: make lruvec lock safe when the LRU pages reparented
>   mm: vmscan: rework move_pages_to_lru()
>   mm: thp: introduce lock/unlock_split_queue{_irqsave}()
>   mm: thp: make deferred split queue lock safe when the LRU pages
>     reparented
>   mm: memcontrol: make all the callers of page_memcg() safe
>   mm: memcontrol: introduce memcg_reparent_ops
>   mm: memcontrol: use obj_cgroup APIs to charge the LRU pages
>   mm: memcontrol: rename {un}lock_page_memcg() to {un}lock_page_objcg()
>   mm: lru: add VM_BUG_ON_PAGE to lru maintenance function
>   mm: lru: use lruvec lock to serialize memcg changes
>
>  Documentation/admin-guide/cgroup-v1/memory.rst |   2 +-
>  fs/buffer.c                                    |  13 +-
>  fs/fs-writeback.c                              |  23 +-
>  fs/iomap/buffered-io.c                         |   4 +-
>  include/linux/memcontrol.h                     | 182 ++++----
>  include/linux/mm_inline.h                      |   6 +
>  mm/compaction.c                                |  36 +-
>  mm/filemap.c                                   |   2 +-
>  mm/huge_memory.c                               | 171 ++++++--
>  mm/memcontrol.c                                | 562 ++++++++++++++++++-------
>  mm/migrate.c                                   |   4 +
>  mm/page-writeback.c                            |  24 +-
>  mm/page_io.c                                   |   5 +-
>  mm/rmap.c                                      |  14 +-
>  mm/swap.c                                      |  46 +-
>  mm/vmscan.c                                    |  56 ++-
>  16 files changed, 795 insertions(+), 355 deletions(-)
>
> --
> 2.11.0
>
