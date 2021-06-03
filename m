Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E5A3997BF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 03:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhFCBvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 21:51:42 -0400
Received: from mail-qv1-f48.google.com ([209.85.219.48]:39458 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhFCBvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 21:51:41 -0400
Received: by mail-qv1-f48.google.com with SMTP id eb9so2444325qvb.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 18:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A5jFSAkEfzoPDzF2tYC9gryznUBk4WFIWwyTkqnypAk=;
        b=ksjTJUw8+GzcoidJIpun6CtJWtzTauUj+atJzClf1nhOD8Yi1OYY125VnQlDIefkYW
         lUynAheYsqtUMtBz0g1D/PuCKmsJlwHgUaYq/ZWpkyl6nGJrEyMLtTMVH3tmps5Wrv57
         yXY8ld5kvbVCT3qO2FLnppjbn8Ms6Yha9kknZRlLTKE0VngOxvLhmIs6tqiaNspwAifb
         ufy8cS07Rt+lb/kJucK75Ky83XOH/ZCIyXaaWTwpwD43Usi66/Io3uKpTYXt7axAMW9e
         eJk6qIkgbTg9ZgtMa58E0WuZl4PCyJHDOlF3zcZgsgq5Et7c9oV8ThnD7b8NtQn9Wfbe
         A8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=A5jFSAkEfzoPDzF2tYC9gryznUBk4WFIWwyTkqnypAk=;
        b=r0dpsRV+cZQjUCnDfREiwU7xVvLzYJ38CdYbOyWVPsYeRN5mUArqexIGaz7bTjQ8Wu
         hU3k0u1m4QezYD24T0bcTKAtCZ+L2uWCSLZyoEkfFC5BgGnOUtOoG7/UUq7V8g3XQzeK
         6cnD38XH6Mz1XeQIje/91jeWdmG21KUGNKsJnZCyjpHXbmncBh3dnS4Uc0ocYYf8bZ5L
         NVKFgDdc6XmZ/cNAQTxZ1+cDtnm3WejS35Ko3fVaTGF7cA+OfVopwuYd1M17yk8QnV7u
         T5jZ+JF0p90ZIx8eJnGI+i5CazQ6McjkAO/dlDp5Vn75aRN6MydrpSss+FXlCGDp3OKw
         TkRA==
X-Gm-Message-State: AOAM5330YqQQAwzbzgMiAOSQFew2RPzQkyYdpv/fBcDH6xMREBgdLl9Y
        koDDwNcY2NyX+st9pF2kSCU0XjAeRYU=
X-Google-Smtp-Source: ABdhPJxW+1WRG2zf6S5ApLPJB4Cwr+bZw6J2+bE7UtBwVGFlYEdAqIa2lk8IQJACMes19/WNZFZMKw==
X-Received: by 2002:a0c:83e1:: with SMTP id k88mr31613572qva.40.1622684922286;
        Wed, 02 Jun 2021 18:48:42 -0700 (PDT)
Received: from localhost.localdomain ([130.44.160.152])
        by smtp.gmail.com with ESMTPSA id h62sm1045259qkf.45.2021.06.02.18.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 18:48:41 -0700 (PDT)
Sender: Konrad Rzeszutek Wilk <konrad.r.wilk@gmail.com>
Date:   Wed, 2 Jun 2021 21:48:39 -0400
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/8] dma: Use size for swiotlb boundary checks
Message-ID: <YLg096ycQ60lcuHe@localhost.localdomain>
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-6-ak@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603004133.4079390-6-ak@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 05:41:30PM -0700, Andi Kleen wrote:
> swiotlb currently only uses the start address of a DMA to check if something
> is in the swiotlb or not. But with virtio and untrusted hosts the host
> could give some DMA mapping that crosses the swiotlb boundaries,
> potentially leaking or corrupting data. Add size checks to all the swiotlb
> checks and reject any DMAs that cross the swiotlb buffer boundaries.

