Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CDE3079C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 16:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhA1P3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 10:29:50 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40804 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbhA1P3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 10:29:34 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10SFRu07069381;
        Thu, 28 Jan 2021 09:27:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611847676;
        bh=0x5nGBBd8lDolKR3x+YbTSeWqe7UCmB3rIQ1gpq8PKg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tLu8cXKtqGTB4sgoPyGC5YDtegUXsEdmadAjACfFkjOv7dHy0JP8k724kU0PIPTgB
         sQHEbqArzyixKAJzLWf0DCm5EAhM58ONoESbygwH0SiwUNbu8w/pLC7g+eXJ1xARko
         57cTbTlt4iIJmMlT1xKKtF6S4lQI/ZAHBmmQQkVc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10SFRu8b017449
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jan 2021 09:27:56 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 28
 Jan 2021 09:27:55 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 28 Jan 2021 09:27:55 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10SFRk5B094536;
        Thu, 28 Jan 2021 09:27:52 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/3] arm64: dts: ti: k3-j7200: Add gpio nodes
Date:   Thu, 28 Jan 2021 20:57:42 +0530
Message-ID: <20210128152744.12439-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210128152744.12439-1-a-govindraju@ti.com>
References: <20210128152744.12439-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

There are 4 instances of gpio modules in main domain:
	gpio0, gpio2, gpio4 and gpio6

Groups are created to provide protection between different processor
virtual worlds. Each of these modules I/O pins are muxed within the
group. Exactly one module can be selected to control the corresponding
pin by selecting it in the pad mux configuration registers.

This group pins out 69 lines (5 banks). Add DT modes for each module
instance in the main domain.

Similar to the gpio groups in main domain, there is one gpio group in
wakeup domain with 2 mdoules instances in it.

The gpio group pins out 73 pins (5 banks). Add DT nodes for each module
instance in the wakeup domain.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 72 +++++++++++++++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 34 +++++++++
 2 files changed, 106 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index d623004cfc9e..7a04a113f445 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -675,6 +675,78 @@
 		};
 	};
 
+	main_gpio0: gpio@600000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x00600000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <145>, <146>, <147>, <148>,
+			     <149>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#address-cells = <0>;
+		ti,ngpio = <69>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 105 0>;
+		clock-names = "gpio";
+	};
+
+	main_gpio2: gpio@610000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x00610000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <154>, <155>, <156>, <157>,
+			     <158>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#address-cells = <0>;
+		ti,ngpio = <69>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 107 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 107 0>;
+		clock-names = "gpio";
+	};
+
+	main_gpio4: gpio@620000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x00620000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <163>, <164>, <165>, <166>,
+			     <167>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#address-cells = <0>;
+		ti,ngpio = <69>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 109 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 109 0>;
+		clock-names = "gpio";
+	};
+
+	main_gpio6: gpio@630000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x00630000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&main_gpio_intr>;
+		interrupts = <172>, <173>, <174>, <175>,
+			     <176>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#address-cells = <0>;
+		ti,ngpio = <69>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 111 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 111 0>;
+		clock-names = "gpio";
+	};
+
 	main_r5fss0: r5fss@5c00000 {
 		compatible = "ti,j7200-r5fss";
 		ti,cluster-mode = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 0a8df7e4739c..3376bd57fd2d 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -108,6 +108,40 @@
 		ti,interrupt-ranges = <16 960 16>;
 	};
 
+	wkup_gpio0: gpio@42110000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x42110000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&wkup_gpio_intr>;
+		interrupts = <103>, <104>, <105>, <106>, <107>, <108>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#address-cells = <0>;
+		ti,ngpio = <73>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 113 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 113 0>;
+		clock-names = "gpio";
+	};
+
+	wkup_gpio1: gpio@42100000 {
+		compatible = "ti,j721e-gpio", "ti,keystone-gpio";
+		reg = <0x00 0x42100000 0x00 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&wkup_gpio_intr>;
+		interrupts = <112>, <113>, <114>, <115>, <116>, <117>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#address-cells = <0>;
+		ti,ngpio = <73>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 114 0>;
+		clock-names = "gpio";
+	};
+
 	mcu_navss: bus@28380000 {
 		compatible = "simple-mfd";
 		#address-cells = <2>;
-- 
2.17.1

