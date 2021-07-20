Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35B93CFBEA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 16:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238864AbhGTNln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:41:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40468 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239792AbhGTNhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:37:04 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16KEH7mx017506;
        Tue, 20 Jul 2021 09:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626790627;
        bh=ZrvlhI4x9E8cak+9Nzisags1LME2/53lIBU7GhEi6JU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FMpihYknVtsRDH82yvCWPEdcSjbYucnQUeBtdC0nHAiAe8AL+xR6pV3FZxFqRywq2
         NBiuOfeeOoKYMrT6DNm7SNlyfnSZfbhS/rqYF65OAmpRjT/nxKOVkChNF7YI8g9+Ei
         teNLBmMOyZHmlFg0743HvjVBL9WXMyLFJ5XIu8zY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16KEH77L120382
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Jul 2021 09:17:07 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 20
 Jul 2021 09:17:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 20 Jul 2021 09:17:07 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16KEGh4s044909;
        Tue, 20 Jul 2021 09:17:03 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH 5/6] arm64: dts: ti: k3-am64-main: Add support for MCAN
Date:   Tue, 20 Jul 2021 19:46:41 +0530
Message-ID: <20210720141642.24999-6-a-govindraju@ti.com>
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

Add Support for two MCAN controllers present on the am64x SOC. Both support
classic CAN messages as well as CAN-FD.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 02c3fdf9cc46..f0113dece6cb 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -859,4 +859,32 @@
 		clock-names = "fck";
 		max-functions = /bits/ 8 <1>;
 	};
+
+	main_mcan0: can@20701000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x20701000 0x00 0x200>,
+		      <0x00 0x20708000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 98 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 98 0>, <&k3_clks 98 5>;
+		clock-names = "cclk", "hclk";
+		interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+	};
+
+	main_mcan1: can@20711000 {
+		compatible = "bosch,m_can";
+		reg = <0x00 0x20711000 0x00 0x200>,
+		      <0x00 0x20718000 0x00 0x8000>;
+		reg-names = "m_can", "message_ram";
+		power-domains = <&k3_pds 99 TI_SCI_PD_EXCLUSIVE>;
+		clocks =  <&k3_clks 99 0>, <&k3_clks 99 5>;
+		clock-names = "cclk", "hclk";
+		interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+	};
 };
-- 
2.17.1

