Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8676B4527DB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 03:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351677AbhKPCrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 21:47:48 -0500
Received: from inva020.nxp.com ([92.121.34.13]:36476 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242396AbhKPCp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 21:45:57 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1BE6D1A2669;
        Tue, 16 Nov 2021 03:43:00 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D71A31A124E;
        Tue, 16 Nov 2021 03:42:59 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 68A51183AD6F;
        Tue, 16 Nov 2021 10:42:58 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, galak@kernel.crashing.org, shawnguo@kernel.org
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v6 1/8] dt-bindings: phy: phy-imx8-pcie: Add binding for the pad modes of imx8 pcie phy
Date:   Tue, 16 Nov 2021 10:16:09 +0800
Message-Id: <1637028976-9201-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637028976-9201-1-git-send-email-hongxing.zhu@nxp.com>
References: <1637028976-9201-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for reference clock PAD modes of the i.MX8 PCIe PHY.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Tim Harvey <tharvey@gateworks.com>
Tested-by: Tim Harvey <tharvey@gateworks.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/phy/phy-imx8-pcie.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 include/dt-bindings/phy/phy-imx8-pcie.h

diff --git a/include/dt-bindings/phy/phy-imx8-pcie.h b/include/dt-bindings/phy/phy-imx8-pcie.h
new file mode 100644
index 000000000000..8bbe2d6538d8
--- /dev/null
+++ b/include/dt-bindings/phy/phy-imx8-pcie.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * This header provides constants for i.MX8 PCIe.
+ */
+
+#ifndef _DT_BINDINGS_IMX8_PCIE_H
+#define _DT_BINDINGS_IMX8_PCIE_H
+
+/* Reference clock PAD mode */
+#define IMX8_PCIE_REFCLK_PAD_UNUSED	0
+#define IMX8_PCIE_REFCLK_PAD_INPUT	1
+#define IMX8_PCIE_REFCLK_PAD_OUTPUT	2
+
+#endif /* _DT_BINDINGS_IMX8_PCIE_H */
-- 
2.25.1

