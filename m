Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D14418744
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 10:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhIZIFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 04:05:15 -0400
Received: from inva020.nxp.com ([92.121.34.13]:43624 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhIZIFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 04:05:14 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 468DB1A14B9;
        Sun, 26 Sep 2021 10:03:37 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0DE8E1A0FF5;
        Sun, 26 Sep 2021 10:03:37 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7EBC3183AD05;
        Sun, 26 Sep 2021 16:03:35 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, galak@kernel.crashing.org, shawnguo@kernel.org
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v2 0/4] add the imx8 pcie phy driver support
Date:   Sun, 26 Sep 2021 15:39:39 +0800
Message-Id: <1632641983-1455-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to the discussion [1] when try to enable i.MX8MM PCIe support,
one standalone PCIe PHY driver should be seperated from i.MX PCIe
driver when enable i.MX8MM PCIe support.

This patch-set adds the standalone PCIe PHY driver suport, and as a
preparatory to add the i.MX8MM PCIe support later.

The PCIe works on i.MX8MM EVK board based the the blkctrl power driver
[2] and this PHY driver patch-set.

[1] https://patchwork.ozlabs.org/project/linux-pci/patch/20210510141509.929120-3-l.stach@pengutronix.de/
[2] https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210910202640.980366-1-l.stach@pengutronix.de/

Changes v1 --> v2:
- Update the license of the dt-binding header file to make the license
  compatible with dts files.
- Fix the dt_binding_check errors.

[PATCH v2 1/4] dt-bindings: phy: phy-imx8-pcie: Add binding for the
[PATCH v2 2/4] dt-bindings: phy: add imx8 pcie phy driver support
[PATCH v2 3/4] arm64: dts: imx8mm: add the pcie phy support
[PATCH v2 4/4] phy: freescale: pcie: initialize the imx8 pcie

Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  67 ++++++++++++++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi                |   4 ++
arch/arm64/boot/dts/freescale/imx8mm.dtsi                    |  12 ++++++
drivers/phy/freescale/Kconfig                                |   9 +++++
drivers/phy/freescale/Makefile                               |   1 +
drivers/phy/freescale/phy-fsl-imx8-pcie.c                    | 167 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
include/dt-bindings/phy/phy-imx8-pcie.h                      |  14 +++++++
7 files changed, 274 insertions(+)

