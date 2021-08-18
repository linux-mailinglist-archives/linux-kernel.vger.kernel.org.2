Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E42D3EFCD5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 08:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbhHRGce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 02:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239410AbhHRGcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 02:32:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35245C0612E7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 23:31:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s4-20020a259004000000b005947575ac53so1861517ybl.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 23:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EuYCgt8+lkHBd5kOQmKG+gfowm77wjwHGDYaQfqgXkM=;
        b=jf1KXu7fmEUdMsKv8qqPS1uXlv+56ikFPzF13yc3+KTvUt6asr/dfm42U7m8z2oaxW
         A1lZnhfuZsNz6idvEFIx7MwSYBYmByXzQK4ED92Tl/aOYre4fO0pStwZP5hfQyZoLhpA
         k9RuTVA9AcmArHPO54uF/Ki4EABqeALUSuj9BtbZVk/q1wrblw+DakX+xFVyH0ZPllpN
         QRr9BLXmVbCFxjf9LCMyU2/3AuDTtwNHaELFoGy21fgiwitZOhlfWs7IBfT24zSAzv5z
         gcDc1UyinDFGNwilfZtrE/BXLAPyfDw73xKZU00G6uLKrvxEGHYLjgWMad1/KSypqjGn
         s8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EuYCgt8+lkHBd5kOQmKG+gfowm77wjwHGDYaQfqgXkM=;
        b=pPgXjgH5fT7E9Q0DERuqan9Sr+xKavdAEM0ci54WvUeOwzcJomqIY/HdOh1ATzDnBT
         EZyhFKm+eNdK/mLGMLIg9JmwcccjU0ABKfwmvVMERlX9rgWlgO2C/B93rKwyBjtt3GoN
         UxH3ym0tXbSc8nbsIEMK/T/U42Q+12EbiDF/iXo9x1JsMuov0vE5gZGcVE3DCtjLbUr8
         /kWvJlCNcuHbd7CT8RTrcXsafVV3kKPlyTpiv+E9xLleQX3UTR0DIRcpxErW5CPfJzX3
         x8rAvdZuyjHjsmJS5RWTtMPyixbtfofWQ3WLoVDsdLI72kdTXugqhs0Xsjk/FEs8lNIw
         DmWg==
X-Gm-Message-State: AOAM5323fFg6FKWefPwsdIBlJDRgDTQOoAwneDX8QljMq1HB3/tILeVS
        HtrIUYREIjS8nObJdlzFvDko9hPUn4s=
X-Google-Smtp-Source: ABdhPJyHuC5mbVB/nEzN5pzEvd35CiT+uZVTZdGa9/B0v3WwM0r7rwsMuOQ4SlTfuOuU4UXhfMr9DYHhRjw=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:41f0:f89:87cd:8bd0])
 (user=yuzhao job=sendgmr) by 2002:a25:f310:: with SMTP id c16mr8599656ybs.464.1629268286452;
 Tue, 17 Aug 2021 23:31:26 -0700 (PDT)
Date:   Wed, 18 Aug 2021 00:31:07 -0600
In-Reply-To: <20210818063107.2696454-1-yuzhao@google.com>
Message-Id: <20210818063107.2696454-12-yuzhao@google.com>
Mime-Version: 1.0
References: <20210818063107.2696454-1-yuzhao@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v4 11/11] mm: multigenerational lru: documentation
From:   Yu Zhao <yuzhao@google.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
        page-reclaim@google.com, Yu Zhao <yuzhao@google.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Documentation/vm/multigen_lru.rst.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
---
 Documentation/vm/index.rst        |   1 +
 Documentation/vm/multigen_lru.rst | 134 ++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+)
 create mode 100644 Documentation/vm/multigen_lru.rst

diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
index eff5fbd492d0..c353b3f55924 100644
--- a/Documentation/vm/index.rst
+++ b/Documentation/vm/index.rst
@@ -17,6 +17,7 @@ various features of the Linux memory management
 
    swap_numa
    zswap
+   multigen_lru
 
 Kernel developers MM documentation
 ==================================
