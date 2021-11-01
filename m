Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1327C4419E3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 11:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhKAKcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 06:32:03 -0400
Received: from foss.arm.com ([217.140.110.172]:37610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232100AbhKAKcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 06:32:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2382411B3;
        Mon,  1 Nov 2021 03:29:28 -0700 (PDT)
Received: from [10.57.80.217] (unknown [10.57.80.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21D2B3F719;
        Mon,  1 Nov 2021 03:29:26 -0700 (PDT)
Message-ID: <0316e4f0-b0ad-c702-676f-36347b4ebcb1@arm.com>
Date:   Mon, 1 Nov 2021 10:29:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING
Content-Language: en-GB
To:     Walter Wu <walter-zh.wu@mediatek.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211101031558.7184-1-walter-zh.wu@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211101031558.7184-1-walter-zh.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-01 03:15, Walter Wu wrote:
> DMA_ATTR_NO_KERNEL_MAPPING is to avoid creating a kernel mapping
> for the allocated buffer, but current implementation is that
> PTE of allocated buffer in kernel page table is valid. So we
> should set invalid for PTE of allocate buffer so that there are
> no kernel mapping for the allocated buffer.

No, the semantic of NO_KERNEL_MAPPING is an indication that the *caller* 
does not need a mapping, such that the DMA API implementation may choose 
to optimise for that internally. It has never given any guarantee of any 
particular behaviour - like most attributes it is only a hint.

> In some cases, we don't hope the allocated buffer to be read
> by cpu or speculative execution, so we use DMA_ATTR_NO_KERNEL_MAPPING
> to get no kernel mapping in order to achieve this goal.

If it's important that no CPU accesses to this memory can happen, then I 
think the only way to absolutely guarantee that is to exclude it from 
the kernel's memory map in the first place, e.g. as a DT reserved-memory 
region with the "no-map" property.

Robin.

> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>   kernel/dma/direct.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4c6c5e0635e3..aa10b4c5d762 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -13,6 +13,7 @@
>   #include <linux/vmalloc.h>
>   #include <linux/set_memory.h>
>   #include <linux/slab.h>
> +#include <asm/cacheflush.h>
>   #include "direct.h"
>   
>   /*
> @@ -169,6 +170,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   		if (!PageHighMem(page))
>   			arch_dma_prep_coherent(page, size);
>   		*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> +		/* remove kernel mapping for pages */
> +		set_memory_valid((unsigned long)phys_to_virt(dma_to_phys(dev, *dma_handle)),
> +				size >> PAGE_SHIFT, 0);
>   		/* return the page pointer as the opaque cookie */
>   		return page;
>   	}
> @@ -278,6 +282,10 @@ void dma_direct_free(struct device *dev, size_t size,
>   
>   	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
>   	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
> +		size = PAGE_ALIGN(size);
> +		/* create kernel mapping for pages */
> +		set_memory_valid((unsigned long)phys_to_virt(dma_to_phys(dev, dma_addr)),
> +				size >> PAGE_SHIFT, 1);
>   		/* cpu_addr is a struct page cookie, not a kernel address */
>   		dma_free_contiguous(dev, cpu_addr, size);
>   		return;
> 
