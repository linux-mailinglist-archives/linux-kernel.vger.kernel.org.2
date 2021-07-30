Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5483DB33C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbhG3GJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:09:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:19454 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236641AbhG3GJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:09:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="274111036"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="274111036"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 23:09:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; 
   d="scan'208";a="465344710"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2021 23:08:57 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, john.garry@huawei.com,
        dianders@chromium.org, Marek Szyprowski <m.szyprowski@samsung.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yong Wu <yong.wu@mediatek.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 01/24] iommu: Pull IOVA cookie management into the core
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <fcd58f6e0265b5339091cbabdea88151d437ad40.1627468309.git.robin.murphy@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <19face6d-daae-fe36-5154-a1f6e409064d@linux.intel.com>
Date:   Fri, 30 Jul 2021 14:06:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <fcd58f6e0265b5339091cbabdea88151d437ad40.1627468309.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/21 11:58 PM, Robin Murphy wrote:
> Now that everyone has converged on iommu-dma for IOMMU_DOMAIN_DMA
> support, we can abandon the notion of drivers being responsible for the
> cookie type, and consolidate all the management into the core code.
> 
> CC: Marek Szyprowski <m.szyprowski@samsung.com>
> CC: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> CC: Geert Uytterhoeven <geert+renesas@glider.be>
> CC: Yong Wu <yong.wu@mediatek.com>
> CC: Heiko Stuebner <heiko@sntech.de>
> CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
> CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
> CC: Maxime Ripard <mripard@kernel.org>
> CC: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/iommu.c | 7 +++++++
>   include/linux/iommu.h | 3 ++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f2cda9950bd5..ea5a9ea8d431 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -7,6 +7,7 @@
>   #define pr_fmt(fmt)    "iommu: " fmt
>   
>   #include <linux/device.h>
> +#include <linux/dma-iommu.h>
>   #include <linux/kernel.h>
>   #include <linux/bits.h>
>   #include <linux/bug.h>
> @@ -1946,6 +1947,11 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>   	/* Assume all sizes by default; the driver may override this later */
>   	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
>   
> +	/* Temporarily ignore -EEXIST while drivers still get their own cookies */
> +	if (type == IOMMU_DOMAIN_DMA && iommu_get_dma_cookie(domain) == -ENOMEM) {
> +		iommu_domain_free(domain);
> +		domain = NULL;
> +	}
>   	return domain;
>   }
>   
> @@ -1957,6 +1963,7 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>   
>   void iommu_domain_free(struct iommu_domain *domain)
>   {
> +	iommu_put_dma_cookie(domain);
>   	domain->ops->domain_free(domain);
>   }
>   EXPORT_SYMBOL_GPL(iommu_domain_free);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 4997c78e2670..141779d76035 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -40,6 +40,7 @@ struct iommu_domain;
>   struct notifier_block;
>   struct iommu_sva;
>   struct iommu_fault_event;
> +struct iommu_dma_cookie;
>   
>   /* iommu fault flags */
>   #define IOMMU_FAULT_READ	0x0
> @@ -86,7 +87,7 @@ struct iommu_domain {
>   	iommu_fault_handler_t handler;
>   	void *handler_token;
>   	struct iommu_domain_geometry geometry;
> -	void *iova_cookie;
> +	struct iommu_dma_cookie *iova_cookie;
>   };
>   
>   enum iommu_cap {
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
