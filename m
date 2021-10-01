Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422A341E568
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 02:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351227AbhJAALZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 20:11:25 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41450 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350104AbhJAALP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 20:11:15 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5AC221A0D7C;
        Fri,  1 Oct 2021 02:09:31 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1E20B1A0D85;
        Fri,  1 Oct 2021 02:09:31 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 4A14D40BD3;
        Thu, 30 Sep 2021 17:09:30 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 4/5] arm64: dts: remove "simple-bus" compatible from ifc node
Date:   Thu, 30 Sep 2021 19:09:23 -0500
Message-Id: <20211001000924.15421-5-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211001000924.15421-1-leoyang.li@nxp.com>
References: <20211001000924.15421-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binding of ifc device has been updated.  Update dts to match
accordingly.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index d856a1f45da1..b19a44204df8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -435,7 +435,7 @@ dcfg: dcfg@1ee0000 {
 		};
 
 		ifc: ifc@1530000 {
-			compatible = "fsl,ifc", "simple-bus";
+			compatible = "fsl,ifc";
 			reg = <0x0 0x1530000 0x0 0x10000>;
 			interrupts = <0 43 0x4>;
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 41904b8bc85e..1b065f134bd6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -283,7 +283,7 @@ ddr: memory-controller@1080000 {
 		};
 
 		ifc: ifc@1530000 {
-			compatible = "fsl,ifc", "simple-bus";
+			compatible = "fsl,ifc";
 			reg = <0x0 0x1530000 0x0 0x10000>;
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index f8f252fdc039..2b1b0adfd340 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -398,7 +398,7 @@ gpio3: gpio@2330000 {
 		};
 
 		ifc: ifc@2240000 {
-			compatible = "fsl,ifc", "simple-bus";
+			compatible = "fsl,ifc";
 			reg = <0x0 0x2240000 0x0 0x20000>;
 			interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
 			little-endian;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index d8590d080c5e..3679f1707048 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -1037,7 +1037,7 @@ i2c3: i2c@2030000 {
 		};
 
 		ifc: ifc@2240000 {
-			compatible = "fsl,ifc", "simple-bus";
+			compatible = "fsl,ifc";
 			reg = <0x0 0x2240000 0x0 0x20000>;
 			interrupts = <0 21 0x4>; /* Level high type */
 			little-endian;
-- 
2.25.1

