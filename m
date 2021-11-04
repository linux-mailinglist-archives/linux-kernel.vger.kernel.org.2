Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A34445534
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhKDOXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhKDOWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:22:43 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C806C0432F7
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 07:16:28 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9FE8C4E1; Thu,  4 Nov 2021 15:16:25 +0100 (CET)
Date:   Thu, 4 Nov 2021 15:16:22 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Updates for Linux v5.16
Message-ID: <YYPrNkweZahTdAbA@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Zk4rAeSYz7p/8iE9"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Zk4rAeSYz7p/8iE9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

there is a merge conflict this time between the IOMMU tree and FPU
changes which came from the tip tree. My conflict resolution is
attached. With that in mind:

The following changes since commit 8bb7eca972ad531c9b149c0a51ab43a417385813:

  Linux 5.15 (2021-10-31 13:53:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-u=
pdates-v5.16

for you to fetch changes up to 52d96919d6a846aace5841cd23055927c6e6ec2c:

  Merge branches 'apple/dart', 'arm/mediatek', 'arm/renesas', 'arm/smmu', '=
arm/tegra', 'iommu/fixes', 'x86/amd', 'x86/vt-d' and 'core' into next (2021=
-10-31 22:26:53 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v5.16:

Including:

  - Intel IOMMU Updates fro Lu Baolu:
    - Dump DMAR translation structure when DMA fault occurs
    - An optimization in the page table manipulation code
    - Use second level for GPA->HPA translation
    - Various cleanups

  - Arm SMMU Updates from Will
    - Minor optimisations to SMMUv3 command creation and submission
    - Numerous new compatible string for Qualcomm SMMUv2 implementations

  - Fixes for the SWIOTLB based implemenation of dma-iommu code for
    untrusted devices

  - Add support for r8a779a0 to the Renesas IOMMU driver and DT matching
    code for r8a77980

  - A couple of cleanups and fixes for the Apple DART IOMMU driver

  - Make use of generic report_iommu_fault() interface in the AMD IOMMU
    driver

  - Various smaller fixes and cleanups

----------------------------------------------------------------
Arnd Bergmann (1):
      iommu/mediatek: Fix out-of-range warning with clang

Christophe JAILLET (1):
      iommu/tegra-smmu: Use devm_bitmap_zalloc when applicable

David Stevens (7):
      iommu/dma: Fix sync_sg with swiotlb
      iommu/dma: Fix arch_sync_dma for map
      iommu/dma: Skip extra sync during unmap w/swiotlb
      iommu/dma: Fold _swiotlb helpers into callers
      iommu/dma: Check CONFIG_SWIOTLB more broadly
      swiotlb: Support aligned swiotlb buffers
      iommu/dma: Account for min_align_mask w/swiotlb

Fenghua Yu (1):
      iommu/vt-d: Clean up unused PASID updating functions

Gustavo A. R. Silva (1):
      iommu/dma: Use kvcalloc() instead of kvzalloc()

Joerg Roedel (2):
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/will/linux into arm/smmu
      Merge branches 'apple/dart', 'arm/mediatek', 'arm/renesas', 'arm/smmu=
', 'arm/tegra', 'iommu/fixes', 'x86/amd', 'x86/vt-d' and 'core' into next

Konrad Dybcio (2):
      dt-bindings: arm-smmu: Add compatible for SM6350 SoC
      iommu/arm-smmu-qcom: Add SM6350 SMMU compatible

Kyung Min Park (1):
      iommu/vt-d: Dump DMAR translation structure when DMA fault occurs

Lennert Buytenhek (1):
      iommu/amd: Use report_iommu_fault()

Logan Gunthorpe (1):
      iommu/dma: Fix incorrect error return on iommu deferred attach

Loic Poulain (2):
      dt-bindings: arm-smmu: Add compatible for QCM2290 SoC
      iommu: arm-smmu-qcom: Add compatible for QCM2290

Longpeng(Mike) (2):
      iommu/vt-d: Convert the return type of first_pte_in_page to bool
      iommu/vt-d: Avoid duplicate removing in __domain_mapping()

Lu Baolu (4):
      iommu/vt-d: Remove duplicate identity domain flag
      iommu/vt-d: Check FL and SL capability sanity in scalable mode
      iommu/vt-d: Use second level for GPA->HPA translation
      iommu/vt-d: Delete dev_has_feat callback

Nikita Yushchenko (1):
      iommu/ipmmu-vmsa: Hook up r8a77980 DT matching code

Robin Murphy (2):
      iommu/dart: Clean up IOVA cookie crumbs
      iommu/dma: Unexport IOVA cookie management

Sibi Sankar (1):
      iommu/arm-smmu-qcom: Request direct mapping for modem device

Sven Peter (1):
      iommu/dart: Initialize DART_STREAMS_ENABLE

Tvrtko Ursulin (1):
      iommu/vt-d: Do not falsely log intel_iommu is unsupported kernel opti=
on

Wan Jiabing (1):
      iommu/dart: Use kmemdup instead of kzalloc and memcpy

Yoshihiro Shimoda (2):
      dt-bindings: iommu: renesas,ipmmu-vmsa: add r8a779a0 support
      iommu/ipmmu-vmsa: Add support for r8a779a0

Zhen Lei (2):
      iommu/arm-smmu-v3: Stop pre-zeroing batch commands in arm_smmu_atc_in=
v_master()
      iommu/arm-smmu-v3: Properly handle the return value of arm_smmu_cmdq_=
build_cmd()

 .../devicetree/bindings/iommu/arm,smmu.yaml        |   2 +
 .../bindings/iommu/renesas,ipmmu-vmsa.yaml         |   1 +
 arch/x86/include/asm/fpu/api.h                     |   2 -
 drivers/iommu/amd/amd_iommu_types.h                |   2 +
 drivers/iommu/amd/iommu.c                          |  21 ++
 drivers/iommu/apple-dart.c                         |  10 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  21 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   3 +
 drivers/iommu/dma-iommu.c                          | 200 +++++++++--------=
--
 drivers/iommu/intel/Kconfig                        |   4 +
 drivers/iommu/intel/cap_audit.c                    |  13 ++
 drivers/iommu/intel/cap_audit.h                    |   1 +
 drivers/iommu/intel/dmar.c                         |  10 +-
 drivers/iommu/intel/iommu.c                        | 213 ++++++++++++++---=
----
 drivers/iommu/intel/svm.c                          |  24 +--
 drivers/iommu/iommu.c                              |   3 +-
 drivers/iommu/ipmmu-vmsa.c                         |  32 +++-
 drivers/iommu/mtk_iommu.c                          |   4 +-
 drivers/iommu/tegra-smmu.c                         |   5 +-
 drivers/xen/swiotlb-xen.c                          |   2 +-
 include/linux/dmar.h                               |   8 +
 include/linux/intel-iommu.h                        |  13 +-
 include/linux/swiotlb.h                            |   3 +-
 kernel/dma/swiotlb.c                               |  13 +-
 24 files changed, 367 insertions(+), 243 deletions(-)

Please pull.

Thanks,

	Joerg

diff --cc arch/x86/include/asm/fpu/api.h
index b7267b9e452f,ca4d0dee1ecd..6053674f9132
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@@ -108,58 -106,4 +108,56 @@@ extern int cpu_has_xfeatures(u64 xfeatu
   */
  #define PASID_DISABLED	0
 =20
- static inline void update_pasid(void) { }
-=20
 +/* Trap handling */
 +extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
 +extern void fpu_sync_fpstate(struct fpu *fpu);
 +extern void fpu_reset_from_exception_fixup(void);
 +
 +/* Boot, hotplug and resume */
 +extern void fpu__init_cpu(void);
 +extern void fpu__init_system(struct cpuinfo_x86 *c);
 +extern void fpu__init_check_bugs(void);
 +extern void fpu__resume_cpu(void);
 +
 +#ifdef CONFIG_MATH_EMULATION
 +extern void fpstate_init_soft(struct swregs_state *soft);
 +#else
 +static inline void fpstate_init_soft(struct swregs_state *soft) {}
 +#endif
 +
 +/* State tracking */
 +DECLARE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
 +
 +/* Process cleanup */
 +#ifdef CONFIG_X86_64
 +extern void fpstate_free(struct fpu *fpu);
 +#else
 +static inline void fpstate_free(struct fpu *fpu) { }
 +#endif
 +
 +/* fpstate-related functions which are exported to KVM */
 +extern void fpstate_clear_xstate_component(struct fpstate *fps, unsigned =
int xfeature);
 +
 +/* KVM specific functions */
 +extern bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu);
 +extern void fpu_free_guest_fpstate(struct fpu_guest *gfpu);
 +extern int fpu_swap_kvm_fpstate(struct fpu_guest *gfpu, bool enter_guest);
 +
 +extern void fpu_copy_guest_fpstate_to_uabi(struct fpu_guest *gfpu, void *=
buf, unsigned int size, u32 pkru);
 +extern int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const v=
oid *buf, u64 xcr0, u32 *vpkru);
 +
 +static inline void fpstate_set_confidential(struct fpu_guest *gfpu)
 +{
 +	gfpu->fpstate->is_confidential =3D true;
 +}
 +
 +static inline bool fpstate_is_confidential(struct fpu_guest *gfpu)
 +{
 +	return gfpu->fpstate->is_confidential;
 +}
 +
 +/* prctl */
 +struct task_struct;
 +extern long fpu_xstate_prctl(struct task_struct *tsk, int option, unsigne=
d long arg2);
 +
  #endif /* _ASM_X86_FPU_API_H */

