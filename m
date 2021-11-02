Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA31442734
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 07:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhKBGqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 02:46:34 -0400
Received: from verein.lst.de ([213.95.11.211]:54613 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhKBGqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 02:46:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 85F8768AFE; Tue,  2 Nov 2021 07:43:56 +0100 (CET)
Date:   Tue, 2 Nov 2021 07:43:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING
Message-ID: <20211102064356.GB27749@lst.de>
References: <20211101031558.7184-1-walter-zh.wu@mediatek.com> <CAMj1kXGqOzHM+J30TXR3-uZPkjHBCXB4CMkzZjHbbmptyU5W9w@mail.gmail.com> <76840b40fcf26a65467931a73f236982ad39989c.camel@mediatek.com> <CAMj1kXFrUrThJFDJ0Q9qjDemcEovQVMtO20KbdnLccp7VfyVwA@mail.gmail.com> <c9f74d817aa1ae1cceaee9ec226d39bbdf2c5c48.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9f74d817aa1ae1cceaee9ec226d39bbdf2c5c48.camel@mediatek.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 11:21:16AM +0800, Walter Wu wrote:
> Our platform is arch64. We need a dynamic allocated buffer from CMA is
> not to read by CPU peculative execution, so we need to remove its
> kernel mapping.

If your CPU speculates into unused kernel direct mappings your have
a worse problem than this, because all the dma coherent allocations for
non-coherent devices still have a cachable direct mapping.  Will
mentioned he wanted to look into getting rid of that mapping now that
the core dma code has the infrastucture for that, so adding him here.
