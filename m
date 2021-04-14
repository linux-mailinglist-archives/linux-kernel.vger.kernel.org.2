Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4A135FA01
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhDNRoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbhDNRoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:44:07 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E42C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:43:45 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id t11so7510737qtr.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gJIqXtEPBTPf8Vbg1psNlzwIziMSQJuCr+0yP7fEKc8=;
        b=zpiEg/9/z2z96RHVolFbG1jBGX0L8ZENukcWUq8Mls3X074lzChglghcACjDpAGFIy
         QhN2U4eov9u98sXf/sVRWTJTmTNWkfJIqElIv6g2hasYh+i8NTWj1ammFH6L90foSixB
         WEXQj9PNOhpKJ6o8/OaKIgV0hQbCUH+o53C3A8fbMMOm3NWPBli0t6o/doZE3nDM02LH
         4vdUoogmhbHZh28xwGbGtvCPzKzl1whUDeyHqyoGPDbAaSQTgm6uaAt41ZkXX1byvgrm
         pYyIeesabqZrQri3c7nC980LHZckVGfK7XYT8kspS0+3UOfbCfXRi6gGBPtGVMXQvR6o
         mLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gJIqXtEPBTPf8Vbg1psNlzwIziMSQJuCr+0yP7fEKc8=;
        b=F1LxJAYpSGpxisUKTeo6m9xH/XhvYcA5JfzcrXIEuY3iX7qpry9pWGIOv7fwPlb8qT
         DOPCgJBtLFuQkorfRKQaNkdC4sGDnzHK8WWZtrJPmWYHzJVIUIkUeYirj/wBp7wSp4H1
         7sBsz28oSgffFLE9kK/fJM/Quo5JLB4jlnDIE8nJ6gcmuwkiYulJ71WMpP+KXTSSi4cQ
         vu83DbYiLOIMXHhKXx7fp+QMlVdRhK1q0293/syS/uDg46k7GPMLSzpkyFtTDn1gsoia
         BfbcFI0DL76Vwf0WB80KmqESC4tKtA/q75yAAatZ6ytgHS3SgPkxiuUQWJI/93nLRbKz
         JuEA==
X-Gm-Message-State: AOAM530MaTqrJ/IwWehbXweVakcOGbkOY/he9TtNk+EAIC0SskLz0gJz
        rLBEuC/gfv1wYrg0hb9/Qg1yhg==
X-Google-Smtp-Source: ABdhPJxEqfpUeR09/MhxRz55wu+1/aZUx5y41/rVnFvNr9shIWYtT+TI9xESsccZZbuqr/o8MNKxMw==
X-Received: by 2002:ac8:7742:: with SMTP id g2mr10964570qtu.20.1618422224289;
        Wed, 14 Apr 2021 10:43:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:f8bd])
        by smtp.gmail.com with ESMTPSA id a8sm59911qtx.9.2021.04.14.10.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 10:43:43 -0700 (PDT)
Date:   Wed, 14 Apr 2021 13:43:41 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     linux-mm@kvack.org, Alex Shi <alexs@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Manes <ben.manes@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
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
        page-reclaim@google.com
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
Message-ID: <YHcpzZYD2fQyWvEQ@cmpxchg.org>
References: <20210413065633.2782273-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413065633.2782273-1-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yu,

On Tue, Apr 13, 2021 at 12:56:17AM -0600, Yu Zhao wrote:
> What's new in v2
> ================
> Special thanks to Jens Axboe for reporting a regression in buffered
> I/O and helping test the fix.
> 
> This version includes the support of tiers, which represent levels of
> usage from file descriptors only. Pages accessed N times via file
> descriptors belong to tier order_base_2(N). Each generation contains
> at most MAX_NR_TIERS tiers, and they require additional MAX_NR_TIERS-2
> bits in page->flags. In contrast to moving across generations which
> requires the lru lock, moving across tiers only involves an atomic
> operation on page->flags and therefore has a negligible cost. A
> feedback loop modeled after the well-known PID controller monitors the
> refault rates across all tiers and decides when to activate pages from
> which tiers, on the reclaim path.

