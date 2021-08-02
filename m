Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7AC3DD90B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 15:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbhHBN4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 09:56:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235030AbhHBNuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 09:50:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F6E160FC2;
        Mon,  2 Aug 2021 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627912241;
        bh=GBr6UnZnddvBVtPy1lt2vpJ7l1kGUYvvLsBoTxeVP4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WgH17kg3HEe1Wizzqvjcr5kTff4dkEdqHbCHlmRKCvBUGDzuRKo33Qd7IePx1dAl6
         zEFn9XAv1elezGzF2eguzFcH4uB7ngIzCRTjMsfxwLx97WmXQRM0PZkH9twIQmXNcJ
         +K58eKlj4xK/fw8FEO8pJWuYB1tIJuRNCAIRH6UFGDVxzSqWRXsWufdnPGn2/fm4hp
         zbpKwVR+N7kuGmN5sE7jRktdNflfCDv+vaoGKVd2igU4miwM6NyDTEec2pL4CTOdu1
         uKnn+Y+n7JHjTRRL/5uagoaV5XD2s5qMriVQxFCk+FV007RfhqhsH1B+JSUsGaDrq/
         3SDJPNTUGgsNA==
Date:   Mon, 2 Aug 2021 14:50:37 +0100
From:   Will Deacon <will@kernel.org>
To:     David Stevens <stevensd@chromium.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dma-iommu: fix arch_sync_dma for map with swiotlb
Message-ID: <20210802135037.GD28547@willie-the-truck>
References: <20210709033502.3545820-1-stevensd@google.com>
 <20210709033502.3545820-3-stevensd@google.com>
 <20210802134059.GC28547@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802134059.GC28547@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 02:40:59PM +0100, Will Deacon wrote:
> On Fri, Jul 09, 2021 at 12:35:00PM +0900, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> > 
> > When calling arch_sync_dma, we need to pass it the memory that's
> > actually being used for dma. When using swiotlb bounce buffers, this is
> > the bounce buffer. Move arch_sync_dma into the __iommu_dma_map_swiotlb
> > helper, so it can use the bounce buffer address if necessary. This also
> > means it is no longer necessary to call iommu_dma_sync_sg_for_device in
> > iommu_dma_map_sg for untrusted devices.
> > 
> > Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> >  drivers/iommu/dma-iommu.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index eac65302439e..e79e274d2dc5 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -574,6 +574,9 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
> >  		memset(padding_start, 0, padding_size);
> >  	}
> >  
> > +	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> > +		arch_sync_dma_for_device(phys, org_size, dir);
> 
> I think this relies on the swiotlb buffers residing in the linear mapping
> (i.e. where phys_to_virt() is reliable), which doesn't look like a safe
> assumption to me.

No, sorry, ignore me here. I misread swiotlb_bounce(), so I think your
change is good.

As an aside, it strikes me that we'd probably be better off using
uncacheable bounce buffers for non-coherent devices so we could avoid all
this maintenance entirely.

Will
