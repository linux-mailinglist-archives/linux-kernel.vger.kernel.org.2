Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1592B42A0AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 11:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbhJLJIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 05:08:21 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45362 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235343AbhJLJIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 05:08:11 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 753431A1D1C;
        Tue, 12 Oct 2021 11:06:05 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3B6C91A1D11;
        Tue, 12 Oct 2021 11:06:05 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9B2AE183AD14;
        Tue, 12 Oct 2021 17:06:03 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, tharvey@gateworks.com, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org, galak@kernel.crashing.org,
        shawnguo@kernel.org
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v3 0/9] add the imx8m pcie phy driver and imx8mm pcie support
Date:   Tue, 12 Oct 2021 16:41:09 +0800
Message-Id: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

refer to the discussion [1] when try to enable i.MX8MM PCIe support,
one standalone PCIe PHY driver should be seperated from i.MX PCIe
driver when enable i.MX8MM PCIe support.

This patch-set adds the standalone PCIe PHY driver suport[1-5], and i.MX8MM
PCIe support[6-9] to have whole view to review this patch-set.

The PCIe works on i.MX8MM EVK board based the the blkctrl power driver
[2] and this PHY driver patch-set.

[1] https://patchwork.ozlabs.org/project/linux-pci/patch/20210510141509.929120-3-l.stach@pengutronix.de/
[2] https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210910202640.980366-1-l.stach@pengutronix.de/

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
Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  79 +++++++++++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi                |  53 ++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx8mm.dtsi                    |  46 ++++++++++++++++-
drivers/pci/controller/dwc/pci-imx6.c                        |  63 ++++++++++++++++++++++-
drivers/phy/freescale/Kconfig                                |   9 ++++
drivers/phy/freescale/Makefile                               |   1 +
drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   | 218 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
include/dt-bindings/phy/phy-imx8-pcie.h                      |  14 ++++++
9 files changed, 486 insertions(+), 3 deletions(-)

[PATCH v3 1/9] dt-bindings: phy: phy-imx8-pcie: Add binding for the
[PATCH v3 2/9] dt-bindings: phy: add imx8 pcie phy driver support
[PATCH v3 3/9] arm64: dts: imx8mm: add the pcie phy support
[PATCH v3 4/9] arm64: dts: imx8mm-evk: add the pcie phy support
[PATCH v3 5/9] phy: freescale: pcie: initialize the imx8 pcie
[PATCH v3 6/9] dt-bindings: imx6q-pcie: Add PHY phandles and name
[PATCH v3 7/9] arm64: dts: imx8mm: add the pcie support
[PATCH v3 8/9] arm64: dts: imx8mm-evk: add the pcie support on imx8mm
[PATCH v3 9/9] PCI: imx: add the imx8mm pcie support
