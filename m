Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C058B3DD771
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 15:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbhHBNlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 09:41:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233826AbhHBNlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 09:41:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33C2760527;
        Mon,  2 Aug 2021 13:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627911664;
        bh=T6TWUTiAj92VMQeo9D2L0JR2kOWfrkEOeOZopIPa0VE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d/64efJ5zA/m+402dzhCDuHrU2jY302WfZWrU+aWmVSFHB1r9t/c9Ab73NR7fKLfe
         IoAEEoJQ30itvaAF29kVH6quNSN4mjIxSxmydFAcKu51wVrt6JsExy0KpsL9Ri8mT/
         iqBVItJ5uzfqnkHnB8CnRj5GQ3mj7oAt/r8joL1VY0vXNpBjh4N0ZwIbNDKBNOBvk6
         X20sNlhtmkKu1Dfmp0IdqZB32qAbKqSIax+SRATS7pS+pAZ8fG0zMQ+YD+rY03DsDq
         csW0RHmrSHGsDqA+wlyUfpWOpADzoo0GYh7LcIuXlSKtrAHWTU8HLodoysKTKP2nJn
         req52quV0YsyA==
Date:   Mon, 2 Aug 2021 14:40:59 +0100
From:   Will Deacon <will@kernel.org>
To:     David Stevens <stevensd@chromium.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dma-iommu: fix arch_sync_dma for map with swiotlb
Message-ID: <20210802134059.GC28547@willie-the-truck>
References: <20210709033502.3545820-1-stevensd@google.com>
 <20210709033502.3545820-3-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709033502.3545820-3-stevensd@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 12:35:00PM +0900, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> When calling arch_sync_dma, we need to pass it the memory that's
> actually being used for dma. When using swiotlb bounce buffers, this is
> the bounce buffer. Move arch_sync_dma into the __iommu_dma_map_swiotlb
> helper, so it can use the bounce buffer address if necessary. This also
> means it is no longer necessary to call iommu_dma_sync_sg_for_device in
> iommu_dma_map_sg for untrusted devices.
> 
> Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  drivers/iommu/dma-iommu.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index eac65302439e..e79e274d2dc5 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -574,6 +574,9 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>  		memset(padding_start, 0, padding_size);
>  	}
>  
> +	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		arch_sync_dma_for_device(phys, org_size, dir);

I think this relies on the swiotlb buffers residing in the linear mapping
(i.e. where phys_to_virt() is reliable), which doesn't look like a safe
assumption to me.

Will
