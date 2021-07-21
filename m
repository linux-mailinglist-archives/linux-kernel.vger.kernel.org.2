Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D953D162F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhGURkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:40:11 -0400
Received: from foss.arm.com ([217.140.110.172]:33096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230339AbhGURkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:40:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FE71D6E;
        Wed, 21 Jul 2021 11:20:45 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CBB8F3F694;
        Wed, 21 Jul 2021 11:20:43 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
Subject: [PATCH 00/23] iommu: Refactor DMA domain strictness
Date:   Wed, 21 Jul 2021 19:20:11 +0100
Message-Id: <cover.1626888444.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

First off, yes, this conflicts with just about everything else
currently in-flight. Sorry about that. If it stands up to initial review
then I'll start giving some thought to how to fit everything together
(particularly John's cleanup of strictness defaults, which I'd be
inclined to fold into a v2 of this series).

Anyway, this is my take on promoting the strict vs. non-strict DMA
domain choice to distinct domain types, so that it can fit logically
into the existing sysfs and Kconfig controls. The first 13 patches are
effectively preparatory cleanup to reduce churn in the later changes,
but could be merged in their own right even if the rest is too
contentious. I ended up splitting patches #2-#11 by driver for ease of
review, since some of them are more than just trivial deletions, but
they could readily be squashed (even as far as with #1 and #12 too).

I'm slightly surprised at how straightforward it's turned out, but it
has survived some very basic smoke testing for arm-smmu using dmatest
on my Arm Juno board. Branch here for convenience:

https://gitlab.arm.com/linux-arm/linux-rm/-/tree/iommu/fq

Please let me know what you think!

Robin.


Robin Murphy (23):
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
  iommu: Introduce explicit type for non-strict DMA domains
  iommu/amd: Prepare for multiple DMA domain types
  iommu/arm-smmu: Prepare for multiple DMA domain types
  iommu/vt-d: Prepare for multiple DMA domain types
  iommu: Express DMA strictness via the domain type
  iommu: Expose DMA domain strictness via sysfs
  iommu: Allow choosing DMA strictness at build time
  iommu/dma: Factor out flush queue init
  iommu: Allow enabling non-strict mode dynamically
  iommu/arm-smmu: Allow non-strict in pgtable_quirks interface

 .../ABI/testing/sysfs-kernel-iommu_groups     |  2 +
 drivers/iommu/Kconfig                         | 48 +++++++++++++++----
 drivers/iommu/amd/iommu.c                     | 21 +-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 25 ++++++----
 drivers/iommu/arm/arm-smmu/arm-smmu.c         | 24 ++++++----
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       |  8 ----
 drivers/iommu/dma-iommu.c                     | 44 +++++++++--------
 drivers/iommu/exynos-iommu.c                  | 18 ++-----
 drivers/iommu/intel/iommu.c                   | 23 +++------
 drivers/iommu/iommu.c                         | 44 +++++++++++------
 drivers/iommu/ipmmu-vmsa.c                    | 27 ++---------
 drivers/iommu/mtk_iommu.c                     |  6 ---
 drivers/iommu/rockchip-iommu.c                | 11 +----
 drivers/iommu/sprd-iommu.c                    |  6 ---
 drivers/iommu/sun50i-iommu.c                  | 12 +----
 drivers/iommu/virtio-iommu.c                  |  8 ----
 include/linux/dma-iommu.h                     |  9 ++--
 include/linux/iommu.h                         | 10 +++-
 18 files changed, 160 insertions(+), 186 deletions(-)

-- 
2.25.1

