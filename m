Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED813A7C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 12:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhFOKpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 06:45:07 -0400
Received: from foss.arm.com ([217.140.110.172]:59552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231374AbhFOKpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:45:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74DB3D6E;
        Tue, 15 Jun 2021 03:43:01 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DB1C3F694;
        Tue, 15 Jun 2021 03:43:00 -0700 (PDT)
Subject: Re: [PATCH v3 3/6] iommu: Improve iommu_iotlb_gather helpers
To:     Nadav Amit <nadav.amit@gmail.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Jiajun Cao <caojiajun@vmware.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-4-namit@vmware.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <07969028-d807-cad1-2a01-8efc87390157@arm.com>
Date:   Tue, 15 Jun 2021 11:42:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210607182541.119756-4-namit@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-07 19:25, Nadav Amit wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> The Mediatek driver is not the only one which might want a basic
> address-based gathering behaviour, so although it's arguably simple
> enough to open-code, let's factor it out for the sake of cleanliness.
> Let's also take this opportunity to document the intent of these
> helpers for clarity.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jiajun Cao <caojiajun@vmware.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Nit: missing your signoff.

> ---
> 
> Changes from Robin's version:
> * Added iommu_iotlb_gather_add_range() stub !CONFIG_IOMMU_API

Out of curiosity, is there any config in which a stub is actually 
needed? Unlike iommu_iotlb_gather_init(), I would have thought that 
these helpers should only ever be called by driver code which already 
depends on IOMMU_API.

Thanks,
Robin.

> * Use iommu_iotlb_gather_add_range() in iommu_iotlb_gather_add_page()
> ---
>   drivers/iommu/mtk_iommu.c |  5 +----
>   include/linux/iommu.h     | 43 ++++++++++++++++++++++++++++++++++-----
>   2 files changed, 39 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index e06b8a0e2b56..0af4a91ac7da 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -523,10 +523,7 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
>   	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
>   	unsigned long end = iova + size - 1;
>   
> -	if (gather->start > iova)
> -		gather->start = iova;
> -	if (gather->end < end)
> -		gather->end = end;
> +	iommu_iotlb_gather_add_range(gather, iova, size);
>   	return dom->iop->unmap(dom->iop, iova, size, gather);
>   }
>   
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 32d448050bf7..f254c62f3720 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -497,6 +497,38 @@ static inline void iommu_iotlb_sync(struct iommu_domain *domain,
>   	iommu_iotlb_gather_init(iotlb_gather);
>   }
>   
> +/**
> + * iommu_iotlb_gather_add_range - Gather for address-based TLB invalidation
> + * @gather: TLB gather data
> + * @iova: start of page to invalidate
> + * @size: size of page to invalidate
> + *
> + * Helper for IOMMU drivers to build arbitrarily-sized invalidation commands
> + * where only the address range matters, and simply minimising intermediate
> + * syncs is preferred.
> + */
> +static inline void iommu_iotlb_gather_add_range(struct iommu_iotlb_gather *gather,
> +						unsigned long iova, size_t size)
> +{
> +	unsigned long end = iova + size - 1;
> +
> +	if (gather->start > iova)
> +		gather->start = iova;
> +	if (gather->end < end)
> +		gather->end = end;
> +}
> +
> +/**
> + * iommu_iotlb_gather_add_page - Gather for page-based TLB invalidation
> + * @domain: IOMMU domain to be invalidated
> + * @gather: TLB gather data
> + * @iova: start of page to invalidate
> + * @size: size of page to invalidate
> + *
> + * Helper for IOMMU drivers to build invalidation commands based on individual
> + * pages, or with page size/table level hints which cannot be gathered if they
> + * differ.
> + */
>   static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
>   					       struct iommu_iotlb_gather *gather,
>   					       unsigned long iova, size_t size)
> @@ -515,11 +547,7 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
>   		gather->pgsize = size;
>   	}
>   
> -	if (gather->end < end)
> -		gather->end = end;
> -
> -	if (gather->start > start)
> -		gather->start = start;
> +	iommu_iotlb_gather_add_range(gather, iova, size);
>   }
>   
>   /* PCI device grouping function */
> @@ -702,6 +730,11 @@ static inline void iommu_iotlb_sync(struct iommu_domain *domain,
>   {
>   }
>   
> +static inline void iommu_iotlb_gather_add_range(struct iommu_iotlb_gather *gather,
> +						unsigned long iova, size_t size)
> +{
> +}
> +
>   static inline phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
>   {
>   	return 0;
> 
