Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FB044D0F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 05:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbhKKETU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 23:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbhKKESS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 23:18:18 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364ABC06120D
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 20:15:30 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y125-20020a25dc83000000b005c2326bf744so7388045ybe.21
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 20:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AHZ3kmKPBbgSlKkx70Jkx/JJwoTNnQAirv7fs8MUZEQ=;
        b=nganR/HIY2g3DIBcYqJ+LlFlwq3OV6yutpYcQYkXRL95KSdDdNyxNMwvupYK5zzK66
         y1eF7QSfsl/c6NOsSKlX9qKoPA/6m/8vMrvDO4ia/DCpgjcUCyJ+AchTBFzFS8Yb66Ow
         Ic+5xp1xc1mmfv6bOVYMHwDpAAAnzy52bk4zoUim7/pcvGUD44AsmBoQd8kg/L0DC5I8
         lIFQuI16WV2idpisLAngW4KrBGX5R5bL8kw1CSOmjIOMP+jV7yh05Mmgo1v7WlrY6OKZ
         oWahiX1cBmEMIhEsC9UV8wbKrkZzx4IqqVRjoJVrUZdHMi1I5rsh7lUe7K6eE5W0hiW4
         x8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AHZ3kmKPBbgSlKkx70Jkx/JJwoTNnQAirv7fs8MUZEQ=;
        b=izCv3ON5EiG8XBxl+zmBsfnGXILz9GN+248Trfiz0Y4NPCw81VyL9WnQ4mELKwhvFm
         P+hBUAY5bKOVNIPfOzM1k2RtfniLidvpc6vLRsnMpThs1DycO8wuwQXP/pALjn1z0da0
         xWJGP9AA/58oPPM8eNXiMrLOAxpu5qIc1HsgpojuIiAVqNTukhmECEdk9lgP2cuZ3t12
         sCUU1MLkbs14TQT+ElZHpo4wGWW7jM/vLdc3Gezwrt0QapHHIDZNHq4AIIVAH8hrxhWr
         lLNg3SMxyYm9FKBKMbioidx08TdhE+/hOuK140XqWUI1vsQiZSIrzwZtmZnFlCNxEfR7
         m48g==
X-Gm-Message-State: AOAM5308BaCpHKnJvPYsKrX53bGtPlWAojNnaVLfJ8Vmp6E0N1yjfUgZ
        LoDLFsDaQ4W1vN0owvjgxJPh43bI9Vs=
X-Google-Smtp-Source: ABdhPJyXNJLT8J42rpeVmfDmzRMGA/ulyVZGawiW3JEdWBFrMupnAG+En3AbbsUg1S/yDZ4Vz2QO1wi5xeo=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:346b:bb72:659e:f91c])
 (user=yuzhao job=sendgmr) by 2002:a25:b790:: with SMTP id n16mr4887325ybh.395.1636604129429;
 Wed, 10 Nov 2021 20:15:29 -0800 (PST)
Date:   Wed, 10 Nov 2021 21:15:10 -0700
In-Reply-To: <20211111041510.402534-1-yuzhao@google.com>
Message-Id: <20211111041510.402534-11-yuzhao@google.com>
Mime-Version: 1.0
References: <20211111041510.402534-1-yuzhao@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v5 10/10] mm: multigenerational lru: documentation
From:   Yu Zhao <yuzhao@google.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, page-reclaim@google.com,
        holger@applied-asynchrony.com, iam@valdikss.org.ru,
        Yu Zhao <yuzhao@google.com>,
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
 Documentation/vm/multigen_lru.rst | 132 ++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)
 create mode 100644 Documentation/vm/multigen_lru.rst

diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
index b51f0d8992f8..779772a025a0 100644
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
index 000000000000..7c064a378b85
--- /dev/null
+++ b/Documentation/vm/multigen_lru.rst
@@ -0,0 +1,132 @@
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
+ [swappiness] [use_bloom_filter]`` to ``/sys/kernel/debug/lru_gen`` to
+ invoke the aging, which scans PTEs for accessed pages and then
+ creates the next generation ``max_gen+1``. A swap file and a non-zero
+ ``swappiness``, which overrides ``vm.swappiness``, are required to
+ scan PTEs mapping anon pages. Set ``use_bloom_filter`` to 0 to
+ override the default behavior which only scans PTE tables found
+ populated.
+
+:Proactive reclaim: Write ``- memcg_id node_id min_gen [swappiness]
+ [nr_to_reclaim]`` to ``/sys/kernel/debug/lru_gen`` to invoke the
+ eviction, which evicts generations less than or equal to ``min_gen``.
+ ``min_gen`` should be less than ``max_gen-1`` as ``max_gen`` and
+ ``max_gen-1`` are not fully aged and therefore cannot be evicted.
+ Use ``nr_to_reclaim`` to limit the number of pages to evict. Multiple
+ command lines are supported, so does concatenation with delimiters
+ ``,`` and ``;``.
+
+Framework
+=========
+For each ``lruvec``, evictable pages are divided into multiple
+generations. The youngest generation number is stored in
+``lrugen->max_seq`` for both anon and file types as they are aged on
+an equal footing. The oldest generation numbers are stored in
+``lrugen->min_seq[]`` separately for anon and file types as clean
+file pages can be evicted regardless of swap and writeback
+constraints. These three variables are monotonically increasing.
+Generation numbers are truncated into
+``order_base_2(CONFIG_NR_LRU_GENS+1)`` bits in order to fit into
+``page->flags``. The sliding window technique is used to prevent
+truncated generation numbers from overlapping. Each truncated
+generation number is an index to an array of per-type and per-zone
+lists ``lrugen->lists``.
+
+Each generation is divided into multiple tiers. Tiers represent
+different ranges of numbers of accesses from file descriptors only.
+Pages accessed ``N`` times via file descriptors belong to tier
+``order_base_2(N)``. Each generation contains at most
+``CONFIG_TIERS_PER_GEN`` tiers, and they require additional
+``CONFIG_TIERS_PER_GEN-2`` bits in ``page->flags``. In contrast to
+moving between generations which requires list operations, moving
+between tiers only involves operations on ``page->flags`` and
+therefore has a negligible cost. A feedback loop modeled after the PID
+controller monitors refaulted % across all tiers and decides when to
+protect pages from which tiers.
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
+aging is due when ``min_seq[]`` reaches ``max_seq-1``.
+
+Eviction
+--------
+The eviction consumes old generations. Given an ``lruvec``, the
+eviction scans pages on the per-zone lists indexed by anon and file
+``min_seq[]`` (modulo ``CONFIG_NR_LRU_GENS``). It first tries to
+select a type based on the values of ``min_seq[]``. If they are
+equal, it selects the type that has a lower refaulted %. The eviction
+sorts a page according to its updated generation number if the aging
+has found this page accessed. It also moves a page to the next
+generation if this page is from an upper tier that has a higher
+refaulted % than the base tier. The eviction increments ``min_seq[]``
+of a selected type when it finds all the per-zone lists indexed by
+``min_seq[]`` of this selected type are empty.
+
+To-do List
+==========
+KVM Optimization
+----------------
+Support shadow page table walk.
-- 
2.34.0.rc0.344.g81b53c2807-goog

