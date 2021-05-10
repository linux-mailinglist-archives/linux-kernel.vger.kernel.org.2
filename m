Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16F137915F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239467AbhEJOxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:53:07 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51330 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238980AbhEJOvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:51:44 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14AEoY8Z053514;
        Mon, 10 May 2021 09:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620658234;
        bh=kSl8JDU6+7l+uosU2KIqF2hGJ7mhQ+xhsvTV24fYPtc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nyzXyCsPW5kN7b2yruLuyZqHfF3FbVc11Jt732usZT4U9e6OJVBu3WZbFksmxiP4d
         bPGUJfpWd6soTia1urVgJOLK4DWNTT6/70rVZr+fGyQh3IZ69jFU+LGSXrUkWnkp+2
         rVqWPmKAJXLVShgTY3bqggx6P4DVCuKfRmXdan7k=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14AEoYvq083198
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 May 2021 09:50:34 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 10
 May 2021 09:50:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 10 May 2021 09:50:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14AEoY1t117399;
        Mon, 10 May 2021 09:50:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/4] arm64: dts: ti: k3-am65-wakeup: Add debug region to TI-SCI node
Date:   Mon, 10 May 2021 09:50:31 -0500
Message-ID: <20210510145033.7426-3-nm@ti.com>
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

Lets add the TISCI debug region to TI-SCI region in line with TI-SCI
documentation[1]. While at it, lets rename the node to indicate the
address usage.

[1] http://downloads.ti.com/tisci/esd/latest/4_trace/trace.html

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index 2ae1f9214b8a..444842a2d556 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -6,7 +6,7 @@
  */
 
 &cbass_wakeup {
-	dmsc: dmsc {
+	dmsc: dmsc@44083000 {
 		compatible = "ti,am654-sci";
 		ti,host-id = <12>;
 		#address-cells = <1>;
@@ -18,6 +18,9 @@ dmsc: dmsc {
 		mboxes= <&secure_proxy_main 11>,
 			<&secure_proxy_main 13>;
 
+		reg-names = "debug_messages";
+		reg = <0x44083000 0x1000>;
+
 		k3_pds: power-controller {
 			compatible = "ti,sci-pm-domain";
 			#power-domain-cells = <2>;
-- 
2.31.0

