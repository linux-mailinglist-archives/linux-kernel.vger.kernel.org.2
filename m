Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310B3342EFA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 19:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhCTSYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 14:24:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:52459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229880AbhCTSYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 14:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616264651;
        bh=cRfWA5R1fJ5FGd11SNvO8ZcOB+OoWYmC3HHkh1uT+BE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XDaYKRXWa8HDMRm3Rp8wwFl7I5lZhsArc+4JDMptV1fYZQgy3o6YycJ+IYy0ntMat
         +cIbMr1+fiHw0IlFS2tsjkq8vcZtbc2tnQjJ05FlH4tabc2VqPglOxyW1g1ctwWQiq
         3Cb08QSfpXd23KO8prAnM2GVqaKF95PWWvNN4xU0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DNt-1lP2e63H3d-003ht6; Sat, 20
 Mar 2021 19:24:11 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 14/14] MAINTAINERS: Nuvoton NPCM: Add wpcm patterns
Date:   Sat, 20 Mar 2021 19:16:10 +0100
Message-Id: <20210320181610.680870-15-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210320181610.680870-1-j.neuschaefer@gmx.net>
References: <20210320181610.680870-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+/m8+Ew9kOublJzm4+L1AeTlyuOvvvyZG3GyrV0FrzuiBdG0TVD
 raXC/64LQaIXG9lpQDNKs/ukQMlXgTTRGkJj0fDJhvQInvCI73UTj/08uU69bAnSqLDgHD/
 iQKKn5genx/qPQSNzcpVdRtz/ZNOgJ0BBXJuNa3PzD5OwLaFA25OGuGlhUw657kYD5A56Ic
 49zLnM0L3iuUQKo5I0kkg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7vCqhzdpnTY=:TAIB+s7h+V1wG6glWf8vmZ
 hutayMs5l6dlY0bEDborbI1fTAhqxEv/qAXsknWkal8S5Wh8Ufsh7+kfqm2Ta5dr7LniOvhc+
 NY1dKGRmy3LeTJUn6ewn2iXX8J2Ye1k4s3dfOuKzMYEgVdPlgfzSRbXgHZu3G2UYE7wyhIfpC
 qmt4J/tgIhcBy0M/LQm9Fo3wp8bfT29S0NbsOjce2QI3wUM7izlJWMIpSBTRMlaK4zxPewYTF
 XJuG4lLjRYFzCaPOFaHT1o0Ht2Dbr2rpotnhRQagK7yq1BsY/W2p3Om9RF3dlmyVixaSRW6qw
 dLoibW2Hh1xkWjLj0gfOu+U0v1S8mMHn6dXDr2uBDjCz0CLxQwzn+oubOw1vKhuUIA1LxqGTE
 9Znum7Mc+ydon4faXqpsRCYtmHqbJDRmWGkT56+MpAXkq8oHZd9OlM75unU9XjHXG1d/8NwbK
 246kXT9B9CZZ/+El88umb8dGkFsfSEb3NneMQ0pV7uskmFnsawGvJ3ImTPTC/DOxcgbMPuWlx
 4L4jljGtVM0U3yrtU3ZIq19OUvfrchdmPIcX8Of3fA5DFGjmLlG7Xf/8Z25F5TdvukVf4S7Zy
 6o7MMiTYrGUOCTbYFDJLpGf1U4+Tl3wMnfVnpu+0IaycaYF8upslR7Tavggag6tNzLrD1zU3P
 tRXdPG2MX2ieipN78/9GFAnCYq9ymtO6HHZNvhh6fbMagzUlmxC2uN9rVs76nMGpmPyjVQlip
 reY2aDkyU4zf6f90P8CUlKwqO2HgoKlJ1Vujw/t+y+UcwDXTyLqw/WIVOcyQ/23AtyPbwPiLv
 J1qV6k6XwS5vJn3Wabz2xRCxhGf3VVb5vFxfnkOxAHpcj7nlNRMmoQmmLosqeJiaMyB9f3Wb0
 MCiTugheLgXjW6CwD9xA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that patches related to the Nuvoton WPCM450 (part of the NPCM
family) find the Nuvoton NPCM maintainers and reviewers.

I am adding myself as a reviewer, so that I don't miss these patches.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
=2D--
 MAINTAINERS | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d3..97923952679a8 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2184,14 +2184,15 @@ M:	Tali Perry <tali.perry1@gmail.com>
 R:	Patrick Venture <venture@google.com>
 R:	Nancy Yuen <yuenn@google.com>
 R:	Benjamin Fair <benjaminfair@google.com>
+R:	Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
 L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
-F:	Documentation/devicetree/bindings/*/*/*npcm*
-F:	Documentation/devicetree/bindings/*/*npcm*
-F:	arch/arm/boot/dts/nuvoton-npcm*
+F:	Documentation/devicetree/bindings/*/*/*[nw]pcm*
+F:	Documentation/devicetree/bindings/*/*[nw]pcm*
+F:	arch/arm/boot/dts/nuvoton-[nw]pcm*
 F:	arch/arm/mach-npcm/
-F:	drivers/*/*npcm*
-F:	drivers/*/*/*npcm*
+F:	drivers/*/*[nw]pcm*
+F:	drivers/*/*/*[nw]pcm*
 F:	include/dt-bindings/clock/nuvoton,npcm7xx-clock.h

 ARM/OPENMOKO NEO FREERUNNER (GTA02) MACHINE SUPPORT
=2D-
2.30.2

