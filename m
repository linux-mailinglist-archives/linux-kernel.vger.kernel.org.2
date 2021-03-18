Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161203409B4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 17:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhCRQJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 12:09:35 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2712 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbhCRQJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 12:09:24 -0400
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F1Ww628xgz681Nc;
        Fri, 19 Mar 2021 00:00:54 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 18 Mar 2021 17:09:22 +0100
Received: from [10.47.0.142] (10.47.0.142) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 18 Mar
 2021 16:09:21 +0000
Subject: Re: [PATCH 2/2] iommu/iova: Improve restart logic
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     <vjitta@codeaurora.org>, <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <03931d86c0ad71f44b29394e3a8d38bfc32349cd.1614962123.git.robin.murphy@arm.com>
 <076b3484d1e5057b95d8c387c894bd6ad2514043.1614962123.git.robin.murphy@arm.com>
 <c1181e3b-cdf3-c658-1c57-8ec86d034f4b@huawei.com>
 <d8e80756-a628-3a0d-77ac-1e9df734f1c5@huawei.com>
 <6cea11f9-e98d-98cb-6789-93abd8833fa0@huawei.com>
 <878f4f77-97ee-898d-eb05-4548cf00ec27@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b9417479-4e45-8b31-bc32-d20739c97a10@huawei.com>
Date:   Thu, 18 Mar 2021 16:07:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <878f4f77-97ee-898d-eb05-4548cf00ec27@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.0.142]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Well yeah, in your particular case you're allocating from a heavily 
> over-contended address space, so much of the time it is genuinely full. 
> Plus you're primarily churning one or two sizes of IOVA, so there's a 
> high chance that you will either allocate immediately from the cached 
> node (after a previous free), or search the whole space and fail. In 
> case it was missed, searching only some arbitrary subset of the space 
> before giving up is not a good behaviour for an allocator to have in 
> general.
> 
>>> So since the retry means that we search through the complete pfn 
>>> range most of the time (due to poor success rate), we should be able 
>>> to do a better job at maintaining an accurate max alloc size, by 
>>> calculating it from the range search, and not relying on max alloc 
>>> failed or resetting it frequently. Hopefully that would mean that 
>>> we're smarter about not trying the allocation.
>>
>> So I tried that out and we seem to be able to scrap back an 
>> appreciable amount of performance. Maybe 80% of original, with with 
>> another change, below.
> 
> TBH if you really want to make allocation more efficient I think there 
> are more radical changes that would be worth experimenting with, like 
> using some form of augmented rbtree to also encode the amount of free 
> space under each branch, or representing the free space in its own 
> parallel tree, or whether some other structure entirely might be a 
> better bet these days.
> 
> And if you just want to make your thing acceptably fast, now I'm going 
> to say stick a quirk somewhere to force the "forcedac" option on your 
> platform ;)
> 

Easier said than done :)

But still, I'd like to just be able to cache all IOVA sizes for my DMA 
engine, so we should not have to go near the RB tree often.

I have put together a series to allow upper limit of rcache range be 
increased per domain. So naturally that gives better performance than we 
originally had.

I don't want to prejudice the solution by saying what I think of it now, 
so will send it out...


> [...]
>>>>> @@ -219,7 +256,7 @@ static int __alloc_and_insert_iova_range(struct 
>>>>> iova_domain *iovad,
>>>>>           if (low_pfn == iovad->start_pfn && retry_pfn < limit_pfn) {
>>>>>               high_pfn = limit_pfn;
>>>>>               low_pfn = retry_pfn;
>>>>> -            curr = &iovad->anchor.node;
>>>>> +            curr = iova_find_limit(iovad, limit_pfn);
>>
>>
>> I see that it is now applied. However, alternatively could we just add 
>> a zero-length 32b boundary marker node for the 32b pfn restart point?
> 
> That would need special cases all over the place to prevent the marker 
> getting merged into reservations or hit by lookups, and at worst break 
> the ordering of the tree if a legitimate node straddles the boundary. I 
> did consider having the insert/delete routines keep track of yet another 
> cached node for whatever's currently the first thing above the 32-bit 
> boundary, but I was worried that might be a bit too invasive.

Yeah, I did think of that. I don't think that it would have too much 
overhead.

> 
> FWIW I'm currently planning to come back to this again when I have a bit 
> more time, since the optimum thing to do (modulo replacing the entire 
> algorithm...) is actually to make the second part of the search 
> *upwards* from the cached node to the limit. Furthermore, to revive my 
> arch/arm conversion I think we're realistically going to need a 
> compatibility option for bottom-up allocation to avoid too many nasty 
> surprises, so I'd like to generalise things to tackle both concerns at 
> once.
> 

Thanks,
John

