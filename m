Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F333D536F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 08:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhGZGQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 02:16:33 -0400
Received: from verein.lst.de ([213.95.11.211]:43913 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229658AbhGZGQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 02:16:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 408B168AFE; Mon, 26 Jul 2021 08:56:58 +0200 (CEST)
Date:   Mon, 26 Jul 2021 08:56:57 +0200
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
Subject: Re: [RFC 1/5] RISC-V: Implement arch_sync_dma* functions
Message-ID: <20210726065657.GA9035@lst.de>
References: <20210723214031.3251801-1-atish.patra@wdc.com> <20210723214031.3251801-2-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723214031.3251801-2-atish.patra@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_RISCV_DMA_NONCOHERENT
> +struct riscv_dma_cache_sync {
> +	void (*cache_invalidate)(phys_addr_t paddr, size_t size);
> +	void (*cache_clean)(phys_addr_t paddr, size_t size);
> +	void (*cache_flush)(phys_addr_t paddr, size_t size);
> +};
> +
> +void riscv_dma_cache_sync_set(struct riscv_dma_cache_sync *ops);
> +#endif

As told a bunch of times before: doing indirect calls here is a
performance nightmare.  Use something that actually does perform
horribly like alternatives.  Or even delay implementing that until
we need it and do a plain direct call for now.

static void __dma_sync(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
> +{
> +	if ((dir == DMA_FROM_DEVICE) && (dma_cache_sync->cache_invalidate))
> +		dma_cache_sync->cache_invalidate(paddr, size);
> +	else if ((dir == DMA_TO_DEVICE) && (dma_cache_sync->cache_clean))
> +		dma_cache_sync->cache_clean(paddr, size);
> +	else if ((dir == DMA_BIDIRECTIONAL) && dma_cache_sync->cache_flush)
> +		dma_cache_sync->cache_flush(paddr, size);
> +}

The seletion of flush types is completely broken.  Take a look at the
comment in arch/arc/mm/dma.c above arch_sync_dma_for_device for a good
explanation.

> +void arch_dma_prep_coherent(struct page *page, size_t size)
> +{
> +	void *flush_addr = page_address(page);
> +
> +	memset(flush_addr, 0, size);

arch_dma_prep_coherent is not supposed to modify the content of
the data.
