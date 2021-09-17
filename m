Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11EA040EFD6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 04:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242891AbhIQCzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 22:55:51 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45004 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234959AbhIQCzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 22:55:49 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1B91B2012CD;
        Fri, 17 Sep 2021 04:54:27 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D7E762012FC;
        Fri, 17 Sep 2021 04:54:26 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3CA2A183AC4C;
        Fri, 17 Sep 2021 10:54:25 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, galak@kernel.crashing.org, shawnguo@kernel.org
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH 1/4] dt-bindings: phy: phy-imx8-pcie: Add binding for the pad modes of imx8 pcie phy
Date:   Fri, 17 Sep 2021 10:31:00 +0800
Message-Id: <1631845863-24249-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631845863-24249-1-git-send-email-hongxing.zhu@nxp.com>
References: <1631845863-24249-1-git-send-email-hongxing.zhu@nxp.com>
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
index 000000000000..fe198a0cc12c
--- /dev/null
+++ b/include/dt-bindings/phy/phy-imx8-pcie.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for i.MX8 PCIe.
+ */
+
+#ifndef _DT_BINDINGS_IMX8_PCIE_H
+#define _DT_BINDINGS_IMX8_PCIE_H
+
+/* Reference clock PAD mode */
+#define IMX8_PCIE_REFCLK_PAD_NO_USED	0
+#define IMX8_PCIE_REFCLK_PAD_INPUT	1
+#define IMX8_PCIE_REFCLK_PAD_OUTPUT	2
+
+#endif /* _DT_BINDINGS_IMX8_PCIE_H */
-- 
2.25.1

