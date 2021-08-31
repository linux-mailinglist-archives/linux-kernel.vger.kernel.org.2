Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92DD3FC86E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbhHaNlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:41:22 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:41343 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238242AbhHaNlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:41:19 -0400
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DF12B22249;
        Tue, 31 Aug 2021 15:40:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1630417221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SgCobNgXxotZPKPaZcWVffPDLAUuN5xHWBJboyh24ZU=;
        b=P1+wy6Z9P3uFHM7qinmcwniYzx4WIL5jICLzhuj4pOKstCWCABjkQiWqqKbYuoUBtq3STB
        y36G+Jy88Z2sv4vfb1K4G/BbKe4xupvp4eJAGRIz/Y1Vhtz0WlY3xQ8BDgnJN0UF+7FfSe
        7HTEP4zOwXCT0cYAgR64PyHHe0wXcpk=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 2/7] arm64: dts: ls1028a: move Mali DP500 node into /soc
Date:   Tue, 31 Aug 2021 15:40:08 +0200
Message-Id: <20210831134013.1625527-3-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210831134013.1625527-1-michael@walle.cc>
References: <20210831134013.1625527-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move it inside the /soc subnode because it is part of the CCSR space.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 41 ++++++++++---------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 9a65a7118faa..92e4f004c1c2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -793,6 +793,27 @@ QORIQ_CLK_PLL_DIV(16)>,
 			clock-names = "wdog_clk", "apb_pclk";
 		};
 
+		malidp0: display@f080000 {
+			compatible = "arm,mali-dp500";
+			reg = <0x0 0xf080000 0x0 0x10000>;
+			interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 223 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "DE", "SE";
+			clocks = <&dpclk>,
+				 <&clockgen QORIQ_CLK_HWACCEL 2>,
+				 <&clockgen QORIQ_CLK_HWACCEL 2>,
+				 <&clockgen QORIQ_CLK_HWACCEL 2>;
+			clock-names = "pxlclk", "mclk", "aclk", "pclk";
+			arm,malidp-output-port-lines = /bits/ 8 <8 8 8>;
+			arm,malidp-arqos-value = <0xd000d000>;
+
+			port {
+				dpi0_out: endpoint {
+
+				};
+			};
+		};
+
 		sai1: audio-controller@f100000 {
 			#sound-dai-cells = <0>;
 			compatible = "fsl,vf610-sai";
@@ -1139,24 +1160,4 @@ ftm_alarm0: timer@2800000 {
 		};
 	};
 
-	malidp0: display@f080000 {
-		compatible = "arm,mali-dp500";
-		reg = <0x0 0xf080000 0x0 0x10000>;
-		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 223 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "DE", "SE";
-		clocks = <&dpclk>,
-			 <&clockgen QORIQ_CLK_HWACCEL 2>,
-			 <&clockgen QORIQ_CLK_HWACCEL 2>,
-			 <&clockgen QORIQ_CLK_HWACCEL 2>;
-		clock-names = "pxlclk", "mclk", "aclk", "pclk";
-		arm,malidp-output-port-lines = /bits/ 8 <8 8 8>;
-		arm,malidp-arqos-value = <0xd000d000>;
-
-		port {
-			dp0_out: endpoint {
-
-			};
-		};
-	};
 };
-- 
2.30.2