Could you elaborate a bit more on the difference between generations
and tiers?

A refault, a page table reference, or a buffered read through a file
descriptor ultimately all boil down to a memory access. The value of
having that memory resident and the cost of bringing it in from
backing storage should be the same regardless of how it's accessed by
userspace; and whether it's an in-memory reference or a non-resident
reference should have the same relative impact on the page's age.

With that context, I don't understand why file descriptor refs and
refaults get such special treatment. Could you shed some light here?

> This feedback model has a few advantages over the current feedforward
> model:
> 1) It has a negligible overhead in the buffered I/O access path
>    because activations are done in the reclaim path.

This is useful if the workload isn't reclaim bound, but it can be
hazardous to defer work to reclaim, too.

If you go through the git history, there have been several patches to
soften access recognition inside reclaim because it can come with
large latencies when page reclaim kicks in after a longer period with
no memory pressure and doesn't have uptodate reference information -
to the point where eating a few extra IOs tend to add less latency to
the workload than waiting for reclaim to refresh its aging data.

Could you elaborate a bit more on the tradeoff here?

> Highlights from the discussions on v1
> =====================================
> Thanks to Ying Huang and Dave Hansen for the comments and suggestions
> on page table scanning.
> 
> A simple worst-case scenario test did not find page table scanning
> underperforms the rmap because of the following optimizations:
> 1) It will not scan page tables from processes that have been sleeping
>    since the last scan.
> 2) It will not scan PTE tables under non-leaf PMD entries that do not
>    have the accessed bit set, when
>    CONFIG_HAVE_ARCH_PARENT_PMD_YOUNG=y.
> 3) It will not zigzag between the PGD table and the same PMD or PTE
>    table spanning multiple VMAs. In other words, it finishes all the
>    VMAs with the range of the same PMD or PTE table before it returns
>    to the PGD table. This optimizes workloads that have large numbers
>    of tiny VMAs, especially when CONFIG_PGTABLE_LEVELS=5.
> 
> TLDR
> ====
> The current page reclaim is too expensive in terms of CPU usage and
> often making poor choices about what to evict. We would like to offer
> an alternative framework that is performant, versatile and
> straightforward.
> 
> Repo
> ====
> git fetch https://linux-mm.googlesource.com/page-reclaim refs/changes/73/1173/1
> 
> Gerrit https://linux-mm-review.googlesource.com/c/page-reclaim/+/1173
> 
> Background
> ==========
> DRAM is a major factor in total cost of ownership, and improving
> memory overcommit brings a high return on investment.

RAM cost on one hand.

On the other, paging backends have seen a revolutionary explosion in
iop/s capacity from solid state devices and CPUs that allow in-memory
compression at scale, so a higher rate of paging (semi-random IO) and
thus larger levels of overcommit are possible than ever before.

There is a lot of new opportunity here.

> Over the past decade of research and experimentation in memory
> overcommit, we observed a distinct trend across millions of servers
> and clients: the size of page cache has been decreasing because of
> the growing popularity of cloud storage. Nowadays anon pages account
> for more than 90% of our memory consumption and page cache contains
> mostly executable pages.

This gives the impression that because the number of setups heavily
using the page cache has reduced somewhat, its significance is waning
as well. I don't think that's true. I think we'll continue to have
mainstream workloads for which the page cache is significant.

Yes, the importance of paging anon memory more efficiently (or paging
it at all again, for that matter), has increased dramatically. But IMO
not because it's more prevalent, but rather because of the increase in
paging capacity from the hardware side. It's not like we've been
heavily paging filesystem data beyond cold starts either when it was
more prevalent - workloads quickly fall apart when you do that on
rotating drives.

So that increase in paging capacity also applies to filesystem data,
and makes local filesystems an option again where they might have been
replaced by anonymous blobs managed by a userspace network filesystem.

Take disaggregated storage for example. It's an attractive measure for
reducing per-host CAPEX when the alternative is a local spindle, whose
seekiness doesn't make the network distance look so bad, and prevents
significant memory overcommit anyway. You have to spec the same RAM in
either case.

