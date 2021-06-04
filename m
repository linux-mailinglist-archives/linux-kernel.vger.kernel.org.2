Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1C139BD74
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhFDQpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:45:18 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34988 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDQpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:45:16 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 154GhMPJ093166;
        Fri, 4 Jun 2021 11:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622825002;
        bh=Q4fwlcTV+UfFIP59ocRNpSmIcNZ5COysLR/B5UGpX4k=;
        h=From:To:CC:Subject:Date;
        b=ngl/+cP/qNlvOAw0foSGXmWi6kElTKqi0nwhpVdinw48DAvEz2UjOZuV7cnD6gFq0
         +8Wg8H3IzUDFnBdxj8XGe4rGjlO2VfiIE5sODtPJkmx56ONJ05R8AxCwHcdPbIahr3
         AIdFDOR1Vn695VgtMJARn6+pkt1CimKySFqSFvxc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 154GhMcB047238
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Jun 2021 11:43:22 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 4 Jun
 2021 11:43:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 4 Jun 2021 11:43:21 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 154GhCtf063841;
        Fri, 4 Jun 2021 11:43:14 -0500
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
Subject: [PATCH] arm64: dts: ti: k3-am64-main: Update the location of ATF in SRAM and increase its max size
Date:   Fri, 4 Jun 2021 22:13:08 +0530
Message-ID: <20210604164308.16693-1-a-govindraju@ti.com>
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

Link to corresponding U-Boot series that makes the ATF load address update,
- https://patchwork.ozlabs.org/project/uboot/list/?series=247265

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index ca59d1f711f8..7ae28992097f 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -14,7 +14,7 @@
 		ranges = <0x0 0x00 0x70000000 0x200000>;
 
 		atf-sram@0 {
-			reg = <0x0 0x1a000>;
+			reg = <0x1a0000 0x1c000>;
 		};
 	};
 
-- 
2.17.1

