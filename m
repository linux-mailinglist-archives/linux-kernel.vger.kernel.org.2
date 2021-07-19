Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD0B3CCFDD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 11:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbhGSIV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 04:21:58 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53934 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbhGSIV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:21:56 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16J8sCwJ068595;
        Mon, 19 Jul 2021 03:54:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626684852;
        bh=2aMBT68yvyc9qhPFHnpJ7+fH8WKBnf72TNPAa/X9gaw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=m9FJNSTvtUGOE+poP5uIp89WM1bmQhLqXRlfKy5Jdy8/zQnGHpLiKvw+5LlYp1VpI
         +VDwrmLha4aNt+9dI3ScwSQltkrzeB5p5ebOjGbL1Cur74gtgJdshM9MtgnUlHPXsD
         iNQ0inm/8eaLdHN3lIp+HrVZRMqZFAuOikXvQ5WY=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16J8sB39120975
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Jul 2021 03:54:11 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 19
 Jul 2021 03:54:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 19 Jul 2021 03:54:11 -0500
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16J8s3hD047822;
        Mon, 19 Jul 2021 03:54:09 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Nishanth Menon <nm@ti.com>, <kristo@kernel.org>
CC:     Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 2/4] arm64: dts: ti: k3-am64-main: Add ecap pwm nodes
Date:   Mon, 19 Jul 2021 14:24:00 +0530
Message-ID: <20210719085402.28569-3-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210719085402.28569-1-lokeshvutla@ti.com>
References: <20210719085402.28569-1-lokeshvutla@ti.com>
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
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
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
2.30.0

