Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB2A3CFC02
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 16:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbhGTNoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:44:17 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40452 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239765AbhGTNhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:37:04 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16KEGxVc017421;
        Tue, 20 Jul 2021 09:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626790619;
        bh=r6HjtWL3Ke0EbqxVulrXcVKlqmbRbVR733yWLlXjZmc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=zUhThdWvt1PuEObeD2r2/FyXFJwi7LHhbY2BOaP4oyvqKGyjOslKkCV9J13f6fwQG
         YEJzlXWab3SnzGikETy6aH6qyqv2R/pus7H5kfNIgyS3CPOWDNwLS7ZGj23WgEHC6K
         9MpwU3JqiBxKNxoGA1ubRFKxWLnVDmsLFp9nAcqA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16KEGxww119877
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Jul 2021 09:16:59 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 20
 Jul 2021 09:16:59 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 20 Jul 2021 09:16:59 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16KEGh4q044909;
        Tue, 20 Jul 2021 09:16:55 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH 3/6] arm64: dts: ti: k3-j721e: Add support for MCAN nodes
Date:   Tue, 20 Jul 2021 19:46:39 +0530
Message-ID: <20210720141642.24999-4-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210720141642.24999-1-a-govindraju@ti.com>
References: <20210720141642.24999-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

Add support for 14 MCAN controllers in main domain and 2 MCAN controllers
present in mcu domain. All the MCAN controllers support classic CAN
messages as well as CAN_FD messages.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 196 ++++++++++++++++++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  28 +++
 2 files changed, 224 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index cf3482376c1e..4215b8e6785a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -1940,4 +1940,200 @@
 			bus_freq = <1000000>;
 		};
 	};
+
+	main_mcan0: can@2701000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02701000 0x00 0x200>,
+		      <0x00 0x02708000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 156 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 156 1>, <&k3_clks 156 0>;
+		clock-names = "cclk", "hclk";
+		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+	};
+
+	main_mcan1: can@2711000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02711000 0x00 0x200>,
+		      <0x00 0x02718000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 158 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 158 1>, <&k3_clks 158 0>;
+		clock-names = "cclk", "hclk";
+		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+	};
+
+	main_mcan2: can@2721000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02721000 0x00 0x200>,
+		      <0x00 0x02728000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 160 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 160 1>, <&k3_clks 160 0>;
+		clock-names = "cclk", "hclk";
+		interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+	};
+
+	main_mcan3: can@2731000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02731000 0x00 0x200>,
+		      <0x00 0x02738000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 161 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 161 1>, <&k3_clks 161 0>;
+		clock-names = "cclk", "hclk";
+		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+	};
+
+	main_mcan4: can@2741000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02741000 0x00 0x200>,
+		      <0x00 0x02748000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 162 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 162 1>, <&k3_clks 162 0>;
+		clock-names = "cclk", "hclk";
+		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+	};
+
+	main_mcan5: can@2751000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02751000 0x00 0x200>,
+		      <0x00 0x02758000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 163 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 163 1>, <&k3_clks 163 0>;
+		clock-names = "cclk", "hclk";
+		interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+	};
+
+	main_mcan6: can@2761000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02761000 0x00 0x200>,
+		      <0x00 0x02768000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 164 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 164 1>, <&k3_clks 164 0>;
+		clock-names = "cclk", "hclk";
+		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+	};
+
+	main_mcan7: can@2771000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02771000 0x00 0x200>,
+		      <0x00 0x02778000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 165 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 165 1>, <&k3_clks 165 0>;
+		clock-names = "cclk", "hclk";
+		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+	};
+
+	main_mcan8: can@2781000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02781000 0x00 0x200>,
+		      <0x00 0x02788000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 166 1>, <&k3_clks 166 0>;
+		clock-names = "cclk", "hclk";
+		interrupts = <GIC_SPI 576 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+	};
+
+	main_mcan9: can@2791000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x02791000 0x00 0x200>,
+		      <0x00 0x02798000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 167 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 167 1>, <&k3_clks 167 0>;
+		clock-names = "cclk", "hclk";
+		interrupts = <GIC_SPI 579 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+	};
+
+	main_mcan10: can@27a1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027a1000 0x00 0x200>,
+		      <0x00 0x027a8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 168 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 168 1>, <&k3_clks 168 0>;
+		clock-names = "cclk", "hclk";
+		interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+	};
+
+	main_mcan11: can@27b1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027b1000 0x00 0x200>,
+		      <0x00 0x027b8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 169 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 169 1>, <&k3_clks 169 0>;
+		clock-names = "cclk", "hclk";
+		interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+	};
+
+	main_mcan12: can@27c1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027c1000 0x00 0x200>,
+		      <0x00 0x027c8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 170 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 170 1>, <&k3_clks 170 0>;
+		clock-names = "cclk", "hclk";
+		interrupts = <GIC_SPI 588 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+	};
+
+	main_mcan13: can@27d1000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x027d1000 0x00 0x200>,
+		      <0x00 0x027d8000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 171 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 171 1>, <&k3_clks 171 0>;
+		clock-names = "cclk", "hclk";
+		interrupts = <GIC_SPI 591 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index d2dceda72fe9..e803a2a8742a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -390,4 +390,32 @@
 			ti,loczrama = <1>;
 		};
 	};
+
+	mcu_mcan0: can@40528000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x40528000 0x00 0x200>,
+		      <0x00 0x40500000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 172 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 172 1>, <&k3_clks 172 0>;
+		clock-names = "cclk", "hclk";
+		interrupts = <GIC_SPI 832 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+	};
+
+	mcu_mcan1: can@40568000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x40568000 0x00 0x200>,
+		      <0x00 0x40540000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 173 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 173 1>, <&k3_clks 173 0>;
+		clock-names = "cclk", "hclk";
+		interrupts = <GIC_SPI 835 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+	};
 };
-- 
2.17.1

