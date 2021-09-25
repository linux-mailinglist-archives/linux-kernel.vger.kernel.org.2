Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AD741844C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 22:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhIYUQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 16:16:22 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45092 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhIYUQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 16:16:22 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18PKEY8p106719;
        Sat, 25 Sep 2021 15:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632600874;
        bh=QNBHi5+0FNCIPxmxLfNSiYlxzhsum00YH6IaFTLHtOk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iVCcaZpFPoaXv7V2b6flgmgEWMy3aQTe2ZMFbpmwHs3dulsqogpTgg0DCzVXXgPrV
         Tq2YTJ9xcMeSYhwChg7VaFxuTejHu/Icy6TFJ2AWStKec/Nqgn1Ip68AVaqxFenOFM
         R/8i00XxUb23CNzleavOtj/dozWL63fl+FkyZqdQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18PKEYfE130222
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 25 Sep 2021 15:14:34 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 25
 Sep 2021 15:14:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 25 Sep 2021 15:14:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18PKEYmD075489;
        Sat, 25 Sep 2021 15:14:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>,
        Hari Nagalla <hnagalla@ti.com>,
        Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 4/4] arm64: dts: ti: k3-j7200-common-proc-board: Add j7200-evm compatible
Date:   Sat, 25 Sep 2021 15:14:30 -0500
Message-ID: <20210925201430.11678-5-nm@ti.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210925201430.11678-1-nm@ti.com>
References: <20210925201430.11678-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add j7200-evm compatible to the board to allow the board to distinguish
itself from other platforms that may be added in the future.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Changes in V2:
* no change

V1: https://lore.kernel.org/all/20210915121937.27702-4-nm@ti.com/

 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index d14f3c18b65f..121975dc8239 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -12,6 +12,9 @@
 #include <dt-bindings/phy/phy.h>
 
 / {
+	compatible = "ti,j7200-evm", "ti,j7200";
+	model = "Texas Instruments J7200 EVM";
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
-- 
2.32.0

