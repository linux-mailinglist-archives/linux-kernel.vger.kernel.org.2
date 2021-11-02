Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9843E4425D7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 03:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhKBDBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 23:01:14 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51820 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231882AbhKBDBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 23:01:10 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BD6C7201DDA;
        Tue,  2 Nov 2021 03:58:35 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 81D7A200168;
        Tue,  2 Nov 2021 03:58:35 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A89CA183AD6F;
        Tue,  2 Nov 2021 10:58:33 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, kishon@ti.com, vkoul@kernel.org,
        robh@kernel.org, galak@kernel.crashing.org, shawnguo@kernel.org
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v5 3/8] dt-bindings: imx6q-pcie: Add PHY phandles and name properties
Date:   Tue,  2 Nov 2021 10:32:30 +0800
Message-Id: <1635820355-27009-4-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635820355-27009-1-git-send-email-hongxing.zhu@nxp.com>
References: <1635820355-27009-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MM PCIe has the PHY. Add a PHY phandle and name properties
in the binding document.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Tim Harvey <tharvey@gateworks.com>
Tested-by: Tim Harvey <tharvey@gateworks.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 2911e565b260..46b5446f5791 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -128,6 +128,12 @@ properties:
     enum: [1, 2, 3, 4]
     default: 1
 
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: pcie-phy
+
   reset-gpio:
     description: Should specify the GPIO for controlling the PCI bus device
       reset signal. It's not polarity aware and defaults to active-low reset
-- 
2.25.1

