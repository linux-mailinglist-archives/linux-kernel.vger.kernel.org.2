Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2C333E7B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCQDhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:37:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:49533 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhCQDht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:37:49 -0400
IronPort-SDR: sNDOEzJlb8PmLOIhdIZ1GxEMKg5Pikn5G5vxN6Eh1m/CFfKqc2uHWRrsOlqXXudPgrDCx5Rbk0
 ouR0iV9rZbKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="176979338"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="176979338"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 20:37:49 -0700
IronPort-SDR: Aw85+KfMZ5GUfoUnBULoUR8q6q+BCgtY2OqTpRoda1Tt0n4H1eRahcmIThmv2/Y4YcL6S31K0d
 cCjSL0sm981A==
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="412480917"
Received: from unknown (HELO yhuang6-desk1.ccr.corp.intel.com) ([10.239.13.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 20:37:44 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
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
Subject: Re: [PATCH v1 09/14] mm: multigenerational lru: mm_struct list
References: <20210313075747.3781593-1-yuzhao@google.com>
        <20210313075747.3781593-10-yuzhao@google.com>
        <048e5e1e977e720c3f9fc536ac54beebcc8319f5.camel@surriel.com>
        <87pmzzsvfb.fsf@yhuang6-desk1.ccr.corp.intel.com>
        <YFAsjP7NIZM5Ld+m@google.com>
        <871rcfzjg0.fsf@yhuang6-desk1.ccr.corp.intel.com>
        <YFBktbCH9JFcT0rL@google.com>
Date:   Wed, 17 Mar 2021 11:37:38 +0800
In-Reply-To: <YFBktbCH9JFcT0rL@google.com> (Yu Zhao's message of "Tue, 16 Mar
        2021 01:56:37 -0600")
Message-ID: <87o8fixxfh.fsf@yhuang6-desk1.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Zhao <yuzhao@google.com> writes:

> On Tue, Mar 16, 2021 at 02:44:31PM +0800, Huang, Ying wrote:
>> Yu Zhao <yuzhao@google.com> writes:
>> 
>> > On Tue, Mar 16, 2021 at 10:07:36AM +0800, Huang, Ying wrote:
>> >> Rik van Riel <riel@surriel.com> writes:
>> >> 
>> >> > On Sat, 2021-03-13 at 00:57 -0700, Yu Zhao wrote:
>> >> >
>> >> >> +/*
>> >> >> + * After pages are faulted in, they become the youngest generation.
>> >> >> They must
>> >> >> + * go through aging process twice before they can be evicted. After
>> >> >> first scan,
>> >> >> + * their accessed bit set during initial faults are cleared and they
>> >> >> become the
>> >> >> + * second youngest generation. And second scan makes sure they
>> >> >> haven't been used
>> >> >> + * since the first.
>> >> >> + */
>> >> >
>> >> > I have to wonder if the reductions in OOM kills and 
>> >> > low-memory tab discards is due to this aging policy
>> >> > change, rather than from the switch to virtual scanning.
>> >
>> > There are no policy changes per se. The current page reclaim also
>> > scans a faulted-in page at least twice before it can reclaim it.
>> > That said, the new aging yields a better overall result because it
>> > discovers every page that has been referenced since the last scan,
>> > in addition to what Ying has mentioned. The current page scan stops
>> > stops once it finds enough candidates, which may seem more
>> > efficiently, but actually pays the price for not finding the best.
>> >
>> >> If my understanding were correct, the temperature of the processes is
>> >> considered in addition to that of the individual pages.  That is, the
>> >> pages of the processes that haven't been scheduled after the previous
>> >> scanning will not be scanned.  I guess that this helps OOM kills?
>> >
>> > Yes, that's correct.
>> >
>> >> If so, how about just take advantage of that information for OOM killing
>> >> and page reclaiming?  For example, if a process hasn't been scheduled
>> >> for long time, just reclaim its private pages.
>> >
>> > This is how it works. Pages that haven't been scanned grow older
>> > automatically because those that have been scanned will be tagged with
>> > younger generation numbers. Eviction does bucket sort based on
>> > generation numbers and attacks the oldest.
>> 
>> Sorry, my original words are misleading.  What I wanted to say was that
>> is it good enough that
>> 
>> - Do not change the core algorithm of current page reclaiming.
>> 
>> - Add some new logic to reclaim the process private pages regardless of
>>   the Accessed bits if the processes are not scheduled for some long
>>   enough time.  This can be done before the normal page reclaiming.
>
> This is a good idea, which being used on Android and Chrome OS. We
> call it per-process reclaim, and I've mentioned here:
> https://lore.kernel.org/linux-mm/YBkT6175GmMWBvw3@google.com/
>   On Android, our most advanced simulation that generates memory
>   pressure from realistic user behavior shows 18% fewer low-memory
>   kills, which in turn reduces cold starts by 16%. This is on top of
>   per-process reclaim, a predecessor of ``MADV_COLD`` and
>   ``MADV_PAGEOUT``, against background apps.

Thanks, now I see your improvement compared with the per-process
reclaim.  How about the per-process reclaim compared with the normal
page reclaiming for the similar test cases?

My intention behind this is that your solution includes several
improvements,

a) take advantage of scheduler information
b) more fine-grained active/inactive dividing
c) page table scanning instead of rmap

