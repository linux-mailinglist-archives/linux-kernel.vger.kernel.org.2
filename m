Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610ED395361
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 01:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhE3Xql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 19:46:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:61928 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229677AbhE3Xqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 19:46:39 -0400
IronPort-SDR: qmWiOSraS62W78YcQMhthFMrf53kb4lyv7JRI0HA4TDQs6hJ0X0VZL9BDkM7rQfymWAeJUmsHH
 /LHltnG0EXRQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="267147211"
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="267147211"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2021 16:44:59 -0700
IronPort-SDR: W9hABTtk3AxExNUhyopqea5WkqD+xyCduLWbH8YQzk8a4NwTUwPbbtcLTD4ZDC+rrBHh6o1Yfz
 P/I6VizRLxMA==
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="478680705"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2021 16:44:56 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -V2] mm: move idle swap cache pages to the tail of LRU
 after COW
References: <20210527084953.573788-1-ying.huang@intel.com>
        <YK/OaEAwL4cufITY@cmpxchg.org>
Date:   Mon, 31 May 2021 07:44:54 +0800
In-Reply-To: <YK/OaEAwL4cufITY@cmpxchg.org> (Johannes Weiner's message of
        "Thu, 27 May 2021 12:52:56 -0400")
Message-ID: <871r9nbxc9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> writes:

> On Thu, May 27, 2021 at 04:49:53PM +0800, Huang Ying wrote:
>> With commit 09854ba94c6a ("mm: do_wp_page() simplification"), after
>> COW, the idle swap cache (neither the page nor the corresponding swap
>> entry is mapped by any process) will be left at the original position
>> in the LRU list.  While it may be in the active list or the head of
>> the inactive list, so that vmscan may take more overhead or time to
>> reclaim these actually unused pages.
>> 
>> To help the page reclaiming, in this patch, after COW, the idle swap
>> cache will be tried to be moved to the tail of the inactive LRU list.
>> To avoid to introduce much overhead to the hot COW code path, all
>> locks are acquired with try locking.
>> 
>> To test the patch, we used pmbench memory accessing benchmark with
>> working-set larger than available memory on a 2-socket Intel server
>> with a NVMe SSD as swap device.  Test results shows that the pmbench
>> score increases up to 21.8% with the decreased size of swap cache and
>> swapin throughput.
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Rik van Riel <riel@surriel.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> Cc: Tim Chen <tim.c.chen@intel.com>
>> 
>> V2:
>> 
>> - Move trylock_page() to try_to_free_idle_swapcache() per Rik and
>>   Linus' comments.
>> - Fix PageLRU() checking.
>> - Fix THP processing.
>> - Rename the function.
>> ---
>>  include/linux/memcontrol.h | 10 ++++++++++
>>  include/linux/swap.h       |  3 +++
>>  mm/memcontrol.c            | 12 ++++++++++++
>>  mm/memory.c                |  2 ++
>>  mm/swapfile.c              | 39 ++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 66 insertions(+)
>
> Sorry the discussion fizzled out on the last patch.
>
> Let me try to recap this series: on your first submission you directly
> freed the old page if we copied. Linus was worried about overhead in
> the COW path that wouldn't pay off in a real workload. Before getting
> numbers, it was then suggested to move the pages to the tail of the
> LRU and leaving them to reclaim - which was also met with skepticism.
>
> V2 presented the LRU moving version with pmbench numbers that indeed
> show it pays off. However, much simpler direct freeing produces even
> better numbers in the same benchmark. We don't have numbers showing if
> the LRU shuffling would significantly fare better in other workloads.
>
> Purely looking at the code: whether we defer or free, we need to lock
> the page, take the LRU spinlock for this page, and touch the LRU
> linkage. If we free, we add the swapcache deletion and the page
> allocator, but it's most likely the percpu-cached fastpath. If we
> defer, reclaim needs to re-establish information about the page that
> we already had in the COW context, do another LRU operation, do the
> swapcache deletion and go through the allocator, but on cold caches.
>
> Personally, I'm a bit skeptical the extra code complexity and reclaim
> overhead in paging workloads will definitely pay off in intermittently
> paging loads (non-paging wouldn't have swap pages). As far as code
> goes, the point of 09854ba94c6a (+17, -42) was simplification, and
> this adds more lines back in another place. In particular it adds
> another lifetime variant to swap pages which are already somewhat
> unwieldy. OTOH, freeing is a two-liner reusing the swap unmap code:
>
> 	if (page_copied)
> 		free_swap_cache(old_page);

Yes.  This looks better than my previous version, which duplicated the
code of free_swap_cache().  Thanks for pointing this out.

Best Regards,
Huang, Ying
