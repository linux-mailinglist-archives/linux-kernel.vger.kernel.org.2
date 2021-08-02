Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D24A3DD71A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 15:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhHBNax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 09:30:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233867AbhHBNav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 09:30:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5381260F6D;
        Mon,  2 Aug 2021 13:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627911042;
        bh=AopIBg3UQuNzGUn6zHPTl2RUpxi1CeIiSyyBhV3W0IU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nHwL3XngEiLQt4Didk/zSnyxzEHhLvI/h87NYzxgJW8aV9nergHLrRivaMg8Z2AZO
         8kuEw4+FZosbZe4uikBvFP1Sml89L/BSeuj5Ff25UAMW6Pcy7EYLRaZp/DGE9vk/Q3
         xr2oL845xDL4K22oGmVfyU0UzhLgn1e1K8khfY9wEkWXOOG6qbBH+ZnjQ3/qqnk0GR
         WXPH12PIZS96YbDsPp9MnZp6cvrcg1r/6GlQq0HFHKMI0yyFCqvnI/99FWO93aoC5q
         +9Um+bb8RbypSIvULxhV0A5kejZrgqd8NNxdC4uS2WUXxGe8MAXKh0p/EIZPA13Hpc
         EN7cMXB+23UFQ==
Date:   Mon, 2 Aug 2021 14:30:38 +0100
From:   Will Deacon <will@kernel.org>
To:     David Stevens <stevensd@chromium.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dma-iommu: fix sync_sg with swiotlb
Message-ID: <20210802133037.GB28547@willie-the-truck>
References: <20210709033502.3545820-1-stevensd@google.com>
 <20210709033502.3545820-2-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709033502.3545820-2-stevensd@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 12:34:59PM +0900, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> The is_swiotlb_buffer function takes the physical address of the swiotlb
> buffer, not the physical address of the original buffer. The sglist
> contains the physical addresses of the original buffer, so for the
> sync_sg functions to work properly when a bounce buffer might have been
> used, we need to use iommu_iova_to_phys to look up the physical address.
> This is what sync_single does, so call that function on each sglist
> segment.
> 
> The previous code mostly worked because swiotlb does the transfer on map
> and unmap. However, any callers which use DMA_ATTR_SKIP_CPU_SYNC with
> sglists or which call sync_sg would not have had anything copied to the
> bounce buffer.
> 
> Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  drivers/iommu/dma-iommu.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 7bcdd1205535..eac65302439e 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -811,14 +811,14 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
>  	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
>  		return;
>  
> -	for_each_sg(sgl, sg, nelems, i) {
> -		if (!dev_is_dma_coherent(dev))
> -			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
> -
> -		if (is_swiotlb_buffer(sg_phys(sg)))
> +	if (dev_is_untrusted(dev))
> +		for_each_sg(sgl, sg, nelems, i)
> +			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
> +						      sg->length, dir);
> +	else
> +		for_each_sg(sgl, sg, nelems, i)
>  			swiotlb_sync_single_for_cpu(dev, sg_phys(sg),
>  						    sg->length, dir);

Doesn't this skip arch_sync_dma_for_cpu() for non-coherent trusted devices?

Why not skip the extra dev_is_untrusted(dev) call here and just call
iommu_dma_sync_single_for_cpu() for each entry regardless?

Will
