Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF2A36CAA9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238873AbhD0Rw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:52:56 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50516 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238394AbhD0Rwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:52:54 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13RHpwwq032788;
        Tue, 27 Apr 2021 12:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1619545918;
        bh=WxlZWJTNgIPhmFWeaV5D6iM6qCshbWaA6MZx0N0wYgo=;
        h=From:To:CC:Subject:Date;
        b=At3DWtXS3WOCHtkd7QNtdKC/TGhwqRiUMhbQceBMovoJYLkU/PdU8hN5+LBy9RCvu
         /3Wezww83LCezS18M+ZMvRfRL+MIdZjxSlZCNQm2QsVkqsF+KBVIJrJC1+mIUHyNOF
         86wCABDA6E0kY0b5eAkk2MNbWvvXN2QHC0eUhaMM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13RHpwPX078303
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Apr 2021 12:51:58 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 27
 Apr 2021 12:51:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 27 Apr 2021 12:51:58 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13RHptMR026486;
        Tue, 27 Apr 2021 12:51:56 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: ti: j7200-main: Mark Main NAVSS as dma-coherent
Date:   Tue, 27 Apr 2021 23:21:30 +0530
Message-ID: <20210427175130.29451-1-vigneshr@ti.com>
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

Also add dma-ranges to be consistent with mcu_navss node.

Fixes: d361ed88455fe ("arm64: dts: ti: Add support for J7200 SoC")
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index f86c493a44f1c..a6826f1888ef0 100644
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

