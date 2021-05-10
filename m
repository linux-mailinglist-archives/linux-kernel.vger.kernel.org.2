Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB7E379134
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242327AbhEJOpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:45:55 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49628 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343683AbhEJOo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:44:26 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14AEhD3c050713;
        Mon, 10 May 2021 09:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620657793;
        bh=mboloecEt7zpcUJX9MGcVgdbvpk/j/gHxod2xui5w9k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GEg9Q/LwzDzVdqvxXVhwDzbo/yzxZorAI/1N+O9OcmpyaaRl008SQm0QKCxGDsxDM
         4g11i5NbS8qxNXYrkV0DkdzUE5Z3SBunDfWy/0AMMwzYHXtmsyayVJGFEhKm1OZo0q
         hWnh+vaPwIcM1iBRYDvoMlt0W4AUVIlPX4QuGUqI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14AEhD7D057873
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 May 2021 09:43:13 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 10
 May 2021 09:43:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 10 May 2021 09:43:13 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14AEhDVp126640;
        Mon, 10 May 2021 09:43:13 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kristo@kernel.org>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH 4/4] ARM: dts: keystone: k2g-evm: Move audio oscillator assigned clock to mcasp
Date:   Mon, 10 May 2021 09:43:12 -0500
Message-ID: <20210510144312.986-5-nm@ti.com>
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

Setting assigned clock with a dependency on itself for k2g_clks
creates a circular dependency. Instead, Lets model the audio clock
as a assigned-clock configuration for mcasp and set it up as the
first clock assigned-clock to be satisfied. Following the standard
convention, we use null entries to indicate entries that doesn't need
to be programmed.

References:
[1] schematics: https://www.ti.com/lit/df/sprr302/sprr302.pdf
[2] TRM: https://www.ti.com/lit/ug/spruhy8i/spruhy8i.pdf

Signed-off-by: Nishanth Menon <nm@ti.com>
---
yaml fixup series:
https://lore.kernel.org/linux-arm-kernel/20210503190824.GA2192378@robh.at.kernel.org

Specific yaml:
https://lore.kernel.org/linux-arm-kernel/20210426155457.21221-3-nm@ti.com/

 arch/arm/boot/dts/keystone-k2g-evm.dts | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index 14e26a4fd62a..d800f26b6275 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -544,20 +544,15 @@ dpi_out: endpoint {
 	};
 };
 
-&k2g_clks {
-	/* on the board 22.5792MHz is connected to AUDOSC_IN */
-	assigned-clocks = <&k2g_clks 0x4c 2>;
-	assigned-clock-rates = <22579200>;
-};
-
 &mcasp2 {
 	#sound-dai-cells = <0>;
 
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcasp2_pins>;
 
-	assigned-clocks = <&k2g_clks 0x6 1>;
-	assigned-clock-parents = <&k2g_clks 0x6 2>;
+	assigned-clocks = <&k2g_clks 0x4c 2>, <&k2g_clks 0x6 1>;
+	assigned-clock-parents = <0>, <&k2g_clks 0x6 2>;
+	assigned-clock-rates = <22579200>, <0>;
 
 	status = "okay";
 
-- 
2.31.0

