Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A5530DB82
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhBCNkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:40:41 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:46158 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232155AbhBCNcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:32:54 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 113DQ6N0010647;
        Wed, 3 Feb 2021 05:32:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=cEN838B4rdgKcXacCbiSqaP3S3cRdwnY+6KxL2hPQSk=;
 b=Adb+FM9dtNxXrav8mxs3Sn10foHXmxsIayPLf1/wPtD1E8GuaDtirfr/1eDBp0a8GOt3
 j42W0z4YBBa6PtDlKRuGxPL6RQbAGwIQXjH5wdB/ZdhftUPu3yl+bQnsmwuIwcvOFGTX
 JqUl/RGaFNWadYxCJj5lVFqKqh37N49yBPu46a800LPD6Ian678WLyBGDRcXyrks34fV
 3JyaZJeiIZYUj5Ftbk8/AXxxa1z6mP6zu2i2uo5XwjlQee/9uoTIO03q9et570G4oVTI
 8gBOdzdXe0qvN4OXQyqTnL6WhXm+GBbDSVrLwcM9mloosde7fEbiXm7QAML8OagxCz54 Mg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 36fnr6154f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 05:32:01 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 05:31:59 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 05:31:59 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Feb 2021 05:31:59 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 194923F7041;
        Wed,  3 Feb 2021 05:31:55 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH 04/11] fix: dts: a8k: Add CP eMMC regulator and update device parameters
Date:   Wed, 3 Feb 2021 15:31:31 +0200
Message-ID: <20210203133138.10754-5-kostap@marvell.com>
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

Add GPIO regulator for controlling CP0 eMMC voltage (3.3V/1.8V)
Update CP0 SDHCI parameters in A7K/A8K boards DTS files.

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts | 17 ++++++++++++++++-
 arch/arm64/boot/dts/marvell/armada-8040-db.dts | 18 +++++++++++++++++-
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index a7eb4e7697a2..f8179cadc610 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -28,6 +28,19 @@
 		ethernet2 = &cp0_eth2;
 	};
 
+	cp0_vccq_sd0_reg: cp0_vccq_sd0 {
+		compatible = "regulator-gpio";
+		regulator-name = "cp0-vccq-sd0";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		gpios = <&expander0 15 GPIO_ACTIVE_HIGH>;
+		gpios-states = <0>;
+		states = <1800000 0x1
+			  3300000 0x0>;
+		enable-active-high;
+	};
+
 	cp0_exp_usb3_0_current_regulator: gpio-regulator {
 		compatible = "regulator-gpio";
 		regulator-name = "cp0-usb3-0-current-regulator";
@@ -253,8 +266,10 @@
 
 &cp0_sdhci0 {
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhci_pins>;
 	bus-width = <4>;
-	no-1-8-v;
+	vqmmc-supply = <&cp0_vccq_sd0_reg>;
 	cd-gpios = <&expander0 12 GPIO_ACTIVE_LOW>;
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index 6362e654a823..d96aa9e9e61c 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -31,6 +31,19 @@
 		i2c2 = &cp1_i2c0;
 	};
 
+	cp0_vccq_sd0_reg: cp0_vccq_sd0 {
+		compatible = "regulator-gpio";
+		regulator-name = "cp0-vccq-sd0";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		gpios = <&expander0 15 GPIO_ACTIVE_HIGH>;
+		gpios-states = <0>;
+		states = <1800000 0x1
+			  3300000 0x0>;
+		enable-active-high;
+	};
+
 	cp0_reg_usb3_0_vbus: cp0-usb3-0-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "cp0-usb3h0-vbus";
@@ -362,6 +375,9 @@
 
 &cp0_sdhci0 {
 	status = "okay";
-	bus-width = <8>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhci_pins>;
+	bus-width = <4>;
+	vqmmc-supply = <&cp0_vccq_sd0_reg>;
 	non-removable;
 };
-- 
2.17.1

