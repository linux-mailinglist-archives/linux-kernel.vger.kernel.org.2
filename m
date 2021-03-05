Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A04F32EFF8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 17:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhCEQXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 11:23:33 -0500
Received: from 8bytes.org ([81.169.241.247]:57838 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229832AbhCEQX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 11:23:27 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id CEDC947C; Fri,  5 Mar 2021 17:23:25 +0100 (CET)
Date:   Fri, 5 Mar 2021 17:23:24 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux iommu-updates-v5.12
Message-ID: <20210305162319.GA14489@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 45e606f2726926b04094e1c9bf809bca4884c57f:

  Merge branches 'arm/renesas', 'arm/smmu', 'x86/amd', 'x86/vt-d' and 'core' into next (2021-02-12 15:27:17 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.12-rc1

for you to fetch changes up to 444d66a23c1f1e4c4d12aed4812681d0ad835d60:

  iommu/vt-d: Fix status code for Allocate/Free PASID command (2021-03-04 13:32:04 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.12-rc1

Including:

	- Fix for a sleeping-while-atomic issue in the AMD IOMMU code

	- Disabling lazy IOTLB flush for untrusted devices in the Intel VT-d driver

	- Fix status code definitions for Intel VT-d

	- Fix IO Page Fault issue in Tegra IOMMU driver

----------------------------------------------------------------
Andrey Ryabinin (1):
      iommu/amd: Fix sleeping in atomic in increase_address_space()

Lu Baolu (1):
      iommu: Don't use lazy flush for untrusted device

Nicolin Chen (1):
      iommu/tegra-smmu: Fix mc errors on tegra124-nyan

Zenghui Yu (1):
      iommu/vt-d: Fix status code for Allocate/Free PASID command

 drivers/iommu/amd/io_pgtable.c | 10 +++---
 drivers/iommu/dma-iommu.c      | 15 +++++----
 drivers/iommu/intel/pasid.h    |  4 +--
 drivers/iommu/tegra-smmu.c     | 72 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 87 insertions(+), 14 deletions(-)

Please pull.

Thanks,

	Joerg

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmBCWvYACgkQK/BELZcB
GuNZ7Q/+KqbPG4VldrL3+whXokC0q+DaLATCaWJln2vjzUEqoJEf5T1YbEki+GzJ
T4hzfEjjQgqX4NyZY2dXELkbuclkeZJKXxTb72Dcnsqf8y8xo33PHVw0B10nE5mR
qi3SNrETGtykcx5hJKMZnHVVm7hJGRlTwKtzKKV4Rfl0TQnQ2IibqmDexeoUWXlz
tNK48glmGs3wcfjdRlPABCEFTqQoODllaZ9rgCiQMqegPR4dVyEFhhOJ3ATgAcCt
OYDnXyoUcdhWhmTCYosQlAlrRQ5X0VZ7voRMoAv2ZTHTjRvmvwIIPAnV5M6w3CtW
iGPzN7JwEULwPUgJajcj8Qda/kR41K1fXUdJO+LLKAnekU1W6xfCIsJRNAIcU2IB
2qZuJdcnZhkh4TN8UoQdQLZvT1YEshKpT7FdcY0LyDIsdp8KcHIeNfjx5crYC6IT
5uvlRfEV3vkqm2sZO+qAtxCxM9iRKkkWUCC1IqSLzQ2Dri+5b02fKkEqd5hIgn5I
qZOem3Sb29gpjcoKCV8tdgiiXeZ302rFB+Xkvl3VF4jb5DlwHkuTSkWM47dlD/L9
9WZSQzPWi09NWahHulPQEpYueppEhlJlzu9XXWoRWNSO6O80y3ROyx/Ag5t2gzYb
ILuS47fCLwUD8518MAVXD4MrhMzL4pbYVyvLVBykOnZKFztRoAo=
=UIv1
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
