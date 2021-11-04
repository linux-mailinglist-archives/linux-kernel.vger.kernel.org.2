Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D85D4452D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 13:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhKDMVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 08:21:15 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:33270 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229843AbhKDMVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 08:21:14 -0400
X-UUID: 731cec951b914e8b9b791b1b4e1d014f-20211104
X-UUID: 731cec951b914e8b9b791b1b4e1d014f-20211104
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1409694579; Thu, 04 Nov 2021 20:18:34 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 4 Nov 2021 20:18:33 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs10n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 4 Nov 2021 20:18:33 +0800
Message-ID: <f890498e474b48f017ec763cf866f7ddd1cc40c4.camel@mediatek.com>
Subject: Re: [PATCH v2] dma-direct: improve DMA_ATTR_NO_KERNEL_MAPPING
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 4 Nov 2021 20:18:33 +0800
In-Reply-To: <20211104085336.GA24260@lst.de>
References: <20211104023221.16391-1-walter-zh.wu@mediatek.com>
         <20211104085336.GA24260@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-11-04 at 09:53 +0100, Christoph Hellwig wrote:
> On Thu, Nov 04, 2021 at 10:32:21AM +0800, Walter Wu wrote:
> > diff --git a/include/linux/set_memory.h
> > b/include/linux/set_memory.h
> > index f36be5166c19..6c7d1683339c 100644
> > --- a/include/linux/set_memory.h
> > +++ b/include/linux/set_memory.h
> > @@ -7,11 +7,16 @@
> >  
> >  #ifdef CONFIG_ARCH_HAS_SET_MEMORY
> >  #include <asm/set_memory.h>
> > +
> > +#ifndef CONFIG_RODATA_FULL_DEFAULT_ENABLED
> 
> This is an arm64-specific symbol, and one that only controls a
> default.  I don't think it is suitable to key off stubs in common
> code.
> 

ok

> > +static inline int set_memory_valid(unsigned long addr, int
> > numpages, int enable) { return 0; }
> 
> Pleae avoid overly long lines.
> 
> > +		if (IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED)) {
> > +			kaddr = (unsigned
> > long)phys_to_virt(dma_to_phys(dev, *dma_handle));
> 
> This can just use page_address.
> 
> > +			/* page remove kernel mapping for arm64 */
> > +			set_memory_valid(kaddr, size >> PAGE_SHIFT, 0);
> > +		}
> 
> But more importantly:  set_memory_valid only exists on arm64, this
> will break compile everywhere else.  And this API is complete crap.
> Passing kernel virtual addresses as unsigned long just sucks, and
> passing an integer argument for valid/non-valid also is a horrible
> API.
> 

Would you think __kernel_map_page() is ok?
Many arch support it, and only pass page and page number. but need to
depend CONFIG_DEBUG_PAGEALLOC.

Thanks.
Walter


> Not to mention the overly long line.  Same on the free side.

