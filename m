Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D303A7E56
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFOMoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:44:05 -0400
Received: from foss.arm.com ([217.140.110.172]:34450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230175AbhFOMoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:44:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EBC51063;
        Tue, 15 Jun 2021 05:41:59 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FDAC3F719;
        Tue, 15 Jun 2021 05:41:58 -0700 (PDT)
Subject: Re: [PATCH v3 3/6] iommu: Improve iommu_iotlb_gather helpers
To:     Yong Wu <yong.wu@mediatek.com>, Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Jiajun Cao <caojiajun@vmware.com>,
        Will Deacon <will@kernel.org>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-4-namit@vmware.com>
 <1623760166.24285.1.camel@mhfsdcap03>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5f176808-20ab-1d51-fcae-eb2307117f5b@arm.com>
Date:   Tue, 15 Jun 2021 13:41:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1623760166.24285.1.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-15 13:29, Yong Wu wrote:
> On Mon, 2021-06-07 at 11:25 -0700, Nadav Amit wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>>
>> The Mediatek driver is not the only one which might want a basic
>> address-based gathering behaviour, so although it's arguably simple
>> enough to open-code, let's factor it out for the sake of cleanliness.
>> Let's also take this opportunity to document the intent of these
>> helpers for clarity.
>>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Jiajun Cao <caojiajun@vmware.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>> Cc: iommu@lists.linux-foundation.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>
>> ---
>>
>> Changes from Robin's version:
>> * Added iommu_iotlb_gather_add_range() stub !CONFIG_IOMMU_API
>> * Use iommu_iotlb_gather_add_range() in iommu_iotlb_gather_add_page()
>> ---
>>   drivers/iommu/mtk_iommu.c |  5 +----
>>   include/linux/iommu.h     | 43 ++++++++++++++++++++++++++++++++++-----
>>   2 files changed, 39 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>> index e06b8a0e2b56..0af4a91ac7da 100644
>> --- a/drivers/iommu/mtk_iommu.c
>> +++ b/drivers/iommu/mtk_iommu.c
>> @@ -523,10 +523,7 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
>>   	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
>>   	unsigned long end = iova + size - 1;
> 
> Please also help delete this "end".

Yes, that was part of my original patch - not sure what happened here :/

Robin.

>>   
>> -	if (gather->start > iova)
>> -		gather->start = iova;
>> -	if (gather->end < end)
>> -		gather->end = end;
>> +	iommu_iotlb_gather_add_range(gather, iova, size);
>>   	return dom->iop->unmap(dom->iop, iova, size, gather);
>>   }
> 
> [snip]
> 
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
