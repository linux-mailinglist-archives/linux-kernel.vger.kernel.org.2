Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D2B3168C4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhBJOLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:11:22 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:13941 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231274AbhBJOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:11:04 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11AE0OcR011334;
        Wed, 10 Feb 2021 06:10:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=952jutI4HaIieYpCElWHOlDgqiHN62yK+gefne9AiQo=;
 b=DjR10mbkhEalCSqR8i60EnNls1dYO50u4nP4D2ml9zvUtokdbBby6Cq61qFnXUnc7iLX
 Qer/ZpqxjcflW7Cg3Pea4pJulULde+j5sOMvFxAQdY4d3tCoTVkHJng0tDfaCb9jAN+Q
 NEFc3byKFdLwHIIAM9szOQnSoSW7uHFfiTZyJckAEiqXjaOcF58XPuySugAa3+E3ZANZ
 4condUfsmOXuNUotwTsd8is7lEvq62K8mq87s5mSmI4FMQ43ipoDBjCj6VVMSE3Qmfvs
 JW59LGbaTjXOgnZ92gtpNkIQIgzZ2zZEJukM2ZUCQ0JJIiuYBzqmxXGeBwKOy/qClTub GA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 36hugqbs01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 06:10:08 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 06:10:06 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 06:10:06 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Feb 2021 06:10:06 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 24C4E3F7045;
        Wed, 10 Feb 2021 06:10:02 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v2 03/12] dts: mvebu: Add pin control definitions for SDIO interafce
Date:   Wed, 10 Feb 2021 16:09:40 +0200
Message-ID: <20210210140949.32515-4-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210210140949.32515-1-kostap@marvell.com>
References: <20210210140949.32515-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_05:2021-02-10,2021-02-10 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

Add SDIO mode pin control configuration for CP0 in Armada
70x0 and 80x0 SoCs.

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-70x0.dtsi | 6 ++++++
 arch/arm64/boot/dts/marvell/armada-80x0.dtsi | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
index 293403a1a333..f22b6b8f5086 100644
--- a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
@@ -47,6 +47,12 @@
 	cp0_pinctrl: pinctrl {
 		compatible = "marvell,armada-7k-pinctrl";
 
+		sdhci_pins: sdhci-pins {
+			marvell,pins = "mpp56", "mpp57", "mpp58",
+				       "mpp59", "mpp60", "mpp61", "mpp62";
+			marvell,function = "sdio";
+		};
+
 		nand_pins: nand-pins {
 			marvell,pins =
 			"mpp15", "mpp16", "mpp17", "mpp18",
diff --git a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
index ee67c70bf02e..04a6142a0286 100644
--- a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
@@ -70,6 +70,12 @@
 &cp0_syscon0 {
 	cp0_pinctrl: pinctrl {
 		compatible = "marvell,armada-8k-cpm-pinctrl";
+
+		sdhci_pins: sdhci-pins {
+			marvell,pins = "mpp56", "mpp57", "mpp58",
+				       "mpp59", "mpp60", "mpp61", "mpp62";
+			marvell,function = "sdio";
+		};
 	};
 };
 
-- 
2.17.1

