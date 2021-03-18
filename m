Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557093404D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhCRLlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:41:32 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2710 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCRLlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:41:01 -0400
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F1Q0z6vdJz6804r;
        Thu, 18 Mar 2021 19:34:43 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 12:40:59 +0100
Received: from [10.47.0.142] (10.47.0.142) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 18 Mar
 2021 11:40:58 +0000
Subject: Re: [PATCH 2/2] iommu/iova: Improve restart logic
From:   John Garry <john.garry@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     Linuxarm <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <vjitta@codeaurora.org>
References: <03931d86c0ad71f44b29394e3a8d38bfc32349cd.1614962123.git.robin.murphy@arm.com>
 <076b3484d1e5057b95d8c387c894bd6ad2514043.1614962123.git.robin.murphy@arm.com>
 <c1181e3b-cdf3-c658-1c57-8ec86d034f4b@huawei.com>
 <d8e80756-a628-3a0d-77ac-1e9df734f1c5@huawei.com>
Message-ID: <6cea11f9-e98d-98cb-6789-93abd8833fa0@huawei.com>
Date:   Thu, 18 Mar 2021 11:38:49 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <d8e80756-a628-3a0d-77ac-1e9df734f1c5@huawei.com>
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

On 10/03/2021 17:47, John Garry wrote:
> On 09/03/2021 15:55, John Garry wrote:
>> On 05/03/2021 16:35, Robin Murphy wrote:
>>
>> Hi Robin,
>>
>>> When restarting after searching below the cached node fails, resetting
>>> the start point to the anchor node is often overly pessimistic. If
>>> allocations are made with mixed limits - particularly in the case of the
>>> opportunistic 32-bit allocation for PCI devices - this could mean
>>> significant time wasted walking through the whole populated upper range
>>> just to reach the initial limit. 
>>
>> Right
>>
>>> We can improve on that by implementing
>>> a proper tree traversal to find the first node above the relevant limit,
>>> and set the exact start point.
>>
>> Thanks for this. However, as mentioned in the other thread, this does 
>> not help our performance regression Re: commit 4e89dce72521.
>>
>> And mentioning this "retry" approach again, in case it was missed, 
>> from my experiment on the affected HW, it also has generally a 
>> dreadfully low success rate - less than 1% for the 32b range retry. 
>> Retry rate is about 20%. So I am saying from this 20%, less than 1% of 
>> those succeed.
>>
> 
> So since the retry means that we search through the complete pfn range 
> most of the time (due to poor success rate), we should be able to do a 
> better job at maintaining an accurate max alloc size, by calculating it 
> from the range search, and not relying on max alloc failed or resetting 
> it frequently. Hopefully that would mean that we're smarter about not 
> trying the allocation.

So I tried that out and we seem to be able to scrap back an appreciable 
amount of performance. Maybe 80% of original, with with another change, 
below.

Thanks,
John

> 
> 
>>
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>>   drivers/iommu/iova.c | 39 ++++++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 38 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>>> index c28003e1d2ee..471c48dd71e7 100644
>>> --- a/drivers/iommu/iova.c
>>> +++ b/drivers/iommu/iova.c
>>> @@ -154,6 +154,43 @@ __cached_rbnode_delete_update(struct iova_domain 
>>> *iovad, struct iova *free)
>>>           iovad->cached_node = rb_next(&free->node);
>>>   }
>>> +static struct rb_node *iova_find_limit(struct iova_domain *iovad, 
>>> unsigned long limit_pfn)
>>> +{
>>> +    struct rb_node *node, *next;
>>> +    /*
>>> +     * Ideally what we'd like to judge here is whether limit_pfn is 
>>> close
>>> +     * enough to the highest-allocated IOVA that starting the 
>>> allocation
>>> +     * walk from the anchor node will be quicker than this initial 
>>> work to
>>> +     * find an exact starting point (especially if that ends up 
>>> being the
>>> +     * anchor node anyway). This is an incredibly crude 
>>> approximation which
>>> +     * only really helps the most likely case, but is at least 
>>> trivially easy.
>>> +     */
>>> +    if (limit_pfn > iovad->dma_32bit_pfn)
>>> +        return &iovad->anchor.node;
>>> +
>>> +    node = iovad->rbroot.rb_node;
>>> +    while (to_iova(node)->pfn_hi < limit_pfn)
>>> +        node = node->rb_right;
>>> +
>>> +search_left:
>>> +    while (node->rb_left && to_iova(node->rb_left)->pfn_lo >= 
>>> limit_pfn)
>>> +        node = node->rb_left;
>>> +
>>> +    if (!node->rb_left)
>>> +        return node;
>>> +
>>> +    next = node->rb_left;
>>> +    while (next->rb_right) {
>>> +        next = next->rb_right;
>>> +        if (to_iova(next)->pfn_lo >= limit_pfn) {
>>> +            node = next;
>>> +            goto search_left;
>>> +        }
>>> +    }
>>> +
>>> +    return node;
>>> +}
>>> +
>>>   /* Insert the iova into domain rbtree by holding writer lock */
>>>   static void
>>>   iova_insert_rbtree(struct rb_root *root, struct iova *iova,
>>> @@ -219,7 +256,7 @@ static int __alloc_and_insert_iova_range(struct 
>>> iova_domain *iovad,
>>>           if (low_pfn == iovad->start_pfn && retry_pfn < limit_pfn) {
>>>               high_pfn = limit_pfn;
>>>               low_pfn = retry_pfn;
>>> -            curr = &iovad->anchor.node;
>>> +            curr = iova_find_limit(iovad, limit_pfn);


I see that it is now applied. However, alternatively could we just add a 
zero-length 32b boundary marker node for the 32b pfn restart point?

>>>               curr_iova = to_iova(curr);
>>>               goto retry;
>>>           }
>>>
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>> .
> 

