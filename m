Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD97E3796CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 20:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhEJSHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 14:07:22 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35770 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbhEJSHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 14:07:21 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14AI6AhD126158;
        Mon, 10 May 2021 13:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620669970;
        bh=+ymKHzTttndT+GEoa/+WOh5EyYjEL3llmrmJjo9sJG4=;
        h=From:To:CC:Subject:Date;
        b=cFv4+DPMH6WNLBF+4CT0fVK8vALHVHAnWqJWilcv6yTgTWdNOpmC/MUX72woLKaEs
         K30nRtRIGRj1L8c7EBcVgaOu59PhdEX/cXg+cqvKeFapdu/N65NI3zGTiya6pNwVRY
         HG8SgfoGxJ2K2D6vVfFPH9bxtF54pZLa2x9mTHYI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14AI6Aq3066625
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 May 2021 13:06:10 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 10
 May 2021 13:06:09 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 10 May 2021 13:06:09 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14AI66K3001704;
        Mon, 10 May 2021 13:06:07 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@gmail.com>,
        <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2] arm64: dts: ti: j7200-main: Mark Main NAVSS as dma-coherent
Date:   Mon, 10 May 2021 23:36:01 +0530
Message-ID: <20210510180601.19458-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Traffic through main NAVSS interconnect is coherent wrt ARM caches on
J7200 SoC.  Add missing dma-coherent property to main_navss node.

Also add dma-ranges to be consistent with mcu_navss node
and with AM65/J721e main_navss and mcu_navss nodes.

Fixes: d361ed88455fe ("arm64: dts: ti: Add support for J7200 SoC")
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---

v2:
Pick up Reviewed-by and update commit msg as suggested by Peter
v1: https://lore.kernel.org/r/20210427175130.29451-1-vigneshr@ti.com

 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index f86c493a44f1..a6826f1888ef 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -85,6 +85,8 @@ main_navss: bus@30000000 {
 		#size-cells = <2>;
 		ranges = <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
 		ti,sci-dev-id = <199>;
+		dma-coherent;
+		dma-ranges;
 
 		main_navss_intr: interrupt-controller1 {
 			compatible = "ti,sci-intr";
-- 
2.31.1

