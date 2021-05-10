Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19335377E73
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 10:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhEJIpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 04:45:14 -0400
Received: from verein.lst.de ([213.95.11.211]:57663 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhEJIpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 04:45:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 446F667373; Mon, 10 May 2021 10:44:06 +0200 (CEST)
Date:   Mon, 10 May 2021 10:44:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chanho Park <chanho61.park@samsung.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Bumyong Lee <bumyong.lee@samsung.com>
Subject: Re: [PATCH] swiotlb: manipulate orig_addr when tlb_addr has offset
Message-ID: <20210510084406.GA1093@lst.de>
References: <CGME20210510083139epcas2p211d9bee16e5e8f8ea34e606c83ac3a55@epcas2p2.samsung.com> <20210510083057.46476-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510083057.46476-1-chanho61.park@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 05:30:57PM +0900, Chanho Park wrote:
> +static unsigned int swiotlb_align_offset(struct device *dev, u64 addr);

Please just move swiotlb_align_offset up to avoid the forward declaration.

>  /*
>   * Bounce: copy the swiotlb buffer from or back to the original dma location
>   */
> @@ -346,10 +347,17 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
>  	size_t alloc_size = mem->slots[index].alloc_size;
>  	unsigned long pfn = PFN_DOWN(orig_addr);
>  	unsigned char *vaddr = phys_to_virt(tlb_addr);
> +	unsigned int tlb_offset;
>  
>  	if (orig_addr == INVALID_PHYS_ADDR)
>  		return;
>  
> +	tlb_offset = (unsigned int)tlb_addr & (IO_TLB_SIZE - 1);
> +	tlb_offset -= swiotlb_align_offset(dev, orig_addr);

Nit: I'd write this as:

	tlb_offset = (tlb_addr & (IO_TLB_SIZE - 1)) -
			swiotlb_align_offset(dev, orig_addr);

as there is no need for the cast, and just having a single assignment
is easier to follow.
