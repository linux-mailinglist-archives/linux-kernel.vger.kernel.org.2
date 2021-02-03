Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B077C30DB8C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhBCNlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:41:49 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:5884 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232144AbhBCNcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:32:54 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 113DPq0m010557;
        Wed, 3 Feb 2021 05:31:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=wxN0G9Sh3TEdyx3iOK2sUCS/vfaNb6bEAbR6SXkDa2o=;
 b=UF85YUUwUPs6LoZ1Gvr0JetuJtrDlXXgEc+y+4JwRZ3yLHM2xJaIgdmEx1aV4IOVd4kh
 CtDNlZG55QnerW2knRvwHRlKnfsp7e9hGhS+AuTALMuEypwgZBMo4nX4wsysAKyLvyEv
 hXas+3jakQjnoDJdTDoMuuebFG2hD6ChBPSbL6/cmDiDfgL/3QSkBXyWZgZfu0LFkM4w
 TVoPpkIt0azbRN6WeBcq2why+2e59wcaPupIjIV4as01ShhtMDbib1GTBcd/A332kBbC
 sLEouKdz2ZaMMjWsiNQKOh7D5N8aqoVPgfN4mcTd0uR+ONH6EFLzqamFhWSTIAZbnvyi 9A== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 36fnr61545-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 05:31:54 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 05:31:52 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 05:31:51 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Feb 2021 05:31:52 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id E939A3F7040;
        Wed,  3 Feb 2021 05:31:48 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH 02/11] dts: mvebu: Update A8K AP806 SDHCI settings
Date:   Wed, 3 Feb 2021 15:31:29 +0200
Message-ID: <20210203133138.10754-3-kostap@marvell.com>
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

Update the settings for AP806 SDHCI interface according to
latest Xenon drivers changes.
- no need to select the PHY slow mode anymore
- recommended to add HS400 support at 1.8V signalling on AP806-B0
- fix the bus witdth for A8040 DB from 4 to 8 bits.

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     | 11 ++++++++++-
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi |  5 -----
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi      |  1 -
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index 09fb5256f1db..6362e654a823 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -347,7 +347,16 @@
 
 &ap_sdhci0 {
 	status = "okay";
-	bus-width = <4>;
+	bus-width = <8>;
+	/* The below property should be added to boards with AP806-B0
+	 * for enabling HS400 speed mode. Otherwise the device highest
+	 * speed mode will be HS200.
+	 * Should not be added to boards with earlier release of AP806
+	 * since it will cause SDHCI driver to fail upon initialization.
+	 * Reference - HWE-7296210 (errata for releases A0/A1/A2)
+	 *
+	 * mmc-hs400-1_8v;
+	 */
 	non-removable;
 };
 
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

