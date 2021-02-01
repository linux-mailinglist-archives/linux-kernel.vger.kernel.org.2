Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E286230ABDB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhBAPrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:47:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:47168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231778AbhBAPrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:47:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 358D164DE1;
        Mon,  1 Feb 2021 15:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612194398;
        bh=r4ZiOV3cFWC4KnBUdzF+9ODAarCpp3Tth+L/wlsensE=;
        h=Date:From:To:Cc:Subject:From;
        b=pf0VK55jNVj9OhSDLsAG73B2mQPtZDuZxWNyDisEP2Cf3rtMNTW5ZbS9deZ/CyF3h
         DGsEW9zzor4ck8zGW1sOIM1xvW5j2uEF8feF5Zrpu+lyDZE2pufsuv74VAXhzSCm3V
         YZkQgj3UMTUCnoiwWoSLFe3cBiIRDc1RFNsTwmT32bY6OfO7decBUePGLNH1u3kSdo
         IRDdKS7l/JRJR/Z28Xy87dO/M4n5Xuo2+WrQ2jlRCWrTvTw0BmTZOFlFYgISQilVUG
         u6TLXtUCTtoKUXzD6iy9o+MEhEyKW6d/Xbr0XawTdtKjqDKunaRbVM03fHIdUAZERq
         WlLI9Sgy9C/lw==
Date:   Mon, 1 Feb 2021 15:46:33 +0000
From:   Will Deacon <will@kernel.org>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, jean-philippe@linaro.org,
        kernel-team@android.com, yong.wu@mediatek.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 5.12
Message-ID: <20210201154633.GC15263@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please pull these Arm SMMU updates for 5.12. The biggest thing here isn't
actually Arm SMMU-related at all, but is the addition of a new driver for
the MT8192 IOMMU. I've included it here because it ended up touching
quite a bit of the io-pgtable code.

Please note that I've based this branch on the "iommu-fixes" tag I sent for
-rc4 to avoid conflicts with upstream.

Cheers,

Will

--->8

