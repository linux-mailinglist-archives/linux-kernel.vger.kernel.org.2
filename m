Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFFF305A27
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbhA0LoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:44:11 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:35726 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236768AbhA0L3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:29:01 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10RBPbOk006149;
        Wed, 27 Jan 2021 03:28:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=VnO9xWbapIND4EXdMxnGEqAT/bCJQc4DY3nKKvQv6hc=;
 b=DuSgqAqaAPyHWqitHsO+PQ6Yg/PPPlGXjbJtNkGwtbye/nMBQ26UkKHZ0As26GDhwryk
 TOYJysya8D9lu/kwcYnsgo2HC9NCv+5IAz5mgUiG0zVX4k2YOqOmanCBeMiR19j7z52y
 e+t5R33losA5/DWt+xnd812hed4545qwZngd6Bmp+ausG56/yoQvvk8WrJbkTJno7Q+p
 rjNxlZW3HQTJcj3uOrpr5Bfi5V506i0FuX00M1TQEMah1wSi95BcXDTucK7t3yPCtTYr
 aVFmnUwyKJ7ntzZLoeJpAAZKQHmYWyTs4phlXYvgFl60qIqEduCY/gmQ9SmVPx08QXOV Lw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 368j1ubd7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 03:28:05 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Jan
 2021 03:28:04 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Jan
 2021 03:28:03 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Jan 2021 03:28:03 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id CA6C33F703F;
        Wed, 27 Jan 2021 03:27:59 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <lkundrak@v3.sk>,
        <linux@armlinux.org.uk>, <sebastian.hesselbarth@gmail.com>,
        <gregory.clement@bootlin.com>, <andrew@lunn.ch>,
        <robh+dt@kernel.org>, <vkoul@kernel.org>, <kishon@ti.com>,
        <miquel.raynal@bootlin.com>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH 4/4] arch/arm64: dts: enable CP110 UTMI driver
Date:   Wed, 27 Jan 2021 13:27:19 +0200
Message-ID: <20210127112719.30632-5-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210127112719.30632-1-kostap@marvell.com>
References: <20210127112719.30632-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-27_04:2021-01-27,2021-01-27 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

Enable support for CP110 UTMI driver in Armada SoC family platform
device trees.

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     | 12 ++++++++----
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     | 18 ++++++++++++++++--
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi | 16 ++++++++++++++--
 arch/arm64/boot/dts/marvell/cn9130-db.dts          | 10 ++++++++--
 arch/arm64/boot/dts/marvell/cn9131-db.dts          |  8 ++++++--
 arch/arm64/boot/dts/marvell/cn9132-db.dts          |  9 +++++++--
 6 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index a7eb4e7697a2..ef792b932912 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -218,6 +218,10 @@
 	};
 };
 
+&cp0_utmi {
+	status = "okay";
+};
+
 &cp0_comphy1 {
 	cp0_usbh0_con: connector {
 		compatible = "usb-a-connector";
@@ -226,8 +230,8 @@
 };
 
 &cp0_usb3_0 {
-	phys = <&cp0_comphy1 0>;
-	phy-names = "cp0-usb3h0-comphy";
+	phys = <&cp0_comphy1 0>, <&cp0_utmi0>;
+	phy-names = "cp0-usb3h0-comphy", "utmi";
 	status = "okay";
 };
 
@@ -239,8 +243,8 @@
 };
 
 &cp0_usb3_1 {
-	phys = <&cp0_comphy4 1>;
-	phy-names = "cp0-usb3h1-comphy";
+	phys = <&cp0_comphy4 1>, <&cp0_utmi1>;
+	phy-names = "cp0-usb3h1-comphy", "utmi";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index 09fb5256f1db..f1af6beeb9f9 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -154,8 +154,14 @@
 };
 
 /* CON9 on CP0 expansion */
+&cp0_utmi {
+	status = "okay";
+};
+
 &cp0_usb3_0 {
 	usb-phy = <&cp0_usb3_0_phy>;
+	phys = <&cp0_utmi0>;
+	phy-names = "utmi";
 	status = "okay";
 };
 
@@ -168,8 +174,8 @@
 
 /* CON10 on CP0 expansion */
 &cp0_usb3_1 {
-	phys = <&cp0_comphy4 1>;
-	phy-names = "cp0-usb3h1-comphy";
+	phys = <&cp0_comphy4 1>, <&cp0_utmi1>;
+	phy-names = "usb", "utmi";
 	status = "okay";
 };
 
