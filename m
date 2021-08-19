Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE693F15B5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 11:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbhHSJEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 05:04:00 -0400
Received: from foss.arm.com ([217.140.110.172]:33362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhHSJDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:03:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 312251FB;
        Thu, 19 Aug 2021 02:03:18 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5C243F66F;
        Thu, 19 Aug 2021 02:03:16 -0700 (PDT)
Subject: Re: [PATCH v6 7/7] dma-iommu: account for min_align_mask
To:     David Stevens <stevensd@chromium.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210817013852.3222824-1-stevensd@google.com>
 <20210817013852.3222824-8-stevensd@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f64b1349-d271-7b57-0eea-276dda065a87@arm.com>
Date:   Thu, 19 Aug 2021 10:03:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817013852.3222824-8-stevensd@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-17 02:38, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> For devices which set min_align_mask, swiotlb preserves the offset of
> the original physical address within that mask. Since __iommu_dma_map
> accounts for non-aligned addresses, passing a non-aligned swiotlb
> address with the swiotlb aligned size results in the offset being
> accounted for twice in the size passed to iommu_map_atomic. The extra
> page exposed to DMA is also not cleaned up by __iommu_dma_unmap, since
> that function unmaps with the correct size. This causes mapping failures
> if the iova gets reused, due to collisions in the iommu page tables.
> 
> To fix this, pass the original size to __iommu_dma_map, since that
> function already handles alignment.
> 
> Additionally, when swiotlb returns non-aligned addresses, there is
> padding at the start of the bounce buffer that needs to be cleared.
> 
> Fixes: 1f221a0d0dbf ("swiotlb: respect min_align_mask")
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>   drivers/iommu/dma-iommu.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 6738420fc081..f2fb360c2907 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -788,7 +788,6 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	struct iova_domain *iovad = &cookie->iovad;
> -	size_t aligned_size = size;
>   	dma_addr_t iova, dma_mask = dma_get_mask(dev);
>   
>   	/*
> @@ -796,8 +795,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   	 * page aligned, we don't need to use a bounce page.
>   	 */
>   	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) {
> -		void *padding_start;
> -		size_t padding_size;
> +		void *tlb_start;
> +		size_t aligned_size, iova_off, mapping_end_off;
>   
>   		aligned_size = iova_align(iovad, size);
>   		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
> @@ -806,23 +805,26 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   		if (phys == DMA_MAPPING_ERROR)
>   			return DMA_MAPPING_ERROR;
>   
> -		/* Cleanup the padding area. */
> -		padding_start = phys_to_virt(phys);
> -		padding_size = aligned_size;
> +		iova_off = iova_offset(iovad, phys);
> +		tlb_start = phys_to_virt(phys - iova_off);
>   
>   		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>   		    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)) {
> -			padding_start += size;
> -			padding_size -= size;
> +			/* Cleanup the padding area. */
> +			mapping_end_off = iova_off + size;
> +			memset(tlb_start, 0, iova_off);
> +			memset(tlb_start + mapping_end_off, 0,
> +			       aligned_size - mapping_end_off);
> +		} else {
> +			/* Nothing was sync'ed, so clear the whole buffer. */
> +			memset(tlb_start, 0, aligned_size);
>   		}
> -
> -		memset(padding_start, 0, padding_size);
>   	}
>   
>   	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>   		arch_sync_dma_for_device(phys, size, dir);
>   
> -	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
> +	iova = __iommu_dma_map(dev, phys, size, prot, dma_mask);

I still don't see how this preserves min_align_mask if it is larger than 
the IOVA granule (either way this change here does nothing since the 
first thing __iommu_dma_map() does is iova_align() the size right back 
anyway).

Robin.

>   	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
>   		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
>   	return iova;
> 
