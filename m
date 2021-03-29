Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F0B34D0CE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhC2NBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:01:15 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:65312 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbhC2NBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1617022864; x=1619614864;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KkyaLvXgnh8FHwhgimfkJzNBhe8FYXfqUyA0puTFtrg=;
        b=NICHpzJr7Tv+1CxFlfsYlHFDQlNu/cEgLx12UmKOodcGMnv0YrHwyK8OALvIKfJp
        olUvWhJq5sISZcgTbNeC4HppmIGcA5n7Nx3vxZueiCxAUrLcOXYFx+DkvoNBqcZb
        r5qap9lPJXYXDsrKGnh/lIzO5YhFeANsEPUf3BZQuLw=;
X-AuditID: c39127d2-85cb770000001c91-35-6061cf90f966
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 8E.4B.07313.09FC1606; Mon, 29 Mar 2021 15:01:04 +0200 (CEST)
Received: from lws-riedmueller.phytec.de ([172.16.23.108])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021032915010496-253808 ;
          Mon, 29 Mar 2021 15:01:04 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>
Subject: [PATCH v2 1/3] ARM: dts: imx6: pfla02: Fix USB vbus enable pinmuxing
Date:   Mon, 29 Mar 2021 15:01:01 +0200
Message-Id: <20210329130103.65857-1-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.03.2021 15:01:04,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.03.2021 15:01:05
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWyRoCBS3fC+cQEg53zLCzmHznHavHwqr/F
        qqk7WSw2Pb7GatH1ayWzxeVdc9gsWvceYbf4u30Ti8WLLeIOnB47Z91l99i0qpPNY/OSeo+N
        73YwefT/NfD4vEkugC2KyyYlNSezLLVI3y6BK2PTcq2ChTwVk3v3sTYwdnN1MXJySAiYSDRu
        nMXWxcjFISSwjVHi1pbdzBDONUaJJy//MoFUsQkYSSyY1ghmiwjkSJzauJkFxGYW6GSS+H0y
        GMQWFvCVmDD/EmsXIwcHi4CqxNf9qSBhXgEbibN3F7JBLJOXmHnpOztEXFDi5MwnLBDxK4wS
        e26qQ9hCEqcXn2WGGK8tsWzha+YJjHyzkLTMQpJawMi0ilEoNzM5O7UoM1uvIKOyJDVZLyV1
        EyMwVA9PVL+0g7FvjschRiYOxkOMEhzMSiK8wgcSE4R4UxIrq1KL8uOLSnNSiw8xSnOwKInz
        buAtCRMSSE8sSc1OTS1ILYLJMnFwSjUwRnvN3qn6d4rkSqbHMR8X3fue9vt83kerwim++7fZ
        zOCIqH0RMUf/0aNqzqVn7CLfJ6RmsQl7ny14cd5dql/X1Jt31uepq1/ES79X8mL7+72jZim7
        0+vD32KsZpUY9HOYv+u+u95b45H8MX4tQ9PP2htOfF87r3pGzTsvpYa+fy9FwlmkN/hdVmIp
        zkg01GIuKk4EALO2rFFDAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pinmuxing for the enable pin of the usbh1 node is wrong. It needs to
be muxed as GPIO. While at it, move the pinctrl to the vbus regulator
since it is actually the regulator enable pin.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
Changes in v2:
 - Use default pad ctl value instead of 0x80000000

 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/d=
ts/imx6qdl-phytec-pfla02.dtsi
index 7a1e53195785..9f39c926cc08 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -31,6 +31,8 @@ reg=5Fusb=5Fotg=5Fvbus: regulator@0 {
=20
 		reg=5Fusb=5Fh1=5Fvbus: regulator@1 {
 			compatible =3D "regulator-fixed";
+			pinctrl-names =3D "default";
+			pinctrl-0 =3D <&pinctrl=5Fusbh1=5Fvbus>;
 			reg =3D <1>;
 			regulator-name =3D "usb=5Fh1=5Fvbus";
 			regulator-min-microvolt =3D <5000000>;
@@ -328,9 +330,9 @@ MX6QDL=5FPAD=5FKEY=5FROW0=5F=5FUART4=5FRX=5FDATA	0x1b0b1
 			>;
 		};
=20
-		pinctrl=5Fusbh1: usbh1grp {
+		pinctrl=5Fusbh1=5Fvbus: usbh1vbusgrp {
 			fsl,pins =3D <
-				MX6QDL=5FPAD=5FGPIO=5F0=5F=5FUSB=5FH1=5FPWR		0x80000000
+				MX6QDL=5FPAD=5FGPIO=5F0=5F=5FGPIO1=5FIO00		0x1b0b0
 			>;
 		};
=20
@@ -415,8 +417,6 @@ &uart4 {
=20
 &usbh1 {
 	vbus-supply =3D <&reg=5Fusb=5Fh1=5Fvbus>;
-	pinctrl-names =3D "default";
-	pinctrl-0 =3D <&pinctrl=5Fusbh1>;
 	status =3D "disabled";
 };
=20
--=20
2.25.1

