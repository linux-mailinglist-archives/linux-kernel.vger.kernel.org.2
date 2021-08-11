Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1113E8A05
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 08:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbhHKGIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 02:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbhHKGIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 02:08:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DCEC061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 23:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ho6/AeZ5c1e6H7tCddsJ5x23ZKaDp8UDRhTSPgHPvu0=; b=cZJRapbbrIvpgLvOp7/1uAXVx5
        dUxcxMYN8KjE8/1aIb4A1gTXnPj/PCrV39losPl6E2htv9/fydbXUf/YByRpUt3Gxxmzwo86jmo7+
        f8/Fk0dONTrPS8qOO9ogUq9y3ZQy4P+hn/BJ3ZeudBRF9l+cMu2AD82AlwSSMs0ju2mixWhnMbyU3
        jxO8eMH97woKOLErPaAXI5dt7g635pg0SXEQcjEvJE5wwmu8CJPfuKI8KlG6lYScP490vN8rugRDx
        +zNFkOXyjv6tAJitWfjSzsmHjN13O3Pd0lwwJx4xn5Eh/pVLL/vDznokXwU+5wPRbvNqOuhsV22cE
        N82GXKbg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDhOf-00D2xK-2R; Wed, 11 Aug 2021 06:07:33 +0000
Date:   Wed, 11 Aug 2021 07:07:25 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     David Stevens <stevensd@chromium.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v3 3/5] dma-iommu: add SKIP_CPU_SYNC after syncing
Message-ID: <YRNpHcskc0Vv1ofa@infradead.org>
References: <20210811024247.1144246-1-stevensd@google.com>
 <20210811024247.1144246-4-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811024247.1144246-4-stevensd@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 4f0cc4a0a61f..be0214b1455c 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -859,8 +859,11 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>  static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs)
>  {
> -	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
>  		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
> +		attrs |= DMA_ATTR_SKIP_CPU_SYNC;
> +	}
> +
>  	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);

I don't think this is the correct way to go.  Instead just call the
raw cache sync helper instead of iommu_dma_sync_single_for_cpu, similar
to what dma-direct does.  Same for the map side.
