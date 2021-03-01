Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603ED327F54
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbhCANV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:21:26 -0500
Received: from foss.arm.com ([217.140.110.172]:57888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235387AbhCANVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:21:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B38C1FB;
        Mon,  1 Mar 2021 05:20:27 -0800 (PST)
Received: from [10.57.48.219] (unknown [10.57.48.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0845A3F70D;
        Mon,  1 Mar 2021 05:20:25 -0800 (PST)
Subject: Re: [PATCH 1/1] Revert "iommu/iova: Retry from last rb tree node if
 iova search fails"
To:     John Garry <john.garry@huawei.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Vijayanand Jitta <vjitta@codeaurora.org>,
        Linuxarm <linuxarm@huawei.com>
References: <20210129092120.1482-1-thunder.leizhen@huawei.com>
 <5505b1e5-2450-d5c4-6d77-5bb21fd0b6a1@huawei.com>
 <e8ff095f-7b7c-da38-3675-cd3c1ee84b1a@arm.com>
 <7e18829a-3e7e-cc82-9d33-366cf2025624@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4c634a22-7168-b51c-a012-2009fc03e6c3@arm.com>
Date:   Mon, 1 Mar 2021 13:20:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <7e18829a-3e7e-cc82-9d33-366cf2025624@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-25 13:54, John Garry wrote:
> On 29/01/2021 12:03, Robin Murphy wrote:
>> On 2021-01-29 09:48, Leizhen (ThunderTown) wrote:
>>>
>>> Currently, we are thinking about the solution to the problem. 
>>> However, because the end time of v5.11 is approaching, this patch is 
>>> sent first.
>>
>> However, that commit was made for a reason - how do we justify that 
>> one thing being slow is more important than another thing being 
>> completely broken? It's not practical to just keep doing the patch 
>> hokey-cokey based on whoever shouts loudest :(
>>
>>> On 2021/1/29 17:21, Zhen Lei wrote:
>>>> This reverts commit 4e89dce725213d3d0b0475211b500eda4ef4bf2f.
>>>>
>>>> We find that this patch has a great impact on performance. According to
>>>> our test: the iops decreases from 1655.6K to 893.5K, about half.
>>>>
>>>> Hardware: 1 SAS expander with 12 SAS SSD
>>>> Command:  Only the main parameters are listed.
>>>>            fio bs=4k rw=read iodepth=128 cpus_allowed=0-127
>>
>> FWIW, I'm 99% sure that what you really want is [1], but then you get 
>> to battle against an unknown quantity of dodgy firmware instead.
>>
> 
> Something which has not been said before is that this only happens for 
> strict mode.

I think that makes sense - once you *have* actually failed to allocate 
from the 32-bit space, max32_alloc_size will make subsequent attempts 
fail immediately. In non-strict mode you're most likely freeing 32-bit 
IOVAs back to the tree - and thus reset max32_alloc_size - much less 
often, and you'll make more total space available each time, both of 
which will amortise the cost of getting back into that failed state 
again. Conversely, the worst case in strict mode is to have multiple 
threads getting into this pathological cycle:

1: allocate, get last available IOVA
2: allocate, fail and set max32_alloc_size
3: free one IOVA, reset max32_alloc_size, goto 1

Now, given the broken behaviour where the cached PFN can get stuck near 
the bottom of the address space, step 2 might well have been faster and 
more premature than it should have, but I hope you can appreciate that 
relying on an allocator being broken at its fundamental purpose of 
allocating is not a good or sustainable thing to do.

While max32_alloc_size indirectly tracks the largest *contiguous* 
available space, one of the ideas from which it grew was to simply keep 
count of the total number of free PFNs. If you're really spending 
significant time determining that the tree is full, as opposed to just 
taking longer to eventually succeed, then it might be relatively 
innocuous to tack on that semi-redundant extra accounting as a 
self-contained quick fix for that worst case.

> Anyway, we see ~50% throughput regression, which is intolerable. As seen 
> in [0], I put this down to the fact that we have so many IOVA requests 
> which exceed the rcache size limit, which means many RB tree accesses 
> for non-cacheble IOVAs, which are now slower.
> 
> On another point, as for longterm IOVA aging issue, it seems that there 
> is no conclusion there. However I did mention the issue of IOVA sizes 
> exceeding rcache size for that issue, so maybe we can find a common 
> solution. Similar to a fixed rcache depot size, it seems that having a 
> fixed rcache max size range value (at 6) doesn't scale either.

Well, I'd say that's more of a workload tuning thing than a scalability 
one - a massive system with hundreds of CPUs that spends all day 
flinging 1500-byte network packets around as fast as it can might be 
happy with an even smaller value and using the saved memory for 
something else. IIRC the value of 6 is a fairly arbitrary choice for a 
tradeoff between expected utility and memory consumption, so making it a 
Kconfig or command-line tuneable does seem like a sensible thing to explore.

> As for 4e89dce72521, so even if it's proper to retry for a failed alloc, 
> it is not always necessary. I mean, if we're limiting ourselves to 32b 
> subspace for this SAC trick and we fail the alloc, then we can try the 
> space above 32b first (if usable). If that fails, then retry there. I 
> don't see a need to retry the 32b subspace if we're not limited to it. 
> How about it? We tried that idea and it looks to just about restore 
> performance.

The thing is, if you do have an actual PCI device where DAC might mean a 
33% throughput loss and you're mapping a long-lived buffer, or you're on 
one of these systems where firmware fails to document address limits and 
using the full IOMMU address width quietly breaks things, then you 
almost certainly *do* want the allocator to actually do a proper job of 
trying to satisfy the given request.

Furthermore, what you propose is still fragile for your own use-case 
anyway. If someone makes internal changes to the allocator - converts it 
to a different tree structure, implements split locking for concurrency, 
that sort of thing - and it fundamentally loses the dodgy cached32_node 
behaviour which makes the initial failure unintentionally fast for your 
workload's allocation pattern, that extra complexity will suddenly just 
be dead weight and you'll probably be complaining of a performance 
regression again.

We're talking about an allocation that you know you don't need to make, 
and that you even expect to fail, so I still maintain that it's absurd 
to focus on optimising for failure; focus on *not even doing it at all*. 
It just needs an approach that's not going to mess up the unknown but 
apparently nonzero number of systems inadvertently relying on 32-bit 
IOVAs for correctness.

Robin.