The equation is different for flash. You can *significantly* reduce
RAM needs of even latency-sensitive, interactive workloads with cheap,
consumer-grade local SSD drives. Disaggregating those drives and
adding the network to the paging path would directly eat into the much
higher RAM savings. It's a much less attractive proposition now. And
that's bringing larger data sets back to local filesystems.

And of course, even in cloud and disaggregated environments, there ARE
those systems that deal with things like source code trees -
development machines, build hosts etc. For those, filesystem data
continues to be the primary workload.

So while I agree with what you say about anon pages, I don't expect
non-trivial (local) filesystem loads to go away anytime soon. The
kernel needs to continue treating it as a first-class citizen.

> Problems
> ========
> Notion of active/inactive
> -------------------------
> For servers equipped with hundreds of gigabytes of memory, the
> granularity of the active/inactive is too coarse to be useful for job
> scheduling. False active/inactive rates are relatively high, and thus
> the assumed savings may not materialize.

The inactive/active naming is certainly confusing for users of the
system. The kernel uses it to preselect reclaim candidates, it's not
meant to indicate how much memory capacity is idle and available.

But a confusion around naming doesn't necessarily indicate it's bad at
what it is actually designed to do.

Fundamentally, LRU ordering is susceptible to a flood of recent pages
with no reuse pushing out the established frequent pages. The split
into inactive and active is simply there to address this shortcoming,
and protect frequent pages from recent ones - where pages that are
only accessed once get reclaimed before pages used twice or more.

Obviously, 'twice or more' is a coarse category, and it's not hard to
imagine that it might go wrong. But please, don't leave it up to the
imagination ;-) It's been in use for two decades or so, it needs a bit
more in-depth analysis of its limitations to justify replacing it.

> For phones and laptops, executable pages are frequently evicted
> despite the fact that there are many less recently used anon pages.
> Major faults on executable pages cause "janks" (slow UI renderings)
> and negatively impact user experience.

This is not because of the inactive/active scheme but rather because
of the anon/file split, which has evolved over the years to just not
swap onto iop-anemic rotational drives.

We ran into the same issue at FB too, where even with painfully
obvious anon candidates and a fast paging backend the kernel would
happily thrash on the page cache instead.

There has been significant work in this area recently to address this
(see commit 5df741963d52506a985b14c4bcd9a25beb9d1981). We've added
extensive testing and production time onto these patches since and
have not found the kernel to be thrashing executables or be reluctant
to go after anonymous pages anymore.

I wonder if your observation takes these recent changes into account?

> For lruvecs from different memcgs or nodes, comparisons are impossible
> due to the lack of a common frame of reference.

My first thought is that this is expected. Workloads running under
different memory constraints, IO priority levels etc. will not have
comparable workingsets: an access frequency that is considered high in
one domain could be considered quite cold in another.

Could you elaborate a bit on the situations where you would want to
compare, and how this is possible by having more generations?

> Solutions
> =========
> Notion of generation numbers
> ----------------------------
> The notion of generation numbers introduces a quantitative approach to
> memory overcommit. A larger number of pages can be spread out across
> a configurable number of generations, and each generation includes all
> pages that have been referenced since the last generation. This
> improved granularity yields relatively low false active/inactive
> rates.
> 
> Given an lruvec, scans of anon and file types and selections between
> them are all based on direct comparisons of generation numbers, which
> are simple and yet effective. For different lruvecs, comparisons are
> still possible based on birth times of generations.

This describes *what* it's doing, but could you elaborate more on how
to think about generations in relation to workload behavior and what
you can predict based on how your workload gets bucketed into these?

If we accept that the current two generations are not enough, how many
should there be instead? Four? Ten?

What determines this? Is it the workload's access pattern? Or the
memory size?

How do I know whether the number of generations I have chosen is right
for my setup? How do I detect when the underlying factors changed and
it no longer is?

How does it manifest if I have too few generations? What about too
many?

What about systems that host a variety of workloads that come and go?
Is there a generation number that will be good for any combination of
workloads on the system as jobs come and go?

