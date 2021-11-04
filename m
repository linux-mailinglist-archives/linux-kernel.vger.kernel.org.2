Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E106445424
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 14:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhKDNnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 09:43:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:58298 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232078AbhKDNms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 09:42:48 -0400
X-UUID: dd3d1f00d03641ca81ca0244cbffcbeb-20211104
X-UUID: dd3d1f00d03641ca81ca0244cbffcbeb-20211104
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 125901010; Thu, 04 Nov 2021 21:40:04 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 4 Nov 2021 21:40:03 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs10n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 4 Nov 2021 21:40:03 +0800
Message-ID: <9da413e95727a3b48ea35ec576aa1b1b57ffc9b9.camel@mediatek.com>
Subject: Re: [PATCH v2] dma-direct: improve DMA_ATTR_NO_KERNEL_MAPPING
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 4 Nov 2021 21:40:03 +0800
In-Reply-To: <CAMj1kXG0DmLXQgfv2N1nhNdXgnXOiK2Rv7D+boSdW9_C=wsowA@mail.gmail.com>
References: <20211104023221.16391-1-walter-zh.wu@mediatek.com>
         <20211104085336.GA24260@lst.de>
         <CAMj1kXHjjmhCVzKFhAseMGOdnidmFT=+o+vwKLTCGFkpwHmcfQ@mail.gmail.com>
         <cc893162f0e2c81a1d64bf85794cc77ae76cadce.camel@mediatek.com>
         <CAMj1kXG0DmLXQgfv2N1nhNdXgnXOiK2Rv7D+boSdW9_C=wsowA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-11-04 at 13:47 +0100, Ard Biesheuvel wrote:
> On Thu, 4 Nov 2021 at 13:31, Walter Wu <walter-zh.wu@mediatek.com>
> wrote:
> > 
> > On Thu, 2021-11-04 at 09:57 +0100, Ard Biesheuvel wrote:
> > > On Thu, 4 Nov 2021 at 09:53, Christoph Hellwig <hch@lst.de>
> > > wrote:
> > > > 
> > > > On Thu, Nov 04, 2021 at 10:32:21AM +0800, Walter Wu wrote:
> > > > > diff --git a/include/linux/set_memory.h
> > > > > b/include/linux/set_memory.h
> > > > > index f36be5166c19..6c7d1683339c 100644
> > > > > --- a/include/linux/set_memory.h
> > > > > +++ b/include/linux/set_memory.h
> > > > > @@ -7,11 +7,16 @@
> > > > > 
> > > > >  #ifdef CONFIG_ARCH_HAS_SET_MEMORY
> > > > >  #include <asm/set_memory.h>
> > > > > +
> > > > > +#ifndef CONFIG_RODATA_FULL_DEFAULT_ENABLED
> > > > 
> > > > This is an arm64-specific symbol, and one that only controls a
> > > > default.  I don't think it is suitable to key off stubs in
> > > > common
> > > > code.
> > > > 
> > > > > +static inline int set_memory_valid(unsigned long addr, int
> > > > > numpages, int enable) { return 0; }
> > > > 
> > > > Pleae avoid overly long lines.
> > > > 
> > > > > +             if
> > > > > (IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED))
> > > > > {
> > > > > +                     kaddr = (unsigned
> > > > > long)phys_to_virt(dma_to_phys(dev, *dma_handle));
> > > > 
> > > > This can just use page_address.
> > > > 
> > > > > +                     /* page remove kernel mapping for arm64
> > > > > */
> > > > > +                     set_memory_valid(kaddr, size >>
> > > > > PAGE_SHIFT,
> > > > > 0);
> > > > > +             }
> > > > 
> > > > But more importantly:  set_memory_valid only exists on arm64,
> > > > this
> > > > will break compile everywhere else.  And this API is complete
> > > > crap.
> > > > Passing kernel virtual addresses as unsigned long just sucks,
> > > > and
> > > > passing an integer argument for valid/non-valid also is a
> > > > horrible
> > > > API.
> > > > 
> > > 
> > > ... and as I pointed out before, you can still pass rodata=off on
> > > arm64, and get the old behavior, in which case bad things will
> > > happen
> > > if you try to use an API that expects to operate on page mappings
> > > with
> > > a 1 GB block mapping.
> > > 
> > 
> > Thanks for your suggestion.
> > 
> > 
> > > And you still haven't explained what the actual problem is: is
> > > this
> > > about CPU speculation corrupting non-cache coherent inbound DMA?
> > 
> > No corrupiton, only cpu read it, we hope to fix the behavior.
> > 
> 
> Fix which behavior? Please explain
> 
> 1) the current behavior
We call dma_direct_alloc() with DMA_ATTR_NO_KERNEL_MAPPING to get the
allocated buffer and the kernel mapping is exist. Our goal is this
buffer doesn't allow to be accessed by cpu. Unfortunately, we see cpu
speculation to read it. So we need to fix it and don't use no-map the
way.

> 2) why the current behavior is problematic for you
dma_direct_alloc() with DMA_ATTR_NO_KERNEL_MAPPING have kernel mapping,
so it still has cpu speculation read the buffer. Although we have
hardware to protect the buffer, we still hope use software to fix it.

> 3) how this patch changes the current behavior
When call dma_direct_alloc() with DMA_ATTR_NO_KERNEL_MAPPING, then
remove the kernel mapping which belong to the buffer.

> 4) why the new behavior fixes your problem.
If I understand correctly, want to block cpu speculation, then need
unmap the buffer at stage 1 and stage 2 page table and tlb invalidate.
This patch is to do stage 1 unmap at EL1.

> 
> There is no penalty for using too many words.

Thanks.
Walter

