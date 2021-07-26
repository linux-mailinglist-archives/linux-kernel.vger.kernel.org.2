Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DC73D5727
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhGZJaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:30:17 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44554 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbhGZJaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:30:10 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16QAAYFu009406;
        Mon, 26 Jul 2021 05:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1627294234;
        bh=mzTqcij+0JJYV2iPtzt1yQW3PNay/eAPH+dtbDLIwSo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=zAJmNzmxG4j7nJDGK35Vvq9ZVdlEYVbbzEnG5SG33lTThT9BBSyJXeALWTysvF4Ee
         Lh8WNCQZfuZYjbTIY4++QtK8nYCyMR5AlabNj13xX5H/C9xY6bWpZGf+XCYflPEaBf
         ygZo9tL7Ti2PREehy75eRy2sJu+npbwmqaYVZ0Ic=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16QAAYON017343
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Jul 2021 05:10:34 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 26
 Jul 2021 05:10:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 26 Jul 2021 05:10:34 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16QAACRh067730;
        Mon, 26 Jul 2021 05:10:30 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH v2 4/6] arm64: dts: ti: k3-j721e-common-proc-board: Add support for mcu_mcan nodes
Date:   Mon, 26 Jul 2021 15:40:10 +0530
Message-ID: <20210726101012.26983-5-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210726101012.26983-1-a-govindraju@ti.com>
References: <20210726101012.26983-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

Add two MCAN nodes present on the common processor board and set a
maximum data rate of 5 Mbps. Disable all other nodes for now.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 .../dts/ti/k3-j721e-common-proc-board.dts     | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 8bd02d9e28ad..d40e282325c9 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -109,6 +109,25 @@
 			      "cpb-codec-scki",
 			      "cpb-codec-scki-48000", "cpb-codec-scki-44100";
 	};
+
+	transceiver1: can-phy0 {
+		compatible = "ti,tcan1043";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcu_mcan0_gpio_pins_default>;
+		standby-gpios = <&wkup_gpio0 54 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&wkup_gpio0 0 GPIO_ACTIVE_HIGH>;
+	};
+
+	transceiver2: can-phy1 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcu_mcan1_gpio_pins_default>;
+		standby-gpios = <&wkup_gpio0 2 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &main_pmx0 {
@@ -249,6 +268,33 @@
 			J721E_WKUP_IOPAD(0x0088, PIN_INPUT, 0) /* MCU_MDIO0_MDIO */
 		>;
 	};
+
+	mcu_mcan0_pins_default: mcu-mcan0-pins-default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xac, PIN_INPUT, 0) /* (C29) MCU_MCAN0_RX */
+			J721E_WKUP_IOPAD(0xa8, PIN_OUTPUT, 0) /* (D29) MCU_MCAN0_TX */
+		>;
+	};
+
+	mcu_mcan0_gpio_pins_default: mcu-mcan0-gpio-pins-default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xb0, PIN_INPUT, 7) /* (F26) WKUP_GPIO0_0 */
+			J721E_WKUP_IOPAD(0x98, PIN_INPUT, 7) /* (E28) MCU_SPI0_D1.WKUP_GPIO0_54 */
+		>;
+	};
+
+	mcu_mcan1_pins_default: mcu-mcan1-pins-default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xc4, PIN_INPUT, 0) /* (G24) WKUP_GPIO0_5.MCU_MCAN1_RX */
+			J721E_WKUP_IOPAD(0xc0, PIN_OUTPUT, 0) /* (G25) WKUP_GPIO0_4.MCU_MCAN1_TX */
+		>;
+	};
+
+	mcu_mcan1_gpio_pins_default: mcu-mcan1-gpio-pins-default {
+		pinctrl-single,pins = <
+			J721E_WKUP_IOPAD(0xb8, PIN_INPUT, 7) /* (F28) WKUP_GPIO0_2 */
+		>;
+	};
 };
 
 &wkup_uart0 {
@@ -770,3 +816,73 @@
 &icssg1_mdio {
 	status = "disabled";
 };
+
+&mcu_mcan0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan0_pins_default>;
+	phys = <&transceiver1>;
+};
+
+&mcu_mcan1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcu_mcan1_pins_default>;
+	phys = <&transceiver2>;
+};
+
+&main_mcan0 {
+	status = "disabled";
+};
+
+&main_mcan1 {
+	status = "disabled";
+};
+
+&main_mcan2 {
+	status = "disabled";
+};
+
+&main_mcan3 {
+	status = "disabled";
+};
+
+&main_mcan4 {
+	status = "disabled";
+};
+
+&main_mcan5 {
+	status = "disabled";
+};
+
+&main_mcan6 {
+	status = "disabled";
+};
+
+&main_mcan7 {
+	status = "disabled";
+};
+
+&main_mcan8 {
+	status = "disabled";
+};
+
+&main_mcan9 {
+	status = "disabled";
+};
+
+&main_mcan10 {
+	status = "disabled";
+};
+
+&main_mcan11 {
+	status = "disabled";
+};
+
+&main_mcan12 {
+	status = "disabled";
+};
+
+&main_mcan13 {
+	status = "disabled";
+};
-- 
2.17.1

