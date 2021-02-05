Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A623311B1E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhBFEtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:49:09 -0500
Received: from inva021.nxp.com ([92.121.34.21]:60492 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230218AbhBFD21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:28:27 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 540CA200374;
        Sat,  6 Feb 2021 00:50:53 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1784220016E;
        Sat,  6 Feb 2021 00:50:53 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 2B9BA40011;
        Fri,  5 Feb 2021 16:50:52 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 08/15] ARM: dts: ls1021a: breakup long values in thermal node
Date:   Fri,  5 Feb 2021 17:47:27 -0600
Message-Id: <20210205234734.3397-9-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20210205234734.3397-1-leoyang.li@nxp.com>
References: <20210205234734.3397-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Breakup long values to pass the schema check.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 72 +++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 215a3d928ec9..88e7248fc5f0 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -247,42 +247,42 @@
 			reg = <0x0 0x1f00000 0x0 0x10000>;
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			fsl,tmu-range = <0xb0000 0x9002c 0x6004e 0x30066>;
-			fsl,tmu-calibration = <0x00000000 0x00000020
-					       0x00000001 0x00000024
-					       0x00000002 0x0000002a
-					       0x00000003 0x00000032
-					       0x00000004 0x00000038
-					       0x00000005 0x0000003e
-					       0x00000006 0x00000043
-					       0x00000007 0x0000004a
-					       0x00000008 0x00000050
-					       0x00000009 0x00000059
-					       0x0000000a 0x0000005f
-					       0x0000000b 0x00000066
-
-					       0x00010000 0x00000023
-					       0x00010001 0x0000002b
-					       0x00010002 0x00000033
-					       0x00010003 0x0000003a
-					       0x00010004 0x00000042
-					       0x00010005 0x0000004a
-					       0x00010006 0x00000054
-					       0x00010007 0x0000005c
-					       0x00010008 0x00000065
-					       0x00010009 0x0000006f
-
-					       0x00020000 0x00000029
-					       0x00020001 0x00000033
-					       0x00020002 0x0000003d
-					       0x00020003 0x00000048
-					       0x00020004 0x00000054
-					       0x00020005 0x00000060
-					       0x00020006 0x0000006c
-
-					       0x00030000 0x00000025
-					       0x00030001 0x00000033
-					       0x00030002 0x00000043
-					       0x00030003 0x00000055>;
+			fsl,tmu-calibration = <0x00000000 0x00000020>,
+					      <0x00000001 0x00000024>,
+					      <0x00000002 0x0000002a>,
+					      <0x00000003 0x00000032>,
+					      <0x00000004 0x00000038>,
+					      <0x00000005 0x0000003e>,
+					      <0x00000006 0x00000043>,
+					      <0x00000007 0x0000004a>,
+					      <0x00000008 0x00000050>,
+					      <0x00000009 0x00000059>,
+					      <0x0000000a 0x0000005f>,
+					      <0x0000000b 0x00000066>,
+
+					      <0x00010000 0x00000023>,
+					      <0x00010001 0x0000002b>,
+					      <0x00010002 0x00000033>,
+					      <0x00010003 0x0000003a>,
+					      <0x00010004 0x00000042>,
+					      <0x00010005 0x0000004a>,
+					      <0x00010006 0x00000054>,
+					      <0x00010007 0x0000005c>,
+					      <0x00010008 0x00000065>,
+					      <0x00010009 0x0000006f>,
+
+					      <0x00020000 0x00000029>,
+					      <0x00020001 0x00000033>,
+					      <0x00020002 0x0000003d>,
+					      <0x00020003 0x00000048>,
+					      <0x00020004 0x00000054>,
+					      <0x00020005 0x00000060>,
+					      <0x00020006 0x0000006c>,
+
+					      <0x00030000 0x00000025>,
+					      <0x00030001 0x00000033>,
+					      <0x00030002 0x00000043>,
+					      <0x00030003 0x00000055>;
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.17.1

