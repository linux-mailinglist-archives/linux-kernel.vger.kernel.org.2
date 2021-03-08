Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3393311E9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 16:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhCHPQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 10:16:20 -0500
Received: from foss.arm.com ([217.140.110.172]:39350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230453AbhCHPQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 10:16:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 138F631B;
        Mon,  8 Mar 2021 07:16:06 -0800 (PST)
Received: from [10.57.55.135] (unknown [10.57.55.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 647B63F73C;
        Mon,  8 Mar 2021 07:16:04 -0800 (PST)
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
 <4c634a22-7168-b51c-a012-2009fc03e6c3@arm.com>
 <d090b869-b3ac-fecc-9efd-d870e43e0d99@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <eacd5ccd-ab5a-27fe-6542-deaefd597d11@arm.com>
Date:   Mon, 8 Mar 2021 15:15:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <d090b869-b3ac-fecc-9efd-d870e43e0d99@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-01 15:48, John Garry wrote:
> On 01/03/2021 13:20, Robin Murphy wrote:
>>>> FWIW, I'm 99% sure that what you really want is [1], but then you get
>>>> to battle against an unknown quantity of dodgy firmware instead.
>>>>
>>> Something which has not been said before is that this only happens for
>>> strict mode.
>> I think that makes sense - once you*have*  actually failed to allocate
>> from the 32-bit space, max32_alloc_size will make subsequent attempts
>> fail immediately. In non-strict mode you're most likely freeing 32-bit
>> IOVAs back to the tree - and thus reset max32_alloc_size - much less
>> often, and you'll make more total space available each time, both of
>> which will amortise the cost of getting back into that failed state
>> again. Conversely, the worst case in strict mode is to have multiple
>> threads getting into this pathological cycle:
>>
>> 1: allocate, get last available IOVA
>> 2: allocate, fail and set max32_alloc_size
>> 3: free one IOVA, reset max32_alloc_size, goto 1
>>
>> Now, given the broken behaviour where the cached PFN can get stuck near
>> the bottom of the address space, step 2 might well have been faster and
>> more premature than it should have, but I hope you can appreciate that
>> relying on an allocator being broken at its fundamental purpose of
>> allocating is not a good or sustainable thing to do.
> 
> I figure that you're talking about 4e89dce72521 now. I would have liked 
> to know which real-life problem it solved in practice.

 From what I remember, the problem reported was basically the one 
illustrated in that commit and the one I alluded to above - namely that 
certain allocation patterns with a broad mix of sizes and relative 
lifetimes end up pushing the cached PFN down to the bottom of the 
address space such that allocations start failing despite there still 
being sufficient free space overall, which was breaking some media 
workload. What was originally proposed was an overcomplicated palaver 
with DMA attributes and a whole extra allocation algorithm rather than 
just fixing the clearly unintended and broken behaviour.

>> While max32_alloc_size indirectly tracks the largest*contiguous* 
>> available space, one of the ideas from which it grew was to simply keep
>> count of the total number of free PFNs. If you're really spending
>> significant time determining that the tree is full, as opposed to just
>> taking longer to eventually succeed, then it might be relatively
>> innocuous to tack on that semi-redundant extra accounting as a
>> self-contained quick fix for that worst case.
>>
>>> Anyway, we see ~50% throughput regression, which is intolerable. As seen
>>> in [0], I put this down to the fact that we have so many IOVA requests
>>> which exceed the rcache size limit, which means many RB tree accesses
>>> for non-cacheble IOVAs, which are now slower.
> 
> I will attempt to prove this by increasing RCACHE RANGE, such that all 
> IOVA sizes may be cached.
> 
>>>
>>> On another point, as for longterm IOVA aging issue, it seems that there
>>> is no conclusion there. However I did mention the issue of IOVA sizes
>>> exceeding rcache size for that issue, so maybe we can find a common
>>> solution. Similar to a fixed rcache depot size, it seems that having a
>>> fixed rcache max size range value (at 6) doesn't scale either.
>> Well, I'd say that's more of a workload tuning thing than a scalability
>> one -
> 
> ok
> 
>> a massive system with hundreds of CPUs that spends all day
>> flinging 1500-byte network packets around as fast as it can might be
>> happy with an even smaller value and using the saved memory for
>> something else. IIRC the value of 6 is a fairly arbitrary choice for a
>> tradeoff between expected utility and memory consumption, so making it a
>> Kconfig or command-line tuneable does seem like a sensible thing to 
>> explore.
> 
> Even if it is were configurable, wouldn't it make sense to have it 
> configurable per IOVA domain?

Perhaps, but I don't see that being at all easy to implement. We can't 
arbitrarily *increase* the scope of caching once a domain is active due 
to the size-rounding-up requirement, which would be prohibitive to 
larger allocations if applied universally.

> Furthermore, as mentioned above, I still want to solve this IOVA aging 
> issue, and this fixed RCACHE RANGE size seems to be the at the center of 
> that problem.
> 
>>
>>> As for 4e89dce72521, so even if it's proper to retry for a failed alloc,
>>> it is not always necessary. I mean, if we're limiting ourselves to 32b
>>> subspace for this SAC trick and we fail the alloc, then we can try the
>>> space above 32b first (if usable). If that fails, then retry there. I
>>> don't see a need to retry the 32b subspace if we're not limited to it.
>>> How about it? We tried that idea and it looks to just about restore
>>> performance.
>> The thing is, if you do have an actual PCI device where DAC might mean a
>> 33% throughput loss and you're mapping a long-lived buffer, or you're on
>> one of these systems where firmware fails to document address limits and
>> using the full IOMMU address width quietly breaks things, then you
>> almost certainly*do*  want the allocator to actually do a proper job of
>> trying to satisfy the given request.
> 
> If those conditions were true, then it seems quite a tenuous position, 
> so trying to help that scenario in general terms will have limited 
> efficacy.

Still, I'd be curious to see if making the restart a bit cleverer offers 
a noticeable improvement. IIRC I suggested it at the time, but in the 
end the push was just to get *something* merged.

Robin.