--Zk4rAeSYz7p/8iE9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmGD6zEACgkQK/BELZcB
GuOvuQ//UDKSDIVsht5iDvnt9H+0s/ZcyrZySnC/dNyq32ZPadL8+v9suLLSfEsb
I3pU1MSSzJGdVzvlqyVeeqg3YBc3CLFCeX8hVRhFNlRgf5D3qrxPa6AgSctj4dSy
6ww2tKKu5+Y4HrAdkgC2HA2x20c0sPE/3iqwhAyWHGJ6/ET2ri2tgtUAUpdwqfJT
EPTq+Xe/mm8lLQBxfg+3mRIQRowiIs/yUTMa7VM0He2s86/TISkmp1Gqwb1daTVK
smAlUxZeHhdf9ObQ0OHH9L+BTlGYFeqDYDf7FCWTtyMnDWDc61Zs95O7AZkFVRZS
fdl9Qiu4GPXFK4YKQkT+asOKhbJeu8R06A2Gd0+WiRwGRhLHePx9aUhaZ1a/gzJB
r+tvgPieh8Maf+MO9IvweWiuF/ynHP5MnUQBwB8fiSsY8wj7zbC9K9kYiffVVLqI
gC2CDZp8d1GwkptLUWz1+ZmzVmZ80on0wEj4Ied8poaORTcA99/r28k0E+OqBOAC
umnTPLR0l3Act5amhr1b6r1O2A6cjIq0PqF+vm+EFCwb7qZSHXToR7bc79h5ijf1
bBdZG8RD3jlejuRfaEskw8UAQzj3arywUDuWFGxSR9N/a6MHOWRFuA2LuAnjvB6g
RS9QLQzbLJt52d9y84GVi/DSdCpRDH+CKTVEZwR/EX667htcjBI=
=ByX3
-----END PGP SIGNATURE-----

--Zk4rAeSYz7p/8iE9--