For a general purpose OS like Linux, it's nice to be *able* to tune to
your specific requirements, but it's always bad to *have* to. Whatever
we end up doing, there needs to be some reasonable default behavior
that works acceptably for a broad range of workloads out of the box.

> Differential scans via page tables
> ----------------------------------
> Each differential scan discovers all pages that have been referenced
> since the last scan. Specifically, it walks the mm_struct list
> associated with an lruvec to scan page tables of processes that have
> been scheduled since the last scan. The cost of each differential scan
> is roughly proportional to the number of referenced pages it
> discovers. Unless address spaces are extremely sparse, page tables
> usually have better memory locality than the rmap. The end result is
> generally a significant reduction in CPU usage, for workloads using a
> large amount of anon memory.
> 
> Our real-world benchmark that browses popular websites in multiple
> Chrome tabs demonstrates 51% less CPU usage from kswapd and 52% (full)
> less PSI on v5.11. With this patchset, kswapd profile looks like:
>   49.36%  lzo1x_1_do_compress
>    4.54%  page_vma_mapped_walk
>    4.45%  memset_erms
>    3.47%  walk_pte_range
>    2.88%  zram_bvec_rw
> 
> In addition, direct reclaim latency is reduced by 22% at 99th
> percentile and the number of refaults is reduced by 7%. Both metrics
> are important to phones and laptops as they are correlated to user
> experience.

This looks very exciting!

However, this seems to be an improvement completely in its own right:
getting the mapped page access information in a more efficient way.

Is there anything that ties it to the multi-generation LRU that I may
be missing here? Or could it simply be a drop-in replacement for rmap
that gives us the CPU savings right away?

> Framework
> =========
> For each lruvec, evictable pages are divided into multiple
> generations. The youngest generation number is stored in
> lruvec->evictable.max_seq for both anon and file types as they are
> aged on an equal footing. The oldest generation numbers are stored in
> lruvec->evictable.min_seq[2] separately for anon and file types as
> clean file pages can be evicted regardless of may_swap or
> may_writepage. Generation numbers are truncated into
> order_base_2(MAX_NR_GENS+1) bits in order to fit into page->flags. The
> sliding window technique is used to prevent truncated generation
> numbers from overlapping. Each truncated generation number is an inde
> to lruvec->evictable.lists[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES].
> Evictable pages are added to the per-zone lists indexed by max_seq or
> min_seq[2] (modulo MAX_NR_GENS), depending on whether they are being
> faulted in.
> 
> Each generation is then divided into multiple tiers. Tiers represent
> levels of usage from file descriptors only. Pages accessed N times via
> file descriptors belong to tier order_base_2(N). In contrast to moving
> across generations which requires the lru lock, moving across tiers
> only involves an atomic operation on page->flags and therefore has a
> lower cost. A feedback loop modeled after the well-known PID
> controller monitors the refault rates across all tiers and decides
> when to activate pages from which tiers on the reclaim path.
> 
> The framework comprises two conceptually independent components: the
> aging and the eviction, which can be invoked separately from user
> space.

Why from userspace?

> Aging
> -----
> The aging produces young generations. Given an lruvec, the aging scans
> page tables for referenced pages of this lruvec. Upon finding one, the
> aging updates its generation number to max_seq. After each round of
> scan, the aging increments max_seq.
> 
> The aging maintains either a system-wide mm_struct list or per-memcg
> mm_struct lists and tracks whether an mm_struct is being used or has
> been used since the last scan. Multiple threads can concurrently work
> on the same mm_struct list, and each of them will be given a different
> mm_struct belonging to a process that has been scheduled since the
> last scan.
> 
> The aging is due when both of min_seq[2] reaches max_seq-1, assuming
> both anon and file types are reclaimable.

As per above, this is centered around mapped pages, but it really
needs to include a detailed answer for unmapped pages, such as page
cache and shmem/tmpfs data, as well as how sampled page table
references behave wrt realtime syscall references.

