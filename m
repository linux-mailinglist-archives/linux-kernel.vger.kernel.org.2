Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909AC3BF8ED
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhGHL2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 07:28:51 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:26696 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231724AbhGHL2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:28:46 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168BB6Xg023087;
        Thu, 8 Jul 2021 04:25:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=WPavP26DKZ05Jmrq/qASLQHWFNCPXboM76wEZXomdjk=;
 b=GYAxR8Ly9Uq2RCtRJmmg5TB6jCIRzWrKtK+8+qKKlGzunGcZJQXLeNQJ6UwJ/UT52l4E
 IjQVltQUXmMVg0+U1MdXpQW/Fl2dEXiqTTrjczxWdU63vnS5ehFIx7ALtxBSluJjoTsf
 GSlvU+jgrC6ghqoWLRmaJb3mYa9+u5lNmTbnvjvwrslxy5Dp1GY44qqNauQrEPKywTiT
 K0CoDZp6Tiq4HMqKBeiwCA+QMlqgbApuJWzv7nxNs8OhIGRhXYfugUWm0gPdBYRieXZa
 ZLogjYN/iUlm15ZiaFch+TMiI6H/YcInWHRk7HZkIuG+FxJXSUmV9A2IcB9DJ1X5yZ5K 5w== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 39ny0g89p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 08 Jul 2021 04:25:55 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 8 Jul
 2021 04:25:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 8 Jul 2021 04:25:52 -0700
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 13C323F7065;
        Thu,  8 Jul 2021 04:25:47 -0700 (PDT)
From:   <kostap@marvell.com>
To:     <miquel.raynal@bootlin.com>, <kishon@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <vladimir.vid@sartura.hr>, <luka.kovacic@sartura.hr>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <mw@semihalf.com>, <jaz@semihalf.com>, <nadavh@marvell.com>,
        <stefanc@marvell.com>, <bpeled@marvell.com>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH v6 1/5] Documentation/bindings: phy: update references to cp11x
Date:   Thu, 8 Jul 2021 14:25:24 +0300
Message-ID: <20210708112528.3254-2-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210708112528.3254-1-kostap@marvell.com>
References: <20210708112528.3254-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vq0hwm8PogmnyT1sBXmofF6RLIzjDcjc
X-Proofpoint-GUID: vq0hwm8PogmnyT1sBXmofF6RLIzjDcjc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-08_06:2021-07-06,2021-07-08 signatures=0
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

