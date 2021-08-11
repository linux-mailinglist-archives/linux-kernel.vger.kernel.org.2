Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DB43E9828
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 21:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhHKTBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 15:01:07 -0400
Received: from foss.arm.com ([217.140.110.172]:56564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230224AbhHKTBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:01:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27FADD6E;
        Wed, 11 Aug 2021 12:00:42 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FA263F40C;
        Wed, 11 Aug 2021 12:00:40 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] dma-iommu: add SKIP_CPU_SYNC after syncing
To:     David Stevens <stevensd@chromium.org>,
        Will Deacon <will@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210811024247.1144246-1-stevensd@google.com>
 <20210811024247.1144246-4-stevensd@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d8f07858-e8e7-9989-b95f-c512ba3904cf@arm.com>
Date:   Wed, 11 Aug 2021 20:00:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811024247.1144246-4-stevensd@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-11 03:42, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> After syncing in map/unmap, add the DMA_ATTR_SKIP_CPU_SYNC flag so
> anything that uses attrs later on will skip any sync work that has
> already been completed. In particular, this skips copying from the
> swiotlb twice during unmap.
> 
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>   drivers/iommu/dma-iommu.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 4f0cc4a0a61f..be0214b1455c 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -859,8 +859,11 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
> -	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
>   		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
> +		attrs |= DMA_ATTR_SKIP_CPU_SYNC;
> +	}
> +
>   	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);

Again, fold that into here and put the arch sync in an else case to the 
is_swiotlb_buffer() check.

>   }
>   
> @@ -999,8 +1002,10 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	if (dev_is_untrusted(dev))
>   		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
>   
> -	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
>   		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
> +		attrs |= DMA_ATTR_SKIP_CPU_SYNC;
> +	}

Why? attrs is never referenced again after this.

>   	/*
>   	 * Work out how much IOVA space we need, and align the segments to
> @@ -1068,8 +1073,10 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   	struct scatterlist *tmp;
>   	int i;
>   
> -	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
>   		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
> +		attrs |= DMA_ATTR_SKIP_CPU_SYNC;
> +	}

Just move it down so it's out of the SWIOTLB path entirely. Exactly like 
you did in patch #2 for map_sg, conspicuous in the hunk above.

Robin.

>   
>   	if (dev_is_untrusted(dev)) {
>   		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
> 
