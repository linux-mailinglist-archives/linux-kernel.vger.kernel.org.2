Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FC640BF6F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 07:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbhIOFz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 01:55:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60274 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhIOFz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 01:55:27 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18F5s6fR078624;
        Wed, 15 Sep 2021 00:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631685246;
        bh=axEYb9JYEKzBTn2mRjbYse2llSNaAdqIYZHqBb+4Uz0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=f24U9FeHwfGmaElCobZJkDLCo66dT1nnmmxv6fy3rWS5zT6+ATCOfsvqQrCjb1u+g
         hXKFcq7BwjOzFe36ACZ9XoGN94VLRzQ6pYg6hYc1jo8UkCG2HVqkvcnlpz1cJESxCV
         Z8EzZDpc0JtS2whyoIKQvb4pmXR1NXJAocpq4xwM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18F5s65l096967
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Sep 2021 00:54:06 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Sep 2021 00:54:06 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Sep 2021 00:54:06 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18F5rwsa023333;
        Wed, 15 Sep 2021 00:54:03 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH 1/6] arm64: dts: ti: k3-j721e-main: Fix "max-virtual-functions" in PCIe EP nodes
Date:   Wed, 15 Sep 2021 11:23:53 +0530
Message-ID: <20210915055358.19997-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210915055358.19997-1-kishon@ti.com>
References: <20210915055358.19997-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 4e5833884f66 ("arm64: dts: ti: k3-j721e-main: Add PCIe device
tree nodes") added "max-virtual-functions" to have 16 bit values.
Fix "max-virtual-functions" in PCIe endpoint (EP) nodes to have 8 bit
values instead of 16.

Fixes: 4e5833884f66 ("arm64: dts: ti: k3-j721e-main: Add PCIe device tree nodes")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index cf3482376c1e..43be5d23130b 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -636,7 +636,7 @@
 		clocks = <&k3_clks 239 1>;
 		clock-names = "fck";
 		max-functions = /bits/ 8 <6>;
-		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
+		max-virtual-functions = /bits/ 8 <4 4 4 4 0 0>;
 		dma-coherent;
 	};
 
@@ -684,7 +684,7 @@
 		clocks = <&k3_clks 240 1>;
 		clock-names = "fck";
 		max-functions = /bits/ 8 <6>;
-		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
+		max-virtual-functions = /bits/ 8 <4 4 4 4 0 0>;
 		dma-coherent;
 	};
 
@@ -732,7 +732,7 @@
 		clocks = <&k3_clks 241 1>;
 		clock-names = "fck";
 		max-functions = /bits/ 8 <6>;
-		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
+		max-virtual-functions = /bits/ 8 <4 4 4 4 0 0>;
 		dma-coherent;
 	};
 
@@ -780,7 +780,7 @@
 		clocks = <&k3_clks 242 1>;
 		clock-names = "fck";
 		max-functions = /bits/ 8 <6>;
-		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
+		max-virtual-functions = /bits/ 8 <4 4 4 4 0 0>;
 		dma-coherent;
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.17.1

