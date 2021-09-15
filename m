Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B0D40BD48
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbhIOBqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:46:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:55388 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhIOBqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:46:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="285873143"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="285873143"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 18:45:01 -0700
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="544377778"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 18:44:58 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Wei Xu <weixugc@google.com>,
        osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH -V8 1/6] NUMA balancing: optimize page placement for
 memory tiering system
References: <20210914013701.344956-1-ying.huang@intel.com>
        <20210914013701.344956-2-ying.huang@intel.com>
        <CAHbLzkpRWwtkhnXUZEUk3LgpHtmgNJRPGUjKzd9bhQU33Y4u2g@mail.gmail.com>
Date:   Wed, 15 Sep 2021 09:44:56 +0800
In-Reply-To: <CAHbLzkpRWwtkhnXUZEUk3LgpHtmgNJRPGUjKzd9bhQU33Y4u2g@mail.gmail.com>
        (Yang Shi's message of "Tue, 14 Sep 2021 15:40:15 -0700")
Message-ID: <8735q63947.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Shi <shy828301@gmail.com> writes:

> On Mon, Sep 13, 2021 at 6:37 PM Huang Ying <ying.huang@intel.com> wrote:
>>
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
>
> Thanks for coming up with the patches. TBH the first question off the
> top of my head is all the complexity is really worthy for real life
> workload at the moment? And the interfaces (sysctl knob files exported
> to users) look complicated for the users. I don't know if the users
> know how to set an optimal value for their workloads.
>
> I don't disagree the NUMA balancing needs optimization and improvement
> for tiering memory, the question we need answer is how far we should
> go for now and what the interfaces should look like. Does it make
> sense to you?
>
> IMHO I'd prefer the most simple and straightforward approach at the
> moment. For example, we could just skip high water mark check for PMEM
> promotion.

Hi, Yang,

Thanks for comments.

I understand your concerns about complexity.  I have tried to organize
the patchset so that the initial patch is as simple as possible and the
complexity is introduced step by step.  But it seems that your simplest
version is even simpler than my one :-)

In this patch ([1/6]), I introduced 2 stuff.

Firstly, a sysctl knob is provided to disable the NUMA balancing based
promotion.  Per my understanding, you suggest to remove this.  If so,
optimizing cross-socket access and promoting hot PMEM pages to DRAM must
be enabled/disabled together.  If a user wants to enable promoting the
hot PMEM pages to DRAM but disable optimizing cross-socket access
because they have already bound the CPU of the workload so that there's no
much cross-socket access, how can they do?

Secondly, we add a promote watermark to the DRAM node so that we can
demote/promote pages between the high and promote watermark.  Per my
understanding, you suggest just to ignore the high watermark checking
for promoting.  The problem is that this may make the free pages of the
DRAM node too few.  If many pages are promoted in short time, the free
pages will be kept near the min watermark for a while, so that the page
allocation from the application will trigger direct reclaiming.  We have
observed page allocation failure in a test before with a similar policy.

Best Regards,
Huang, Ying
