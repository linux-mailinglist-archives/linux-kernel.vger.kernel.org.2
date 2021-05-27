Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAD8393531
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 19:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhE0R7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 13:59:03 -0400
Received: from 8bytes.org ([81.169.241.247]:41164 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233395AbhE0R7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 13:59:01 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id CE612247; Thu, 27 May 2021 19:57:26 +0200 (CEST)
Date:   Thu, 27 May 2021 19:57:25 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.13-rc3
Message-ID: <YK/dheM2NZz6KOkb@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r7JlHYcG2r1PRoWj"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r7JlHYcG2r1PRoWj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.13-rc3

for you to fetch changes up to 0ee74d5a48635c848c20f152d0d488bf84641304:

  iommu/vt-d: Fix sysfs leak in alloc_iommu() (2021-05-27 16:07:08 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.13-rc3

Including:

	- Important fix for the AMD IOMMU driver in the recently added
	  page-specific invalidation code to fix a calculation.

	- Fix a NULL-ptr dereference in the AMD IOMMU driver when a
	  device switches domain types.

	- Fixes for the Intel VT-d driver to check for allocation
	  failure and do correct cleanup.

	- Another fix for Intel VT-d to not allow supervisor page
	  requests from devices when using second level page
	  translation.

	- Add a MODULE_DEVICE_TABLE to the VIRTIO IOMMU driver

----------------------------------------------------------------
Bixuan Cui (1):
      iommu/virtio: Add missing MODULE_DEVICE_TABLE

Dan Carpenter (1):
      iommu/vt-d: Check for allocation failure in aux_detach_device()

Jean-Philippe Brucker (1):
      iommu/amd: Clear DMA ops when switching domain

Lu Baolu (1):
      iommu/vt-d: Use user privilege for RID2PASID translation

Nadav Amit (1):
      iommu/amd: Fix wrong parentheses on page-specific invalidations

Rolf Eike Beer (1):
      iommu/vt-d: Fix sysfs leak in alloc_iommu()

 drivers/iommu/amd/iommu.c    | 4 +++-
 drivers/iommu/intel/dmar.c   | 4 +++-
 drivers/iommu/intel/iommu.c  | 9 +++++++--
 drivers/iommu/intel/pasid.c  | 3 ++-
 drivers/iommu/virtio-iommu.c | 1 +
 5 files changed, 16 insertions(+), 5 deletions(-)

Please pull.

Thanks,

	Joerg

--r7JlHYcG2r1PRoWj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmCv3YIACgkQK/BELZcB
GuOAWw//WQuACOwVW8z+7/0rzSoYcfITOJ21HhiHYCHpr7G6+3w5gUJfia/vWeB1
QkfS7IFtcnkjGCoI5ZLQN2c6NIHfXrv7hjk73A95XKAhy/t208u749EYvj0vJsFm
LNevjwcpQuRFJZMFO+1oCVt+lCGTdneY+BXme2GV6D5tu/U8MNGlzrnoMk5+rcPr
5jq60d9ELFxpLRVHc3/pd7uSn+LqzF2hPjxxifFgoZyVW9zC1Qp2pEOXhosb+HXv
rBjDaXlo7k9osgRWLErGjkr3xSIfDaLFWfJmOAwCem7OvZn9NIdIsikiQdSgQMJ2
fkwQcY8lwe6ZWvW5mCqy7gqIQVkYU2D3hoUdWUxpatrXoDLQyLpPJYEzNq6a4yMv
QeMQ5gEWGiYKar0PQoG257TjMieT4FWsFUBZxWl3tSsg3Vf0pmDa3NJ7493u06D6
d8nUFqjqDs4eFcivXop/sbGYyD9kpoEkzxKiciEsKw/5UvZb+zZ8aASl8JvY3nYC
qeRNtcThiK5HJF78UrSfFxmke1v8pp+5wphBi5Z4yBimliwo4hGVleQLrR4wOfDr
6EXDE+GA1mtzn0SvzMqhRy4C+VRUkz6f6gNTQFxhjLEa3j5MXjhHczZvSQeXFddX
UmilTYT2f4QNVdX5oR4rSzMLa5j5fYQXCEeDUW1LtZAXDUxs6yg=
=hxvZ
-----END PGP SIGNATURE-----

--r7JlHYcG2r1PRoWj--
