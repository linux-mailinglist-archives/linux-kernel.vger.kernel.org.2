Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEBE3C9A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240193AbhGOIOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:14:05 -0400
Received: from 8bytes.org ([81.169.241.247]:38570 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240498AbhGOIOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:14:03 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 97DB02C7; Thu, 15 Jul 2021 10:11:09 +0200 (CEST)
Date:   Thu, 15 Jul 2021 10:11:08 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.14-rc1
Message-ID: <YO/tnD+7RA32yO1F@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HSEOSdXA7rPfQ8+y"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HSEOSdXA7rPfQ8+y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.14-rc1

for you to fetch changes up to 4a5c155a5ab372516a1a5ddd29473f8f696feb79:

  MAINTAINERS: Add Suravee Suthikulpanit as Reviewer for AMD IOMMU (AMD-Vi) (2021-07-15 09:00:16 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.14-rc1

Including:

	- Revert a patch which caused boot failures with QCOM IOMMU

	- Two fixes for Intel VT-d context table handling

	- Physical address decoding fix for Rockchip IOMMU

	- Add a reviewer for AMD IOMMU

----------------------------------------------------------------
Benjamin Gaignard (1):
      iommu/rockchip: Fix physical address decoding

Lu Baolu (1):
      iommu/vt-d: Fix clearing real DMA device's scalable-mode context entries

Marek Szyprowski (1):
      iommu/qcom: Revert "iommu/arm: Cleanup resources in case of probe error path"

Sanjay Kumar (1):
      iommu/vt-d: Global devTLB flush when present context entry changed

Suravee Suthikulpanit (1):
      MAINTAINERS: Add Suravee Suthikulpanit as Reviewer for AMD IOMMU (AMD-Vi)

 MAINTAINERS                             |  1 +
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 13 ++-----------
 drivers/iommu/intel/iommu.c             | 34 ++++++++++++++++++++++-----------
 drivers/iommu/rockchip-iommu.c          |  6 ++++--
 4 files changed, 30 insertions(+), 24 deletions(-)

Please pull.

Thanks,

	Joerg

--HSEOSdXA7rPfQ8+y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmDv7ZwACgkQK/BELZcB
GuP1wg//RVNooucIetYWJ9+/NMIKL8T94ItDABC/S8xJsE1ageX8F45udjdyP5Ig
Jp/V6EQRO9+zvjv5puzWT9ZXjVgHrIU7V4sP4FzKHzv6QQfn2sXFZQVkWFNn/ybP
gbs1Ea2b014g/XS5XVmpx9Dti3h0IOWIg6yHl/oINgUa9St5+9w9fvg8w6LBwH8v
DMJfKbyurdMekHl1cwDm7wXN9cup2q5xraywyUt33ei4QK0vI/RixkLdzkezNVHC
UG9knFWQ83jGlU6ZhouY4528oNN8Yt2+dMB0P4UGg3oD6DHw/SEwHHw/V71dFisn
UxBi+N9V52XQyX7LTEPz8/uz2/VWICeaOn9TYYARZxUVMopADr3ST3OK54oVWSy0
7FuuepXw3ujbxcgnvBKUEmvIjBD+I+sXmSQy91vwgZCBCWgxa1Ki63bIB/CQDqri
Avj1H+6mBuCgjnl5Or2PdkmSwf+BnZ/jP1krBsTPtD1ZrWPdjbBaEr2kt/oBtzu7
HMwp9AcRQnXMYW1XuOE8CSUfAuE+8f9SvB60nFSN5h2Jx50y3ackrIkdFggubyHx
34uPKvd1nufgt4SiRGnaoIFABM4LEd6ksWuGK1SzaFfNm8EgcovU62xhK0MJo1gH
ryvoOBXmOVEzmSEQ3zJ3iHzrOXy8AZSIzZqvcceEGtQegOaBhQg=
=F2tX
-----END PGP SIGNATURE-----

--HSEOSdXA7rPfQ8+y--
