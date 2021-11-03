Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F3C4443E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 15:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhKCOyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 10:54:08 -0400
Received: from ixit.cz ([94.230.151.217]:60768 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhKCOyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 10:54:06 -0400
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 3C063240AA;
        Wed,  3 Nov 2021 14:56:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1635947806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4XFk6BhCrqvQIXsvCoDdvAryZ1gRub3jJKZJwwAE2LY=;
        b=AoUQftpKgC88mrsJFMP2aAImKKgAvdv33bdKmAD86CZMF4Dk5ftiIjqptacOEu1409s/Lp
        ou1XLhWn/2pMQClPvuNqnWdMWFRcYJeJdHaiFLQ+pNJ2hPFmtTRXcElbCp6Ujx34YleQeZ
        DPbwRWa+npI2GOHZpwdkqSwbFiMbnEo=
From:   David Heidelberg <david@ixit.cz>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] arm64: dts: freescale: fix the schema check errors for fsl,tmu-calibration
Date:   Wed,  3 Nov 2021 14:56:42 +0100
Message-Id: <20211103135643.52882-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsl,tmu-calibration is in u32-matrix format. Use matching property syntax and allows validation.

No functional changes. Fixes warnings as:
$ make dtbs_check
...
arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dt.yaml: tmu@30260000: fsl,tmu-calibration:0: Additional items are not allowed (1, 41, 2, 47, 3, 53, 4, 61, 5, 67, 6, 75, 7, 81, 8, 87, 9, 95, 10, 103, 11, 111
, 65536, 27, 65537, 35, 65538, 43, 65539, 51, 65540, 59, 65541, 67, 65542, 75, 65543, 85, 65544, 93, 65545, 103, 65546, 112, 131072, 23, 131073, 35, 131074, 45, 131075, 55, 131076, 65, 131077, 75, 131078, 87, 13
1079, 99, 131080, 111, 196608, 21, 196609, 33, 196610, 45, 196611, 57, 196612, 69, 196613, 83, 196614, 95, 196615, 113 were unexpected)
        From schema: Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
