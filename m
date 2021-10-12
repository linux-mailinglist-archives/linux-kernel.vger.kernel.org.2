Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424D642A0AD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 11:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbhJLJI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 05:08:29 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45680 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235532AbhJLJIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 05:08:14 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BD20A1A1D21;
        Tue, 12 Oct 2021 11:06:12 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8E8CE1A2486;
        Tue, 12 Oct 2021 11:06:12 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D6637183AD0B;
        Tue, 12 Oct 2021 17:06:10 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, tharvey@gateworks.com, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org, galak@kernel.crashing.org,
        shawnguo@kernel.org
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 6/9] dt-bindings: imx6q-pcie: Add PHY phandles and name properties
Date:   Tue, 12 Oct 2021 16:41:15 +0800
Message-Id: <1634028078-2387-7-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MM PCIe has the PHY. Add a PHY phandle and name properties
in the binding document.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 2911e565b260..99d9863a69cd 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -128,6 +128,12 @@ properties:
     enum: [1, 2, 3, 4]
     default: 1
 
+  phys:
+    description: Phandle of the Generic PHY to the PCIe PHY.
+
+  phy-names:
+    const: pcie-phy
+
   reset-gpio:
     description: Should specify the GPIO for controlling the PCI bus device
       reset signal. It's not polarity aware and defaults to active-low reset
-- 
2.25.1

