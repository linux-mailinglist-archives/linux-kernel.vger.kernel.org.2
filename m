Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BE3359EB8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhDIMcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhDIMcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:32:05 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487DAC061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 05:31:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so4903899pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 05:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fpGPZ/lJV4md7gBypR0OCCiHuyZq6QhPBcCfYgEbJEM=;
        b=sh/mgJLYQRmgQqkTLmkyeqBnWjzmX2I5489hGKjNCA9muzF5do0dhJVzBP1ATVHIRx
         Dq0iBxD8XgO5kkLHoXnwiig9phEyFzVFSIinjz5pAXkMGSSbK4/VpowoOMYEf3MgFQsH
         WPTGvQoGystqgsHXHODZ59kWSvv7GQlSv7e8nJxlpgyvC68Ym1KN0qpaoqQesk4t5ctd
         9swBfdviVAyeUbTaZ+6TDk8W0S/jA/NvaN5atJHadAYCjSMtfqSsKXQ2IMfGsWeM+Nyh
         kKPgup/IvQHBp6mG6mFyPZLHtoeX9IH0SXC9HRnJA7vHCMHdoQfvrEGkkwahFkBF0kpu
         vY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fpGPZ/lJV4md7gBypR0OCCiHuyZq6QhPBcCfYgEbJEM=;
        b=fMp6a9gYWLkrIIZbm+e8IknS0HIMyEE1OuH/62V5fH4yhgcj/MLAuzNoKwNQlZi2Q1
         wdeUKUnlxtYnU9CWgVKnvA5kKnAlDoU3laalS+Jpqprwoun1YOLVAmNZFNgJzrMt1B7+
         VF63xIrTHfHOx7H+awd/UVZXhLczGH3lIjmIKe0tOhsBmLvclZ33kopW581K/SwxIREi
         iIoHyfn0iB+oAPbKyD8S8DznB9ThoklbfKVNsuItkmcIOChn1bBZxVcOBW4eoZ5D49UF
         p2hhyuSRcwGo7pBdWz6DYIFFeT/Gcej+cyWo70HBGrGzVNUoaxK8YmrMlJYOX4OrOxGj
         YYog==
X-Gm-Message-State: AOAM530x3yHmXd9u4EkRFbfA8gfwWq9P8pepTZqDH2FaSaH7SeyIF7oU
        3wSHzImpYI2z3w4t+Kcb6X9ysQ==
X-Google-Smtp-Source: ABdhPJyT7hPDnhRsvstpcwogIpoqHm14u2ElWSIC9KQSpWaWDTBWQd7RYVX7IxVOSA8SDR6JU/1ptw==
X-Received: by 2002:a17:90a:9404:: with SMTP id r4mr13397950pjo.64.1617971512869;
        Fri, 09 Apr 2021 05:31:52 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id t3sm2167785pfg.176.2021.04.09.05.31.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Apr 2021 05:31:52 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v2 00/18] Use obj_cgroup APIs to charge the LRU pages
Date:   Fri,  9 Apr 2021 20:29:41 +0800
Message-Id: <20210409122959.82264-1-songmuchun@bytedance.com>
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
Patch 6-18 convert LRU pages pin to the objcg direction.

Any comments are welcome. Thanks.

Changlogs in RFC v2:
  1. Collect Acked-by tags by Johannes. Thanks.
  2. Rework lruvec_holds_page_lru_lock() suggested by Johannes. Thanks.
  3. Fix move_pages_to_lru().

Muchun Song (18):
  mm: memcontrol: fix page charging in page replacement
  mm: memcontrol: bail out early when !mm in get_mem_cgroup_from_mm
  mm: memcontrol: remove the pgdata parameter of mem_cgroup_page_lruvec
  mm: memcontrol: simplify lruvec_holds_page_lru_lock
  mm: memcontrol: simplify the logic of objcg pinning memcg
  mm: memcontrol: move the objcg infrastructure out of CONFIG_MEMCG_KMEM
  mm: memcontrol: introduce compact_lock_page_lruvec_irqsave
  mm: memcontrol: make lruvec lock safe when the LRU pages reparented
  mm: vmscan: remove noinline_for_stack
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
 include/linux/memcontrol.h                     | 216 +++++----
 include/linux/mm_inline.h                      |   6 +
 mm/compaction.c                                |  40 +-
 mm/filemap.c                                   |   2 +-
 mm/huge_memory.c                               | 171 ++++++-
 mm/memcontrol.c                                | 622 ++++++++++++++++++-------
 mm/migrate.c                                   |   4 +
 mm/page-writeback.c                            |  24 +-
 mm/page_io.c                                   |   5 +-
 mm/rmap.c                                      |  14 +-
 mm/swap.c                                      |  48 +-
 mm/vmscan.c                                    |  58 ++-
 mm/workingset.c                                |   2 +-
 17 files changed, 841 insertions(+), 413 deletions(-)

-- 
2.11.0

