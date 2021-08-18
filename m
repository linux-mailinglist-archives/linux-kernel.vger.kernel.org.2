Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EC53EFCCA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 08:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbhHRGbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 02:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238341AbhHRGbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 02:31:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC115C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 23:31:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x5-20020a0569020505b0290592c25b8c59so1774042ybs.18
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 23:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jtTrh/UFwWabV4XfsSZ0FACu0kGSYP9nGWGkTFTHlsw=;
        b=rYMUo64dR6ahM+BcSE0/y1k3cjhl/5uCjAdrngLJav3ieUZRIPNvjzEC/JPbQJsVdx
         isCKE1M5/TKt/ijSDwZaFzySv9g5EECHN0FYdjVMAOc6Q1qKZtvZlDFISn5MeJK880ov
         w6szD7HnCkM1GmFce2xq+1I02A0NBcXDMbTuGfB2WR9IuUXIXpsVwGuog9ZNVu80funt
         FD3shkUAfI1VdDhaXh2nDa8NRzPk4GOkk5pmKbXIyIYvl0/RHnIRLXo8iDfr03SCfNgQ
         l2IYUfrgs4OwKbq5vqlHqK8nXpUFO4VO//4X0fBklHNDVJNSOCIA/kKRJK1BHM5jr/j6
         UNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jtTrh/UFwWabV4XfsSZ0FACu0kGSYP9nGWGkTFTHlsw=;
        b=NvOQKl757BA/LNJS4By70mErUhSBm/qGMHZcv+M0fmIiwW0eTsS+zdnpkNWYHCGTaM
         WmF+VghWYGGi5kGtrH6viSxtEtgeYAHxhv87zCJXrdbWER/w1wnqL7pWAH292tYintJG
         etDLKvmgepKI9ecXzW6v8j/acCRcEZmP6zK2aMjOsizyIh0GbU9zuKEeScQQpciT7dCv
         kpnQ9jcNWbf8fShSrEwL3dda2r2FHSNCcL1GxRgz8AbWEJ8Bm7N+TTpJkZzpEWSEXJMz
         tavJUUENL/0C5hBnLwOwzWYN9LhjlnaUJqhzJEKhrgu8zSM+ME3zWc90s1wNg/oLclcK
         FrYA==
X-Gm-Message-State: AOAM530ftR9ZDZ+DhxNSHnGjQxD5tBlBI1OAWUz6QfWSiiasq2wLbwnC
        t3ZvSUTRYhTGEo53KOfEcs4L9wpF4a4=
X-Google-Smtp-Source: ABdhPJyxCeX40u4a2F0inY4Yj1kn9U/GlGZUnkBuaHkcHk0ZzESRu/sq8kWmfTp0nQueYC9cliFCb4vXIYI=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:41f0:f89:87cd:8bd0])
 (user=yuzhao job=sendgmr) by 2002:a25:7cc3:: with SMTP id x186mr9070752ybc.227.1629268270995;
 Tue, 17 Aug 2021 23:31:10 -0700 (PDT)
Date:   Wed, 18 Aug 2021 00:30:56 -0600
Message-Id: <20210818063107.2696454-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v4 00/11] Multigenerational LRU Framework
From:   Yu Zhao <yuzhao@google.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
        page-reclaim@google.com, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TLDR
====
The current page reclaim is too expensive in terms of CPU usage and it
often makes poor choices about what to evict. This patchset offers an
alternative solution that is performant, versatile and
straightforward.

Repo
====
git fetch https://linux-mm.googlesource.com/page-reclaim refs/changes/81/1281/1

Problems
========
Active/inactive
---------------
Data centers need to predict whether a job can successfully land on a
machine without actually impacting the existing jobs. The granularity
of the active/inactive is too coarse to be useful for job schedulers
to make such decisions. In addition, data centers need to monitor
their memory utilization for horizontal scaling. The active/inactive
are relative terms and therefore cannot give any insight into a pool
of machines, e.g., aggregating the active/inactive across multiple
machines without a common frame of reference yields no meaningful
results.

Phones and laptops need to make good choices about what to evict
because they are more sensitive to major faults and power consumption.
Major faults can cause janks, i.e., slow UI renderings, and negatively
impact user experience. The selection between anon and file types has
been suboptimal because it is difficult to compare the access patterns
of the two types. On phones and laptops, executable pages are
frequently evicted despite the fact that there are many less
frequently used anon pages. Conversely, on workstations building large
projects, anon pages are sometimes swapped out while there are many
less recently used file pages.

Fundamentally, the notion of active/inactive has very limited ability
to measure temporal locality.

Rmap walk
---------
Traversing a list of pages and searching the rmap for PTEs mapping
each page can be very expensive because those pages are likely to be
unrelated. For workloads using a high percentage of anon memory, the
rmap becomes a bottleneck in page reclaim. For example, kswapd can
easily spend more CPU time in the rmap than in anything else on
laptops running Chrome. And the kernel can spend more CPU time in the
rmap than in any other functions on servers that heavily overcommit
anon memory.

Simply put, it does not take advantage of spatial locality when using
the rmap to test the accessed bit over a large number of pages.

Solutions
=========
Generations
-----------
This solution introduces a temporal dimension. Each generation is a
dot on the timeline and its population includes all mapped pages that
have been accessed since the birth of this generation.

All eviction choices are made based on generation numbers, which are
simple and yet effective. A large number of pages can be spread out
across many generations. Since each generation is timestamped at
birth, its population is aggregatable across different machines. This
is especially useful for data centers that require working set
estimation and proactive reclaim.

