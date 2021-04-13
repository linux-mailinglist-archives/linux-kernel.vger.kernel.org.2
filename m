Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38FC35D59B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 05:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344201AbhDMDC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 23:02:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:1078 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239974AbhDMDC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 23:02:56 -0400
IronPort-SDR: sGzMWmJ8f313O43b+kAxGlWcyh255fOAH0bO7Y+3tmd/EO7pmi8F7NkOZuvPRAaOvc9HFzkawk
 BgwpsBEdTcDA==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="258300162"
X-IronPort-AV: E=Sophos;i="5.82,218,1613462400"; 
   d="scan'208";a="258300162"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 20:02:14 -0700
IronPort-SDR: Ao3ZRaOAUawUYuNq+EuvJMvAopgXQufq7G/PYX7Vj8ZDNII0wvv1zB68yjKAcx9cdanIlt4eYF
 BiVBOHoygBAw==
X-IronPort-AV: E=Sophos;i="5.82,218,1613462400"; 
   d="scan'208";a="381805936"
Received: from yhuang6-desk1.sh.intel.com (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 20:02:10 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
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
        Yang Shi <shy828301@gmail.com>, linux-kernel@vger.kernel.org,
        page-reclaim@google.com
Subject: Re: [PATCH v1 00/14] Multigenerational LRU
References: <20210313075747.3781593-1-yuzhao@google.com>
        <5f621dd6-4bbd-dbf7-8fa1-d63d9a5bfc16@intel.com>
        <YFAW+PtJS7DEngFZ@google.com>
        <7378f56e-4bc0-51d0-4a61-26aa6969c0de@intel.com>
        <YFEVaZvsVt7nfhdM@google.com>
        <4e76078c-846f-a0f0-2349-12d9d806d1a8@intel.com>
        <YHFuL/Ddtiml4biw@google.com>
Date:   Tue, 13 Apr 2021 11:02:06 +0800
In-Reply-To: <YHFuL/Ddtiml4biw@google.com> (Yu Zhao's message of "Sat, 10 Apr
        2021 03:21:51 -0600")
Message-ID: <87zgy2ubtd.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:

> On Tue, Mar 16, 2021 at 02:14:43PM -0700, Dave Hansen wrote:
>> On 3/16/21 1:30 PM, Yu Zhao wrote:
>> > On Tue, Mar 16, 2021 at 07:50:23AM -0700, Dave Hansen wrote:
>> >> I think it would also be very worthwhile to include some research in
>> >> this series about why the kernel moved away from page table scanning.
>> >> What has changed?  Are the workloads we were concerned about way back
>> >> then not around any more?  Has faster I/O or larger memory sizes with a
>> >> stagnating page size changed something?
>> > 
>> > Sure. Hugh also suggested this too but I personally found that ancient
>> > pre-2.4 history too irrelevant (and uninteresting) to the modern age
>> > and decided to spare audience of the boredom.
>> 
>> IIRC, rmap chains showed up in the 2.5 era and the VM was quite bumpy
>> until anon_vmas came around, which was early-ish in the 2.6 era.
>> 
>> But, either way, I think there is a sufficient population of nostalgic
>> crusty old folks around to warrant a bit of a history lesson.  We'll
>> enjoy the trip down memory lane, fondly remembering the old days in
>> Ottawa...
>> 
>> >>> nr_vmscan_write 24900719
>> >>> nr_vmscan_immediate_reclaim 115535
>> >>> pgscan_kswapd 320831544
>> >>> pgscan_direct 23396383
>> >>> pgscan_direct_throttle 0
>> >>> pgscan_anon 127491077
>> >>> pgscan_file 216736850
>> >>> slabs_scanned 400469680
>> >>> compact_migrate_scanned 1092813949
>> >>> compact_free_scanned 4919523035
>> >>> compact_daemon_migrate_scanned 2372223
>> >>> compact_daemon_free_scanned 20989310
>> >>> unevictable_pgs_scanned 307388545
>> > 
>> > 10G swap + 8G anon rss + 6G file rss, hmm... an interesting workload.
>> > The file rss does seem a bit high to me, my wild speculation is there
>> > have been git/make activities in addition to a VM?
>> 
>> I wish I was doing more git/make activities.  It's been an annoying
>> amount of email and web browsers for 12 days.  If anything, I'd suspect
>> that Thunderbird is at fault for keeping a bunch of mail in the page
>> cache.  There are a couple of VM's running though.
>
> Hi Dave,
>
> Sorry for the late reply. Here is the benchmark result from the worst
> case scenario.
>
> As you suggested, we create a lot of processes sharing one large
> sparse shmem, and they access the shmem at random 2MB-aligned offsets.
> So there will be at most one valid PTE entry per PTE table, hence the
> worst case scenario for the multigenerational LRU, since it is based
> on page table scanning.
>
> TL;DR: the multigenerational LRU did not perform worse than the rmap.
>
> My test configurations:
>
>   The size of the shmem: 256GB
>   The number of processes: 450
>   Total memory size: 200GB
>   The number of CPUs: 64
>   The number of nodes: 2
>
> There is no clear winner in the background reclaim path (kswapd).
>
>   kswapd (5.12.0-rc6):
>     43.99%  kswapd1  page_vma_mapped_walk
>     34.86%  kswapd0  page_vma_mapped_walk
>      2.43%  kswapd0  count_shadow_nodes
>      1.17%  kswapd1  page_referenced_one
>      1.15%  kswapd0  _find_next_bit.constprop.0
>      0.95%  kswapd0  page_referenced_one
>      0.87%  kswapd1  try_to_unmap_one
>      0.75%  kswapd0  cpumask_next
>      0.67%  kswapd0  shrink_slab
>      0.66%  kswapd0  down_read_trylock
>
>   kswapd (the multigenerational LRU):
>     33.39%  kswapd0  walk_pud_range
>     10.93%  kswapd1  walk_pud_range
>      9.36%  kswapd0  page_vma_mapped_walk
>      7.15%  kswapd1  page_vma_mapped_walk
>      3.83%  kswapd0  count_shadow_nodes
>      2.60%  kswapd1  shrink_slab
>      2.47%  kswapd1  down_read_trylock
>      2.03%  kswapd0  _raw_spin_lock
>      1.87%  kswapd0  shrink_slab
>      1.67%  kswapd1  count_shadow_nodes
>
> The multigenerational LRU is somewhat winning in the direct reclaim
> path (sparse is the test binary name):
>
>   The test process context (5.12.0-rc6):
>     65.02%  sparse   page_vma_mapped_walk
>      5.49%  sparse   page_counter_try_charge
>      3.60%  sparse   propagate_protected_usage
>      2.31%  sparse   page_counter_uncharge
>      2.06%  sparse   count_shadow_nodes
>      1.81%  sparse   native_queued_spin_lock_slowpath
>      1.79%  sparse   down_read_trylock
>      1.67%  sparse   page_referenced_one
>      1.42%  sparse   shrink_slab
>      0.87%  sparse   try_to_unmap_one
>
>   CPU % (direct reclaim vs the rest): 71% vs 29%
>   # grep oom_kill /proc/vmstat
>   oom_kill 81
>
>   The test process context (the multigenerational LRU):
>     33.12%  sparse   page_vma_mapped_walk
>     10.70%  sparse   walk_pud_range
>      9.64%  sparse   page_counter_try_charge
>      6.63%  sparse   propagate_protected_usage
>      4.43%  sparse   native_queued_spin_lock_slowpath
>      3.85%  sparse   page_counter_uncharge
>      3.71%  sparse   irqentry_exit_to_user_mode
>      2.16%  sparse   _raw_spin_lock
>      1.83%  sparse   unmap_page_range
>      1.82%  sparse   shrink_slab
>
>   CPU % (direct reclaim vs the rest): 47% vs 53%
>   # grep oom_kill /proc/vmstat
>   oom_kill 80
>
> I also compared other numbers from /proc/vmstat. They do not provide
> any additional insight than the profiles, so I will just omit them
> here.
>
> The following optimizations and the stats measuring their efficacies
> explain why the multigenerational LRU did not perform worse:
>
>   Optimization 1: take advantage of the scheduling information.
>     # of active processes           270
>     # of inactive processes         105
>
>   Optimization 2: take the advantage of the accessed bit on non-leaf
>   PMD entries.
>     # of old non-leaf PMD entries   30523335
>     # of young non-leaf PMD entries 1358400
>
> These stats are not currently included. But I will add them to the
> debugfs interface in the next version coming soon. And I will also add
> another optimization for Android. It reduces zigzags when there are
> many single-page VMAs, i.e., not returning to the PGD table for each
> of such VMAs. Just a heads-up.
>
> The rmap, on the other hand, had to
>   1) lock each (shmem) page it scans
>   2) go through five levels of page tables for each page, even though
>   some of them have the same LCAs
> during the test. The second part is worse given that I have 5 levels
> of page tables configured.
>
> Any additional benchmarks you would suggest? Thanks.

Hi, Yu,

Thanks for your data.

In addition to the data your measured above, is it possible for you to
measure some raw data?  For example, how many CPU cycles does it take to
scan all pages in the system?  For the page table scanning, the page
tables of all processes will be scanned.  For the rmap scanning, all
pages in LRU will be scanned.  And we can do that with difference
parameters, for example, shared vs. non-shared, sparse vs. dense.  Then
we can get an idea about how fast the page table scanning can be.

Best Regards,
Huang, Ying
