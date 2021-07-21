Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5DC3D0E19
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbhGULIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:08:00 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34390 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbhGUK4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:56:04 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16LBaa1u058757;
        Wed, 21 Jul 2021 06:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626867396;
        bh=zTc0+d5by1yn2c2oxZDaWLTqDtg1JcqD65QZC9tn/98=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EH/xpLCSywfg1GlSxcvWScXzqutR0Kele8XTwoQazKl+vTub/HRw2yNwVvL4iS4qa
         pDXZLua3Hqac7F8FMTxNOEwZsJxPIptXQVqA3v2tuC9zpytrrYbstMbLICnAcCe0qn
         guyoFvGGI6s1SYIWDnrvIJHcya6nNn99Vf7Jejvg=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16LBaaB7109213
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Jul 2021 06:36:36 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 21
 Jul 2021 06:36:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 21 Jul 2021 06:36:36 -0500
Received: from lokesh-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16LBaQBn115096;
        Wed, 21 Jul 2021 06:36:33 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Nishanth Menon <nm@ti.com>, <kristo@kernel.org>
CC:     Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 2/4] arm64: dts: ti: k3-am64-main: Add ecap pwm nodes
Date:   Wed, 21 Jul 2021 17:06:23 +0530
Message-ID: <20210721113625.17299-3-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210721113625.17299-1-lokeshvutla@ti.com>
References: <20210721113625.17299-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 3 instances of ecap modules that are capable of generating
a pwm when configured in apwm mode. Add DT nodes for these 3 ecap
instances.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 27 ++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 9e762f64b631..42d1d219a3fd 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -946,4 +946,31 @@ epwm8: pwm@23080000 {
 		clocks = <&epwm_tbclk 8>, <&k3_clks 94 0>;
 		clock-names = "tbclk", "fck";
 	};
+
+	ecap0: pwm@23100000 {
+		compatible = "ti,am64-ecap", "ti,am3352-ecap";
+		#pwm-cells = <3>;
+		reg = <0x0 0x23100000 0x0 0x60>;
+		power-domains = <&k3_pds 51 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 51 0>;
+		clock-names = "fck";
+	};
+
+	ecap1: pwm@23110000 {
+		compatible = "ti,am64-ecap", "ti,am3352-ecap";
+		#pwm-cells = <3>;
+		reg = <0x0 0x23110000 0x0 0x60>;
+		power-domains = <&k3_pds 52 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 52 0>;
+		clock-names = "fck";
+	};
+
+	ecap2: pwm@23120000 {
+		compatible = "ti,am64-ecap", "ti,am3352-ecap";
+		#pwm-cells = <3>;
+		reg = <0x0 0x23120000 0x0 0x60>;
+		power-domains = <&k3_pds 53 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 53 0>;
+		clock-names = "fck";
+	};
 };
-- 
2.31.1

