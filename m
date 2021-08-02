Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690493DD9D9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbhHBOEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235619AbhHBN5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 09:57:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D13161155;
        Mon,  2 Aug 2021 13:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627912490;
        bh=ffsZcqleS2Msj4hKWIBmJ4DPBk3NI1GngO6NeU0SeTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VtSmunYUXbIIrXS3l/nVkmZXkowH6vo/7g7EKVHyGGAP/bs4NpsweEv1bYURFTDYP
         hPZkudv6Q+a1gVJLvSugGrJCXJGILZJXjQzxFBTiIxO+EwtizHV5Ph4vUtdeyue8i9
         dkMBvitTmr3l0I5+q7p3nWeLK1b9uacCWjCeefWIm0rWNNa/2bRiT4DpgiNkpZkaKH
         uAJrliut8ve2C7rQIIMqyP5sSiyd+sOv9LtAQruboXcyd32Tn6PLVeBXRY3Ob2RSc8
         n/n92HXPgxrkA9a9JptQmeZKFf4CSCofpomOhAAx+xF4xqHHhJZHAVliePCKrTO2Nf
         6KwI1rx3CS2ag==
Date:   Mon, 2 Aug 2021 14:54:46 +0100
From:   Will Deacon <will@kernel.org>
To:     David Stevens <stevensd@chromium.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dma-iommu: pass SKIP_CPU_SYNC to swiotlb unmap
Message-ID: <20210802135446.GE28547@willie-the-truck>
References: <20210709033502.3545820-1-stevensd@google.com>
 <20210709033502.3545820-4-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709033502.3545820-4-stevensd@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 12:35:01PM +0900, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> If SKIP_CPU_SYNC isn't already set, then iommu_dma_unmap_(page|sg) has
> already called iommu_dma_sync_(single|sg)_for_cpu, so there is no need
> to copy from the bounce buffer again.
> 
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  drivers/iommu/dma-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index e79e274d2dc5..0a9a9a343e64 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -505,7 +505,8 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
>  	__iommu_dma_unmap(dev, dma_addr, size);
>  
>  	if (unlikely(is_swiotlb_buffer(phys)))
> -		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
> +		swiotlb_tbl_unmap_single(dev, phys, size, dir,
> +					 attrs | DMA_ATTR_SKIP_CPU_SYNC);
>  }

I think it would be cleaner to drop DMA_ATTR_SKIP_CPU_SYNC in the callers
once they've called iommu_dma_sync_*_for_cpu().

Will
