Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0118040DBC1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbhIPNxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbhIPNx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:53:29 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91382C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:52:08 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v2so3886797plp.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n9wIjj8xLLBzdnBn259zJI9o7Pja/5VUgexxrmUSEiM=;
        b=xAfHTJVecbpE3lJwD/OU7A5LkTVmINWpj3g3tEt77KH3wp2QGLIQpKQM1oxh00i5zJ
         9ivYA8X/CGTn1V2iluipfkQLQowSqkxHd20YBitRdMwIQmSLdQom9DK9OPlymTFwBi+P
         HHcao7oKUI/jaVhgMkHwcz0EbFjVXVrQxCCdqtl34DcKZ0kurCIZ1jOv1DSKBHQLd5kM
         SBrgkker9/Zs0YNOdQjlV53OQznqUYRqXXMIs45kv3snr46pSUYdbEOViia9k96Out24
         v8zf9E3McuFjcr3Hc7sAr5sVXfejNJbLzsYfbSR/TXNoacNWG9OoS+jm0blXhwz89h8O
         972A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n9wIjj8xLLBzdnBn259zJI9o7Pja/5VUgexxrmUSEiM=;
        b=qljM3qjt98GLFuv/d327xLD2oByEmn1Yw6vaY4Xsd+LqcsO4mZrIHkqZkLzvHKBjsj
         AiUaOQ++Iksw4GHkUhnLQayzlnI/efqE/fK9VvvTdFWMp71ALXlg/H+U4faxDxLqQK49
         EQBPY4kaNjA6ZfbxOjKNkoJqGo5nwY5a7Yy/d8TX+WjNQMrFDURx2I6Lk69PltZwIk6X
         7wxo4qblbSYd5hSccYURxFXZ6jMyNXvybHDm4XwfSZFoqgAewBnuDJovgA2M9hIxQdgH
         wLqhyUBSplIAGlOCzL6TV5LmWTXL3+V+wrRTsI4AWR8xfjb8fwAIa4adQYNBujQns96W
         qpfQ==
X-Gm-Message-State: AOAM533jKC4vLQW9CBMyEZ488oKoMZlqdvKrfMsFt3kfTFQUClnYCt0k
        AtmbCABPRSGzhn80QBSMtHl1Lg==
X-Google-Smtp-Source: ABdhPJytGRuNBoH643MZXZvZXjefR0Q3eMMQfrYoaaMQdSTA9YzbMkpZvG7K8qnbdiW9nVFEaHu6tw==
X-Received: by 2002:a17:902:e78f:b0:139:a3c3:5eaa with SMTP id cp15-20020a170902e78f00b00139a3c35eaamr4920556plb.47.1631800328043;
        Thu, 16 Sep 2021 06:52:08 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id o9sm3617443pfh.217.2021.09.16.06.52.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 06:52:07 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 00/13] Use obj_cgroup APIs to charge the LRU pages
Date:   Thu, 16 Sep 2021 21:47:35 +0800
Message-Id: <20210916134748.67712-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version is rebased over linux 5.15-rc1, because Shakeel has asked me
if I could do that. I rework some code suggested by Roman as well in this
version. I have not removed the Acked-by tags which are from Roman, because
this version is not based on the folio relevant. If Roman wants me to
do this, please let me know, thanks.

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

Changlogs in v2:
  1. Rename obj_cgroup_release_kmem() to obj_cgroup_release_bytes() and the
     dependencies of CONFIG_MEMCG_KMEM (suggested by Roman, Thanks).
  2. Rebase to linux 5.15-rc1.
  3. Add a new pacth to cleanup mem_cgroup_kmem_disabled().

Changlogs in v1:
  1. Drop RFC tag.
  2. Rebase to linux next-20210811.

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

Muchun Song (13):
  mm: move mem_cgroup_kmem_disabled() to memcontrol.h
  mm: memcontrol: prepare objcg API for non-kmem usage
  mm: memcontrol: introduce compact_lock_page_irqsave
  mm: memcontrol: make lruvec lock safe when the LRU pages reparented
  mm: vmscan: rework move_pages_to_lru()
  mm: thp: introduce split_queue_lock/unlock{_irqsave}()
  mm: thp: make split queue lock safe when LRU pages reparented
  mm: memcontrol: make all the callers of page_memcg() safe
  mm: memcontrol: introduce memcg_reparent_ops
  mm: memcontrol: use obj_cgroup APIs to charge the LRU pages
  mm: memcontrol: rename {un}lock_page_memcg() to {un}lock_page_objcg()
  mm: lru: add VM_BUG_ON_PAGE to lru maintenance function
  mm: lru: use lruvec lock to serialize memcg changes

 Documentation/admin-guide/cgroup-v1/memory.rst |   2 +-
 fs/buffer.c                                    |  11 +-
 fs/fs-writeback.c                              |  23 +-
 include/linux/memcontrol.h                     | 184 ++++----
 include/linux/mm_inline.h                      |   6 +
 mm/compaction.c                                |  36 +-
 mm/filemap.c                                   |   2 +-
 mm/huge_memory.c                               | 159 +++++--
 mm/internal.h                                  |   5 -
 mm/memcontrol.c                                | 563 ++++++++++++++++++-------
 mm/migrate.c                                   |   4 +
 mm/page-writeback.c                            |  26 +-
 mm/page_io.c                                   |   5 +-
 mm/rmap.c                                      |  14 +-
 mm/slab_common.c                               |   2 +-
 mm/swap.c                                      |  46 +-
 mm/vmscan.c                                    |  56 ++-
 17 files changed, 775 insertions(+), 369 deletions(-)

-- 
2.11.0

