Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001253406BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhCRNUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:20:45 -0400
Received: from foss.arm.com ([217.140.110.172]:40942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhCRNUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:20:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 068B0ED1;
        Thu, 18 Mar 2021 06:20:12 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F32643F718;
        Thu, 18 Mar 2021 06:20:10 -0700 (PDT)
Subject: Re: [PATCH 2/2] iommu/iova: Improve restart logic
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org
Cc:     vjitta@codeaurora.org, iommu@lists.linux-foundation.org,
        Linuxarm <linuxarm@huawei.com>, linux-kernel@vger.kernel.org
References: <03931d86c0ad71f44b29394e3a8d38bfc32349cd.1614962123.git.robin.murphy@arm.com>
 <076b3484d1e5057b95d8c387c894bd6ad2514043.1614962123.git.robin.murphy@arm.com>
 <c1181e3b-cdf3-c658-1c57-8ec86d034f4b@huawei.com>
 <d8e80756-a628-3a0d-77ac-1e9df734f1c5@huawei.com>
 <6cea11f9-e98d-98cb-6789-93abd8833fa0@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <878f4f77-97ee-898d-eb05-4548cf00ec27@arm.com>
Date:   Thu, 18 Mar 2021 13:20:03 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6cea11f9-e98d-98cb-6789-93abd8833fa0@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-18 11:38, John Garry wrote:
> On 10/03/2021 17:47, John Garry wrote:
>> On 09/03/2021 15:55, John Garry wrote:
>>> On 05/03/2021 16:35, Robin Murphy wrote:
>>>
>>> Hi Robin,
>>>
>>>> When restarting after searching below the cached node fails, resetting
>>>> the start point to the anchor node is often overly pessimistic. If
>>>> allocations are made with mixed limits - particularly in the case of 
>>>> the
>>>> opportunistic 32-bit allocation for PCI devices - this could mean
>>>> significant time wasted walking through the whole populated upper range
>>>> just to reach the initial limit. 
>>>
>>> Right
>>>
>>>> We can improve on that by implementing
>>>> a proper tree traversal to find the first node above the relevant 
>>>> limit,
>>>> and set the exact start point.
>>>
>>> Thanks for this. However, as mentioned in the other thread, this does 
>>> not help our performance regression Re: commit 4e89dce72521.
>>>
>>> And mentioning this "retry" approach again, in case it was missed, 
>>> from my experiment on the affected HW, it also has generally a 
>>> dreadfully low success rate - less than 1% for the 32b range retry. 
>>> Retry rate is about 20%. So I am saying from this 20%, less than 1% 
>>> of those succeed.

Well yeah, in your particular case you're allocating from a heavily 
over-contended address space, so much of the time it is genuinely full. 
Plus you're primarily churning one or two sizes of IOVA, so there's a 
high chance that you will either allocate immediately from the cached 
node (after a previous free), or search the whole space and fail. In 
case it was missed, searching only some arbitrary subset of the space 
before giving up is not a good behaviour for an allocator to have in 
general.

>> So since the retry means that we search through the complete pfn range 
>> most of the time (due to poor success rate), we should be able to do a 
>> better job at maintaining an accurate max alloc size, by calculating 
>> it from the range search, and not relying on max alloc failed or 
>> resetting it frequently. Hopefully that would mean that we're smarter 
>> about not trying the allocation.
> 
> So I tried that out and we seem to be able to scrap back an appreciable 
> amount of performance. Maybe 80% of original, with with another change, 
> below.

TBH if you really want to make allocation more efficient I think there 
are more radical changes that would be worth experimenting with, like 
using some form of augmented rbtree to also encode the amount of free 
space under each branch, or representing the free space in its own 
parallel tree, or whether some other structure entirely might be a 
better bet these days.

And if you just want to make your thing acceptably fast, now I'm going 
to say stick a quirk somewhere to force the "forcedac" option on your 
platform ;)

[...]
>>>> @@ -219,7 +256,7 @@ static int __alloc_and_insert_iova_range(struct 
>>>> iova_domain *iovad,
>>>>           if (low_pfn == iovad->start_pfn && retry_pfn < limit_pfn) {
>>>>               high_pfn = limit_pfn;
>>>>               low_pfn = retry_pfn;
>>>> -            curr = &iovad->anchor.node;
>>>> +            curr = iova_find_limit(iovad, limit_pfn);
> 
> 
> I see that it is now applied. However, alternatively could we just add a 
> zero-length 32b boundary marker node for the 32b pfn restart point?

That would need special cases all over the place to prevent the marker 
getting merged into reservations or hit by lookups, and at worst break 
the ordering of the tree if a legitimate node straddles the boundary. I 
did consider having the insert/delete routines keep track of yet another 
cached node for whatever's currently the first thing above the 32-bit 
boundary, but I was worried that might be a bit too invasive.

FWIW I'm currently planning to come back to this again when I have a bit 
more time, since the optimum thing to do (modulo replacing the entire 
algorithm...) is actually to make the second part of the search 
*upwards* from the cached node to the limit. Furthermore, to revive my 
arch/arm conversion I think we're realistically going to need a 
compatibility option for bottom-up allocation to avoid too many nasty 
surprises, so I'd like to generalise things to tackle both concerns at once.

Thanks,
Robin.
