Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5BE33C5E0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhCOSiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbhCOSie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:38:34 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8792FC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:38:33 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id j3so18562629edp.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 11:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Z7UDxrsKWFb5uH1xeByMVAYhc7egaiKULxUtQ3zv4c=;
        b=DqlKAklNaRLpLfQTbRvt+Xf/dymbipCdAOW8ZVX6jGmvVcGgDSQwOAyLeJdzux8C6S
         UeCcAsrtGKwqGNf+3ob7uQPrarmqavjP0GeDcV+XIbwVJVa9ZBTedkX1UD2eo6zBNvJa
         ZfZ30Gv2yqWhmr2G7enyqRI2KtuUV4OUaTa04MTaEeMc6hlmffOFEqp8UEI+OkZX77Be
         dfWOy2KdThwrDbjyE65+KEEpJr6P4EgFg+iLBN1/kroWP3FpLqHK6m+IToK3j5KMKA8O
         yn4ohN5V5smiQlKF+kcseNmdYAvgtmQi5I+9g3dihyGRMAE1Tlr3jb9NIliVeV3sczvR
         Tc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Z7UDxrsKWFb5uH1xeByMVAYhc7egaiKULxUtQ3zv4c=;
        b=SIwhbc7E5Cpq/VVU/WFeqbck73REPg2rM+n/BDkznZ2cqeKO/WnYV1BAqK4cSiA8ip
         5c2FPhvEBVTaIgJUStlSVCktw7OE2M4zYTYwFv2ECPbk3FGLJ9DRhTK38HzJXttVCVqL
         yiO9WnF7nqwLnEm263p26N1J6NtHgPa+fBFMvHEZAss788BzYAw71VVVvqxlcuDHRpC/
         K6yiO+gxPJkTBfuxx04JBn32kwJGi0lUxD7SNTNDIt72wpdBU2a2aUB9rL3OZ4eaDRqF
         VPTAfB99FeVaxDr/zMoksIrJ9qnzj0v4tGTOYxa+OHy2hRdE6QMlMCjCNVsMjtJEp2nP
         +T+Q==
X-Gm-Message-State: AOAM532SzFepSd0Zr4KADyCO2K/Fia/rj8TGU8/Ls7VtlSns0EZy/E7s
        OZb506vNLYHGoisTSgH4RIhfC1yS5mGamEvwT2g=
X-Google-Smtp-Source: ABdhPJyHBWt7HBTOQ9bWBGPv09WFzeEOF1N+TBNJif1XbAw4H5mqjCZTPJ71Tm35VlgbFY4Q2HsMFmw8S6yIZ07UIZ8=
X-Received: by 2002:a50:ef11:: with SMTP id m17mr31597600eds.151.1615833512249;
 Mon, 15 Mar 2021 11:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210313075747.3781593-1-yuzhao@google.com>
