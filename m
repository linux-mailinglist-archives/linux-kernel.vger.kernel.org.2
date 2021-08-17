Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3BD3EEC2B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 14:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239890AbhHQMJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 08:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbhHQMJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 08:09:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38983C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 05:08:37 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mFxtR-0008Cj-N9; Tue, 17 Aug 2021 14:08:33 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mFxtR-0001Va-1p; Tue, 17 Aug 2021 14:08:33 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com
Subject: [PATCH v1] ARM: imx6: mask all interrupts before calling stby-poweroff sequence
Date:   Tue, 17 Aug 2021 14:08:32 +0200
Message-Id: <20210817120832.5746-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any pending interrupt can prevent entering standby based power off state.
To avoid it, mask all interrupts.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/mach-imx/pm-imx6.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 9244437cb1b9..63887ade411a 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -59,8 +59,11 @@
 #define MX6Q_SUSPEND_OCRAM_SIZE		0x1000
 #define MX6_MAX_MMDC_IO_NUM		33
 
+#define GIC_DIST_ENABLE_CLEAR		0x180
+
 static void __iomem *ccm_base;
 static void __iomem *suspend_ocram_base;
+static void __iomem *gic_raw_dist_base;
 static void (*imx6_suspend_in_ocram_fn)(void __iomem *ocram_vbase);
 
 /*
@@ -592,6 +595,7 @@ static int __init imx6q_suspend_init(const struct imx6_pm_socdata *socdata)
 static void __init imx6_pm_common_init(const struct imx6_pm_socdata
 					*socdata)
 {
+	struct device_node *np;
 	struct regmap *gpr;
 	int ret;
 
@@ -615,10 +619,29 @@ static void __init imx6_pm_common_init(const struct imx6_pm_socdata
 	if (!IS_ERR(gpr))
 		regmap_update_bits(gpr, IOMUXC_GPR1, IMX6Q_GPR1_GINT,
 				   IMX6Q_GPR1_GINT);
+
+	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-gic");
+	gic_raw_dist_base = of_iomap(np, 0);
+}
+
+static void imx_gic_mask_all(void)
+{
+	int i;
+
+	if (WARN_ON(!gic_raw_dist_base))
+		return;
+
+	for (i = 0; i < 4; i++)
+		writel_relaxed(~0, gic_raw_dist_base + GIC_DIST_ENABLE_CLEAR + 4 * i);
 }
 
 static void imx6_pm_stby_poweroff(void)
 {
+	/*
+	 * A pending interrupt can prevent power off signal to be activated.
+	 * So, mask all interrupts to avoid it.
+	 */
+	imx_gic_mask_all();
 	imx6_set_lpm(STOP_POWER_OFF);
 	imx6q_suspend_finish(0);
 
-- 
2.30.2

