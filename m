Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3639432E1BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 06:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhCEFlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 00:41:23 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56888 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCEFlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 00:41:22 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1255fGdP088042;
        Thu, 4 Mar 2021 23:41:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614922876;
        bh=Zj2zU4nNxYvDCr1JJ3pAzwcCV3RhOeXkT/tvob1JQbo=;
        h=From:To:CC:Subject:Date;
        b=rK/GHUCfiFs/+gmWaWDE8iaZgv/PppfhdqkJf5L9ou1vFaeBWxppttQ3jcGFPx6m7
         gMmmZzKFXdwjRpI3tOKTH/sy4cxxcvjJSs1vD0msPluiWROb2gF0kGGDmqs6zNJOsl
         1+MuRBLcyo+V8ohcSNx0IQwByxcItFZGAn0kF+3c=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1255fG7T063539
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Mar 2021 23:41:16 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 4 Mar
 2021 23:41:16 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 4 Mar 2021 23:41:16 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1255f7Zv051887;
        Thu, 4 Mar 2021 23:41:09 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] arm64: dts: ti: k3-j721e-main: Update the speed modes supported and their itap delay values for MMCSD subsystems
Date:   Fri, 5 Mar 2021 11:11:04 +0530
Message-ID: <20210305054104.10153-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to latest errata of J721e [1], HS400 mode is not supported
in MMCSD0 subsystem (i2024) and SDR104 mode is not supported in MMCSD1/2
subsystems (i2090). Therefore, replace mmc-hs400-1_8v with mmc-hs200-1_8v
in MMCSD0 subsystem and add a sdhci mask to disable SDR104 speed mode.

Also, update the itap delay values for all the MMCSD subsystems according
the latest J721e data sheet[2]

[1] - https://www.ti.com/lit/er/sprz455/sprz455.pdf
[2] - https://www.ti.com/lit/ds/symlink/tda4vm.pdf

Fixes: cd48ce86a4d0 ("arm64: dts: ti: k3-j721e-common-proc-board: Add support for SD card UHS modes")
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---

Changes since v1:
- Corrected the fixes tag to latest commit that makes changes to the
  sdhci DT nodes.

 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 8c84dafb7125..f1e7da3dfa27 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -1042,13 +1042,16 @@
 		assigned-clocks = <&k3_clks 91 1>;
 		assigned-clock-parents = <&k3_clks 91 2>;
 		bus-width = <8>;
-		mmc-hs400-1_8v;
+		mmc-hs200-1_8v;
 		mmc-ddr-1_8v;
 		ti,otap-del-sel-legacy = <0xf>;
 		ti,otap-del-sel-mmc-hs = <0xf>;
 		ti,otap-del-sel-ddr52 = <0x5>;
 		ti,otap-del-sel-hs200 = <0x6>;
 		ti,otap-del-sel-hs400 = <0x0>;
+		ti,itap-del-sel-legacy = <0x10>;
+		ti,itap-del-sel-mmc-hs = <0xa>;
+		ti,itap-del-sel-ddr52 = <0x3>;
 		ti,trm-icp = <0x8>;
 		ti,strobe-sel = <0x77>;
 		dma-coherent;
@@ -1069,9 +1072,15 @@
 		ti,otap-del-sel-sdr25 = <0xf>;
 		ti,otap-del-sel-sdr50 = <0xc>;
 		ti,otap-del-sel-ddr50 = <0xc>;
+		ti,itap-del-sel-legacy = <0x0>;
+		ti,itap-del-sel-sd-hs = <0x0>;
+		ti,itap-del-sel-sdr12 = <0x0>;
+		ti,itap-del-sel-sdr25 = <0x0>;
+		ti,itap-del-sel-ddr50 = <0x2>;
 		ti,trm-icp = <0x8>;
 		ti,clkbuf-sel = <0x7>;
 		dma-coherent;
+		sdhci-caps-mask = <0x2 0x0>;
 	};
 
 	main_sdhci2: mmc@4f98000 {
@@ -1089,9 +1098,15 @@
 		ti,otap-del-sel-sdr25 = <0xf>;
 		ti,otap-del-sel-sdr50 = <0xc>;
 		ti,otap-del-sel-ddr50 = <0xc>;
+		ti,itap-del-sel-legacy = <0x0>;
+		ti,itap-del-sel-sd-hs = <0x0>;
+		ti,itap-del-sel-sdr12 = <0x0>;
+		ti,itap-del-sel-sdr25 = <0x0>;
+		ti,itap-del-sel-ddr50 = <0x2>;
 		ti,trm-icp = <0x8>;
 		ti,clkbuf-sel = <0x7>;
 		dma-coherent;
+		sdhci-caps-mask = <0x2 0x0>;
 	};
 
 	usbss0: cdns-usb@4104000 {
-- 
2.17.1

