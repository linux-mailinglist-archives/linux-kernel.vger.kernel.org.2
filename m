Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A148F33CC2B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 04:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhCPDjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 23:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhCPDib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 23:38:31 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E65C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 20:38:30 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e7so11413897ile.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 20:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vtcOa+7Jfn82RgfkNHogCmMHHCEtwBVt/KyTEvjuHVo=;
        b=byobSetErHobQnhmJt47XbeiIVDT5OvHVBfFx0MR0rGAh72fAAhi8E0VF56AsMlJM/
         1ab/UrmBzq5GCe6rtxMpVCl1uMfD6oyURN/ERYQSfu9ZnNf+o779cqzgQtZVwG0LX5aQ
         bW1YJg1uIuCcAgDwkD8rMdXyqQDzBCeFa4XKb66CqUHiRmgIZ6mEu/7JE6LW4o8jcXlN
         EvzRFkB698K/9l01g3kc3didtcBxyVC5LEWZj62U+MuCX2ZCd7jZdfRPD2yJdeB5Li0/
         Pa3jLaheH+7WImh3Qu22P+q/rV4YZ617r0tC9oW5zsgHWeYbPY42WXYdabmPL6+lDxZW
         znrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vtcOa+7Jfn82RgfkNHogCmMHHCEtwBVt/KyTEvjuHVo=;
        b=fcTMUDuQVXERPKcV3fXWhEwMQASMiUzdoHEJIj+hxHsfoXB+nHgPbK8wNvp5OhzqeM
         SVnQPkYVkz/NZM+o2wda6s7xYNfMQODq3k0hlatIWj2GJ2PX+HBasP2B+X8r6wXEXIel
         VW30JUrHE1FmSz5FRi6AQjlHjaQa4stpEj2DbzeIQxRiXZLWd4NONLm5VdFI42gjmq9Q
         88Iz2C8XfAVnZe2G6XRSiSqGDwc3zRGxIsRrXlVZginSheCCbZJkeB/mnUrj5bNLC5eC
         Nq57UcE5Xwh36R3NXpmzf/BMBe0RUPVa5Ha7CqBfnsbmbUTGNajeITKV7ysiw0fmqzI6
         ScZQ==
X-Gm-Message-State: AOAM532EN7KaLKxkSkJ2+goIthcWyaxZ+xrP1wxScmAK9sQqf4BPSDgO
        edv32X6a/EQTUlnSKdrZf28iZQ==
X-Google-Smtp-Source: ABdhPJzfi2bkvP+g7z5KGPNTYjVAssPjB/Vc66u+Ae6OpHz5mAqTZO3vdjeldyuELZO18fmW2Af9dQ==
X-Received: by 2002:a92:c5cf:: with SMTP id s15mr2115369ilt.149.1615865909765;
        Mon, 15 Mar 2021 20:38:29 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:d825:37a2:4b55:995f])
        by smtp.gmail.com with ESMTPSA id l1sm1731804iln.63.2021.03.15.20.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 20:38:29 -0700 (PDT)
Date:   Mon, 15 Mar 2021 21:38:25 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Yang Shi <shy828301@gmail.com>
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
Subject: Re: [PATCH v1 00/14] Multigenerational LRU
Message-ID: <YFAoMS67UeqA3IhW@google.com>
References: <20210313075747.3781593-1-yuzhao@google.com>
 <CAHbLzkrHQANSeXbVJLQ3TJxoVRJ8Cm6Qmr9Nk9aHbD-BnDRn-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkrHQANSeXbVJLQ3TJxoVRJ8Cm6Qmr9Nk9aHbD-BnDRn-w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 11:38:20AM -0700, Yang Shi wrote:
