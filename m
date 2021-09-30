Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4685F41DC16
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351824AbhI3OQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:16:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:1373 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240149AbhI3OQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:16:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="286213255"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="286213255"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 07:14:09 -0700
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="564196256"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.141]) ([10.254.214.141])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 07:14:07 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, arei.gonglei@huawei.com
Subject: Re: [PATCH v1 2/2] iommu/vt-d: avoid duplicated removing in
 __domain_mapping
To:     "Longpeng(Mike)" <longpeng2@huawei.com>, dwmw2@infradead.org,
        joro@8bytes.org, will@kernel.org
References: <20210915152129.1254-1-longpeng2@huawei.com>
 <20210915152129.1254-3-longpeng2@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2d060249-8503-6b68-33ed-7623f62686ae@linux.intel.com>
Date:   Thu, 30 Sep 2021 22:14:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210915152129.1254-3-longpeng2@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Longpeng,

On 2021/9/15 23:21, Longpeng(Mike) wrote:
> __domain_mapping() always removes the pages in the range from
> 'iov_pfn' to 'end_pfn', but the 'end_pfn' is always the last pfn
> of the range that the caller wants to map.
> 
> This would introduce too many duplicated removing and leads the
> map operation take too long, for example:
> 
>    Map iova=0x100000,nr_pages=0x7d61800
>      iov_pfn: 0x100000, end_pfn: 0x7e617ff
>      iov_pfn: 0x140000, end_pfn: 0x7e617ff
>      iov_pfn: 0x180000, end_pfn: 0x7e617ff
>      iov_pfn: 0x1c0000, end_pfn: 0x7e617ff
>      iov_pfn: 0x200000, end_pfn: 0x7e617ff
>      ...
>    it takes about 50ms in total.
> 
> We can reduce the cost by recalculate the 'end_pfn' and limit it
> to the boundary of the end of the pte page.
> 
>    Map iova=0x100000,nr_pages=0x7d61800
>      iov_pfn: 0x100000, end_pfn: 0x13ffff
>      iov_pfn: 0x140000, end_pfn: 0x17ffff
>      iov_pfn: 0x180000, end_pfn: 0x1bffff
>      iov_pfn: 0x1c0000, end_pfn: 0x1fffff
>      iov_pfn: 0x200000, end_pfn: 0x23ffff
>      ...
>    it only need 9ms now.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>

The 0day robot reports below compiling warning when building a 32-bit
kernel (make W=1 ARCH=i386):

All errors (new ones prefixed by >>):

    In file included from drivers/gpu/drm/i915/i915_drv.h:43,
                     from 
drivers/gpu/drm/i915/display/intel_display_types.h:47,
                     from drivers/gpu/drm/i915/display/intel_dsi.h:30,
                     from <command-line>:
    include/linux/intel-iommu.h: In function 'nr_pte_to_next_page':
 >> include/linux/intel-iommu.h:719:3: error: cast to pointer from 
integer of different size [-Werror=int-to-pointer-cast]
      719 |   (struct dma_pte *)VTD_PAGE_ALIGN((unsigned long)pte) - pte;
          |   ^
    cc1: all warnings being treated as errors


vim +719 include/linux/intel-iommu.h

    715	
    716	static inline int nr_pte_to_next_page(struct dma_pte *pte)
    717	{
    718		return first_pte_in_page(pte) ? BIT_ULL(VTD_STRIDE_SHIFT) :
  > 719			(struct dma_pte *)VTD_PAGE_ALIGN((unsigned long)pte) - pte;
    720	}
    721	

Can you please take a look at this?

Best regards,
baolu

> ---
>   drivers/iommu/intel/iommu.c | 12 +++++++-----
>   include/linux/intel-iommu.h |  6 ++++++
>   2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d75f59a..87cbf34 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2354,12 +2354,18 @@ static void switch_to_super_page(struct dmar_domain *domain,
>   				return -ENOMEM;
>   			first_pte = pte;
>   
> +			lvl_pages = lvl_to_nr_pages(largepage_lvl);
> +			BUG_ON(nr_pages < lvl_pages);
> +
>   			/* It is large page*/
>   			if (largepage_lvl > 1) {
>   				unsigned long end_pfn;
> +				unsigned long pages_to_remove;
>   
>   				pteval |= DMA_PTE_LARGE_PAGE;
> -				end_pfn = ((iov_pfn + nr_pages) & level_mask(largepage_lvl)) - 1;
> +				pages_to_remove = min_t(unsigned long, nr_pages,
> +							nr_pte_to_next_page(pte) * lvl_pages);
> +				end_pfn = iov_pfn + pages_to_remove - 1;
>   				switch_to_super_page(domain, iov_pfn, end_pfn, largepage_lvl);
>   			} else {
>   				pteval &= ~(uint64_t)DMA_PTE_LARGE_PAGE;
> @@ -2381,10 +2387,6 @@ static void switch_to_super_page(struct dmar_domain *domain,
>   			WARN_ON(1);
>   		}
>   
> -		lvl_pages = lvl_to_nr_pages(largepage_lvl);
> -
> -		BUG_ON(nr_pages < lvl_pages);
> -
>   		nr_pages -= lvl_pages;
>   		iov_pfn += lvl_pages;
>   		phys_pfn += lvl_pages;
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index a590b00..4bff70c 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -713,6 +713,12 @@ static inline bool first_pte_in_page(struct dma_pte *pte)
>   	return !((unsigned long)pte & ~VTD_PAGE_MASK);
>   }
>   
> +static inline int nr_pte_to_next_page(struct dma_pte *pte)
> +{
> +	return first_pte_in_page(pte) ? BIT_ULL(VTD_STRIDE_SHIFT) :
> +		(struct dma_pte *)VTD_PAGE_ALIGN((unsigned long)pte) - pte;
> +}
> +
>   extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
>   extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
>   
> 
