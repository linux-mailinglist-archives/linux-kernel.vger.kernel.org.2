Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12D333B1FE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhCOMCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:02:40 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40960 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhCOMCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:02:39 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12FC22Vn102713;
        Mon, 15 Mar 2021 07:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615809723;
        bh=COdTv/ZGsNPK/GmGVU7hagCz94OpO7DfNJkDILPdWVw=;
        h=From:To:CC:Subject:Date;
        b=sMaoDIVAuLTLM8rjmswjPz0P9O99xmDd8FwN1FpwJw7zvEZdDFI9zaYvvo3GnhP6O
         xfNicyV9TBDMTdQ+Zyl1sScjc+fAdRULsSuOYZeyRFjUx3GLtDJgki1zOSTc5BlbPP
         7e+LrZY1Kyn/xMs97jeS4+GKb5MIoqrj8XW2GJVY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12FC22kl062345
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Mar 2021 07:02:02 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 15
 Mar 2021 07:02:02 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 15 Mar 2021 07:02:02 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12FC1xvJ088838;
        Mon, 15 Mar 2021 07:01:59 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [RESEND PATCH 1/2] arm64: dts: ti: k3-am64-main: Add OSPI node
Date:   Mon, 15 Mar 2021 17:31:48 +0530
Message-ID: <20210315120149.10606-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM64 SoC has a single Octal SPI (OSPI) instance under Flash SubSystem
(FSS).  Add DT entry for the same.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
Resend:
Rebase onto latest -next

v1: lore.kernel.org/r/20210309130514.11740-1-vigneshr@ti.com

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 1f33b8d0080b..d914a58680aa 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -508,4 +508,29 @@ adc {
 			compatible = "ti,am654-adc", "ti,am3359-adc";
 		};
 	};
+
+	fss: bus@fc00000 {
+		compatible = "simple-bus";
+		reg = <0x00 0x0fc00000 0x00 0x70000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ospi0: spi@fc40000 {
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
+			reg = <0x00 0x0fc40000 0x00 0x100>,
+			      <0x05 0x00000000 0x01 0x00000000>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x0>;
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			clocks = <&k3_clks 75 6>;
+			assigned-clocks = <&k3_clks 75 6>;
+			assigned-clock-parents = <&k3_clks 75 7>;
+			assigned-clock-rates = <166666666>;
+			power-domains = <&k3_pds 75 TI_SCI_PD_EXCLUSIVE>;
+		};
+	};
 };
-- 
2.30.2