> On Fri, Mar 12, 2021 at 11:57 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > TLDR
> > ====
> > The current page reclaim is too expensive in terms of CPU usage and
> > often making poor choices about what to evict. We would like to offer
> > a performant, versatile and straightforward augment.
> >
> > Repo
> > ====
> > git fetch https://linux-mm.googlesource.com/page-reclaim refs/changes/01/1101/1
> >
> > Gerrit https://linux-mm-review.googlesource.com/c/page-reclaim/+/1101
> >
> > Background
> > ==========
> > DRAM is a major factor in total cost of ownership, and improving
> > memory overcommit brings a high return on investment. Over the past
> > decade of research and experimentation in memory overcommit, we
> > observed a distinct trend across millions of servers and clients: the
> > size of page cache has been decreasing because of the growing
> > popularity of cloud storage. Nowadays anon pages account for more than
> > 90% of our memory consumption and page cache contains mostly
> > executable pages.
> >
> > Problems
> > ========
> > Notion of the active/inactive
> > -----------------------------
> > For servers equipped with hundreds of gigabytes of memory, the
> > granularity of the active/inactive is too coarse to be useful for job
> > scheduling. And false active/inactive rates are relatively high. In
> > addition, scans of largely varying numbers of pages are unpredictable
> > because inactive_is_low() is based on magic numbers.
> >
> > For phones and laptops, the eviction is biased toward file pages
> > because the selection has to resort to heuristics as direct
> > comparisons between anon and file types are infeasible. On Android and
> > Chrome OS, executable pages are frequently evicted despite the fact
> > that there are many less recently used anon pages. This causes "janks"
> > (slow UI rendering) and negatively impacts user experience.
> >
> > For systems with multiple nodes and/or memcgs, it is impossible to
> > compare lruvecs based on the notion of the active/inactive.
> >
> > Incremental scans via the rmap
> > ------------------------------
> > Each incremental scan picks up at where the last scan left off and
> > stops after it has found a handful of unreferenced pages. For most of
> > the systems running cloud workloads, incremental scans lose the
> > advantage under sustained memory pressure due to high ratios of the
> > number of scanned pages to the number of reclaimed pages. In our case,
> > the average ratio of pgscan to pgsteal is about 7.
> 
> So, you mean the reclaim efficiency is just 1/7? It seems quite low.

Well, from the perspective of memory utilization, 6/7 is non-idle. And
in our dictionary, high "reclaim efficiency" is synonym for
underutilization :)

> Just out of curiosity, did you have more insights about why it is that
> low? I think it heavily depends on workload. We have page cache heavy
> workloads, the efficiency rate is quite high.

Yes, our observation on (a small group of) page cache heavy workloads
is the same. They access files via file descriptors, and sometimes
stream large files, i.e., only reading each file page once. Those
pages they leave in page cache are highly reclaimable because they
are clean, not mapped into page tables and therefore can be dropped
quickly.

> > On top of that, the rmap has poor memory locality due to its complex
> > data structures. The combined effects typically result in a high
> > amount of CPU usage in the reclaim path. For example, with zram, a
> > typical kswapd profile on v5.11 looks like:
> >   31.03%  page_vma_mapped_walk
> >   25.59%  lzo1x_1_do_compress
> >    4.63%  do_raw_spin_lock
> >    3.89%  vma_interval_tree_iter_next
> >    3.33%  vma_interval_tree_subtree_search
> >
> > And with real swap, it looks like:
> >   45.16%  page_vma_mapped_walk
> >    7.61%  do_raw_spin_lock
> >    5.69%  vma_interval_tree_iter_next
> >    4.91%  vma_interval_tree_subtree_search
> >    3.71%  page_referenced_one
> 
> I guess it is because your workloads have a lot of shared anon pages?

Sharing (map_count > 1) does make kswapd profile look worse. But the
majority of our anon memory including shmem is not shared but mapped
(map_count = 1).

> > Solutions
> > =========
> > Notion of generation numbers
> > ----------------------------
> > The notion of generation numbers introduces a quantitative approach to
> > memory overcommit. A larger number of pages can be spread out across
> > configurable generations, and thus they have relatively low false
> > active/inactive rates. Each generation includes all pages that have
> > been referenced since the last generation.
> >
> > Given an lruvec, scans and the selections between anon and file types
> > are all based on generation numbers, which are simple and yet
> > effective. For different lruvecs, comparisons are still possible based
> > on birth times of generations.
> 
> It means you replace the active/inactive lists to multiple lists, from
> most active to least active?

Precisely.

> > Differential scans via page tables
> > ----------------------------------
> > Each differential scan discovers all pages that have been referenced
> > since the last scan. Specifically, it walks the mm_struct list
> > associated with an lruvec to scan page tables of processes that have
> > been scheduled since the last scan. The cost of each differential scan
> > is roughly proportional to the number of referenced pages it
> > discovers. Unless address spaces are extremely sparse, page tables
> > usually have better memory locality than the rmap. The end result is
> > generally a significant reduction in CPU usage, for most of the
> > systems running cloud workloads.
> 
> How's about unmapped page caches? I think they are still quite common
> for a lot of workloads.

