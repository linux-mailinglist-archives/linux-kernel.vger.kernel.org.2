Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE073E0854
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239574AbhHDSxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 14:53:55 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50092 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238726AbhHDSxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:53:54 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mBM1J-0002cI-Lo; Wed, 04 Aug 2021 20:53:37 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     joro@8bytes.org, will@kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com
Subject: Re: [PATCH v3 08/25] iommu/rockchip: Drop IOVA cookie management
Date:   Wed, 04 Aug 2021 20:53:36 +0200
Message-ID: <4512656.mogB4TqSGs@diego>
In-Reply-To: <0d25511c58981ecd0a1f3006dc1c30a73fb7d377.1628094601.git.robin.murphy@arm.com>
References: <cover.1628094600.git.robin.murphy@arm.com> <0d25511c58981ecd0a1f3006dc1c30a73fb7d377.1628094601.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 4. August 2021, 19:15:36 CEST schrieb Robin Murphy:
> The core code bakes its own cookies now.
> 
> CC: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>


On a Rockchip rk3288 (arm32), rk3399 (arm64) and px30 (arm64)
with the graphics pipeline using the iommu

Tested-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Heiko Stuebner <heiko@sntech.de>


Works now nicely on both arm32 and arm64


Thanks
Heiko


> 
> ---
> 
> v3: Also remove unneeded include
> ---
>  drivers/iommu/rockchip-iommu.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 9febfb7f3025..5cb260820eda 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -10,7 +10,6 @@
>  #include <linux/compiler.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> -#include <linux/dma-iommu.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/errno.h>
>  #include <linux/interrupt.h>
> @@ -1074,10 +1073,6 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
>  	if (!rk_domain)
>  		return NULL;
>  
> -	if (type == IOMMU_DOMAIN_DMA &&
> -	    iommu_get_dma_cookie(&rk_domain->domain))
> -		goto err_free_domain;
> -
>  	/*
>  	 * rk32xx iommus use a 2 level pagetable.
>  	 * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries.
> @@ -1085,7 +1080,7 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
>  	 */
>  	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL | GFP_DMA32);
>  	if (!rk_domain->dt)
> -		goto err_put_cookie;
> +		goto err_free_domain;
>  
>  	rk_domain->dt_dma = dma_map_single(dma_dev, rk_domain->dt,
>  					   SPAGE_SIZE, DMA_TO_DEVICE);
> @@ -1106,9 +1101,6 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
>  
>  err_free_dt:
>  	free_page((unsigned long)rk_domain->dt);
> -err_put_cookie:
> -	if (type == IOMMU_DOMAIN_DMA)
> -		iommu_put_dma_cookie(&rk_domain->domain);
>  err_free_domain:
>  	kfree(rk_domain);
>  
> @@ -1137,8 +1129,6 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
>  			 SPAGE_SIZE, DMA_TO_DEVICE);
>  	free_page((unsigned long)rk_domain->dt);
>  
> -	if (domain->type == IOMMU_DOMAIN_DMA)
> -		iommu_put_dma_cookie(&rk_domain->domain);
>  	kfree(rk_domain);
>  }
>  
> 




