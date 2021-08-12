Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68193EA28E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 11:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbhHLJ6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 05:58:09 -0400
Received: from foss.arm.com ([217.140.110.172]:41452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236556AbhHLJ6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:58:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14F831042;
        Thu, 12 Aug 2021 02:57:43 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D66923F718;
        Thu, 12 Aug 2021 02:57:41 -0700 (PDT)
Subject: Re: [PATCH v3 5/5] dma-iommu: account for min_align_mask
To:     David Stevens <stevensd@chromium.org>
Cc:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>
References: <20210811024247.1144246-1-stevensd@google.com>
 <20210811024247.1144246-6-stevensd@google.com>
 <b5fff839-3242-7080-13f7-61c0e40af304@arm.com>
 <CAD=HUj7u71cdPfJ5t2tC8A26YOgwDe8H7i-h78f_MeRmuNUySQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e69aa3e9-00c6-4551-2362-c88eb5f88721@arm.com>
Date:   Thu, 12 Aug 2021 10:57:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAD=HUj7u71cdPfJ5t2tC8A26YOgwDe8H7i-h78f_MeRmuNUySQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-12 02:45, David Stevens wrote:
> On Thu, Aug 12, 2021 at 4:12 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-08-11 03:42, David Stevens wrote:
>>> From: David Stevens <stevensd@chromium.org>
>>>
>>> For devices which set min_align_mask, swiotlb preserves the offset of
>>> the original physical address within that mask. Since __iommu_dma_map
>>> accounts for non-aligned addresses, passing a non-aligned swiotlb
>>> address with the swiotlb aligned size results in the offset being
>>> accounted for twice in the size passed to iommu_map_atomic. The extra
>>> page exposed to DMA is also not cleaned up by __iommu_dma_unmap, since
>>> tht at function unmaps with the correct size. This causes mapping failures
>>> if the iova gets reused, due to collisions in the iommu page tables.
>>>
>>> To fix this, pass the original size to __iommu_dma_map, since that
>>> function already handles alignment.
>>>
>>> Additionally, when swiotlb returns non-aligned addresses, there is
>>> padding at the start of the bounce buffer that needs to be cleared.
>>>
>>> Fixes: 1f221a0d0dbf ("swiotlb: respect min_align_mask")
>>> Signed-off-by: David Stevens <stevensd@chromium.org>
>>> ---
>>>    drivers/iommu/dma-iommu.c | 23 ++++++++++++-----------
>>>    1 file changed, 12 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index 89b689bf801f..ffa7e8ef5db4 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -549,9 +549,8 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>>>        struct iommu_domain *domain = iommu_get_dma_domain(dev);
>>>        struct iommu_dma_cookie *cookie = domain->iova_cookie;
>>>        struct iova_domain *iovad = &cookie->iovad;
>>> -     size_t aligned_size = org_size;
>>> -     void *padding_start;
>>> -     size_t padding_size;
>>> +     void *tlb_start;
>>> +     size_t aligned_size, iova_off, mapping_end_off;
>>>        dma_addr_t iova;
>>>
>>>        /*
>>> @@ -566,24 +565,26 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>>>                if (phys == DMA_MAPPING_ERROR)
>>>                        return DMA_MAPPING_ERROR;
>>>
>>> -             /* Cleanup the padding area. */
>>> -             padding_start = phys_to_virt(phys);
>>> -             padding_size = aligned_size;
>>> +             iova_off = iova_offset(iovad, phys);
>>> +             tlb_start = phys_to_virt(phys - iova_off);
>>>
>>> +             /* Cleanup the padding area. */
>>>                if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>>>                    (dir == DMA_TO_DEVICE ||
>>>                     dir == DMA_BIDIRECTIONAL)) {
>>> -                     padding_start += org_size;
>>> -                     padding_size -= org_size;
>>> +                     mapping_end_off = iova_off + org_size;
>>> +                     memset(tlb_start, 0, iova_off);
>>> +                     memset(tlb_start + mapping_end_off, 0,
>>> +                            aligned_size - mapping_end_off);
>>> +             } else {
>>> +                     memset(tlb_start, 0, aligned_size);
>>>                }
>>> -
>>> -             memset(padding_start, 0, padding_size);
>>>        }
>>>
>>>        if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>>>                arch_sync_dma_for_device(phys, org_size, dir);
>>>
>>> -     iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
>>> +     iova = __iommu_dma_map(dev, phys, org_size, prot, dma_mask);
>>
>> This doesn't feel right - what if the IOVA granule was equal to or
>> smaller than min_align_mask, wouldn't you potentially end up mapping the
>> padding rather than the data?
> 
> The phys value returned by swiotlb_tbl_map_single is the address of
> the start of the data in the swiotlb buffer, so the range that needs
> to be mapped is [phys, phys + org_size). __iommu_dma_map will handle
> this the same as it handles a misaligned mapping in the non-swiotlb
> case. It might map memory before/after the desired range, but it will
> map the entire range and iova will be the mapped address of phys. Is
> there something I'm missing there?

No, my bad - I overlooked that phys got rewritten, so that aspect is OK, 
but...

> That said, considering that memory before phys might be mapped, I
> think there is actually still a bug. The buffer allocated by swiotlb
> needs to be aligned to the granule size to ensure that preceding
> swiotlb slots aren't mapped. The swiotlb does align allocations larger
> than a page to PAGE_SIZE, but if IO_TLB_SIZE < IOVA granule <
> PAGE_SIZE, then there can be problems. That can't happen if PAGE_SIZE
> is 4k, but it can for larger page sizes. I'll add a fix for that to
> the next version of this series.

I was mainly thinking that we still need to map aligned_size (where that 
also accounts for min_align_mask) from tlb_start in order to guarantee 
that the buffer ends up at the right offset in IOVA space. I suppose 
technically we could be cleverer about only padding one thing or the 
other depending on the IOVA granule, but I'm not sure it's worth the 
bother of decoupling the IOMMU mapping from the IOVA allocation just for 
this niche case.

Robin.
