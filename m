Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F083DB341
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbhG3GKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:10:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:4954 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230282AbhG3GKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:10:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="213070065"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="213070065"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 23:10:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="465344820"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2021 23:10:01 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, john.garry@huawei.com,
        dianders@chromium.org
Subject: Re: [PATCH v2 12/24] iommu/dma: Unexport IOVA cookie management
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <697a7c5da18c58e61e6b9a98b97775a2934a6358.1627468309.git.robin.murphy@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <fcd151ab-342e-cea4-a9d9-358635dd4a75@linux.intel.com>
Date:   Fri, 30 Jul 2021 14:07:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <697a7c5da18c58e61e6b9a98b97775a2934a6358.1627468309.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/21 11:58 PM, Robin Murphy wrote:
> IOVA cookies are now got and put by core code, so we no longer need to
> export these to modular drivers. The export for getting MSI cookies
> stays, since VFIO can still be a module, but it was already relying on
> someone else putting them, so that aspect is unaffected.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/dma-iommu.c | 7 -------
>   drivers/iommu/iommu.c     | 3 +--
>   2 files changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 98ba927aee1a..10067fbc4309 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -98,9 +98,6 @@ static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
>   /**
>    * iommu_get_dma_cookie - Acquire DMA-API resources for a domain
>    * @domain: IOMMU domain to prepare for DMA-API usage
> - *
> - * IOMMU drivers should normally call this from their domain_alloc
> - * callback when domain->type == IOMMU_DOMAIN_DMA.
>    */
>   int iommu_get_dma_cookie(struct iommu_domain *domain)
>   {
> @@ -113,7 +110,6 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
>   
>   	return 0;
>   }
> -EXPORT_SYMBOL(iommu_get_dma_cookie);
>   
>   /**
>    * iommu_get_msi_cookie - Acquire just MSI remapping resources
> @@ -151,8 +147,6 @@ EXPORT_SYMBOL(iommu_get_msi_cookie);
>    * iommu_put_dma_cookie - Release a domain's DMA mapping resources
>    * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie() or
>    *          iommu_get_msi_cookie()
> - *
> - * IOMMU drivers should normally call this from their domain_free callback.
>    */
>   void iommu_put_dma_cookie(struct iommu_domain *domain)
>   {
> @@ -172,7 +166,6 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>   	kfree(cookie);
>   	domain->iova_cookie = NULL;
>   }
> -EXPORT_SYMBOL(iommu_put_dma_cookie);
>   
>   /**
>    * iommu_dma_get_resv_regions - Reserved region driver helper
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index ea5a9ea8d431..fa8109369f74 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1947,8 +1947,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>   	/* Assume all sizes by default; the driver may override this later */
>   	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
>   
> -	/* Temporarily ignore -EEXIST while drivers still get their own cookies */
> -	if (type == IOMMU_DOMAIN_DMA && iommu_get_dma_cookie(domain) == -ENOMEM) {
> +	if (type == IOMMU_DOMAIN_DMA && iommu_get_dma_cookie(domain)) {
>   		iommu_domain_free(domain);
>   		domain = NULL;
>   	}
> 


Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
