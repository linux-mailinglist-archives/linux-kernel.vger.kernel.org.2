Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC073F5783
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 07:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhHXFL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 01:11:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhHXFL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 01:11:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE16160F57;
        Tue, 24 Aug 2021 05:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629781845;
        bh=jytvFnpGKBFIKqx7pCKjyoj1lA+c76RzTUomXFxQ760=;
        h=Date:From:To:Cc:Subject:From;
        b=SuZ+6QHB04Nh3BIOyDukcK6sMGO3mYZ/l3wx4iowmzEVm3w5NTOOr3pAokLfWa+LG
         /EINGrx9IXFptFgDIpjsYFqOef9VgnkTQNifOAvDeafpfHFTvmA8+whdhTHSFrJH9m
         TMqLf/EsMYgujfCczCxxAiOVo3xNZBcMrNSA9Hm/d3F+1SbF0ZxAY4IWwfBKL4Sqo6
         nXC2klYa6rhUngYfgsQQGSRSxnY0PKQXYjqdu/ssYUPaEvVlcYpdmMFcBqYmmA9L18
         6ZQMLyMYM5uh3alr834rF9fIhp7Hbljcy0wBTyIBs9+L0fV0d/maehuS7bBfydtGD/
         EjysJlSfp6gSA==
Date:   Tue, 24 Aug 2021 10:40:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>
Subject: [GIT PULL]: Generic phy updates for v5.15
Message-ID: <YSR/UHNxE6iu3GBc@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0oUymOkPC2OoOjB7"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0oUymOkPC2OoOjB7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Here is the update for v5.15, sorry this time it is bit late than
normal. Will make sure this hits early next time.

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-5.15

for you to fetch changes up to 152a810eae03f16e982444ffe3b0eca933a750cd:

  phy: qcom-qmp: Add support for SM6115 UFS phy (2021-08-23 11:12:30 +0530)

----------------------------------------------------------------
phy-for-5.15

  - Updates:
        - Yaml conversion for Freescale imx8mq usb phy, TI AM654 SERDES phy,
          Cadence torrent phy
        - Updates for Amlogic Meson8b-usb2 phy, Samsung ufs phy

  - New support:
        - UFS phy for Qualcomm SM6115
	- PCIe & USB/DP phy for Qualcomm sc8180x
	- USB3 PHY support for Qualcomm IPQ6018
	- Renesas USB2.0 PHY for RZ/G2L

----------------------------------------------------------------
Anand Moon (2):
      phy: amlogic: meson8b-usb2: Power off the PHY by putting it into rese=
t mode
      phy: amlogic: meson8b-usb2: don't log an error on -EPROBE_DEFER

Arnd Bergmann (1):
      phy: tegra: xusb: mark PM functions as __maybe_unused

Baruch Siach (2):
      dt-bindings: phy: qcom,qmp: Add IPQ6018 USB3 PHY
      phy: qcom-qmp: add USB3 PHY support for IPQ6018

Biju Das (2):
      dt-bindings: phy: renesas,usb2-phy: Document RZ/G2L phy bindings
      phy: renesas: phy-rcar-gen3-usb2: Add USB2.0 PHY support for RZ/G2L

Bjorn Andersson (6):
      dt-bindings: phy: qcom,qmp: Add sc8180x PCIe compatible
      phy: qcom-qmp: Add sc8180x PCIe support
      phy: qcom-qmp: Fix sc8180x PCIe definition
      dt-bindings: phy: qcom,qmp-usb3-dp: Add support for sc8180x
      phy: qcom: qmp: Add SC8180x USB/DP combo
      phy: qmp: Provide unique clock names for DP clocks

Chanho Park (2):
      phy: samsung-ufs: move phy-exynos7-ufs header
      phy: samsung-ufs: support exynosauto ufs phy driver

Chunfeng Yun (12):
      dt-bindings: phy: mediatek: tphy: add support hardware version 3
      phy: phy-mtk-tphy: support new hardware version
      phy: phy-mtk-tphy: add support mt8195
      dt-bindings: phy: mediatek: tphy: support type switch by pericfg
      phy: phy-mtk-tphy: use clock bulk to get clocks
      phy: phy-mtk-tphy: support type switch by pericfg
      phy: phy-mtk-tphy: print error log using child device
      phy: phy-mtk-tphy: remove error log of ioremap failure
      phy: phy-mtk-ufs: use clock bulk to get clocks
      phy: phy-mtk-hdmi: convert to devm_platform_ioremap_resource
      phy: phy-mtk-mipi-dsi: remove dummy assignment of error number
      phy: phy-mtk-mipi-dsi: convert to devm_platform_ioremap_resource

Dong Aisheng (1):
      dt-bindings: phy: imx8mq-usb-phy: convert to json schema

Geert Uytterhoeven (1):
      dt-bindings: phy: Rename Intel Keem Bay USB PHY bindings

Iskren Chernev (2):
      dt-bindings: phy: qcom,qmp: Add SM6115 UFS PHY bindings
      phy: qcom-qmp: Add support for SM6115 UFS phy

Kishon Vijay Abraham I (1):
      dt-bindings: phy: Convert AM654 SERDES bindings to YAML

Piyush Mehta (1):
      phy: xilinx: zynqmp: skip PHY initialization and PLL lock for USB

Randy Dunlap (1):
      phy: qualcomm: phy-qcom-usb-hs: repair non-kernel-doc comment

