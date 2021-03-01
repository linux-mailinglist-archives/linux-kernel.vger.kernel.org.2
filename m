Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B9D327766
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 07:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhCAGIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 01:08:44 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47282 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbhCAGHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 01:07:41 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12165UBb129615;
        Mon, 1 Mar 2021 00:05:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614578730;
        bh=eXn3m1eYJsCAwe2CGJZNEBs+NH+JX/pD6w/lNbuQh6Y=;
        h=From:To:CC:Subject:Date;
        b=PWuH4Ynn9c3B/GCH55jzXA51bp9Bixjg8ObyTd5aWFQr+QNPuei/c2/3Ty7s3y2yJ
         mhSZLbB/T1KZJVn+y4kU5QvHumgasA+UNOX71T4jzerxftWuMaVwFoZ1DSYXB3s6jG
         HKo5hmyJ10FfMxEenBCU7JCblDKgiUg1ZRbs1Zgs=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12165U4x022384
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Mar 2021 00:05:30 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 1 Mar
 2021 00:05:30 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 1 Mar 2021 00:05:30 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12165LeV011507;
        Mon, 1 Mar 2021 00:05:22 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-am642-evm: Add support for SPI EEPROM
Date:   Mon, 1 Mar 2021 11:35:18 +0530
Message-ID: <20210301060518.19550-1-a-govindraju@ti.com>
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
---

This patch depends on,
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210301055109.17626-3-a-govindraju@ti.com/

 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index bfd849a29655..bc5bd7f896ab 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -139,6 +139,15 @@
 			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* (E19) USB0_DRVVBUS */
 		>;
 	};
+
+	main_spi0_pins_default: main-spi0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0210, PIN_INPUT, 0) /* (D13) SPI0_CLK */
+			AM64X_IOPAD(0x0208, PIN_OUTPUT, 0) /* (D12) SPI0_CS0 */
+			AM64X_IOPAD(0x0214, PIN_OUTPUT, 0) /* (A13) SPI0_D0 */
+			AM64X_IOPAD(0x0218, PIN_INPUT, 0) /* (A14) SPI0_D1 */
+		>;
+	};
 };
 
 &main_uart0 {
@@ -245,6 +254,19 @@
 	pinctrl-0 = <&main_usb0_pins_default>;
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

