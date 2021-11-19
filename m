Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D78C4569D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 06:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbhKSFro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 00:47:44 -0500
Received: from mga09.intel.com ([134.134.136.24]:58118 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232894AbhKSFrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 00:47:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="234192659"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="234192659"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 21:44:28 -0800
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="495730950"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.101])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 21:44:24 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michal Hocko" <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Wei Xu <weixugc@google.com>,
        osalvador <osalvador@suse.de>, Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH -V10 2/6] NUMA balancing: optimize page placement for
 memory tiering system
References: <20211116013522.140575-1-ying.huang@intel.com>
        <20211116013522.140575-3-ying.huang@intel.com>
        <C9EB54B4-AA86-4473-AE04-95E3CC6F6E94@nvidia.com>
Date:   Fri, 19 Nov 2021 13:44:22 +0800
In-Reply-To: <C9EB54B4-AA86-4473-AE04-95E3CC6F6E94@nvidia.com> (Zi Yan's
        message of "Thu, 18 Nov 2021 10:01:26 -0500")
Message-ID: <87bl2gsnrd.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Zi,

Thanks for review!

Zi Yan <ziy@nvidia.com> writes:

> On 15 Nov 2021, at 20:35, Huang Ying wrote:
>
>> With the advent of various new memory types, some machines will have
>> multiple types of memory, e.g. DRAM and PMEM (persistent memory).  The
>> memory subsystem of these machines can be called memory tiering
>> system, because the performance of the different types of memory are
>> usually different.
>>
>> In such system, because of the memory accessing pattern changing etc,
>> some pages in the slow memory may become hot globally.  So in this
>> patch, the NUMA balancing mechanism is enhanced to optimize the page
>> placement among the different memory types according to hot/cold
>> dynamically.
>>
>> In a typical memory tiering system, there are CPUs, fast memory and
>> slow memory in each physical NUMA node.  The CPUs and the fast memory
>> will be put in one logical node (called fast memory node), while the
>> slow memory will be put in another (faked) logical node (called slow
>> memory node).  That is, the fast memory is regarded as local while the
>> slow memory is regarded as remote.  So it's possible for the recently
>> accessed pages in the slow memory node to be promoted to the fast
>> memory node via the existing NUMA balancing mechanism.
>>
>> The original NUMA balancing mechanism will stop to migrate pages if the free
>> memory of the target node will become below the high watermark.  This
>> is a reasonable policy if there's only one memory type.  But this
>> makes the original NUMA balancing mechanism almost not work to optimize page
>> placement among different memory types.  Details are as follows.
>>
>> It's the common cases that the working-set size of the workload is
>> larger than the size of the fast memory nodes.  Otherwise, it's
>> unnecessary to use the slow memory at all.  So in the common cases,
>> there are almost always no enough free pages in the fast memory nodes,
>> so that the globally hot pages in the slow memory node cannot be
>> promoted to the fast memory node.  To solve the issue, we have 2
>> choices as follows,
>>
>> a. Ignore the free pages watermark checking when promoting hot pages
>>    from the slow memory node to the fast memory node.  This will
>>    create some memory pressure in the fast memory node, thus trigger
>>    the memory reclaiming.  So that, the cold pages in the fast memory
>>    node will be demoted to the slow memory node.
>>
>> b. Make kswapd of the fast memory node to reclaim pages until the free
>>    pages are a little more (about 10MB) than the high watermark.  Then,
>>    if the free pages of the fast memory node reaches high watermark, and
>>    some hot pages need to be promoted, kswapd of the fast memory node
>>    will be waken up to demote some cold pages in the fast memory node to
>>    the slow memory node.  This will free some extra space in the fast
>>    memory node, so the hot pages in the slow memory node can be
>>    promoted to the fast memory node.
>
> Why 10MB? Is 10MB big enough to avoid creating memory pressure on fast
> memory? This number seems pretty ad-hoc and may only work well on your
> test machine.
>
> In theory, this extra free memory space should be related to page promotion
> throughput and kswapd demotion throughput, right? Patch 5 allows user
> to adjust page promotion throughput, NUMA_BALANCING_PROMOTE_WATERMARK
> at least can be something like X * numa_balancing_rate_limit_mbps.
> Also, is there any way of measuring kswapd demotion throughput at boot
> time? So we can take it into account too. Does this make sense?

Yes.  10MB is just a ad-hoc number that happens work well on my test
machine.  And I am glad to discuss the proper value.

- The effect of the patchset will keep the size of the free memory in
  the DRAM node between HIGH_WATERMARK and HIGH_WATERMARK +
  PROMOTE_WATERMARK in normal cases.  So PROMOTE_WATERMARK should be
  as small as possible to take full advantage of the valuable DRAM.

- The PROMOTE_WATERMARK should be larger than the max per-CPU counter
  error.  So that migrate_balanced_pgdat() for promotion and
  pgdat_balanced() for demotion can cooperate.

- The PROMOTE_WATERMARK should be large enough to batch the demotion.

- If the promotion speed is slower than the demotion speed, the larger
  the PROMOTE_WATERMARK, the longer the sleep time of kswapd.  If the
  promotion speed is faster than the demotion speed, kswapd will keep
  running until promotion is rate limited at least.

So, if we set PROMOTE_WATERMARK as N * numa_balancing_rate_limit_mbps,
then kswapd will sleep about N seconds after the number of the free
pages reaches PROMOTE_WATERMARK.  Is that expected?

All in all, I don't think some ad-hoc number such as 10MB is good
enough.  And the solution adopted in this patch should be as simple as
possible.  This will provide a baseline, so that we can improve it later
with more sophisticated solution with the numbers.  Do you agree?

Best Regards,
Huang, Ying

>>
>> The choice "a" will create the memory pressure in the fast memory
>> node.  If the memory pressure of the workload is high, the memory
>> pressure may become so high that the memory allocation latency of the
>> workload is influenced, e.g. the direct reclaiming may be triggered.
>>
>> The choice "b" works much better at this aspect.  If the memory
>> pressure of the workload is high, the hot pages promotion will stop
>> earlier because its allocation watermark is higher than that of the
>> normal memory allocation.  So in this patch, choice "b" is
>> implemented.
>>
>> In addition to the original page placement optimization among sockets,
>> the NUMA balancing mechanism is extended to be used to optimize page
>> placement according to hot/cold among different memory types.  So the
>> sysctl user space interface (numa_balancing) is extended in a backward
>> compatible way as follow, so that the users can enable/disable these
>> functionality individually.
>>
>> The sysctl is converted from a Boolean value to a bits field.  The
>> definition of the flags is,
>>
>> - 0x0: NUMA_BALANCING_DISABLED
>> - 0x1: NUMA_BALANCING_NORMAL
>> - 0x2: NUMA_BALANCING_MEMORY_TIERING
>>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Rik van Riel <riel@surriel.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Wei Xu <weixugc@google.com>
>> Cc: osalvador <osalvador@suse.de>
>> Cc: Shakeel Butt <shakeelb@google.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-mm@kvack.org

[snip]

Best Regards,
Huang, Ying
