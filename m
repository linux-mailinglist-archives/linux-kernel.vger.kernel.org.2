Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C4F3EC0A8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 07:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbhHNF0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 01:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbhHNF0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 01:26:02 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D9CC061575
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:25:34 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so5540442pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0WN+1Ca2oONIC6+RCCmzf4jTeBHsA3MzR6howz8AK0E=;
        b=0wRQI98ijU1uWeXer/aZUSSs6aAJexilg4qccmUj5oivNSXXtzb2HYvzIH5Z85F77c
         FdNI+Pe1cC4fraSsnNrK+Zzg7vVu0Iu8iPMtsg+J62sXHE6uc29KfCHq00mIuBch6Oee
         wp1jH2MyqKmA4JBllN3IJnxmsWDlhygtcD5+h3gBvPZMiIvvF3ZtbM5nn6rQNT6a6v5d
         QbEnZ4hWFC8HD9Qy58Okq+qk/zFq4cHXkqNjCE1TdnwMmDWekiCx3AxgICLwUtgQWDGv
         CdnryurMBr3+mrjSd4VnEF0HtvMDTMLvz6awp6Ls8pOmbLjCQ9u99IGYUyHHg9brKgp5
         jMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0WN+1Ca2oONIC6+RCCmzf4jTeBHsA3MzR6howz8AK0E=;
        b=qu5HUebZu7wtujrSIvuxcdqWOyaLlzY4fsE82mg+t3ftNb2knyk03nh4L2YxoAgkzB
         xoHVBFGNjw1SrkoEpE/ALAwpvpn+pcNJItHAmNtDkuzWWPMYaWW/40H/kt218ZpaihYT
         9jmLAQjmQ6bs8cD0uUkMt225rQ55yLS61B88CexBLRPoFNK7cKp2dDue0LIxLfwk9HVw
         lH1Y68Y9dRGBfDB1tP2q6i2Bn4cUGXjqN0V6hQrOJ9QKtUsI1tuYeo7e5BJUGkQKAItD
         UoTEV9PDSZH5lLa2F0997bFLtovYKBqQkOUd4caOugKGmEeXLDi5mZPq2fjWA5IcNEFn
         Oe0w==
X-Gm-Message-State: AOAM533VFKcPIZypnH1t9mDpFeivaDqupFjLG2vRhPbjqGATH54hADG/
        FLAAl3ynxmKI7RPEQlCZtIxw5Q==
X-Google-Smtp-Source: ABdhPJyenO8qMymW+D0aWaQc3Rw5rx8DJmj5KXhE6IQvnbKClwjtWQR1yFiP8f1RNG96dbcnJdoBkQ==
X-Received: by 2002:a62:be04:0:b029:3e0:3fca:2a8f with SMTP id l4-20020a62be040000b02903e03fca2a8fmr5657896pff.12.1628918734128;
        Fri, 13 Aug 2021 22:25:34 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id s5sm4783133pgp.81.2021.08.13.22.25.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 22:25:33 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v1 00/12] Use obj_cgroup APIs to charge the LRU pages
Date:   Sat, 14 Aug 2021 13:25:07 +0800
Message-Id: <20210814052519.86679-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This version is basded on the next-20210811 and drops RFC tag from the last
version. Comments and reviews are welcome. Thanks.

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

Muchun Song (12):
  mm: memcontrol: prepare objcg API for non-kmem usage
  mm: memcontrol: introduce compact_folio_lruvec_lock_irqsave
  mm: memcontrol: make lruvec lock safe when LRU pages are reparented
  mm: vmscan: rework move_pages_to_lru()
  mm: thp: introduce folio_split_queue_lock{_irqsave}()
  mm: thp: make split queue lock safe when LRU pages are reparented
  mm: memcontrol: make all the callers of {folio,page}_memcg() safe
  mm: memcontrol: introduce memcg_reparent_ops
  mm: memcontrol: use obj_cgroup APIs to charge the LRU pages
  mm: memcontrol: rename {un}lock_page_memcg() to {un}lock_page_objcg()
  mm: lru: add VM_BUG_ON_FOLIO to lru maintenance function
  mm: lru: use lruvec lock to serialize memcg changes

 Documentation/admin-guide/cgroup-v1/memory.rst |   2 +-
 fs/buffer.c                                    |  11 +-
 fs/fs-writeback.c                              |  23 +-
 include/linux/memcontrol.h                     | 184 ++++----
 include/linux/mm.h                             |   1 +
 include/linux/mm_inline.h                      |  15 +-
 mm/compaction.c                                |  39 +-
 mm/filemap.c                                   |   2 +-
 mm/huge_memory.c                               | 162 ++++++--
 mm/memcontrol.c                                | 554 ++++++++++++++++++-------
 mm/migrate.c                                   |   4 +
 mm/page-writeback.c                            |   6 +-
 mm/page_io.c                                   |   5 +-
 mm/rmap.c                                      |  14 +-
 mm/swap.c                                      |  49 +--
 mm/vmscan.c                                    |  57 ++-
 16 files changed, 778 insertions(+), 350 deletions(-)

-- 
2.11.0

