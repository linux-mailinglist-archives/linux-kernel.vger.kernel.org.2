Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39493BF798
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 11:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhGHJcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 05:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhGHJcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 05:32:03 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8853CC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 02:29:21 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3AF02312; Thu,  8 Jul 2021 11:29:20 +0200 (CEST)
Date:   Thu, 8 Jul 2021 11:29:18 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     David Stevens <stevensd@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@google.com>
Subject: Re: [PATCH 0/4] Add dynamic iommu backed bounce buffers
Message-ID: <YObFbqEk1nGVuHLF@8bytes.org>
References: <20210707075505.2896824-1-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707075505.2896824-1-stevensd@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Robin too.

On Wed, Jul 07, 2021 at 04:55:01PM +0900, David Stevens wrote:
> Add support for per-domain dynamic pools of iommu bounce buffers to the 
> dma-iommu API. This allows iommu mappings to be reused while still
> maintaining strict iommu protection. Allocating buffers dynamically
> instead of using swiotlb carveouts makes per-domain pools more amenable
> on systems with large numbers of devices or where devices are unknown.
> 
> When enabled, all non-direct streaming mappings below a configurable
> size will go through bounce buffers. Note that this means drivers which
> don't properly use the DMA API (e.g. i915) cannot use an iommu when this
> feature is enabled. However, all drivers which work with swiotlb=force
> should work.
> 
> Bounce buffers serve as an optimization in situations where interactions
> with the iommu are very costly. For example, virtio-iommu operations in
> a guest on a linux host require a vmexit, involvement the VMM, and a
> VFIO syscall. For relatively small DMA operations, memcpy can be
> significantly faster.
> 
> As a performance comparison, on a device with an i5-10210U, I ran fio
> with a VFIO passthrough NVMe drive with '--direct=1 --rw=read
> --ioengine=libaio --iodepth=64' and block sizes 4k, 16k, 64k, and
> 128k. Test throughput increased by 2.8x, 4.7x, 3.6x, and 3.6x. Time
> spent in iommu_dma_unmap_(page|sg) per GB processed decreased by 97%,
> 94%, 90%, and 87%. Time spent in iommu_dma_map_(page|sg) decreased
> by >99%, as bounce buffers don't require syncing here in the read case.
> Running with multiple jobs doesn't serve as a useful performance
> comparison because virtio-iommu and vfio_iommu_type1 both have big
> locks that significantly limit mulithreaded DMA performance.
> 
> This patch set is based on v5.13-rc7 plus the patches at [1].
> 
> David Stevens (4):
>   dma-iommu: add kalloc gfp flag to alloc helper
>   dma-iommu: replace device arguments
>   dma-iommu: expose a few helper functions to module
>   dma-iommu: Add iommu bounce buffers to dma-iommu api
> 
>  drivers/iommu/Kconfig          |  10 +
>  drivers/iommu/Makefile         |   1 +
>  drivers/iommu/dma-iommu.c      | 119 ++++--
>  drivers/iommu/io-buffer-pool.c | 656 +++++++++++++++++++++++++++++++++
>  drivers/iommu/io-buffer-pool.h |  91 +++++
>  include/linux/dma-iommu.h      |  12 +
>  6 files changed, 861 insertions(+), 28 deletions(-)
>  create mode 100644 drivers/iommu/io-buffer-pool.c
>  create mode 100644 drivers/iommu/io-buffer-pool.h
> 
> -- 
> 2.32.0.93.g670b81a890-goog
