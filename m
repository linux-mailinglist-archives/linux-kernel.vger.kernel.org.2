Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363E440E9BF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348381AbhIPSUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 14:20:36 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37852 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348445AbhIPST2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 14:19:28 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18GII26a072604;
        Thu, 16 Sep 2021 13:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631816282;
        bh=pyw9qfNvaWdLSiz1gujXS6WUJuA+dp3Tth+WCvjmhP0=;
        h=From:To:CC:Subject:Date;
        b=gHttkm+7FmDOQZqeCnfvj5kj4FCHgXgVO/dkBoBfgohtSr44IHd4WXsO2naS86a6h
         x7F5x9xHVTk1hC1NiopWOhXZMiwmrEZwbJRAgL0sP5EunIxhjJt+zy+I+AynE6SmO0
         g8LEp/qiTiQch9h9p0/CcKJai5BLTmqEhB+WMI7Y=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18GII2oq112717
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Sep 2021 13:18:02 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 16
 Sep 2021 13:18:02 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 16 Sep 2021 13:18:02 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18GII10w082245;
        Thu, 16 Sep 2021 13:18:01 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Keerthy <j-keerthy@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am65: Relocate thermal-zones to SoC specific location
Date:   Thu, 16 Sep 2021 13:18:01 -0500
Message-ID: <20210916181801.32588-1-nm@ti.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When commit 64f9147d914d ("arm64: dts: ti: am654: Add thermal
zones") introduced thermal-zones for am654, it defined as under the
common am65-wakeup bus segment, when it is am654 specific (other SoC
spins can have slightly different thermal characteristics). Futher,
thermal-zones is introduced under simple-bus node, when it has no
actual register or base address.

So, move it to it's rightful place under am654 SoC dtsi under the base
node.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

NOTE:
1. This is a cosmetic fixup, so skip the "Fixes" tag.
2. This fixes up noisy dtbs_check warning around thermal.

 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 4 ----
 arch/arm64/boot/dts/ti/k3-am654.dtsi       | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index 9d21cdf6fce8..9c69d0917f69 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -100,8 +100,4 @@ wkup_vtm0: temperature-sensor@42050000 {
 		power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
 		#thermal-sensor-cells = <1>;
 	};
-
-	thermal_zones: thermal-zones {
-		#include "k3-am654-industrial-thermal.dtsi"
-	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am654.dtsi b/arch/arm64/boot/dts/ti/k3-am654.dtsi
index f0a6541b8042..a89257900047 100644
--- a/arch/arm64/boot/dts/ti/k3-am654.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am654.dtsi
@@ -112,4 +112,8 @@ msmc_l3: l3-cache0 {
 		compatible = "cache";
 		cache-level = <3>;
 	};
+
+	thermal_zones: thermal-zones {
+		#include "k3-am654-industrial-thermal.dtsi"
+	};
 };
-- 
2.32.0

