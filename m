Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF1C3E9836
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 21:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhHKTCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 15:02:46 -0400
Received: from foss.arm.com ([217.140.110.172]:56610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhHKTCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:02:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 805DED6E;
        Wed, 11 Aug 2021 12:02:21 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3480B3F40C;
        Wed, 11 Aug 2021 12:02:20 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] dma-iommu: Check CONFIG_SWIOTLB more broadly
To:     David Stevens <stevensd@chromium.org>,
        Will Deacon <will@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210811024247.1144246-1-stevensd@google.com>
 <20210811024247.1144246-5-stevensd@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <681553ad-df37-a469-8cbd-51e321e5b087@arm.com>
Date:   Wed, 11 Aug 2021 20:02:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811024247.1144246-5-stevensd@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-11 03:42, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Introduce a new dev_use_swiotlb function to guard swiotlb code, instead
> of overloading dev_is_untrusted. This allows CONFIG_SWIOTLB to be
> checked more broadly, so the swiotlb related code can be removed more
> aggressively.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>   drivers/iommu/dma-iommu.c | 24 ++++++++++++++----------
>   1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index be0214b1455c..89b689bf801f 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -317,6 +317,11 @@ static bool dev_is_untrusted(struct device *dev)
>   	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
>   }
>   
> +static bool dev_use_swiotlb(struct device *dev)
> +{
> +	return IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev);
> +}
> +
>   /**
>    * iommu_dma_init_domain - Initialise a DMA mapping domain
>    * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
> @@ -553,8 +558,7 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>   	 * If both the physical buffer start address and size are
>   	 * page aligned, we don't need to use a bounce page.
>   	 */
> -	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
> -	    iova_offset(iovad, phys | org_size)) {
> +	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | org_size)) {
>   		aligned_size = iova_align(iovad, org_size);
>   		phys = swiotlb_tbl_map_single(dev, phys, org_size,
>   					      aligned_size, dir, attrs);
> @@ -779,7 +783,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
>   {
>   	phys_addr_t phys;
>   
> -	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
> +	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
>   		return;
>   
>   	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
> @@ -795,7 +799,7 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
>   {
>   	phys_addr_t phys;
>   
> -	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
> +	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
>   		return;
>   
>   	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
> @@ -813,10 +817,10 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
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
> @@ -832,10 +836,10 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
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
>   			iommu_dma_sync_single_for_device(dev,
>   							 sg_dma_address(sg),
> @@ -999,7 +1003,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	    iommu_deferred_attach(dev, domain))
>   		return 0;
>   
> -	if (dev_is_untrusted(dev))
> +	if (dev_use_swiotlb(dev))
>   		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
>   
>   	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
> @@ -1078,7 +1082,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
>   		attrs |= DMA_ATTR_SKIP_CPU_SYNC;
>   	}
>   
> -	if (dev_is_untrusted(dev)) {
> +	if (dev_use_swiotlb(dev)) {
>   		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
>   		return;
>   	}
> 
