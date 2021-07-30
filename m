Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D153DB354
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbhG3GNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:13:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:4212 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233890AbhG3GNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:13:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="200245807"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="200245807"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 23:13:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="465345314"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2021 23:13:39 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, john.garry@huawei.com,
        dianders@chromium.org
Subject: Re: [PATCH v2 21/24] iommu/dma: Factor out flush queue init
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <afdded2f32737757f2af3ee08e123798fa024cce.1627468310.git.robin.murphy@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e7c0aeea-0e74-168c-170d-d627adfe6d6a@linux.intel.com>
Date:   Fri, 30 Jul 2021 14:11:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <afdded2f32737757f2af3ee08e123798fa024cce.1627468310.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/21 11:58 PM, Robin Murphy wrote:
> Factor out flush queue setup from the initial domain init so that we
> can potentially trigger it from sysfs later on in a domain's lifetime.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/dma-iommu.c | 30 ++++++++++++++++++++----------
>   include/linux/dma-iommu.h |  9 ++++++---
>   2 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 7f3968865387..304a3ec71223 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -310,6 +310,25 @@ static bool dev_is_untrusted(struct device *dev)
>   	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
>   }
>   
> +int iommu_dma_init_fq(struct iommu_domain *domain)
> +{
> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +
> +	if (domain->type != IOMMU_DOMAIN_DMA_FQ)
> +		return -EINVAL;
> +	if (cookie->fq_domain)
> +		return 0;
> +
> +	if (init_iova_flush_queue(&cookie->iovad, iommu_dma_flush_iotlb_all,
> +				  iommu_dma_entry_dtor)) {
> +		pr_warn("iova flush queue initialization failed\n");
> +		domain->type = IOMMU_DOMAIN_DMA;
> +		return -ENODEV;
> +	}
> +	cookie->fq_domain = domain;
> +	return 0;
> +}
> +
>   /**
>    * iommu_dma_init_domain - Initialise a DMA mapping domain
>    * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
> @@ -362,16 +381,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>   	}
>   
>   	init_iova_domain(iovad, 1UL << order, base_pfn);
> -
> -	if (domain->type == IOMMU_DOMAIN_DMA_FQ && !cookie->fq_domain) {
> -		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
> -					  iommu_dma_entry_dtor)) {
> -			pr_warn("iova flush queue initialization failed\n");
> -			domain->type = IOMMU_DOMAIN_DMA;
> -		} else {
> -			cookie->fq_domain = domain;
> -		}
> -	}
> +	iommu_dma_init_fq(domain);
>   
>   	return iova_reserve_iommu_regions(dev, domain);
>   }
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 758ca4694257..81ab647f1618 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -20,6 +20,7 @@ void iommu_put_dma_cookie(struct iommu_domain *domain);
>   
>   /* Setup call for arch DMA mapping code */
>   void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit);
> +int iommu_dma_init_fq(struct iommu_domain *domain);
>   
>   /* The DMA API isn't _quite_ the whole story, though... */
>   /*
> @@ -37,9 +38,6 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
>   
>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
>   
> -void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
> -		struct iommu_domain *domain);
> -
>   extern bool iommu_dma_forcedac;
>   
>   #else /* CONFIG_IOMMU_DMA */
> @@ -54,6 +52,11 @@ static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
>   {
>   }
>   
> +static inline int iommu_dma_init_fq(struct iommu_domain *domain)
> +{
> +	return -EINVAL;
> +}
> +
>   static inline int iommu_get_dma_cookie(struct iommu_domain *domain)
>   {
>   	return -ENODEV;
> 


Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
