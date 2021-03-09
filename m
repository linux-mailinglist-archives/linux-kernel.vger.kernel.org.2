Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A2B332626
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhCINHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:07:53 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33538 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhCINHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:07:42 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 129D7Z7c006430;
        Tue, 9 Mar 2021 07:07:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615295255;
        bh=H4KLeRcY8FYKwED6Dp8oQb+JI73HrNZNMg+0rhkPUEg=;
        h=From:To:CC:Subject:Date;
        b=I1ExK8yrkG7qJ0zpY2RYoVFSJwAKWSwmBVqNwPvFuvH9mHg2GCc3X/cBN9OcbCCtg
         AWBFT3I0lRzYEJ9CjSDzzaadRSzpWTszX8Hs7MtsR7lKDRJiA6reQf4lSe6i6oZmcI
         9VN/qnPOusp577VkOg5PX4JE44VjsrKwfKFbh5t0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 129D7ZUn125097
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Mar 2021 07:07:35 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 9 Mar
 2021 07:07:35 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 9 Mar 2021 07:07:35 -0600
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 129D7Vgb098032;
        Tue, 9 Mar 2021 07:07:32 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am64-main: Add ADC nodes
Date:   Tue, 9 Mar 2021 18:37:08 +0530
Message-ID: <20210309130708.12391-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.30.1
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
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 17 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  5 +++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   |  4 ++++
 3 files changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index bcec4fa444b5..1bb1e292547d 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -427,4 +427,21 @@ ospi0: spi@fc40000 {
 			power-domains = <&k3_pds 75 TI_SCI_PD_EXCLUSIVE>;
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
index 7dd8e94b108d..7154d34faf4c 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -280,3 +280,8 @@ flash@0{
 		#size-cells = <1>;
 	};
 };
+
+&tscadc0 {
+	/* ADC is reserved for R5 usage */
+	status = "reserved";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index fc27470fc083..28059f07bef1 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -207,3 +207,7 @@ flash@0{
 		#size-cells = <1>;
 	};
 };
+
+&tscadc0 {
+	status = "disabled";
+};
-- 
2.30.1

