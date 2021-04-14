Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55ADB35ED14
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347788AbhDNGQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:16:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:32872 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229877AbhDNGQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:16:11 -0400
IronPort-SDR: cAdf/qPUOmLCXFcvrZPwaWibpVna21hHf1mTXE6kLtzBfd884t+ZYf0tlyqB9p00zHaIXYyy5b
 3F2dYiKcBAKg==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="258542224"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="258542224"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 23:15:49 -0700
IronPort-SDR: EBKoZlK+dMkVcGQ2Qi/FfLInSXc2rFSELw+6kvuItB0WvIViPnkUZJs/uTRaodrDWFP5gpnEiY
 jfMC2Ml/QkZQ==
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="424584972"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 23:15:41 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Rik van Riel <riel@surriel.com>,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        SeongJae Park <sj38.park@gmail.com>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Manes <ben.manes@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michael Larabel <michael@michaellarabel.com>,
        Michal Hocko <mhocko@suse.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Roman Gushchin <guro@fb.com>,
        Rong Chen <rong.a.chen@intel.com>,
        SeongJae Park <sjpark@amazon.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Kernel Page Reclaim v2 <page-reclaim@google.com>
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
References: <20210413075155.32652-1-sjpark@amazon.de>
        <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
        <20210413231436.GF63242@dread.disaster.area>
        <f4750f9431bd12b7338a47925de8b17015da51a7.camel@surriel.com>
        <CAOUHufafMcaG8sOS=1YMy2P_6p0R1FzP16bCwpUau7g1-PybBQ@mail.gmail.com>
Date:   Wed, 14 Apr 2021 14:15:38 +0800
In-Reply-To: <CAOUHufafMcaG8sOS=1YMy2P_6p0R1FzP16bCwpUau7g1-PybBQ@mail.gmail.com>
        (Yu Zhao's message of "Tue, 13 Apr 2021 22:13:16 -0600")
Message-ID: <87tuo9qtmd.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:

> On Tue, Apr 13, 2021 at 8:30 PM Rik van Riel <riel@surriel.com> wrote:
>>
>> On Wed, 2021-04-14 at 09:14 +1000, Dave Chinner wrote:
>> > On Tue, Apr 13, 2021 at 10:13:24AM -0600, Jens Axboe wrote:
>> >
>> > > The initial posting of this patchset did no better, in fact it did
>> > > a bit
>> > > worse. Performance dropped to the same levels and kswapd was using
>> > > as
>> > > much CPU as before, but on top of that we also got excessive
>> > > swapping.
>> > > Not at a high rate, but 5-10MB/sec continually.
>> > >
>> > > I had some back and forths with Yu Zhao and tested a few new
>> > > revisions,
>> > > and the current series does much better in this regard. Performance
>> > > still dips a bit when page cache fills, but not nearly as much, and
>> > > kswapd is using less CPU than before.
>> >
>> > Profiles would be interesting, because it sounds to me like reclaim
>> > *might* be batching page cache removal better (e.g. fewer, larger
>> > batches) and so spending less time contending on the mapping tree
>> > lock...
>> >
>> > IOWs, I suspect this result might actually be a result of less lock
>> > contention due to a change in batch processing characteristics of
>> > the new algorithm rather than it being a "better" algorithm...
>>
>> That seems quite likely to me, given the issues we have
>> had with virtual scan reclaim algorithms in the past.
>
> Hi Rik,
>
> Let paste the code so we can move beyond the "batching" hypothesis:
>
> static int __remove_mapping(struct address_space *mapping, struct page
> *page,
>                             bool reclaimed, struct mem_cgroup *target_memcg)
> {
>         unsigned long flags;
>         int refcount;
>         void *shadow = NULL;
>
>         BUG_ON(!PageLocked(page));
>         BUG_ON(mapping != page_mapping(page));
>
>         xa_lock_irqsave(&mapping->i_pages, flags);
>
>> SeongJae, what is this algorithm supposed to do when faced
>> with situations like this:
>
> I'll assume the questions were directed at me, not SeongJae.
>
>> 1) Running on a system with 8 NUMA nodes, and
>> memory
>>    pressure in one of those nodes.
>> 2) Running PostgresQL or Oracle, with hundreds of
>>    processes mapping the same (very large) shared
>>    memory segment.
>>
>> How do you keep your algorithm from falling into the worst
>> case virtual scanning scenarios that were crippling the
>> 2.4 kernel 15+ years ago on systems with just a few GB of
>> memory?
>
> There is a fundamental shift: that time we were scanning for cold pages,
> and nowadays we are scanning for hot pages.
>
> I'd be surprised if scanning for cold pages didn't fall apart, because it'd
> find most of the entries accessed, if they are present at all.
>
> Scanning for hot pages, on the other hand, is way better. Let me just
> reiterate:
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
> So the cost is roughly proportional to the number of referenced pages it
> discovers. If there is no memory pressure, no scanning at all. For a system
> under heavy memory pressure, most of the pages are referenced (otherwise
> why would it be under memory pressure?), and if we use the rmap, we need to
> scan a lot of pages anyway. Why not just scan them all?

This may be not the case.  For rmap scanning, it's possible to scan only
a small portion of memory.  But with the page table scanning, you need
to scan almost all (I understand you have some optimization as above).
As Rik shown in the test case above, there may be memory pressure on
only one of 8 NUMA nodes (because of NUMA binding?).  Then ramp scanning
only needs to scan pages in this node, while the page table scanning may
need to scan pages in other nodes too.

Best Regards,
Huang, Ying

> This way you save a
> lot because of batching (now it's time to talk about batching). Besides,
> page tables have far better memory locality than the rmap. For the shared
> memory example you gave, the rmap needs to lock *each* page it scans. How
> many 4KB pages does your large file have? I'll leave the math to you.
>
> Here are some profiles:
>
> zram with the rmap (mainline)
>   31.03%  page_vma_mapped_walk
>   25.59%  lzo1x_1_do_compress
>    4.63%  do_raw_spin_lock
>    3.89%  vma_interval_tree_iter_next
>    3.33%  vma_interval_tree_subtree_search
>
> zram with page table scanning (this patchset)
>   49.36%  lzo1x_1_do_compress
>    4.54%  page_vma_mapped_walk
>    4.45%  memset_erms
>    3.47%  walk_pte_range
>    2.88%  zram_bvec_rw
>
> Note that these are not just what I saw from some local benchmarks. We have
> observed *millions* of machines in our fleet.
>
> I encourage you to try it and see for yourself. It's as simple as:
>
> git fetch https://linux-mm.googlesource.com/page-reclaim
>  refs/changes/73/1173/1
>
> CONFIG_LRU_GEN=y
> CONFIG_LRU_GEN_ENABLED=y
>
> and build and run your favorite benchmarks.
