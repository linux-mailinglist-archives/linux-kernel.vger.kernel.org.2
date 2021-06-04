Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B6939B56B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhFDJBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 05:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229975AbhFDJBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 05:01:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAC72613BF;
        Fri,  4 Jun 2021 08:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622797163;
        bh=tY42r8cFPqMltVvhSyc5iCxm8Gxpn98wcJ0fI73qMas=;
        h=Date:From:To:Cc:Subject:From;
        b=Z+ZTwv2lIrnblVGbTE7JYpSpr1WySCDJtxw5bqpX83ZZngrphUjFZYaUjVoQbLBAp
         WOj0reFOONIvPaPWQcQgZHaEYCNPFaTBqZaY0A03H9cd2eTL4QmI8xkA0a/Xy9Tvk7
         LMEif3gDQO4cbdcbCMXqG6SlrVVLLGtYccjbkgXEkePBZ9RUy6FWXU1pTsRhreLFVS
         cLlJJmEyLxmtMmu55WtP0QGvZjVlb+9b4ftbXk0u+x3xekJ6+mM5GBUk4qsD2Kxbqe
         3YlZM70UXyQSIzLMN9O7KA/U1gMpzITKzK6zWWF1COmtV9MuvYLgesm3tsQiHVBNFs
         ynRgJq/2OrMxw==
Date:   Fri, 4 Jun 2021 14:29:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>
Subject: [GIT PULL]: Generic phy fixes for v5.13
Message-ID: <YLnraMuKUKPtktfZ@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gQR8tj6Dj9TjCklp"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gQR8tj6Dj9TjCklp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Please pull to recive few fixes for phy subsystem.

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
fixes-5.13

for you to fetch changes up to d1ce245fe409241ed6168c835a5b55ef52bdb6a9:

  phy: Sparx5 Eth SerDes: check return value after calling platform_get_res=
ource() (2021-06-03 11:18:19 +0530)

----------------------------------------------------------------
phy: fixes for 5.13

Phy driver fixes for few drivers: cadence, mtk-tphy, sparx5, wiz mostly
fixing error code and checking return codes etc

----------------------------------------------------------------
Chen Li (1):
      phy: usb: Fix misuse of IS_ENABLED

Sergio Paracuellos (1):
      phy: ralink: phy-mt7621-pci: drop 'of_match_ptr' to fix -Wunused-cons=
t-variable

Tiezhu Yang (1):
      phy: phy-mtk-tphy: Fix some resource leaks in mtk_phy_init()

Wang Wensheng (1):
      phy: cadence: Sierra: Fix error return code in cdns_sierra_phy_probe()

Yang Li (1):
      phy: ti: Fix an error code in wiz_probe()

Yang Yingliang (1):
      phy: Sparx5 Eth SerDes: check return value after calling platform_get=
_resource()

 drivers/phy/broadcom/phy-brcm-usb-init.h | 4 ++--
 drivers/phy/cadence/phy-cadence-sierra.c | 1 +
 drivers/phy/mediatek/phy-mtk-tphy.c      | 2 ++
 drivers/phy/microchip/sparx5_serdes.c    | 4 ++++
 drivers/phy/ralink/phy-mt7621-pci.c      | 2 +-
 drivers/phy/ti/phy-j721e-wiz.c           | 1 +
 6 files changed, 11 insertions(+), 3 deletions(-)

Thanks
--=20
~Vinod

--gQR8tj6Dj9TjCklp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmC562cACgkQfBQHDyUj
g0ej0RAA0wfjAOCnj6YXMFIdTp3L134VgSbx7+1nIpfqXN3tyDRKLYCiesRuoWm1
iBgYaYwfaKbaYqGof5ORO+IygwuySprGr41pAbna2SpRAHbBznHMkTqrQPs/E7pC
EfbK4S4YAWVXyl9hSBsngtQu9n7K24vw+sZsvQJEH+5FOPmTQMgRqD1Lt4wYPpxY
Kv0BScYtEETMWHEZT3YX1WOUBJpi6q5wfxoHS/xb0QyP2fB5/wq6piUPKlq/L2fh
sbCWlYEjOuc/M66BTEm4SfNqc6DiMLwIRr8Z3kOl7OKb0ZCnfT6mWYI/r+RS+9Om
dUy1Jyhol7Ecn9lZ26aPwDdg/+pRwwz2h0/IeT4QvzVFXKS3mjJmnFon3m8BZNnb
SfzT6wpzTuYdYml9X6lUE4T+XhZWXnfymfAG74Z3779gb6QXHSMwimtSkHVRr9bp
Gyuqe5APNAVstITi6JqJixXibgK/SJ7PGWVPsiyqlz+Tc5xFKka8+sVKa5yJISPS
U5wgW0/KILRrwdDQ/Vuvbop+j6aT245TtTQaRQkGyJ5Hy4W0F5T+bEnMDiBLGTQm
0Ciyog2ciubOwwctCt4rhkjpUs5wq8k5gJuoArn151WT21snKbmPx7lv0RIlNFL/
TOqwwNRwu5VOercqAawixfKpDz6MNPJL0kngn3wRjHZlR0dyvzw=
=RtN2
-----END PGP SIGNATURE-----

--gQR8tj6Dj9TjCklp--
