Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0585836FC00
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhD3OSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbhD3OSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:18:10 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51817C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:17:22 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id CF41990B; Fri, 30 Apr 2021 16:17:19 +0200 (CEST)
Date:   Fri, 30 Apr 2021 16:17:18 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Updates for Linux v5.13
Message-ID: <YIwRbkQcElemYSjz@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MZwZ1CIB3DPVYbmT"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MZwZ1CIB3DPVYbmT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit d434405aaab7d0ebc516b68a8fc4100922d7f5ef:

  Linux 5.12-rc7 (2021-04-11 15:16:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.13

for you to fetch changes up to 2d471b20c55e13c98d1dba413bf2de618e89cdac:

  iommu: Streamline registration interface (2021-04-16 17:20:45 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v5.13

Including:

	- Big cleanup of almost unsused parts of the IOMMU API by
	  Christoph Hellwig. This mostly affects the Freescale PAMU
	  driver.

	- New IOMMU driver for Unisoc SOCs

	- ARM SMMU Updates from Will:

	  - SMMUv3: Drop vestigial PREFETCH_ADDR support
	  - SMMUv3: Elide TLB sync logic for empty gather
	  - SMMUv3: Fix "Service Failure Mode" handling
    	  - SMMUv2: New Qualcomm compatible string

	- Removal of the AMD IOMMU performance counter writeable check
	  on AMD. It caused long boot delays on some machines and is
	  only needed to work around an errata on some older (possibly
	  pre-production) chips. If someone is still hit by this
	  hardware issue anyway the performance counters will just
	  return 0.

	- Support for targeted invalidations in the AMD IOMMU driver.
	  Before that the driver only invalidated a single 4k page or the
	  whole IO/TLB for an address space. This has been extended now
	  and is mostly useful for emulated AMD IOMMUs.

	- Several fixes for the Shared Virtual Memory support in the
	  Intel VT-d driver

	- Mediatek drivers can now be built as modules

	- Re-introduction of the forcedac boot option which got lost
	  when converting the Intel VT-d driver to the common dma-iommu
	  implementation.

	- Extension of the IOMMU device registration interface and
	  support iommu_ops to be const again when drivers are built as
	  modules.

----------------------------------------------------------------
Christoph Hellwig (23):
      iommu: remove the unused domain_window_disable method
      iommu/fsl_pamu: remove fsl_pamu_get_domain_attr
      iommu/fsl_pamu: remove support for setting DOMAIN_ATTR_GEOMETRY
      iommu/fsl_pamu: merge iommu_alloc_dma_domain into fsl_pamu_domain_alloc
      iommu/fsl_pamu: remove support for multiple windows
      iommu/fsl_pamu: remove ->domain_window_enable
      iommu/fsl_pamu: replace DOMAIN_ATTR_FSL_PAMU_STASH with a direct call
      iommu/fsl_pamu: merge pamu_set_liodn and map_liodn
      iommu/fsl_pamu: merge handle_attach_device into fsl_pamu_attach_device
      iommu/fsl_pamu: enable the liodn when attaching a device
      iommu/fsl_pamu: remove the snoop_id field
      iommu/fsl_pamu: remove the rpn and snoop_id arguments to pamu_config_ppaac
      iommu/fsl_pamu: hardcode the window address and size in pamu_config_ppaace
      iommu: remove DOMAIN_ATTR_PAGING
      iommu: remove DOMAIN_ATTR_GEOMETRY
      iommu: remove DOMAIN_ATTR_NESTING
      iommu: remove iommu_set_cmd_line_dma_api and iommu_cmd_line_dma_api
      iommu: remove DOMAIN_ATTR_IO_PGTABLE_CFG
      iommu: remove iommu_domain_{get,set}_attr
      iommu/amd: Remove the unused device errata code
      iommu/amd: Remove the unused amd_iommu_get_v2_domain function
      iommu/amd: Remove a few unused exports
      iommu/amd: Move a few prototypes to include/linux/amd-iommu.h

Christophe JAILLET (1):
      iommu/vt-d: Fix an error handling path in 'intel_prepare_irq_remapping()'

Chunyan Zhang (3):
      dt-bindings: iommu: add bindings for sprd IOMMU
      iommu: add Unisoc IOMMU basic driver
      iommu/sprd: Fix parameter type warning

Colin Ian King (1):
      iommu/unisoc: Fix spelling mistake "sixe" -> "size"

Dafna Hirschfeld (1):
      iommu/mediatek: Always enable the clk on resume

Jacob Pan (4):
      iommu/vt-d: Enable write protect for supervisor SVM
      iommu/vt-d: Enable write protect propagation from guest
      iommu/vt-d: Reject unsupported page request modes
      iommu/vt-d: Calculate and set flags for handle_mm_fault

Jean-Philippe Brucker (7):
      iommu: Fix comment for struct iommu_fwspec
      iommu/arm-smmu-v3: Use device properties for pasid-num-bits
      iommu: Separate IOMMU_DEV_FEAT_IOPF from IOMMU_DEV_FEAT_SVA
      iommu/vt-d: Support IOMMU_DEV_FEAT_IOPF
      uacce: Enable IOMMU_DEV_FEAT_IOPF
      iommu: Add a page fault handler
      iommu/arm-smmu-v3: Maintain a SID->device structure

Joerg Roedel (3):
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into arm/smmu
      iommu/fsl-pamu: Fix uninitialized variable warning
      Merge branches 'iommu/fixes', 'arm/mediatek', 'arm/smmu', 'arm/exynos', 'unisoc', 'x86/vt-d', 'x86/amd' and 'core' into next

John Garry (4):
      iova: Add CPU hotplug handler to flush rcaches
      iommu/vt-d: Remove IOVA domain rcache flushing for CPU offlining
      iommu: Delete iommu_dma_free_cpu_cached_iovas()
      iommu: Stop exporting free_iova_fast()

Krzysztof Kozlowski (1):
      iommu/exynos: Remove unneeded local variable initialization

Kyung Min Park (1):
      iommu/vt-d: Disable SVM when ATS/PRI/PASID are not enabled in the device

Longpeng(Mike) (1):
      iommu/vt-d: Force to flush iotlb before creating superpage

Lu Baolu (14):
      iommu/vt-d: Report more information about invalidation errors
      iommu/vt-d: Fix lockdep splat in intel_pasid_get_entry()
      iommu/vt-d: Don't set then clear private data in prq_event_thread()
      iommu/vt-d: Remove unused dma map/unmap trace events
      iommu/vt-d: Remove svm_dev_ops
      iommu/vt-d: Remove SVM_FLAG_PRIVATE_PASID
      iommu/vt-d: Remove unused function declarations
      iommu/vt-d: Make unnecessarily global functions static
      iommu/vt-d: Report right snoop capability when using FL for IOVA
      iommu/vt-d: Report the right page fault address
      iommu/vt-d: Remove WO permissions on second-level paging entries
      iommu/vt-d: Invalidate PASID cache when root/context entry changed
      iommu/vt-d: Avoid unnecessary cache flush in pasid entry teardown
      iommu/vt-d: Fix build error of pasid_enable_wpe() with !X86

Nadav Amit (1):
      iommu/amd: Page-specific invalidations for more than one page

Paul Menzel (2):
      Revert "iommu/amd: Fix performance counter initialization"
      iommu/amd: Put newline after closing bracket in warning

Qi Liu (1):
      iommu/amd: Remove duplicate check of pasids

Robin Murphy (6):
      iommu/dma: Resurrect the "forcedac" option
      iommu/iova: Add rbtree entry helper
      iommu/iova: Improve restart logic
      iommu: remove DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE
      iommu: Statically set module owner
      iommu: Streamline registration interface

Sai Prakash Ranjan (1):
      dt-bindings: arm-smmu: Add compatible for SC7280 SoC

Shameer Kolothum (1):
      iommu: Check dev->iommu in iommu_dev_xxx functions

Shaokun Zhang (1):
      iommu/amd: Remove duplicate check of devid

Suravee Suthikulpanit (1):
      iommu/amd: Remove performance counter pre-initialization test

Xiang Chen (2):
      iommu/arm-smmu-v3: Add a check to avoid invalid iotlb sync
      iommu: Fix a boundary issue to avoid performance drop

Yong Wu (4):
      iommu/mediatek-v1: Allow building as module
      iommu/mediatek: Allow building as module
      iommu/mediatek-v1: Avoid build fail when build as module
      iommu/mediatek-v1: Add error handle for mtk_iommu_probe

Zenghui Yu (1):
      iommu/arm-smmu-v3: Remove the unused fields for PREFETCH_CONFIG command

Zhen Lei (1):
      iommu/arm-smmu-v3: add bit field SFM into GERROR_ERR_MASK

 Documentation/admin-guide/kernel-parameters.txt    |  15 +-
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   1 +
 .../devicetree/bindings/iommu/sprd,iommu.yaml      |  57 ++
 arch/powerpc/include/asm/fsl_pamu_stash.h          |  12 +-
 arch/x86/events/amd/iommu.c                        |   1 +
 arch/x86/events/amd/iommu.h                        |  19 -
 drivers/acpi/arm64/iort.c                          |  13 +-
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c             |   4 -
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |   5 +-
 drivers/iommu/Kconfig                              |  16 +-
 drivers/iommu/Makefile                             |   3 +-
 drivers/iommu/amd/amd_iommu.h                      |   2 -
 drivers/iommu/amd/amd_iommu_types.h                |   1 -
 drivers/iommu/amd/init.c                           |  59 +-
 drivers/iommu/amd/iommu.c                          | 201 ++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 247 +++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  18 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c              | 117 +---
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |   2 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |   5 +-
 drivers/iommu/dma-iommu.c                          |  23 +-
 drivers/iommu/exynos-iommu.c                       |   7 +-
 drivers/iommu/fsl_pamu.c                           | 293 +--------
 drivers/iommu/fsl_pamu.h                           |  12 +-
 drivers/iommu/fsl_pamu_domain.c                    | 693 ++-------------------
 drivers/iommu/fsl_pamu_domain.h                    |  46 --
 drivers/iommu/intel/dmar.c                         |  72 ++-
 drivers/iommu/intel/iommu.c                        | 233 +++----
 drivers/iommu/intel/irq_remapping.c                |   2 +-
 drivers/iommu/intel/pasid.c                        |  75 ++-
 drivers/iommu/intel/pasid.h                        |   6 +-
 drivers/iommu/intel/svm.c                          |  82 ++-
 drivers/iommu/io-pgfault.c                         | 461 ++++++++++++++
 drivers/iommu/iommu-sva-lib.h                      |  53 ++
 drivers/iommu/iommu.c                              | 161 +++--
 drivers/iommu/iova.c                               |  96 ++-
 drivers/iommu/ipmmu-vmsa.c                         |   6 +-
 drivers/iommu/msm_iommu.c                          |   5 +-
 drivers/iommu/mtk_iommu.c                          |  41 +-
 drivers/iommu/mtk_iommu_v1.c                       |  98 +--
 drivers/iommu/of_iommu.c                           |   5 -
 drivers/iommu/omap-iommu.c                         |   5 +-
 drivers/iommu/rockchip-iommu.c                     |   5 +-
 drivers/iommu/s390-iommu.c                         |   4 +-
 drivers/iommu/sprd-iommu.c                         | 575 +++++++++++++++++
 drivers/iommu/sun50i-iommu.c                       |   5 +-
 drivers/iommu/tegra-gart.c                         |   5 +-
 drivers/iommu/tegra-smmu.c                         |   5 +-
 drivers/iommu/virtio-iommu.c                       |   6 +-
 drivers/misc/uacce/uacce.c                         |  39 +-
 drivers/soc/fsl/qbman/qman_portal.c                |  55 +-
 drivers/vfio/vfio_iommu_type1.c                    |  31 +-
 drivers/vhost/vdpa.c                               |  10 +-
 include/linux/amd-iommu.h                          |  30 +-
 include/linux/cpuhotplug.h                         |   2 +-
 include/linux/dma-iommu.h                          |   7 +-
 include/linux/intel-iommu.h                        |  10 +-
 include/linux/intel-svm.h                          |  23 +-
 include/linux/io-pgtable.h                         |   4 -
 include/linux/iommu.h                              | 141 ++---
 include/linux/iova.h                               |   6 +-
 include/trace/events/intel_iommu.h                 | 120 ----
 include/uapi/linux/iommu.h                         |   3 +-
 63 files changed, 2117 insertions(+), 2242 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
 create mode 100644 drivers/iommu/io-pgfault.c
 create mode 100644 drivers/iommu/sprd-iommu.c

Please pull.

Thanks,

	Joerg

--MZwZ1CIB3DPVYbmT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmCMEW4ACgkQK/BELZcB
GuNDJBAAiphQKo4kPCNNlk79pEd73Py6QbRR2AvfkISzcf93OBq012MoZVQGCMQt
o8mhNHePqi5CJe1lym1NMeKqXvUI8ck2Xr3XEqArS/Exkn4y6mi+dkx2+mm1Ifrj
VSfzAyIp7tPtcWwFOaw42rbXAfBouyIrTn2GmvweUkNb7+aKYTWV/suwuHwoSva3
e2XVQOGFMSsbVd49BBrCytYSOFaivCablviwH7CfqRwI8o36HNqS6L9doU0fXerQ
cETuTdQXnDBzN3URf4O+hehqiaTy8v06RTzV98vG6Ksv2ZSDNJAD6aMTijLDjKC/
HTIpW/PMTkgV+cp34Pb/nNXiMMpQBT25AtTskaDZuzKybUTY4p5QEKSAXpf/2UjW
azTAMkRclhT6AnPJNprUJgbSqyuUEG9tElnVfD3wg2r5PRFW3BCu3i14SIL+RjPo
GKFk+lfwekQq//58aybTJCCJyqmLA8jxAXPyX8F3Mmwi55bA88jhCCQ8ftYQxgJz
NbKnTJlSO/0fUjBDT/3bMEocnHSKm51LozIdI3uW1wT4RQ8c1inzfY+x++3XXB4U
d7z2KjHWaCE1NeLe4G/e2uxAW9qAWIh0s01TAtG6rJnwsxHLDtIckY6PVCb0kX9Z
LBHfGUncwsMSIGZHEWBTEDfI6/aPUgKJuPcGlSiCfPXwDV5xKKQ=
=LtQk
-----END PGP SIGNATURE-----

--MZwZ1CIB3DPVYbmT--
