Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A6F3E9066
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbhHKMWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:22:17 -0400
Received: from foss.arm.com ([217.140.110.172]:48484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhHKMWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:22:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E84A2106F;
        Wed, 11 Aug 2021 05:21:48 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2BD7B3F718;
        Wed, 11 Aug 2021 05:21:46 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
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
Subject: [PATCH v4 00/24] iommu: Refactor DMA domain strictness
Date:   Wed, 11 Aug 2021 13:21:14 +0100
Message-Id: <cover.1628682048.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1: https://lore.kernel.org/linux-iommu/cover.1626888444.git.robin.murphy@arm.com/
v2: https://lore.kernel.org/linux-iommu/cover.1627468308.git.robin.murphy@arm.com/
v3: https://lore.kernel.org/linux-iommu/cover.1628094600.git.robin.murphy@arm.com/

Hi all,

I'm hoping this is good to go now. Changes from v3 are minimal, just
rolling back patch #2 to the non-broken version, and tidying up the
final patch as documented there.

Cheers,
Robin.


CC: Marek Szyprowski <m.szyprowski@samsung.com>
CC: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
CC: Geert Uytterhoeven <geert+renesas@glider.be>
CC: Yong Wu <yong.wu@mediatek.com>
CC: Heiko Stuebner <heiko@sntech.de>
CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
CC: Maxime Ripard <mripard@kernel.org>
CC: Jean-Philippe Brucker <jean-philippe@linaro.org>


Robin Murphy (24):
  iommu: Pull IOVA cookie management into the core
  iommu/amd: Drop IOVA cookie management
  iommu/arm-smmu: Drop IOVA cookie management
  iommu/vt-d: Drop IOVA cookie management
  iommu/exynos: Drop IOVA cookie management
  iommu/ipmmu-vmsa: Drop IOVA cookie management
  iommu/mtk: Drop IOVA cookie management
  iommu/rockchip: Drop IOVA cookie management
  iommu/sprd: Drop IOVA cookie management
  iommu/sun50i: Drop IOVA cookie management
  iommu/virtio: Drop IOVA cookie management
  iommu/dma: Unexport IOVA cookie management
  iommu/dma: Remove redundant "!dev" checks
  iommu: Indicate queued flushes via gather data
  iommu/io-pgtable: Remove non-strict quirk
  iommu: Introduce explicit type for non-strict DMA domains
  iommu/amd: Prepare for multiple DMA domain types
  iommu/arm-smmu: Prepare for multiple DMA domain types
  iommu/vt-d: Prepare for multiple DMA domain types
  iommu: Express DMA strictness via the domain type
  iommu: Expose DMA domain strictness via sysfs
  iommu: Only log strictness for DMA domains
  iommu: Merge strictness and domain type configs
  iommu: Allow enabling non-strict mode dynamically

 .../ABI/testing/sysfs-kernel-iommu_groups     |  6 +-
 .../admin-guide/kernel-parameters.txt         |  8 +-
 drivers/iommu/Kconfig                         | 80 +++++++++----------
 drivers/iommu/amd/iommu.c                     | 21 +----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 11 +--
 drivers/iommu/arm/arm-smmu/arm-smmu.c         | 19 ++---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       |  9 ---
 drivers/iommu/dma-iommu.c                     | 58 ++++++++------
 drivers/iommu/exynos-iommu.c                  | 19 +----
 drivers/iommu/intel/iommu.c                   | 23 ++----
 drivers/iommu/io-pgtable-arm-v7s.c            | 12 +--
 drivers/iommu/io-pgtable-arm.c                | 12 +--
 drivers/iommu/iommu.c                         | 56 ++++++++-----
 drivers/iommu/iova.c                          | 14 +++-
 drivers/iommu/ipmmu-vmsa.c                    | 28 +------
 drivers/iommu/mtk_iommu.c                     |  7 --
 drivers/iommu/mtk_iommu_v1.c                  |  1 -
 drivers/iommu/rockchip-iommu.c                | 12 +--
 drivers/iommu/sprd-iommu.c                    |  7 --
 drivers/iommu/sun50i-iommu.c                  | 13 +--
 drivers/iommu/virtio-iommu.c                  |  8 --
 include/linux/dma-iommu.h                     |  6 ++
 include/linux/io-pgtable.h                    |  5 --
 include/linux/iommu.h                         | 23 +++++-
 24 files changed, 184 insertions(+), 274 deletions(-)

-- 
2.25.1

