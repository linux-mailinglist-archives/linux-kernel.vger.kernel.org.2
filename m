Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FC244CC9A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 23:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhKJWZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 17:25:54 -0500
Received: from inva021.nxp.com ([92.121.34.21]:56186 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233592AbhKJWZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 17:25:25 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 322C920119D;
        Wed, 10 Nov 2021 23:22:36 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E82EE2010FC;
        Wed, 10 Nov 2021 23:22:35 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 0AA9940BF1;
        Wed, 10 Nov 2021 15:22:35 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 05/11] arm64: dts: lx2160a: add optee-tz node
Date:   Wed, 10 Nov 2021 16:21:54 -0600
Message-Id: <20211110222200.6780-6-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211110222200.6780-1-leoyang.li@nxp.com>
References: <20211110222200.6780-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Gupta <pankaj.gupta@nxp.com>

Disabled by default in SoC dtsi and enables in board dts files.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
index d858d9c8b583..8354af0b31e3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
@@ -156,6 +156,10 @@ rtc@51 {
 	};
 };
 
+&optee {
+	status = "okay";
+};
+
 &sata0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 0ec41838e54e..0c44b3cbef77 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -219,6 +219,10 @@ rtc@51 {
 	};
 };
 
+&optee {
+	status = "okay";
+};
+
 &pcs_mdio3 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 51c4f61007cd..5d1f84f4de29 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1751,4 +1751,12 @@ dpmac18: ethernet@12 {
 			};
 		};
 	};
+
+	firmware {
+		optee: optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+			status = "disabled";
+		};
+	};
 };
-- 
2.25.1