I seem to be only CC-ed on this and #7, so please bear with me.

But could you explain to me why please:

commit daf9514fd5eb098d7d6f3a1247cb8cc48fc94155 (swiotlb/stable/for-linus-5.12)
Author: Martin Radev <martin.b.radev@gmail.com>
Date:   Tue Jan 12 16:07:29 2021 +0100

    swiotlb: Validate bounce size in the sync/unmap path

does not solve the problem as well?

> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  drivers/iommu/dma-iommu.c   | 13 ++++++-------
>  drivers/xen/swiotlb-xen.c   | 11 ++++++-----
>  include/linux/dma-mapping.h |  4 ++--
>  include/linux/swiotlb.h     |  8 +++++---
>  kernel/dma/direct.c         |  8 ++++----
>  kernel/dma/direct.h         |  8 ++++----
>  kernel/dma/mapping.c        |  4 ++--
>  net/xdp/xsk_buff_pool.c     |  2 +-
>  8 files changed, 30 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 7bcdd1205535..7ef13198721b 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -504,7 +504,7 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
>  
>  	__iommu_dma_unmap(dev, dma_addr, size);
>  
> -	if (unlikely(is_swiotlb_buffer(phys)))
> +	if (unlikely(is_swiotlb_buffer(phys, size)))
>  		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
>  }
>  
> @@ -575,7 +575,7 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>  	}
>  
>  	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
> -	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
> +	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys, org_size))
>  		swiotlb_tbl_unmap_single(dev, phys, org_size, dir, attrs);
>  	return iova;
>  }
> @@ -781,7 +781,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
>  	if (!dev_is_dma_coherent(dev))
>  		arch_sync_dma_for_cpu(phys, size, dir);
>  
> -	if (is_swiotlb_buffer(phys))
> +	if (is_swiotlb_buffer(phys, size))
>  		swiotlb_sync_single_for_cpu(dev, phys, size, dir);
>  }
>  
> @@ -794,7 +794,7 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
>  		return;
>  
>  	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
> -	if (is_swiotlb_buffer(phys))
> +	if (is_swiotlb_buffer(phys, size))
>  		swiotlb_sync_single_for_device(dev, phys, size, dir);
>  
>  	if (!dev_is_dma_coherent(dev))
> @@ -815,7 +815,7 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
>  		if (!dev_is_dma_coherent(dev))
>  			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
>  
> -		if (is_swiotlb_buffer(sg_phys(sg)))
> +		if (is_swiotlb_buffer(sg_phys(sg), sg->length))
>  			swiotlb_sync_single_for_cpu(dev, sg_phys(sg),
>  						    sg->length, dir);
>  	}
> @@ -832,10 +832,9 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
>  		return;
>  
>  	for_each_sg(sgl, sg, nelems, i) {
> -		if (is_swiotlb_buffer(sg_phys(sg)))
> +		if (is_swiotlb_buffer(sg_phys(sg), sg->length))
>  			swiotlb_sync_single_for_device(dev, sg_phys(sg),
>  						       sg->length, dir);
> -
>  		if (!dev_is_dma_coherent(dev))
>  			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
>  	}
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 24d11861ac7d..333846af8d35 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -89,7 +89,8 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
>  	return 0;
>  }
>  
> -static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
> +static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr,
> +				 size_t size)
>  {
>  	unsigned long bfn = XEN_PFN_DOWN(dma_to_phys(dev, dma_addr));
>  	unsigned long xen_pfn = bfn_to_local_pfn(bfn);
> @@ -100,7 +101,7 @@ static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
>  	 * in our domain. Therefore _only_ check address within our domain.
>  	 */
>  	if (pfn_valid(PFN_DOWN(paddr)))
> -		return is_swiotlb_buffer(paddr);
> +		return is_swiotlb_buffer(paddr, size);
>  	return 0;
>  }
>  
> @@ -431,7 +432,7 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
>  	}
>  
>  	/* NOTE: We use dev_addr here, not paddr! */
> -	if (is_xen_swiotlb_buffer(hwdev, dev_addr))
> +	if (is_xen_swiotlb_buffer(hwdev, dev_addr, size))
>  		swiotlb_tbl_unmap_single(hwdev, paddr, size, dir, attrs);
>  }
>  
> @@ -448,7 +449,7 @@ xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
>  			xen_dma_sync_for_cpu(dev, dma_addr, size, dir);
>  	}
>  
> -	if (is_xen_swiotlb_buffer(dev, dma_addr))
> +	if (is_xen_swiotlb_buffer(dev, dma_addr, size))
>  		swiotlb_sync_single_for_cpu(dev, paddr, size, dir);
>  }
>  
> @@ -458,7 +459,7 @@ xen_swiotlb_sync_single_for_device(struct device *dev, dma_addr_t dma_addr,
>  {
>  	phys_addr_t paddr = xen_dma_to_phys(dev, dma_addr);
>  
> -	if (is_xen_swiotlb_buffer(dev, dma_addr))
> +	if (is_xen_swiotlb_buffer(dev, dma_addr, size))
>  		swiotlb_sync_single_for_device(dev, paddr, size, dir);
>  
>  	if (!dev_is_dma_coherent(dev)) {
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 183e7103a66d..37fbd12bd4ab 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -142,7 +142,7 @@ int dma_set_mask(struct device *dev, u64 mask);
>  int dma_set_coherent_mask(struct device *dev, u64 mask);
>  u64 dma_get_required_mask(struct device *dev);
>  size_t dma_max_mapping_size(struct device *dev);
> -bool dma_need_sync(struct device *dev, dma_addr_t dma_addr);
> +bool dma_need_sync(struct device *dev, dma_addr_t dma_addr, size_t size);
>  unsigned long dma_get_merge_boundary(struct device *dev);
>  struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
>  		enum dma_data_direction dir, gfp_t gfp, unsigned long attrs);
> @@ -258,7 +258,7 @@ static inline size_t dma_max_mapping_size(struct device *dev)
>  {
>  	return 0;
>  }
> -static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
> +static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr, size_t size)
>  {
>  	return false;
>  }
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 216854a5e513..3e447f722d81 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -101,11 +101,13 @@ struct io_tlb_mem {
>  };
>  extern struct io_tlb_mem *io_tlb_default_mem;
>  
> -static inline bool is_swiotlb_buffer(phys_addr_t paddr)
> +static inline bool is_swiotlb_buffer(phys_addr_t paddr, size_t size)
>  {
>  	struct io_tlb_mem *mem = io_tlb_default_mem;
>  
> -	return mem && paddr >= mem->start && paddr < mem->end;
> +	if (paddr + size <= paddr) /* wrapping */
> +		return false;
> +	return mem && paddr >= mem->start && paddr + size <= mem->end;
>  }
>  
>  void __init swiotlb_exit(void);
> @@ -115,7 +117,7 @@ bool is_swiotlb_active(void);
>  void __init swiotlb_adjust_size(unsigned long size);
>  #else
>  #define swiotlb_force SWIOTLB_NO_FORCE
> -static inline bool is_swiotlb_buffer(phys_addr_t paddr)
> +static inline bool is_swiotlb_buffer(phys_addr_t paddr, size_t size)
>  {
>  	return false;
>  }
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index f737e3347059..9ae6f94e868f 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -343,7 +343,7 @@ void dma_direct_sync_sg_for_device(struct device *dev,
>  	for_each_sg(sgl, sg, nents, i) {
>  		phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
>  
> -		if (unlikely(is_swiotlb_buffer(paddr)))
> +		if (unlikely(is_swiotlb_buffer(paddr, sg->length)))
>  			swiotlb_sync_single_for_device(dev, paddr, sg->length,
>  						       dir);
>  
> @@ -369,7 +369,7 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
>  		if (!dev_is_dma_coherent(dev))
>  			arch_sync_dma_for_cpu(paddr, sg->length, dir);
>  
> -		if (unlikely(is_swiotlb_buffer(paddr)))
> +		if (unlikely(is_swiotlb_buffer(paddr, sg->length)))
>  			swiotlb_sync_single_for_cpu(dev, paddr, sg->length,
>  						    dir);
>  
> @@ -501,10 +501,10 @@ size_t dma_direct_max_mapping_size(struct device *dev)
>  	return SIZE_MAX;
>  }
>  
> -bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr)
> +bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr, size_t size)
>  {
>  	return !dev_is_dma_coherent(dev) ||
> -		is_swiotlb_buffer(dma_to_phys(dev, dma_addr));
> +		is_swiotlb_buffer(dma_to_phys(dev, dma_addr), size);
>  }
>  
>  /**
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index 50afc05b6f1d..4a17e431ae56 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -16,7 +16,7 @@ bool dma_direct_can_mmap(struct device *dev);
>  int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
>  		void *cpu_addr, dma_addr_t dma_addr, size_t size,
>  		unsigned long attrs);
> -bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr);
> +bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr, size_t size);
>  int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>  		enum dma_data_direction dir, unsigned long attrs);
>  size_t dma_direct_max_mapping_size(struct device *dev);
> @@ -56,7 +56,7 @@ static inline void dma_direct_sync_single_for_device(struct device *dev,
>  {
>  	phys_addr_t paddr = dma_to_phys(dev, addr);
>  
> -	if (unlikely(is_swiotlb_buffer(paddr)))
> +	if (unlikely(is_swiotlb_buffer(paddr, size)))
>  		swiotlb_sync_single_for_device(dev, paddr, size, dir);
>  
>  	if (!dev_is_dma_coherent(dev))
> @@ -73,7 +73,7 @@ static inline void dma_direct_sync_single_for_cpu(struct device *dev,
>  		arch_sync_dma_for_cpu_all();
>  	}
>  
> -	if (unlikely(is_swiotlb_buffer(paddr)))
> +	if (unlikely(is_swiotlb_buffer(paddr, size)))
>  		swiotlb_sync_single_for_cpu(dev, paddr, size, dir);
>  
>  	if (dir == DMA_FROM_DEVICE)
> @@ -113,7 +113,7 @@ static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
>  	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>  		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
>  
> -	if (unlikely(is_swiotlb_buffer(phys)))
> +	if (unlikely(is_swiotlb_buffer(phys, size)))
>  		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
>  }
>  #endif /* _KERNEL_DMA_DIRECT_H */
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 2b06a809d0b9..9bf02c8d7d1b 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -716,12 +716,12 @@ size_t dma_max_mapping_size(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dma_max_mapping_size);
>  
> -bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
> +bool dma_need_sync(struct device *dev, dma_addr_t dma_addr, size_t size)
>  {
>  	const struct dma_map_ops *ops = get_dma_ops(dev);
>  
>  	if (dma_map_direct(dev, ops))
> -		return dma_direct_need_sync(dev, dma_addr);
> +		return dma_direct_need_sync(dev, dma_addr, size);
>  	return ops->sync_single_for_cpu || ops->sync_single_for_device;
>  }
>  EXPORT_SYMBOL_GPL(dma_need_sync);
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 8de01aaac4a0..c1e404fe0cf4 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -399,7 +399,7 @@ int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
>  			__xp_dma_unmap(dma_map, attrs);
>  			return -ENOMEM;
>  		}
> -		if (dma_need_sync(dev, dma))
> +		if (dma_need_sync(dev, dma, PAGE_SIZE))
>  			dma_map->dma_need_sync = true;
>  		dma_map->dma_pages[i] = dma;
>  	}
> -- 
> 2.25.4
> 
