Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC91426253
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 04:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbhJHCNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 22:13:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:37004 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhJHCNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 22:13:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="287298679"
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; 
   d="scan'208";a="287298679"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 19:11:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; 
   d="scan'208";a="478804301"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2021 19:11:05 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, arei.gonglei@huawei.com
Subject: Re: [PATCH v3 2/2] iommu/vt-d: avoid duplicated removing in
 __domain_mapping
To:     "Longpeng(Mike)" <longpeng2@huawei.com>, dwmw2@infradead.org,
        will@kernel.org, joro@8bytes.org
References: <20211008000433.1115-1-longpeng2@huawei.com>
 <20211008000433.1115-3-longpeng2@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <54cf3663-85e0-3e63-9112-385e9d6eeceb@linux.intel.com>
Date:   Fri, 8 Oct 2021 10:07:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211008000433.1115-3-longpeng2@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/21 8:04 AM, Longpeng(Mike) wrote:
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
> to the boundary of the end of this pte page.
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
> ---
>   drivers/iommu/intel/iommu.c | 11 ++++++-----
>   include/linux/intel-iommu.h |  6 ++++++
>   2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d75f59a..46edae6 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2354,12 +2354,17 @@ static void switch_to_super_page(struct dmar_domain *domain,
>   				return -ENOMEM;
>   			first_pte = pte;
>   
> +			lvl_pages = lvl_to_nr_pages(largepage_lvl);
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
> @@ -2381,10 +2386,6 @@ static void switch_to_super_page(struct dmar_domain *domain,
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
> index 9bcabc7..b29b2a3 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -713,6 +713,12 @@ static inline bool first_pte_in_page(struct dma_pte *pte)
>   	return IS_ALIGNED((unsigned long)pte, VTD_PAGE_SIZE);
>   }
>   
> +static inline int nr_pte_to_next_page(struct dma_pte *pte)
> +{
> +	return first_pte_in_page(pte) ? BIT_ULL(VTD_STRIDE_SHIFT) :
> +		(struct dma_pte *)ALIGN((unsigned long)pte, VTD_PAGE_SIZE) - pte;

We should make it like this to avoid the 0day warning:

	(struct dma_pte *)(uintptr_t)VTD_PAGE_ALIGN((unsigned long)pte) - pte;

Can you please test this line of change? No need to send a new version.
I will handle it if it passes your test.

> +}
> +
>   extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
>   extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
>   
> 

Best regards,
baolu
