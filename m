Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0456F346A65
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 21:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbhCWUoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 16:44:16 -0400
Received: from mailoutvs39.siol.net ([185.57.226.230]:42102 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233327AbhCWUoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 16:44:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id A38685243E7;
        Tue, 23 Mar 2021 21:43:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MIC_cxZMKViE; Tue, 23 Mar 2021 21:43:59 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 668105243E1;
        Tue, 23 Mar 2021 21:43:59 +0100 (CET)
Received: from kista.localdomain (cpe-86-58-17-133.cable.triera.net [86.58.17.133])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id BDEF05243E7;
        Tue, 23 Mar 2021 21:43:58 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2] ARM: dts: sun8i: h3: beelink-x2: Add power button
Date:   Tue, 23 Mar 2021 21:43:41 +0100
Message-Id: <20210323204341.28825-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beelink X2 has power button. Add node for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
Changes from v1:
- renamed node name so it doesn't contain underscores

 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dt=
s/sun8i-h3-beelink-x2.dts
index 62b5280ec093..f0e591e1c771 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -111,6 +111,17 @@ spdif_out: spdif-out {
 		#sound-dai-cells =3D <0>;
 		compatible =3D "linux,spdif-dit";
 	};
+
+	r-gpio-keys {
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
2.31.0

