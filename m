Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4703E1172
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 11:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238895AbhHEJiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 05:38:22 -0400
Received: from foss.arm.com ([217.140.110.172]:41792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238146AbhHEJiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:38:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 168B16D;
        Thu,  5 Aug 2021 02:38:05 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFEED3F719;
        Thu,  5 Aug 2021 02:38:03 -0700 (PDT)
Subject: Re: [PATCH v3 02/25] iommu/amd: Drop IOVA cookie management
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, dianders@chromium.org,
        iommu@lists.linux-foundation.org, rajatja@google.com,
        linux-arm-kernel@lists.infradead.org
References: <cover.1628094600.git.robin.murphy@arm.com>
 <ebc82f082d5fde58557efbec66f34b1be6a12599.1628094600.git.robin.murphy@arm.com>
Message-ID: <44f5c699-1177-7f1d-479e-59a8a42efab6@arm.com>
Date:   Thu, 5 Aug 2021 10:37:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <ebc82f082d5fde58557efbec66f34b1be6a12599.1628094600.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-04 18:15, Robin Murphy wrote:
> The core code bakes its own cookies now.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> v3: Also remove unneeded include
> ---
>   drivers/iommu/amd/iommu.c | 13 -------------
>   1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 52fe2326042a..92f7cbe3d14a 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -20,7 +20,6 @@
>   #include <linux/scatterlist.h>
>   #include <linux/dma-map-ops.h>
>   #include <linux/dma-direct.h>
> -#include <linux/dma-iommu.h>

Oh dear, how embarrassing... I went through all the drivers making that 
decision based on iommu_dma* references but totally forgot about 
iommu_setup_dma_ops() here. And then of course fell into the trap of 
"such a minor change I don't need to re-rest it" hubris... sigh, roll 
back to v2 for this one.

Apologies,
Robin.

>   #include <linux/iommu-helper.h>
>   #include <linux/delay.h>
>   #include <linux/amd-iommu.h>
> @@ -1918,16 +1917,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
>   	domain->domain.geometry.aperture_end   = ~0ULL;
>   	domain->domain.geometry.force_aperture = true;
>   
> -	if (type == IOMMU_DOMAIN_DMA &&
> -	    iommu_get_dma_cookie(&domain->domain) == -ENOMEM)
> -		goto free_domain;
> -
>   	return &domain->domain;
> -
> -free_domain:
> -	protection_domain_free(domain);
> -
> -	return NULL;
>   }
>   
>   static void amd_iommu_domain_free(struct iommu_domain *dom)
> @@ -1944,9 +1934,6 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
>   	if (!dom)
>   		return;
>   
> -	if (dom->type == IOMMU_DOMAIN_DMA)
> -		iommu_put_dma_cookie(&domain->domain);
> -
>   	if (domain->flags & PD_IOMMUV2_MASK)
>   		free_gcr3_table(domain);
>   
> 
