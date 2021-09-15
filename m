Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6886940C513
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbhIOMVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:21:03 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58726 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbhIOMVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:21:00 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18FCJchP091566;
        Wed, 15 Sep 2021 07:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631708378;
        bh=ZVU2ZQLO8yOm95K2Q1ratQNPp8CFKFYo2ZO9PRMQogU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=w2tlOT3jVMiVfeyPL4Uf487baEsDsmfG+aBHt4hpDclwqPDpjtVRrQihxCyUTeYXA
         kcMho3bFwlXQZNpmuLeLN3AgudnYu0noeDHGpnAf++QjnjDMPjVYtukX0oUfy8zzMv
         crnn44u2rcW+QtXnbsYg+j3Vh83zEY09sCcYIVAQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18FCJck0089483
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Sep 2021 07:19:38 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Sep 2021 07:19:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Sep 2021 07:19:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18FCJcAZ046598;
        Wed, 15 Sep 2021 07:19:38 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/3] arm64: dts: ti: k3-j7200-common-proc-board: Add j7200-evm compatible
Date:   Wed, 15 Sep 2021 07:19:37 -0500
Message-ID: <20210915121937.27702-4-nm@ti.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210915121937.27702-1-nm@ti.com>
References: <20210915121937.27702-1-nm@ti.com>
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

