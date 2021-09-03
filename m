Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7D04000EE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239846AbhICOEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:04:24 -0400
Received: from 8bytes.org ([81.169.241.247]:48692 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhICOEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:04:14 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 19A34179; Fri,  3 Sep 2021 16:03:13 +0200 (CEST)
Date:   Fri, 3 Sep 2021 16:03:11 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Updates for Linux v5.15
Message-ID: <YTIrHxWNzIwuseXO@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5NXEJNe6MdZMyfv2"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5NXEJNe6MdZMyfv2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The tree is a bit more messy this time, mostly because there are many
IOMMU core changes included and driver patches which depend on them
living in different branches. So some cross-merging between branches was
necessary. With that said:

The following changes since commit 7c60610d476766e128cc4284bb6349732cbd6606:

  Linux 5.14-rc6 (2021-08-15 13:40:53 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.15

for you to fetch changes up to d8768d7eb9c21ef928adb93402d9348bcc4a6915:

  Merge branches 'apple/dart', 'arm/smmu', 'iommu/fixes', 'x86/amd', 'x86/vt-d' and 'core' into next (2021-08-20 17:14:35 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v5.15

Including:

	- New DART IOMMU driver for Apple Silicon M1 chips.

	- Optimizations for iommu_[map/unmap] performance

	- Selective TLB flush support for the AMD IOMMU driver to make
	  it more efficient on emulated IOMMUs.

	- Rework IOVA setup and default domain type setting to move more
	  code out of IOMMU drivers and to support runtime switching
	  between certain types of default domains.

	- VT-d Updates from Lu Baolu:
	  - Update the virtual command related registers
	  - Enable Intel IOMMU scalable mode by default
	  - Preset A/D bits for user space DMA usage
	  - Allow devices to have more than 32 outstanding PRs
	  - Various cleanups

	- ARM SMMU Updates from Will Deacon:
	  - SMMUv3: Minor optimisation to avoid zeroing struct members on CMD submission
	  - SMMUv3: Increased use of batched commands to reduce submission latency
	  - SMMUv3: Refactoring in preparation for ECMDQ support
	  - SMMUv2: Fix races when probing devices with identical StreamIDs
	  - SMMUv2: Optimise walk cache flushing for Qualcomm implementations
	  - SMMUv2: Allow deep sleep states for some Qualcomm SoCs with shared clocks

	- Various smaller optimizations, cleanups, and fixes

----------------------------------------------------------------
Andy Shevchenko (1):
      iommu/vt-d: Drop the kernel doc annotation

Ashish Mhetre (1):
      iommu: Fix race condition during default domain allocation

Ezequiel Garcia (1):
      iommu/dma: Fix leak in non-contiguous API

Fenghua Yu (1):
      iommu/vt-d: Fix PASID reference leak

Frank Wunderlich (1):
      iommu: Check if group is NULL before remove device

Geert Uytterhoeven (1):
      iommu/dart: APPLE_DART should depend on ARCH_APPLE

Isaac J. Manjarres (12):
      iommu/io-pgtable: Introduce unmap_pages() as a page table op
      iommu: Add an unmap_pages() op for IOMMU drivers
      iommu/io-pgtable: Introduce map_pages() as a page table op
      iommu: Add a map_pages() op for IOMMU drivers
      iommu: Add support for the map_pages() callback
      iommu/io-pgtable-arm: Prepare PTE methods for handling multiple entries
      iommu/io-pgtable-arm: Implement arm_lpae_unmap_pages()
      iommu/io-pgtable-arm: Implement arm_lpae_map_pages()
      iommu/io-pgtable-arm-v7s: Implement arm_v7s_unmap_pages()
      iommu/io-pgtable-arm-v7s: Implement arm_v7s_map_pages()
      iommu/arm-smmu: Implement the unmap_pages() IOMMU driver callback
      iommu/arm-smmu: Implement the map_pages() IOMMU driver callback

Joerg Roedel (4):
      Merge remote-tracking branch 'korg/core' into x86/amd
      iommu/amd: Remove stale amd_iommu_unmap_flush usage
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into arm/smmu
      Merge branches 'apple/dart', 'arm/smmu', 'iommu/fixes', 'x86/amd', 'x86/vt-d' and 'core' into next

John Garry (5):
      iommu: Deprecate Intel and AMD cmdline methods to enable strict mode
      iommu: Print strict or lazy mode at init time
      iommu: Remove mode argument from iommu_set_dma_strict()
      iommu/arm-smmu-v3: Remove some unneeded init in arm_smmu_cmdq_issue_cmdlist()
      iommu/arm-smmu-v3: Stop pre-zeroing batch commands

Krishna Reddy (1):
      iommu/arm-smmu: Fix race condition during iommu_group creation

Lennert Buytenhek (1):
      iommu/amd: Fix printing of IOMMU events when rate limiting kicks in

Liu Yi L (3):
      iommu/vt-d: Fix incomplete cache flush in intel_pasid_tear_down_entry()
      iommu/vt-d: Use pasid_pte_is_present() helper function
      iommu/vt-d: Add present bit check in pasid entry setup helpers

Lu Baolu (8):
      iommu/vt-d: Report real pgsize bitmap to iommu core
      iommu/vt-d: Implement map/unmap_pages() iommu_ops callback
      iommu/vt-d: Move clflush'es from iotlb_sync_map() to map_pages()
      iommu/vt-d: Update the virtual command related registers
      iommu/vt-d: Refactor Kconfig a bit
      iommu/vt-d: Enable Intel IOMMU scalable mode by default
      iommu/vt-d: Preset A/D bits for user space DMA usage
      iommu/vt-d: Allow devices to have more than 32 outstanding PRs

Nadav Amit (6):
      iommu/amd: Selective flush on unmap
      iommu/amd: Do not use flush-queue when NpCache is on
      iommu: Factor iommu_iotlb_gather_is_disjoint() out
      iommu/amd: Tailored gather logic for AMD
      iommu/amd: Sync once for scatter-gather operations
      iommu/amd: Use only natural aligned flushes in a VM

Robin Murphy (26):
      iommu: Streamline iommu_iova_to_phys()
      iommu: Improve iommu_iotlb_gather helpers
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
      iommu/io-pgtable: Abstract iommu_iotlb_gather access

Sai Prakash Ranjan (2):
      iommu/arm-smmu: Add clk_bulk_{prepare/unprepare} to system pm callbacks
      iommu/arm-smmu: Optimize ->tlb_flush_walk() for qcom implementation

Sven Peter (3):
      iommu/io-pgtable: Add DART pagetable format
      dt-bindings: iommu: add DART iommu bindings
      iommu/dart: Add DART iommu driver

Will Deacon (3):
      iommu: Use bitmap to calculate page size in iommu_pgsize()
      iommu: Split 'addr_merge' argument to iommu_pgsize() into separate parts
      iommu: Hook up '->unmap_pages' driver callback

Xiang Chen (2):
      iommu/arm-smmu-v3: Implement the unmap_pages() IOMMU driver callback
      iommu/arm-smmu-v3: Implement the map_pages() IOMMU driver callback

Xiyu Yang via iommu (1):
      iommu/amd: Convert from atomic_t to refcount_t on pasid_state->count

Yang Yingliang (1):
      iommu/arm-smmu: Fix missing unlock on error in arm_smmu_device_group()

Zhen Lei (8):
      iommu: Enhance IOMMU default DMA mode build options
      iommu/vt-d: Add support for IOMMU default DMA mode build options
      iommu/amd: Add support for IOMMU default DMA mode build options
      iommu/arm-smmu-v3: Use command queue batching helpers to improve performance
      iommu/arm-smmu-v3: Add and use static helper function arm_smmu_cmdq_issue_cmd_with_sync()
      iommu/arm-smmu-v3: Add and use static helper function arm_smmu_get_cmdq()
      iommu/arm-smmu-v3: Extract reusable function __arm_smmu_cmdq_skip_err()
      iommu/vt-d: Remove unnecessary oom message

 .../ABI/testing/sysfs-kernel-iommu_groups          |   6 +-
 Documentation/admin-guide/kernel-parameters.txt    |  29 +-
 .../devicetree/bindings/iommu/apple,dart.yaml      |  81 ++
 MAINTAINERS                                        |   7 +
 drivers/iommu/Kconfig                              |  69 +-
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/amd/amd_iommu_types.h                |   6 -
 drivers/iommu/amd/init.c                           |  12 +-
 drivers/iommu/amd/io_pgtable.c                     |   3 -
 drivers/iommu/amd/iommu.c                          | 151 +++-
 drivers/iommu/amd/iommu_v2.c                       |  13 +-
 drivers/iommu/apple-dart.c                         | 923 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 121 +--
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  11 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |  89 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |   1 +
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |   9 -
 drivers/iommu/dma-iommu.c                          |  52 +-
 drivers/iommu/exynos-iommu.c                       |  19 +-
 drivers/iommu/intel/Kconfig                        |  19 +-
 drivers/iommu/intel/dmar.c                         |   2 -
 drivers/iommu/intel/iommu.c                        | 197 ++---
 drivers/iommu/intel/pasid.c                        |  28 +-
 drivers/iommu/intel/pasid.h                        |  16 +-
 drivers/iommu/intel/perf.c                         |   2 +-
 drivers/iommu/intel/svm.c                          |   7 +-
 drivers/iommu/io-pgtable-arm-v7s.c                 |  62 +-
 drivers/iommu/io-pgtable-arm.c                     | 282 +++++--
 drivers/iommu/io-pgtable.c                         |   1 +
 drivers/iommu/iommu.c                              | 198 +++--
 drivers/iommu/iova.c                               |  14 +-
 drivers/iommu/ipmmu-vmsa.c                         |  28 +-
 drivers/iommu/mtk_iommu.c                          |  13 +-
 drivers/iommu/mtk_iommu_v1.c                       |   1 -
 drivers/iommu/rockchip-iommu.c                     |  12 +-
 drivers/iommu/sprd-iommu.c                         |   7 -
 drivers/iommu/sun50i-iommu.c                       |  13 +-
 drivers/iommu/virtio-iommu.c                       |   8 -
 include/linux/dma-iommu.h                          |   6 +
 include/linux/intel-iommu.h                        |   6 +-
 include/linux/intel-svm.h                          |   5 +
 include/linux/io-pgtable.h                         |  20 +-
 include/linux/iommu.h                              | 114 ++-
 43 files changed, 2054 insertions(+), 610 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/apple,dart.yaml
 create mode 100644 drivers/iommu/apple-dart.c

Please pull.

Thanks,

	Joerg

--5NXEJNe6MdZMyfv2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmEyKx8ACgkQK/BELZcB
GuNM8hAAnehvBuqSRyRC0293xNCjc86O2tarS7TjXW6epdeausCTl+f22VmGI7CJ
ljpwj5Tlaml/blPt/fH9JPA0p2mR61OPAXYG9x/OSufh4c7xXuU/YSbyY83UgJ2W
cVDtWyzrLkCFW2oXFivI1tFxGPjHhPCfrpSmMSQbRtzrmFBJpgQCqH1OlKV9xqvZ
y/XkMz2bd9nOVeFoDjMgHFhfHFZuR3fKvYP+x8z0denzH0PkA+6cxhSdHmt0oKHb
1eQRBtwrRPGuScrRi1ZTDOD98AyePLLNMIMWHS0jdCpO1977yZxuZdmGEoQtQFFj
tK9bFGwGkjb1fGmRMxgDsw9oZij7CnmNHoxjeGwVRIU6zdlpK/7vUhNBdfZVRFWf
CRgh3ukA2+Fqzk6L/Y2Fvt0YTH+ALIvX1thR93FeGiDxoWNm8se5bjAlGfSg9nnB
EzWzdzq/OcEvxmwruSGENrc/jkfEGXcuyTmgoW0XA3wFSxs2GGKK1JRhlcJgycGZ
AUWWULOvR/lv1W5Kg9DvYOnaAD+6HhlxT/Q3DXZOfeetjhRjqeuvoj2eraULE6jl
1BG9kSU4u1pYE/K+3gY79fXygcqaZU05SZL/GIsVe5lWaixqbmRALlGFA25S8ZiW
9Cev22CsLABSvRhJuqKWzqZuSe2jeKIDNz4ePGmd/Qhh/Xue07U=
=g+0b
-----END PGP SIGNATURE-----

--5NXEJNe6MdZMyfv2--
