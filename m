Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1FC42B0CD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 02:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236764AbhJMAIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 20:08:44 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33304 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236216AbhJMAI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 20:08:26 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A1F76202E40;
        Wed, 13 Oct 2021 02:06:23 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6AE5A202E3A;
        Wed, 13 Oct 2021 02:06:23 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id E444840A85;
        Tue, 12 Oct 2021 17:06:22 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v3 09/17] ARM: dts: ls1021a: disable ifc node by default
Date:   Tue, 12 Oct 2021 18:58:15 -0500
Message-Id: <20211012235824.31096-10-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211012235824.31096-1-leoyang.li@nxp.com>
References: <20211012235824.31096-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable the bus in the SoC dtsi file to be enabled only in board dts
files. Also breakup long values in the ifc node to fix dtbs_check.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm/boot/dts/ls1021a-qds.dts | 6 +++---
 arch/arm/boot/dts/ls1021a.dtsi    | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index 8982ba2c14c2..6db6604e7a18 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -189,9 +189,9 @@ &ifc {
 	#address-cells = <2>;
 	#size-cells = <1>;
 	/* NOR, NAND Flashes and FPGA on board */
-	ranges = <0x0 0x0 0x0 0x60000000 0x08000000
-		  0x2 0x0 0x0 0x7e800000 0x00010000
-		  0x3 0x0 0x0 0x7fb00000 0x00000100>;
+	ranges = <0x0 0x0 0x0 0x60000000 0x08000000>,
+		 <0x2 0x0 0x0 0x7e800000 0x00010000>,
+		 <0x3 0x0 0x0 0x7fb00000 0x00000100>;
 	status = "okay";
 
 	nor@0,0 {
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 4a7d06a14946..e6677721263b 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -126,6 +126,7 @@ ifc: ifc@1530000 {
 			compatible = "fsl,ifc", "simple-bus";
 			reg = <0x0 0x1530000 0x0 0x10000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		dcfg: dcfg@1ee0000 {
-- 
2.25.1