In-Reply-To: <20210313075747.3781593-1-yuzhao@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 15 Mar 2021 11:38:20 -0700
Message-ID: <CAHbLzkrHQANSeXbVJLQ3TJxoVRJ8Cm6Qmr9Nk9aHbD-BnDRn-w@mail.gmail.com>
Subject: Re: [PATCH v1 00/14] Multigenerational LRU
To:     Yu Zhao <yuzhao@google.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Ying Huang <ying.huang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        page-reclaim@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 11:57 PM Yu Zhao <yuzhao@google.com> wrote:
>
> TLDR
> ====
> The current page reclaim is too expensive in terms of CPU usage and
> often making poor choices about what to evict. We would like to offer
> a performant, versatile and straightforward augment.
>
> Repo
> ====
> git fetch https://linux-mm.googlesource.com/page-reclaim refs/changes/01/1101/1
>
> Gerrit https://linux-mm-review.googlesource.com/c/page-reclaim/+/1101
>
> Background
> ==========
> DRAM is a major factor in total cost of ownership, and improving
> memory overcommit brings a high return on investment. Over the past
> decade of research and experimentation in memory overcommit, we
> observed a distinct trend across millions of servers and clients: the
> size of page cache has been decreasing because of the growing
> popularity of cloud storage. Nowadays anon pages account for more than
> 90% of our memory consumption and page cache contains mostly
> executable pages.
>
> Problems
> ========
> Notion of the active/inactive
> -----------------------------
> For servers equipped with hundreds of gigabytes of memory, the
> granularity of the active/inactive is too coarse to be useful for job
> scheduling. And false active/inactive rates are relatively high. In
> addition, scans of largely varying numbers of pages are unpredictable
> because inactive_is_low() is based on magic numbers.
>
> For phones and laptops, the eviction is biased toward file pages
> because the selection has to resort to heuristics as direct
> comparisons between anon and file types are infeasible. On Android and
> Chrome OS, executable pages are frequently evicted despite the fact
> that there are many less recently used anon pages. This causes "janks"
> (slow UI rendering) and negatively impacts user experience.
>
> For systems with multiple nodes and/or memcgs, it is impossible to
> compare lruvecs based on the notion of the active/inactive.
>
> Incremental scans via the rmap
> ------------------------------
> Each incremental scan picks up at where the last scan left off and
> stops after it has found a handful of unreferenced pages. For most of
> the systems running cloud workloads, incremental scans lose the
> advantage under sustained memory pressure due to high ratios of the
> number of scanned pages to the number of reclaimed pages. In our case,
> the average ratio of pgscan to pgsteal is about 7.

So, you mean the reclaim efficiency is just 1/7? It seems quite low.
Just out of curiosity, did you have more insights about why it is that
low? I think it heavily depends on workload. We have page cache heavy
workloads, the efficiency rate is quite high.

>
> On top of that, the rmap has poor memory locality due to its complex
> data structures. The combined effects typically result in a high
> amount of CPU usage in the reclaim path. For example, with zram, a
> typical kswapd profile on v5.11 looks like:
>   31.03%  page_vma_mapped_walk
>   25.59%  lzo1x_1_do_compress
>    4.63%  do_raw_spin_lock
>    3.89%  vma_interval_tree_iter_next
>    3.33%  vma_interval_tree_subtree_search
>
> And with real swap, it looks like:
>   45.16%  page_vma_mapped_walk
>    7.61%  do_raw_spin_lock
>    5.69%  vma_interval_tree_iter_next
>    4.91%  vma_interval_tree_subtree_search
>    3.71%  page_referenced_one

I guess it is because your workloads have a lot of shared anon pages?

>
> Solutions
> =========
> Notion of generation numbers
> ----------------------------
> The notion of generation numbers introduces a quantitative approach to
> memory overcommit. A larger number of pages can be spread out across
> configurable generations, and thus they have relatively low false
> active/inactive rates. Each generation includes all pages that have
> been referenced since the last generation.
>
> Given an lruvec, scans and the selections between anon and file types
> are all based on generation numbers, which are simple and yet
> effective. For different lruvecs, comparisons are still possible based
> on birth times of generations.

It means you replace the active/inactive lists to multiple lists, from
most active to least active?

>
> Differential scans via page tables
> ----------------------------------
> Each differential scan discovers all pages that have been referenced
> since the last scan. Specifically, it walks the mm_struct list
> associated with an lruvec to scan page tables of processes that have
> been scheduled since the last scan. The cost of each differential scan
> is roughly proportional to the number of referenced pages it
> discovers. Unless address spaces are extremely sparse, page tables
> usually have better memory locality than the rmap. The end result is
> generally a significant reduction in CPU usage, for most of the
> systems running cloud workloads.

How's about unmapped page caches? I think they are still quite common
for a lot of workloads.

