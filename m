Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE35E31267D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 18:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhBGRtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 12:49:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:54322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhBGRtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 12:49:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91A0064E2E;
        Sun,  7 Feb 2021 17:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612720151;
        bh=l6Iy67Vd6PIunAXbs5zQxT2BEDXN5YmrhNUpNGqFQbU=;
        h=Date:From:To:Cc:Subject:From;
        b=iaD9TWnFU0N2VTtbeekx3ywRx6ZnKJNFyeg5nJqfN0BZVK/ZffnqH/Aq06qwNIuv5
         n7d0qgSsrJDH/vhrBmTHeB+MpMyE2Jd+XtAYO5HDVa71QTY5hZ4yKPq8AuM4UyROt2
         rXa5cGF9f5WvMqpG1MAa2fXJVdb2zRhRLiNfu5svAv1eoNs68NHKGvTmJMxNzwQKxK
         gkAA7lt6r2C173FlxZV0AVhwqEKmbie3HHzJvmoCVBp5EHQ3xi42vbaMWTIr+X2pxa
         zsrl8VQxQty9hgL7RIf2fga2E7IoubSsh1SgwrrzRMKfdO4OzeZs0qFAJcn12xmxJs
         f5uSF+wc3nu1g==
Date:   Sun, 7 Feb 2021 23:19:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [GIT PULL]: Linux-phy updates for v5.12
Message-ID: <20210207174907.GB879029@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Please pull to receive Linus-phy updates for v5.12

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-5.12

for you to fetch changes up to d68f2cb095979dff1c99e7803c7730ec2b53fc83:

  phy: cpcap-usb: Simplify bool conversion (2021-02-06 15:38:22 +0530)

----------------------------------------------------------------
phy-for-5.12

 - Updates:
   - Conversion to YAML binding for:
        - mtk-xsphy
        - mtk-tphy
        - mtk-ufs
	- HDMI PHY
	- MIPI DSI PHY
	- brcmstb-usb-phy
   - Support for BCM4908 usb phy
   - Support for Qualcomm SDX55 USB and QMP phy
   - Support for Qualcomm SM8350 aka Snapdragon 888 UFS and USB phy
   - Support for Qualcomm SDM660 USB and UFS phy
   - Support for Qualcomm SC8180X USB and UFS phy
   - Support for Qualcomm IPQ6018 USB phy
   - Stm32 phy updates

----------------------------------------------------------------
Amelie Delaunay (6):
      dt-bindings: phy: phy-stm32-usbphyc: move PLL supplies to parent node
      phy: stm32: manage 1v1 and 1v8 supplies at pll activation/deactivation
      phy: stm32: replace regulator_bulk* by multiple regulator_*
      phy: stm32: ensure pll is disabled before phys creation
      phy: stm32: ensure phy are no more active when removing the driver
      phy: stm32: rework PLL Lock detection

AngeloGioacchino Del Regno (3):
      phy: qcom-qusb2: Allow specifying default clock scheme
      phy: qcom-qusb2: Add configuration for SDM660
      dt-bindings: phy: qcom-qusb2: Document SDM660 compatible

Baruch Siach (1):
      dt-bindings: phy: qcom,qusb2: document ipq6018 compatible

Bjorn Andersson (4):
      dt-bindings: phy: qcom,qmp: Add SC8180X UFS to the QMP binding
      dt-bindings: phy: qcom,qmp: Add SC8180X USB phy
      phy: qcom-qmp: Add SC8180X UFS phy
      phy: qcom-qmp: Add SC8180X USB phy

Chunfeng Yun (5):
      dt-bindings: phy: convert phy-mtk-xsphy.txt to YAML schema
      dt-bindings: phy: convert phy-mtk-tphy.txt to YAML schema
      dt-bindings: phy: convert phy-mtk-ufs.txt to YAML schema
      dt-bindings: phy: convert HDMI PHY binding to YAML schema
      dt-bindings: phy: convert MIPI DSI PHY binding to YAML schema

Colin Ian King (1):
      phy: qcom-qmp: make a const array static, makes object smaller

Dan Carpenter (1):
      phy: cadence-torrent: Fix error code in cdns_torrent_phy_probe()

Jack Pham (3):
      dt-bindings: phy: qcom,qmp: Add SM8150, SM8250 and SM8350 USB PHY bin=
dings
      phy: qcom-qmp: Add SM8350 USB QMP PHYs
      dt-bindings: phy: qcom,usb-snps-femto-v2: Add SM8250 and SM8350 bindi=
ngs

Kathiravan T (1):
      phy: qcom-qusb2: add QUSB2 support for IPQ6018

Konrad Dybcio (1):
      phy: qualcomm: usb28nm: Add MDM9607 init sequence

Manivannan Sadhasivam (2):
      dt-bindings: phy: qcom,qmp: Add SDX55 USB PHY binding
      phy: qcom-qmp: Add support for SDX55 QMP PHY

Mauro Carvalho Chehab (1):
      dt-bindings: phy: update phy-cadence-sierra.yaml reference

Michal Simek (1):
      phy: zynqmp: Simplify code by using dev_err_probe()

