Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0020405BFB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 19:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240958AbhIIR0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 13:26:55 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:46064 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbhIIR0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 13:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1631208342; x=1633800342;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jbbetMc7CUD8n/rThyOnLoq5J7Z1RxGeMpNl5X/TCdg=;
        b=bP103GSntSORqfBR1JGFLA7wWyQcp3dNlF1nuvPBxSKWa+4iNE/g272sTVoRrwkQ
        5+55B7dDRmoXZwqOsXw4hACa/ReZEYNVCI0RKUhankfN9Z7U4worzdBrfsWUiGV8
        5WEyTUx96B1yq5ToU2obJk7I0lXKZEjb3KtI/iK4sl8=;
X-AuditID: c39127d2-c63ec70000001d24-c6-613a4396dfa0
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id E1.31.07460.6934A316; Thu,  9 Sep 2021 19:25:42 +0200 (CEST)
Received: from lws-ybas.phytec.de ([172.16.21.122])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021090919254195-1638982 ;
          Thu, 9 Sep 2021 19:25:41 +0200 
From:   Yunus Bas <y.bas@phytec.de>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     festevam@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: imx6: phycore-som: Disable micro-SD write protection
Date:   Thu, 9 Sep 2021 19:25:55 +0200
Message-Id: <20210909172555.435430-1-y.bas@phytec.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.09.2021 19:25:42,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.09.2021 19:25:42
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsWyRoCBS3eas1WiwY/VAhbzj5xjtXh41d9i
        0+NrrBaXd81hs2jde4Td4u/2TSwWL7aIO7B77Jx1l91j06pONo/NS+o9+v8aeHzeJBfAGsVl
        k5Kak1mWWqRvl8CVsfLmcaaC5ZwV93ZuZ29g/MfexcjBISFgInHgaWEXIxeHkMA2RonNWyex
        dTFyAjnnGSU+3bcDsdkEFCXO337LCmKLCNRK7N3+nB3EZhawkVj4t5ERZI6wgL/E0dM8IGEW
        ARWJjfd2sYDYvAKmEndOnACzJQTkJY786mSGiAtKnJz5hAVkr4TAFUaJn9+a2CGKhCROLz7L
        DDFfW2LZwtfMExj5ZiHpmYUktYCRaRWjUG5mcnZqUWa2XkFGZUlqsl5K6iZGYDAenqh+aQdj
        3xyPQ4xMHIyHGCU4mJVEeE9ssEwU4k1JrKxKLcqPLyrNSS0+xCjNwaIkznu/hylRSCA9sSQ1
        OzW1ILUIJsvEwSnVwMh2XV9K7QrLfbmSFLnFV/7du7j+nqRV4K+jrWc4J97IVOBzc3+/xkhB
        xqwjpXVC796Pf2U9aj0FFyx98GZtq7+AxnQTQYPXua5r17+aeVbzREGwT1qw9+9LU3c3lyxZ
        EpJaeJthybOX23vfCE2Ti/gRUbdIJJ4161u77JzfobwFZv9+b8ySN1diKc5INNRiLipOBAD2
        Pqa3NAIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The micro-SD card doesn't feature a write-protect pin. Set the
corresponding property in the devicetree to handle this behavior
correctly and suppress driver warnings.

Signed-off-by: Yunus Bas <y.bas@phytec.de>
---
 arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi | 1 +
 arch/arm/boot/dts/imx6ul-phytec-segin.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi b/arch/arm/boot/dts=
/imx6qdl-phytec-mira.dtsi
index 019938562aa9..0873f53ea275 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
@@ -256,6 +256,7 @@ &usdhc1 {
 	pinctrl-0 =3D <&pinctrl=5Fusdhc1>;
 	cd-gpios =3D <&gpio6 31 GPIO=5FACTIVE=5FLOW>;
 	no-1-8-v;
+	disable-wp;
 	status =3D "disabled";
 };
=20
diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin.dtsi b/arch/arm/boot/dts=
/imx6ul-phytec-segin.dtsi
index 95e4080dd0a6..0d4ba9494cf2 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-segin.dtsi
+++ b/arch/arm/boot/dts/imx6ul-phytec-segin.dtsi
@@ -191,6 +191,7 @@ &usdhc1 {
 	no-1-8-v;
 	keep-power-in-suspend;
 	wakeup-source;
+	disable-wp;
 	status =3D "disabled";
 };
=20
--=20
2.33.0

