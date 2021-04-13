Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640E035D84E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 08:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244795AbhDMG5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237169AbhDMG5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:57:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B6BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:56:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h69so10696954ybg.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 23:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=klNSQMhN/fNKSPy7OxOe+TknQ+B2nik9dsHKfikodIA=;
        b=u3vCeX3BYF1asDzX+tLIbfUN5H/VeA5xc9x7LCTIoEdyEIthwhu4wHQbjZUYVLsfuc
         fE31WJAhLOA9kUn2p4ErE5e3jMAc/CJ3TSFMj0eax0nlXyDr/bexss1f8DF3VhyvDR7Y
         Am0UY1U0XUBDzqCqrjXnS15KXD74u5vQZ8sKAFn49jB+diiZ1f+tOmsxY7PBanBc2hc3
         BBKG5gE4USB9hCtFXggXu0XbM7vixFFRpn+JAFs/g0yTaB4OAFUcjXr08osbsBVhwEbT
         E4RMvimAbxu6rM1mztY2JecUsu9aQyZMWtDSyYJqvbkLk49hj3hvoVhWeUcdPcgiyRY7
         eNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=klNSQMhN/fNKSPy7OxOe+TknQ+B2nik9dsHKfikodIA=;
        b=BUSKbu0+8k+ImcVxuoJlGU/Z6rdKB1psgNWCPvezZVPv1GUpzXQ/K3QIEdGjeJAUK7
         W8LyBRoEUxec9Y3JuhXaKWruuw+P2mm1Mtbt2wZDQM9lVCHy15hJOyyhyXYtNMOhu0Fq
         QFxV/hLS+IzaJ6Row0X4yil2c5J+jkIp9YRPwt7DYS70uW5SjnBRBx8BiGOe+pzlnovp
         s2AbjTgRXG+ToVuJUhe9l8Kercr9/agDITU/2/aixgaIU9w1WjTnj1/9XpZ0KtpfTEJz
         OZSX88wgeJl8dF66QHt70QDM7khrZ7/0qPTNt1yl7R56z1tO8oZFaHwdqxjGzmCWrPPE
         zQ1g==
X-Gm-Message-State: AOAM533Es6pJO+zpMvgQz1G5MVq3o+iC+OMZZJ04BTmVKSCRSCWzPciY
        4Gxx0hS4DGpgI66BGADE8rBze0altWg=
X-Google-Smtp-Source: ABdhPJwxruiti4er28fzxRPoebD7c9ea4kVwGgdAvQLjBxu+ZtoMy9cSAwqUp1KHdo7ndQ1Chm+0tgKtw3c=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:d02d:cccc:9ebe:9fe9])
 (user=yuzhao job=sendgmr) by 2002:a25:8884:: with SMTP id d4mr8943691ybl.410.1618297000592;
 Mon, 12 Apr 2021 23:56:40 -0700 (PDT)
Date:   Tue, 13 Apr 2021 00:56:17 -0600
Message-Id: <20210413065633.2782273-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v2 00/16] Multigenerational LRU Framework
From:   Yu Zhao <yuzhao@google.com>
To:     linux-mm@kvack.org
Cc:     Alex Shi <alexs@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Manes <ben.manes@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michael Larabel <michael@michaellarabel.com>,
        Michal Hocko <mhocko@suse.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Rong Chen <rong.a.chen@intel.com>,
        SeongJae Park <sjpark@amazon.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org,
        page-reclaim@google.com, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What's new in v2
================
Special thanks to Jens Axboe for reporting a regression in buffered
I/O and helping test the fix.

This version includes the support of tiers, which represent levels of
usage from file descriptors only. Pages accessed N times via file
descriptors belong to tier order_base_2(N). Each generation contains
at most MAX_NR_TIERS tiers, and they require additional MAX_NR_TIERS-2
bits in page->flags. In contrast to moving across generations which
requires the lru lock, moving across tiers only involves an atomic
operation on page->flags and therefore has a negligible cost. A
feedback loop modeled after the well-known PID controller monitors the
refault rates across all tiers and decides when to activate pages from
which tiers, on the reclaim path.

This feedback model has a few advantages over the current feedforward
model:
1) It has a negligible overhead in the buffered I/O access path
   because activations are done in the reclaim path.
2) It takes mapped pages into account and avoids overprotecting pages
   accessed multiple times via file descriptors.
