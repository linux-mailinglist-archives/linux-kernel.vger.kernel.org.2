Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666BF390006
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 13:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhEYLd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 07:33:29 -0400
Received: from first.geanix.com ([116.203.34.67]:48186 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231190AbhEYLdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 07:33:22 -0400
X-Greylist: delayed 531 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 May 2021 07:33:22 EDT
Received: from localhost (80-62-117-165-mobile.dk.customer.tdc.net [80.62.117.165])
        by first.geanix.com (Postfix) with ESMTPSA id 194AE46181E;
        Tue, 25 May 2021 11:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1621941777; bh=Oy2Cx/M2zELsslWhmc5BIVf86O5MuE1OwiFxG1cgwUw=;
        h=From:To:Cc:Subject:Date;
        b=VsbkbIWGXvGe965MUm6cRViXRoJWSz9R/KIpcxwgptfy/mlpOdAq7fWp8bDfwl1Cl
         +L1hpt2r7HxsvggKxT174GXYmE0/fvAGxXpUH9cfkalvmnN5jPNGCV4ct7at1XFnRh
         La46CHySNUnZhFMchI37DgprvnPAw5pNt2wF15abAU4cCiqt+MoX0KksScb16RvvhF
         Bsldq5DltSdba5auLUyK4cc2tX82BqqNesg/hspIscaJGXl1O8gl6IYLuu8NbUdqb8
         zzklX04Xu0BML3Gs5O32XcxhB9iN2TkRcLWwnA+4IXGMV59sq0/HMRLFrxaJR6JYPz
         e+eQ+DD1P2pmg==
From:   Esben Haabendal <esben@geanix.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx: only enable pinctrl as needed
Date:   Tue, 25 May 2021 13:22:54 +0200
Message-Id: <be1c35eb997959b4939b304ef26664dfb9cd2275.1621941451.git.esben@geanix.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=4.0 tests=ALL_TRUSTED,BAYES_20,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As not all mach-imx platforms has support for run-time changes of pin
configurations (such as LS1021A), a more selective approach to enabling
pinctrl infrastructure makes sense, so that an e.g. an LS1021A only kernel
could be built without pinctrl support.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 arch/arm/mach-imx/Kconfig | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index b407b024dde3..3fc170456cde 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -6,7 +6,6 @@ menuconfig ARCH_MXC
 	select CLKSRC_IMX_GPT
 	select GENERIC_IRQ_CHIP
 	select GPIOLIB
-	select PINCTRL
 	select PM_OPP if PM
 	select SOC_BUS
 	select SRAM
@@ -61,6 +60,7 @@ config SOC_IMX31
 config SOC_IMX35
 	bool "i.MX35 support"
 	select MXC_AVIC
+	select PINCTRL
 	select PINCTRL_IMX35
 	help
 	  This enables support for Freescale i.MX35 processor
@@ -73,6 +73,7 @@ config SOC_IMX1
 	bool "i.MX1 support"
 	select CPU_ARM920T
 	select MXC_AVIC
+	select PINCTRL
 	select PINCTRL_IMX1
 	help
 	  This enables support for Freescale i.MX1 processor
@@ -85,6 +86,7 @@ config SOC_IMX25
 	bool "i.MX25 support"
 	select CPU_ARM926T
 	select MXC_AVIC
+	select PINCTRL
 	select PINCTRL_IMX25
 	help
 	  This enables support for Freescale i.MX25 processor
@@ -93,6 +95,7 @@ config SOC_IMX27
 	bool "i.MX27 support"
 	select CPU_ARM926T
 	select MXC_AVIC
+	select PINCTRL
 	select PINCTRL_IMX27
 	help
 	  This enables support for Freescale i.MX27 processor
@@ -110,6 +113,7 @@ config SOC_IMX5
 
 config	SOC_IMX50
 	bool "i.MX50 support"
+	select PINCTRL
 	select PINCTRL_IMX50
 	select SOC_IMX5
 
@@ -118,6 +122,7 @@ config	SOC_IMX50
 
 config SOC_IMX51
 	bool "i.MX51 support"
+	select PINCTRL
 	select PINCTRL_IMX51
 	select SOC_IMX5
 	help
@@ -125,6 +130,7 @@ config SOC_IMX51
 
 config	SOC_IMX53
 	bool "i.MX53 support"
+	select PINCTRL
 	select PINCTRL_IMX53
 	select SOC_IMX5
 
@@ -149,6 +155,7 @@ config SOC_IMX6Q
 	select ARM_ERRATA_775420
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD
+	select PINCTRL
 	select PINCTRL_IMX6Q
 	select SOC_IMX6
 
@@ -159,6 +166,7 @@ config SOC_IMX6SL
 	bool "i.MX6 SoloLite support"
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_775420
+	select PINCTRL
 	select PINCTRL_IMX6SL
 	select SOC_IMX6
 
@@ -169,6 +177,7 @@ config SOC_IMX6SLL
 	bool "i.MX6 SoloLiteLite support"
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_775420
+	select PINCTRL
 	select PINCTRL_IMX6SLL
 	select SOC_IMX6
 
@@ -179,6 +188,7 @@ config SOC_IMX6SX
 	bool "i.MX6 SoloX support"
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_775420
+	select PINCTRL
 	select PINCTRL_IMX6SX
 	select SOC_IMX6
 
@@ -187,6 +197,7 @@ config SOC_IMX6SX
 
 config SOC_IMX6UL
 	bool "i.MX6 UltraLite support"
+	select PINCTRL
 	select PINCTRL_IMX6UL
 	select SOC_IMX6
 	select ARM_ERRATA_814220
@@ -223,6 +234,7 @@ config SOC_IMX7D_CM4
 
 config SOC_IMX7D
 	bool "i.MX7 Dual support"
+	select PINCTRL
 	select PINCTRL_IMX7D
 	select SOC_IMX7D_CA7 if ARCH_MULTI_V7
 	select SOC_IMX7D_CM4 if ARM_SINGLE_ARMV7M
@@ -233,6 +245,7 @@ config SOC_IMX7D
 config SOC_IMX7ULP
 	bool "i.MX7ULP support"
 	select CLKSRC_IMX_TPM
+	select PINCTRL
 	select PINCTRL_IMX7ULP
 	select SOC_IMX7D_CA7 if ARCH_MULTI_V7
 	select SOC_IMX7D_CM4 if ARM_SINGLE_ARMV7M
@@ -242,6 +255,7 @@ config SOC_IMX7ULP
 config SOC_VF610
 	bool "Vybrid Family VF610 support"
 	select ARM_GIC if ARCH_MULTI_V7
+	select PINCTRL
 	select PINCTRL_VF610
 
 	help
-- 
2.31.1

