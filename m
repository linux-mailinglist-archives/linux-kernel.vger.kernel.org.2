Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1BD34CEF3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 13:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhC2L2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 07:28:42 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:62582 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhC2L23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 07:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1617017307; x=1619609307;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=84GErCcn3zk/3XbjrFZiXM4ByN4FwJAVu0bVQMG9bQY=;
        b=NnQyzmWx2i+eFokHEduz1ENAoYaC2m1tHzr912EjJQ3tMRjFvBy+Hkg8IqgnaO/V
        lMjHLfTiEK8ES9V91EnmtpwsogsJJY3fy2OXqWR7Yjp7BuxQSnDKpW8FqKp4Rnc1
        5HgfKUOit1770FwUQrqI1bHD5xzqISGz2IujBYtdSKE=;
X-AuditID: c39127d2-868b870000001c91-68-6061b9dbda95
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 3A.8A.07313.BD9B1606; Mon, 29 Mar 2021 13:28:27 +0200 (CEST)
Received: from lws-riedmueller.phytec.de ([172.16.23.108])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021032913282721-253196 ;
          Mon, 29 Mar 2021 13:28:27 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>
Subject: [PATCH 1/3] ARM: dts: imx6: pfla02: Fix USB vbus enable pinmuxing
Date:   Mon, 29 Mar 2021 13:28:17 +0200
Message-Id: <20210329112819.64043-1-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.03.2021 13:28:27,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.03.2021 13:28:27
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWyRoCBS/f2zsQEg++zlCzmHznHavHwqr/F
        qqk7WSw2Pb7GatH1ayWzxeVdc9gsWvceYbf4u30Ti8WLLeIOnB47Z91l99i0qpPNY/OSeo+N
        73YwefT/NfD4vEkugC2KyyYlNSezLLVI3y6BK2P79W+MBfe4K3Zd5WtgvMnZxcjJISFgIjFx
        /nGWLkYuDiGBbYwSm3vvsEE41xglTjZ9ZASpYhMwklgwrZEJxBYRyJE4tXEzC4jNLNDJJPH7
        ZDCILSzgJTHrxWywehYBVYkvU3eA2bwCNhJvfn9hgdgmLzHz0nd2iLigxMmZT8A2SwhcYZRo
        Wb+NFaJISOL04rPMEAu0JZYtfM08gZFvFpKeWUhSCxiZVjEK5WYmZ6cWZWbrFWRUlqQm66Wk
        bmIEhuvhieqXdjD2zfE4xMjEwXiIUYKDWUmEl/V0bIIQb0piZVVqUX58UWlOavEhRmkOFiVx
        3g28JWFCAumJJanZqakFqUUwWSYOTqkGxuWCdk/5hM7d27f++sXdZs7R6yxO9QrPs1gXrfbB
        MjH3Kc+8CSp6rfrnvb3StfLerRDZdmndUkGLfWqBn5N5AvULleQdjT0jfhezmCeVLJSyV7Bl
        YT5x2vnz4hMhZ6uf12a1rem8qP/2zJOCTSlbDOqWHV794qWSvd7s5TvrlIq3MVpv5GitVmIp
        zkg01GIuKk4EAECI/PVFAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pinmuxing for the enable pin of the usbh1 node is wrong. It needs to
be muxed as GPIO. While at it, move the pinctrl to the vbus regulator
since it is actually the regulator enable pin.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/d=
ts/imx6qdl-phytec-pfla02.dtsi
index 7a1e53195785..995e99952aca 100644
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
+				MX6QDL=5FPAD=5FGPIO=5F0=5F=5FGPIO1=5FIO00		0x80000000
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

