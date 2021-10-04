Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AB24205FA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 08:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhJDGuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 02:50:37 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:45694 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbhJDGug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 02:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1633330126; x=1635922126;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FErI2ug8KtoVBhGDqdfU5Bd9uqUK/N0StDgB0unFXzM=;
        b=b0LGMGK+GnnEsMQkXUSm5YISvMCQ+8HBmcrjZOktZGZAF9+oCp0rOBX8MBv46jg/
        H8cmuxsTBdOynSJMtyZnj/p1kPbR9cz9kuoBYcnZNYH/n5gB8BUTcHJVYWXaym24
        R+uBieosbtbffgqroE5ywjYfGN+/fo9t9RJUWtuFsgc=;
X-AuditID: c39127d2-c275470000001d24-96-615aa3cea30a
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 5A.77.07460.EC3AA516; Mon,  4 Oct 2021 08:48:46 +0200 (CEST)
Received: from lws-ybas.phytec.de ([172.16.21.122])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021100408484587-1808701 ;
          Mon, 4 Oct 2021 08:48:45 +0200 
From:   Yunus Bas <y.bas@phytec.de>
To:     robh+dt@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: imx6: phytec: Add gpio pinctrl for i2c bus recovery
Date:   Mon, 4 Oct 2021 08:48:22 +0200
Message-Id: <20211004064822.97170-1-y.bas@phytec.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 04.10.2021 08:48:46,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 04.10.2021 08:48:46
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsWyRoCBS/fc4qhEgzPnuC3mHznHavHwqr/F
        qqk7WSw2Pb7GanF51xw2i9a9R9gt/m7fxGLxYou4A4fHzll32T02repk89i8pN6j/6+Bx+dN
        cgGsUVw2Kak5mWWpRfp2CVwZP29PYCp4oVLxbXtUA2OffBcjB4eEgInEum7hLkYuDiGBbYwS
        HY0TWSGc84wSPc+bGbsYOTnYBBQlzt9+ywpiiwhUSkzfuIIJxGYWCJdYffsZO4gtLOAn8a9r
        CzOIzSKgInHz8TSwGl6gBQcuP2ADsSUE5CWO/OpkhogLSpyc+YQFZJmEwBVGibn9H1ggioQk
        Ti8+ywyxQFti2cLXzBMY+WYh6ZmFJLWAkWkVo1BuZnJ2alFmtl5BRmVJarJeSuomRmBgHp6o
        fmkHY98cj0OMTByMhxglOJiVRHivekUmCvGmJFZWpRblxxeV5qQWH2KU5mBREue938OUKCSQ
        nliSmp2aWpBaBJNl4uCUamBke+DAzvHo+rr1HxtyJ7ryy++wCHqXekOmRs3806Y7X53WnJTI
        V5wR+j3h2J3WgrvB7tfM124Wk7/1Pruyw2Z5jl4w1077CSqutsX89uyf6re5Sob0VmyJPb30
        jF5Vr8xXPYbpOZwRnyX4Hu2QUstVfKvB68nwsiokPeFW66Gp5VL7eV/ESymxFGckGmoxFxUn
        AgA1Qe+cOgIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the i2c bus recovery feature and enable it on PHYTEC
phyCORE-based modules and boards.

Signed-off-by: Yunus Bas <y.bas@phytec.de>
---
 arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi    | 30 +++++++++++++++----
 .../boot/dts/imx6qdl-phytec-phycore-som.dtsi  | 12 +++++++-
 .../boot/dts/imx6ul-phytec-phycore-som.dtsi   | 12 +++++++-
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi b/arch/arm/boot/dts=
/imx6qdl-phytec-mira.dtsi
index 0873f53ea275..120d6e997a4c 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
@@ -145,8 +145,11 @@ &hdmi {
 };
=20
 &i2c1 {
-	pinctrl-names =3D "default";
+	pinctrl-names =3D "default", "gpio";
 	pinctrl-0 =3D <&pinctrl=5Fi2c1>;
+	pinctrl-1 =3D <&pinctrl=5Fi2c1=5Fgpio>;
+	scl-gpios =3D <&gpio3 21 (GPIO=5FACTIVE=5FHIGH | GPIO=5FOPEN=5FDRAIN)>;
+	sda-gpios =3D <&gpio3 28 (GPIO=5FACTIVE=5FHIGH | GPIO=5FOPEN=5FDRAIN)>;
 	clock-frequency =3D <400000>;
 	status =3D "disabled";
=20
@@ -185,8 +188,11 @@ i2c=5Frtc: rtc@68 {
 };
=20
 &i2c2 {
-	pinctrl-names =3D "default";
+	pinctrl-names =3D "default", "gpio";
 	pinctrl-0 =3D <&pinctrl=5Fi2c2>;
+	pinctrl-1 =3D <&pinctrl=5Fi2c2=5Fgpio>;
+	scl-gpios =3D <&gpio4 12 (GPIO=5FACTIVE=5FHIGH | GPIO=5FOPEN=5FDRAIN)>;
+	sda-gpios =3D <&gpio4 13 (GPIO=5FACTIVE=5FHIGH | GPIO=5FOPEN=5FDRAIN)>;
 	clock-frequency =3D <100000>;
 	status =3D "disabled";
 };
@@ -300,6 +306,20 @@ MX6QDL=5FPAD=5FKEY=5FROW2=5F=5FHDMI=5FTX=5FCEC=5FLINE	=
0x1f8b0
 		>;
 	};
