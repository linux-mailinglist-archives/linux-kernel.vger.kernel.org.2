Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA1E3150C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhBINtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:49:52 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:44772 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231706AbhBINrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:47:37 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119Dk9CM022658;
        Tue, 9 Feb 2021 05:46:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=WPavP26DKZ05Jmrq/qASLQHWFNCPXboM76wEZXomdjk=;
 b=Qcy+NzfJg+CmaS+Ha810CgNHAzfet527DQ88W123JqqiqqeAjyNP7T81w+/zudxJ3X9W
 hhGS3T/3yykXyw3ueyVPgbULSX2/QnNuo8UopLe2uW9D87lu55u0To7a62i3NgJec9F6
 UwHxU3nglqpWOtXXrRhP3iVSL/SgeuyIo5gSWoCpLYzemmkf9Y/FOixHso46uG669mTa
 s8Rwxi49Dg6iambOVkTAf7GVWPTpEhcyZymd06nhsWz3HIV0Ekxe8uWe9qi4TyWrszFN
 Lk67P6craMQ4ybOW2peKVZJDGuZUV9OHG/jy/z8neAD+2NwhF5F1UEdhaDCN5Ml3h+Fi 7w== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 36hsbrgcnx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 05:46:40 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 9 Feb
 2021 05:46:39 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 9 Feb
 2021 05:46:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 9 Feb 2021 05:46:38 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 5F3F13F703F;
        Tue,  9 Feb 2021 05:46:34 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <vladimir.vid@sartura.hr>, <tmn505@gmail.com>,
        <luka.kovacic@sartura.hr>, <sebastian.hesselbarth@gmail.com>,
        <gregory.clement@bootlin.com>, <andrew@lunn.ch>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>, <kishon@ti.com>,
        <miquel.raynal@bootlin.com>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v4 1/5] Documentation/bindings: phy: update references to cp11x
Date:   Tue, 9 Feb 2021 15:46:06 +0200
Message-ID: <20210209134610.19904-2-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210209134610.19904-1-kostap@marvell.com>
References: <20210209134610.19904-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_03:2021-02-09,2021-02-09 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grzegorz Jaszczyk <jaz@semihalf.com>

The cp11x references in dts has changed, reflect it in comphy
documentation.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt b/Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt
index 8c60e6985950..5ffd0f55d010 100644
--- a/Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt
+++ b/Documentation/devicetree/bindings/phy/phy-mvebu-comphy.txt
@@ -42,22 +42,22 @@ Required properties (child nodes):
 
 Examples:
 
-	cpm_comphy: phy@120000 {
+	CP11X_LABEL(comphy): phy@120000 {
 		compatible = "marvell,comphy-cp110";
 		reg = <0x120000 0x6000>;
-		marvell,system-controller = <&cpm_syscon0>;
-		clocks = <&CP110_LABEL(clk) 1 5>, <&CP110_LABEL(clk) 1 6>,
-			 <&CP110_LABEL(clk) 1 18>;
+		marvell,system-controller = <&CP11X_LABEL(syscon0)>;
+		clocks = <&CP11X_LABEL(clk) 1 5>, <&CP11X_LABEL(clk) 1 6>,
+			 <&CP11X_LABEL(clk) 1 18>;
 		clock-names = "mg_clk", "mg_core_clk", "axi_clk";
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpm_comphy0: phy@0 {
+		CP11X_LABEL(comphy0): phy@0 {
 			reg = <0>;
 			#phy-cells = <1>;
 		};
 
-		cpm_comphy1: phy@1 {
+		CP11X_LABEL(comphy1): phy@1 {
 			reg = <1>;
 			#phy-cells = <1>;
 		};
-- 
2.17.1

