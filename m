Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78563E0852
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239467AbhHDSxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 14:53:09 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50026 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239186AbhHDSxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:53:08 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mBM0O-0002bp-FX; Wed, 04 Aug 2021 20:52:40 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     joro@8bytes.org, will@kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yong Wu <yong.wu@mediatek.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v3 01/25] iommu: Pull IOVA cookie management into the core
Date:   Wed, 04 Aug 2021 20:52:39 +0200
Message-ID: <2535689.1BCLMh4Saa@diego>
In-Reply-To: <46f4cda8215bd5f8a9f9fd5a4a6451805f75efa3.1628094600.git.robin.murphy@arm.com>
References: <cover.1628094600.git.robin.murphy@arm.com> <46f4cda8215bd5f8a9f9fd5a4a6451805f75efa3.1628094600.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 4. August 2021, 19:15:29 CEST schrieb Robin Murphy:
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
> CC: Maxime Ripard <mripard@kernel.org>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

On a Rockchip rk3288 (arm32), rk3399 (arm64) and px30 (arm64)
with the graphics pipeline using the iommu

Tested-by: Heiko Stuebner <heiko@sntech.de>


Heiko

> 
> ---
> 
> v3: Use a simpler temporary check instead of trying to be clever with
>     the error code
> ---
>  drivers/iommu/iommu.c | 7 +++++++
>  include/linux/iommu.h | 3 ++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f2cda9950bd5..b65fcc66ffa4 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -7,6 +7,7 @@
>  #define pr_fmt(fmt)    "iommu: " fmt
>  
>  #include <linux/device.h>
> +#include <linux/dma-iommu.h>
>  #include <linux/kernel.h>
>  #include <linux/bits.h>
>  #include <linux/bug.h>
> @@ -1946,6 +1947,11 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>  	/* Assume all sizes by default; the driver may override this later */
>  	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
>  
> +	/* Temporarily avoid -EEXIST while drivers still get their own cookies */
> +	if (type == IOMMU_DOMAIN_DMA && !domain->iova_cookie && iommu_get_dma_cookie(domain)) {
> +		iommu_domain_free(domain);
> +		domain = NULL;
> +	}
>  	return domain;
>  }
>  
> @@ -1957,6 +1963,7 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>  
>  void iommu_domain_free(struct iommu_domain *domain)
>  {
> +	iommu_put_dma_cookie(domain);
>  	domain->ops->domain_free(domain);
>  }
>  EXPORT_SYMBOL_GPL(iommu_domain_free);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 4997c78e2670..141779d76035 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -40,6 +40,7 @@ struct iommu_domain;
>  struct notifier_block;
>  struct iommu_sva;
>  struct iommu_fault_event;
> +struct iommu_dma_cookie;
>  
>  /* iommu fault flags */
>  #define IOMMU_FAULT_READ	0x0
> @@ -86,7 +87,7 @@ struct iommu_domain {
>  	iommu_fault_handler_t handler;
>  	void *handler_token;
>  	struct iommu_domain_geometry geometry;
> -	void *iova_cookie;
> +	struct iommu_dma_cookie *iova_cookie;
>  };
>  
>  enum iommu_cap {
> 




