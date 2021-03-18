Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978AD3404C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhCRLiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:38:20 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42014 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhCRLiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:38:11 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12IBc52q053681;
        Thu, 18 Mar 2021 06:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616067485;
        bh=J3s6DtR9sFJKJTrnpAKz400/EW5dC5i6UaSvSUZeJgQ=;
        h=From:To:CC:Subject:Date;
        b=EcKwIfAgVODJ1SfxSX+f+ryFX0fp6JXGrH3unWzl87Hx6qIO+qcxJlJ3Dx791Yx7L
         GZKB7JBacfgo821EfsmH9h2fYPXUf33U8fm8JGK7pyL/d2MTzHkax278mBeZDwT+kl
         o139kJRUBJ44jEK1mUnXZYnNzVZld/HP99HAWXBg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12IBc5TZ001329
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Mar 2021 06:38:05 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 18
 Mar 2021 06:38:05 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 18 Mar 2021 06:38:05 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12IBc22H033135;
        Thu, 18 Mar 2021 06:38:02 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [RESEND PATCH v2 1/2] arm64: dts: ti: k3-am64-main: Add OSPI node
Date:   Thu, 18 Mar 2021 17:07:56 +0530
Message-ID: <20210318113757.21012-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM64 SoC has a single Octal SPI (OSPI) instance under Flash SubSystem
(FSS).  Add DT entry for the same.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---

Rebase onto latest k3-dts-next

v1: lore.kernel.org/r/20210309130514.11740-1-vigneshr@ti.com

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index dc852f63d1a2..a03b66456062 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -538,4 +538,29 @@ adc {
 			compatible = "ti,am654-adc", "ti,am3359-adc";
 		};
 	};
+
+	fss: bus@fc00000 {
+		compatible = "simple-bus";
+		reg = <0x00 0x0fc00000 0x00 0x70000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ospi0: spi@fc40000 {
+			compatible = "ti,am654-ospi";
+			reg = <0x00 0x0fc40000 0x00 0x100>,
+			      <0x05 0x00000000 0x01 0x00000000>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x0>;
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			clocks = <&k3_clks 75 6>;
+			assigned-clocks = <&k3_clks 75 6>;
+			assigned-clock-parents = <&k3_clks 75 7>;
+			assigned-clock-rates = <166666666>;
+			power-domains = <&k3_pds 75 TI_SCI_PD_EXCLUSIVE>;
+		};
+	};
 };
-- 
2.31.0

