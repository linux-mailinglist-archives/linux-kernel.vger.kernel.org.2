Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478533A4964
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhFKTTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:19:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38046 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhFKTTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:19:38 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15BJHb9r091096;
        Fri, 11 Jun 2021 14:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623439057;
        bh=P2KjPLpwAgrHduRLM/60JQJ9qmLjFro2RPdh8dds/Kk=;
        h=From:To:CC:Subject:Date;
        b=aZ07JKP6HRIf6NjKp6PHjDksTZW4L81vGCmDdt2r9zd4WYKs0DijFrMY9L6THgLGi
         Rjbqgr62oF46byDDn+kg4EScnUH3jS/u56hSk1FUiEUNCXivg0ZFxp7da4dHdi1ZIb
         3XGn8guTB5+CxyOEv8vfMU/QQk1MAczjDiM7YX/s=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15BJHafM119564
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jun 2021 14:17:37 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 11
 Jun 2021 14:17:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 11 Jun 2021 14:17:36 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15BJHXS0002846;
        Fri, 11 Jun 2021 14:17:34 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-am64-main: Add SYSFW reserved ranges in OCRAM
Date:   Sat, 12 Jun 2021 00:47:18 +0530
Message-ID: <20210611191718.20065-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last 256K of OCRAM (256K@0x701c0000) is reserved for SYSFW usage. Hence
add an entry in DT so that its not used for generic pool memory
allocation.

Without this certain drivers using SRAM as generic shared memory pool
may end up being allocated memory from this range and will lead to boot
time crash when the reserved range is accessed (due to firewall
violation).

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
---

v2:
Rebase onto latest ti-k3-next
Collect R-by

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 309826bf46b3..b731119f58ca 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -27,6 +27,10 @@ oc_sram: sram@70000000 {
 		atf-sram@1a0000 {
 			reg = <0x1a0000 0x1c000>;
 		};
+
+		dmsc-sram@1c0000 {
+			reg = <0x1c0000 0x40000>;
+		};
 	};
 
 	main_conf: syscon@43000000 {
-- 
2.32.0

