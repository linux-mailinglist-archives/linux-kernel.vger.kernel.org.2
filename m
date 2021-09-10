Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD12406E85
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 17:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbhIJPtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 11:49:40 -0400
Received: from 8bytes.org ([81.169.241.247]:54264 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232438AbhIJPtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 11:49:35 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 752D560F; Fri, 10 Sep 2021 17:48:22 +0200 (CEST)
Date:   Fri, 10 Sep 2021 17:48:20 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.15-rc0
Message-ID: <YTt+RAMfjZdchT8W@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TdAk1chTf7oioDPJ"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TdAk1chTf7oioDPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit d8768d7eb9c21ef928adb93402d9348bcc4a6915:

  Merge branches 'apple/dart', 'arm/smmu', 'iommu/fixes', 'x86/amd', 'x86/vt-d' and 'core' into next (2021-08-20 17:14:35 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.15-rc0

for you to fetch changes up to 8cc633190b524c678b740c87fa1fc37447151a6b:

  iommu: Clarify default domain Kconfig (2021-09-09 13:18:07 +0200)

----------------------------------------------------------------
IOMMU Fixes for v5.15-rc1

Including:

	- Intel VT-d:
	  - PASID leakage in intel_svm_unbind_mm();
	  - Deadlock in intel_svm_drain_prq().

	- AMD IOMMU: Fixes for an unhandled page-fault bug when AVIC is used
	  for a KVM guest.

	- Make CONFIG_IOMMU_DEFAULT_DMA_LAZY architecture instead of IOMMU
	  driver dependent

----------------------------------------------------------------
Fenghua Yu (2):
      iommu/vt-d: Fix PASID leak in intel_svm_unbind_mm()
      iommu/vt-d: Fix a deadlock in intel_svm_drain_prq()

Robin Murphy (1):
      iommu: Clarify default domain Kconfig

Suravee Suthikulpanit (1):
      iommu/amd: Remove iommu_init_ga()

Wei Huang (1):
      iommu/amd: Relocate GAMSup check to early_enable_iommus

 drivers/iommu/Kconfig     |  2 +-
 drivers/iommu/amd/init.c  | 48 +++++++++++++++++++++++++++--------------------
 drivers/iommu/intel/svm.c | 15 ++++++++++++---
 3 files changed, 41 insertions(+), 24 deletions(-)

Please pull.

Thanks,

	Joerg

--TdAk1chTf7oioDPJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmE7fkQACgkQK/BELZcB
GuNuvw/9HyW+VBCwaO7b6xV3fk6H6/BeAjAseKZdqy7YnszL6jIgVe96bb6u0bHT
xKRF4fuDwRncSNUMAUItEW3jBXeTnThVrGsttr2YILKPZ5vXC7hDKNIpV09NU4cP
+kJ+m9GVx7xCDVjDIDAspQyHO+Hb8Dnv5hEH1jh67vOxMyQ8poE77c2wqxAPKz54
Y3g92f9X/lAOq7KNXI5gL4p3u9wtsfEhPVakNUj1goxSy3gR78cDKxPSg0qBLtNa
ciG7N6FG9nQDG5Q/y3h9yEcFzY1+HllEG2cHoJdUnc79qUcMFPOBggPaDh8VGlwp
FD2OvKXnUhXqbknFhfsVlmHsn7XBjAc2E/Pj+/u/Pcxuofdr7VD3CL4b6Pbf06lL
KLbgC44+HfJT4blGcHM2rxogxv3GclOkyFIC8OD9/iPIqt+46Zy9zsHh2vW3gk43
gTpbsjMHtjslU4S+i1YmLLfUqQkPVCq6p622jCLTucw4hpJO19I5CsL+7BJZzVyU
E7caA+qKU9b10feJ22fUUDjkKl41YBxAG6xB81czdVYrBy/Dfd1e7vFi09nOZtUW
YXnQRE20Jy0P55ywQU2Xj8CoJjoKSQBTeotIKaI80/dvKhRqZ1vT7tA3YlPgcBEE
TdVOVpRhOxazGHprXZjS4Iv744aiJtWWk7XwTqIb0mgipNB68vI=
=s/pY
-----END PGP SIGNATURE-----

--TdAk1chTf7oioDPJ--
