Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C81E42A0A6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 11:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbhJLJIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 05:08:17 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45510 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235490AbhJLJIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 05:08:11 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AFE061A1D25;
        Tue, 12 Oct 2021 11:06:06 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 75BD11A1D2C;
        Tue, 12 Oct 2021 11:06:06 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BD24E183AD0B;
        Tue, 12 Oct 2021 17:06:04 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, tharvey@gateworks.com, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org, galak@kernel.crashing.org,
        shawnguo@kernel.org
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 1/9] dt-bindings: phy: phy-imx8-pcie: Add binding for the pad modes of imx8 pcie phy
Date:   Tue, 12 Oct 2021 16:41:10 +0800
Message-Id: <1634028078-2387-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for reference clock PAD modes of the i.MX8 PCIe PHY.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 include/dt-bindings/phy/phy-imx8-pcie.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 include/dt-bindings/phy/phy-imx8-pcie.h

diff --git a/include/dt-bindings/phy/phy-imx8-pcie.h b/include/dt-bindings/phy/phy-imx8-pcie.h
new file mode 100644
index 000000000000..2bc7f1b31c6b
--- /dev/null
+++ b/include/dt-bindings/phy/phy-imx8-pcie.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
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

