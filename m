Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BDF332BE4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 17:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhCIQX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 11:23:56 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56484 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhCIQX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:23:27 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 129GNLvF088051;
        Tue, 9 Mar 2021 10:23:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615307001;
        bh=gq/gKxks/K1Z+HGE0yrIR+xQT1DOWcXca+Z+vr1I7ug=;
        h=From:To:CC:Subject:Date;
        b=EG5KUFMF51vmI+1ikUmutQSADJlrL97g41jcDX0QesTF1oNjROHVOOS+sJFjRFesq
         LPHtSOdGKClqeaSp9qg4RAIlKp5EyIlE0ah8Uv/AyHCPkJ7g1UEWlhuAHUQIGKR6h/
         V4iPacGq7BM8QzJ3DBUcCv7/TDMMOwLz/YacFpiw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 129GNLn8091098
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Mar 2021 10:23:21 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 9 Mar
 2021 10:23:21 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 9 Mar 2021 10:23:21 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 129GNHr7076612;
        Tue, 9 Mar 2021 10:23:18 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] arm64: dts: ti: k3-am642-evm: Add support for SPI EEPROM
Date:   Tue, 9 Mar 2021 21:53:15 +0530
Message-ID: <20210309162315.22743-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinmux details and device tree node for the EEPROM attached to SPI0
module in main domain.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
---

Link to test log,
https://pastebin.ubuntu.com/p/jDgvyhF9BQ/

Changes since v1:
- Removed the dependency on USB support patches
- Picked up reviewed-by
- Added test logs for SPI EEPROM

 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 1f1787750fef..f5a8c5c4c8c3 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -127,6 +127,15 @@
 		>;
 	};
 
+	main_spi0_pins_default: main-spi0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0210, PIN_INPUT, 0) /* (D13) SPI0_CLK */
+			AM64X_IOPAD(0x0208, PIN_OUTPUT, 0) /* (D12) SPI0_CS0 */
+			AM64X_IOPAD(0x0214, PIN_OUTPUT, 0) /* (A13) SPI0_D0 */
+			AM64X_IOPAD(0x0218, PIN_INPUT, 0) /* (A14) SPI0_D1 */
+		>;
+	};
+
 	main_i2c1_pins_default: main-i2c1-pins-default {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0268, PIN_INPUT_PULLUP, 0) /* (C18) I2C1_SCL */
@@ -227,6 +236,19 @@
 	status = "disabled";
 };
 
+&main_spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_spi0_pins_default>;
+	ti,pindir-d0-out-d1-in = <1>;
+	eeprom@0 {
+		compatible = "microchip,93lc46b";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		spi-cs-high;
+		data-size = <16>;
+	};
+};
+
 &sdhci0 {
 	/* emmc */
 	bus-width = <8>;
-- 
2.17.1

