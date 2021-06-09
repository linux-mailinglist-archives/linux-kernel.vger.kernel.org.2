Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8640E3A169F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbhFIOI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:08:26 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42832 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbhFIOIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:08:18 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 159E6KRi050340;
        Wed, 9 Jun 2021 09:06:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623247580;
        bh=yb8Sxqxy99dpc2ubYDYTp0LMBNhTC8C2NS2ZuUFEc9o=;
        h=From:To:CC:Subject:Date;
        b=JD4dmsDKqe3zYJIzbkmZJrDT8s1p7HAYe1fSSWhtY+e2DRctHyVEbS7k57xIAj0wY
         6YhVg2IKrMSdBf+ktV5F1XKhUZTRqX6mgo8oDn9QQDBHnLg0uqaF+yVA80P76rSVTL
         A5pKNvzTtLa4E4EbPuWwbHPNtyjY6txvnHHpORnA=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 159E6KWp049606
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jun 2021 09:06:20 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 9 Jun
 2021 09:06:20 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 9 Jun 2021 09:06:20 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 159E6H2d067032;
        Wed, 9 Jun 2021 09:06:18 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: dts: ti: k3-am64-main: Add SYSFW reserved ranges in OCRAM
Date:   Wed, 9 Jun 2021 19:36:04 +0530
Message-ID: <20210609140604.9490-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.31.1
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
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index f1c42ef05e52..77b88e536534 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -16,6 +16,10 @@ oc_sram: sram@70000000 {
 		atf-sram@0 {
 			reg = <0x0 0x1a000>;
 		};
+
+		dmsc-sram@1c0000 {
+			reg = <0x1c0000 0x40000>;
+		};
 	};
 
 	gic500: interrupt-controller@1800000 {
-- 
2.31.1

