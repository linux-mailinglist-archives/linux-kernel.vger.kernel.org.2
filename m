Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC2B3B9D45
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 10:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhGBIE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 04:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhGBIE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 04:04:57 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F14C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 01:02:25 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D0A193C2; Fri,  2 Jul 2021 10:02:22 +0200 (CEST)
Date:   Fri, 2 Jul 2021 10:02:21 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Updates for Linux v5.14
Message-ID: <YN7IDbKZFQnYFCNq@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1iOCIL6iAb0OOQYi"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1iOCIL6iAb0OOQYi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 13311e74253fe64329390df80bed3f07314ddd61:

  Linux 5.13-rc7 (2021-06-20 15:03:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.14

for you to fetch changes up to 2b9d8e3e9a9bb693a8b8bd26ad192db037517759:

  Merge branches 'iommu/fixes', 'arm/rockchip', 'arm/smmu', 'x86/vt-d', 'x86/amd', 'virtio' and 'core' into next (2021-06-25 15:23:25 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v5.14

Including:

 - SMMU Updates from Will Deacon:

     - SMMUv3: Support stalling faults for platform devices
     - SMMUv3: Decrease defaults sizes for the event and PRI queues
     - SMMUv2: Support for a new '->probe_finalize' hook, needed by Nvidia
     - SMMUv2: Even more Qualcomm compatible strings
     - SMMUv2: Avoid Adreno TTBR1 quirk for DB820C platform

 - Intel VT-d updates from Lu Baolu:

     - Convert Intel IOMMU to use sva_lib helpers in iommu core
     - ftrace and debugfs supports for page fault handling
     - Support asynchronous nested capabilities
     - Various misc cleanups

 - Support for new VIOT ACPI table to make the VirtIO IOMMU:
   available on x86

 - Add the amd_iommu=force_enable command line option to
   enable the IOMMU on platforms where they are known to cause
   problems

 - Support for version 2 of the Rockchip IOMMU

 - Various smaller fixes, cleanups and refactorings

----------------------------------------------------------------
Aditya Srivastava (1):
      iommu/vt-d: Fix kernel-doc syntax in file header

Alexander Monakov (1):
      iommu/amd: Fix extended features logging

Amey Narkhede (1):
      iommu/arm: Cleanup resources in case of probe error path

Benjamin Gaignard (4):
      dt-bindings: iommu: rockchip: Convert IOMMU to DT schema
      dt-bindings: iommu: rockchip: Add compatible for v2
      iommu: rockchip: Add internal ops to handle variants
      iommu: rockchip: Add support for iommu v2

Bixuan Cui (1):
      iommu/arm-smmu-v3: Change *array into *const array

Colin Ian King (2):
      iommu/vt-d: Remove redundant assignment to variable agaw
      iommu/vt-d: Fix dereference of pointer info before it is null checked

Eric Anholt (2):
      iommu/arm-smmu-qcom: Skip the TTBR1 quirk for db820c.
      arm64: dts: msm8996: Mark the GPU's SMMU as an adreno one.

Gustavo A. R. Silva (1):
      iommu/vt-d: Fix out-bounds-warning in intel/svm.c

Jean-Philippe Brucker (9):
      dt-bindings: Document stall property for IOMMU masters
      ACPI/IORT: Enable stall support for platform devices
      iommu/arm-smmu-v3: Add stall support for platform devices
      iommu/arm-smmu-v3: Ratelimit event dump
      ACPI: arm64: Move DMA setup operations out of IORT
      ACPI: Move IOMMU setup code out of IORT
      ACPI: Add driver for the VIOT table
      iommu/dma: Pass address limit rather than size to iommu_setup_dma_ops()
      iommu/virtio: Enable x86 support

Joerg Roedel (6):
      iommu/amd: Add amd_iommu=force_enable option
      iommu/dma: Fix compile warning in 32-bit builds
      iommu/amd: Fix section mismatch warning for detect_ivrs()
      iommu/vt-d: Fix linker error on 32-bit
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into arm/smmu
      Merge branches 'iommu/fixes', 'arm/rockchip', 'arm/smmu', 'x86/vt-d', 'x86/amd', 'virtio' and 'core' into next

Lu Baolu (14):
      iommu/vt-d: Tweak the description of a DMA fault
      iommu/vt-d: Select PCI_ATS explicitly
      iommu/vt-d: Support asynchronous IOMMU nested capabilities
      iommu/vt-d: Add pasid private data helpers
      iommu/vt-d: Use iommu_sva_alloc(free)_pasid() helpers
      iommu/vt-d: Use common helper to lookup svm devices
      iommu/vt-d: Refactor prq_event_thread()
      iommu/vt-d: Allocate/register iopf queue for sva devices
      iommu/vt-d: Report prq to io-pgfault framework
      iommu/vt-d: Add prq_report trace event
      iommu/vt-d: Add common code for dmar latency performance monitors
      iommu/vt-d: Expose latency monitor data through debugfs
      iommu/vt-d: Add cache invalidation latency sampling
      iommu/vt-d: Add PRQ handling latency sampling

Martin Botka (1):
      iommu/arm-smmu-qcom: Add sm6125 compatible

Parav Pandit (5):
      iommu/vt-d: Use bitfields for DMAR capabilities
      iommu/vt-d: Removed unused iommu_count in dmar domain
      iommu/vt-d: Remove unnecessary braces
      iommu/vt-d: Define counter explicitly as unsigned int
      iommu/vt-d: No need to typecast

Rob Herring (2):
      iommu: Remove unused of_get_dma_window()
      iommu: Drop unnecessary of_iommu.h includes

Robin Murphy (3):
      iommu/rockchip: Remove redundant DMA syncs
      iommu/amd: Tidy up DMA ops init
      iommu: Update "iommu.strict" documentation

Sai Prakash Ranjan (2):
      iommu/arm-smmu-qcom: Add SC7280 SMMU compatible
      iommu/arm-smmu-qcom: Move the adreno smmu specific impl

Shaokun Zhang (1):
      iommu/amd: Remove redundant assignment of err

Shawn Guo (2):
      iommu/arm-smmu-qcom: hook up qcom_smmu_impl for ACPI boot
      iommu/arm-smmu-qcom: Protect acpi_match_platform_list() call with CONFIG_ACPI

Srinath Mannam (1):
      iommu/dma: Fix IOVA reserve dma ranges

Thierry Reding (1):
      iommu/arm-smmu: Implement ->probe_finalize()

Will Deacon (2):
      iommu/arm-smmu: Check smmu->impl pointer before dereferencing
      Merge branch 'for-thierry/arm-smmu' into for-joerg/arm-smmu/updates

Xiang Chen (1):
      iommu/iova: Put free_iova_mem() outside of spinlock iova_rbtree_lock

Xiyu Yang (2):
      iommu/arm-smmu: Fix arm_smmu_device refcount leak when arm_smmu_rpm_get fails
      iommu/arm-smmu: Fix arm_smmu_device refcount leak in address translation

YueHaibing (1):
      iommu/vt-d: Use DEVICE_ATTR_RO macro

Zhen Lei (3):
      iommu/arm-smmu-v3: Decrease the queue size of evtq and priq
      iommu: Delete a duplicate check in iommu_change_dev_def_domain()
      iommu/arm-smmu-v3: Remove unnecessary oom message

 Documentation/admin-guide/kernel-parameters.txt    |   9 +-
 Documentation/devicetree/bindings/iommu/iommu.txt  |  18 +
 .../devicetree/bindings/iommu/rockchip,iommu.txt   |  38 --
 .../devicetree/bindings/iommu/rockchip,iommu.yaml  |  85 +++
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   2 +-
 arch/arm64/mm/dma-mapping.c                        |   2 +-
 drivers/acpi/Kconfig                               |   3 +
 drivers/acpi/Makefile                              |   2 +
 drivers/acpi/arm64/Makefile                        |   1 +
 drivers/acpi/arm64/dma.c                           |  50 ++
 drivers/acpi/arm64/iort.c                          | 132 +----
 drivers/acpi/bus.c                                 |   2 +
 drivers/acpi/scan.c                                |  78 ++-
 drivers/acpi/viot.c                                | 366 ++++++++++++
 drivers/iommu/Kconfig                              |   4 +-
 drivers/iommu/amd/amd_iommu.h                      |   2 -
 drivers/iommu/amd/init.c                           |  20 +-
 drivers/iommu/amd/iommu.c                          |  33 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  59 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 223 ++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  48 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  43 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |  39 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |   1 +
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |  14 +-
 drivers/iommu/dma-iommu.c                          |  19 +-
 drivers/iommu/exynos-iommu.c                       |   1 -
 drivers/iommu/intel/Kconfig                        |   6 +
 drivers/iommu/intel/Makefile                       |   1 +
 drivers/iommu/intel/debugfs.c                      | 111 ++++
 drivers/iommu/intel/dmar.c                         |  54 +-
 drivers/iommu/intel/iommu.c                        | 172 +++---
 drivers/iommu/intel/pasid.c                        |   2 +-
 drivers/iommu/intel/perf.c                         | 166 ++++++
 drivers/iommu/intel/perf.h                         |  73 +++
 drivers/iommu/intel/svm.c                          | 643 ++++++++++-----------
 drivers/iommu/iommu.c                              |   3 -
 drivers/iommu/iova.c                               |  18 +-
 drivers/iommu/ipmmu-vmsa.c                         |   1 -
 drivers/iommu/msm_iommu.c                          |   1 -
 drivers/iommu/mtk_iommu.c                          |   1 -
 drivers/iommu/mtk_iommu_v1.c                       |   1 -
 drivers/iommu/of_iommu.c                           |  68 ---
 drivers/iommu/omap-iommu.c                         |   1 -
 drivers/iommu/rockchip-iommu.c                     | 175 +++++-
 drivers/iommu/virtio-iommu.c                       |  12 +-
 drivers/of/platform.c                              |   1 -
 include/acpi/acpi_bus.h                            |   3 +
 include/linux/acpi.h                               |   3 +
 include/linux/acpi_iort.h                          |  14 +-
 include/linux/acpi_viot.h                          |  19 +
 include/linux/dma-iommu.h                          |   4 +-
 include/linux/intel-iommu.h                        |  44 +-
 include/linux/of_iommu.h                           |  17 +-
 include/trace/events/intel_iommu.h                 |  37 ++
 56 files changed, 2172 insertions(+), 781 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
 create mode 100644 Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
 create mode 100644 drivers/acpi/arm64/dma.c
 create mode 100644 drivers/acpi/viot.c
 create mode 100644 drivers/iommu/intel/perf.c
 create mode 100644 drivers/iommu/intel/perf.h
 create mode 100644 include/linux/acpi_viot.h

Please pull.

Thanks,

	Joerg

--1iOCIL6iAb0OOQYi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmDeyA0ACgkQK/BELZcB
GuPV1g/+P+PkMWuby/EoLSN59kPOuZWyIByp4Z/nn5vZ8SZ6abPseNm8/YS0gTSd
gn8/iDpz2sO/+OlMTR3l8cmZuRJAcsHJXiv6N70VnJGHlzXsI4KaEaWQUN9y17Eg
5G4GNbL7ODsjxiVVvYv3cAiIJLoq0wVJuD0NWLD8iNHcsW01j0LS00zFJ1Qr4Bmr
nmOfoRQi85EnLwBY0wBiLGYCQ1Yl+TCK4hL7dL40INSahYS22tepGiFIaW1DM7RB
iOvbPHlM4n4VrvLWXuzXbj3CCF9jHPopIVr0eBHLzYQ/ab5FhYAK+sg2DJFBJIik
Hf9OKM2OUyM5v6Ul9AA1LVabXp6Uex1c992pyNNA2d2W/EItsRMqCRtep5VTXJ7e
1VhBaUZJ50lusg5Y+i/ZiweX5IGH5m8l7WDA0R2Vl78RWqmrNAwqg9GZMLQnzWox
iTmTwISYuox/y+7dmpRKnRv6eHGJDA5Yp9qb350QKKDxqTJjELnVgkXkmBLEE73k
HGhLsN6GW8Ko5UtQNO+FDS7Ght3h7l4asyq5xOzxGFZ3aJ5gmKZkLsNMex5Ul95M
tVbI3roc1geSr4Hpq0PZ3WyDZaAAxXYyLCBgiHp0Y5OcwoLUI/GppX2ME7mhWp5+
zBgy0Kj+Zb8Ft5IB8fB//ZXRs9pzgqqip8/mj/k3fvp6ZCGBENQ=
=5sG1
-----END PGP SIGNATURE-----

--1iOCIL6iAb0OOQYi--