The following changes since commit 694a1c0adebee9152a9ba0320468f7921aca647d:

  iommu/vt-d: Fix duplicate included linux/dma-map-ops.h (2021-01-12 16:56:20 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to 7060377ce06f9cd3ed6274c0f2310463feb5baec:

  Merge branch 'for-joerg/mtk' into for-joerg/arm-smmu/updates (2021-02-01 12:59:28 +0000)

----------------------------------------------------------------
Arm SMMU updates for 5.12

- Support for MT8192 IOMMU from Mediatek

- Arm v7s io-pgtable extensions for MT8192

- Removal of TLBI_ON_MAP quirk

- New Qualcomm compatible strings

- Allow SVA without hardware broadcast TLB maintenance on SMMUv3

- Virtualization Host Extension support for SMMUv3 (SVA)

- Allow SMMUv3 PMU (perf) driver to be built independently from IOMMU

- Misc cleanups

----------------------------------------------------------------
Bjorn Andersson (2):
      dt-bindings: arm-smmu-qcom: Add Qualcomm SC8180X compatible
      iommu/arm-smmu-qcom: Add Qualcomm SC8180X impl

Isaac J. Manjarres (1):
      iommu/arm-smmu-qcom: Fix mask extraction for bootloader programmed SMRs

Jean-Philippe Brucker (3):
      iommu/arm-smmu-v3: Split arm_smmu_tlb_inv_range()
      iommu/arm-smmu-v3: Make BTM optional for SVA
      iommu/arm-smmu-v3: Add support for VHE

John Garry (1):
      driver/perf: Remove ARM_SMMU_V3_PMU dependency on ARM_SMMU_V3

Robin Murphy (3):
      iommu/arm-smmu-v3: Remove the page 1 fixup
      iommu/msm: Hook up iotlb_sync_map
      iommu/io-pgtable: Remove TLBI_ON_MAP quirk

Vinod Koul (2):
      dt-bindings: arm-smmu: Add sm8350 compatible string
      iommu: arm-smmu-impl: Add SM8350 qcom iommu implementation

Will Deacon (1):
      Merge branch 'for-joerg/mtk' into for-joerg/arm-smmu/updates

Yong Wu (38):
      iommu: Move iotlb_sync_map out from __iommu_map
      iommu: Add iova and size as parameters in iotlb_sync_map
      iommu/mediatek: Add iotlb_sync_map to sync whole the iova range
      iommu: Switch gather->end to the inclusive end
      iommu/io-pgtable: Allow io_pgtable_tlb ops optional
      iommu/mediatek: Gather iova in iommu_unmap to achieve tlb sync once
      iommu/mediatek: Remove the tlb-ops for v7s
      dt-bindings: iommu: mediatek: Convert IOMMU to DT schema
      dt-bindings: memory: mediatek: Add a common memory header file
      dt-bindings: memory: mediatek: Extend LARB_NR_MAX to 32
      dt-bindings: memory: mediatek: Rename header guard for SMI header file
      dt-bindings: mediatek: Add binding for mt8192 IOMMU
      iommu/mediatek: Use the common mtk-memory-port.h
      iommu/io-pgtable-arm-v7s: Use ias to check the valid iova in unmap
      iommu/io-pgtable-arm-v7s: Extend PA34 for MediaTek
      iommu/io-pgtable-arm-v7s: Clarify LVL_SHIFT/BITS macro
      iommu/io-pgtable-arm-v7s: Add cfg as a param in some macros
      iommu/io-pgtable-arm-v7s: Quad lvl1 pgtable for MediaTek
      iommu/mediatek: Add a flag for iova 34bits case
      iommu/mediatek: Update oas for v7s
      iommu/mediatek: Move hw_init into attach_device
      iommu/mediatek: Add error handle for mtk_iommu_probe
      iommu/mediatek: Add device link for smi-common and m4u
      iommu/mediatek: Add pm runtime callback
      iommu/mediatek: Add power-domain operation
      iommu/mediatek: Support up to 34bit iova in tlb flush
      iommu/mediatek: Support report iova 34bit translation fault in ISR
      iommu/mediatek: Adjust the structure
      iommu/mediatek: Move domain_finalise into attach_device
      iommu/mediatek: Move geometry.aperture updating into domain_finalise
      iommu/mediatek: Add iova_region structure
      iommu/mediatek: Add get_domain_id from dev->dma_range_map
      iommu/mediatek: Support for multi domains
      iommu/mediatek: Add iova reserved function
      iommu/mediatek: Support master use iova over 32bit
      iommu/mediatek: Remove unnecessary check in attach_device
      iommu/mediatek: Add mt8192 support
      MAINTAINERS: Add entry for MediaTek IOMMU

Zhen Lei (1):
      iommu/arm-smmu-v3: Use DEFINE_RES_MEM() to simplify code

 .../devicetree/bindings/iommu/arm,smmu.yaml        |   2 +
 .../devicetree/bindings/iommu/mediatek,iommu.txt   | 105 ------
 .../devicetree/bindings/iommu/mediatek,iommu.yaml  | 183 +++++++++
 MAINTAINERS                                        |   9 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  10 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 154 ++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  14 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   5 +
 drivers/iommu/io-pgtable-arm-v7s.c                 |  65 ++--
 drivers/iommu/iommu.c                              |  23 +-
 drivers/iommu/msm_iommu.c                          |  10 +-
 drivers/iommu/mtk_iommu.c                          | 409 +++++++++++++++------
 drivers/iommu/mtk_iommu.h                          |  12 +-
 drivers/iommu/tegra-gart.c                         |   7 +-
 drivers/memory/mtk-smi.c                           |   8 +
 drivers/perf/Kconfig                               |   2 +-
 include/dt-bindings/memory/mt2701-larb-port.h      |   4 +-
 include/dt-bindings/memory/mt2712-larb-port.h      |   6 +-
 include/dt-bindings/memory/mt6779-larb-port.h      |   6 +-
 include/dt-bindings/memory/mt8167-larb-port.h      |   6 +-
 include/dt-bindings/memory/mt8173-larb-port.h      |   6 +-
 include/dt-bindings/memory/mt8183-larb-port.h      |   6 +-
 include/dt-bindings/memory/mt8192-larb-port.h      | 243 ++++++++++++
 include/dt-bindings/memory/mtk-memory-port.h       |  15 +
 include/linux/io-pgtable.h                         |  17 +-
 include/linux/iommu.h                              |   7 +-
 include/soc/mediatek/smi.h                         |   3 +-
 27 files changed, 981 insertions(+), 356 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
 create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
 create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h
 create mode 100644 include/dt-bindings/memory/mtk-memory-port.h
