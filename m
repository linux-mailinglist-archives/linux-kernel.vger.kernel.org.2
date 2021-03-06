Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198D632FD2A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 21:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhCFUg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 15:36:29 -0500
Received: from mailoutvs22.siol.net ([185.57.226.213]:47005 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231211AbhCFUgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 15:36:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 87CB1522D6D;
        Sat,  6 Mar 2021 21:36:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ytDBUOGx0MJD; Sat,  6 Mar 2021 21:36:18 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 4C13C522E09;
        Sat,  6 Mar 2021 21:36:18 +0100 (CET)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id ABC34522D6D;
        Sat,  6 Mar 2021 21:36:17 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH] ARM: dts: sun8i: h3: beelink-x2: Add power button
Date:   Sat,  6 Mar 2021 21:36:11 +0100
Message-Id: <20210306203611.15534-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beelink X2 has power button. Add node for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dt=
s/sun8i-h3-beelink-x2.dts
index 62b5280ec093..4a2cb072ecf6 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -111,6 +111,17 @@ spdif_out: spdif-out {
 		#sound-dai-cells =3D <0>;
 		compatible =3D "linux,spdif-dit";
 	};
+
+	r_gpio_keys {
+		compatible =3D "gpio-keys";
+
+		power {
+			label =3D "power";
+			linux,code =3D <KEY_POWER>;
+			gpios =3D <&r_pio 0 3 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+	};
 };
=20
 &de {
--=20
2.30.1

