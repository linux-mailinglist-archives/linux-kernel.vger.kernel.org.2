Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6234237C4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 08:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbhJFGGE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Oct 2021 02:06:04 -0400
Received: from ni.piap.pl ([195.187.100.5]:47588 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhJFGGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 02:06:01 -0400
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] CONFIG_SOC_IMX6Q = i.MX6 Quad/DualLite/Solo
Date:   Wed, 06 Oct 2021 08:04:07 +0200
Message-ID: <m3sfxen0yw.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print i.MX6 "Solo" name in addition to the "Quad" and "DualLite"
for SOC_IMX6Q.

Signed-off-by: Krzysztof Hałasa <khalasa@piap.pl>

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index b407b024dde3..b6f2f2ea8e65 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -143,7 +143,7 @@ config SOC_IMX6
 	select PL310_ERRATA_769419 if CACHE_L2X0
 
 config SOC_IMX6Q
-	bool "i.MX6 Quad/DualLite support"
+	bool "i.MX6 Quad/DualLite/Solo support"
 	select ARM_ERRATA_764369 if SMP
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_775420
@@ -153,7 +153,7 @@ config SOC_IMX6Q
 	select SOC_IMX6
 
 	help
-	  This enables support for Freescale i.MX6 Quad processor.
+	  This enables support for Freescale i.MX6 Quad/DualLite/Solo processors.
 
 config SOC_IMX6SL
 	bool "i.MX6 SoloLite support"
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 11dcc369ec14..8cc8a2ed1d12 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -217,7 +217,7 @@ static const char * const imx6q_dt_compat[] __initconst = {
 	NULL,
 };
 
-DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad/DualLite (Device Tree)")
+DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad/DualLite/Solo (Device Tree)")
 	.l2c_aux_val 	= 0,
 	.l2c_aux_mask	= ~0,
 	.smp		= smp_ops(imx_smp_ops),

-- 
Krzysztof "Chris" Hałasa

Sieć Badawcza Łukasiewicz
Przemysłowy Instytut Automatyki i Pomiarów PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
