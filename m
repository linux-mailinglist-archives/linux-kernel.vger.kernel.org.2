Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F2A3665EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbhDUHBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbhDUHBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:01:48 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40E6C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:01:15 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id w6so13277686pfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pkSVS2YCjVQvqsgnImMuXupcbzBZpj2KtRtviCbjdFI=;
        b=fibkw8xQDhCYyY7TuSaQGDQfpVLcOo/wHEkWSbs7rC362g3qcRmkb6qA5cswEs9pzu
         UT0st8t5a4jzQOpQB3RwixyVhYqGGKXpZ5jr9eOnOj7Vwu8qQimiR735BH7ygzVZkdLX
         7UOVZih2pSB+eFrFo0G8tMmQ3ezLZmmb+OQ2duPoz0mag8K9ViiJCHW2pBk18oTZiasp
         nEvlokm+qeZo9d809wQDQS5qxKICS84mq41sxmy3Yl60u6ySeQxCBUzqRk4pncHewOLZ
         2laooZ7N299W4oEK4L3GURcpAIIXiiyDJVEMOMiPJLUY4gl+v1sR+eh9/ogjzpzazi1C
         YuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pkSVS2YCjVQvqsgnImMuXupcbzBZpj2KtRtviCbjdFI=;
        b=slFAf3laakgZydIELqQwgjkx80lNQQn5I+8QKLQe4UEJoshzuCVLCxeqFhplsCPyeg
         1Z3W3qjJR6JoQqHE0/VVxBZO5D5biCMm0BNgHw4PON+GHWVy2dVlIWKJbr+LcijrfYBV
         h7xoxcykKu9lQsHex7yB9kdLTg+t5c/bLBhzMfRVgpvQEIrci3gk5oSsK4QgceBh9uA6
         pwSMpLfjVdHfDkQGdv5G26RsNJJkZWf5tMBRcvEkNq6kP2RENj9fCDY1y4x8EZWcr5rD
         dECOjV8oxAIz9hcW6bvKqhAGehtd7Xa87nAxVtb5KNecAf3EkylLaojUTCONE05UfdtC
         CYxw==
X-Gm-Message-State: AOAM532zlWOH7c/eW9xTo/JgsYWzb4Q20Rh4mQ8azKYl6uZ5dtmafrGb
        p+FMDHPdnvXoJp21505ZMd7OiQ==
X-Google-Smtp-Source: ABdhPJxGDsvyIpyLQfQw6SW6VlR4eiF1JC+LcAxoZZaLSbZuuuay+GazHOtO2DyfuJIxRbE+49jVZg==
X-Received: by 2002:a63:db47:: with SMTP id x7mr11537072pgi.360.1618988475453;
        Wed, 21 Apr 2021 00:01:15 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id c4sm929842pfb.94.2021.04.21.00.01.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Apr 2021 00:01:14 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v3 00/12] Use obj_cgroup APIs to charge the LRU pages
Date:   Wed, 21 Apr 2021 15:00:47 +0800
Message-Id: <20210421070059.69361-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v3 based on the top of the series[1] (memcontrol code cleanup and
simplification). Roman is working on the generalization of obj_cgroup API.
But before that, hope someone can review this patches for correctness.

Since the following patchsets applied. All the kernel memory are charged
with the new APIs of obj_cgroup.

	[v17,00/19] The new cgroup slab memory controller[2]
	[v5,0/7] Use obj_cgroup APIs to charge kmem pages[3]

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

[1] https://lore.kernel.org/linux-mm/20210417043538.9793-1-songmuchun@bytedance.com/
[2] https://lore.kernel.org/linux-mm/20200623015846.1141975-1-guro@fb.com/
[3] https://lore.kernel.org/linux-mm/20210319163821.20704-1-songmuchun@bytedance.com/

Changlogs in RFC v3:
  1. Drop the code cleanup and simplification patches. Gather those patches
     into a separate series[1].
  2. Rework patch #1 suggested by Johannes.

Changlogs in RFC v2:
  1. Collect Acked-by tags by Johannes. Thanks.
  2. Rework lruvec_holds_page_lru_lock() suggested by Johannes. Thanks.
  3. Fix move_pages_to_lru().

Muchun Song (12):
  mm: memcontrol: move the objcg infrastructure out of CONFIG_MEMCG_KMEM
  mm: memcontrol: introduce compact_lock_page_lruvec_irqsave
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
 include/linux/memcontrol.h                     | 182 ++++----
 include/linux/mm_inline.h                      |   6 +
 mm/compaction.c                                |  36 +-
 mm/filemap.c                                   |   2 +-
 mm/huge_memory.c                               | 171 ++++++--
 mm/memcontrol.c                                | 562 ++++++++++++++++++-------
 mm/migrate.c                                   |   4 +
 mm/page-writeback.c                            |  24 +-
 mm/page_io.c                                   |   5 +-
 mm/rmap.c                                      |  14 +-
 mm/swap.c                                      |  46 +-
 mm/vmscan.c                                    |  56 ++-
 16 files changed, 795 insertions(+), 355 deletions(-)

-- 
2.11.0

