Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17ECB3E97E8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhHKSry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:47:54 -0400
Received: from foss.arm.com ([217.140.110.172]:56300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhHKSrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:47:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9387D6E;
        Wed, 11 Aug 2021 11:47:29 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFD193F40C;
        Wed, 11 Aug 2021 11:47:27 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] dma-iommu: fix arch_sync_dma for map
To:     David Stevens <stevensd@chromium.org>,
        Will Deacon <will@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210811024247.1144246-1-stevensd@google.com>
 <20210811024247.1144246-3-stevensd@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5b4fd891-a86a-42cd-5b69-bc08d351dd3a@arm.com>
Date:   Wed, 11 Aug 2021 19:47:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811024247.1144246-3-stevensd@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-11 03:42, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> When calling arch_sync_dma, we need to pass it the memory that's
> actually being used for dma. When using swiotlb bounce buffers, this is
> the bounce buffer. Move arch_sync_dma into the __iommu_dma_map_swiotlb
> helper, so it can use the bounce buffer address if necessary. This also
> means it is no longer necessary to call iommu_dma_sync_sg_for_device in
> iommu_dma_map_sg for untrusted devices.
> 
> Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>   drivers/iommu/dma-iommu.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 54e103b989d9..4f0cc4a0a61f 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -576,6 +576,9 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>   		memset(padding_start, 0, padding_size);
>   	}
>   
> +	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))

Make that an "else if" - otherwise you're just reintroducing the same 
thing that the third hunk is trying to clean up.

> +		arch_sync_dma_for_device(phys, org_size, dir);
> +
>   	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
>   	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
>   		swiotlb_tbl_unmap_single(dev, phys, org_size, dir, attrs);
> @@ -848,14 +851,9 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   {
>   	phys_addr_t phys = page_to_phys(page) + offset;
>   	bool coherent = dev_is_dma_coherent(dev);
> -	dma_addr_t dma_handle;
>   
> -	dma_handle = __iommu_dma_map_swiotlb(dev, phys, size, dma_get_mask(dev),
> +	return __iommu_dma_map_swiotlb(dev, phys, size, dma_get_mask(dev),
>   			coherent, dir, attrs);

Just fold __iommu_dma_map_swiotlb() back into here and have 
iommu_dma_map_sg_swiotlb() call iommu_dma_map_page() in the typical 
pattern of dma-direct and others. Apparently the only purpose served by 
that indirection was allowing these bugs to exist...

Robin.

> -	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> -	    dma_handle != DMA_MAPPING_ERROR)
> -		arch_sync_dma_for_device(phys, size, dir);
> -	return dma_handle;
>   }
>   
>   static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
> @@ -998,12 +996,12 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
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
