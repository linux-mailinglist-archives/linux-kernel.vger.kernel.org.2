Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E885134CEF4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 13:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhC2L2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 07:28:44 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:62600 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhC2L2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 07:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1617017314; x=1619609314;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aZMvFMWsWKvhUAOx0SGgYMa/c6xYvOAnpIPnOvBRG/M=;
        b=E++NQzaLHPdGiH1mtmMaVn7WShaJlon+dw8BprodCLAqDEfslvKXod5TuHT8c5Cq
        4hEuzSwlbFBgosgZGc1gbHmnELZ/8zxZEod2CbQIYVsVkxFmQMfTayEAGnMBRWo6
        fBev+xRbPmThroRflSfpNcVDIQVQh7y9RkYoCEDfBEU=;
X-AuditID: c39127d2-868b870000001c91-71-6061b9e29b37
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 7B.8A.07313.2E9B1606; Mon, 29 Mar 2021 13:28:34 +0200 (CEST)
Received: from lws-riedmueller.phytec.de ([172.16.23.108])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021032913283457-253199 ;
          Mon, 29 Mar 2021 13:28:34 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>
Subject: [PATCH 2/3] ARM: dts: imx6: pbab01: Set USB OTG port to peripheral
Date:   Mon, 29 Mar 2021 13:28:18 +0200
Message-Id: <20210329112819.64043-2-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329112819.64043-1-s.riedmueller@phytec.de>
References: <20210329112819.64043-1-s.riedmueller@phytec.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.03.2021 13:28:34,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.03.2021 13:28:34
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWyRoCBS/fRzsQEgzUnjC3mHznHavHwqr/F
        qqk7WSw2Pb7GatH1ayWzxeVdc9gsWvceYbf4u30Ti8WLLeIOnB47Z91l99i0qpPNY/OSeo+N
        73YwefT/NfD4vEkugC2KyyYlNSezLLVI3y6BK+PQvaOsBb9ZK95vcGlg/MfSxcjJISFgIvFt
        4yTmLkYuDiGBbYwSB9ZsY4RwrjFK/Fy3hwmkik3ASGLBtEYwW0QgR+LUxs1g3cwCnUwSv08G
        g9jCAt4SE3bNBarh4GARUJXYPb8AJMwrYCNx8+psVohl8hIzL31nB7E5BWwl/i9azgxiCwHV
        HG6EiPMKCEqcnPkE6rgrjBJvtuVC2EISpxefZYZYqy2xbOFr5gmMArOQtMxCklrAyLSKUSg3
        Mzk7tSgzW68go7IkNVkvJXUTIzC0D09Uv7SDsW+OxyFGJg7GQ4wSHMxKIrysp2MThHhTEiur
        Uovy44tKc1KLDzFKc7AoifNu4C0JExJITyxJzU5NLUgtgskycXBKNTB2Pe4XkTjcfVvhmDyz
        hbFSTopcWA/XNN7sEx5aLKGL/8S//lId/HeyQ8CzTkdlhhQnpTjXojsJ9jnv7k408vXc8NTg
        qdurWf9sdzzb1B+cfydl6cw9i2+IVxz4tYEjsN3r4H7P7AUlPfnHn3yXep3O9e7vg9UhXnvE
        tz6/8vsVV2mcwAyu6SuUWIozEg21mIuKEwEi6LzIWwIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a hardware bug preventing the correct detection if the ID pin
the USB OTG port cannot be used in otg mode. It can either be set to
host or peripheral. Set it to peripheral so vbus is disabled by default.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
 arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi b/arch/arm/boot/d=
ts/imx6qdl-phytec-pbab01.dtsi
index d434868e870a..b2f78b4362cb 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
@@ -164,6 +164,7 @@ &usbh1 {
=20
 &usbotg {
 	status =3D "okay";
+	dr=5Fmode =3D "peripheral";
 };
=20
 &usdhc2 {
--=20
2.25.1