@@ -306,14 +312,22 @@
 	};
 };
 
+&cp1_utmi {
+	status = "okay";
+};
+
 /* CON9 on CP1 expansion */
 &cp1_usb3_0 {
 	usb-phy = <&cp1_usb3_0_phy>;
+	phys = <&cp1_utmi0>;
+	phy-names = "utmi";
 	status = "okay";
 };
 
 /* CON10 on CP1 expansion */
 &cp1_usb3_1 {
+	phys = <&cp1_utmi1>;
+	phy-names = "utmi";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
index cbcb210cb6d8..b3258a3984a3 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
@@ -259,13 +259,21 @@
 	vqmmc-supply = <&v_3_3>;
 };
 
+&cp0_utmi {
+	status = "okay";
+};
+
 &cp0_usb3_0 {
 	/* J38? - USB2.0 only */
+	phys = <&cp0_utmi0>;
+	phy-names = "utmi";
 	status = "okay";
 };
 
 &cp0_usb3_1 {
 	/* J38? - USB2.0 only */
+	phys = <&cp0_utmi1>;
+	phy-names = "utmi";
 	status = "okay";
 };
 
@@ -364,9 +372,13 @@
 	};
 };
 
+&cp1_utmi {
+	status = "okay";
+};
+
 &cp1_usb3_0 {
 	/* CPS Lane 2 - CON7 */
-	phys = <&cp1_comphy2 0>;
-	phy-names = "cp1-usb3h0-comphy";
+	phys = <&cp1_comphy2 0>, <&cp1_utmi0>;
+	phy-names = "cp1-usb3h0-comphy", "utmi";
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dts b/arch/arm64/boot/dts/marvell/cn9130-db.dts
index ce49a70d88a0..02218422509c 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-db.dts
+++ b/arch/arm64/boot/dts/marvell/cn9130-db.dts
@@ -390,14 +390,20 @@
 	};
 };
 
+&cp0_utmi {
+	status = "okay";
+};
+
 &cp0_usb3_0 {
 	status = "okay";
 	usb-phy = <&cp0_usb3_0_phy0>;
-	phy-names = "usb";
+	phys = <&cp0_utmi0>;
+	phy-names = "utmi";
 };
 
 &cp0_usb3_1 {
 	status = "okay";
 	usb-phy = <&cp0_usb3_0_phy1>;
-	phy-names = "usb";
+	phys =  <&cp0_utmi1>;
+	phy-names = "utmi";
 };
diff --git a/arch/arm64/boot/dts/marvell/cn9131-db.dts b/arch/arm64/boot/dts/marvell/cn9131-db.dts
index 3c975f98b2a3..17e189875182 100644
--- a/arch/arm64/boot/dts/marvell/cn9131-db.dts
+++ b/arch/arm64/boot/dts/marvell/cn9131-db.dts
@@ -193,10 +193,14 @@
 };
 
 /* CON58 */
+&cp1_utmi {
+	status = "okay";
+};
+
 &cp1_usb3_1 {
 	status = "okay";
 	usb-phy = <&cp1_usb3_0_phy0>;
 	/* Generic PHY, providing serdes lanes */
-	phys = <&cp1_comphy3 1>;
-	phy-names = "usb";
+	phys = <&cp1_comphy3 1>, <&cp1_utmi1>;
+	phy-names = "usb", "utmi";
 };
diff --git a/arch/arm64/boot/dts/marvell/cn9132-db.dts b/arch/arm64/boot/dts/marvell/cn9132-db.dts
index 4ef0df3097ca..87da1dc3707c 100644
--- a/arch/arm64/boot/dts/marvell/cn9132-db.dts
+++ b/arch/arm64/boot/dts/marvell/cn9132-db.dts
@@ -205,9 +205,14 @@
 	};
 };
 
+&cp2_utmi {
+	status = "okay";
+};
+
 &cp2_usb3_0 {
 	status = "okay";
 	usb-phy = <&cp2_usb3_0_phy0>;
+	phys = <&cp2_utmi0>;
 	phy-names = "usb";
 };
 
@@ -215,7 +220,7 @@
 &cp2_usb3_1 {
 	status = "okay";
 	usb-phy = <&cp2_usb3_0_phy1>;
-	phy-names = "usb";
 	/* Generic PHY, providing serdes lanes */
-	phys = <&cp2_comphy3 1>;
+	phys = <&cp2_comphy3 1>, <&cp2_utmi1>;
+	phy-names = "usb", "utmi";
 };
-- 
2.17.1

