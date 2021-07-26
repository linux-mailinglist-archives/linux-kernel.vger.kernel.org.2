Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3C03D59FC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 15:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhGZMVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhGZMVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:21:52 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A98C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 06:02:21 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B79822B0; Mon, 26 Jul 2021 15:02:18 +0200 (CEST)
Date:   Mon, 26 Jul 2021 15:02:14 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
Subject: Re: [PATCH 00/23] iommu: Refactor DMA domain strictness
Message-ID: <YP6yVtDcCRpp7UWa@8bytes.org>
References: <cover.1626888444.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1626888444.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, Jul 21, 2021 at 07:20:11PM +0100, Robin Murphy wrote:
> Robin Murphy (23):
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
>   iommu: Introduce explicit type for non-strict DMA domains
>   iommu/amd: Prepare for multiple DMA domain types
>   iommu/arm-smmu: Prepare for multiple DMA domain types
>   iommu/vt-d: Prepare for multiple DMA domain types
>   iommu: Express DMA strictness via the domain type
>   iommu: Expose DMA domain strictness via sysfs
>   iommu: Allow choosing DMA strictness at build time
>   iommu/dma: Factor out flush queue init
>   iommu: Allow enabling non-strict mode dynamically
>   iommu/arm-smmu: Allow non-strict in pgtable_quirks interface

I really like this patch-set. It is a nice cleanup and the
implementation is straightforward. Given no other major objections and
reviews I think this is material for 5.15.

Thanks,

	Joerg
