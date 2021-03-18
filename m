Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B153404B3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhCRLfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:35:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41602 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhCRLez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:34:55 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12IBYm2J052924;
        Thu, 18 Mar 2021 06:34:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616067288;
        bh=pQp9TdiWFXFmbvvfkvhvwWm/3WqsaJmINLKWXONFnxE=;
        h=From:To:CC:Subject:Date;
        b=PIYPgAP0X3td1IeDQEBS9vJVP+XqEHoROr6zrwxIXxdWJE21rqVX7+ljRAzWeo8F/
         amdUl42ekD9IMrVyf1ggyJolIOYOxuTmqldAPmlDDcQMgsWVvfZTjYlPMXQiaaoS4A
         9R+JEsBT0SxoQG/RYU+XBGFNkhYZoAVpfku8BASQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12IBYmW4092348
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Mar 2021 06:34:48 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 18
 Mar 2021 06:34:48 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 18 Mar 2021 06:34:48 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12IBYjtV077067;
        Thu, 18 Mar 2021 06:34:46 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [RESEND PATCH] arm64: dts: ti: k3-am64-main: Add ADC nodes
Date:   Thu, 18 Mar 2021 17:04:43 +0530
Message-ID: <20210318113443.20036-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM64 SoC has a single ADC IP with 8 channels. Add DT node for the same.

Default usecase is to control ADC from non Linux core on the system on
AM642 GP EVM, therefore mark the node as reserved in k3-am642-evm.dts
file. ADC lines are not pinned out on AM642 SK board, therefore disable
the node in k3-am642-sk.dts file.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
---

Rebase onto latest k3-dts-next:
v1: lore.kernel.org/r/20210309130708.12391-1-vigneshr@ti.com

Do note that dtbs_check warns about having the bindings converted to
YAML which is in my future TODO list.

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 17 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  5 +++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   |  4 ++++
 3 files changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 7e7997e3adff..dc852f63d1a2 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -521,4 +521,21 @@ usb0: usb@f400000{
 			dr_mode = "otg";
 		};
 	};
+
+	tscadc0: tscadc@28001000 {
+		compatible = "ti,am654-tscadc", "ti,am3359-tscadc";
+		reg = <0x00 0x28001000 0x00 0x1000>;
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 0 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 0 0>;
+		assigned-clocks = <&k3_clks 0 0>;
+		assigned-clock-parents = <&k3_clks 0 3>;
+		assigned-clock-rates = <60000000>;
+		clock-names = "adc_tsc_fck";
+
+		adc {
+			#io-channel-cells = <1>;
+			compatible = "ti,am654-adc", "ti,am3359-adc";
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 1365e3164294..6331fd426157 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -377,3 +377,8 @@ cpsw3g_phy0: ethernet-phy@0 {
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 	};
 };
+
+&tscadc0 {
+	/* ADC is reserved for R5 usage */
+	status = "reserved";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 397ed3b2e121..8f9b1078b7b5 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -244,3 +244,7 @@ cpsw3g_phy1: ethernet-phy@1 {
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 	};
 };
+
+&tscadc0 {
+	status = "disabled";
+};
-- 
2.31.0

