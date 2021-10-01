Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5DF41E552
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 02:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351391AbhJAAGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 20:06:30 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51610 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350980AbhJAAGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 20:06:08 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9520B20242F;
        Fri,  1 Oct 2021 02:04:24 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5BAEA200C04;
        Fri,  1 Oct 2021 02:04:24 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id D106640BCF;
        Thu, 30 Sep 2021 17:04:23 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 08/16] ARM: dts: ls1021a: disable ifc node by default
Date:   Thu, 30 Sep 2021 19:04:09 -0500
Message-Id: <20211001000417.15334-9-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211001000417.15334-1-leoyang.li@nxp.com>
References: <20211001000417.15334-1-leoyang.li@nxp.com>
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
v2:
Dropped the ifc node name change as we are dropping "simple-bus"

 arch/arm/boot/dts/ls1021a-qds.dts | 6 +++---
 arch/arm/boot/dts/ls1021a.dtsi    | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index 522e1dc51059..1ff11bff4f2b 100644
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
index 9622c6509d9e..25f0cdf3fd0c 100644
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

