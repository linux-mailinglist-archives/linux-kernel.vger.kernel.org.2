Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC02399D6D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 11:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhFCJKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 05:10:22 -0400
Received: from foss.arm.com ([217.140.110.172]:36052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhFCJKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:10:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9098A11FB;
        Thu,  3 Jun 2021 02:08:37 -0700 (PDT)
Received: from [10.57.73.64] (unknown [10.57.73.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D83823F774;
        Thu,  3 Jun 2021 02:08:35 -0700 (PDT)
Subject: Re: [PATCH v1 6/8] dma: Add return value to dma_unmap_page
To:     Andi Kleen <ak@linux.intel.com>, mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-7-ak@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c3b15bc2-104b-dace-1f23-608197b18107@arm.com>
Date:   Thu, 3 Jun 2021 10:08:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210603004133.4079390-7-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On 2021-06-03 01:41, Andi Kleen wrote:
> In some situations when we know swiotlb is forced and we have
> to deal with untrusted hosts, it's useful to know if a mapping
> was in the swiotlb or not. This allows us to abort any IO
> operation that would access memory outside the swiotlb.
> 
> Otherwise it might be possible for a malicious host to inject
> any guest page in a read operation. While it couldn't directly
> access the results of the read() inside the guest, there
> might scenarios where data is echoed back with a write(),
> and that would then leak guest memory.
> 
> Add a return value to dma_unmap_single/page. Most users
> of course will ignore it. The return value is set to EIO
> if we're in forced swiotlb mode and the buffer is not inside
> the swiotlb buffer. Otherwise it's always 0.

I have to say my first impression of this isn't too good :(

What it looks like to me is abusing SWIOTLB's internal housekeeping to 
keep track of virtio-specific state. The DMA API does not attempt to 
validate calls in general since in many cases the additional overhead 
would be prohibitive. It has always been callers' responsibility to keep 
track of what they mapped and make sure sync/unmap calls match, and 
there are many, many, subtle and not-so-subtle ways for things to go 
wrong if they don't. If virtio is not doing a good enough job of that, 
what's the justification for making it the DMA API's problem?

> A new callback is used to avoid changing all the IOMMU drivers.

Nit: presumably by "IOMMU drivers" you actually mean arch DMA API backends?

As an aside, we'll take a look at the rest of the series for the 
perspective of our prototyping for Arm's Confidential Compute 
Architecture, but I'm not sure we'll need it, since accesses beyond the 
bounds of the shared SWIOTLB buffer shouldn't be an issue for us. 
Furthermore, AFAICS it's still not going to help against exfiltrating 
guest memory by over-unmapping the original SWIOTLB slot *without* going 
past the end of the whole buffer, but I think Martin's patch *has* 
addressed that already.

Robin.

> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>   drivers/iommu/dma-iommu.c   | 17 +++++++++++------
>   include/linux/dma-map-ops.h |  3 +++
>   include/linux/dma-mapping.h |  7 ++++---
>   kernel/dma/mapping.c        |  6 +++++-
>   4 files changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 7ef13198721b..babe46f2ae3a 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -491,7 +491,8 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
>   	iommu_dma_free_iova(cookie, dma_addr, size, iotlb_gather.freelist);
>   }
>   
> -static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
> +static int __iommu_dma_unmap_swiotlb_check(struct device *dev,
> +		dma_addr_t dma_addr,
>   		size_t size, enum dma_data_direction dir,
>   		unsigned long attrs)
>   {
> @@ -500,12 +501,15 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
>   
>   	phys = iommu_iova_to_phys(domain, dma_addr);
>   	if (WARN_ON(!phys))
> -		return;
> +		return -EIO;
>   
>   	__iommu_dma_unmap(dev, dma_addr, size);
>   
>   	if (unlikely(is_swiotlb_buffer(phys, size)))
>   		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
> +	else if (swiotlb_force == SWIOTLB_FORCE)
> +		return -EIO;
> +	return 0;
>   }
>   
>   static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> @@ -856,12 +860,13 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   	return dma_handle;
>   }
>   
> -static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
> +static int iommu_dma_unmap_page_check(struct device *dev, dma_addr_t dma_handle,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
>   	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>   		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
> -	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);
> +	return __iommu_dma_unmap_swiotlb_check(dev, dma_handle, size, dir,
> +					       attrs);
>   }
>   
>   /*
> @@ -946,7 +951,7 @@ static void iommu_dma_unmap_sg_swiotlb(struct device *dev, struct scatterlist *s
>   	int i;
>   
>   	for_each_sg(sg, s, nents, i)
> -		__iommu_dma_unmap_swiotlb(dev, sg_dma_address(s),
> +		__iommu_dma_unmap_swiotlb_check(dev, sg_dma_address(s),
>   				sg_dma_len(s), dir, attrs);
>   }
>   
> @@ -1291,7 +1296,7 @@ static const struct dma_map_ops iommu_dma_ops = {
>   	.mmap			= iommu_dma_mmap,
>   	.get_sgtable		= iommu_dma_get_sgtable,
>   	.map_page		= iommu_dma_map_page,
> -	.unmap_page		= iommu_dma_unmap_page,
> +	.unmap_page_check	= iommu_dma_unmap_page_check,
>   	.map_sg			= iommu_dma_map_sg,
>   	.unmap_sg		= iommu_dma_unmap_sg,
>   	.sync_single_for_cpu	= iommu_dma_sync_single_for_cpu,
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 0d53a96a3d64..0ed0190f7949 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -69,6 +69,9 @@ struct dma_map_ops {
>   	u64 (*get_required_mask)(struct device *dev);
>   	size_t (*max_mapping_size)(struct device *dev);
>   	unsigned long (*get_merge_boundary)(struct device *dev);
> +	int (*unmap_page_check)(struct device *dev, dma_addr_t dma_handle,
> +			size_t size, enum dma_data_direction dir,
> +			unsigned long attrs);
>   };
>   
>   #ifdef CONFIG_DMA_OPS
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 37fbd12bd4ab..25b8382f8601 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -103,7 +103,7 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>   dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
>   		size_t offset, size_t size, enum dma_data_direction dir,
>   		unsigned long attrs);
> -void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
> +int dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
>   		enum dma_data_direction dir, unsigned long attrs);
>   int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>   		enum dma_data_direction dir, unsigned long attrs);
> @@ -160,9 +160,10 @@ static inline dma_addr_t dma_map_page_attrs(struct device *dev,
>   {
>   	return DMA_MAPPING_ERROR;
>   }
> -static inline void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr,
> +static inline int dma_unmap_page_attrs(struct device *dev, dma_addr_t addr,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
> +	return 0;
>   }
>   static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>   		int nents, enum dma_data_direction dir, unsigned long attrs)
> @@ -323,7 +324,7 @@ static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
>   			size, dir, attrs);
>   }
>   
> -static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
> +static inline int dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
>   	return dma_unmap_page_attrs(dev, addr, size, dir, attrs);
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 9bf02c8d7d1b..dc0ce649d1f9 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -162,18 +162,22 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
>   }
>   EXPORT_SYMBOL(dma_map_page_attrs);
>   
> -void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
> +int dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
>   		enum dma_data_direction dir, unsigned long attrs)
>   {
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
> +	int ret = 0;
>   
>   	BUG_ON(!valid_dma_direction(dir));
>   	if (dma_map_direct(dev, ops) ||
>   	    arch_dma_unmap_page_direct(dev, addr + size))
>   		dma_direct_unmap_page(dev, addr, size, dir, attrs);
> +	else if (ops->unmap_page_check)
> +		ret = ops->unmap_page_check(dev, addr, size, dir, attrs);
>   	else if (ops->unmap_page)
>   		ops->unmap_page(dev, addr, size, dir, attrs);
>   	debug_dma_unmap_page(dev, addr, size, dir);
> +	return ret;
>   }
>   EXPORT_SYMBOL(dma_unmap_page_attrs);
>   
> 
