Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8BC45BDEB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 13:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245637AbhKXMmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 07:42:25 -0500
Received: from foss.arm.com ([217.140.110.172]:36480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244230AbhKXMhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 07:37:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1C5F1042;
        Wed, 24 Nov 2021 04:34:42 -0800 (PST)
Received: from [10.57.56.56] (unknown [10.57.56.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EDD13F73B;
        Wed, 24 Nov 2021 04:34:41 -0800 (PST)
Message-ID: <927eb333-695d-89d6-f02e-b178b53ae4d9@arm.com>
Date:   Wed, 24 Nov 2021 12:34:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 0/3] Allow restricted-dma-pool to customize IO_TLB_SEGSIZE
Content-Language: en-GB
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     devicetree@vger.kernel.org, - <devicetree-spec@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        senozhatsky@chromium.org, iommu@lists.linux-foundation.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Maxime Ripard <maxime@cerno.tech>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20211123112104.3530135-1-hsinyi@chromium.org>
 <75ea1026-63e5-165a-9e07-27b5ac4c7579@arm.com>
 <CAJMQK-gHpmfedbRfR-1ZNLw0LpRDJHYoKLd-k3kvkqFf8vnD4A@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAJMQK-gHpmfedbRfR-1ZNLw0LpRDJHYoKLd-k3kvkqFf8vnD4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-24 03:55, Hsin-Yi Wang wrote:
> On Tue, Nov 23, 2021 at 7:58 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-11-23 11:21, Hsin-Yi Wang wrote:
>>> Default IO_TLB_SEGSIZE (128) slabs may be not enough for some use cases.
>>> This series adds support to customize io_tlb_segsize for each
>>> restricted-dma-pool.
>>>
>>> Example use case:
>>>
>>> mtk-isp drivers[1] are controlled by mtk-scp[2] and allocate memory through
>>> mtk-scp. In order to use the noncontiguous DMA API[3], we need to use
>>> the swiotlb pool. mtk-scp needs to allocate memory with 2560 slabs.
>>> mtk-isp drivers also needs to allocate memory with 200+ slabs. Both are
>>> larger than the default IO_TLB_SEGSIZE (128) slabs.
>>
>> Are drivers really doing streaming DMA mappings that large? If so, that
>> seems like it might be worth trying to address in its own right for the
>> sake of efficiency - allocating ~5MB of memory twice and copying it back
>> and forth doesn't sound like the ideal thing to do.
>>
>> If it's really about coherent DMA buffer allocation, I thought the plan
>> was that devices which expect to use a significant amount and/or size of
>> coherent buffers would continue to use a shared-dma-pool for that? It's
>> still what the binding implies. My understanding was that
>> swiotlb_alloc() is mostly just a fallback for the sake of drivers which
>> mostly do streaming DMA but may allocate a handful of pages worth of
>> coherent buffers here and there. Certainly looking at the mtk_scp
>> driver, that seems like it shouldn't be going anywhere near SWIOTLB at all.
>>
> mtk_scp on its own can use the shared-dma-pool, which it currently uses.
> The reason we switched to restricted-dma-pool is that we want to use
> the noncontiguous DMA API for mtk-isp. The noncontiguous DMA API is
> designed for devices with iommu, and if a device doesn't have an
> iommu, it will fallback using swiotlb. But currently noncontiguous DMA
> API doesn't work with the shared-dma-pool.
> 
> vb2_dc_alloc() -> dma_alloc_noncontiguous() -> alloc_single_sgt() ->
> __dma_alloc_pages() -> dma_direct_alloc_pages() ->
> __dma_direct_alloc_pages() -> swiotlb_alloc().

OK, thanks for clarifying. My gut feeling is that drivers should 
probably only be calling the noncontiguous API when they *know* that 
they have a scatter-gather-capable device or IOMMU that can cope with 
it, but either way I'm still not convinced that it makes sense to hack 
up SWIOTLB with DT ABI baggage for an obscure fallback case. It would 
seem a lot more sensible to fix alloc_single_sgt() to not ignore 
per-device pools once it has effectively fallen back to the normal 
dma_alloc_attrs() flow, but I guess that's not technically guaranteed to 
uphold the assumption that we can allocate struct-page-backed memory.

Still, if we've got to the point of needing to use a SWIOTLB pool as 
nothing more than a bad reinvention of CMA, rather than an actual bounce 
buffer, that reeks of a fundamental design issue and adding more hacks 
on top to bodge around it is not the right way to go - we need to take a 
step back and properly reconsider how dma_alloc_noncontiguous() is 
supposed to interact with DMA protection schemes.

Thanks,
Robin.

>>> [1] (not in upstream) https://patchwork.kernel.org/project/linux-media/cover/20190611035344.29814-1-jungo.lin@mediatek.com/
>>> [2] https://elixir.bootlin.com/linux/latest/source/drivers/remoteproc/mtk_scp.c
>>> [3] https://patchwork.kernel.org/project/linux-media/cover/20210909112430.61243-1-senozhatsky@chromium.org/
>>>
>>> Hsin-Yi Wang (3):
>>>     dma: swiotlb: Allow restricted-dma-pool to customize IO_TLB_SEGSIZE
>>>     dt-bindings: Add io-tlb-segsize property for restricted-dma-pool
>>>     arm64: dts: mt8183: use restricted swiotlb for scp mem
>>>
>>>    .../reserved-memory/shared-dma-pool.yaml      |  8 +++++
>>>    .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  4 +--
>>>    include/linux/swiotlb.h                       |  1 +
>>>    kernel/dma/swiotlb.c                          | 34 ++++++++++++++-----
>>>    4 files changed, 37 insertions(+), 10 deletions(-)
>>>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
