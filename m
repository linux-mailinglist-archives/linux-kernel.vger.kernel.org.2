Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED6A31B11F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 17:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhBNQDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 11:03:39 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:8222 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229821AbhBNQC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 11:02:29 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11EG06PX025336;
        Sun, 14 Feb 2021 08:01:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=K5pAJPG0vHisE+TG3mImKVMHniXfDzQH2Ef4aoca4vw=;
 b=PB7QZzVWSIOxsvs8zsusXBZNM2mvnHdEWUM6ukH7dsRCN3uR5H4LkxDlPu0HWWUEiwe7
 /92kJIlxTAIOBRpVSF+OhIE5OEjk5vEOG/bIyyUv+lqVArwMW9195adleWzzvSg3WlYc
 v0iNQWReovPnnZRfJi6ewCjlHSVCqJBGl94nYHt8eUr+jPaAo50WvLMpIwiwNUl0EOIH
 iSYBc640PxBYT6W11dmrbBCiprYnSM87QgmmOZeMrjUj3uN8xDszqK9RKInE28nSN2Gu
 /Rf0lhjfqC8mK928W4EAuS1RTuJoDaZJiXib6VP+w0+DEs6gxugp148NuES9sq6JtdKM oA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 36pf5tswnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 14 Feb 2021 08:01:34 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 14 Feb
 2021 08:01:32 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 14 Feb
 2021 08:01:31 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 14 Feb 2021 08:01:32 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 1BDA73F704A;
        Sun, 14 Feb 2021 08:01:27 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lkundrak@v3.sk>, <linux@armlinux.org.uk>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <robh+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@ti.com>, <miquel.raynal@bootlin.com>, <mw@semihalf.com>,
        <jaz@semihalf.com>, <nadavh@marvell.com>, <stefanc@marvell.com>,
        <bpeled@marvell.com>, "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v2 4/4] arch/arm64: dts: enable CP110 UTMI driver
Date:   Sun, 14 Feb 2021 18:01:08 +0200
Message-ID: <20210214160108.3879-5-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210214160108.3879-1-kostap@marvell.com>
References: <20210214160108.3879-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-14_04:2021-02-12,2021-02-14 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

Enable support for CP110 UTMI driver in Armada SoC family platform
device trees.

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     | 14 +++++++++----
 arch/arm64/boot/dts/marvell/armada-8040-db.dts     | 21 ++++++++++++++++++--
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi | 19 ++++++++++++++++--
 arch/arm64/boot/dts/marvell/cn9130-db.dts          | 12 +++++++++--
 arch/arm64/boot/dts/marvell/cn9131-db.dts          |  9 +++++++--
 arch/arm64/boot/dts/marvell/cn9132-db.dts          | 11 ++++++++--
 6 files changed, 72 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index a7eb4e7697a2..51f3e2907597 100644
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
@@ -226,8 +230,9 @@
 };
 
 &cp0_usb3_0 {
-	phys = <&cp0_comphy1 0>;
-	phy-names = "cp0-usb3h0-comphy";
+	phys = <&cp0_comphy1 0>, <&cp0_utmi0>;
+	phy-names = "cp0-usb3h0-comphy", "utmi";
+	dr_mode = "host";
 	status = "okay";
 };
 
@@ -239,8 +244,9 @@
 };
 
 &cp0_usb3_1 {
-	phys = <&cp0_comphy4 1>;
-	phy-names = "cp0-usb3h1-comphy";
+	phys = <&cp0_comphy4 1>, <&cp0_utmi1>;
+	phy-names = "cp0-usb3h1-comphy", "utmi";
+	dr_mode = "host";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index 09fb5256f1db..e39e1efc95b6 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -154,8 +154,15 @@
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
+	dr_mode = "host";
 	status = "okay";
 };
 
@@ -168,8 +175,9 @@
 
 /* CON10 on CP0 expansion */
 &cp0_usb3_1 {
-	phys = <&cp0_comphy4 1>;
-	phy-names = "cp0-usb3h1-comphy";
+	phys = <&cp0_comphy4 1>, <&cp0_utmi1>;
+	phy-names = "usb", "utmi";
+	dr_mode = "host";
 	status = "okay";
 };
 
@@ -306,14 +314,23 @@
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
+	dr_mode = "host";
 	status = "okay";
 };
 
 /* CON10 on CP1 expansion */
 &cp1_usb3_1 {
+	phys = <&cp1_utmi1>;
+	phy-names = "utmi";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
index cbcb210cb6d8..adbfecc678b5 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
@@ -259,13 +259,23 @@
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
+	dr_mode = "host";
 	status = "okay";
 };
 
 &cp0_usb3_1 {
 	/* J38? - USB2.0 only */
+	phys = <&cp0_utmi1>;
+	phy-names = "utmi";
+	dr_mode = "host";
 	status = "okay";
 };
 
@@ -364,9 +374,14 @@
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
+	dr_mode = "host";
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dts b/arch/arm64/boot/dts/marvell/cn9130-db.dts
index ce49a70d88a0..62fa6ecc0acd 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-db.dts
+++ b/arch/arm64/boot/dts/marvell/cn9130-db.dts
@@ -390,14 +390,22 @@
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
+	dr_mode = "host";
 };
 
 &cp0_usb3_1 {
 	status = "okay";
 	usb-phy = <&cp0_usb3_0_phy1>;
-	phy-names = "usb";
+	phys =  <&cp0_utmi1>;
+	phy-names = "utmi";
+	dr_mode = "host";
 };
diff --git a/arch/arm64/boot/dts/marvell/cn9131-db.dts b/arch/arm64/boot/dts/marvell/cn9131-db.dts
index 3c975f98b2a3..ba2d4e1da159 100644
--- a/arch/arm64/boot/dts/marvell/cn9131-db.dts
+++ b/arch/arm64/boot/dts/marvell/cn9131-db.dts
@@ -193,10 +193,15 @@
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
+	dr_mode = "host";
 };
diff --git a/arch/arm64/boot/dts/marvell/cn9132-db.dts b/arch/arm64/boot/dts/marvell/cn9132-db.dts
index 4ef0df3097ca..81fba024b22d 100644
--- a/arch/arm64/boot/dts/marvell/cn9132-db.dts
+++ b/arch/arm64/boot/dts/marvell/cn9132-db.dts
@@ -205,17 +205,24 @@
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
+	dr_mode = "host";
 };
 
 /* SLM-1521-V2, CON11 */
 &cp2_usb3_1 {
 	status = "okay";
 	usb-phy = <&cp2_usb3_0_phy1>;
-	phy-names = "usb";
 	/* Generic PHY, providing serdes lanes */
-	phys = <&cp2_comphy3 1>;
+	phys = <&cp2_comphy3 1>, <&cp2_utmi1>;
+	phy-names = "usb", "utmi";
+	dr_mode = "host";
 };
-- 
2.17.1

