Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5C9418454
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 22:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhIYUQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 16:16:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44278 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhIYUQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 16:16:24 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18PKEYaU113950;
        Sat, 25 Sep 2021 15:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1632600874;
        bh=/1jPd7WHAI+xtbx6c8NPVzIAgJhqiImg83mHTfa424s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rsI7yiyOtcLZCWyIEZbvqtcvkb1f0j8zICO5fWl3wWzONUBE3TjML+wkyvdm8p/ad
         KnWwpBb0hgCICO3XIfDwxdEDiyRInRwulO5UGy1jwgQHCuI9t2JnydVI8qxsaUjDp8
         x0BgbG0I142M/CkO6gn6VO7rTSLSxY06SKDJ62zA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18PKEYoM130216
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 25 Sep 2021 15:14:34 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 25
 Sep 2021 15:14:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 25 Sep 2021 15:14:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18PKEYE4019215;
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
Subject: [PATCH V2 3/4] arm64: dts: ti: k3-j721e-common-proc-board: Add j721e-evm compatible
Date:   Sat, 25 Sep 2021 15:14:29 -0500
Message-ID: <20210925201430.11678-4-nm@ti.com>
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

Add j721e-evm compatible to the board to allow the board to distinguish
itself from other platforms that are pending to be added.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Changes in V2:
* no change

V1: https://lore.kernel.org/all/20210915121937.27702-3-nm@ti.com/

 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 8bd02d9e28ad..dc2bc67f9f48 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -12,6 +12,9 @@
 #include <dt-bindings/phy/phy-cadence.h>
 
 / {
+	compatible = "ti,j721e-evm", "ti,j721e";
+	model = "Texas Instruments J721e EVM";
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
-- 
2.32.0

