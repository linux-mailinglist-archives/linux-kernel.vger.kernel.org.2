Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD313E89F5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 07:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhHKF6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 01:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbhHKF6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 01:58:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38272C0613D5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 22:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cCkb2qMOYuPYfdphFUYq7dI3/TJ7XUd74ZXsL2WF3pw=; b=d9PMnaIJQRLjQ2mzCUBHCcxmKQ
        XYK0zfnIRwpk1A1IUHghWg6sHIWDqaSuyabmsK6qMMtzrkeQjEdbEBqVfk5bmggGvwhNqJsesgP33
        M3MH8uXoF/UF4amLLFo9R6zZuG9wtMmbO91iZOp4upiS94yjZOFTaAoTqtUqWrGsm3yHCl3jyop5L
        y4g1NM6VoULjbyKT3E0SNPUaNfCWBZNtUCq2urc/uL0KMd99WfLE+4W+VYtG55qGusfumpgO43p6R
        D39sUvFki7bEbaZmFx2KzF6gdwWpuRppDYMBsNhm7LyC8W/TNw21fBdckULCRJdozpVwaaUusQ3ch
        c4cfbR/Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDhEz-00D2T9-A4; Wed, 11 Aug 2021 05:57:33 +0000
Date:   Wed, 11 Aug 2021 06:57:25 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     David Stevens <stevensd@chromium.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v3 1/5] dma-iommu: fix sync_sg with swiotlb
Message-ID: <YRNmxU9Ou2OcvBq2@infradead.org>
References: <20210811024247.1144246-1-stevensd@google.com>
 <20210811024247.1144246-2-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811024247.1144246-2-stevensd@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 11:42:43AM +0900, David Stevens wrote:
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
>  drivers/iommu/dma-iommu.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 98ba927aee1a..54e103b989d9 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -813,14 +813,13 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
>  	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
>  		return;
>  
> +	if (dev_is_untrusted(dev))
> +		for_each_sg(sgl, sg, nelems, i)
> +			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
> +						      sg->length, dir);
> +	else
> +		for_each_sg(sgl, sg, nelems, i)
>  			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
>  }

I'd remove the above check and fold the if (!dev_is_dma_coherent(dev))
into the else line.  Same for iommu_dma_sync_sg_for_device.
