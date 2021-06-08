Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7B53A0210
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbhFHTAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:00:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44990 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235795AbhFHSvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:51:52 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 158Inndx080929;
        Tue, 8 Jun 2021 13:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623178189;
        bh=XFmvnR4Sp9qLoZE86AyC7J5ZSl2Xb2RCdaI+k6DBZjY=;
        h=From:To:CC:Subject:Date;
        b=yaG/RTDBfzSBMwBK9EDSfdoN3rvAi5WCHslPVNGgmjGP4VXJpxqqcfizZTJRzEBQ1
         tavaxMEMXeZQjkvePue012n1v5CtbjmN41lne3Zc+ukbdJAAXHO2SqqBUQ1e8TCsvP
         bmCgOBk3wY4Cx7bDc6+DKNNgM9uaaYJKrF9x9WEY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 158InnR9101654
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Jun 2021 13:49:49 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 8 Jun
 2021 13:49:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 8 Jun 2021 13:49:48 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 158InlxD043167;
        Tue, 8 Jun 2021 13:49:47 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am642-main: fix ports mac properties
Date:   Tue, 8 Jun 2021 21:49:40 +0300
Message-ID: <20210608184940.25934-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current device tree CPSW3g node adds non-zero "mac-address" property to
the ports, which prevents random MAC address assignment to network devices
if bootloader failed to update DT. This may cause more then one host to
have the same MAC in the network.

 mac-address = [00 00 de ad be ef];
 mac-address = [00 01 de ad be ef];

In addition, there is one MAC address available in eFuse registers which
can be used for default port 1.

Hence, fix ports MAC properties by:
- resetting "mac-address" property to 0
- adding ti,syscon-efuse = <&main_conf 0x200> to Port 1

Fixes: 3753b12877b6 ("arm64: dts: ti: k3-am64-main: Add CPSW DT node")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index effb9d2e3c25..7f7178a7a055 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -514,7 +514,8 @@
 				ti,mac-only;
 				label = "port1";
 				phys = <&phy_gmii_sel 1>;
-				mac-address = [00 00 de ad be ef];
+				mac-address = [00 00 00 00 00 00];
+				ti,syscon-efuse = <&main_conf 0x200>;
 			};
 
 			cpsw_port2: port@2 {
@@ -522,7 +523,7 @@
 				ti,mac-only;
 				label = "port2";
 				phys = <&phy_gmii_sel 2>;
-				mac-address = [00 01 de ad be ef];
+				mac-address = [00 00 00 00 00 00];
 			};
 		};
 
-- 
2.17.1

