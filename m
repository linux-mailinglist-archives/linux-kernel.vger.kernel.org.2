Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CCC44284B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 08:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhKBH2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 03:28:52 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:40706 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229497AbhKBH2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 03:28:50 -0400
X-UUID: e7445f08e2964818a4e40bd383f7fff4-20211102
X-UUID: e7445f08e2964818a4e40bd383f7fff4-20211102
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1610379575; Tue, 02 Nov 2021 15:26:13 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 2 Nov 2021 15:26:12 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs10n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 2 Nov 2021 15:26:12 +0800
Message-ID: <c5036587af69e70a60f6187048be1991bb2d7e7b.camel@mediatek.com>
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
Date:   Tue, 2 Nov 2021 15:26:12 +0800
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

Hi Christoph,

I am sorry, fix my typo.


Walter

On Tue, 2021-11-02 at 07:41 +0100, Christoph Hellwig wrote:
> As others pointed out, DMA_ATTR_NO_KERNEL_MAPPING just means the
> caller can't rely on a kernel mapping.  So the "fix" here is
> wrong.  That being said for cases where we can easily remove a page
> from the kernel mapping it would be nice to do to:
> 
>  a) improve security
>  b) as a debug check to see that no one actually tries to access it
> 
> > +		/* remove kernel mapping for pages */
> > +		set_memory_valid((unsigned
> > long)phys_to_virt(dma_to_phys(dev, *dma_handle)),
> 
> Please avoid overly long lines.  Also this function only exists for
> arm64
> also and others pointed out won't work for all cases.

