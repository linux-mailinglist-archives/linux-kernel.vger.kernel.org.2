Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26A54427D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhKBHL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:11:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38580 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230509AbhKBHKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:10:49 -0400
X-UUID: 9bc5c97f025f42dca1c5f591645a22ad-20211102
X-UUID: 9bc5c97f025f42dca1c5f591645a22ad-20211102
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 497361011; Tue, 02 Nov 2021 15:08:12 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 2 Nov 2021 15:08:11 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 2 Nov 2021 15:08:11 +0800
Message-ID: <8903df2ad1ae1e0dfaafb3766beef7d0ec156f28.camel@mediatek.com>
Subject: Re: [PATCH] dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>
Date:   Tue, 2 Nov 2021 15:08:11 +0800
In-Reply-To: <20211102064155.GA27749@lst.de>
References: <20211101031558.7184-1-walter-zh.wu@mediatek.com>
         <20211102064155.GA27749@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristoph,

On Tue, 2021-11-02 at 07:41 +0100, Christoph Hellwig wrote:
> As others pointed out, DMA_ATTR_NO_KERNEL_MAPPING just means the
> caller can't rely on a kernel mapping.  So the "fix" here is
> wrong.  That being said for cases where we can easily remove a page
> from the kernel mapping it would be nice to do to:
> 
>  a) improve security
>  b) as a debug check to see that no one actually tries to access it
> 

I will modify my commit message. Thanks for your comment.

> > +		/* remove kernel mapping for pages */
> > +		set_memory_valid((unsigned
> > long)phys_to_virt(dma_to_phys(dev, *dma_handle)),
> 
> Please avoid overly long lines.  Also this function only exists for
> arm64
> also and others pointed out won't work for all cases.

Got it. I will send v2 patch.

Thanks for your review and suggestion.


Walter

