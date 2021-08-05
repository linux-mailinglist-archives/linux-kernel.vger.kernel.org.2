Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A143E12A0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240354AbhHEK0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:26:38 -0400
Received: from foss.arm.com ([217.140.110.172]:42446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239963AbhHEK0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:26:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEB591FB;
        Thu,  5 Aug 2021 03:26:21 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9178A3F719;
        Thu,  5 Aug 2021 03:26:20 -0700 (PDT)
Subject: Re: [PATCH] of: restricted dma: Don't fail device probe on rmem init
 failure
To:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org,
        Claire Chang <tientzu@chromium.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Rob Herring <robh+dt@kernel.org>
References: <20210805094736.902-1-will@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <af998e69-671c-6d13-bd9b-da71b389575c@arm.com>
Date:   Thu, 5 Aug 2021 11:26:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805094736.902-1-will@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-05 10:47, Will Deacon wrote:
> If CONFIG_DMA_RESTRICTED_POOL=n then probing a device with a reference
> to a "restricted-dma-pool" will fail with a reasonably cryptic error:
> 
>    | pci-host-generic: probe of 10000.pci failed with error -22
> 
> Print a more helpful message in this case and try to continue probing
> the device as we do if the kernel doesn't have the restricted DMA patches
> applied or either CONFIG_OF_ADDRESS or CONFIG_HAS_DMA =n.

Makes sense to me;

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Although if we allow probe to succeed when a pool really was there for a 
reason, it may end up being much more fatal if the driver then tries to 
do a DMA transfer to any old memory and the device access causes an 
SError, or the VM to be killed, or whatever. That's not quite the same 
as the stubbed cases where the respective platforms couldn't have a 
genuine pool to parse either way, but as you say it is what could happen 
already if the user tried to use an older kernel, and I think the chance 
of of_reserved_mem_device_init_by_idx() failing without something being 
terminally wrong anyway - invalid DT, not enough RAM, etc. - is low 
enough that it's probably not a major concern. Plus I'd hope that the 
memory protection schemes people do actually implement don't take such 
such a zero-tolerance approach anyway - allowing a malicious or 
malfunctioning device to take down the system because it tried to make a 
rogue access which *was* already contained seems a bit silly.

Robin.

> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   drivers/of/address.c    | 8 ++++----
>   drivers/of/device.c     | 2 +-
>   drivers/of/of_private.h | 8 +++-----
>   3 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 973257434398..f6bf4b423c2a 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -997,7 +997,7 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
>   	return ret;
>   }
>   
> -int of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
> +void of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
>   {
>   	struct device_node *node, *of_node = dev->of_node;
>   	int count, i;
> @@ -1022,11 +1022,11 @@ int of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
>   		 */
>   		if (of_device_is_compatible(node, "restricted-dma-pool") &&
>   		    of_device_is_available(node))
> -			return of_reserved_mem_device_init_by_idx(dev, of_node,
> -								  i);
> +			break;
>   	}
>   
> -	return 0;
> +	if (i != count && of_reserved_mem_device_init_by_idx(dev, of_node, i))
> +		dev_warn(dev, "failed to initialise \"restricted-dma-pool\" memory node\n");
>   }
>   #endif /* CONFIG_HAS_DMA */
>   
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 2defdca418ec..258a2b099410 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -166,7 +166,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>   	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
>   
>   	if (!iommu)
> -		return of_dma_set_restricted_buffer(dev, np);
> +		of_dma_set_restricted_buffer(dev, np);
>   
>   	return 0;
>   }
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index f557bd22b0cf..bc883f69496b 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -163,18 +163,16 @@ struct bus_dma_region;
>   #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
>   int of_dma_get_range(struct device_node *np,
>   		const struct bus_dma_region **map);
> -int of_dma_set_restricted_buffer(struct device *dev, struct device_node *np);
> +void of_dma_set_restricted_buffer(struct device *dev, struct device_node *np);
>   #else
>   static inline int of_dma_get_range(struct device_node *np,
>   		const struct bus_dma_region **map)
>   {
>   	return -ENODEV;
>   }
> -static inline int of_dma_set_restricted_buffer(struct device *dev,
> -					       struct device_node *np)
> +static inline void of_dma_set_restricted_buffer(struct device *dev,
> +						struct device_node *np)
>   {
> -	/* Do nothing, successfully. */
> -	return 0;
>   }
>   #endif
>   
> 
