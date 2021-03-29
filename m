Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B9634D0D9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhC2NBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:01:46 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:65326 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbhC2NBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1617022866; x=1619614866;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yATpTTIIi8G4Xo470utqmEaWBAb3mQqM7AoTAPX/JF4=;
        b=GUjKgWAb6VDNTgTiBJIH6K75unQV6uh3J/1EybxGPCFIZiieAIwc9Jt+onnX4rAF
        2rPnbPKAC9s63TJdDZY3kNrNBVTFrTFEm60bPfhCwOK24909NpAMUjeH0agzD8+C
        YMEwcEYCmrxx3v9o+Q8b6G50LN1aN5ysFOdPCFiZZYc=;
X-AuditID: c39127d2-868b870000001c91-3a-6061cf921b7d
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 00.5B.07313.29FC1606; Mon, 29 Mar 2021 15:01:06 +0200 (CEST)
Received: from lws-riedmueller.phytec.de ([172.16.23.108])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021032915010635-253810 ;
          Mon, 29 Mar 2021 15:01:06 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>
Subject: [PATCH v2 3/3] ARM: dts: imx6: pbab01: Set vmmc supply for both SD interfaces
Date:   Mon, 29 Mar 2021 15:01:03 +0200
Message-Id: <20210329130103.65857-3-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329130103.65857-1-s.riedmueller@phytec.de>
References: <20210329130103.65857-1-s.riedmueller@phytec.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.03.2021 15:01:06,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.03.2021 15:01:06
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWyRoCBS3fS+cQEg65Zihbzj5xjtXh41d9i
        1dSdLBabHl9jtej6tZLZ4vKuOWwWrXuPsFv83b6JxeLFFnEHTo+ds+6ye2xa1cnmsXlJvcfG
        dzuYPPr/Gnh83iQXwBbFZZOSmpNZllqkb5fAldF28hBjwVGuil2TVrM0ML7g6GLk5JAQMJH4
        emIyI4gtJLCNUWL9ucAuRi4g+xqjxNKbN1hBEmwCRhILpjUygdgiAjkSpzZuZgGxmQU6mSR+
        nwwGsYUFwiQ2ToeoZxFQlejZsxRsKK+AjcTNln1MEMvkJWZe+s4OYnMK2EpcOvKODWKxjcTT
        Ky+g6gUlTs58wgJyhITAFUaJDY3LWSCahSROLz7LDLFYW2LZwtfMExgFZiHpmYUktYCRaRWj
        UG5mcnZqUWa2XkFGZUlqsl5K6iZGYHgfnqh+aQdj3xyPQ4xMHIyHGCU4mJVEeIUPJCYI8aYk
        VlalFuXHF5XmpBYfYpTmYFES593AWxImJJCeWJKanZpakFoEk2Xi4JRqYExJzVvPzcf4R+Pb
        N4uv0+6cFTpu3u/Da2G35vbDNfNEb5z+eOSJ6cJJz/7LxNubu1q/rvI95/pKx3h58oYpP4tC
        NH+JCC8W3blLbaLIAtlZa/QVjkjMnsnHZxkkquOtsKn8zg1Pu+OHT31ynfI9NuT0v3fLknVs
        Xt3z2h8xQeJrZvN5pX71ngglluKMREMt5qLiRABWzGgcXQIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting the vmmc supplies is crucial since otherwise the supplying
regulators get disabled and the SD interfaces are no longer powered
which leads to system failures if the system is booted from that SD
interface.

Fixes: 1e44d3f880d5 ("ARM i.MX6Q: dts: Enable I2C1 with EEPROM and PMIC on =
Phytec phyFLEX-i.MX6 Ouad module")

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
Changes in v2:
 - Added fixes tag
 - Added reviewed-by

 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/d=
ts/imx6qdl-phytec-pfla02.dtsi
index 9f39c926cc08..cafbd3d1064d 100644
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

