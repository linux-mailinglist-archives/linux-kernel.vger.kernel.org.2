Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D7844D0C2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 05:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbhKKESP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 23:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbhKKESE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 23:18:04 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3613AC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 20:15:16 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id r18-20020a25ac52000000b005c9047c420bso3147972ybd.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 20:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xKhEDBtcuFCb4X+97EUJQAyRfNf4gnCXH28mZzXM+EQ=;
        b=ZJ3Jl1XTf2OS9zl47jmgsMdeRFdPXRVLkY/Nv4wzwOiQWn3pi7+atsgGYgHhgnwjFV
         ZaI2GZ4otbHqLG922177kg+k9llnjXGsrXc47l20IvVeM+rR86zkpeOQlSGSw7K4BfDJ
         41pFlKu4Y9oRh2tZIetHC6CupNpToSvoGJYYLiFKfXlqWmwn0ULm+VNx1rUHW/phiRfy
         pu4reISIzVvdXYwcZGJqQnZhixh8Ynw42w8b8Yaflci8Ysk9oBL6E3T+/dYSWvxfA0Jk
         Gd0WxEdi4es0vmP8xeAxue6UueV8Se9cPwV7oVqdiIfRjMJCtCkTUpFZaw8B3pL5yEFH
         85Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xKhEDBtcuFCb4X+97EUJQAyRfNf4gnCXH28mZzXM+EQ=;
        b=MWwi8izZhNcw4diIFmOzsBsXTbmyawyZiAcKbUYaYYN14nGXQIgidqQSpyf1uDMZWy
         Cxn1Nsiu3YICp+2rE5kX1Acg27oMZ5c8QzA0JC+qHdGeyr72gpKu727vX4qL4SmLQ+4O
         bo/ss3wWeOUy+sJOrN3n7NZAiAqEw6Hkuu5wCW4Sb6ibMJgWfIhG0/N0jBmk3jV7AAck
         EBsuRUtFmGz+SbpnegJTwizlRc4BVEPxKPIDO+szkc5JipZG1noIEYCjXHMCv/JpB2+l
         tZmfn7QdEV22o2igay048CRIAHoIVR91r40KnIlFJ3oZwetda6E6geh6poA/B8BdHO/Z
         MIMg==
X-Gm-Message-State: AOAM5336KsGksXhWbfLUoXyLVl6J8u6ryMk/XHs2hX4lgD1wypBfYVfT
        BFdSW4d7Y+zsCeHp7z1qH02a2XjVnUc=
X-Google-Smtp-Source: ABdhPJzfrQuuz3fx20iNT8FwAsSbzbaBX0yIwvPkbkvldr8aSgysCUZfUohXAbAF83yED7fHVJWuMzHJreA=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:346b:bb72:659e:f91c])
 (user=yuzhao job=sendgmr) by 2002:a5b:d50:: with SMTP id f16mr4634533ybr.350.1636604115429;
 Wed, 10 Nov 2021 20:15:15 -0800 (PST)
Date:   Wed, 10 Nov 2021 21:15:00 -0700
Message-Id: <20211111041510.402534-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v5 00/10] Multigenerational LRU Framework
From:   Yu Zhao <yuzhao@google.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, page-reclaim@google.com,
        holger@applied-asynchrony.com, iam@valdikss.org.ru,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What's new in v5
================
1) Rebased to v5.15 per users' requests
2) Performance benchmark reports on the previous version:
   https://patchwork.kernel.org/project/linux-mm/cover/20210818063107.2696454-1-yuzhao@google.com/#24506153

TLDR
====
The current page reclaim is too expensive in terms of CPU usage and it
often makes poor choices about what to evict. This patchset offers an
alternative solution that is performant, versatile and
straightforward.

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

Yu Zhao (10):
  mm: x86, arm64: add arch_has_hw_pte_young()
  mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
  mm/vmscan.c: refactor shrink_node()
  mm: multigenerational lru: groundwork
  mm: multigenerational lru: mm_struct list
  mm: multigenerational lru: aging
  mm: multigenerational lru: eviction
  mm: multigenerational lru: user interface
  mm: multigenerational lru: Kconfig
  mm: multigenerational lru: documentation

 Documentation/vm/index.rst          |    1 +
 Documentation/vm/multigen_lru.rst   |  132 ++
 arch/Kconfig                        |    9 +
 arch/arm64/include/asm/cpufeature.h |    5 +
 arch/arm64/include/asm/pgtable.h    |   13 +-
 arch/arm64/kernel/cpufeature.c      |   10 +
 arch/arm64/tools/cpucaps            |    1 +
 arch/x86/Kconfig                    |    1 +
 arch/x86/include/asm/pgtable.h      |    9 +-
 arch/x86/mm/pgtable.c               |    5 +-
 fs/exec.c                           |    2 +
 fs/fuse/dev.c                       |    3 +-
 include/linux/cgroup.h              |   15 +-
 include/linux/memcontrol.h          |    7 +
 include/linux/mm.h                  |   36 +
 include/linux/mm_inline.h           |  198 ++
 include/linux/mm_types.h            |  106 ++
 include/linux/mmzone.h              |  175 ++
 include/linux/nodemask.h            |    1 +
 include/linux/oom.h                 |   16 +
 include/linux/page-flags-layout.h   |   19 +-
 include/linux/page-flags.h          |    4 +-
 include/linux/pgtable.h             |   17 +-
 include/linux/sched.h               |    3 +
 include/linux/swap.h                |    3 +
 kernel/bounds.c                     |    3 +
 kernel/cgroup/cgroup-internal.h     |    1 -
 kernel/exit.c                       |    1 +
 kernel/fork.c                       |   10 +
 kernel/kthread.c                    |    1 +
 kernel/sched/core.c                 |    2 +
 mm/Kconfig                          |   59 +
 mm/huge_memory.c                    |    3 +-
 mm/memcontrol.c                     |   31 +
 mm/memory.c                         |   21 +-
 mm/mm_init.c                        |    6 +-
 mm/oom_kill.c                       |    4 +-
 mm/page_alloc.c                     |    1 +
 mm/rmap.c                           |    8 +
 mm/swap.c                           |   51 +-
 mm/swapfile.c                       |    2 +
 mm/vmscan.c                         | 2697 ++++++++++++++++++++++++++-
 mm/workingset.c                     |  120 +-
 43 files changed, 3679 insertions(+), 133 deletions(-)
 create mode 100644 Documentation/vm/multigen_lru.rst

-- 
2.34.0.rc0.344.g81b53c2807-goog

