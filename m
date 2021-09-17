Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD32140EFD4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 04:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241076AbhIQCzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 22:55:49 -0400
Received: from inva020.nxp.com ([92.121.34.13]:47636 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232494AbhIQCzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 22:55:48 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E777F1A12BC;
        Fri, 17 Sep 2021 04:54:25 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AF7621A125F;
        Fri, 17 Sep 2021 04:54:25 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2CE3A183AC94;
        Fri, 17 Sep 2021 10:54:24 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, galak@kernel.crashing.org, shawnguo@kernel.org
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH 0/4] add the imx8 pcie phy driver support
Date:   Fri, 17 Sep 2021 10:30:59 +0800
Message-Id: <1631845863-24249-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

refer to the discussion [1] when try to enable i.MX8MM PCIe support,
one standalone PCIe PHY driver should be seperated from i.MX PCIe
driver when enable i.MX8MM PCIe support.

This patch-set adds the standalone PCIe PHY driver suport, and as a
preparatory to add the i.MX8MM PCIe support later.

The PCIe works on i.MX8MM EVK board based the the blkctrl power driver
[2] and this PHY driver patch-set.

[1] https://patchwork.ozlabs.org/project/linux-pci/patch/20210510141509.929120-3-l.stach@pengutronix.de/
[2] https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210910202640.980366-1-l.stach@pengutronix.de/

[PATCH 1/4] dt-bindings: phy: phy-imx8-pcie: Add binding for the pad
[PATCH 2/4] dt-bindings: phy: add imx8 pcie phy driver support
[PATCH 3/4] arm64: dts: imx8mm: add the pcie phy support
[PATCH 4/4] phy: freescale: pcie: initialize the imx8 pcie standalone

Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  66 ++++++++++++++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi                |   4 ++
arch/arm64/boot/dts/freescale/imx8mm.dtsi                    |  12 ++++++
drivers/phy/freescale/Kconfig                                |   9 +++++
drivers/phy/freescale/Makefile                               |   1 +
drivers/phy/freescale/phy-fsl-imx8-pcie.c                    | 167 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
include/dt-bindings/phy/phy-imx8-pcie.h                      |  14 +++++++
7 files changed, 273 insertions(+)