=20
+	pinctrl=5Fi2c1: i2c1grp {
+		fsl,pins =3D <
+			MX6QDL=5FPAD=5FEIM=5FD21=5F=5FI2C1=5FSCL		0x4001b8b1
+			MX6QDL=5FPAD=5FEIM=5FD28=5F=5FI2C1=5FSDA		0x4001b8b1
+		>;
+	};
+
+	pinctrl=5Fi2c1=5Fgpio: i2c1gpiogrp {
+		fsl,pins =3D <
+			MX6QDL=5FPAD=5FEIM=5FD21=5F=5FGPIO3=5FIO21		0x4001b8b1
+			MX6QDL=5FPAD=5FEIM=5FD28=5F=5FGPIO3=5FIO28		0x4001b8b1
+		>;
+	};
+
 	pinctrl=5Fi2c2: i2c2grp {
 		fsl,pins =3D <
 			MX6QDL=5FPAD=5FKEY=5FROW3=5F=5FI2C2=5FSDA		0x4001b8b1
@@ -307,10 +327,10 @@ MX6QDL=5FPAD=5FKEY=5FCOL3=5F=5FI2C2=5FSCL		0x4001b8b1
 		>;
 	};
=20
-	pinctrl=5Fi2c1: i2c1grp {
+	pinctrl=5Fi2c2=5Fgpio: i2c2gpiogrp {
 		fsl,pins =3D <
-			MX6QDL=5FPAD=5FEIM=5FD21=5F=5FI2C1=5FSCL		0x4001b8b1
-			MX6QDL=5FPAD=5FEIM=5FD28=5F=5FI2C1=5FSDA		0x4001b8b1
+			MX6QDL=5FPAD=5FKEY=5FROW3=5F=5FGPIO4=5FIO13		0x4001b8b1
+			MX6QDL=5FPAD=5FKEY=5FCOL3=5F=5FGPIO4=5FIO12		0x4001b8b1
 		>;
 	};
=20
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi b/arch/arm/b=
oot/dts/imx6qdl-phytec-phycore-som.dtsi
index a80aa08a37cb..94b254bfd054 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
@@ -78,8 +78,11 @@ &gpmi {
 };
=20
 &i2c3 {
-	pinctrl-names =3D "default";
+	pinctrl-names =3D "default", "gpio";
 	pinctrl-0 =3D <&pinctrl=5Fi2c3>;
+	pinctrl-1 =3D <&pinctrl=5Fi2c3=5Fgpio>;
+	scl-gpios =3D <&gpio1 5 (GPIO=5FACTIVE=5FHIGH | GPIO=5FOPEN=5FDRAIN)>;
+	sda-gpios =3D <&gpio1 6 (GPIO=5FACTIVE=5FHIGH | GPIO=5FOPEN=5FDRAIN)>;
 	clock-frequency =3D <400000>;
 	status =3D "okay";
=20
@@ -259,6 +262,13 @@ MX6QDL=5FPAD=5FGPIO=5F5=5F=5FI2C3=5FSCL		0x4001b8b1
 		>;
 	};
=20
+	pinctrl=5Fi2c3=5Fgpio: i2c3gpiogrp {
+		fsl,pins =3D <
+			MX6QDL=5FPAD=5FGPIO=5F6=5F=5FGPIO1=5FIO06	0x4001b8b1
+			MX6QDL=5FPAD=5FGPIO=5F5=5F=5FGPIO1=5FIO05	0x4001b8b1
+		>;
+	};
+
 	pinctrl=5Fecspi1: ecspi1grp {
 		fsl,pins =3D <
 			MX6QDL=5FPAD=5FEIM=5FD16=5F=5FECSPI1=5FSCLK		0x100b1
diff --git a/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi b/arch/arm/bo=
ot/dts/imx6ul-phytec-phycore-som.dtsi
index 19a062635ff6..3cddc68917a0 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
@@ -68,8 +68,11 @@ &gpmi {
 };
=20
 &i2c1 {
-	pinctrl-names =3D "default";
+	pinctrl-names =3D "default", "gpio";
 	pinctrl-0 =3D <&pinctrl=5Fi2c1>;
+	pinctrl-1 =3D <&pinctrl=5Fi2c1=5Fgpio>;
+	scl-gpios =3D <&gpio1 28 (GPIO=5FACTIVE=5FHIGH | GPIO=5FOPEN=5FDRAIN)>;
+	sda-gpios =3D <&gpio1 29 (GPIO=5FACTIVE=5FHIGH | GPIO=5FOPEN=5FDRAIN)>;
 	clock-frequency =3D <100000>;
 	status =3D "okay";
=20
@@ -147,6 +150,13 @@ MX6UL=5FPAD=5FUART4=5FRX=5FDATA=5F=5FI2C1=5FSDA	0x4001=
b8b0
 		>;
 	};
=20
+	pinctrl=5Fi2c1=5Fgpio: i2cgpiogrp {
+		fsl,pins =3D <
+			MX6UL=5FPAD=5FUART4=5FTX=5FDATA=5F=5FGPIO1=5FIO28	0x4001b8b0
+			MX6UL=5FPAD=5FUART4=5FRX=5FDATA=5F=5FGPIO1=5FIO29	0x4001b8b0
+		>;
+	};
+
 	pinctrl=5Fuart1: uart1grp {
 		fsl,pins =3D <
 			MX6UL=5FPAD=5FUART1=5FTX=5FDATA=5F=5FUART1=5FDCE=5FTX	0x1b0b1
--=20
2.33.0

