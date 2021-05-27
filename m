Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9BA392AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbhE0JfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbhE0JfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:35:22 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06165C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:33:49 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id i5so3302109pgm.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sHbpGJMam8NU22tgKHYOQSyOi8RztO3bNwAJiFedN7s=;
        b=J9useeXoCsMYh/byHeKUeScxpn7jZk/NPMMEA0sz/ycNh3Uyj0rRjF4zu8/qmTrM+Z
         1tRUMhxbhKvRZj0/eh/YdVp2Y38MQzVmDZaSM9ekauPU6xYcf6TwPkMV+k85K+CZegRe
         aumRgfXAwOSV3Szt928WbZYMS94RVCHFkmxe7KScejTBE+vseaQZ38EoYQ8DAKY/X1Kz
         4u1/EKYnD6iH2P+O1Ru8wlf/JodqoQiqYQbC+SIMojOCcyd49SXMKzcPb6w1lK5l67/9
         oDowrVSiFC6mriJnDlHZy67lug1wAKVL6aOsQ+PWMWC2N5CixBw4DSZgylAC116EnvYP
         ixVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sHbpGJMam8NU22tgKHYOQSyOi8RztO3bNwAJiFedN7s=;
        b=GMIvM7QRkem2YBvXmiY1nZZ3f3uE8f9E9EZx2B0hcEKsFvzlryoDf6fjNFMr9Ncj2L
         yfrebQTFfavHiZmxTW7oR5jS8z0W5v47TNyievUtYE7KO+XpkbKiVkbmnXb+mRtNPk4X
         i29bGoml/sD/ew/Fg0T/8CrU6TBmsZFQn8iRdJIKnrE4UrKJ9K7MuqsrBcKUdvtBpukk
         L9IRwNqBbuXUg0bgEhZamiwRcXxuTDdHJDXkNMKh0d9lgQRJ3F1yZVVCMsvw+2pc/FB5
         11h+V1DAJGaRC1oYZ2xaulUfAjc2ZdWF4smBxMMU/ONjXF+xGZGD+0tktaybHxRHqSgb
         HXcA==
X-Gm-Message-State: AOAM532WMrzdlH23rmx+mRZSKGgEHIu1Fl5YMq/Qm8L3c4YaEA7hkXOh
        QBmuSxDEbyuybeCfDgbenC62gA==
X-Google-Smtp-Source: ABdhPJzP4fvbHuX2LjTBCTdv3631Uj/6zhB8/172SGoP/ORjU9lB9mkSQkAcV+TyhRahrAgHd4oUTA==
X-Received: by 2002:a05:6a00:234f:b029:2c4:b8d6:843 with SMTP id j15-20020a056a00234fb02902c4b8d60843mr2842745pfj.71.1622108028493;
        Thu, 27 May 2021 02:33:48 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id a9sm1418917pfl.57.2021.05.27.02.33.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 02:33:47 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v4 00/12] Use obj_cgroup APIs to charge the LRU pages
Date:   Thu, 27 May 2021 17:33:24 +0800
Message-Id: <20210527093336.14895-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the following patchsets applied. All the kernel memory are charged
with the new APIs of obj_cgroup.

	[v17,00/19] The new cgroup slab memory controller[1]
	[v5,0/7] Use obj_cgroup APIs to charge kmem pages[2]

But user memory allocations (LRU pages) pinning memcgs for a long time -
it exists at a larger scale and is causing recurring problems in the real
world: page cache doesn't get reclaimed for a long time, or is used by the
second, third, fourth, ... instance of the same job that was restarted into
a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
and make page reclaim very inefficient.

We can convert LRU pages and most other raw memcg pins to the objcg direction
to fix this problem, and then the LRU pages will not pin the memcgs.

This patchset aims to make the LRU pages to drop the reference to memory
cgroup by using the APIs of obj_cgroup. Finally, we can see that the number
of the dying cgroups will not increase if we run the following test script.

```bash
#!/bin/bash

cat /proc/cgroups | grep memory

cd /sys/fs/cgroup/memory

for i in range{1..500}
do
	mkdir test
	echo $$ > test/cgroup.procs
	sleep 60 &
	echo $$ > cgroup.procs
	echo `cat test/cgroup.procs` > cgroup.procs
	rmdir test
done

cat /proc/cgroups | grep memory
```

Thanks.

[1] https://lore.kernel.org/linux-mm/20200623015846.1141975-1-guro@fb.com/
[2] https://lore.kernel.org/linux-mm/20210319163821.20704-1-songmuchun@bytedance.com/

Changlogs in RFC v4:
  1. Collect Acked-by from Roman.
  2. Rebase to linux next-20210525.
  3. Rename obj_cgroup_release_uncharge() to obj_cgroup_release_kmem().
  4. Change the patch 1 title to "prepare objcg API for non-kmem usage".
  5. Convert reparent_ops_head to an array in patch 8.

  Thanks for Roman's review and suggestions.

Changlogs in RFC v3:
  1. Drop the code cleanup and simplification patches. Gather those patches
     into a separate series[1].
  2. Rework patch #1 suggested by Johannes.

Changlogs in RFC v2:
  1. Collect Acked-by tags by Johannes. Thanks.
  2. Rework lruvec_holds_page_lru_lock() suggested by Johannes. Thanks.
  3. Fix move_pages_to_lru().

Muchun Song (12):
  mm: memcontrol: prepare objcg API for non-kmem usage
  mm: memcontrol: introduce compact_lock_page_irqsave
  mm: memcontrol: make lruvec lock safe when the LRU pages reparented
  mm: vmscan: rework move_pages_to_lru()
  mm: thp: introduce lock/unlock_split_queue{_irqsave}()
  mm: thp: make deferred split queue lock safe when the LRU pages
    reparented
  mm: memcontrol: make all the callers of page_memcg() safe
  mm: memcontrol: introduce memcg_reparent_ops
  mm: memcontrol: use obj_cgroup APIs to charge the LRU pages
  mm: memcontrol: rename {un}lock_page_memcg() to {un}lock_page_objcg()
  mm: lru: add VM_BUG_ON_PAGE to lru maintenance function
  mm: lru: use lruvec lock to serialize memcg changes

 Documentation/admin-guide/cgroup-v1/memory.rst |   2 +-
 fs/buffer.c                                    |  13 +-
 fs/fs-writeback.c                              |  23 +-
 fs/iomap/buffered-io.c                         |   4 +-
 include/linux/memcontrol.h                     | 178 ++++----
 include/linux/mm_inline.h                      |   6 +
 mm/compaction.c                                |  36 +-
 mm/filemap.c                                   |   2 +-
 mm/huge_memory.c                               | 165 ++++++--
 mm/memcontrol.c                                | 563 ++++++++++++++++++-------
 mm/migrate.c                                   |   4 +
 mm/page-writeback.c                            |  24 +-
 mm/page_io.c                                   |   5 +-
 mm/rmap.c                                      |  14 +-
 mm/swap.c                                      |  46 +-
 mm/vmscan.c                                    |  56 ++-
 16 files changed, 784 insertions(+), 357 deletions(-)

-- 
2.11.0

