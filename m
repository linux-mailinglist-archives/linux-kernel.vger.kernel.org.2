Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B33F458FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 14:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239485AbhKVNrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 08:47:13 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59200 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239559AbhKVNpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:45:44 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AMDgWbl101506;
        Mon, 22 Nov 2021 07:42:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637588552;
        bh=gwmy1g7upSs451Tvms0rbChOLQpMToAcL1SFZbrXNh0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VrGtK/6MjhvEpbcleg11dFmPK7mavHfGboSMjVuxhGs0cl4Cpb6Q6vhVYD0wvlmom
         mve3xuRFO54BdDlSZDa3r+JfsvFBAsXaK52cRbHbGpTKJMO7P3e8OLUjtq1M5ludNU
         KrStlsJoDQL1cXNC0qEUIYSHbsM9NNWld/0E3bSI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AMDgWI7050757
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Nov 2021 07:42:32 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 22
 Nov 2021 07:42:32 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 22 Nov 2021 07:42:32 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AMDg04x023508;
        Mon, 22 Nov 2021 07:42:29 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 6/6] arm64: dts: ti: k3-am642-evm/sk: Add support for main domain mcan nodes in EVM and disable them on SK
Date:   Mon, 22 Nov 2021 19:11:58 +0530
Message-ID: <20211122134159.29936-7-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211122134159.29936-1-a-govindraju@ti.com>
References: <20211122134159.29936-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM642 EVM has two CAN connecters brought out from the two MCAN instances in
the main domain through transceivers. Add device tree nodes for
transceivers and set the required properties in the mcan device tree nodes,
in EVM device tree file.

On AM642 SK there are no connectors brought out for CAN. Therefore, disable
the mcan device tree nodes in the SK device tree file.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 40 +++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts  |  8 +++++
 2 files changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 6726c4c7c28c..e94ae178b1ae 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -184,6 +184,20 @@
 			};
 		};
 	};
+
+	transceiver1: can-phy0 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		standby-gpios = <&exp1 8 GPIO_ACTIVE_HIGH>;
+	};
+
+	transceiver2: can-phy1 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		standby-gpios = <&exp1 9 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &main_pmx0 {
@@ -294,6 +308,20 @@
 			AM64X_IOPAD(0x0270, PIN_INPUT, 0) /* (D18) ECAP0_IN_APWM_OUT */
 		>;
 	};
+
+	main_mcan0_pins_default: main-mcan0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0254, PIN_INPUT, 0) /* (B17) MCAN0_RX */
+			AM64X_IOPAD(0x0250, PIN_OUTPUT, 0) /* (A17) MCAN0_TX */
+		>;
+	};
+
+	main_mcan1_pins_default: main-mcan1-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x025c, PIN_INPUT, 0) /* (D17) MCAN1_RX */
+			AM64X_IOPAD(0x0258, PIN_OUTPUT, 0) /* (C17) MCAN1_TX */
+		>;
+	};
 };
 
 &main_uart0 {
@@ -638,3 +666,15 @@
 &icssg1_mdio {
 	status = "disabled";
 };
+
+&main_mcan0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan0_pins_default>;
+	phys = <&transceiver1>;
+};
+
+&main_mcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcan1_pins_default>;
+	phys = <&transceiver2>;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 6b04745147be..a9785bec12df 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -525,3 +525,11 @@
 &icssg1_mdio {
 	status = "disabled";
 };
+
+&main_mcan0 {
+	status = "disabled";
+};
+
+&main_mcan1 {
+	status = "disabled";
+};
-- 
2.17.1

