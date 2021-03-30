Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F6334F127
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 20:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhC3Smr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 14:42:47 -0400
Received: from mailoutvs2.siol.net ([185.57.226.193]:53484 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232825AbhC3Smc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:42:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id DBF0A525379;
        Tue, 30 Mar 2021 20:42:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qijVTcZ6ewZj; Tue, 30 Mar 2021 20:42:24 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 9C9FE5253A4;
        Tue, 30 Mar 2021 20:42:24 +0200 (CEST)
Received: from kista.localdomain (cpe-86-58-17-133.cable.triera.net [86.58.17.133])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 0A5E5525379;
        Tue, 30 Mar 2021 20:42:24 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, jernej.skrabec@siol.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH] arm64: dts: allwinner: h6: beelink-gs1: Remove ext. 32 kHz osc reference
Date:   Tue, 30 Mar 2021 20:42:18 +0200
Message-Id: <20210330184218.279738-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although every Beelink GS1 seems to have external 32768 Hz oscillator,
it works only on one from four tested. There are more reports of RTC
issues elsewhere, like Armbian forum.

One Beelink GS1 owner read RTC osc status register on Android which
shipped with the box. Reported value indicated problems with external
oscillator.

In order to fix RTC and related issues (HDMI-CEC and suspend/resume with
Crust) on all boards, switch to internal oscillator.

Fixes: 32507b868119 ("arm64: dts: allwinner: h6: Move ext. oscillator to =
board DTs")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/ar=
ch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 669d39fc716a..6249e9e02928 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -289,10 +289,6 @@ sw {
 	};
 };
=20
-&rtc {
-	clocks =3D <&ext_osc32k>;
-};
-
 &spdif {
 	status =3D "okay";
 };
--=20
2.31.0

