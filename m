Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393F237C403
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 17:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbhELP1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 11:27:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35670 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbhELPNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:13:42 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14CFCV5P009380;
        Wed, 12 May 2021 10:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620832351;
        bh=CXQ219sIhzufVqYmdFjr2+cNFsKpGGu6R4uLYhnkW8o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xSHmTpjVAdkOUDzBSHCrtVfEXM2py7VGUFjlUxsiHvsA96UX6+7c7exxFmSYgDgw0
         rRoqPu2ox1qo1+VrQNgHHZdT6uQiGqLcLX9hgRxk8H9jF7RPoAKhWHCh8yPAJ8cQKL
         2qpxEUhr6zB4lxFBAigy1mLecA1tvv+550ThukR8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14CFCVS5006144
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 May 2021 10:12:31 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 12
 May 2021 10:12:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 12 May 2021 10:12:31 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14CFCAIq005491;
        Wed, 12 May 2021 10:12:28 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 4/4] arm64: dts: ti: k3-j721e-common-proc-board: Re-name "link" name as "phy"
Date:   Wed, 12 May 2021 20:42:09 +0530
Message-ID: <20210512151209.27560-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210512151209.27560-1-kishon@ti.com>
References: <20210512151209.27560-1-kishon@ti.com>
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

