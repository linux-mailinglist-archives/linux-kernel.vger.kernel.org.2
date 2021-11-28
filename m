Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B87F46068D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 14:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbhK1Nid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 08:38:33 -0500
Received: from 8bytes.org ([81.169.241.247]:34016 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346127AbhK1NgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 08:36:18 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C7DA1396; Sun, 28 Nov 2021 14:33:00 +0100 (CET)
Date:   Sun, 28 Nov 2021 14:32:59 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.16-rc2
Message-ID: <YaOFCyGBRITPRyaa@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7xziTSZJMkKpZ1PO"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7xziTSZJMkKpZ1PO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 136057256686de39cc3a07c2e39ef6bc43003ff6:

  Linux 5.16-rc2 (2021-11-21 13:47:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.16-rc2

for you to fetch changes up to 86dc40c7ea9c22f64571e0e45f695de73a0e2644:

  iommu/vt-d: Fix unmap_pages support (2021-11-26 22:54:47 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.16-rc2:

Including:

  - Intel VT-d fixes:
    - Remove unused PASID_DISABLED
    - Fix RCU locking
    - Fix for the unmap_pages call-back

  - Rockchip RK3568 address mask fix

  - AMD IOMMUv2 log message clarification

----------------------------------------------------------------
Alex Bee (1):
      iommu/rockchip: Fix PAGE_DESC_HI_MASKs for RK3568

Alex Williamson (1):
      iommu/vt-d: Fix unmap_pages support

Christophe JAILLET (1):
      iommu/vt-d: Fix an unbalanced rcu_read_lock/rcu_read_unlock()

Joerg Roedel (2):
      iommu/vt-d: Remove unused PASID_DISABLED
      iommu/amd: Clarify AMD IOMMUv2 initialization messages

 arch/x86/include/asm/fpu/api.h  | 6 ------
 drivers/iommu/amd/iommu_v2.c    | 6 +++---
 drivers/iommu/intel/cap_audit.c | 5 +++--
 drivers/iommu/intel/iommu.c     | 6 ++----
 drivers/iommu/rockchip-iommu.c  | 4 ++--
 5 files changed, 10 insertions(+), 17 deletions(-)

Please pull.

Thanks,

	Joerg

--7xziTSZJMkKpZ1PO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmGjhQsACgkQK/BELZcB
GuPmVRAAub7Gwv82zRlFldNWwQOh6CHMmOBB34W8wNCO3BueB3erZTU2wBpSWCIu
BN0Bz5g1uGPqbDbW58i2UVDowBqY6MSN0RwLDtPAsVT5to2FiJcIu34pBfLDXpgs
j8rio4MSEWEyvT2i/8bEMXlyB4lHuw6Lateh3LV+eNDYA4va8625kBp7agAd1N2z
0SKPtMHlwzDfTbGKYUlASkFbPXHc6WKWDhL8enxfoBHY4ZTWcCj5OLqZzKfyRIMK
jgHPALme/nVJvbGWDFx4EXjQLQT0Q6FnOGxHi2W1iaKvcyHatrN/2KdflepTLP1C
THosEoua360YqVsWPtht2zga7sAHD1fAFIm1EIUgb9OpPq1BrxOGNbOXcOv5PkcD
h68vQqefysu68Af/OC8mX19xKXKH7MtJsF0xC+4jYG7dT16/fZUbekV19RD+Rq8W
8aVksSdwi+NinJ9iKfqcmPe7BFvmOyF3SLDbsAp9IEWJPt68JyiQ5KpE86P4tYA8
XKpOoGI16kT85oZyExGFcJm8B1wfYOLo7go7PyxGkeX93Tu8R9PI+k5XIoZcyBhv
RN2y6QhfnxfeMe8k9fiZPD84sS76w00x58OyMbjEDA/Zymsl2zDdAAP/hQ/guAxd
xCXIt9zH39efF3BNfB1KiQP5bHEFU2ebzsjfkPHs8ka4V4a1mAs=
=WhCV
-----END PGP SIGNATURE-----

--7xziTSZJMkKpZ1PO--
