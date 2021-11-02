Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79064425FF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 04:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhKBDXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 23:23:55 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:54600 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229526AbhKBDXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 23:23:51 -0400
X-UUID: 98af482b8778443ca1aa8da941edd2f1-20211102
X-UUID: 98af482b8778443ca1aa8da941edd2f1-20211102
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 571906133; Tue, 02 Nov 2021 11:21:16 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 2 Nov 2021 11:21:16 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs10n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 2 Nov 2021 11:21:16 +0800
Message-ID: <c9f74d817aa1ae1cceaee9ec226d39bbdf2c5c48.camel@mediatek.com>
Subject: Re: [PATCH] dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>
Date:   Tue, 2 Nov 2021 11:21:16 +0800
In-Reply-To: <CAMj1kXFrUrThJFDJ0Q9qjDemcEovQVMtO20KbdnLccp7VfyVwA@mail.gmail.com>
References: <20211101031558.7184-1-walter-zh.wu@mediatek.com>
         <CAMj1kXGqOzHM+J30TXR3-uZPkjHBCXB4CMkzZjHbbmptyU5W9w@mail.gmail.com>
         <76840b40fcf26a65467931a73f236982ad39989c.camel@mediatek.com>
         <CAMj1kXFrUrThJFDJ0Q9qjDemcEovQVMtO20KbdnLccp7VfyVwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-01 at 15:17 +0100, Ard Biesheuvel wrote:
> On Mon, 1 Nov 2021 at 13:21, Walter Wu <walter-zh.wu@mediatek.com>
> wrote:
> > 
> > Hi Ard,
> > 
> > On Mon, 2021-11-01 at 09:34 +0100, Ard Biesheuvel wrote:
> > > On Mon, 1 Nov 2021 at 04:17, Walter Wu <walter-zh.wu@mediatek.com
> > > >
> > > wrote:
> > > > 
> > > > DMA_ATTR_NO_KERNEL_MAPPING is to avoid creating a kernel
> > > > mapping
> > > > for the allocated buffer, but current implementation is that
> > > > PTE of allocated buffer in kernel page table is valid. So we
> > > > should set invalid for PTE of allocate buffer so that there are
> > > > no kernel mapping for the allocated buffer.
> > > > 
> > > > In some cases, we don't hope the allocated buffer to be read
> > > > by cpu or speculative execution, so we use
> > > > DMA_ATTR_NO_KERNEL_MAPPING
> > > > to get no kernel mapping in order to achieve this goal.
> > > > 
> > > > Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > > > Cc: Christoph Hellwig <hch@lst.de>
> > > > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > ---
> > > >  kernel/dma/direct.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > > 
> > > > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > > > index 4c6c5e0635e3..aa10b4c5d762 100644
> > > > --- a/kernel/dma/direct.c
> > > > +++ b/kernel/dma/direct.c
> > > > @@ -13,6 +13,7 @@
> > > >  #include <linux/vmalloc.h>
> > > >  #include <linux/set_memory.h>
> > > >  #include <linux/slab.h>
> > > > +#include <asm/cacheflush.h>
> > > >  #include "direct.h"
> > > > 
> > > >  /*
> > > > @@ -169,6 +170,9 @@ void *dma_direct_alloc(struct device *dev,
> > > > size_t size,
> > > >                 if (!PageHighMem(page))
> > > >                         arch_dma_prep_coherent(page, size);
> > > >                 *dma_handle = phys_to_dma_direct(dev,
> > > > page_to_phys(page));
> > > > +               /* remove kernel mapping for pages */
> > > > +               set_memory_valid((unsigned
> > > > long)phys_to_virt(dma_to_phys(dev, *dma_handle)),
> > > > +                               size >> PAGE_SHIFT, 0);
> > > 
> > > This only works if the memory is mapped at page granularity in
> > > the
> > > linear region, and you cannot rely on that. Many architectures
> > > prefer
> > > block mappings for the linear region, and arm64 will only use
> > > page
> > > mappings if rodata=full is set (which is set by default but can
> > > be
> > > overridden on the kernel command line)
> > > 
> > 
> > We mainly want to solve arm64 arch.
> 
> Solve what?

Our platform is arch64. We need a dynamic allocated buffer from CMA is
not to read by CPU peculative execution, so we need to remove its
kernel mapping.

> > RODATA_FULL_DEFAULT_ENABLED should
> > be the arm64 config. If we use CONFIG_RODATA_FULL_DEFAULT_ENABLED
> > to
> > check whether it call set_memory_valid(). It should avoid other
> > architectures. Do you think this method is work?
> > 
> 
> No. Try it with rodata=off (or rodata=on for that matter) and see
> what happens.
> 

I try with rodata=[off/on] on qemu, it looks like boot pass. see below.

[    0.000000] Kernel command line: root=/dev/ram0 rw rootfstype=ext4
rodata=off console=ttyAMA0 rdinit=qemu/ramdisk.img earlyprintk=serial


I also try with rodata=off on our platform and do stress test, it looks
like pass.


Thanks.
Walter

> > Thanks for your explaination and suggestion.
> > 
> 
> YW
> 
> > 
> > > 
> > > >                 /* return the page pointer as the opaque cookie
> > > > */
> > > >                 return page;
> > > >         }
> > > > @@ -278,6 +282,10 @@ void dma_direct_free(struct device *dev,
> > > > size_t size,
> > > > 
> > > >         if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> > > >             !force_dma_unencrypted(dev) &&
> > > > !is_swiotlb_for_alloc(dev)) {
> > > > +               size = PAGE_ALIGN(size);
> > > > +               /* create kernel mapping for pages */
> > > > +               set_memory_valid((unsigned
> > > > long)phys_to_virt(dma_to_phys(dev, dma_addr)),
> > > > +                               size >> PAGE_SHIFT, 1);
> > > >                 /* cpu_addr is a struct page cookie, not a
> > > > kernel
> > > > address */
> > > >                 dma_free_contiguous(dev, cpu_addr, size);
> > > >                 return;
> > > > --
> > > > 2.18.0
> > > > 
> > > > 
> > > > _______________________________________________
> > > > linux-arm-kernel mailing list
> > > > linux-arm-kernel@lists.infradead.org
> > > > 
> > 
> > 
https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/linux-arm-kernel__;!!CTRNKA9wMg0ARbw!16dLCjnvtRkaRLeCO9AQ7Fund5XL0FicZmeVaU3-WkFymr-0lbITfzwrvoJpiHlqnqIu-g$
> > > > 

