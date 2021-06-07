Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5692339DDD0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhFGNkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:40:15 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45572 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhFGNkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:40:10 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 157DcDND063671;
        Mon, 7 Jun 2021 08:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623073093;
        bh=zg08DIEdTQ/WvsmZgoAmyQMxsRdgVebwT1zZYza8y74=;
        h=From:To:CC:Subject:Date;
        b=ruEgLhMYCFHFT9QiAF9g0VCroVCw3lug6ad0OV1Wt/V8SukEKiLRuCgsRlziOdstq
         +s8HBlPg9gnYH0aBKGL+3UzkIHA6nA2qR5HbfeB7qGy4PJBtSWk2QgRGMHgR2Mxtbm
         QRHCv7rc9EQCBpdtTceo3xG4LusxB+1N46IMVP2Q=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 157DcDG2062686
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jun 2021 08:38:13 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 7 Jun
 2021 08:38:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 7 Jun 2021 08:38:13 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 157Dc8a5031333;
        Mon, 7 Jun 2021 08:38:09 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Suman Anna <s-anna@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] arm64: dts: ti: k3-am64-main: Update the location of ATF in SRAM and increase its max size
Date:   Mon, 7 Jun 2021 19:08:06 +0530
Message-ID: <20210607133806.18158-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a limitation for USB DFU boot mode, SPL load address has to be less
than  or equal to 0x70001000. So, load address of SPL and ATF have been
moved to 0x70000000 and 0x701a0000 respectively.

Also, the maximum size of ATF has been increased to 0x1c000 [1].

Therefore, update ATF's location and maximum size accordingly in the device
tree file.

[1] - https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/?id=2fb5312f61a7de8b7a70e1639199c4f14a10b6f9

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index ca59d1f711f8..fcd12b6f10f6 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -13,8 +13,8 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x00 0x70000000 0x200000>;
 
-		atf-sram@0 {
-			reg = <0x0 0x1a000>;
+		atf-sram@1a0000 {
+			reg = <0x1a0000 0x1c000>;
 		};
 	};
 
-- 
2.17.1

