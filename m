Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAF033D628
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 15:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237242AbhCPOur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 10:50:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:11637 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237549AbhCPOuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:50:25 -0400
IronPort-SDR: ejHloLz8SsRHhqvDCD57qblc1xi0wjk9bLtQZ8RvPUspGr0PLTc8f4wMsDbAWCqbxNE9ugrqnU
 g6b0WmHp3nfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="189364484"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="189364484"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 07:50:24 -0700
IronPort-SDR: dduCDcrqNHwBtIHWmbo41zv1TZ4439pS/93WddD+L98QVReXubOHa0J1o38YoR6SOTgf027/SJ
 2Fju8tl6A+Gg==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="449740667"
Received: from kcarrier-mobl.amr.corp.intel.com (HELO [10.209.124.168]) ([10.209.124.168])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 07:50:23 -0700
Subject: Re: [PATCH v1 00/14] Multigenerational LRU
To:     Yu Zhao <yuzhao@google.com>
Cc:     linux-mm@kvack.org, Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, page-reclaim@google.com
References: <20210313075747.3781593-1-yuzhao@google.com>
 <5f621dd6-4bbd-dbf7-8fa1-d63d9a5bfc16@intel.com>
 <YFAW+PtJS7DEngFZ@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <7378f56e-4bc0-51d0-4a61-26aa6969c0de@intel.com>
Date:   Tue, 16 Mar 2021 07:50:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YFAW+PtJS7DEngFZ@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/21 7:24 PM, Yu Zhao wrote:
> On Mon, Mar 15, 2021 at 11:00:06AM -0700, Dave Hansen wrote:
>> How bad does this scanning get in the worst case if there's a lot of
>> sharing?
> 
> Actually the improvement is larger when there is more sharing, i.e.,
> higher map_count larger improvement. Let's assume we have a shmem
> page mapped by two processes. To reclaim this page, we need to make
> sure neither PTE from the two sets of page tables has the accessed
> bit. The current page reclaim uses the rmap, i.e., rmap_walk_file().
> It first looks up the two VMAs (from the two processes mapping this
> shmem file) in the interval tree of this shmem file, then from each
> VMA, it goes through PGD/PUD/PMD to reach the PTE. The page can't be
> reclaimed if either of the PTEs has the accessed bit, therefore cost
> of the scanning is more than proportional to the number of accesses,
> when there is a lot sharing.
> 
> Why this series makes it better? We track the usage of page tables.
> Specifically, we work alongside switch_mm(): if one of the processes
> above hasn't be scheduled since the last scan, we don't need to scan
> its page tables. So the cost is roughly proportional to the number of
> accesses, regardless of how many processes. And instead of scanning
> pages one by one, we do it in large batches. However, page tables can
> be very sparse -- this is not a problem for the rmap because it knows
> exactly where the PTEs are (by vma_address()). We only know ranges (by
> vma->vm_start/vm_end). This is where the accessed bit on non-leaf
> PMDs can be of help.

That's an interesting argument.  *But*, this pivoted into describing an
optimization.  My takeaway from this is that large amounts of sharing
are probably only handled well if the processes doing the sharing are
not running constantly.

> But I guess you are wondering what downsides are. Well, we haven't
> seen any (yet). We do have page cache (non-shmem) heavy workloads,
> but not at a scale large enough to make any statistically meaningful
> observations. We are very interested in working with anybody who has
> page cache (non-shmem) heavy workloads and is willing to try out this
> series.

I would also be very interested to see some synthetic, worst-case
micros.  Maybe take a few thousand processes with very sparse page
tables that all map some shared memory.  They wake up long enough to
touch a few pages, then go back to sleep.

What happens if we do that?  I'm not saying this is a good workload or
that things must behave well, but I do find it interesting to watch the
worst case.

I think it would also be very worthwhile to include some research in
this series about why the kernel moved away from page table scanning.
What has changed?  Are the workloads we were concerned about way back
then not around any more?  Has faster I/O or larger memory sizes with a
stagnating page size changed something?

>> I'm kinda surprised by this, but my 16GB laptop has a lot more page
>> cache than I would have guessed:
>>
>>> Active(anon):    4065088 kB
>>> Inactive(anon):  3981928 kB
>>> Active(file):    2260580 kB
>>> Inactive(file):  3738096 kB
>>> AnonPages:       6624776 kB
>>> Mapped:           692036 kB
>>> Shmem:            776276 kB
>>
>> Most of it isn't mapped, but it's far from all being used for text.
> 
> We have categorized two groups:
>   1) average users that haven't experienced memory pressure since
>   their systems have booted. The booting process fills up page cache
>   with one-off file pages, and they remain until users experience
>   memory pressure. This can be confirmed by looking at those counters
>   of a freshly rebooted and idle system. My guess this is the case for
>   your laptop.

It's been up ~12 days.  There is ~10GB of data in swap, and there's been
a lot of scanning activity which I would associate with memory pressure:

> SwapCached:      1187596 kB
> SwapTotal:      51199996 kB
> SwapFree:       40419428 kB
...
> nr_vmscan_write 24900719
> nr_vmscan_immediate_reclaim 115535
> pgscan_kswapd 320831544
> pgscan_direct 23396383
> pgscan_direct_throttle 0
> pgscan_anon 127491077
> pgscan_file 216736850
> slabs_scanned 400469680
> compact_migrate_scanned 1092813949
> compact_free_scanned 4919523035
> compact_daemon_migrate_scanned 2372223
> compact_daemon_free_scanned 20989310
> unevictable_pgs_scanned 307388545


>   2) engineering users who store git repos and compile locally. They
>   complained about their browsers being janky because anon memory got
>   swapped even though their systems had a lot of stale file pages in
>   page cache, with the current page reclaim. They are what we consider
>   part of the page cache (non-shmem) heavy group.

Interesting.  You shouldn't have a shortage of folks like that among
kernel developers.
