Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2368C3F02B9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 13:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbhHRLaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 07:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhHRLaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 07:30:11 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A10C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 04:29:36 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 39A6E24A; Wed, 18 Aug 2021 13:29:33 +0200 (CEST)
Date:   Wed, 18 Aug 2021 13:29:31 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yong Wu <yong.wu@mediatek.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 00/24] iommu: Refactor DMA domain strictness
Message-ID: <YRzvGxTW8m+NUcSi@8bytes.org>
References: <cover.1628682048.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1628682048.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 01:21:14PM +0100, Robin Murphy wrote:
> Robin Murphy (24):
>   iommu: Pull IOVA cookie management into the core
>   iommu/amd: Drop IOVA cookie management
>   iommu/arm-smmu: Drop IOVA cookie management
>   iommu/vt-d: Drop IOVA cookie management
>   iommu/exynos: Drop IOVA cookie management
>   iommu/ipmmu-vmsa: Drop IOVA cookie management
>   iommu/mtk: Drop IOVA cookie management
>   iommu/rockchip: Drop IOVA cookie management
>   iommu/sprd: Drop IOVA cookie management
>   iommu/sun50i: Drop IOVA cookie management
>   iommu/virtio: Drop IOVA cookie management
>   iommu/dma: Unexport IOVA cookie management
>   iommu/dma: Remove redundant "!dev" checks
>   iommu: Indicate queued flushes via gather data
>   iommu/io-pgtable: Remove non-strict quirk
>   iommu: Introduce explicit type for non-strict DMA domains
>   iommu/amd: Prepare for multiple DMA domain types
>   iommu/arm-smmu: Prepare for multiple DMA domain types
>   iommu/vt-d: Prepare for multiple DMA domain types
>   iommu: Express DMA strictness via the domain type
>   iommu: Expose DMA domain strictness via sysfs
>   iommu: Only log strictness for DMA domains
>   iommu: Merge strictness and domain type configs
>   iommu: Allow enabling non-strict mode dynamically

Applied all except patch 12. Please re-submit patch 12 together with the
APPLE DART fixups after v5.15-rc1 is out.

Thanks,

	Joerg