> Eviction
> --------
> The eviction consumes old generations. Given an lruvec, the eviction
> scans the pages on the per-zone lists indexed by either of min_seq[2].
> It first tries to select a type based on the values of min_seq[2].
> When anon and file types are both available from the same generation,
> it selects the one that has a lower refault rate.
> 
> During a scan, the eviction sorts pages according to their generation
> numbers, if the aging has found them referenced. It also moves pages
> from the tiers that have higher refault rates than tier 0 to the next
> generation.
> 
> When it finds all the per-zone lists of a selected type are empty, the
> eviction increments min_seq[2] indexed by this selected type.
> 
> Use cases
> =========
> On Android, our most advanced simulation that generates memory
> pressure from realistic user behavior shows 18% fewer low-memory
> kills, which in turn reduces cold starts by 16%.

I assume you refer to pressure-induced lmkd kills rather than
conventional kernel OOM kills?

I.e. multi-gen LRU does a better job of identifying the workingset,
rather than giving up too early.

Again, I would be interested if the baseline here includes the recent
anon/file balancing rework or not.

> On Borg, a similar approach enables us to identify jobs that
> underutilize their memory and downsize them considerably without
> compromising any of our service level indicators.

This is doable with the current reclaim implementation as well. At FB
we drive proactive reclaim through cgroup control, in a feedback loop
with psi metrics.

Obviously, this would benefit from better workingset identification in
the kernel, as more memory could be offloaded under the same pressure
tolerances from the workload, but it's more of an optimization than
enabling a uniquely new usecase.

> On Chrome OS, our field telemetry reports 96% fewer low-memory tab
> discards and 59% fewer OOM kills from fully-utilized devices and no
> regressions in monitored user experience from underutilized devices.

Again, lkmd rather than kernel oom kills, right? And with or without
the anon/file rework?

> Working set estimation
> ----------------------
> User space can invoke the aging by writing "+ memcg_id node_id gen
> [swappiness]" to /sys/kernel/debug/lru_gen. This debugfs interface
> also provides the birth time and the size of each generation.
> 
> Proactive reclaim
> -----------------
> User space can invoke the eviction by writing "- memcg_id node_id gen
> [swappiness] [nr_to_reclaim]" to /sys/kernel/debug/lru_gen. Multiple
> command lines are supported, so does concatenation with delimiters.

Can you explain a bit more how these two are supposed to be used?

The memcg id is self-explanatory: Age or evict pages from this
particular workload.

The node is a bit less intuitive. In most setups, the distance to a
remote NUMA node is much smaller than the distance to the storage
backend, and users would prefer finding and evicting the coldest
memory between multiple nodes, not within individual node.

Swappiness raises a similar question. Why would the user prefer one
type of data to be reclaimed over the other? Shouldn't it want to
reclaim the pages that are least likely to be used again soon?

> FAQ
> ===
> Why not try to improve the existing code?
> -----------------------------------------
> We have tried but concluded the aforementioned problems are
> fundamental, and therefore changes made on top of them will not result
> in substantial gains.

Realistically, I think incremental changes are unavoidable to get this
merged upstream.

Not just in the sense that they need to be smaller changes, but also
in the sense that they need to replace old code. It would be
impossible to maintain both, focus development and testing resources,
and provide a reasonably stable experience with both systems tugging
at a complicated shared code base.

On the other hand, the existing code also has billions of hours of
production testing and tuning. We can't throw this all out overnight -
it needs to be surgical and the broader consequences of each step need
to be well understood.

We also have millions of servers relying on being able to do upgrades
for drivers and fixes in other subsystems that we can't put on hold
until we stabilized a new reclaim implementation from scratch.

The good thing is that swap really hasn't been used much
recently. There definitely is room to maneuver without being too
disruptive. There *are* swap configurations today, but for the most
part, users don't expect the kernel to swap until the machine is under
heavy pressure. Few have expectations of it doing a nuanced and
efficient memory offloading job under nominal loads. So the anon side
could well be a testbed for the multigen LRU that has a more
reasonable blast radius than doing everything at once.

And if the rmap replacement for mapped pages could be split out as a
CPU optimzation for getting MMU info, without changing how those are
interpreted in the same step, I think we'd get into a more manageable
territory with this proposal.

Thanks!
Johannes
