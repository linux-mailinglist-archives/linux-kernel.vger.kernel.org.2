Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE853167C2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhBJNRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:17:45 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:31642 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231649AbhBJNRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:17:12 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11ADGHEI013118;
        Wed, 10 Feb 2021 05:16:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=WPavP26DKZ05Jmrq/qASLQHWFNCPXboM76wEZXomdjk=;
 b=EhI2Gb380F1AtPmHh30+I4D4J7GlyRGDeWx9xzv0YkXsnO86PHZWKeldUVBET+E9+7gL
 fe1EtORGAqeQifeXtAtcfzMFZQMNPEbOCCk1coScMJwKMBN3Cb/LZUlwiCBrDGPxUVhh
 sgGjGyyIC+vX1hWHtJL87bSSfbs4yNULoU0/mrSAFXotdzdOHWnP7tRBcTygRVPA5kYk
 bTQe08Thr44dgnbUzzDV4EPuvOLPG5XwbZOnLQwbOOVgjk0uUCnOqDitjLaLUE85jbhw
 c7aN1lSIJ1CT6l3K1J5ILsy1KWXdvwrWiGLoFoF22ozMWhVn/t5Gt/DYHF6Tg4SWryO3 5w== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 36hsbrkw8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 05:16:17 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 05:16:16 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Feb 2021 05:16:16 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 1D4893F703F;
        Wed, 10 Feb 2021 05:16:11 -0800 (PST)
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
Subject: [PATCH v5 1/5] Documentation/bindings: phy: update references to cp11x
Date:   Wed, 10 Feb 2021 15:16:00 +0200
Message-ID: <20210210131604.28806-2-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210210131604.28806-1-kostap@marvell.com>
References: <20210210131604.28806-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_05:2021-02-10,2021-02-10 signatures=0
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

