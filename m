Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BDE32DBA1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 22:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbhCDVNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 16:13:31 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37726 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbhCDVNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 16:13:11 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 124LBP9R075211;
        Thu, 4 Mar 2021 15:11:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614892285;
        bh=9AjnsMgiuOgRIrqSEF6MNWOVhlGpziVU6+BSCfg+pB4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wW6LZy6M0QiTi8oYVzyYtUM7lMp0j+S/i1vQYGNq5JBhFkqzN88hfld6qtbzYLWZ1
         NLGjlPWfwLpq9ta4Azjw10AjMovChTYQidlsI+ufeTRGNafeisAV79vCdHrLAIOLZh
         /swT8FcJOx8pDUB2XTc+lnftS/yAjule6hDeoxYU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 124LBPu8016976
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Mar 2021 15:11:25 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 4 Mar
 2021 15:11:25 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 4 Mar 2021 15:11:25 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 124LBO5e040274;
        Thu, 4 Mar 2021 15:11:24 -0600
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
CC:     <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2 2/4] arm64: dts: ti: k3-am64-main: add main CPTS entry
Date:   Thu, 4 Mar 2021 23:10:36 +0200
Message-ID: <20210304211038.12511-3-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210304211038.12511-1-grygorii.strashko@ti.com>
References: <20210304211038.12511-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT node for the Main domain CPTS.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
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

