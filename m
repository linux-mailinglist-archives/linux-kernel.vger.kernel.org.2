Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4953C18A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 19:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhGHRvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 13:51:49 -0400
Received: from foss.arm.com ([217.140.110.172]:35644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhGHRvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 13:51:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F741ED1;
        Thu,  8 Jul 2021 10:49:06 -0700 (PDT)
Received: from [10.57.35.192] (unknown [10.57.35.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54A7F3F66F;
        Thu,  8 Jul 2021 10:49:05 -0700 (PDT)
Subject: Re: [PATCH 2/2] dma-iommu: Check CONFIG_SWIOTLB more broadly
To:     David Stevens <stevensd@chromium.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Tom Murphy <murphyt7@tcd.ie>
References: <20210702053742.842850-1-stevensd@google.com>
 <20210702053742.842850-2-stevensd@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <aa5271cc-b555-50eb-7a45-b9bbec92d97c@arm.com>
Date:   Thu, 8 Jul 2021 18:49:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702053742.842850-2-stevensd@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-02 06:37, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Add check for CONFIG_SWIOTLB to dev_is_untrusted, so that swiotlb
> related code can be removed more aggressively.

Seems logical, and I think the new name is secretly the best part since 
it clarifies the intent of 90% of the callers. However...

> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>   drivers/iommu/dma-iommu.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 24d1042cd052..614f0dd86b08 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -310,9 +310,10 @@ static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
>   	domain->ops->flush_iotlb_all(domain);
>   }
>   
> -static bool dev_is_untrusted(struct device *dev)
> +static bool dev_use_swiotlb(struct device *dev)
>   {
> -	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
> +	return IS_ENABLED(CONFIG_SWIOTLB) &&
> +	       dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
>   }
>   
>   /**
> @@ -368,7 +369,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>   
>   	init_iova_domain(iovad, 1UL << order, base_pfn);
>   
> -	if (!cookie->fq_domain && (!dev || !dev_is_untrusted(dev)) &&
> +	if (!cookie->fq_domain && (!dev || !dev_use_swiotlb(dev)) &&

...this one is unrelated to SWIOTLB. Even when we can't use bouncing to 
fully mitigate untrusted devices, it still makes sense to impose strict 
invalidation on them. Maybe we can keep dev_is_untrusted() and define 
dev_use_swiotlb() in terms of it?

Robin.

>   	    domain->ops->flush_iotlb_all && !iommu_get_dma_strict(domain)) {
>   		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
>   					  iommu_dma_entry_dtor))
> @@ -553,8 +554,7 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>   	 * If both the physical buffer start address and size are
>   	 * page aligned, we don't need to use a bounce page.
>   	 */
> -	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
> -	    iova_offset(iovad, phys | org_size)) {
> +	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | org_size)) {
>   		aligned_size = iova_align(iovad, org_size);
>   		phys = swiotlb_tbl_map_single(dev, phys, org_size,
>   					      aligned_size, dir,
> @@ -779,7 +779,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
>   {
>   	phys_addr_t phys;
>   
> -	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
> +	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
>   		return;
>   
>   	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
> @@ -794,7 +794,7 @@ static void __iommu_dma_sync_single_for_device(struct device *dev,
>   		dma_addr_t dma_handle, size_t size,
>   		enum dma_data_direction dir, phys_addr_t phys)
>   {
> -	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
> +	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
>   		return;
>   
>   	if (phys == 0)
> @@ -821,10 +821,10 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
>   	struct scatterlist *sg;
>   	int i;
>   
> -	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
> +	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
>   		return;
>   
> -	if (dev_is_untrusted(dev))
> +	if (dev_use_swiotlb(dev))
>   		for_each_sg(sgl, sg, nelems, i)
>   			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
>   						      sg->length, dir);
> @@ -840,10 +840,10 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
>   	struct scatterlist *sg;
>   	int i;
>   
> -	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
> +	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
>   		return;
>   
> -	if (dev_is_untrusted(dev))
> +	if (dev_use_swiotlb(dev))
>   		for_each_sg(sgl, sg, nelems, i)
>   			__iommu_dma_sync_single_for_device(dev,
>   							   sg_dma_address(sg),
> @@ -1010,7 +1010,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	    iommu_deferred_attach(dev, domain))
>   		return 0;
>   
> -	if (dev_is_untrusted(dev)) {
> +	if (dev_use_swiotlb(dev)) {
>   		early_mapped = iommu_dma_map_sg_swiotlb(dev, sg, nents,
>   							dir, attrs);
>   		if (!early_mapped)
> @@ -1092,7 +1092,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>   		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
>   
> -	if (dev_is_untrusted(dev)) {
> +	if (dev_use_swiotlb(dev)) {
>   		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
>   		return;
>   	}
> 
