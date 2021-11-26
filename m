Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D7A45E998
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 09:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359516AbhKZIvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 03:51:25 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45556 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344660AbhKZItW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 03:49:22 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AQ8k3Ow031049;
        Fri, 26 Nov 2021 02:46:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637916363;
        bh=SNnvhHsSYIDsZ9wv0UbZsycvp//YDakTZwJ1aODw9IM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mVjVzcyUVgPKGuAOrKoEl3fufxa1lbcOh1PsIrorZfAL0OQcIhSyGAp42qGbEP6iw
         BwwTsnolryH1XWdZFOIbJH0awgc2Hsb5ajzu1k9rjdLMX4jfdHtg2KH002IOb5UOGj
         3sZkIN/gwJRVKx4n5W4rschIerzjx47pxqEwst9U=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AQ8k3wr055374
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Nov 2021 02:46:03 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 26
 Nov 2021 02:46:03 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 26 Nov 2021 02:46:03 -0600
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AQ8jtIm074242;
        Fri, 26 Nov 2021 02:46:00 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] arm64: dts: ti: j7200-main: Fix 'dtbs_check' serdes_ln_ctrl node
Date:   Fri, 26 Nov 2021 14:15:54 +0530
Message-ID: <20211126084555.17797-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211126084555.17797-1-kishon@ti.com>
References: <20211126084555.17797-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix 'dtbs_check' in serdes_ln_ctrl (serdes-ln-ctrl@4080) node by
changing the node name to mux-controller@4080.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index d60ef4f7dd0b..05a627ad6cdc 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -32,7 +32,7 @@
 		#size-cells = <1>;
 		ranges = <0x00 0x00 0x00100000 0x1c000>;
 
-		serdes_ln_ctrl: serdes-ln-ctrl@4080 {
+		serdes_ln_ctrl: mux-controller@4080 {
 			compatible = "mmio-mux";
 			#mux-control-cells = <1>;
 			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
-- 
2.17.1

