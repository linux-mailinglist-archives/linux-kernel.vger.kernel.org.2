Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5412331350
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhCHQYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:24:42 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2655 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhCHQYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:24:15 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DvNmq6Dy2z67wj5;
        Tue,  9 Mar 2021 00:18:19 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 17:24:13 +0100
Received: from [10.210.165.214] (10.210.165.214) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 16:24:12 +0000
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
 <d090b869-b3ac-fecc-9efd-d870e43e0d99@huawei.com>
 <eacd5ccd-ab5a-27fe-6542-deaefd597d11@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c58abbec-7220-b440-98d4-d1026a8feed4@huawei.com>
Date:   Mon, 8 Mar 2021 16:22:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <eacd5ccd-ab5a-27fe-6542-deaefd597d11@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.165.214]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2021 15:15, Robin Murphy wrote:
>> I figure that you're talking about 4e89dce72521 now. I would have 
>> liked to know which real-life problem it solved in practice.
> 
>  From what I remember, the problem reported was basically the one 
> illustrated in that commit and the one I alluded to above - namely that 
> certain allocation patterns with a broad mix of sizes and relative 
> lifetimes end up pushing the cached PFN down to the bottom of the 
> address space such that allocations start failing despite there still 
> being sufficient free space overall, which was breaking some media 
> workload. What was originally proposed was an overcomplicated palaver 
> with DMA attributes and a whole extra allocation algorithm rather than 
> just fixing the clearly unintended and broken behaviour.

ok, fine. I just wondered if this was a theoretical problem only.

> 
>>> While max32_alloc_size indirectly tracks the largest*contiguous* 
>>> available space, one of the ideas from which it grew was to simply keep
>>> count of the total number of free PFNs. If you're really spending
>>> significant time determining that the tree is full, as opposed to just
>>> taking longer to eventually succeed, then it might be relatively
>>> innocuous to tack on that semi-redundant extra accounting as a
>>> self-contained quick fix for that worst case.
>>>

...

>>
>> Even if it is were configurable, wouldn't it make sense to have it 
>> configurable per IOVA domain?
> 
> Perhaps, but I don't see that being at all easy to implement. We can't 
> arbitrarily *increase* the scope of caching once a domain is active due 
> to the size-rounding-up requirement, which would be prohibitive to 
> larger allocations if applied universally.
> 

Agreed.

But having that (all IOVAs sizes being cacheable) available could be 
really great, though, for some situations.

>> Furthermore, as mentioned above, I still want to solve this IOVA aging 
>> issue, and this fixed RCACHE RANGE size seems to be the at the center 
>> of that problem.
>>
>>>
>>>> As for 4e89dce72521, so even if it's proper to retry for a failed 
>>>> alloc,
>>>> it is not always necessary. I mean, if we're limiting ourselves to 32b
>>>> subspace for this SAC trick and we fail the alloc, then we can try the
>>>> space above 32b first (if usable). If that fails, then retry there. I
>>>> don't see a need to retry the 32b subspace if we're not limited to it.
>>>> How about it? We tried that idea and it looks to just about restore
>>>> performance.
>>> The thing is, if you do have an actual PCI device where DAC might mean a
>>> 33% throughput loss and you're mapping a long-lived buffer, or you're on
>>> one of these systems where firmware fails to document address limits and
>>> using the full IOMMU address width quietly breaks things, then you
>>> almost certainly*do*  want the allocator to actually do a proper job of
>>> trying to satisfy the given request.
>>
>> If those conditions were true, then it seems quite a tenuous position, 
>> so trying to help that scenario in general terms will have limited 
>> efficacy.
> 
> Still, I'd be curious to see if making the restart a bit cleverer offers 
> a noticeable improvement. IIRC I suggested it at the time, but in the 
> end the push was just to get *something* merged.

Sorry to say, I just tested that ("iommu/iova: Improve restart logic") 
and there is no obvious improvement.

I'll have a further look at what might be going on.

Thanks very much,
John
