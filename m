Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2892B33B200
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhCOMDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:03:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40964 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhCOMCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:02:41 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12FC25qg102746;
        Mon, 15 Mar 2021 07:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615809725;
        bh=zip3QNfLNninBOCzv/e4IC8dXyImpfIC1+J6usKYJY4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eJvPkEgSyohoMZwPlQJbTArmivoNQr0+OtwpBldDzVuow9ZFwP9RRWleeBhFGcXCH
         y3L5ez5FqrnWe1eJdBjMtpqxaIAsxn7jtUGgoKEhp/IXSxPaNF/wmLccEPeZTVXAjT
         gsSg7Ove6wuU+il3hijqDSxC/q/VhVt/Q6jEkPKQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12FC255Q032756
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Mar 2021 07:02:05 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 15
 Mar 2021 07:02:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 15 Mar 2021 07:02:04 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12FC1xvK088838;
        Mon, 15 Mar 2021 07:02:02 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [RESEN DPATCH 2/2] arm64: dts: ti: k3-am642-evm/sk: Add OSPI flash DT node
Date:   Mon, 15 Mar 2021 17:31:49 +0530
Message-ID: <20210315120149.10606-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315120149.10606-1-vigneshr@ti.com>
References: <20210315120149.10606-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both AM64 EVM and SK have a 512Mb S28HS512T Octal SPI NOR flash.
Add DT node for the same.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---

Boot logs:
https://pastebin.ubuntu.com/p/mNG7ryv3w6/
https://pastebin.ubuntu.com/p/TZf9ZwSqqM/

Resend:
Rebase onto latest -next

There is a warning related to dtbs_check which is because
spi-cadence-quadspi.txt is not converted to YAML.

v1: lore.kernel.org/r/20210309130514.11740-2-vigneshr@ti.com

 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 36 +++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts  | 36 +++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 188f0eb687fb..2f187555d04a 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -210,6 +210,22 @@ AM64X_IOPAD(0x0148, PIN_OUTPUT, 4) /* (Y10) PRG1_PRU1_GPO16.RGMII2_TXC */
 			AM64X_IOPAD(0x0144, PIN_OUTPUT, 4) /* (Y11) PRG1_PRU1_GPO15.RGMII2_TX_CTL */
 		>;
 	};
+
+	ospi0_pins_default: ospi0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0000, PIN_OUTPUT, 0) /* (N20) OSPI0_CLK */
+			AM64X_IOPAD(0x002c, PIN_OUTPUT, 0) /* (L19) OSPI0_CSn0 */
+			AM64X_IOPAD(0x000c, PIN_INPUT, 0) /* (M19) OSPI0_D0 */
+			AM64X_IOPAD(0x0010, PIN_INPUT, 0) /* (M18) OSPI0_D1 */
+			AM64X_IOPAD(0x0014, PIN_INPUT, 0) /* (M20) OSPI0_D2 */
+			AM64X_IOPAD(0x0018, PIN_INPUT, 0) /* (M21) OSPI0_D3 */
+			AM64X_IOPAD(0x001c, PIN_INPUT, 0) /* (P21) OSPI0_D4 */
+			AM64X_IOPAD(0x0020, PIN_INPUT, 0) /* (P20) OSPI0_D5 */
+			AM64X_IOPAD(0x0024, PIN_INPUT, 0) /* (N18) OSPI0_D6 */
+			AM64X_IOPAD(0x0028, PIN_INPUT, 0) /* (M17) OSPI0_D7 */
+			AM64X_IOPAD(0x0008, PIN_INPUT, 0) /* (N19) OSPI0_DQS */
+		>;
+	};
 };
 
 &main_uart0 {
@@ -364,3 +380,23 @@ &tscadc0 {
 	/* ADC is reserved for R5 usage */
 	status = "reserved";
 };
+
+&ospi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ospi0_pins_default>;
+
+	flash@0{
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+		spi-max-frequency = <25000000>;
+		cdns,tshsl-ns = <60>;
+		cdns,tsd2d-ns = <60>;
+		cdns,tchsh-ns = <60>;
+		cdns,tslch-ns = <60>;
+		cdns,read-delay = <4>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 8f9b1078b7b5..3a5bee4b0b0c 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -132,6 +132,22 @@ AM64X_IOPAD(0x0148, PIN_OUTPUT, 4) /* (Y10) PRG1_PRU1_GPO16.RGMII2_TXC */
 			AM64X_IOPAD(0x0144, PIN_OUTPUT, 4) /* (Y11) PRG1_PRU1_GPO15.RGMII2_TX_CTL */
 		>;
 	};
+
+	ospi0_pins_default: ospi0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0000, PIN_OUTPUT, 0) /* (N20) OSPI0_CLK */
+			AM64X_IOPAD(0x002c, PIN_OUTPUT, 0) /* (L19) OSPI0_CSn0 */
+			AM64X_IOPAD(0x000c, PIN_INPUT, 0) /* (M19) OSPI0_D0 */
+			AM64X_IOPAD(0x0010, PIN_INPUT, 0) /* (M18) OSPI0_D1 */
+			AM64X_IOPAD(0x0014, PIN_INPUT, 0) /* (M20) OSPI0_D2 */
+			AM64X_IOPAD(0x0018, PIN_INPUT, 0) /* (M21) OSPI0_D3 */
+			AM64X_IOPAD(0x001c, PIN_INPUT, 0) /* (P21) OSPI0_D4 */
+			AM64X_IOPAD(0x0020, PIN_INPUT, 0) /* (P20) OSPI0_D5 */
+			AM64X_IOPAD(0x0024, PIN_INPUT, 0) /* (N18) OSPI0_D6 */
+			AM64X_IOPAD(0x0028, PIN_INPUT, 0) /* (M17) OSPI0_D7 */
+			AM64X_IOPAD(0x0008, PIN_INPUT, 0) /* (N19) OSPI0_DQS */
+		>;
+	};
 };
 
 &mcu_uart0 {
@@ -248,3 +264,23 @@ cpsw3g_phy1: ethernet-phy@1 {
 &tscadc0 {
 	status = "disabled";
 };
+
+&ospi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ospi0_pins_default>;
+
+	flash@0{
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+		spi-max-frequency = <25000000>;
+		cdns,tshsl-ns = <60>;
+		cdns,tsd2d-ns = <60>;
+		cdns,tchsh-ns = <60>;
+		cdns,tslch-ns = <60>;
+		cdns,read-delay = <4>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
-- 
2.30.2

