Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5053640C6CB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 15:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhION4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 09:56:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52100 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhION4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 09:56:00 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18FDsSTb128368;
        Wed, 15 Sep 2021 08:54:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631714068;
        bh=n3Xsh7wMUpKW9VHza0op5L8b8abYDU5Q+J2hqqb6NXI=;
        h=From:To:CC:Subject:Date;
        b=hD/f7RZO2jMSRmCWWW3vxAVd71VqBYPI/hzdSfI5D6UgB9Dgl1BC7ZRe45ZdXcApG
         PaEypBbY4pFUhHfsJGVUykGAT4pXuNzPvg1fCgOJ6iyqJ8bEfnAHMl8RIQPptPnxiY
         yS29Ofk9+tpUBhRIk1L/Sb7tS8pqX/C8ObOuZNsk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18FDsSOs020775
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Sep 2021 08:54:28 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Sep 2021 08:54:28 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Sep 2021 08:54:28 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18FDsSY8026036;
        Wed, 15 Sep 2021 08:54:28 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH] arm64: dts: ti: ti-k3*: Introduce aliases for mmc nodes
Date:   Wed, 15 Sep 2021 08:54:15 -0500
Message-ID: <20210915135415.5706-1-nm@ti.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since probe order of mmc can vary depending on device tree dependencies,
Lets try and introduce a consistent definition of what mmc0, 1 are
across platforms.

NOTE: Certain platforms may choose to have overrides due to various
legacy reasons, we permit that in the board specific alias definition.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64.dtsi  | 2 ++
 arch/arm64/boot/dts/ti/k3-am65.dtsi  | 2 ++
 arch/arm64/boot/dts/ti/k3-j7200.dtsi | 2 ++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi | 3 +++
 4 files changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64.dtsi b/arch/arm64/boot/dts/ti/k3-am64.dtsi
index de6805b0c72c..120974726be8 100644
--- a/arch/arm64/boot/dts/ti/k3-am64.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64.dtsi
@@ -30,6 +30,8 @@ aliases {
 		serial8 = &main_uart6;
 		ethernet0 = &cpsw_port1;
 		ethernet1 = &cpsw_port2;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
 	};
 
 	chosen { };
diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
index a9fc1af03f27..a58a39fa42db 100644
--- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
@@ -31,6 +31,8 @@ aliases {
 		i2c4 = &main_i2c2;
 		i2c5 = &main_i2c3;
 		ethernet0 = &cpsw_port1;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
 	};
 
 	chosen { };
diff --git a/arch/arm64/boot/dts/ti/k3-j7200.dtsi b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
index b7005b803149..47567cb260c2 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
@@ -30,6 +30,8 @@ aliases {
 		serial9 = &main_uart7;
 		serial10 = &main_uart8;
 		serial11 = &main_uart9;
+		mmc0 = &main_sdhci0;
+		mmc1 = &main_sdhci1;
 	};
 
 	chosen { };
diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
index f0587fde147e..214359e7288b 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
@@ -31,6 +31,9 @@ aliases {
 		serial10 = &main_uart8;
 		serial11 = &main_uart9;
 		ethernet0 = &cpsw_port1;
+		mmc0 = &main_sdhci0;
+		mmc1 = &main_sdhci1;
+		mmc2 = &main_sdhci2;
 	};
 
 	chosen { };
-- 
2.32.0