3) More tiers offer better protection to pages accessed more than
   twice when buffered-I/O-intensive workloads are under memory
   pressure.

The fio/io_uring benchmark shows 14% improvement in IOPS when randomly
accessing Samsung PM981a in the buffered I/O mode.

Highlights from the discussions on v1
=====================================
Thanks to Ying Huang and Dave Hansen for the comments and suggestions
on page table scanning.

A simple worst-case scenario test did not find page table scanning
underperforms the rmap because of the following optimizations:
1) It will not scan page tables from processes that have been sleeping
   since the last scan.
2) It will not scan PTE tables under non-leaf PMD entries that do not
   have the accessed bit set, when
   CONFIG_HAVE_ARCH_PARENT_PMD_YOUNG=y.
3) It will not zigzag between the PGD table and the same PMD or PTE
   table spanning multiple VMAs. In other words, it finishes all the
   VMAs with the range of the same PMD or PTE table before it returns
   to the PGD table. This optimizes workloads that have large numbers
   of tiny VMAs, especially when CONFIG_PGTABLE_LEVELS=5.

TLDR
====
The current page reclaim is too expensive in terms of CPU usage and
often making poor choices about what to evict. We would like to offer
an alternative framework that is performant, versatile and
straightforward.

Repo
====
git fetch https://linux-mm.googlesource.com/page-reclaim refs/changes/73/1173/1

Gerrit https://linux-mm-review.googlesource.com/c/page-reclaim/+/1173

Background
==========
DRAM is a major factor in total cost of ownership, and improving
memory overcommit brings a high return on investment. Over the past
decade of research and experimentation in memory overcommit, we
observed a distinct trend across millions of servers and clients: the
size of page cache has been decreasing because of the growing
popularity of cloud storage. Nowadays anon pages account for more than
90% of our memory consumption and page cache contains mostly
executable pages.

Problems
========
Notion of active/inactive
-------------------------
For servers equipped with hundreds of gigabytes of memory, the
granularity of the active/inactive is too coarse to be useful for job
scheduling. False active/inactive rates are relatively high, and thus
the assumed savings may not materialize.

For phones and laptops, executable pages are frequently evicted
despite the fact that there are many less recently used anon pages.
Major faults on executable pages cause "janks" (slow UI renderings)
and negatively impact user experience.

For lruvecs from different memcgs or nodes, comparisons are impossible
due to the lack of a common frame of reference.

Incremental scans via rmap
--------------------------
Each incremental scan picks up at where the last scan left off and
stops after it has found a handful of unreferenced pages. For
workloads using a large amount of anon memory, incremental scans lose
the advantage under sustained memory pressure due to high ratios of
the number of scanned pages to the number of reclaimed pages. In our
case, the average ratio of pgscan to pgsteal is above 7.

On top of that, the rmap has poor memory locality due to its complex
data structures. The combined effects typically result in a high
amount of CPU usage in the reclaim path. For example, with zram, a
typical kswapd profile on v5.11 looks like:
  31.03%  page_vma_mapped_walk
  25.59%  lzo1x_1_do_compress
   4.63%  do_raw_spin_lock
   3.89%  vma_interval_tree_iter_next
   3.33%  vma_interval_tree_subtree_search

And with real swap, it looks like:
  45.16%  page_vma_mapped_walk
   7.61%  do_raw_spin_lock
   5.69%  vma_interval_tree_iter_next
   4.91%  vma_interval_tree_subtree_search
   3.71%  page_referenced_one

Solutions
=========
Notion of generation numbers
----------------------------
The notion of generation numbers introduces a quantitative approach to
memory overcommit. A larger number of pages can be spread out across
a configurable number of generations, and each generation includes all
pages that have been referenced since the last generation. This
improved granularity yields relatively low false active/inactive
rates.

Given an lruvec, scans of anon and file types and selections between
them are all based on direct comparisons of generation numbers, which
are simple and yet effective. For different lruvecs, comparisons are
still possible based on birth times of generations.

Differential scans via page tables
----------------------------------
Each differential scan discovers all pages that have been referenced
since the last scan. Specifically, it walks the mm_struct list
associated with an lruvec to scan page tables of processes that have
been scheduled since the last scan. The cost of each differential scan
is roughly proportional to the number of referenced pages it
discovers. Unless address spaces are extremely sparse, page tables
usually have better memory locality than the rmap. The end result is
generally a significant reduction in CPU usage, for workloads using a
large amount of anon memory.

