Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDD4368D50
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbhDWGsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:48:55 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56978 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhDWGsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:48:52 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13N6mAQw093049;
        Fri, 23 Apr 2021 01:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1619160490;
        bh=N0q3/l+13M9AP+IVPyafTQEQwO1+v41hdNB/Yy5AtqE=;
        h=From:To:CC:Subject:Date;
        b=pdAa5rDn2MRgKVjvszXzxiyh7diOVYXJSxJRDkA+wkOMlLhl9cxeRJT0qRgT8UVa3
         hgKdiuFiY/EzITwjOqLrZbU7DQ0B6vw0TIduTm7IfO4sJjZ3+dxzeuYgRIDOqY9BUD
         SpbensbiCiikhXGccuEjKS5bgjQnKDWOfTLCTa3U=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13N6mA4v069238
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Apr 2021 01:48:10 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 23
 Apr 2021 01:48:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 23 Apr 2021 01:48:10 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13N6m43k061466;
        Fri, 23 Apr 2021 01:48:05 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-j7200: Remove "#address-cells" property from GPIO DT nodes
Date:   Fri, 23 Apr 2021 12:17:57 +0530
Message-ID: <20210423064758.25520-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO device tree nodes do not have child nodes. Therefore, "#address-cells"
property should not be added.

Fixes: e0b2e6af39ea ("arm64: dts: ti: k3-j7200: Add gpio nodes")
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi       | 4 ----
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 2 --
 2 files changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 07c0ce484cae..829b5db565f5 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -693,7 +693,6 @@
 			     <149>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		#address-cells = <0>;
 		ti,ngpio = <69>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
@@ -711,7 +710,6 @@
 			     <158>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		#address-cells = <0>;
 		ti,ngpio = <69>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 107 TI_SCI_PD_EXCLUSIVE>;
@@ -729,7 +727,6 @@
 			     <167>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		#address-cells = <0>;
 		ti,ngpio = <69>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
@@ -747,7 +744,6 @@
 			     <176>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		#address-cells = <0>;
 		ti,ngpio = <69>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 111 TI_SCI_PD_EXCLUSIVE>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 5e74e43822c3..d865805eeff2 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -116,7 +116,6 @@
 		interrupts = <103>, <104>, <105>, <106>, <107>, <108>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		#address-cells = <0>;
 		ti,ngpio = <85>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 113 TI_SCI_PD_EXCLUSIVE>;
@@ -133,7 +132,6 @@
 		interrupts = <112>, <113>, <114>, <115>, <116>, <117>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
-		#address-cells = <0>;
 		ti,ngpio = <85>;
 		ti,davinci-gpio-unbanked = <0>;
 		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
-- 
2.17.1

