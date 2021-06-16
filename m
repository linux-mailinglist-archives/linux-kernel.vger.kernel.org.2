Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F2B3AA23A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 19:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhFPRP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 13:15:27 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52086 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhFPRPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 13:15:25 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15GHDHB9020090;
        Wed, 16 Jun 2021 12:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623863597;
        bh=53le9wb2XHFlNWcBLheLgmca8E61IDkPyOy8gz1smJg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DgKPxw7H/ymsGUXhttpGd/YFudwK8e5yDmeW+BcbgF6CRcKq1ScA+wio1eWy1TfA1
         feloWUQd1Mad8+O3lF2MkF20VJr5LKSB1dGh7ZyxshT5W97OmDuNiDfriao1OOqQOX
         8tVeLCctksQ2EfGek5wgIc9uxdBeV8sN49wE72Vw=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15GHDHAv011996
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jun 2021 12:13:17 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 16
 Jun 2021 12:13:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 16 Jun 2021 12:13:16 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15GHCSuE106909;
        Wed, 16 Jun 2021 12:13:07 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Suman Anna <s-anna@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 3/3] arm64: dts: ti: k3-am64-main: Update the location of TF-A in compliance with U-Boot v2021.10
Date:   Wed, 16 Jun 2021 22:42:24 +0530
Message-ID: <20210616171224.24635-4-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210616171224.24635-1-a-govindraju@ti.com>
References: <20210616171224.24635-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a limitation for USB DFU boot mode, SPL load address has to be less
than  or equal to 0x70001000. So, load address of SPL and TF-A have been
moved to 0x70000000 and 0x701c0000 respectively, in U-Boot version 2021.10.

Therefore, update TF-A's location in the device tree node.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 27888ee6f039..62d2b8fff67d 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -24,8 +24,8 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x00 0x70000000 0x200000>;
 
-		tfa-sram@0 {
-			reg = <0x0 0x20000>;
+		tfa-sram@1c0000 {
+			reg = <0x1c0000 0x20000>;
 		};
 
 		dmsc-sram@1e0000 {
-- 
2.17.1

