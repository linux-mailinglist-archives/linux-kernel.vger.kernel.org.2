Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B049733260F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhCINFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:05:46 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34784 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhCINFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:05:32 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 129D5PAI083779;
        Tue, 9 Mar 2021 07:05:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615295125;
        bh=0l+zHYos4lzrG1+DYj78zQ0HfZRU4gyc8kUAOuiWgns=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=k+qmuLoyoK8M6leqybnn3+fZlX4SkAVLltIOU2SBP1Fm9Rewy854q38zofglYpeeU
         zLpDAaMK31bQI4ZRwvuZ5gEKRUF7oQAY3frfUgglFsUxdpiAa0gf/c34vIgmoQ9tkM
         m864L+7sXQdDDkhWgSpaXd6uczWaS93nNK7jjwzg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 129D5PdP122499
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Mar 2021 07:05:25 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 9 Mar
 2021 07:05:25 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 9 Mar 2021 07:05:25 -0600
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 129D5I5x094746;
        Tue, 9 Mar 2021 07:05:22 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am64-evm/sk: Add OSPI flash DT node
Date:   Tue, 9 Mar 2021 18:35:14 +0530
Message-ID: <20210309130514.11740-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309130514.11740-1-vigneshr@ti.com>
References: <20210309130514.11740-1-vigneshr@ti.com>
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
---

Bootlog:

SK: https://pastebin.ubuntu.com/p/gvxg7cFrXH/
EVM: https://pastebin.ubuntu.com/p/jb39GqkB78/

 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 36 +++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts  | 36 +++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 1f1787750fef..7dd8e94b108d 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -133,6 +133,22 @@ AM64X_IOPAD(0x0268, PIN_INPUT_PULLUP, 0) /* (C18) I2C1_SCL */
 			AM64X_IOPAD(0x026c, PIN_INPUT_PULLUP, 0) /* (B19) I2C1_SDA */
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
@@ -244,3 +260,23 @@ &sdhci1 {
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
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
index aa6ca4c49153..fc27470fc083 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -90,6 +90,22 @@ AM64X_IOPAD(0x0268, PIN_INPUT_PULLUP, 0) /* (C18) I2C1_SCL */
 			AM64X_IOPAD(0x026c, PIN_INPUT_PULLUP, 0) /* (B19) I2C1_SDA */
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
@@ -171,3 +187,23 @@ &sdhci1 {
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
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
2.30.1

