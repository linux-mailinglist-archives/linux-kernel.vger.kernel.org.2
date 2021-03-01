Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9943282D1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbhCAPvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:51:25 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2616 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236767AbhCAPvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:51:24 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dq4KJ5Dj4z67tT2;
        Mon,  1 Mar 2021 23:43:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 1 Mar 2021 16:50:36 +0100
Received: from [10.47.7.243] (10.47.7.243) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 1 Mar 2021
 15:50:35 +0000
Subject: Re: [PATCH 1/1] Revert "iommu/iova: Retry from last rb tree node if
 iova search fails"
To:     Robin Murphy <robin.murphy@arm.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Vijayanand Jitta <vjitta@codeaurora.org>,
        Linuxarm <linuxarm@huawei.com>
References: <20210129092120.1482-1-thunder.leizhen@huawei.com>
 <5505b1e5-2450-d5c4-6d77-5bb21fd0b6a1@huawei.com>
 <e8ff095f-7b7c-da38-3675-cd3c1ee84b1a@arm.com>
 <7e18829a-3e7e-cc82-9d33-366cf2025624@huawei.com>
 <4c634a22-7168-b51c-a012-2009fc03e6c3@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d090b869-b3ac-fecc-9efd-d870e43e0d99@huawei.com>
Date:   Mon, 1 Mar 2021 15:48:42 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <4c634a22-7168-b51c-a012-2009fc03e6c3@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.7.243]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2021 13:20, Robin Murphy wrote:
>>> FWIW, I'm 99% sure that what you really want is [1], but then you get
>>> to battle against an unknown quantity of dodgy firmware instead.
>>>
>> Something which has not been said before is that this only happens for
>> strict mode.
> I think that makes sense - once you*have*  actually failed to allocate
> from the 32-bit space, max32_alloc_size will make subsequent attempts
> fail immediately. In non-strict mode you're most likely freeing 32-bit
> IOVAs back to the tree - and thus reset max32_alloc_size - much less
> often, and you'll make more total space available each time, both of
> which will amortise the cost of getting back into that failed state
> again. Conversely, the worst case in strict mode is to have multiple
> threads getting into this pathological cycle:
> 
> 1: allocate, get last available IOVA
> 2: allocate, fail and set max32_alloc_size
> 3: free one IOVA, reset max32_alloc_size, goto 1
> 
> Now, given the broken behaviour where the cached PFN can get stuck near
> the bottom of the address space, step 2 might well have been faster and
> more premature than it should have, but I hope you can appreciate that
> relying on an allocator being broken at its fundamental purpose of
> allocating is not a good or sustainable thing to do.

I figure that you're talking about 4e89dce72521 now. I would have liked 
to know which real-life problem it solved in practice.

> 
> While max32_alloc_size indirectly tracks the largest*contiguous*  
> available space, one of the ideas from which it grew was to simply keep
> count of the total number of free PFNs. If you're really spending
> significant time determining that the tree is full, as opposed to just
> taking longer to eventually succeed, then it might be relatively
> innocuous to tack on that semi-redundant extra accounting as a
> self-contained quick fix for that worst case.
> 
>> Anyway, we see ~50% throughput regression, which is intolerable. As seen
>> in [0], I put this down to the fact that we have so many IOVA requests
>> which exceed the rcache size limit, which means many RB tree accesses
>> for non-cacheble IOVAs, which are now slower.

I will attempt to prove this by increasing RCACHE RANGE, such that all 
IOVA sizes may be cached.

>>
>> On another point, as for longterm IOVA aging issue, it seems that there
>> is no conclusion there. However I did mention the issue of IOVA sizes
>> exceeding rcache size for that issue, so maybe we can find a common
>> solution. Similar to a fixed rcache depot size, it seems that having a
>> fixed rcache max size range value (at 6) doesn't scale either.
> Well, I'd say that's more of a workload tuning thing than a scalability
> one -

ok

> a massive system with hundreds of CPUs that spends all day
> flinging 1500-byte network packets around as fast as it can might be
> happy with an even smaller value and using the saved memory for
> something else. IIRC the value of 6 is a fairly arbitrary choice for a
> tradeoff between expected utility and memory consumption, so making it a
> Kconfig or command-line tuneable does seem like a sensible thing to explore.

Even if it is were configurable, wouldn't it make sense to have it 
configurable per IOVA domain?

Furthermore, as mentioned above, I still want to solve this IOVA aging 
issue, and this fixed RCACHE RANGE size seems to be the at the center of 
that problem.

> 
>> As for 4e89dce72521, so even if it's proper to retry for a failed alloc,
>> it is not always necessary. I mean, if we're limiting ourselves to 32b
>> subspace for this SAC trick and we fail the alloc, then we can try the
>> space above 32b first (if usable). If that fails, then retry there. I
>> don't see a need to retry the 32b subspace if we're not limited to it.
>> How about it? We tried that idea and it looks to just about restore
>> performance.
> The thing is, if you do have an actual PCI device where DAC might mean a
> 33% throughput loss and you're mapping a long-lived buffer, or you're on
> one of these systems where firmware fails to document address limits and
> using the full IOMMU address width quietly breaks things, then you
> almost certainly*do*  want the allocator to actually do a proper job of
> trying to satisfy the given request.

If those conditions were true, then it seems quite a tenuous position, 
so trying to help that scenario in general terms will have limited efficacy.

> 
> Furthermore, what you propose is still fragile for your own use-case
> anyway. If someone makes internal changes to the allocator - converts it
> to a different tree structure, implements split locking for concurrency,
> that sort of thing - and it fundamentally loses the dodgy cached32_node
> behaviour which makes the initial failure unintentionally fast for your
> workload's allocation pattern, that extra complexity will suddenly just
> be dead weight and you'll probably be complaining of a performance
> regression again.
> 
> We're talking about an allocation that you know you don't need to make,
> and that you even expect to fail, so I still maintain that it's absurd
> to focus on optimising for failure; 

Of course, but....

> focus on*not even doing it at all*.
> It just needs an approach that's not going to mess up the unknown but
> apparently nonzero number of systems inadvertently relying on 32-bit
> IOVAs for correctness.

We are seeing a ~50% throughput performance hit, and it's quite 
reasonable to request a short-term fix, rather than accepting that this 
problem is something which we need to solve medium/long-term and we 
don't know how yet.

Going forward, we should try to fix/workaround any broken platforms, 
rather than hide them all. Indeed, the current approach will just give 
rise to more broken platforms - people only fix generally what they see 
is broken. I do wonder how many there really are.

So how about stick the change to avoid the SAC trick for PCIe devices 
behind a kconfig option, and handle issues on a case-by-case basis, as 
they arise? I think that this is what Joerg suggested earlier.

In addition to that, revisit IOVA aging issue and related topic of fixed 
RCACHE RANGE. Hopefully we can solve our short-term performance issue there.

Thanks,
John