>
> On Chrome OS, our real-world benchmark that browses popular websites
> in multiple tabs demonstrates 51% less CPU usage from kswapd and 52%
> (full) less PSI on v5.11. And kswapd profile looks like:
>   49.36%  lzo1x_1_do_compress
>    4.54%  page_vma_mapped_walk
>    4.45%  memset_erms
>    3.47%  walk_pte_range
>    2.88%  zram_bvec_rw
>
> In addition, direct reclaim latency is reduced by 22% at 99th
> percentile and the number of refaults is reduced 7%. These metrics are
> important to phones and laptops as they are correlated to user
> experience.
>
> Workflow
> ========
> Evictable pages are divided into multiple generations for each lruvec.
> The youngest generation number is stored in lruvec->evictable.max_seq
> for both anon and file types as they are aged on an equal footing. The
> oldest generation numbers are stored in lruvec->evictable.min_seq[2]
> separately for anon and file types as clean file pages can be evicted
> regardless of may_swap or may_writepage. Generation numbers are
> truncated into ilog2(MAX_NR_GENS)+1 bits in order to fit into
> page->flags. The sliding window technique is used to prevent truncated
> generation numbers from overlapping. Each truncated generation number
> is an index to
> lruvec->evictable.lists[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES].
> Evictable pages are added to the per-zone lists indexed by max_seq or
> min_seq[2] (modulo MAX_NR_GENS), depending on whether they are being
> faulted in or read ahead. The workflow comprises two conceptually
> independent functions: the aging and the eviction.

Could you please illustrate the data structures? I think this would be
very helpful to understand the code. I haven't looked into the code
closely yet, per my shallow understanding to the above paragraphs, the
new lruvec looks like:

----------------
| max_seq  |
----------------
| .....            |
----------------
| min_seq.  | -----> -------------
----------------          |  Anon    | ---------> -------------------
                              ------------               | MAX_ZONE  |
--------> list of pages
                             |  File       |              --------------------
                              -------------              | .......
          | --------->
                                                            --------------------
                                                            | ZONE_DMA
 | --------->
                                                            --------------------

And the max_seq/min_seq is per memcg, is my understanding correct?

>
> Aging
> -----
> The aging produces young generations. Given an lruvec, the aging scans
> page tables for referenced pages of this lruvec. Upon finding one, the
> aging updates its generation number to max_seq. After each round of
> scan, the aging increments max_seq. The aging maintains either a
> system-wide mm_struct list or per-memcg mm_struct lists and tracks
> whether an mm_struct is being used on any CPUs or has been used since
> the last scan. Multiple threads can concurrently work on the same
> mm_struct list, and each of them will be given a different mm_struct
> belonging to a process that has been scheduled since the last scan.

I don't quite get how the "aging" works. IIUC, you have a dedicated
kernel thread or threads to scan the page tables periodically to
update the generations and promote or demote pages among the lists or
the "aging" just happens in reclaimer?

Thanks,
Yang