Paul Cercueil (1):
      phy: ingenic: Remove useless field .version

Rafa=C5=82 Mi=C5=82ecki (5):
      phy: phy-brcm-usb: improve getting OF matching data
      phy: phy-brcm-usb: specify init function format at struct level
      dt-bindings: phy: brcm, brcmstb-usb-phy: convert to the json-schema
      dt-bindings: phy: brcm, brcmstb-usb-phy: add BCM4908 binding
      phy: phy-brcm-usb: support PHY on the BCM4908

Vinod Koul (3):
      dt-bindings: phy: qcom,qmp: Add SM8350 UFS PHY bindings
      phy: qcom-qmp: Add UFS V5 registers found in SM8350
      phy: qcom-qmp: Add support for SM8350 UFS phy

Yang Li (1):
      phy: cpcap-usb: Simplify bool conversion

Zou Wei (1):
      phy: mediatek: Mark mtk_mipi_tx_driver with static keyword

 .../bindings/display/mediatek/mediatek,dsi.txt     |  18 +-
 .../bindings/display/mediatek/mediatek,hdmi.txt    |  18 +-
 .../bindings/phy/brcm,brcmstb-usb-phy.txt          |  86 -----
 .../bindings/phy/brcm,brcmstb-usb-phy.yaml         | 196 ++++++++++
 .../devicetree/bindings/phy/mediatek,dsi-phy.yaml  |  85 ++++
 .../devicetree/bindings/phy/mediatek,hdmi-phy.yaml |  92 +++++
 .../devicetree/bindings/phy/mediatek,tphy.yaml     | 260 +++++++++++++
 .../devicetree/bindings/phy/mediatek,ufs-phy.yaml  |  64 +++
 .../devicetree/bindings/phy/mediatek,xsphy.yaml    | 199 ++++++++++
 .../devicetree/bindings/phy/phy-mtk-tphy.txt       | 162 --------
 .../devicetree/bindings/phy/phy-mtk-ufs.txt        |  38 --
 .../devicetree/bindings/phy/phy-mtk-xsphy.txt      | 109 ------
 .../devicetree/bindings/phy/phy-stm32-usbphyc.yaml |  22 +-
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |  97 +++++
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |   2 +
 .../devicetree/bindings/phy/qcom,usb-hs-28nm.yaml  |   1 +
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       |   2 +
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml  |   2 +-
 drivers/phy/broadcom/Kconfig                       |   3 +-
 drivers/phy/broadcom/phy-brcm-usb.c                |  18 +-
 drivers/phy/cadence/phy-cadence-torrent.c          |   1 +
 drivers/phy/ingenic/phy-ingenic-usb.c              |  23 --
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c            |   2 +-
 drivers/phy/motorola/phy-cpcap-usb.c               |   2 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 430 +++++++++++++++++=
+++-
 drivers/phy/qualcomm/phy-qcom-qmp.h                | 147 +++++++
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |  74 +++-
 drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c        |  13 +
 drivers/phy/st/phy-stm32-usbphyc.c                 | 222 +++++++----
 drivers/phy/xilinx/phy-zynqmp.c                    |  11 +-
 30 files changed, 1835 insertions(+), 564 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-=
phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-=
phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,dsi-phy.=
yaml
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,hdmi-phy=
=2Eyaml
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,ufs-phy.=
yaml
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,xsphy.ya=
ml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-ufs.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt

Thanks
--=20
~Vinod

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmAgKBMACgkQfBQHDyUj
g0d1VxAAzuO53J3gB9vedafw2vsZ80p7s/It6XA3mR1hSJuMG3VjD1zwGX92Kn4q
uGkRbuFnRLZBa5hqSnd/fakdEvMllNJPLd75K4RyI82x1Gm4FUON0+/+itp4+W02
i/qynnI7x05FadFqv55ylDUbV5r30nGqFUyGHXvA6qdvseTm8HMn875Orn1sy47G
nvFYzuupPhJENAQjoS8VE9Xo512pbHHIE6XNhaRXBHlyrwI9YYMSYX1SC1RmBzpM
FDkD6e0d+kRX+dhAKwrsa82U074MYUzu1TL7KZmQ8FGmReJoWmizeMoWLe463Isq
LnJcGIjHLWGM7XhrgVeZMMaboE6DCytNzIG94gUDTmzNNrwlG+sOshwoWe/mJro8
5hfS7bA+t+QO9tVFSfSZTSurZjwqZVcXXWOstBJiqjz8Vs1fUEdA7G4sCwI9HKpA
28vAU6aKgkDEz59LNW3OVQZkuhFAUy1j83AFmRSFRy0vVKacHOCnvcWzYH+35+Ja
USGUvQRAQov60lGBQ7xWK5vA5dXKvl06bbyNKWZ0dosclLXjSXQLQOy0I56tvO6j
rMtjXY1glJya9DsQYMk/SuzMmy5Gh6LdNfolpvnJJnF7r0IwRRzomBAuTGbz9sk3
INCBq5PjZZ49zGXdhUGA3tnf2ox1VBvE0OIIWpjr+6w1MY1uCdQ=
=0anH
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
