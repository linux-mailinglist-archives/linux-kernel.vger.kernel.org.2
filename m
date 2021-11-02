Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1795A44272F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 07:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhKBGod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 02:44:33 -0400
Received: from verein.lst.de ([213.95.11.211]:54601 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhKBGoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 02:44:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7487768AA6; Tue,  2 Nov 2021 07:41:55 +0100 (CET)
Date:   Tue, 2 Nov 2021 07:41:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING
Message-ID: <20211102064155.GA27749@lst.de>
References: <20211101031558.7184-1-walter-zh.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101031558.7184-1-walter-zh.wu@mediatek.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As others pointed out, DMA_ATTR_NO_KERNEL_MAPPING just means the
caller can't rely on a kernel mapping.  So the "fix" here is
wrong.  That being said for cases where we can easily remove a page
from the kernel mapping it would be nice to do to:

 a) improve security
 b) as a debug check to see that no one actually tries to access it

> +		/* remove kernel mapping for pages */
> +		set_memory_valid((unsigned long)phys_to_virt(dma_to_phys(dev, *dma_handle)),

Please avoid overly long lines.  Also this function only exists for arm64
also and others pointed out won't work for all cases.
