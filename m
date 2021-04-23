Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA67C368CE9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240554AbhDWGDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:03:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34600 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhDWGDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:03:12 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13N61fZM040368;
        Fri, 23 Apr 2021 01:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1619157701;
        bh=JS5f/cXLKR+nDFCrXUPQLAttffTxFh/lfPdsd+o09is=;
        h=From:To:CC:Subject:Date;
        b=n30RsWFlRDIyaXOcAPqTpyJc6W3BNfNWBIdkfEaPajuyBMa5df/qnhBVV/shh9gFM
         pwu1Ed8Fs/di1D/h+IwC0B5ohrZthxWsxlMkh5R8PGQCazGan2w83OuLNHy1Mylbg/
         Ag6JXDga5/QKFkFNHRX122BFTdzxyozJwFyZeKz0=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13N61fZj034103
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Apr 2021 01:01:41 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 23
 Apr 2021 01:01:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 23 Apr 2021 01:01:40 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13N61aYh014429;
        Fri, 23 Apr 2021 01:01:36 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-am64-mcu: Fix the compatible string in GPIO DT node
Date:   Fri, 23 Apr 2021 11:31:33 +0530
Message-ID: <20210423060133.16473-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the compatible string in mcu domain GPIO device tree node.

Fixes: 01a91e01b8fd ("arm64: dts: ti: k3-am64: Add GPIO DT nodes")
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
index 99e94dee1bd4..892db8229f77 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
@@ -86,7 +86,7 @@
 	};
 
 	mcu_gpio0: gpio@4201000 {
-		compatible = "ti,am64-gpio", "keystone-gpio";
+		compatible = "ti,am64-gpio", "ti,keystone-gpio";
 		reg = <0x0 0x4201000 0x0 0x100>;
 		gpio-controller;
 		#gpio-cells = <2>;
-- 
2.17.1

