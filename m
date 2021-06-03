Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723B539A35D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 16:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhFCOgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:36:39 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47538 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhFCOgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:36:38 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 153EYltI016340;
        Thu, 3 Jun 2021 09:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622730887;
        bh=CXQ219sIhzufVqYmdFjr2+cNFsKpGGu6R4uLYhnkW8o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Xun2lmMO8tsHh6luQ0LGGs3OW18UlnlBNyjPuLoUfEG6cDn4CzurWVvR8mwemy/Xe
         lc3YB2SBjkP0EGM/T5cZ/BmH4ySj+Amfgr1shmceP1KZrdRJqyhYuDmc2wdQbdSdIa
         MYR7HUss8jSLSNhBzrjavrg4ySie0E5WvullkSrw=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 153EYlSp097114
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Jun 2021 09:34:47 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 3 Jun
 2021 09:34:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 3 Jun 2021 09:34:47 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 153EYRDM011740;
        Thu, 3 Jun 2021 09:34:44 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 4/4] arm64: dts: ti: k3-j721e-common-proc-board: Re-name "link" name as "phy"
Date:   Thu, 3 Jun 2021 20:04:27 +0530
Message-ID: <20210603143427.28735-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210603143427.28735-1-kishon@ti.com>
References: <20210603143427.28735-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 66db854b1f62d ("arm64: dts: ti: k3-j721e-common-proc-board:
Configure the PCIe instances") and
commit 02c35dca2b488 ("arm64: dts: ti: k3-j721e: Enable Super-Speed
support for USB0") added PHY DT nodes with node name as "link"
However nodes with #phy-cells should be named 'phy' as discussed in [1].
Re-name subnodes of serdes in J721E to 'phy'.

[1] -> http://lore.kernel.org/r/20200909203631.GA3026331@bogus
Fixes: 66db854b1f62d ("arm64: dts: ti: k3-j721e-common-proc-board: Configure the PCIe instances")
Fixes: 02c35dca2b488 ("arm64: dts: ti: k3-j721e: Enable Super-Speed support for USB0")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 1b25a5ae9635..ffccbc53f1e7 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -359,7 +359,7 @@
 };
 
 &serdes3 {
-	serdes3_usb_link: link@0 {
+	serdes3_usb_link: phy@0 {
 		reg = <0>;
 		cdns,num-lanes = <2>;
 		#phy-cells = <0>;
@@ -674,7 +674,7 @@
 	assigned-clocks = <&serdes0 CDNS_SIERRA_PLL_CMNLC>;
 	assigned-clock-parents = <&wiz0_pll1_refclk>;
 
-	serdes0_pcie_link: link@0 {
+	serdes0_pcie_link: phy@0 {
 		reg = <0>;
 		cdns,num-lanes = <1>;
 		#phy-cells = <0>;
@@ -687,7 +687,7 @@
 	assigned-clocks = <&serdes1 CDNS_SIERRA_PLL_CMNLC>;
 	assigned-clock-parents = <&wiz1_pll1_refclk>;
 
-	serdes1_pcie_link: link@0 {
+	serdes1_pcie_link: phy@0 {
 		reg = <0>;
 		cdns,num-lanes = <2>;
 		#phy-cells = <0>;
@@ -700,7 +700,7 @@
 	assigned-clocks = <&serdes2 CDNS_SIERRA_PLL_CMNLC>;
 	assigned-clock-parents = <&wiz2_pll1_refclk>;
 
-	serdes2_pcie_link: link@0 {
+	serdes2_pcie_link: phy@0 {
 		reg = <0>;
 		cdns,num-lanes = <2>;
 		#phy-cells = <0>;
-- 
2.17.1

