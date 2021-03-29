Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6677D34CEF5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 13:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhC2L2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 07:28:45 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:62600 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhC2L2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 07:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1617017316; x=1619609316;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dag0VALSFXxJrNDdDso7no10SDPXXkuRDt61Ctbt0Rc=;
        b=K1oH4h2CocmPw4sGcR3hBIdtlV9kD9LY6bGzB0yMnqWz63P6B1OfjI02ywYg9865
        zAheioPcGBIM0tL6SWXQ6OTDLxqofP4llcfD5xBmpTj9/9Jwu0hm6QcTXqVLOG2T
        p7tuCece7UegKPnQxGmC2y5LTeDQ3f1pciKfS5L39eI=;
X-AuditID: c39127d2-85cb770000001c91-73-6061b9e48219
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 3C.8A.07313.4E9B1606; Mon, 29 Mar 2021 13:28:36 +0200 (CEST)
Received: from lws-riedmueller.phytec.de ([172.16.23.108])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021032913283634-253200 ;
          Mon, 29 Mar 2021 13:28:36 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>
Subject: [PATCH 3/3] ARM: dts: imx6: pbab01: Set vmmc supply for both SD interfaces
Date:   Mon, 29 Mar 2021 13:28:19 +0200
Message-Id: <20210329112819.64043-3-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329112819.64043-1-s.riedmueller@phytec.de>
References: <20210329112819.64043-1-s.riedmueller@phytec.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.03.2021 13:28:36,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.03.2021 13:28:36
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWyRoCBS/fJzsQEg45Dahbzj5xjtXh41d9i
        1dSdLBabHl9jtej6tZLZ4vKuOWwWrXuPsFv83b6JxeLFFnEHTo+ds+6ye2xa1cnmsXlJvcfG
        dzuYPPr/Gnh83iQXwBbFZZOSmpNZllqkb5fAlfFrvUDBE46Kc6cesTcwbmLvYuTkkBAwkfj7
        aDpjFyMXh5DANkaJBR/b2SCca4wSt793sYJUsQkYSSyY1sgEYosI5Eic2riZBcRmFuhkkvh9
        MriLkYNDWCBYYsF9PZAwi4CqxJqGncwgNq+AjcT6hpOsEMvkJWZe+g62mFPAVuL/ouVgNUJA
        NYcbIeK8AoISJ2c+YQG5QULgCqPEpT97mCGahSROLz7LDLFXW2LZwtfMExgFZiHpmYUktYCR
        aRWjUG5mcnZqUWa2XkFGZUlqsl5K6iZGYHAfnqh+aQdj3xyPQ4xMHIyHGCU4mJVEeFlPxyYI
        8aYkVlalFuXHF5XmpBYfYpTmYFES593AWxImJJCeWJKanZpakFoEk2Xi4JRqYJw3acV04Urz
        X3pdOvlqrwPOHGwoNzbRZveYJBhwY/ItJaf9pz4xtVu9z1ZgWefOwbfr/syEW5mVPaz2Z7+E
        B93n1mALO9IleMJN5jNDT9SRSfxGpw9r/7jxyKqg61PA0b8Het7Wdl+OC9ETyX9pr+Z35cS3
        ZctZXyQ8WZXW5bShTsJJz+KdnRJLcUaioRZzUXEiAAd04UZcAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting the vmmc supplies is crucial since otherwise the supplying
regulators get disabled and the SD interfaces are no longer powered
which leads to system failures if the system is booted from that SD
interface.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/d=
ts/imx6qdl-phytec-pfla02.dtsi
index 995e99952aca..3ab12aa2a615 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -433,6 +433,7 @@ &usdhc2 {
 	pinctrl-0 =3D <&pinctrl=5Fusdhc2>;
 	cd-gpios =3D <&gpio1 4 GPIO=5FACTIVE=5FLOW>;
 	wp-gpios =3D <&gpio1 2 GPIO=5FACTIVE=5FHIGH>;
+	vmmc-supply =3D <&vdd=5Fsd1=5Freg>;
 	status =3D "disabled";
 };
=20
@@ -442,5 +443,6 @@ &usdhc3 {
 		     &pinctrl=5Fusdhc3=5Fcdwp>;
 	cd-gpios =3D <&gpio1 27 GPIO=5FACTIVE=5FLOW>;
 	wp-gpios =3D <&gpio1 29 GPIO=5FACTIVE=5FHIGH>;
+	vmmc-supply =3D <&vdd=5Fsd0=5Freg>;
 	status =3D "disabled";
 };
--=20
2.25.1