>
> Eviction
> --------
> The eviction consumes old generations. Given an lruvec, the eviction
> scans the pages on the per-zone lists indexed by either of min_seq[2].
> It selects a type according to the values of min_seq[2] and
> swappiness. During a scan, the eviction either sorts or isolates a
> page, depending on whether the aging has updated its generation
> number. When it finds all the per-zone lists are empty, the eviction
> increments min_seq[2] indexed by this selected type. The eviction
> triggers the aging when both of min_seq[2] reaches max_seq-1, assuming
> both anon and file types are reclaimable.
>
> Use cases
> =========
> On Android, our most advanced simulation that generates memory
> pressure from realistic user behavior shows 18% fewer low-memory
> kills, which in turn reduces cold starts by 16%.
>
> On Borg, a similar approach enables us to identify jobs that
> underutilize their memory and downsize them considerably without
> compromising any of our service level indicators.
>
> On Chrome OS, our field telemetry reports 96% fewer low-memory tab
> discards and 59% fewer OOM kills from fully-utilized devices and no UX
> regressions from underutilized devices.
>
> For other use cases include working set estimation, proactive reclaim,
> far memory tiering and NUMA-aware job scheduling, please refer to the
> documentation included in this series and the following references.
>
> References
> ==========
> 1. Long-term SLOs for reclaimed cloud computing resources
>    https://research.google/pubs/pub43017/
> 2. Profiling a warehouse-scale computer
>    https://research.google/pubs/pub44271/
> 3. Evaluation of NUMA-Aware Scheduling in Warehouse-Scale Clusters
>    https://research.google/pubs/pub48329/
> 4. Software-defined far memory in warehouse-scale computers
>    https://research.google/pubs/pub48551/
> 5. Borg: the Next Generation
>    https://research.google/pubs/pub49065/
>
> Yu Zhao (14):
>   include/linux/memcontrol.h: do not warn in page_memcg_rcu() if
>     !CONFIG_MEMCG
>   include/linux/nodemask.h: define next_memory_node() if !CONFIG_NUMA
>   include/linux/huge_mm.h: define is_huge_zero_pmd() if
>     !CONFIG_TRANSPARENT_HUGEPAGE
>   include/linux/cgroup.h: export cgroup_mutex
>   mm/swap.c: export activate_page()
>   mm, x86: support the access bit on non-leaf PMD entries
>   mm/pagewalk.c: add pud_entry_post() for post-order traversals
>   mm/vmscan.c: refactor shrink_node()
>   mm: multigenerational lru: mm_struct list
>   mm: multigenerational lru: core
>   mm: multigenerational lru: page activation
>   mm: multigenerational lru: user space interface
>   mm: multigenerational lru: Kconfig
>   mm: multigenerational lru: documentation
>
>  Documentation/vm/index.rst        |    1 +
>  Documentation/vm/multigen_lru.rst |  210 +++
>  arch/Kconfig                      |    8 +
>  arch/x86/Kconfig                  |    1 +
>  arch/x86/include/asm/pgtable.h    |    2 +-
>  arch/x86/mm/pgtable.c             |    5 +-
>  fs/exec.c                         |    2 +
>  fs/proc/task_mmu.c                |    3 +-
>  include/linux/cgroup.h            |   15 +-
>  include/linux/huge_mm.h           |    5 +
>  include/linux/memcontrol.h        |    5 +-
>  include/linux/mm.h                |    1 +
>  include/linux/mm_inline.h         |  246 ++++
>  include/linux/mm_types.h          |  135 ++
>  include/linux/mmzone.h            |   62 +-
>  include/linux/nodemask.h          |    1 +
>  include/linux/page-flags-layout.h |   20 +-
>  include/linux/pagewalk.h          |    4 +
>  include/linux/pgtable.h           |    4 +-
>  include/linux/swap.h              |    5 +-
>  kernel/events/uprobes.c           |    2 +-
>  kernel/exit.c                     |    1 +
>  kernel/fork.c                     |   10 +
>  kernel/kthread.c                  |    1 +
>  kernel/sched/core.c               |    2 +
>  mm/Kconfig                        |   29 +
>  mm/huge_memory.c                  |    5 +-
>  mm/khugepaged.c                   |    2 +-
>  mm/memcontrol.c                   |   28 +
>  mm/memory.c                       |   14 +-
>  mm/migrate.c                      |    2 +-
>  mm/mm_init.c                      |   13 +-
>  mm/mmzone.c                       |    2 +
>  mm/pagewalk.c                     |    5 +
>  mm/rmap.c                         |    6 +
>  mm/swap.c                         |   58 +-
>  mm/swapfile.c                     |    6 +-
>  mm/userfaultfd.c                  |    2 +-
>  mm/vmscan.c                       | 2091 +++++++++++++++++++++++++++--
>  39 files changed, 2870 insertions(+), 144 deletions(-)
>  create mode 100644 Documentation/vm/multigen_lru.rst
>
> --
> 2.31.0.rc2.261.g7f71774620-goog
>