Swapnil Jakhade (9):
      phy: cadence-torrent: Remove use of CamelCase to fix checkpatch CHECK=
 message
      phy: cadence-torrent: Reorder few functions to remove function declar=
ations
      phy: cadence-torrent: Add enum for supported input reference clock fr=
equencies
      phy: cadence-torrent: Configure PHY registers as a function of input =
reference clock rate
      phy: cadence-torrent: Add PHY registers for DP in array format
      phy: cadence-torrent: Add PHY configuration for DP with 100MHz ref cl=
ock
      phy: cadence-torrent: Add separate functions for reusable code
      phy: cadence-torrent: Add debug information for PHY configuration
      phy: cadence-torrent: Check PIPE mode PHY status to be ready for oper=
ation

Tony Lindgren (1):
      phy: phy-twl4030-usb: Disable PHY for suspend

kernel test robot (1):
      phy: rockchip-inno-usb2: fix for_each_child.cocci warnings

 .../devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt |   20 -
 .../bindings/phy/fsl,imx8mq-usb-phy.yaml           |   53 +
 ...keembay-usb.yaml =3D> intel,keembay-phy-usb.yaml} |    2 +-
 .../devicetree/bindings/phy/mediatek,tphy.yaml     |   30 +-
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |    4 +
 .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml         |    1 +
 .../devicetree/bindings/phy/renesas,usb2-phy.yaml  |   15 +
 .../devicetree/bindings/phy/samsung,ufs-phy.yaml   |    1 +
 .../bindings/phy/ti,phy-am654-serdes.txt           |   82 -
 .../bindings/phy/ti,phy-am654-serdes.yaml          |  103 +
 drivers/phy/amlogic/phy-meson8b-usb2.c             |    8 +-
 drivers/phy/cadence/phy-cadence-torrent.c          | 3181 +++++++++++-----=
----
 drivers/phy/mediatek/phy-mtk-hdmi.c                |    7 +-
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c            |   13 +-
 drivers/phy/mediatek/phy-mtk-tphy.c                |  224 +-
 drivers/phy/mediatek/phy-mtk-ufs.c                 |   44 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                |  321 +-
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   18 +
 drivers/phy/qualcomm/phy-qcom-usb-hs.c             |    2 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |   97 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |    4 +-
 drivers/phy/samsung/Makefile                       |    5 +-
 .../{phy-exynos7-ufs.h =3D> phy-exynos7-ufs.c}       |    8 +-
 drivers/phy/samsung/phy-exynosautov9-ufs.c         |   67 +
 drivers/phy/samsung/phy-samsung-ufs.c              |    3 +
 drivers/phy/samsung/phy-samsung-ufs.h              |   13 +-
 drivers/phy/tegra/xusb.c                           |    4 +-
 drivers/phy/ti/phy-twl4030-usb.c                   |   15 +
 drivers/phy/xilinx/phy-zynqmp.c                    |    3 +
 29 files changed, 2676 insertions(+), 1672 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-ph=
y.txt
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-ph=
y.yaml
 rename Documentation/devicetree/bindings/phy/{intel,phy-keembay-usb.yaml =
=3D> intel,keembay-phy-usb.yaml} (93%)
 delete mode 100644 Documentation/devicetree/bindings/phy/ti,phy-am654-serd=
es.txt
 create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-am654-serd=
es.yaml
 rename drivers/phy/samsung/{phy-exynos7-ufs.h =3D> phy-exynos7-ufs.c} (93%)
 create mode 100644 drivers/phy/samsung/phy-exynosautov9-ufs.c

Thanks
--=20
~Vinod

--0oUymOkPC2OoOjB7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmEkf08ACgkQfBQHDyUj
g0eh6BAAwB8ZuXAsat/AuJDgSF+ybLz4u+Bk8cDpvPHXas2P2OnPD3XYWgNYO/Ah
bG1Ri+vsiioaJ8eYkhDyla/ulG/gKx3pmRnDsCUxYuyOh8Bx5hdA9BF9U8ZyxaSd
uk2prAShCipcvv8DbZ+V1D1cNZT9jZvx2MXjtuu82HMrb3VNN89r4vGwln/XiYqy
fbM9Mf2gItG+iuX9Mkgp8D7o6tvcm/griKHCix9glINMBq2ED/A+csztj77eX2ze
6bXzb1RkPrc/7ZvQM+HBzXCnIPqMfNT73BBJ63HbG/Psa+gBWa+nYA2H27QgAiJJ
XT2FytgDF3r/xwNJRPJT420+C57yAqVHVlbQmNnMWMF8iwKQhCylshMP9U8VeH/6
+kHYUPYL6jhCYCUZZgZq7u2bRcMYJVnG1NSUU1Q9+tuIkIIYEBe2+6qvzGPbHwhl
xpiMfa+Yn9I39Ilk3TI2HihXnX90mu11PpPJReOaouUZFbk5TY+w0rzjF3u1c9rI
AznAYmXHlvAG1F3djUEJg5Wmr5C10UsxuRtYbM1old5bKnxxR6OZdNdeRIdpjsgd
ylKuNkq5hYJuuyNVRIzXLCQKButUfIiIAsC6Cy0OfuaThsyf5EVguLfMADUiRGhN
M5FIS1R8B/B4CA6YpwrJ4cHUMouSsiRgLS1pyXeuO8BtIofZjHo=
=/D9M
-----END PGP SIGNATURE-----

--0oUymOkPC2OoOjB7--
