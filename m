Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D9043DC6D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 09:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhJ1Hz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 03:55:27 -0400
Received: from inva020.nxp.com ([92.121.34.13]:32854 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhJ1Hz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 03:55:26 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 61D041A01F0;
        Thu, 28 Oct 2021 09:52:58 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 099A21A1E17;
        Thu, 28 Oct 2021 09:52:58 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9F080183AC94;
        Thu, 28 Oct 2021 15:52:55 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, galak@kernel.crashing.org, shawnguo@kernel.org
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v4 0/8] add the imx8m pcie phy driver and imx8mm pcie support
Date:   Thu, 28 Oct 2021 15:27:09 +0800
Message-Id: <1635406037-20900-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to the discussion [1] when try to enable i.MX8MM PCIe support,
one standalone PCIe PHY driver should be seperated from i.MX PCIe
driver when enable i.MX8MM PCIe support.

This patch-set adds the standalone PCIe PHY driver suport[1-5], and i.MX8MM
PCIe support[6-8] to have whole view to review this patch-set.

The PCIe works on i.MX8MM EVK board based the the blkctrl power driver
[2] and this patch-set.

[1] https://patchwork.ozlabs.org/project/linux-pci/patch/20210510141509.929120-3-l.stach@pengutronix.de/
[2] https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210910202640.980366-1-l.stach@pengutronix.de/

Main changes v3 --> v4:
- Update the yaml to fix syntax error, add maxitems and drop description of phy
- Correct the clock name in PHY DT node.
- Squash the EVK board relalted dts changes into one patch, and drop the
  useless dummy clock and gpio suffix in DT nodes.
- Add board specific de-emphasis parameters as DT properties. Thus each board
  can specify its actual de-emphasis values.
- Update the commit log of PHY driver.
- Remove the useless codes from PCIe driver, since they are moved to PHY driver
- After the discussion and verification of the CLKREQ# configurations with Tim,
  agree to add an optional boolean property "fsl,clkreq-unsupported", indicates
  the CLKREQ# signal is hooked or not in HW designs.
- Add "Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>" tag, since
  Marcel help to test the v3 patch-set.

Main changes v2 --> v3:
- Regarding Lucas' comments.
 - to have a whole view to review the patches, send out the i.MX8MM PCIe support too.
 - move the PHY related bits manipulations of the GPR/SRC to standalone PHY driver.
 - split the dts changes to SOC and board DT, and use the enum instead of raw value.
 - update the license of the dt-binding header file.

Changes v1 --> v2:
- Update the license of the dt-binding header file to make the license
  compatible with dts files.
- Fix the dt_binding_check errors.

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   6 +++
Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  95 +++++++++++++++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi                |  55 +++++++++++++++++++
arch/arm64/boot/dts/freescale/imx8mm.dtsi                    |  46 +++++++++++++++-
drivers/pci/controller/dwc/pci-imx6.c                        |  73 ++++++++++++++++++++++---
drivers/phy/freescale/Kconfig                                |   9 ++++
drivers/phy/freescale/Makefile                               |   1 +
drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   | 234 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
include/dt-bindings/phy/phy-imx8-pcie.h                      |  14 +++++
9 files changed, 525 insertions(+), 8 deletions(-)

[PATCH v4 1/8] dt-bindings: phy: phy-imx8-pcie: Add binding for the
[PATCH v4 2/8] dt-bindings: phy: Add imx8 pcie phy driver support
[PATCH v4 3/8] dt-bindings: imx6q-pcie: Add PHY phandles and name
[PATCH v4 4/8] arm64: dts: imx8mm: Add the pcie phy support
[PATCH v4 5/8] phy: freescale: pcie: Initialize the imx8 pcie
[PATCH v4 6/8] arm64: dts: imx8mm: Add the pcie support
[PATCH v4 7/8] arm64: dts: imx8mm-evk: Add the pcie support on imx8mm
[PATCH v4 8/8] PCI: imx: Add the imx8mm pcie support