Our real-world benchmark that browses popular websites in multiple
Chrome tabs demonstrates 51% less CPU usage from kswapd and 52% (full)
less PSI on v5.11. With this patchset, kswapd profile looks like:
  49.36%  lzo1x_1_do_compress
   4.54%  page_vma_mapped_walk
   4.45%  memset_erms
   3.47%  walk_pte_range
   2.88%  zram_bvec_rw

In addition, direct reclaim latency is reduced by 22% at 99th
percentile and the number of refaults is reduced by 7%. Both metrics
are important to phones and laptops as they are correlated to user
experience.

Framework
=========
For each lruvec, evictable pages are divided into multiple
generations. The youngest generation number is stored in
lruvec->evictable.max_seq for both anon and file types as they are
aged on an equal footing. The oldest generation numbers are stored in
lruvec->evictable.min_seq[2] separately for anon and file types as
clean file pages can be evicted regardless of may_swap or
may_writepage. Generation numbers are truncated into
order_base_2(MAX_NR_GENS+1) bits in order to fit into page->flags. The
sliding window technique is used to prevent truncated generation
numbers from overlapping. Each truncated generation number is an inde
to lruvec->evictable.lists[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES].
Evictable pages are added to the per-zone lists indexed by max_seq or
min_seq[2] (modulo MAX_NR_GENS), depending on whether they are being
faulted in.

Each generation is then divided into multiple tiers. Tiers represent
levels of usage from file descriptors only. Pages accessed N times via
file descriptors belong to tier order_base_2(N). In contrast to moving
across generations which requires the lru lock, moving across tiers
only involves an atomic operation on page->flags and therefore has a
lower cost. A feedback loop modeled after the well-known PID
controller monitors the refault rates across all tiers and decides
when to activate pages from which tiers on the reclaim path.

The framework comprises two conceptually independent components: the
aging and the eviction, which can be invoked separately from user
space.

Aging
-----
The aging produces young generations. Given an lruvec, the aging scans
page tables for referenced pages of this lruvec. Upon finding one, the
aging updates its generation number to max_seq. After each round of
scan, the aging increments max_seq.

The aging maintains either a system-wide mm_struct list or per-memcg
mm_struct lists and tracks whether an mm_struct is being used or has
been used since the last scan. Multiple threads can concurrently work
on the same mm_struct list, and each of them will be given a different
mm_struct belonging to a process that has been scheduled since the
last scan.

The aging is due when both of min_seq[2] reaches max_seq-1, assuming
both anon and file types are reclaimable.

Eviction
--------
The eviction consumes old generations. Given an lruvec, the eviction
scans the pages on the per-zone lists indexed by either of min_seq[2].
It first tries to select a type based on the values of min_seq[2].
When anon and file types are both available from the same generation,
it selects the one that has a lower refault rate.

During a scan, the eviction sorts pages according to their generation
numbers, if the aging has found them referenced. It also moves pages
from the tiers that have higher refault rates than tier 0 to the next
generation.

When it finds all the per-zone lists of a selected type are empty, the
eviction increments min_seq[2] indexed by this selected type.

Use cases
=========
On Android, our most advanced simulation that generates memory
pressure from realistic user behavior shows 18% fewer low-memory
kills, which in turn reduces cold starts by 16%.

On Borg, a similar approach enables us to identify jobs that
underutilize their memory and downsize them considerably without
compromising any of our service level indicators.

On Chrome OS, our field telemetry reports 96% fewer low-memory tab
discards and 59% fewer OOM kills from fully-utilized devices and no
regressions in monitored user experience from underutilized devices.

Working set estimation
----------------------
User space can invoke the aging by writing "+ memcg_id node_id gen
[swappiness]" to /sys/kernel/debug/lru_gen. This debugfs interface
also provides the birth time and the size of each generation.

Proactive reclaim
-----------------
User space can invoke the eviction by writing "- memcg_id node_id gen
[swappiness] [nr_to_reclaim]" to /sys/kernel/debug/lru_gen. Multiple
command lines are supported, so does concatenation with delimiters.

Intensive buffered I/O
----------------------
Tiers are specifically designed to improve the performance of
intensive buffered I/O under memory pressure. The fio/io_uring
benchmark shows 14% improvement in IOPS when randomly accessing
Samsung PM981a in buffered I/O mode.

For far memory tiering and NUMA-aware job scheduling, please refer to
the reference section.

