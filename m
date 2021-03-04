Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E43232DB9E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 22:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238035AbhCDVM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 16:12:59 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46534 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239126AbhCDVM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 16:12:29 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 124LBZUi025253;
        Thu, 4 Mar 2021 15:11:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614892295;
        bh=nX6GDXwjx+I2m6sehHm1RmXmRI2AW63pQiCh5/1UQWI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PSP7na397+pNY35GGbiVUOZl9Szl3YD2NbUo8/tQxEO1A4e9QXHvSWpAblPo1vuMZ
         7GSkV1yhEdTWrzoUypsl9OhpI0SxqTZewJvLuxOWLCEzNtJ8Gab2iktqMlzUjAkPFd
         C27jrjJToJLMBrjPVadT7tzbhkpUeLPvpYPUfPfQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 124LBZic010085
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Mar 2021 15:11:35 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 4 Mar
 2021 15:11:34 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 4 Mar 2021 15:11:34 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 124LBXah109232;
        Thu, 4 Mar 2021 15:11:33 -0600
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
CC:     <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2 4/4] arm64: dts: ti: k3-am642-sk: Add CPSW DT nodes
Date:   Thu, 4 Mar 2021 23:10:38 +0200
Message-ID: <20210304211038.12511-5-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210304211038.12511-1-grygorii.strashko@ti.com>
References: <20210304211038.12511-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vignesh Raghavendra <vigneshr@ti.com>

AM642 SK board has 2 CPSW3g ports connected through TI DP83867 PHYs. Add DT
entries for the same.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 73 ++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index aa6ca4c49153..397ed3b2e121 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/net/ti-dp83867.h>
 #include "k3-am642.dtsi"
 
 / {
@@ -90,6 +91,47 @@
 			AM64X_IOPAD(0x026c, PIN_INPUT_PULLUP, 0) /* (B19) I2C1_SDA */
 		>;
 	};
+
+	mdio1_pins_default: mdio1-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x01fc, PIN_OUTPUT, 4) /* (R2) PRG0_PRU1_GPO19.MDIO0_MDC */
+			AM64X_IOPAD(0x01f8, PIN_INPUT, 4) /* (P5) PRG0_PRU1_GPO18.MDIO0_MDIO */
+		>;
+	};
+
+	rgmii1_pins_default: rgmii1-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x011c, PIN_INPUT, 4) /* (AA13) PRG1_PRU1_GPO5.RGMII1_RD0 */
+			AM64X_IOPAD(0x0128, PIN_INPUT, 4) /* (U12) PRG1_PRU1_GPO8.RGMII1_RD1 */
+			AM64X_IOPAD(0x0150, PIN_INPUT, 4) /* (Y13) PRG1_PRU1_GPO18.RGMII1_RD2 */
+			AM64X_IOPAD(0x0154, PIN_INPUT, 4) /* (V12) PRG1_PRU1_GPO19.RGMII1_RD3 */
+			AM64X_IOPAD(0x00d8, PIN_INPUT, 4) /* (W13) PRG1_PRU0_GPO8.RGMII1_RXC */
+			AM64X_IOPAD(0x00cc, PIN_INPUT, 4) /* (V13) PRG1_PRU0_GPO5.RGMII1_RX_CTL */
+			AM64X_IOPAD(0x0124, PIN_OUTPUT, 4) /* (V15) PRG1_PRU1_GPO7.RGMII1_TD0 */
+			AM64X_IOPAD(0x012c, PIN_OUTPUT, 4) /* (V14) PRG1_PRU1_GPO9.RGMII1_TD1 */
+			AM64X_IOPAD(0x0130, PIN_OUTPUT, 4) /* (W14) PRG1_PRU1_GPO10.RGMII1_TD2 */
+			AM64X_IOPAD(0x014c, PIN_OUTPUT, 4) /* (AA14) PRG1_PRU1_GPO17.RGMII1_TD3 */
+			AM64X_IOPAD(0x00e0, PIN_OUTPUT, 4) /* (U14) PRG1_PRU0_GPO10.RGMII1_TXC */
+			AM64X_IOPAD(0x00dc, PIN_OUTPUT, 4) /* (U15) PRG1_PRU0_GPO9.RGMII1_TX_CTL */
+		>;
+	};
+
+       rgmii2_pins_default: rgmii2-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0108, PIN_INPUT, 4) /* (W11) PRG1_PRU1_GPO0.RGMII2_RD0 */
+			AM64X_IOPAD(0x010c, PIN_INPUT, 4) /* (V11) PRG1_PRU1_GPO1.RGMII2_RD1 */
+			AM64X_IOPAD(0x0110, PIN_INPUT, 4) /* (AA12) PRG1_PRU1_GPO2.RGMII2_RD2 */
+			AM64X_IOPAD(0x0114, PIN_INPUT, 4) /* (Y12) PRG1_PRU1_GPO3.RGMII2_RD3 */
+			AM64X_IOPAD(0x0120, PIN_INPUT, 4) /* (U11) PRG1_PRU1_GPO6.RGMII2_RXC */
+			AM64X_IOPAD(0x0118, PIN_INPUT, 4) /* (W12) PRG1_PRU1_GPO4.RGMII2_RX_CTL */
+			AM64X_IOPAD(0x0134, PIN_OUTPUT, 4) /* (AA10) PRG1_PRU1_GPO11.RGMII2_TD0 */
+			AM64X_IOPAD(0x0138, PIN_OUTPUT, 4) /* (V10) PRG1_PRU1_GPO12.RGMII2_TD1 */
+			AM64X_IOPAD(0x013c, PIN_OUTPUT, 4) /* (U10) PRG1_PRU1_GPO13.RGMII2_TD2 */
+			AM64X_IOPAD(0x0140, PIN_OUTPUT, 4) /* (AA11) PRG1_PRU1_GPO14.RGMII2_TD3 */
+			AM64X_IOPAD(0x0148, PIN_OUTPUT, 4) /* (Y10) PRG1_PRU1_GPO16.RGMII2_TXC */
+			AM64X_IOPAD(0x0144, PIN_OUTPUT, 4) /* (Y11) PRG1_PRU1_GPO15.RGMII2_TX_CTL */
+		>;
+	};
 };
 
 &mcu_uart0 {
@@ -171,3 +213,34 @@
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
 };
+
+&cpsw3g {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio1_pins_default
+		     &rgmii1_pins_default
+		     &rgmii2_pins_default>;
+};
+
+&cpsw_port1 {
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&cpsw3g_phy0>;
+};
+
+&cpsw_port2 {
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&cpsw3g_phy1>;
+};
+
+&cpsw3g_mdio {
+	cpsw3g_phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+	};
+
+	cpsw3g_phy1: ethernet-phy@1 {
+		reg = <1>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+	};
+};
-- 
2.17.1

