Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB49C33E876
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 05:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhCQEay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 00:30:54 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46696 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhCQEaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 00:30:24 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12H4UGR9109402;
        Tue, 16 Mar 2021 23:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615955416;
        bh=l+wsrM9H7Adz9GUIOenRJfVY017GOX0ZXQtvPKSzAKU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=o2eUzO6o9wfTb1JyFONNzuywq1F4fkXj7rj/W1YqOhwwvJZcrTYl3WV2p+qnKDvD3
         q+DclC+G0bM/7G+RgwVEQppqIWMnV9/wZPiSccNqwr5OEAmcCqmmgxL0nPGtDPBNeu
         zij6m9+SdAHiUhnU5f0pSBer4zeBRyK4+rn3xsOQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12H4UGxe104728
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Mar 2021 23:30:16 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 16
 Mar 2021 23:30:15 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 16 Mar 2021 23:30:15 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12H4U8bu072628;
        Tue, 16 Mar 2021 23:30:13 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] arm64: dts: ti: k3-am64-main: Add DT node for USB subsystem
Date:   Wed, 17 Mar 2021 10:00:05 +0530
Message-ID: <20210317043007.18272-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210317043007.18272-1-a-govindraju@ti.com>
References: <20210317043007.18272-1-a-govindraju@ti.com>
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
index 0cf727e3d1e2..7e7997e3adff 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -491,4 +491,34 @@
 		ti,cpts-periodic-outputs = <6>;
 		ti,cpts-ext-ts-inputs = <8>;
 	};
+
+	usbss0: cdns-usb@f900000{
+		compatible = "ti,am64-usb";
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

