Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBBD311A17
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhBFDa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:30:29 -0500
Received: from inva020.nxp.com ([92.121.34.13]:47588 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231694AbhBFCl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:41:28 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AD3E91A17A7;
        Sat,  6 Feb 2021 00:50:53 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7220A1A024F;
        Sat,  6 Feb 2021 00:50:53 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id D32F540BCF;
        Fri,  5 Feb 2021 16:50:52 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 09/15] ARM: dts: ls1021a: fix ifc node to follow binding schema
Date:   Fri,  5 Feb 2021 17:47:28 -0600
Message-Id: <20210205234734.3397-10-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20210205234734.3397-1-leoyang.li@nxp.com>
References: <20210205234734.3397-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Breakup long values in the ifc node.  Change the node name to ifc-bus to
follow the schema of simple-bus and disable the bus in the SoC dtsi file
to be enabled only in board dts files.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm/boot/dts/ls1021a-qds.dts | 6 +++---
 arch/arm/boot/dts/ls1021a.dtsi    | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
index 86d969d0ef68..9b0f9212e777 100644
--- a/arch/arm/boot/dts/ls1021a-qds.dts
+++ b/arch/arm/boot/dts/ls1021a-qds.dts
@@ -189,9 +189,9 @@
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
index 88e7248fc5f0..875202f26450 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -123,10 +123,11 @@
 			interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		ifc: ifc@1530000 {
+		ifc: ifc-bus@1530000 {
 			compatible = "fsl,ifc", "simple-bus";
 			reg = <0x0 0x1530000 0x0 0x10000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		dcfg: dcfg@1ee0000 {
-- 
2.17.1