diff --git a/Documentation/vm/multigen_lru.rst b/Documentation/vm/multigen_lru.rst
new file mode 100644
index 000000000000..adedff5319d9
--- /dev/null
+++ b/Documentation/vm/multigen_lru.rst
@@ -0,0 +1,134 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Multigenerational LRU
+=====================
+
+Quick Start
+===========
+Build Configurations
+--------------------
+:Required: Set ``CONFIG_LRU_GEN=y``.
+
+:Optional: Set ``CONFIG_LRU_GEN_ENABLED=y`` to turn the feature on by
+ default.
+
+Runtime Configurations
+----------------------
+:Required: Write ``1`` to ``/sys/kernel/mm/lru_gen/enable`` if the
+ feature was not turned on by default.
+
+:Optional: Write ``N`` to ``/sys/kernel/mm/lru_gen/min_ttl_ms`` to
+ protect the working set of ``N`` milliseconds. The OOM killer is
+ invoked if this working set cannot be kept in memory.
+
+:Optional: Read ``/sys/kernel/debug/lru_gen`` to confirm the feature
+ is turned on. This file has the following output:
+
+::
+
+  memcg  memcg_id  memcg_path
+    node  node_id
+      min_gen  birth_time  anon_size  file_size
+      ...
+      max_gen  birth_time  anon_size  file_size
+
+``min_gen`` is the oldest generation number and ``max_gen`` is the
+youngest generation number. ``birth_time`` is in milliseconds.
+``anon_size`` and ``file_size`` are in pages.
+
+Phones/Laptops/Workstations
+---------------------------
+No additional configurations required.
+
+Servers/Data Centers
+--------------------
+:To support more generations: Change ``CONFIG_NR_LRU_GENS`` to a
+ larger number.
+
+:To support more tiers: Change ``CONFIG_TIERS_PER_GEN`` to a larger
+ number.
+
+:To support full stats: Set ``CONFIG_LRU_GEN_STATS=y``.
+
+:Working set estimation: Write ``+ memcg_id node_id max_gen
+ [swappiness]`` to ``/sys/kernel/debug/lru_gen`` to invoke the aging,
+ which scans PTEs for accessed pages and then creates the next
+ generation ``max_gen+1``. A swap file and a non-zero ``swappiness``,
+ which overrides ``vm.swappiness``, are required to scan PTEs mapping
+ anon pages.
+
+:Proactive reclaim: Write ``- memcg_id node_id min_gen [swappiness]
+ [nr_to_reclaim]`` to ``/sys/kernel/debug/lru_gen`` to invoke the
+ eviction, which evicts generations less than or equal to ``min_gen``.
+ ``min_gen`` should be less than ``max_gen-1`` as ``max_gen`` and
+ ``max_gen-1`` are not fully aged and therefore cannot be evicted.
+ ``nr_to_reclaim`` can be used to limit the number of pages to evict.
+ Multiple command lines are supported, so does concatenation with
+ delimiters ``,`` and ``;``.
+
+Framework
+=========
+For each ``lruvec``, evictable pages are divided into multiple
+generations. The youngest generation number is stored in
+``lrugen->max_seq`` for both anon and file types as they are aged on
+an equal footing. The oldest generation numbers are stored in
+``lrugen->min_seq[2]`` separately for anon and file types as clean
+file pages can be evicted regardless of swap and writeback
+constraints. These three variables are monotonically increasing.
+Generation numbers are truncated into
+``order_base_2(CONFIG_NR_LRU_GENS+1)`` bits in order to fit into
+``page->flags``. The sliding window technique is used to prevent
+truncated generation numbers from overlapping. Each truncated
+generation number is an index to an array of per-type and per-zone
+lists ``lrugen->lists``.
+
+Each generation is then divided into multiple tiers. Tiers represent
+levels of usage from file descriptors only. Pages accessed ``N`` times
+via file descriptors belong to tier ``order_base_2(N)``. Each
+generation contains at most ``CONFIG_TIERS_PER_GEN`` tiers, and they
+require additional ``CONFIG_TIERS_PER_GEN-2`` bits in ``page->flags``.
+In contrast to moving across generations which requires list
+operations, moving across tiers only involves operations on
+``page->flags`` and therefore has a negligible cost. A feedback loop
+modeled after the PID controller monitors refault rates of all tiers
+and decides when to protect pages from which tiers.
+
+The framework comprises two conceptually independent components: the
+aging and the eviction, which can be invoked separately from user
+space for the purpose of working set estimation and proactive reclaim.
+
+Aging
+-----
+The aging produces young generations. Given an ``lruvec``, the aging
+traverses ``lruvec_memcg()->mm_list`` and calls ``walk_page_range()``
+to scan PTEs for accessed pages (a ``mm_struct`` list is maintained
+for each ``memcg``). Upon finding one, the aging updates its
+generation number to ``max_seq`` (modulo ``CONFIG_NR_LRU_GENS``).
+After each round of traversal, the aging increments ``max_seq``. The
+aging is due when both ``min_seq[2]`` have caught up with
+``max_seq-1``.
+
+Eviction
+--------
+The eviction consumes old generations. Given an ``lruvec``, the
+eviction scans pages on the per-zone lists indexed by anon and file
+``min_seq[2]`` (modulo ``CONFIG_NR_LRU_GENS``). It first tries to
+select a type based on the values of ``min_seq[2]``. If they are
+equal, it selects the type that has a lower refault rate. The eviction
+sorts a page according to its updated generation number if the aging
+has found this page accessed. It also moves a page to the next
+generation if this page is from an upper tier that has a higher
+refault rate than the base tier. The eviction increments
+``min_seq[2]`` of a selected type when it finds all the per-zone lists
+indexed by ``min_seq[2]`` of this selected type are empty.
+
+To-do List
+==========
+KVM Optimization
+----------------
+Support shadow page table walk.
+
+NUMA Optimization
+-----------------
+Optimize page table walk for NUMA.
-- 
2.33.0.rc1.237.g0d66db33f3-goog

