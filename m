Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C8F3F15A8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbhHSI7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:59:55 -0400
Received: from foss.arm.com ([217.140.110.172]:33232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229990AbhHSI7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:59:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1DF01FB;
        Thu, 19 Aug 2021 01:59:17 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68EFE3F40C;
        Thu, 19 Aug 2021 01:59:16 -0700 (PDT)
Subject: Re: [PATCH v6 2/7] dma-iommu: fix arch_sync_dma for map
To:     David Stevens <stevensd@chromium.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210817013852.3222824-1-stevensd@google.com>
 <20210817013852.3222824-3-stevensd@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0725585f-525b-d689-4b63-8ffeedfe87d9@arm.com>
Date:   Thu, 19 Aug 2021 09:59:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817013852.3222824-3-stevensd@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-17 02:38, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> When calling arch_sync_dma, we need to pass it the memory that's
> actually being used for dma. When using swiotlb bounce buffers, this is
> the bounce buffer. Move arch_sync_dma into the __iommu_dma_map_swiotlb
> helper, so it can use the bounce buffer address if necessary.
> 
> Now that iommu_dma_map_sg delegates to a function which takes care of
> architectural syncing in the untrusted device case, the call to
> iommu_dma_sync_sg_for_device can be moved so it only occurs for trusted
> devices. Doing the sync for untrusted devices before mapping never
> really worked, since it needs to be able to target swiotlb buffers.
> 
> This also moves the architectural sync to before the call to
> __iommu_dma_map, to guarantee that untrusted devices can't see stale
> data they shouldn't see.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
> Signed-off-by: David Stevens <stevensd@chromium.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 968e0150c95e..8098ce593640 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -576,6 +576,9 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>   		memset(padding_start, 0, padding_size);
>   	}
>   
> +	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		arch_sync_dma_for_device(phys, org_size, dir);
> +
>   	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
>   	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
>   		swiotlb_tbl_unmap_single(dev, phys, org_size, dir, attrs);
> @@ -842,14 +845,9 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   {
>   	phys_addr_t phys = page_to_phys(page) + offset;
>   	bool coherent = dev_is_dma_coherent(dev);
> -	dma_addr_t dma_handle;
>   
> -	dma_handle = __iommu_dma_map_swiotlb(dev, phys, size, dma_get_mask(dev),
> +	return __iommu_dma_map_swiotlb(dev, phys, size, dma_get_mask(dev),
>   			coherent, dir, attrs);
> -	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> -	    dma_handle != DMA_MAPPING_ERROR)
> -		arch_sync_dma_for_device(phys, size, dir);
> -	return dma_handle;
>   }
>   
>   static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
> @@ -992,12 +990,12 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	    iommu_deferred_attach(dev, domain))
>   		return 0;
>   
> -	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> -		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
> -
>   	if (dev_is_untrusted(dev))
>   		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
>   
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
> +
>   	/*
>   	 * Work out how much IOVA space we need, and align the segments to
>   	 * IOVA granules for the IOMMU driver to handle. With some clever
> 
