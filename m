Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066D045A219
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 12:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbhKWMCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 07:02:03 -0500
Received: from foss.arm.com ([217.140.110.172]:51650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231180AbhKWMCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 07:02:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDC521063;
        Tue, 23 Nov 2021 03:58:54 -0800 (PST)
Received: from [10.57.56.56] (unknown [10.57.56.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8214F3F5A1;
        Tue, 23 Nov 2021 03:58:52 -0800 (PST)
Message-ID: <75ea1026-63e5-165a-9e07-27b5ac4c7579@arm.com>
Date:   Tue, 23 Nov 2021 11:58:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 0/3] Allow restricted-dma-pool to customize IO_TLB_SEGSIZE
Content-Language: en-GB
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        - <devicetree-spec@vger.kernel.org>, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, senozhatsky@chromium.org,
        tfiga@chromium.org
References: <20211123112104.3530135-1-hsinyi@chromium.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211123112104.3530135-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-23 11:21, Hsin-Yi Wang wrote:
> Default IO_TLB_SEGSIZE (128) slabs may be not enough for some use cases.
> This series adds support to customize io_tlb_segsize for each
> restricted-dma-pool.
> 
> Example use case:
> 
> mtk-isp drivers[1] are controlled by mtk-scp[2] and allocate memory through
> mtk-scp. In order to use the noncontiguous DMA API[3], we need to use
> the swiotlb pool. mtk-scp needs to allocate memory with 2560 slabs.
> mtk-isp drivers also needs to allocate memory with 200+ slabs. Both are
> larger than the default IO_TLB_SEGSIZE (128) slabs.

Are drivers really doing streaming DMA mappings that large? If so, that 
seems like it might be worth trying to address in its own right for the 
sake of efficiency - allocating ~5MB of memory twice and copying it back 
and forth doesn't sound like the ideal thing to do.

If it's really about coherent DMA buffer allocation, I thought the plan 
was that devices which expect to use a significant amount and/or size of 
coherent buffers would continue to use a shared-dma-pool for that? It's 
still what the binding implies. My understanding was that 
swiotlb_alloc() is mostly just a fallback for the sake of drivers which 
mostly do streaming DMA but may allocate a handful of pages worth of 
coherent buffers here and there. Certainly looking at the mtk_scp 
driver, that seems like it shouldn't be going anywhere near SWIOTLB at all.

Robin.

> [1] (not in upstream) https://patchwork.kernel.org/project/linux-media/cover/20190611035344.29814-1-jungo.lin@mediatek.com/
> [2] https://elixir.bootlin.com/linux/latest/source/drivers/remoteproc/mtk_scp.c
> [3] https://patchwork.kernel.org/project/linux-media/cover/20210909112430.61243-1-senozhatsky@chromium.org/
> 
> Hsin-Yi Wang (3):
>    dma: swiotlb: Allow restricted-dma-pool to customize IO_TLB_SEGSIZE
>    dt-bindings: Add io-tlb-segsize property for restricted-dma-pool
>    arm64: dts: mt8183: use restricted swiotlb for scp mem
> 
>   .../reserved-memory/shared-dma-pool.yaml      |  8 +++++
>   .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  4 +--
>   include/linux/swiotlb.h                       |  1 +
>   kernel/dma/swiotlb.c                          | 34 ++++++++++++++-----
>   4 files changed, 37 insertions(+), 10 deletions(-)
> 
