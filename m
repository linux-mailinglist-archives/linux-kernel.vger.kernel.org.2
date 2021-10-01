Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4ED41F1B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355167AbhJAQD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:03:28 -0400
Received: from 8bytes.org ([81.169.241.247]:43018 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355158AbhJAQD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:03:26 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B142C25C; Fri,  1 Oct 2021 18:01:41 +0200 (CEST)
Date:   Fri, 1 Oct 2021 18:01:38 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.15-rc3
Message-ID: <YVcw4sXKg6alXhmx@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BAeRcwq0YWaKgDX+"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BAeRcwq0YWaKgDX+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.15-rc3

for you to fetch changes up to f0b636804c7c4c564efbca5981e3c56b5c6fe0c5:

  iommu/dart: Clear sid2group entry when a group is freed (2021-09-28 11:47:24 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.15-rc3

Including:

	- Two fixes for the new Apple DART driver to fix a kernel panic
	  and a stale data usage issue

	- Intel VT-d fix for how PCI device ids are printed

----------------------------------------------------------------
Bjorn Helgaas (1):
      iommu/vt-d: Drop "0x" prefix from PCI bus & device addresses

Sven Peter (2):
      iommu/dart: Remove iommu_flush_ops
      iommu/dart: Clear sid2group entry when a group is freed

 drivers/iommu/apple-dart.c | 56 +++++++++++++++++++++++++++++-----------------
 drivers/iommu/intel/dmar.c |  6 ++---
 2 files changed, 38 insertions(+), 24 deletions(-)

Please pull.

Thanks,

	Joerg

--BAeRcwq0YWaKgDX+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmFXMOIACgkQK/BELZcB
GuNnEQ//UWvxSNWNVy7EYhUIMEMXXb8Qf+CUgNaCfQzzwLKAZv/hsQdfGJjF5NFC
0aLw3Of0RFq04R16Vss9gFuPcpse7/GAtFxg74IZaWTCN3nAUrMXcew3nT2PVuPU
MS21f4O854aKgq3uXn4C6wO7LgwpbZrVBrijJ+xK/URWgFuvpT8w5yhPoRiP0S5M
XnVkJ91403W5plUvpcA84RbxGVUo75ozmAlvmPRQRf0LcacWtYyfuwSCDQepTZHr
FUglbNip6BUDdga1gR4UegDaQISyfy6wPmAKXYOa2R9cDXqJcOcj0BY6ZucDTUAg
T/TsZZD87T4mM4pbc/83Z8XP9/+gxmOqPgcdCqU0DtQA8bQJVENLQ88LfsulhKDA
GbX7vN2xu2slssZelHzEn2L1FZ5bdjpXrodtJRQbCF6I7ZSp1VrsmlG36INpLFs5
3uIphwy8him8ah9FhF+LpgAzK8qIkwWywbB+gmdjOOo+fxSTqMbsejpF8OfGwDrO
3954YCic++oq5zt+RZix+55fcmwBfchnxumzeyYApMuoWhAxLBNXncyew9YoHlXy
izcFNjJ9LiNm6H++EI9mjHdsd/M7S6iMC9SaRuIKsnizmq7cPRrTqn9eobUpJiX3
IWRoGf+sU2oZczZdulSuV2qsqSqJ+jfmDlXEaLHeFCUPu44Kfp0=
=69i1
-----END PGP SIGNATURE-----

--BAeRcwq0YWaKgDX+--