...

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 79 ++++++++---------
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 87 ++++++++++---------
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 81 ++++++++---------
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 74 ++++++++--------
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 74 ++++++++--------
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 73 ++++++++--------
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |  4 +-
 7 files changed, 238 insertions(+), 234 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 50a72cda4727..028dbe48b33d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -299,45 +299,46 @@ tmu: tmu@1f00000 {
 			reg = <0x0 0x1f00000 0x0 0x10000>;
 			interrupts = <0 33 0x4>;
 			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x60062>;
-			fsl,tmu-calibration = <0x00000000 0x00000025
-					       0x00000001 0x0000002c
-					       0x00000002 0x00000032
-					       0x00000003 0x00000039
-					       0x00000004 0x0000003f
-					       0x00000005 0x00000046
-					       0x00000006 0x0000004c
-					       0x00000007 0x00000053
-					       0x00000008 0x00000059
-					       0x00000009 0x0000005f
-					       0x0000000a 0x00000066
-					       0x0000000b 0x0000006c
-
-					       0x00010000 0x00000026
-					       0x00010001 0x0000002d
-					       0x00010002 0x00000035
-					       0x00010003 0x0000003d
-					       0x00010004 0x00000045
-					       0x00010005 0x0000004d
-					       0x00010006 0x00000055
-					       0x00010007 0x0000005d
-					       0x00010008 0x00000065
-					       0x00010009 0x0000006d
-
-					       0x00020000 0x00000026
-					       0x00020001 0x00000030
-					       0x00020002 0x0000003a
-					       0x00020003 0x00000044
-					       0x00020004 0x0000004e
-					       0x00020005 0x00000059
-					       0x00020006 0x00000063
-
-					       0x00030000 0x00000014
-					       0x00030001 0x00000021
-					       0x00030002 0x0000002e
-					       0x00030003 0x0000003a
-					       0x00030004 0x00000047
-					       0x00030005 0x00000053
-					       0x00030006 0x00000060>;
+			fsl,tmu-calibration =
+					<0x00000000 0x00000025>,
+					<0x00000001 0x0000002c>,
+					<0x00000002 0x00000032>,
+					<0x00000003 0x00000039>,
+					<0x00000004 0x0000003f>,
+					<0x00000005 0x00000046>,
+					<0x00000006 0x0000004c>,
+					<0x00000007 0x00000053>,
+					<0x00000008 0x00000059>,
+					<0x00000009 0x0000005f>,
+					<0x0000000a 0x00000066>,
+					<0x0000000b 0x0000006c>,
+
+					<0x00010000 0x00000026>,
+					<0x00010001 0x0000002d>,
+					<0x00010002 0x00000035>,
+					<0x00010003 0x0000003d>,
+					<0x00010004 0x00000045>,
+					<0x00010005 0x0000004d>,
+					<0x00010006 0x00000055>,
+					<0x00010007 0x0000005d>,
+					<0x00010008 0x00000065>,
+					<0x00010009 0x0000006d>,
+
+					<0x00020000 0x00000026>,
+					<0x00020001 0x00000030>,
+					<0x00020002 0x0000003a>,
+					<0x00020003 0x00000044>,
+					<0x00020004 0x0000004e>,
+					<0x00020005 0x00000059>,
+					<0x00020006 0x00000063>,
+
+					<0x00030000 0x00000014>,
+					<0x00030001 0x00000021>,
+					<0x00030002 0x0000002e>,
+					<0x00030003 0x0000003a>,
+					<0x00030004 0x00000047>,
+					<0x00030005 0x00000053>,
+					<0x00030006 0x00000060>;
 			big-endian;
 			#thermal-sensor-cells = <1>;
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index fd3f3e8bb6ce..f4dada877b3a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -965,49 +965,50 @@ tmu: tmu@1f80000 {
 			reg = <0x0 0x1f80000 0x0 0x10000>;
 			interrupts = <0 23 0x4>;
 			fsl,tmu-range = <0xb0000 0xa0026 0x80048 0x70061>;
-			fsl,tmu-calibration = <0x00000000 0x00000024
-					       0x00000001 0x0000002b
-					       0x00000002 0x00000031
-					       0x00000003 0x00000038
-					       0x00000004 0x0000003f
-					       0x00000005 0x00000045
-					       0x00000006 0x0000004c
-					       0x00000007 0x00000053
-					       0x00000008 0x00000059
-					       0x00000009 0x00000060
-					       0x0000000a 0x00000066
-					       0x0000000b 0x0000006d
-
-					       0x00010000 0x0000001c
-					       0x00010001 0x00000024
-					       0x00010002 0x0000002c
-					       0x00010003 0x00000035
-					       0x00010004 0x0000003d
-					       0x00010005 0x00000045
-					       0x00010006 0x0000004d
-					       0x00010007 0x00000055
-					       0x00010008 0x0000005e
-					       0x00010009 0x00000066
-					       0x0001000a 0x0000006e
-
-					       0x00020000 0x00000018
-					       0x00020001 0x00000022
-					       0x00020002 0x0000002d
-					       0x00020003 0x00000038
-					       0x00020004 0x00000043
-					       0x00020005 0x0000004d
-					       0x00020006 0x00000058
-					       0x00020007 0x00000063
-					       0x00020008 0x0000006e
-
-					       0x00030000 0x00000010
-					       0x00030001 0x0000001c
-					       0x00030002 0x00000029
-					       0x00030003 0x00000036
-					       0x00030004 0x00000042
-					       0x00030005 0x0000004f
-					       0x00030006 0x0000005b
-					       0x00030007 0x00000068>;
+			fsl,tmu-calibration =
+					<0x00000000 0x00000024>,
+					<0x00000001 0x0000002b>,
+					<0x00000002 0x00000031>,
+					<0x00000003 0x00000038>,
+					<0x00000004 0x0000003f>,
+					<0x00000005 0x00000045>,
+					<0x00000006 0x0000004c>,
+					<0x00000007 0x00000053>,
+					<0x00000008 0x00000059>,
+					<0x00000009 0x00000060>,
+					<0x0000000a 0x00000066>,
+					<0x0000000b 0x0000006d>,
+
+					<0x00010000 0x0000001c>,
+					<0x00010001 0x00000024>,
+					<0x00010002 0x0000002c>,
+					<0x00010003 0x00000035>,
+					<0x00010004 0x0000003d>,
+					<0x00010005 0x00000045>,
+					<0x00010006 0x0000004d>,
+					<0x00010007 0x00000055>,
+					<0x00010008 0x0000005e>,
+					<0x00010009 0x00000066>,
+					<0x0001000a 0x0000006e>,
+
+					<0x00020000 0x00000018>,
+					<0x00020001 0x00000022>,
+					<0x00020002 0x0000002d>,
+					<0x00020003 0x00000038>,
+					<0x00020004 0x00000043>,
+					<0x00020005 0x0000004d>,
+					<0x00020006 0x00000058>,
+					<0x00020007 0x00000063>,
+					<0x00020008 0x0000006e>,
+
+					<0x00030000 0x00000010>,
+					<0x00030001 0x0000001c>,
+					<0x00030002 0x00000029>,
+					<0x00030003 0x00000036>,
+					<0x00030004 0x00000042>,
+					<0x00030005 0x0000004f>,
+					<0x00030006 0x0000005b>,
+					<0x00030007 0x00000068>;
 			little-endian;
 			#thermal-sensor-cells = <1>;
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 01b01e320411..e6042c4c35ef 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -434,46 +434,47 @@ tmu: tmu@1f00000 {
 			reg = <0x0 0x1f00000 0x0 0x10000>;
 			interrupts = <0 33 0x4>;
 			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x70062>;
-			fsl,tmu-calibration = <0x00000000 0x00000023
-					       0x00000001 0x0000002a
-					       0x00000002 0x00000031
-					       0x00000003 0x00000037
-					       0x00000004 0x0000003e
-					       0x00000005 0x00000044
-					       0x00000006 0x0000004b
-					       0x00000007 0x00000051
-					       0x00000008 0x00000058
-					       0x00000009 0x0000005e
-					       0x0000000a 0x00000065
-					       0x0000000b 0x0000006b
-
-					       0x00010000 0x00000023
-					       0x00010001 0x0000002b
-					       0x00010002 0x00000033
-					       0x00010003 0x0000003b
-					       0x00010004 0x00000043
-					       0x00010005 0x0000004b
-					       0x00010006 0x00000054
-					       0x00010007 0x0000005c
-					       0x00010008 0x00000064
-					       0x00010009 0x0000006c
-
-					       0x00020000 0x00000021
-					       0x00020001 0x0000002c
-					       0x00020002 0x00000036
-					       0x00020003 0x00000040
-					       0x00020004 0x0000004b
-					       0x00020005 0x00000055
-					       0x00020006 0x0000005f
-
-					       0x00030000 0x00000013
-					       0x00030001 0x0000001d
-					       0x00030002 0x00000028
-					       0x00030003 0x00000032
-					       0x00030004 0x0000003d
-					       0x00030005 0x00000047
-					       0x00030006 0x00000052
-					       0x00030007 0x0000005c>;
+			fsl,tmu-calibration =
+					<0x00000000 0x00000023>,
+					<0x00000001 0x0000002a>,
+					<0x00000002 0x00000031>,
+					<0x00000003 0x00000037>,
+					<0x00000004 0x0000003e>,
+					<0x00000005 0x00000044>,
+					<0x00000006 0x0000004b>,
+					<0x00000007 0x00000051>,
+					<0x00000008 0x00000058>,
+					<0x00000009 0x0000005e>,
+					<0x0000000a 0x00000065>,
+					<0x0000000b 0x0000006b>,
+
+					<0x00010000 0x00000023>,
+					<0x00010001 0x0000002b>,
+					<0x00010002 0x00000033>,
+					<0x00010003 0x0000003b>,
+					<0x00010004 0x00000043>,
+					<0x00010005 0x0000004b>,
+					<0x00010006 0x00000054>,
+					<0x00010007 0x0000005c>,
+					<0x00010008 0x00000064>,
+					<0x00010009 0x0000006c>,
+
+					<0x00020000 0x00000021>,
+					<0x00020001 0x0000002c>,
+					<0x00020002 0x00000036>,
+					<0x00020003 0x00000040>,
+					<0x00020004 0x0000004b>,
+					<0x00020005 0x00000055>,
+					<0x00020006 0x0000005f>,
+
+					<0x00030000 0x00000013>,
+					<0x00030001 0x0000001d>,
+					<0x00030002 0x00000028>,
+					<0x00030003 0x00000032>,
+					<0x00030004 0x0000003d>,
+					<0x00030005 0x00000047>,
+					<0x00030006 0x00000052>,
+					<0x00030007 0x0000005c>;
 			#thermal-sensor-cells = <1>;
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 687fea6d8afa..6d6d6daee0c2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -433,46 +433,46 @@ tmu: tmu@1f00000 {
 			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x70062>;
 			fsl,tmu-calibration =
 				/* Calibration data group 1 */
-				<0x00000000 0x00000023
-				0x00000001 0x00000029
-				0x00000002 0x0000002f
-				0x00000003 0x00000036
-				0x00000004 0x0000003c
-				0x00000005 0x00000042
-				0x00000006 0x00000049
-				0x00000007 0x0000004f
-				0x00000008 0x00000055
-				0x00000009 0x0000005c
-				0x0000000a 0x00000062
-				0x0000000b 0x00000068
+				<0x00000000 0x00000023>,
+				<0x00000001 0x00000029>,
+				<0x00000002 0x0000002f>,
+				<0x00000003 0x00000036>,
+				<0x00000004 0x0000003c>,
+				<0x00000005 0x00000042>,
+				<0x00000006 0x00000049>,
+				<0x00000007 0x0000004f>,
+				<0x00000008 0x00000055>,
+				<0x00000009 0x0000005c>,
+				<0x0000000a 0x00000062>,
+				<0x0000000b 0x00000068>,
 				/* Calibration data group 2 */
-				0x00010000 0x00000022
-				0x00010001 0x0000002a
-				0x00010002 0x00000032
-				0x00010003 0x0000003a
-				0x00010004 0x00000042
-				0x00010005 0x0000004a
-				0x00010006 0x00000052
-				0x00010007 0x0000005a
-				0x00010008 0x00000062
-				0x00010009 0x0000006a
+				<0x00010000 0x00000022>,
+				<0x00010001 0x0000002a>,
+				<0x00010002 0x00000032>,
+				<0x00010003 0x0000003a>,
+				<0x00010004 0x00000042>,
+				<0x00010005 0x0000004a>,
+				<0x00010006 0x00000052>,
+				<0x00010007 0x0000005a>,
+				<0x00010008 0x00000062>,
+				<0x00010009 0x0000006a>,
 				/* Calibration data group 3 */
-				0x00020000 0x00000021
-				0x00020001 0x0000002b
-				0x00020002 0x00000035
-				0x00020003 0x0000003e
-				0x00020004 0x00000048
-				0x00020005 0x00000052
-				0x00020006 0x0000005c
+				<0x00020000 0x00000021>,
+				<0x00020001 0x0000002b>,
+				<0x00020002 0x00000035>,
+				<0x00020003 0x0000003e>,
+				<0x00020004 0x00000048>,
+				<0x00020005 0x00000052>,
+				<0x00020006 0x0000005c>,
 				/* Calibration data group 4 */
-				0x00030000 0x00000011
-				0x00030001 0x0000001a
-				0x00030002 0x00000024
-				0x00030003 0x0000002e
-				0x00030004 0x00000038
-				0x00030005 0x00000042
-				0x00030006 0x0000004c
-				0x00030007 0x00000056>;
+				<0x00030000 0x00000011>,
+				<0x00030001 0x0000001a>,
+				<0x00030002 0x00000024>,
+				<0x00030003 0x0000002e>,
+				<0x00030004 0x00000038>,
+				<0x00030005 0x00000042>,
+				<0x00030006 0x0000004c>,
+				<0x00030007 0x00000056>;
 			big-endian;
 			#thermal-sensor-cells = <1>;
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index f891ef6a3754..8956f860155f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -264,46 +264,46 @@ tmu: tmu@1f80000 {
 			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x70062>;
 			fsl,tmu-calibration =
 				/* Calibration data group 1 */
-				<0x00000000 0x00000023
-				0x00000001 0x0000002a
-				0x00000002 0x00000030
-				0x00000003 0x00000037
-				0x00000004 0x0000003d
-				0x00000005 0x00000044
-				0x00000006 0x0000004a
-				0x00000007 0x00000051
-				0x00000008 0x00000057
-				0x00000009 0x0000005e
-				0x0000000a 0x00000064
-				0x0000000b 0x0000006b
+				<0x00000000 0x00000023>,
+				<0x00000001 0x0000002a>,
+				<0x00000002 0x00000030>,
+				<0x00000003 0x00000037>,
+				<0x00000004 0x0000003d>,
+				<0x00000005 0x00000044>,
+				<0x00000006 0x0000004a>,
+				<0x00000007 0x00000051>,
+				<0x00000008 0x00000057>,
+				<0x00000009 0x0000005e>,
+				<0x0000000a 0x00000064>,
+				<0x0000000b 0x0000006b>,
 				/* Calibration data group 2 */
-				0x00010000 0x00000022
-				0x00010001 0x0000002a
-				0x00010002 0x00000032
-				0x00010003 0x0000003a
-				0x00010004 0x00000042
-				0x00010005 0x0000004a
-				0x00010006 0x00000052
-				0x00010007 0x0000005a
-				0x00010008 0x00000062
-				0x00010009 0x0000006a
+				<0x00010000 0x00000022>,
+				<0x00010001 0x0000002a>,
+				<0x00010002 0x00000032>,
+				<0x00010003 0x0000003a>,
+				<0x00010004 0x00000042>,
+				<0x00010005 0x0000004a>,
+				<0x00010006 0x00000052>,
+				<0x00010007 0x0000005a>,
+				<0x00010008 0x00000062>,
+				<0x00010009 0x0000006a>,
 				/* Calibration data group 3 */
-				0x00020000 0x00000021
-				0x00020001 0x0000002b
-				0x00020002 0x00000035
-				0x00020003 0x00000040
-				0x00020004 0x0000004a
-				0x00020005 0x00000054
-				0x00020006 0x0000005e
+				<0x00020000 0x00000021>,
+				<0x00020001 0x0000002b>,
+				<0x00020002 0x00000035>,
+				<0x00020003 0x00000040>,
+				<0x00020004 0x0000004a>,
+				<0x00020005 0x00000054>,
+				<0x00020006 0x0000005e>,
 				/* Calibration data group 4 */
-				0x00030000 0x00000010
-				0x00030001 0x0000001c
-				0x00030002 0x00000027
-				0x00030003 0x00000032
-				0x00030004 0x0000003e
-				0x00030005 0x00000049
-				0x00030006 0x00000054
-				0x00030007 0x00000060>;
+				<0x00030000 0x00000010>,
+				<0x00030001 0x0000001c>,
+				<0x00030002 0x00000027>,
+				<0x00030003 0x00000032>,
+				<0x00030004 0x0000003e>,
+				<0x00030005 0x00000049>,
+				<0x00030006 0x00000054>,
+				<0x00030007 0x00000060>;
 			little-endian;
 			#thermal-sensor-cells = <1>;
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 3cb9c21d2775..8cfe4ff9577c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -314,42 +314,43 @@ tmu: tmu@1f80000 {
 			reg = <0x0 0x1f80000 0x0 0x10000>;
 			interrupts = <0 23 0x4>;
 			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x30062>;
-			fsl,tmu-calibration = <0x00000000 0x00000026
-					       0x00000001 0x0000002d
-					       0x00000002 0x00000032
-					       0x00000003 0x00000039
-					       0x00000004 0x0000003f
-					       0x00000005 0x00000046
-					       0x00000006 0x0000004d
-					       0x00000007 0x00000054
-					       0x00000008 0x0000005a
-					       0x00000009 0x00000061
-					       0x0000000a 0x0000006a
-					       0x0000000b 0x00000071
-
-					       0x00010000 0x00000025
-					       0x00010001 0x0000002c
-					       0x00010002 0x00000035
-					       0x00010003 0x0000003d
-					       0x00010004 0x00000045
-					       0x00010005 0x0000004e
-					       0x00010006 0x00000057
-					       0x00010007 0x00000061
-					       0x00010008 0x0000006b
-					       0x00010009 0x00000076
-
-					       0x00020000 0x00000029
-					       0x00020001 0x00000033
-					       0x00020002 0x0000003d
-					       0x00020003 0x00000049
-					       0x00020004 0x00000056
-					       0x00020005 0x00000061
-					       0x00020006 0x0000006d
-
-					       0x00030000 0x00000021
-					       0x00030001 0x0000002a
-					       0x00030002 0x0000003c
-					       0x00030003 0x0000004e>;
+			fsl,tmu-calibration =
+					<0x00000000 0x00000026>,
+					<0x00000001 0x0000002d>,
+					<0x00000002 0x00000032>,
+					<0x00000003 0x00000039>,
+					<0x00000004 0x0000003f>,
+					<0x00000005 0x00000046>,
+					<0x00000006 0x0000004d>,
+					<0x00000007 0x00000054>,
+					<0x00000008 0x0000005a>,
+					<0x00000009 0x00000061>,
+					<0x0000000a 0x0000006a>,
+					<0x0000000b 0x00000071>,
+
+					<0x00010000 0x00000025>,
+					<0x00010001 0x0000002c>,
+					<0x00010002 0x00000035>,
+					<0x00010003 0x0000003d>,
+					<0x00010004 0x00000045>,
+					<0x00010005 0x0000004e>,
+					<0x00010006 0x00000057>,
+					<0x00010007 0x00000061>,
+					<0x00010008 0x0000006b>,
+					<0x00010009 0x00000076>,
+
+					<0x00020000 0x00000029>,
+					<0x00020001 0x00000033>,
+					<0x00020002 0x0000003d>,
+					<0x00020003 0x00000049>,
+					<0x00020004 0x00000056>,
+					<0x00020005 0x00000061>,
+					<0x00020006 0x0000006d>,
+
+					<0x00030000 0x00000021>,
+					<0x00030001 0x0000002a>,
+					<0x00030002 0x0000003c>,
+					<0x00030003 0x0000004e>;
 			little-endian;
 			#thermal-sensor-cells = <1>;
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index dc8661ebd1f6..634291ec6a89 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -703,9 +703,9 @@ tmu: tmu@1f80000 {
 			fsl,tmu-range = <0x800000e6 0x8001017d>;
 			fsl,tmu-calibration =
 				/* Calibration data group 1 */
-				<0x00000000 0x00000035
+				<0x00000000 0x00000035>,
 				/* Calibration data group 2 */
-				0x00000001 0x00000154>;
+				<0x00000001 0x00000154>;
 			little-endian;
 			#thermal-sensor-cells = <1>;
 		};
-- 
2.33.0