Page table walk
---------------
Each walk traverses an mm_struct list to scan PTEs for accessed pages
only. Processes that have been sleeping since the last walk are
skipped. The cost of this solution is roughly proportional to the
number of accessed pages. Since page tables usually have good spatial
locality for workloads using a high percentage of anon memory, the end
result is generally a significant reduction in kswapd CPU usage.

Note that page table walks are conditional and therefore do not
replace the rmap. For workloads that have sparse mappings, this
solution falls back to the rmap.

Use cases
=========
Page cache overcommit
---------------------
Tiers within each generation are specifically designed to improve the
performance of page cache under memory pressure. The fio/io_uring
benchmark shows 14% increase in IOPS for buffered I/O.

Without this patchset, the profile of fio/io_uring looks like:
  12.03%  __page_cache_alloc
   6.53%  shrink_active_list
   2.53%  mark_page_accessed

With this patchset, it looks like:
   9.45%  __page_cache_alloc
   0.52%  mark_page_accessed

Essentially, the idea of tiers is a feedback loop based on trial and
error. Instead of unconditionally moving file pages to the active list
upon the second access, this solution monitors refaults and
conditionally protects file pages with outlying refaults.

Anon memory overcommit
----------------------
Our real-world benchmark that browses popular websites in multiple
Chrome tabs demonstrates 51% less CPU usage from kswapd and 52% (full)
less PSI.

Without this patchset, the profile of kswapd looks like:
  31.03%  page_vma_mapped_walk
  25.59%  lzo1x_1_do_compress
   4.63%  do_raw_spin_lock
   3.89%  vma_interval_tree_iter_next
   3.33%  vma_interval_tree_subtree_search

With this patchset, it looks like:
  49.36%  lzo1x_1_do_compress
   4.54%  page_vma_mapped_walk
   4.45%  memset_erms
   3.47%  walk_pte_range
   2.88%  zram_bvec_rw

In addition, direct reclaim latency is reduced by 22% at 99th
percentile and the number of refaults is reduced by 7%. Both metrics
are important to phones and laptops as they are highly correlated to
user experience.

Working set estimation
----------------------
Userspace can invoke the aging by writing "+ memcg_id node_id max_gen
[swappiness]" to /sys/kernel/debug/lru_gen. Reading this debugfs
interface returns the birth time and the population of each
generation.

Given a pool of machines, by periodically invoking the aging, a job
scheduler is able to rank these machines based on the sizes of their
working sets and in turn selects the most ideal ones to land new jobs.

Proactive reclaim
-----------------
Userspace can invoke the eviction by writing "- memcg_id node_id
min_gen [swappiness] [nr_to_reclaim]" to /sys/kernel/debug/lru_gen.
Multiple command lines are supported, as is concatenation with
delimiters "," and ";".

A typical use case is that a job scheduler invokes the eviction in
anticipation of new jobs. The savings from proactive reclaim can
provide certain SLA to landing these new jobs.

Yu Zhao (11):
  mm: x86, arm64: add arch_has_hw_pte_young()
  mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
  mm/vmscan.c: refactor shrink_node()
  mm: multigenerational lru: groundwork
  mm: multigenerational lru: protection
  mm: multigenerational lru: mm_struct list
  mm: multigenerational lru: aging
  mm: multigenerational lru: eviction
  mm: multigenerational lru: user interface
  mm: multigenerational lru: Kconfig
  mm: multigenerational lru: documentation

 Documentation/vm/index.rst          |    1 +
 Documentation/vm/multigen_lru.rst   |  134 ++
 arch/Kconfig                        |    9 +
 arch/arm64/include/asm/cpufeature.h |   19 +-
 arch/arm64/include/asm/pgtable.h    |   10 +-
 arch/arm64/kernel/cpufeature.c      |   19 +
 arch/arm64/mm/proc.S                |   12 -
 arch/arm64/tools/cpucaps            |    1 +
 arch/x86/Kconfig                    |    1 +
 arch/x86/include/asm/pgtable.h      |    9 +-
 arch/x86/mm/pgtable.c               |    5 +-
 fs/exec.c                           |    2 +
 fs/fuse/dev.c                       |    3 +-
 include/linux/cgroup.h              |   15 +-
 include/linux/memcontrol.h          |    9 +
 include/linux/mm.h                  |   34 +
 include/linux/mm_inline.h           |  201 ++
 include/linux/mm_types.h            |  107 ++
 include/linux/mmzone.h              |  103 ++
 include/linux/nodemask.h            |    1 +
 include/linux/oom.h                 |   16 +
 include/linux/page-flags-layout.h   |   19 +-
 include/linux/page-flags.h          |    4 +-
 include/linux/pgtable.h             |   16 +-
 include/linux/sched.h               |    3 +
 include/linux/swap.h                |    1 +
 kernel/bounds.c                     |    3 +
 kernel/cgroup/cgroup-internal.h     |    1 -
 kernel/exit.c                       |    1 +
 kernel/fork.c                       |   10 +
 kernel/kthread.c                    |    1 +
 kernel/sched/core.c                 |    2 +
 mm/Kconfig                          |   59 +
 mm/huge_memory.c                    |    3 +-
 mm/memcontrol.c                     |   28 +
 mm/memory.c                         |   21 +-
 mm/mm_init.c                        |    6 +-
 mm/mmzone.c                         |    2 +
 mm/oom_kill.c                       |    4 +-
 mm/rmap.c                           |    7 +
 mm/swap.c                           |   55 +-
 mm/swapfile.c                       |    2 +
 mm/vmscan.c                         | 2674 ++++++++++++++++++++++++++-
 mm/workingset.c                     |  119 +-
 44 files changed, 3591 insertions(+), 161 deletions(-)
 create mode 100644 Documentation/vm/multigen_lru.rst

-- 
2.33.0.rc1.237.g0d66db33f3-goog