Is it possible to evaluate the benefit of the each step?  And is there
still some potential to optimize the current LRU based algorithm before
adopting a totally new algorithm?

> The patches landed not long a ago :) See mm/madvise.c

:) I'm too out-dated.

>> So this is an one small step improvement to the current page reclaiming
>> algorithm via taking advantage of the scheduler information.  It's
>> clearly not sophisticated as your new algorithm, for example, the cold
>> pages in the hot processes will not be reclaimed in this stage.  But it
>> can reduce the overhead of scanning too.
>
> The general problems with the direction of per-process reclaim:
>   1) we can't find the coldest pages, as you have mentioned.
>   2) we can't reach file pages accessed via file descriptors only,
>   especially those caching config files that were read only once.

In theory, this is possible, we can build a inode list based on the
accessing time too.  Although this may not be necessary.  We can reclaim
the read-once file cache before the per-process reclaim in theory.

>   3) we can't reclaim lru pages and slab objects proportionally and
>   therefore we leave many stale slab objects behind.
>   4) we have to be proactive, as you suggested (once again, you were
>   right), and this has a serious problem: client's battery life can
>   be affected.

Why can this not be done reactively?  We can start per-process reclaim
under memory pressure.  This has been used in phone and laptop now, so
there's a solution for this issue?

> The scanning overhead is only one of the two major problems of the
> current page reclaim. The other problem is the granularity of the
> active/inactive (sizes). We stopped using them in making job
> scheduling decision a long time ago. I know another large internet
> company adopted a similar approach as ours, and I'm wondering how
> everybody else is coping with the discrepancy from those counters.

From intuition, the scanning overhead of the full page table scanning
appears higher than that of the rmap scanning for a small portion of
system memory.  But form your words, you think the reality is the
reverse?  If others concern about the overhead too, finally, I think you
need to prove the overhead of the page table scanning isn't too higher,
or even lower with more data and theory.

>> All in all, some of your ideas may help the original LRU algorithm too.
>> Or some can be experimented without replacing the original algorithm.
>> 
>> But from another point of view, your solution can be seen as a kind of
>> improvement on top of the original LRU algorithm too.  It moves the
>> recently accessed pages to kind of multiple active lists based on
>> scanning page tables directly (instead of reversely).
>
> We hope this series can be a framework or an infrastructure flexible
> enough that people can build their complex use cases upon, e.g.,
> proactive reclaim (machine-wide, not per process), cold memory
> estimation (for job scheduling), AEP demotion, specifically, we want
> people to use it with what you and Dave are working on here:
> https://patchwork.kernel.org/project/linux-mm/cover/20210304235949.7922C1C3@viggo.jf.intel.com/

Yes.  A better page reclaiming algorithm will help DRAM->PMEM demotion
much!

Best Regards,
Huang, Ying
