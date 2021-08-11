Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A003E9793
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhHKSWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:22:54 -0400
Received: from foss.arm.com ([217.140.110.172]:55934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhHKSWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:22:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61D69D6E;
        Wed, 11 Aug 2021 11:22:29 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A9E23F40C;
        Wed, 11 Aug 2021 11:22:28 -0700 (PDT)
Subject: Re: [PATCH v3 1/5] dma-iommu: fix sync_sg with swiotlb
To:     Christoph Hellwig <hch@infradead.org>,
        David Stevens <stevensd@chromium.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org
References: <20210811024247.1144246-1-stevensd@google.com>
 <20210811024247.1144246-2-stevensd@google.com>
 <YRNmxU9Ou2OcvBq2@infradead.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0340855f-def5-d5cf-0f2a-6d978df2c5c6@arm.com>
Date:   Wed, 11 Aug 2021 19:22:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRNmxU9Ou2OcvBq2@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-11 06:57, Christoph Hellwig wrote:
> On Wed, Aug 11, 2021 at 11:42:43AM +0900, David Stevens wrote:
>> From: David Stevens <stevensd@chromium.org>
>>
>> The is_swiotlb_buffer function takes the physical address of the swiotlb
>> buffer, not the physical address of the original buffer. The sglist
>> contains the physical addresses of the original buffer, so for the
>> sync_sg functions to work properly when a bounce buffer might have been
>> used, we need to use iommu_iova_to_phys to look up the physical address.
>> This is what sync_single does, so call that function on each sglist
>> segment.
>>
>> The previous code mostly worked because swiotlb does the transfer on map
>> and unmap. However, any callers which use DMA_ATTR_SKIP_CPU_SYNC with
>> sglists or which call sync_sg would not have had anything copied to the
>> bounce buffer.
>>
>> Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
>> Signed-off-by: David Stevens <stevensd@chromium.org>
>> ---
>>   drivers/iommu/dma-iommu.c | 27 +++++++++++++--------------
>>   1 file changed, 13 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 98ba927aee1a..54e103b989d9 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -813,14 +813,13 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
>>   	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
>>   		return;
>>   
>> +	if (dev_is_untrusted(dev))
>> +		for_each_sg(sgl, sg, nelems, i)
>> +			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
>> +						      sg->length, dir);
>> +	else
>> +		for_each_sg(sgl, sg, nelems, i)
>>   			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
>>   }
> 
> I'd remove the above check and fold the if (!dev_is_dma_coherent(dev))
> into the else line.  Same for iommu_dma_sync_sg_for_device.

+1

With those also cleaned up,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
