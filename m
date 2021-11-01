Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43A4441AFE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 13:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhKAMKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 08:10:35 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:43936 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231673AbhKAMKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 08:10:32 -0400
X-UUID: 96666a0304944cc38cc087434f5944a7-20211101
X-UUID: 96666a0304944cc38cc087434f5944a7-20211101
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 909134349; Mon, 01 Nov 2021 20:07:56 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 1 Nov 2021 20:07:54 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Nov 2021 20:07:54 +0800
Message-ID: <73d900564ce9b0d773c801efe8b8689946bef150.camel@mediatek.com>
Subject: Re: [PATCH] dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>
Date:   Mon, 1 Nov 2021 20:07:54 +0800
In-Reply-To: <0316e4f0-b0ad-c702-676f-36347b4ebcb1@arm.com>
References: <20211101031558.7184-1-walter-zh.wu@mediatek.com>
         <0316e4f0-b0ad-c702-676f-36347b4ebcb1@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Mon, 2021-11-01 at 10:29 +0000, Robin Murphy wrote:
> On 2021-11-01 03:15, Walter Wu wrote:
> > DMA_ATTR_NO_KERNEL_MAPPING is to avoid creating a kernel mapping
> > for the allocated buffer, but current implementation is that
> > PTE of allocated buffer in kernel page table is valid. So we
> > should set invalid for PTE of allocate buffer so that there are
> > no kernel mapping for the allocated buffer.
> 
> No, the semantic of NO_KERNEL_MAPPING is an indication that the
> *caller* 
> does not need a mapping, such that the DMA API implementation may
> choose 
> to optimise for that internally. It has never given any guarantee of
> any 
> particular behaviour - like most attributes it is only a hint.
> 
> > In some cases, we don't hope the allocated buffer to be read
> > by cpu or speculative execution, so we use
> > DMA_ATTR_NO_KERNEL_MAPPING
> > to get no kernel mapping in order to achieve this goal.
> 
> If it's important that no CPU accesses to this memory can happen,
> then I 
> think the only way to absolutely guarantee that is to exclude it
> from 
> the kernel's memory map in the first place, e.g. as a DT reserved-
> memory 
> region with the "no-map" property.
> 

Yes, this is our previous implementation, but we hope to use kernel
memory to fix it.

Thanks for your suggestion.

Walter

> Robin.
> 
> > Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >   kernel/dma/direct.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 4c6c5e0635e3..aa10b4c5d762 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -13,6 +13,7 @@
> >   #include <linux/vmalloc.h>
> >   #include <linux/set_memory.h>
> >   #include <linux/slab.h>
> > +#include <asm/cacheflush.h>
> >   #include "direct.h"
> >   
> >   /*
> > @@ -169,6 +170,9 @@ void *dma_direct_alloc(struct device *dev,
> > size_t size,
> >   		if (!PageHighMem(page))
> >   			arch_dma_prep_coherent(page, size);
> >   		*dma_handle = phys_to_dma_direct(dev,
> > page_to_phys(page));
> > +		/* remove kernel mapping for pages */
> > +		set_memory_valid((unsigned
> > long)phys_to_virt(dma_to_phys(dev, *dma_handle)),
> > +				size >> PAGE_SHIFT, 0);
> >   		/* return the page pointer as the opaque cookie */
> >   		return page;
> >   	}
> > @@ -278,6 +282,10 @@ void dma_direct_free(struct device *dev,
> > size_t size,
> >   
> >   	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> >   	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
> > {
> > +		size = PAGE_ALIGN(size);
> > +		/* create kernel mapping for pages */
> > +		set_memory_valid((unsigned
> > long)phys_to_virt(dma_to_phys(dev, dma_addr)),
> > +				size >> PAGE_SHIFT, 1);
> >   		/* cpu_addr is a struct page cookie, not a kernel
> > address */
> >   		dma_free_contiguous(dev, cpu_addr, size);
> >   		return;
> > 

