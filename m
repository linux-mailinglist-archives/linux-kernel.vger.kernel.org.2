Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0F93F27F9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 09:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbhHTHyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 03:54:51 -0400
Received: from 8bytes.org ([81.169.241.247]:37906 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236378AbhHTHyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 03:54:50 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B0847309; Fri, 20 Aug 2021 09:54:11 +0200 (CEST)
Date:   Fri, 20 Aug 2021 09:54:10 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.14-rc6
Message-ID: <YR9fopoKjkg2o2V1@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fxzoJDnuzNfsWAyh"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fxzoJDnuzNfsWAyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit ff1176468d368232b684f75e82563369208bc371:

  Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.14-rc6

for you to fetch changes up to 8798d36411196da86e70b994725349c16c1119f6:

  iommu/vt-d: Fix incomplete cache flush in intel_pasid_tear_down_entry() (2021-08-18 13:15:58 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.14-rc6

Including:

	- Fix for a potential NULL-ptr dereference in IOMMU core code

	- Two resource leak fixes

	- Cache flush fix in the Intel VT-d driver

----------------------------------------------------------------
Ezequiel Garcia (1):
      iommu/dma: Fix leak in non-contiguous API

Fenghua Yu (1):
      iommu/vt-d: Fix PASID reference leak

Frank Wunderlich (1):
      iommu: Check if group is NULL before remove device

Liu Yi L (1):
      iommu/vt-d: Fix incomplete cache flush in intel_pasid_tear_down_entry()

 drivers/iommu/dma-iommu.c   |  1 +
 drivers/iommu/intel/pasid.c | 10 ++++++++--
 drivers/iommu/intel/pasid.h |  6 ++++++
 drivers/iommu/intel/svm.c   |  3 ++-
 drivers/iommu/iommu.c       |  3 +++
 5 files changed, 20 insertions(+), 3 deletions(-)

Please pull.

Thanks,

	Joerg

--fxzoJDnuzNfsWAyh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmEfX6IACgkQK/BELZcB
GuPnSBAA5BchTG8clKnQrKlrlekTM8zBVifRvcS01ERNMHXt3arJZ5l+1iSRMuUN
cpeTAWIMr3ckdWSIkb/f2eKp63QCY60asf+l05cc/yyyl/lbkgT/Nu/eXSUkZXxf
qU6XUn/7PNL9coKm5dwaBRC+fjX8vjtmh8F6aiT8dYGJB8cfyq51NDLoq11jdnEq
cD0aS4R+Uevg8HaNW0BMeeB9E+I/FQtsONYSAHiJGJz1b3abv6PGSBrP83l5EpUG
1TjmPF6eUAK9m/w9M9cY2qwlVZP64FHvtfzE2xJSRqHIDxVR+oAzdM+A8DznRJGt
zisrjq8w2tDp5tXLn1g5T1eWsHmMxqmk++m8aMeR3LVumzIAZQK7n1xktola/QqA
yoh7Y7sBuzrSybAwLkMgj+gxeWl3tvG1aEyaRCsDIaLJaIaFGyk3C1C1ib3+kRU/
NwTmBJccFU0et4aIcP/uraOCOul38wBnrUqNHIBZTt2IULP+sCfKohwLtYOFhQPM
uvYlEcSK1X43CQW3x+fWF4tpil/PjUwzPevoZjfTv6krVemfdXEjDL/vD/EKcAW8
9+3K24adP8u1YRDKjNooe2RXmm+2f1ikHAjiG+BvsPhtSKaUR5z4H0ryjlrHR7pa
+oWmCqvTd8Um7PPLD4HWN4cxcOx4MJGoBxJ9J4ggBWNgsuQJ2MA=
=1Nmb
-----END PGP SIGNATURE-----

--fxzoJDnuzNfsWAyh--