FAQ
===
Why not try to improve the existing code?
-----------------------------------------
We have tried but concluded the aforementioned problems are
fundamental, and therefore changes made on top of them will not result
in substantial gains.

What particular workloads does it help?
---------------------------------------
This framework is designed to improve the performance of the page
reclaim under any types of workloads.

How would it benefit the community?
-----------------------------------
Google is committed to promoting sustainable development of the
community. We hope successful adoptions of this framework will
steadily climb over time. To that end, we would be happy to learn your
workloads and work with you case by case, and we will do our best to
keep the repo fully maintained. For those whose workloads rely on the
existing code, we will make sure you will not be affected in any way.

References
==========
1. Long-term SLOs for reclaimed cloud computing resources
   https://research.google/pubs/pub43017/
2. Profiling a warehouse-scale computer
   https://research.google/pubs/pub44271/
3. Evaluation of NUMA-Aware Scheduling in Warehouse-Scale Clusters
   https://research.google/pubs/pub48329/
4. Software-defined far memory in warehouse-scale computers
   https://research.google/pubs/pub48551/
5. Borg: the Next Generation
   https://research.google/pubs/pub49065/

Yu Zhao (16):
  include/linux/memcontrol.h: do not warn in page_memcg_rcu() if
    !CONFIG_MEMCG
  include/linux/nodemask.h: define next_memory_node() if !CONFIG_NUMA
  include/linux/huge_mm.h: define is_huge_zero_pmd() if
    !CONFIG_TRANSPARENT_HUGEPAGE
  include/linux/cgroup.h: export cgroup_mutex
  mm/swap.c: export activate_page()
  mm, x86: support the access bit on non-leaf PMD entries
  mm/vmscan.c: refactor shrink_node()
  mm: multigenerational lru: groundwork
  mm: multigenerational lru: activation
  mm: multigenerational lru: mm_struct list
  mm: multigenerational lru: aging
  mm: multigenerational lru: eviction
  mm: multigenerational lru: page reclaim
  mm: multigenerational lru: user interface
  mm: multigenerational lru: Kconfig
  mm: multigenerational lru: documentation

 Documentation/vm/index.rst        |    1 +
 Documentation/vm/multigen_lru.rst |  192 +++
 arch/Kconfig                      |    9 +
 arch/x86/Kconfig                  |    1 +
 arch/x86/include/asm/pgtable.h    |    2 +-
 arch/x86/mm/pgtable.c             |    5 +-
 fs/exec.c                         |    2 +
 fs/fuse/dev.c                     |    3 +-
 fs/proc/task_mmu.c                |    3 +-
 include/linux/cgroup.h            |   15 +-
 include/linux/huge_mm.h           |    5 +
 include/linux/memcontrol.h        |    7 +-
 include/linux/mm.h                |    2 +
 include/linux/mm_inline.h         |  294 ++++
 include/linux/mm_types.h          |  117 ++
 include/linux/mmzone.h            |  118 +-
 include/linux/nodemask.h          |    1 +
 include/linux/page-flags-layout.h |   20 +-
 include/linux/page-flags.h        |    4 +-
 include/linux/pgtable.h           |    4 +-
 include/linux/swap.h              |    5 +-
 kernel/bounds.c                   |    6 +
 kernel/events/uprobes.c           |    2 +-
 kernel/exit.c                     |    1 +
 kernel/fork.c                     |   10 +
 kernel/kthread.c                  |    1 +
 kernel/sched/core.c               |    2 +
 mm/Kconfig                        |   55 +
 mm/huge_memory.c                  |    5 +-
 mm/khugepaged.c                   |    2 +-
 mm/memcontrol.c                   |   28 +
 mm/memory.c                       |   14 +-
 mm/migrate.c                      |    2 +-
 mm/mm_init.c                      |   16 +-
 mm/mmzone.c                       |    2 +
 mm/rmap.c                         |    6 +
 mm/swap.c                         |   54 +-
 mm/swapfile.c                     |    6 +-
 mm/userfaultfd.c                  |    2 +-
 mm/vmscan.c                       | 2580 ++++++++++++++++++++++++++++-
 mm/workingset.c                   |  179 +-
 41 files changed, 3603 insertions(+), 180 deletions(-)
 create mode 100644 Documentation/vm/multigen_lru.rst

-- 
2.31.1.295.g9ea45b61b8-goog

