Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FB03D537C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 09:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhGZGUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 02:20:45 -0400
Received: from verein.lst.de ([213.95.11.211]:43954 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231879AbhGZGUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 02:20:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B117C68BEB; Mon, 26 Jul 2021 09:01:00 +0200 (CEST)
Date:   Mon, 26 Jul 2021 09:01:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@lst.de>, devicetree@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        iommu@lists.linux-foundation.org, linux-riscv@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [RFC 4/5] dma-direct: Allocate dma pages directly if global
 pool allocation fails
Message-ID: <20210726070100.GC9035@lst.de>
References: <20210723214031.3251801-1-atish.patra@wdc.com> <20210723214031.3251801-5-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723214031.3251801-5-atish.patra@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 02:40:30PM -0700, Atish Patra wrote:
> DMA_GLOBAL_POOL config may be enabled for platforms where global pool is
> not supported because a generic defconfig is expected to boot on different
> platforms. Specifically, some RISC-V platforms may use global pool for
> non-coherent devices while some other platforms are completely coherent.
> However, it is expected that single kernel image must boot on all the
> platforms.
> 
> Continue the dma direct allocation if a allocation from global pool failed.
> This indicates that the platform is relying on some other method (direct
> remap) or just have coherent devices.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  kernel/dma/direct.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index d1d0258ed6d0..984ea776f099 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -161,8 +161,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
>  
>  	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
> -	    !dev_is_dma_coherent(dev))
> -		return dma_alloc_from_global_coherent(dev, size, dma_handle);
> +	    !dev_is_dma_coherent(dev)) {
> +		ret = dma_alloc_from_global_coherent(dev, size, dma_handle);
> +		if (ret)
> +			return ret;

This will now silently return normal non-cache coherent memory when
the global pool allocation fails, and thus is completely broken.