Yes, they are covered too, by mark_page_accessed(), when they are
read/written via file descriptors.

> > On Chrome OS, our real-world benchmark that browses popular websites
> > in multiple tabs demonstrates 51% less CPU usage from kswapd and 52%
> > (full) less PSI on v5.11. And kswapd profile looks like:
> >   49.36%  lzo1x_1_do_compress
> >    4.54%  page_vma_mapped_walk
> >    4.45%  memset_erms
> >    3.47%  walk_pte_range
> >    2.88%  zram_bvec_rw
> >
> > In addition, direct reclaim latency is reduced by 22% at 99th
> > percentile and the number of refaults is reduced 7%. These metrics are
> > important to phones and laptops as they are correlated to user
> > experience.
> >
> > Workflow
> > ========
> > Evictable pages are divided into multiple generations for each lruvec.
> > The youngest generation number is stored in lruvec->evictable.max_seq
> > for both anon and file types as they are aged on an equal footing. The
> > oldest generation numbers are stored in lruvec->evictable.min_seq[2]
> > separately for anon and file types as clean file pages can be evicted
> > regardless of may_swap or may_writepage. Generation numbers are
> > truncated into ilog2(MAX_NR_GENS)+1 bits in order to fit into
> > page->flags. The sliding window technique is used to prevent truncated
> > generation numbers from overlapping. Each truncated generation number
> > is an index to
> > lruvec->evictable.lists[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES].
> > Evictable pages are added to the per-zone lists indexed by max_seq or
> > min_seq[2] (modulo MAX_NR_GENS), depending on whether they are being
> > faulted in or read ahead. The workflow comprises two conceptually
> > independent functions: the aging and the eviction.
> 
> Could you please illustrate the data structures? I think this would be
> very helpful to understand the code. I haven't looked into the code
> closely yet, per my shallow understanding to the above paragraphs, the
> new lruvec looks like:
> 
> ----------------
> | max_seq  |
> ----------------
> | .....            |
> ----------------
> | min_seq.  | -----> -------------
> ----------------          |  Anon    | ---------> -------------------
>                               ------------               | MAX_ZONE  |
> --------> list of pages
>                              |  File       |              --------------------
>                               -------------              | .......
>           | --------->
>                                                             --------------------
>                                                             | ZONE_DMA
>  | --------->
>                                                             --------------------
> 
> And the max_seq/min_seq is per memcg, is my understanding correct?

Yes, on single-node systems. To be precise, they are per lruvec. Each
memcg has N lruvecs for N-node systems.

A crude analogy would be a ring buffer: the aging to the writer
advancing max_seq and the eviction to the reader advancing min_seq,
in terms of generations. (The aging only tags pages -- it doesn't add
pages to the lists; page allocations do.)

> > Aging
> > -----
> > The aging produces young generations. Given an lruvec, the aging scans
> > page tables for referenced pages of this lruvec. Upon finding one, the
> > aging updates its generation number to max_seq. After each round of
> > scan, the aging increments max_seq. The aging maintains either a
> > system-wide mm_struct list or per-memcg mm_struct lists and tracks
> > whether an mm_struct is being used on any CPUs or has been used since
> > the last scan. Multiple threads can concurrently work on the same
> > mm_struct list, and each of them will be given a different mm_struct
> > belonging to a process that has been scheduled since the last scan.
> 
> I don't quite get how the "aging" works. IIUC, you have a dedicated
> kernel thread or threads to scan the page tables periodically to
> update the generations and promote or demote pages among the lists or
> the "aging" just happens in reclaimer?

The aging can happen in any reclaiming threads, when let's say "the
inactive" is low. There is no dedicated kernel threads, unless you
count kswapd as one.

For example, for memcg reclaim, we have:
  page charge failure
    memcg reclaim
      select a node
        get lruvec from the node and the memcg
retry:
          if max_seq - min_seq < 2, i.e., no inactive pages
            the aging: scan the mm_struct lists
              increment max_seq
          the eviction: scan the page lists
            if the per-zone lists are empty
              increment min_seq
              goto retry
