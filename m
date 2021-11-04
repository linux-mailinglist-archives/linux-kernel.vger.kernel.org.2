Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231D74450A0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 09:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhKDI4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 04:56:18 -0400
Received: from verein.lst.de ([213.95.11.211]:34363 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230084AbhKDI4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 04:56:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 89EB968AA6; Thu,  4 Nov 2021 09:53:36 +0100 (CET)
Date:   Thu, 4 Nov 2021 09:53:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] dma-direct: improve DMA_ATTR_NO_KERNEL_MAPPING
Message-ID: <20211104085336.GA24260@lst.de>
References: <20211104023221.16391-1-walter-zh.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104023221.16391-1-walter-zh.wu@mediatek.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 10:32:21AM +0800, Walter Wu wrote:
> diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
> index f36be5166c19..6c7d1683339c 100644
> --- a/include/linux/set_memory.h
> +++ b/include/linux/set_memory.h
> @@ -7,11 +7,16 @@
>  
>  #ifdef CONFIG_ARCH_HAS_SET_MEMORY
>  #include <asm/set_memory.h>
> +
> +#ifndef CONFIG_RODATA_FULL_DEFAULT_ENABLED

This is an arm64-specific symbol, and one that only controls a
default.  I don't think it is suitable to key off stubs in common
code.

> +static inline int set_memory_valid(unsigned long addr, int numpages, int enable) { return 0; }

Pleae avoid overly long lines.

> +		if (IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED)) {
> +			kaddr = (unsigned long)phys_to_virt(dma_to_phys(dev, *dma_handle));

This can just use page_address.

> +			/* page remove kernel mapping for arm64 */
> +			set_memory_valid(kaddr, size >> PAGE_SHIFT, 0);
> +		}

But more importantly:  set_memory_valid only exists on arm64, this
will break compile everywhere else.  And this API is complete crap.
Passing kernel virtual addresses as unsigned long just sucks, and
passing an integer argument for valid/non-valid also is a horrible
API.

Not to mention the overly long line.  Same on the free side.
