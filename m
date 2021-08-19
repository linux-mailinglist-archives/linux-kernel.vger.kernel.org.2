Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6BE3F15AB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbhHSJA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 05:00:28 -0400
Received: from foss.arm.com ([217.140.110.172]:33262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236353AbhHSJA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:00:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C4D01FB;
        Thu, 19 Aug 2021 01:59:50 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1444F3F40C;
        Thu, 19 Aug 2021 01:59:48 -0700 (PDT)
Subject: Re: [PATCH v6 3/7] dma-iommu: skip extra sync during unmap w/swiotlb
To:     David Stevens <stevensd@chromium.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210817013852.3222824-1-stevensd@google.com>
 <20210817013852.3222824-4-stevensd@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c1febb7b-8a79-c94b-5358-b6fb38c5a194@arm.com>
Date:   Thu, 19 Aug 2021 09:59:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210817013852.3222824-4-stevensd@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-17 02:38, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Calling the iommu_dma_sync_*_for_cpu functions during unmap can cause
> two copies out of the swiotlb buffer. Do the arch sync directly in
> __iommu_dma_unmap_swiotlb instead to avoid this. This makes the call to
> iommu_dma_sync_sg_for_cpu for untrusted devices in iommu_dma_unmap_sg no
> longer necessary, so move that invocation later in the function.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: David Stevens <stevensd@chromium.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 8098ce593640..5dd2c517dbf5 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -504,6 +504,9 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
>   	if (WARN_ON(!phys))
>   		return;
>   
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) && !dev_is_dma_coherent(dev))
> +		arch_sync_dma_for_cpu(phys, size, dir);
> +
>   	__iommu_dma_unmap(dev, dma_addr, size);
>   
>   	if (unlikely(is_swiotlb_buffer(phys)))
> @@ -853,8 +856,6 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
> -	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> -		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
>   	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);
>   }
>   
> @@ -1062,14 +1063,14 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   	struct scatterlist *tmp;
>   	int i;
>   
> -	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> -		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
> -
>   	if (dev_is_untrusted(dev)) {
>   		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
>   		return;
>   	}
>   
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
> +
>   	/*
>   	 * The scatterlist segments are mapped into a single
>   	 * contiguous IOVA allocation, so this is incredibly easy.
> 
