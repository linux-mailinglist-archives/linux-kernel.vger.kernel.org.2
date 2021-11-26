Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0EC45E999
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 09:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359624AbhKZIv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 03:51:27 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46160 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345831AbhKZItW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 03:49:22 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AQ8k7OC042239;
        Fri, 26 Nov 2021 02:46:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637916367;
        bh=meQ7lU3UFqNzyz6oZpg4XEYjCTaR8JxzylsA+iLuUcY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Wcw87ZtFyfmKQNvpyaHBgGMHLnPMYece/gtouL2LMV2Qk5e4M6ivAjZOa8nrsXtvS
         FJY2wA9cklVSshukNN67Mnqh/m1EO0zIq0bUIS9IeqfUrGA4BUd3DfmQeUZL6Fd+E8
         oE4lwFduYtVF/jn65SA5zp5DxWfJekL9hn8Fukn8=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AQ8k750094731
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Nov 2021 02:46:07 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 26
 Nov 2021 02:46:06 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 26 Nov 2021 02:46:07 -0600
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AQ8jtIn074242;
        Fri, 26 Nov 2021 02:46:03 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 2/2] arm64: dts: ti: j721e-main: Fix 'dtbs_check' in serdes_ln_ctrl node
Date:   Fri, 26 Nov 2021 14:15:55 +0530
Message-ID: <20211126084555.17797-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211126084555.17797-1-kishon@ti.com>
References: <20211126084555.17797-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix 'dtbs_check' in serdes_ln_ctrl (mux@4080) node by changing the node
name to mux-controller@4080.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 08c8d1b47dcd..e85c89eebfa3 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -42,7 +42,7 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x00100000 0x1c000>;
 
-		serdes_ln_ctrl: mux@4080 {
+		serdes_ln_ctrl: mux-controller@4080 {
 			compatible = "mmio-mux";
 			reg = <0x00004080 0x50>;
 			#mux-control-cells = <1>;
-- 
2.17.1

