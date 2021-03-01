Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B31327743
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 06:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhCAFwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 00:52:24 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58304 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbhCAFwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 00:52:16 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1215pSKR036765;
        Sun, 28 Feb 2021 23:51:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614577888;
        bh=jUuJrezMry9hd404HvvG+ToYDksIljqwEy6ABO1jNp4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FJjdeBHF32Dw5EPJQSK36I8e1Y1zsBBAWHNjeE91PzsMhVaEcdBpOl6bElMwsQ0aj
         ND+SkP8izqG5ZlVbXvmuWSuR3H9W/yn7B81fElFfcEeMQslIKE2xxh0JS3srGhNQkH
         zY4wd19W+h3Vd4zjEs8pfi7nI+QEiMpihVTIwfTQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1215pSc9027674
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 28 Feb 2021 23:51:28 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 28
 Feb 2021 23:51:28 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 28 Feb 2021 23:51:28 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1215pCDN115264;
        Sun, 28 Feb 2021 23:51:22 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am64-main: Add DT node for USB subsystem
Date:   Mon, 1 Mar 2021 11:21:08 +0530
Message-ID: <20210301055109.17626-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210301055109.17626-1-a-govindraju@ti.com>
References: <20210301055109.17626-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT node for the single USB subsystem in main dtsi file.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Acked-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 5f85950daef7..a36ebddf3a4c 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -402,4 +402,34 @@
 		ti,otap-del-sel-ddr50 = <0x9>;
 		ti,clkbuf-sel = <0x7>;
 	};
+
+	usbss0: cdns-usb@f900000{
+		compatible = "ti,am64-usb", "ti,j721e-usb";
+		reg = <0x00 0xf900000 0x00 0x100>;
+		power-domains = <&k3_pds 161 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 161 9>, <&k3_clks 161 1>;
+		clock-names = "ref", "lpm";
+		assigned-clocks = <&k3_clks 161 9>; /* USB2_REFCLK */
+		assigned-clock-parents = <&k3_clks 161 10>; /* HF0SC0 */
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		usb0: usb@f400000{
+			compatible = "cdns,usb3";
+			reg = <0x00 0xf400000 0x00 0x10000>,
+			      <0x00 0xf410000 0x00 0x10000>,
+			      <0x00 0xf420000 0x00 0x10000>;
+			reg-names = "otg",
+				    "xhci",
+				    "dev";
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
+				     <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>, /* irq.6 */
+				     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>; /* otgirq */
+			interrupt-names = "host",
+					  "peripheral",
+					  "otg";
+			maximum-speed = "super-speed";
+			dr_mode = "otg";
+		};
+	};
 };
-- 
2.17.1

