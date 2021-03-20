Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0E1342EE5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 19:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCTSVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 14:21:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:39243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229900AbhCTSUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 14:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616264443;
        bh=sgopXkqj40uUkRPhDPMpk7bTtLvVFAAsQsE3W8f8Do8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BkaMOoub696+Jm0b6bzsfT0p4QODdeA5LFElVr89K7mURIrT7dwIHQwcmYoYHJn/M
         siT2j/4c2TdItqHFOwV7lm5LEmWIZ+BmH89L3gCOoX8X927MKY8lkAk0jDXTFS7seN
         OYNk/sZbF19QMr6Tc3eN9+x6GgZF4cex+8R+2eLw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHAB-1luW7U1M5L-00glr4; Sat, 20
 Mar 2021 19:20:43 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 07/14] ARM: npcm: Introduce Nuvoton WPCM450 SoC
Date:   Sat, 20 Mar 2021 19:16:03 +0100
Message-Id: <20210320181610.680870-8-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210320181610.680870-1-j.neuschaefer@gmx.net>
References: <20210320181610.680870-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Cpwml3BuleDgxGQANF+bJyKDQJJr7bedoFK5LxmcxZgU6RHcSvk
 qHnOfk0QXcrYl2rdtwk1hzK/dz28SbedbGRSH1sRlS9tWRGx7zLXQaQH9p31UpKTgFLVLRQ
 GeuGiBqgi9y6eMY89Sjq+0v468ZJnt6Rw2Zkxw4sNUjaaUC8nP5KOqD9XRbyvh57C3+AcdK
 3qoad5/BSg0VzITYXmYAw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bbr5qGFW1+s=:57a3VOHV4y/O7L0vIpHmav
 YisAMpCqlhEwivtHfxckG3BduwiJEMAfClmyST5QH1welmlCZ6SFQhp1/47OkSGwxL1kxPVCT
 VhyEpiMmf59X8qCN47SQL7uT03poC+/Z5oAElFKKHHUSQhhPdYTP0sVx/gwlSTNHwEsh3fors
 QzmMfVkZzxCrCvOiW3+r3WIShOyhXSTOGgEEN+IMX4ZCFMtSSQe7xqMyN9mx05sF/GmszwDVZ
 NJRMngz6O4MvnDdr8eITy6Ho9E8gQwi4Cf9Mp/dinuU/xYG0K5uJ507XCmxImVxul0EMDzYXO
 z/9sHcWnDZcT8+xEKzOU0NK7nuARtjH6JyFmLUH4rldcMcHww+9erF20eYHWOINY88j/slshp
 h4wllBp7Q8rx8PBuvVTKuum8GMJvNSUt/4cpOaN8j7sRvFCabkDSOEBILSem10TwvQqGRj/Wf
 CaX60fLlzno1r7KrlGcZW4/tk+WKpFWQmyLqopBvP4xCHsniASEcYOkWEGKACIBesDXm1aB22
 tlnVbBpqrHeF91U2FukupHKb0//E5EMSo1/40pVtCf+XNOQKc/IKxkOMFZbY2ax5N+Wc4f4L/
 Nr+WV2w41IWl8+xGjl2m5AFu9Abu8UasX2V1w4MZBTwcXuVZmJwLFVr12g3t7I325EE4NzzZI
 vDJ8+4pl0Zd82XnxrBCBwmY9YPBgSKz6VplOMp9Wv0OsOdGQVcOMmwZN2tOZkloUWUUbSm7D2
 jI052Ioo+D5QMgQnLVRnjjXvy/cJG9geXiVnUclEuY5CuBrAnb7m6osVyXlEQOoRW+zfo4OfV
 WWfalBMuAL/AyTBHtkIoAHlYJ7JQoCFX8sbv8yBYRJcv/cagfFeCJX2gjQwy6IBZT00gcKX4K
 JV5N17CO94838z2+FK8Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WPCM450 is an older BMC SoC in the Nuvoton NPCM family, originally
marketed as Winbond WPCM450.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/mach-npcm/Kconfig   | 12 +++++++++++-
 arch/arm/mach-npcm/Makefile  |  1 +
 arch/arm/mach-npcm/wpcm450.c | 13 +++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-npcm/wpcm450.c

diff --git a/arch/arm/mach-npcm/Kconfig b/arch/arm/mach-npcm/Kconfig
index 7f7002dc2b21f..658c8efb4ca14 100644
=2D-- a/arch/arm/mach-npcm/Kconfig
+++ b/arch/arm/mach-npcm/Kconfig
@@ -1,11 +1,21 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig ARCH_NPCM
 	bool "Nuvoton NPCM Architecture"
-	depends on ARCH_MULTI_V7
+	depends on ARCH_MULTI_V5 || ARCH_MULTI_V7
 	select PINCTRL

 if ARCH_NPCM

+config ARCH_WPCM450
+	bool "Support for WPCM450 BMC (Hermon)"
+	depends on ARCH_MULTI_V5
+	select CPU_ARM926T
+	select NPCM7XX_TIMER
+	help
+	  General support for WPCM450 BMC (Hermon).
+
+	  Winbond/Nuvoton WPCM450 BMC based on the ARM926EJ-S.
+
 config ARCH_NPCM7XX
 	bool "Support for NPCM7xx BMC (Poleg)"
 	depends on ARCH_MULTI_V7
diff --git a/arch/arm/mach-npcm/Makefile b/arch/arm/mach-npcm/Makefile
index 1bc3a70bfab8b..0a915084c8ff3 100644
=2D-- a/arch/arm/mach-npcm/Makefile
+++ b/arch/arm/mach-npcm/Makefile
@@ -2,4 +2,5 @@
 AFLAGS_headsmp.o		+=3D -march=3Darmv7-a

 obj-$(CONFIG_ARCH_NPCM7XX)	+=3D npcm7xx.o
+obj-$(CONFIG_ARCH_WPCM450)	+=3D wpcm450.o
 obj-$(CONFIG_SMP)		+=3D platsmp.o headsmp.o
diff --git a/arch/arm/mach-npcm/wpcm450.c b/arch/arm/mach-npcm/wpcm450.c
new file mode 100644
index 0000000000000..f17b3dab45af3
=2D-- /dev/null
+++ b/arch/arm/mach-npcm/wpcm450.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2021 Jonathan Neusch=C3=A4fer
+
+#include <asm/mach/arch.h>
+
+static const char *const wpcm450_dt_match[] =3D {
+	"nuvoton,wpcm450",
+	NULL
+};
+
+DT_MACHINE_START(WPCM450_DT, "WPCM450 chip")
+	.dt_compat	=3D wpcm450_dt_match,
+MACHINE_END
=2D-
2.30.2

