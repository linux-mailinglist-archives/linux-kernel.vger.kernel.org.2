Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2677F379160
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbhEJOxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:53:11 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38036 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238801AbhEJOvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:51:44 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14AEoYMK061475;
        Mon, 10 May 2021 09:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620658234;
        bh=OjRPo/+VEPRehC0D2Xoqh9sRDsKdqDCnR1KHMLNxRmk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UD8F/2bEQ86yugcFn7/nl001GgmcuekgXyK8ZDiYh4vb/6zEsyg7e7R7sLbqwRqSn
         SKokhnAzzFMY/9igST2R51TT2D8BX+XaZv2k5U1/14LCA50mSb9xARo7qjevRrc7qh
         l0DeQbSKXwr/j54qfOwtor7hhPftfhtbJAcbx79s=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14AEoYSp083216
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 May 2021 09:50:34 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 10
 May 2021 09:50:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 10 May 2021 09:50:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14AEoYfR023174;
        Mon, 10 May 2021 09:50:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 4/4] arm64: dts: ti: k3-*: Rename the TI-SCI node
Date:   Mon, 10 May 2021 09:50:33 -0500
Message-ID: <20210510145033.7426-5-nm@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210510145033.7426-1-nm@ti.com>
References: <20210510145033.7426-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lets rename the node name of TI-SCI node to be system-controller as it
is a better standardized name for the function that TI-SCI plays in the
SoC.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi        | 2 +-
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi      | 2 +-
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index e1216073e3df..dc52178d9b64 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -134,7 +134,7 @@ main_pktdma: dma-controller@485c0000 {
 		};
 	};
 
-	dmsc: dmsc@44043000 {
+	dmsc: system-controller@44043000 {
 		compatible = "ti,k2g-sci";
 		ti,host-id = <12>;
 		mbox-names = "rx", "tx";
diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index 80d4df775f43..822f4cff1db4 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -6,7 +6,7 @@
  */
 
 &cbass_wakeup {
-	dmsc: dmsc@44083000 {
+	dmsc: system-controller@44083000 {
 		compatible = "ti,am654-sci";
 		ti,host-id = <12>;
 
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 9dba2df3569f..65f3fabda114 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -6,7 +6,7 @@
  */
 
 &cbass_mcu_wakeup {
-	dmsc: dmsc@44083000 {
+	dmsc: system-controller@44083000 {
 		compatible = "ti,k2g-sci";
 		ti,host-id = <12>;
 
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index b83801feeb10..94e821467eaa 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -6,7 +6,7 @@
  */
 
 &cbass_mcu_wakeup {
-	dmsc: dmsc@44083000 {
+	dmsc: system-controller@44083000 {
 		compatible = "ti,k2g-sci";
 		ti,host-id = <12>;
 
-- 
2.31.0

