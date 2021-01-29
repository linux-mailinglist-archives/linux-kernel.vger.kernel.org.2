Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D86308A82
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 17:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhA2Qnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 11:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhA2QnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 11:43:04 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6CBC0617AB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 08:41:33 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 01A68303; Fri, 29 Jan 2021 17:41:30 +0100 (CET)
Date:   Fri, 29 Jan 2021 17:41:29 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>
Subject: [git pull] IOMMU Fixes for Linux v5.11-rc5
Message-ID: <20210129164123.GA25513@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.11-rc5

for you to fetch changes up to 29b32839725f8c89a41cb6ee054c85f3116ea8b5:

  iommu/vt-d: Do not use flush-queue when caching-mode is on (2021-01-28 13:59:02 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.11-rc5

Including:

	- AMD IOMMU Fix to make sure features are detected before they
	  are queried.

	- Intel IOMMU address alignment check fix for an IOLTB flushing
	  command.

	- Performance fix for Intel IOMMU to make sure the code does not
	  do full IOTLB flushes all the time. Those flushes are very
	  expensive on emulated IOMMUs.

----------------------------------------------------------------
Lu Baolu (1):
      iommu/vt-d: Correctly check addr alignment in qi_flush_dev_iotlb_pasid()

Nadav Amit (1):
      iommu/vt-d: Do not use flush-queue when caching-mode is on

Suravee Suthikulpanit (1):
      iommu/amd: Use IVHD EFR for early initialization of IOMMU features

 drivers/iommu/amd/amd_iommu.h       |  7 ++---
 drivers/iommu/amd/amd_iommu_types.h |  4 +++
 drivers/iommu/amd/init.c            | 56 +++++++++++++++++++++++++++++++++++--
 drivers/iommu/intel/dmar.c          |  2 +-
 drivers/iommu/intel/iommu.c         | 32 ++++++++++++++++++++-
 5 files changed, 92 insertions(+), 9 deletions(-)

Please pull.

Thanks,

	Joerg

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmAUOrMACgkQK/BELZcB
GuNMbRAA1qlBq3RXbPp8Iftn1CXMnLLkpb576ndYAmxMTyh4WxRxrt8zTOJ17Lrc
xee83/utsWZ0K3AtSkXVe/cCdq+mH57M/A5bJUK0QdrPZC27xTNtBpKpI6NgbM/q
NJzdTpa9GFYkpKIEO5MvVTmC0DDin+yDLEge43osARz+1eteEfOTfaAkhVga4ml/
3tbmQouk4GdOw5b8aHMAXPJHJbNTWTcZ4B7mWVIKwAAhT1XM1TbjX2DjNr7QRrz1
Cibh0a3S9hkvr5W5dTU116f/MRAa9Cz28Zdk57hzD2ry+UVV6lNcLCQNndiafdnb
tKx7lqdXIfnXC+td622EXhqC82Rd5z1oM01Ipcrt89KourdWtGcfADmy927tOol4
VkuSTc6mVSmMT/vig6dy9r/BbcpX9CNkcKxBTt/PYT23mrDWKoMC9QdcQ5xNaR8G
Sd4ai96vWFz4IJsKkImRz8ASh2u2LflK9gtmjcg/xyUMiU34jbvnnN7yNAVi4eES
bBzwi8h/TXcel975KhR7xGDURPfOYuhGNy4pBtNUA+JB1MDQGVlDUrbQcdvIKQ3o
43PNwb4QYZRKfRCJhttsDNL+txYVuUjPSi6ydsJs1L9Wmhfy5ipMuJU/GD1HxtWA
mJFwF1GU67vauEvV7ZLZres8wkSvhfMR9qe6yo5egc67NyfCjnQ=
=PJqE
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
