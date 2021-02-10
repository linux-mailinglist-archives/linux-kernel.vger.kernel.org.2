Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635333168BB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhBJOLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:11:05 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:20830 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231396AbhBJOKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:10:55 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11AE0OIr011326;
        Wed, 10 Feb 2021 06:10:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=PWnnzGuk/ieIQSw2dLZPjY03chHqOhLoJqWbCzDUdbY=;
 b=cHHRItzhU3ry59G5WG8+/Q42T/304ozlhLOoCwFye3P+Okorn6VIuF4xAWRE4N4A5Q++
 liLFynWyAxJq+flG/sKFvSgQSzTAoQl9w4TvEFyPqBiwjKcLsp+FKDm5A7Jz3Q4uxrA0
 JavTjXTddEJC2oviktAOJPsdNr1GP23HO1J4IRBGUcarZTn7Nm/EMb0NEzaPSedD1GJy
 A2SX8DGD/yHZLQnCF6jkN+YWYDA4CtPYnw+WUstlwRWNak4eP+8vxPOCnOcTK2pfCA/j
 UBC+z8lhZeFCtzZvhOVYoyLX/9KmUPHtvSUU9SyIdP5Z8zU82HiLk2jAl73oiHiydg9K EQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 36hugqbryv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 06:10:04 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 06:10:02 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Feb 2021 06:10:02 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 8DC043F703F;
        Wed, 10 Feb 2021 06:09:59 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v2 02/12] dts: mvebu: Update A8K AP806/AP807 SDHCI settings
Date:   Wed, 10 Feb 2021 16:09:39 +0200
Message-ID: <20210210140949.32515-3-kostap@marvell.com>
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

Select the AP SDHCI PHY slow mode for AP806 die only (move it
from armada-ap80x.dtsi to armada-ap806.dtsi). This will allow
running AP807 based devices at HS400 speed.
Remove Ap SDHCI slow mode property from MacchiatoBin board DTS
since it is already selected on the SoC level.

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi |  5 -----
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 12 ++++++++++++
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi      |  1 -
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
index 73733b4126e2..69653de998e2 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
@@ -109,11 +109,6 @@
 
 &ap_sdhci0 {
 	bus-width = <8>;
-	/*
-	 * Not stable in HS modes - phy needs "more calibration", so add
-	 * the "slow-mode" and disable SDR104, SDR50 and DDR50 modes.
-	 */
-	marvell,xenon-phy-slow-mode;
 	no-1-8-v;
 	no-sd;
 	no-sdio;
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 866628679ac7..828cd539173b 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -28,3 +28,15 @@
 		reg = <0x278 0xa30>;
 	};
 };
+
+&ap_sdhci0 {
+	/*
+	 * SoC based on AP806 revision A0, A1 and A2 should use slow mode
+	 * settings for Ap SDHCI due to HW Erratum HWE-7296210
+	 * AP806 revesion B0 and later has this erratum fixed and the slow
+	 * mode could be removed in board DTS:
+	 *     /delete-property/marvell,xenon-phy-slow-mode;
+	 * Starting from B0 revision, the AP SDHCI can run with HS400 timing.
+	 */
+	marvell,xenon-phy-slow-mode;
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
index 12e477f1aeb9..edd6131a0587 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
@@ -257,7 +257,6 @@
 				clock-names = "core";
 				clocks = <&ap_clk 4>;
 				dma-coherent;
-				marvell,xenon-phy-slow-mode;
 				status = "disabled";
 			};
 
-- 
2.17.1

