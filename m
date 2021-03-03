Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE4032C23D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387942AbhCCTfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:35:11 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54718 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245272AbhCCTWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:22:43 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 123JLf6q100396;
        Wed, 3 Mar 2021 13:21:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614799301;
        bh=g5bA4TxNTkNpSyJeswh+tz6oQDdUJZwyCz+VpHY0Bto=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yNTQbdWbSEdLyQq213hEdOTUEeePmhPDVjEaG4GVVQFUXd0x6vpkft0i+dNYrTEDR
         YrbXobdAmtqbk8I14BfXC25lLD+JbKdYy1l2XjqwORlk/qVrWma4gHKanaLCo2JJZC
         hIFA6iFePgRl6l+B7BdDY6RujfPzUdujEyM8oxLs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 123JLfOr055583
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Mar 2021 13:21:41 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 3 Mar
 2021 13:21:40 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 3 Mar 2021 13:21:40 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 123JLeuQ013018;
        Wed, 3 Mar 2021 13:21:40 -0600
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
CC:     <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 2/4] arm64: dts: ti: k3-am64-main: add main CPTS entry
Date:   Wed, 3 Mar 2021 21:21:12 +0200
Message-ID: <20210303192114.12292-3-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210303192114.12292-1-grygorii.strashko@ti.com>
References: <20210303192114.12292-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT node for the Main domain CPTS.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 80443dbf272c..0cf727e3d1e2 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -476,4 +476,19 @@
 			ti,cpts-periodic-outputs = <2>;
 		};
 	};
+
+	cpts@39000000 {
+		compatible = "ti,j721e-cpts";
+		reg = <0x0 0x39000000 0x0 0x400>;
+		reg-names = "cpts";
+		power-domains = <&k3_pds 84 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 84 0>;
+		clock-names = "cpts";
+		assigned-clocks = <&k3_clks 84 0>;
+		assigned-clock-parents = <&k3_clks 84 8>;
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "cpts";
+		ti,cpts-periodic-outputs = <6>;
+		ti,cpts-ext-ts-inputs = <8>;
+	};
 };
-- 
2.17.1

