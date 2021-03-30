Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BA434E54C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhC3KUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhC3KUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:20:34 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A19AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:20:33 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id k8so2228779pgf.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TU4CV4YLVkFbwG4kyfiazu8+2NmeG1063RTT/LGVd6w=;
        b=0pg6UFsP/hE+myqG0q7Cv0BwoV83P31hKY44lzq2US9m0TbommXHTAt7kYU3yx+U5q
         3TuSpxvEakTlPhIg+rmECo2YBk72hz8mDex4yNJNgZOMrWq6+Kui9Llw9SgEvaHlvXpy
         sXgJfeRGV4Wp+gbeagkvkvYUECqRn+eVv6LTDcBK8Foh8TgwPenVSb15OLdpkUZrWuHN
         tDyAiSX8TjCzKmkt+clyuNxagJ8Dg3fMGx90TVnwDmuB8Z/cwXqEv6wFMOfo4ENq/Hp+
         QMS8pCd5Wi1WO9BqyYD/MZKIzhOSflUpKlVF0vSPMfP6N3QanFgIHTPnY5dt1Q+JAOrZ
         DFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TU4CV4YLVkFbwG4kyfiazu8+2NmeG1063RTT/LGVd6w=;
        b=eGZg/MVovs5GTMZIgBddDr14nTYPV5PB3Z2NvkgKFVq2BUqGh11pNC1FhbDOy6RPC/
         kiYygCJz1T8aXYtsEyImFi45DfpDxRnHMjfp2j9Ta89bUI6TX8gs5Y7kU6CBT5a+6cBG
         THS9sergCmmmHqec7AKz8MnlimRaADImdMbhrSP5kTdY3zK/auw3sELj5sNLZBF5+9fl
         CN2AdjmMemOjurHmiv7FgJiAJNpubCOindE0MEcydLUxTmWKb8eE7WPbxACiE4gtJMQi
         BtA6u091PVpzOkH2G6KtRc/bqwbCSSleAnuHWsYt3ffl4k64yh2Q7fNIi+t0oeur7ghw
         bM/g==
X-Gm-Message-State: AOAM531WTQ5nmARXdlkQf/kcoP9z1Kj2Qqi4bOwnsz/iIIxXybW+1+/r
        QMvGEAn9a7TKAIO2hWebsHOQVw==
X-Google-Smtp-Source: ABdhPJyER9cwj4Z/xC/2DKZfUBiRyk4g6KI/BsbAEu6XMj4TJnpWHTAL83PIbQsIvialX253VaTlng==
X-Received: by 2002:a65:40c7:: with SMTP id u7mr11924136pgp.29.1617099632791;
        Tue, 30 Mar 2021 03:20:32 -0700 (PDT)
Received: from localhost.localdomain ([2408:8445:ad30:68d8:c87f:ca1b:dc00:4730])
        by smtp.gmail.com with ESMTPSA id k10sm202259pfk.205.2021.03.30.03.20.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 03:20:32 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 00/15] Use obj_cgroup APIs to charge the LRU pages
Date:   Tue, 30 Mar 2021 18:15:16 +0800
Message-Id: <20210330101531.82752-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the following patchsets applied. All the kernel memory are charged
with the new APIs of obj_cgroup.

	[v17,00/19] The new cgroup slab memory controller
	[v5,0/7] Use obj_cgroup APIs to charge kmem pages

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

Patch 1 aims to fix page charging in page replacement.
Patch 2-5 are code cleanup and simplification.
Patch 6-15 convert LRU pages pin to the objcg direction.

Muchun Song (15):
  mm: memcontrol: fix page charging in page replacement
  mm: memcontrol: bail out early when !mm in get_mem_cgroup_from_mm
  mm: memcontrol: remove the pgdata parameter of mem_cgroup_page_lruvec
  mm: memcontrol: use lruvec_memcg in lruvec_holds_page_lru_lock
  mm: memcontrol: simplify the logic of objcg pinning memcg
  mm: memcontrol: move the objcg infrastructure out of CONFIG_MEMCG_KMEM
  mm: memcontrol: introduce compact_lock_page_lruvec_irqsave
  mm: memcontrol: make lruvec lock safe when the LRU pages reparented
  mm: thp: introduce lock/unlock_split_queue{_irqsave}()
  mm: thp: make deferred split queue lock safe when the LRU pages
    reparented
  mm: memcontrol: make all the callers of page_memcg() safe
  mm: memcontrol: introduce memcg_reparent_ops
  mm: memcontrol: use obj_cgroup APIs to charge the LRU pages
  mm: memcontrol: rename {un}lock_page_memcg() to {un}lock_page_objcg()
  mm: lru: add VM_BUG_ON_PAGE to lru maintenance function

 Documentation/admin-guide/cgroup-v1/memory.rst |   2 +-
 fs/buffer.c                                    |  13 +-
 fs/fs-writeback.c                              |  23 +-
 fs/iomap/buffered-io.c                         |   4 +-
 include/linux/memcontrol.h                     | 197 +++++----
 include/linux/mm_inline.h                      |   6 +
 mm/compaction.c                                |  42 +-
 mm/filemap.c                                   |   2 +-
 mm/huge_memory.c                               | 175 +++++++-
 mm/memcontrol.c                                | 578 +++++++++++++++++--------
 mm/migrate.c                                   |   4 +
 mm/page-writeback.c                            |  28 +-
 mm/page_io.c                                   |   5 +-
 mm/rmap.c                                      |  14 +-
 mm/swap.c                                      |   7 +-
 mm/vmscan.c                                    |   3 +-
 mm/workingset.c                                |   2 +-
 17 files changed, 762 insertions(+), 343 deletions(-)

-- 
2.11.0

