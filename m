Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E98445FEB8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 14:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244599AbhK0NGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 08:06:40 -0500
Received: from ixit.cz ([94.230.151.217]:58522 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234018AbhK0NEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 08:04:39 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 1D0EB20064;
        Sat, 27 Nov 2021 14:01:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1638018082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TL5Z0v3ROjL1VN0kk5T9RzyinmEmWC4BFheAFJjFzNM=;
        b=PVuxMRDBWOG6/Pyw8AxqLdlVD6yNjLKsnza21sk3xFphm0ZWND+BJGuWPN8bcYGlTf7hT3
        eXif+8lNXdD0H102lV4eVwYsVpLTH9ORrIM1q3u6e6KSD/ftZeeVxg7eLaAdBnt4oc8Tb4
        SVHGHXNnL/O6Hi4+pmwPDJG5tNO+7UE=
From:   David Heidelberg <david@ixit.cz>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: imx8mq: fix the schema check errors for fsl,tmu-calibration
Date:   Sat, 27 Nov 2021 14:01:18 +0100
Message-Id: <20211127130118.37525-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsl,tmu-calibration is in u32-matrix. Use matching property syntax.
No functional changes. Fixes warnings as:
$ make dtbs_check
...
arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dt.yaml: tmu@30260000: fsl,tmu-calibration:0: Additional items are not allowed (1, 41, 2, 47, 3, 53, 4, 61, 5, 67, 6, 75, 7, 81, 8, 87, 9, 95, 10, 103, 11, 111, 65536, 27, 65537, 35, 65538, 43, 65539, 51, 65540, 59, 65541, 67, 65542, 75, 65543, 85, 65544, 93, 65545, 103, 65546, 112, 131072, 23, 131073, 35, 131074, 45, 131075, 55, 131076, 65, 131077, 75, 131078, 87, 131079, 99, 131080, 111, 196608, 21, 196609, 33, 196610, 45, 196611, 57, 196612, 69, 196613, 83, 196614, 95, 196615, 113 were unexpected)
        From schema: /home/ubuntu/projects_remote/linux/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
...

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 86 +++++++++++------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 95d8b95d6120..c90a8befdd95 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -457,49 +457,49 @@ tmu: tmu@30260000 {
 				clocks = <&clk IMX8MQ_CLK_TMU_ROOT>;
 				little-endian;
 				fsl,tmu-range = <0xb0000 0xa0026 0x80048 0x70061>;
-				fsl,tmu-calibration = <0x00000000 0x00000023
-						       0x00000001 0x00000029
-						       0x00000002 0x0000002f
-						       0x00000003 0x00000035
-						       0x00000004 0x0000003d
-						       0x00000005 0x00000043
-						       0x00000006 0x0000004b
-						       0x00000007 0x00000051
-						       0x00000008 0x00000057
-						       0x00000009 0x0000005f
-						       0x0000000a 0x00000067
-						       0x0000000b 0x0000006f
-
-						       0x00010000 0x0000001b
-						       0x00010001 0x00000023
-						       0x00010002 0x0000002b
-						       0x00010003 0x00000033
-						       0x00010004 0x0000003b
-						       0x00010005 0x00000043
-						       0x00010006 0x0000004b
-						       0x00010007 0x00000055
-						       0x00010008 0x0000005d
-						       0x00010009 0x00000067
-						       0x0001000a 0x00000070
-
-						       0x00020000 0x00000017
-						       0x00020001 0x00000023
-						       0x00020002 0x0000002d
-						       0x00020003 0x00000037
-						       0x00020004 0x00000041
-						       0x00020005 0x0000004b
-						       0x00020006 0x00000057
-						       0x00020007 0x00000063
-						       0x00020008 0x0000006f
-
-						       0x00030000 0x00000015
-						       0x00030001 0x00000021
-						       0x00030002 0x0000002d
-						       0x00030003 0x00000039
-						       0x00030004 0x00000045
-						       0x00030005 0x00000053
-						       0x00030006 0x0000005f
-						       0x00030007 0x00000071>;
+				fsl,tmu-calibration = <0x00000000 0x00000023>,
+						<0x00000001 0x00000029>,
+						<0x00000002 0x0000002f>,
+						<0x00000003 0x00000035>,
+						<0x00000004 0x0000003d>,
+						<0x00000005 0x00000043>,
+						<0x00000006 0x0000004b>,
+						<0x00000007 0x00000051>,
+						<0x00000008 0x00000057>,
+						<0x00000009 0x0000005f>,
+						<0x0000000a 0x00000067>,
+						<0x0000000b 0x0000006f>,
+
+						<0x00010000 0x0000001b>,
+						<0x00010001 0x00000023>,
+						<0x00010002 0x0000002b>,
+						<0x00010003 0x00000033>,
+						<0x00010004 0x0000003b>,
+						<0x00010005 0x00000043>,
+						<0x00010006 0x0000004b>,
+						<0x00010007 0x00000055>,
+						<0x00010008 0x0000005d>,
+						<0x00010009 0x00000067>,
+						<0x0001000a 0x00000070>,
+
+						<0x00020000 0x00000017>,
+						<0x00020001 0x00000023>,
+						<0x00020002 0x0000002d>,
+						<0x00020003 0x00000037>,
+						<0x00020004 0x00000041>,
+						<0x00020005 0x0000004b>,
+						<0x00020006 0x00000057>,
+						<0x00020007 0x00000063>,
+						<0x00020008 0x0000006f>,
+
+						<0x00030000 0x00000015>,
+						<0x00030001 0x00000021>,
+						<0x00030002 0x0000002d>,
+						<0x00030003 0x00000039>,
+						<0x00030004 0x00000045>,
+						<0x00030005 0x00000053>,
+						<0x00030006 0x0000005f>,
+						<0x00030007 0x00000071>;
 				#thermal-sensor-cells =  <1>;
 			};
 
-- 
2.33.0

