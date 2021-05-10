Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8064379130
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbhEJOpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:45:41 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36258 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245601AbhEJOoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:44:24 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14AEhDKx058750;
        Mon, 10 May 2021 09:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620657793;
        bh=WrYm0Ve++Kt7KJmg6dyPOtLGOQKOfCMceRyIird5uNw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=v76yBXGxC6YFDXgVSVe+oL38Oa/setUhP3JBrowywE34CG9Gab7Lv9JZoLNtAnU8P
         wrNEtiaPBwAH9MiONJxlbIN5XOukWRzn7V6x0xNi5++ndD3vZN1XfosZsE26r164U3
         DBpXOLaMRh3TlfPcmKx1kjPzKMqHNrcF3PPqJXxA=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14AEhDaT073658
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 May 2021 09:43:13 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 10
 May 2021 09:43:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 10 May 2021 09:43:12 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14AEhDEc011027;
        Mon, 10 May 2021 09:43:13 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kristo@kernel.org>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/4] ARM: dts: keystone: k2g: Rename the TI-SCI clocks node name
Date:   Mon, 10 May 2021 09:43:11 -0500
Message-ID: <20210510144312.986-4-nm@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210510144312.986-1-nm@ti.com>
References: <20210510144312.986-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently use clocks as the node name for the node representing
TI-SCI clock nodes. This is better renamed to being clock-controller
as that is a better representative of the system controller function
as a clock controller for the SoC.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
yaml fixup series:
https://lore.kernel.org/linux-arm-kernel/20210503190824.GA2192378@robh.at.kernel.org

Specific yaml:
https://lore.kernel.org/linux-arm-kernel/20210426155457.21221-3-nm@ti.com/

 arch/arm/boot/dts/keystone-k2g.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index d7fc6057ca41..37198294f4b2 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -272,7 +272,7 @@ k2g_pds: power-controller {
 				#power-domain-cells = <1>;
 			};
 
-			k2g_clks: clocks {
+			k2g_clks: clock-controller {
 				compatible = "ti,k2g-sci-clk";
 				#clock-cells = <2>;
 			};
-- 
2.31.0

