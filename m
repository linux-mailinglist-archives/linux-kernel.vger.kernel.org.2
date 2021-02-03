Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A686430DB59
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhBCNdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:33:39 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:34246 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232151AbhBCNcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:32:54 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 113DV0xa020044;
        Wed, 3 Feb 2021 05:31:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=/VbT86Gx7coUfqGHQsFFpkykvtG7fI0zWwrJPr9Bopw=;
 b=ZZzx5Vzei4IBWTqi4Pa2FxnrI6i+VAMM8TDhcu+P2iPw4LAKgqjLCFO1ENrnu+lHXg2P
 /rTTDB5fb6YggYJaNrLFeS3VQo0vLjTV5zIPVqa/v1hniqOGXrzy9C+8Rsc/lblQQYUC
 kDrJs/sXE9s35t5g+h4hLm592dtE7Y31W5qVuh93uVYjYk9zFmiVBbxjrxIHaVbS6+/w
 0YFspN9MtykMDdxDcerZh0VOpNqsyFrMl89vWbabCZvVvouAovQCNF0ANToOkTYCazf8
 szl/7kURTkcIuZOwqIIIzNdvmLVnf0JPLWFESHszLNOYugNW3aXvIqTmS1sQqN/qWqKP 3g== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 36d5pt3afm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 05:31:57 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 05:31:55 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Feb 2021 05:31:55 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 849253F7040;
        Wed,  3 Feb 2021 05:31:52 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH 03/11] dts: mvebu: Add pin control definitions for SDIO interafce
Date:   Wed, 3 Feb 2021 15:31:30 +0200
Message-ID: <20210203133138.10754-4-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210203133138.10754-1-kostap@marvell.com>
References: <20210203133138.10754-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-03_05:2021-02-03,2021-02-03 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

Add SDIO mode pin control configration for CP0 on A8K DB.

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-70x0.dtsi | 6 ++++++
 arch/arm64/boot/dts/marvell/armada-80x0.dtsi | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
index 293403a1a333..179218774ba9 100644
--- a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
@@ -47,6 +47,12 @@
 	cp0_pinctrl: pinctrl {
 		compatible = "marvell,armada-7k-pinctrl";
 
+		sdhci_pins: sdhi-pins {
+			marvell,pins = "mpp56", "mpp57", "mpp58",
+				       "mpp59", "mpp60", "mpp61", "mpp62";
+			marvell,function = "sdio";
+		};
+
 		nand_pins: nand-pins {
 			marvell,pins =
 			"mpp15", "mpp16", "mpp17", "mpp18",
diff --git a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
index ee67c70bf02e..64100ae204da 100644
--- a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
@@ -70,6 +70,12 @@
 &cp0_syscon0 {
 	cp0_pinctrl: pinctrl {
 		compatible = "marvell,armada-8k-cpm-pinctrl";
+
+		sdhci_pins: sdhi-pins {
+			marvell,pins = "mpp56", "mpp57", "mpp58",
+				       "mpp59", "mpp60", "mpp61", "mpp62";
+			marvell,function = "sdio";
+		};
 	};
 };
 
-- 
2.17.1

