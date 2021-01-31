Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F98309F05
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 21:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhAaU5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 15:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbhAaU5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 15:57:39 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF030C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 12:56:58 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id u66so11784795qkd.13
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 12:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=M0/ffCzflaSzm8zegmbrgtKSZrWUkbfyK67XvLh2jA4=;
        b=e5lbRHX7c9nMDJzgY4V6CSl5cGAINtlBKXqzoKy+GUx9VH/kA5+pcABQ1u1K+UdiSq
         ovM1czT3X6b0+p5ZpjKXYgtRLUqdoptPaQ+Aqr4lRS3MQLpdKmOs5Rmv4jBV9nZw65ij
         wbDQj89xwU0y0D4FV0V5WlK/G3Z+5jkN3lbj5jPLyMH0Kc7lEWX7fflur9haIq/P/ilV
         cvGHByto1dGvif6OhGIaCuIsTYEjGQaHDkI+sqk1iDsan4Wwys/hKLqleV58R6LVbFCj
         eDDeuDbBjHAOL84cN0zwi5T4IvhTqQH74Dto3Y+d98ClsXRVriAipPzMs7YXquNq5EWj
         rBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=M0/ffCzflaSzm8zegmbrgtKSZrWUkbfyK67XvLh2jA4=;
        b=HQ6k0wn+NBjlKvn7QtlL4aBuLHEdz3yUID8guIztfoWxrBMFUK+GxmOGcKX00puEw7
         t7+bPnITnheF0xVrpkwhYW3HRp1XmwK4xyDCMVzYkuJfwZcJ2FJ6BP6hg2mhmrwPhvs5
         r2YufRDFh/lUC6G/H4F39Qop84j3A29bzlp7ihEQR80W83tZ8VX+oLxZgjsZkW8TmGMG
         2naihmPClE82+SYOvN4TfeFp/bRPaHrRhw8rKOg9suAcnqLj83M0agqpV0WpL2ORaFHe
         /Q5hrNoNHFxROAGD7e1NCxHzN/17Q8fhcJ7BOTBIdQ+BwKA+TXj1gI0bstEIHfQK9ac/
         vqwg==
X-Gm-Message-State: AOAM533QyxyzkPfbAIWAoVRzUODtyPYGdqnkPV3av/2WV/rzuAsgb1X1
        /dJYEyK2FHJR8HBC8MQ29HmkofHwLR7UVmU=
X-Google-Smtp-Source: ABdhPJy+M2FKsXWxPbkG0IyqHwoolAG9sb04KgbtDqMBfjWPpcT0bbPu6PfAGvvgkHzbfNl89R7X7LQseqQQdHY=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a0c:f582:: with SMTP id
 k2mr12673609qvm.55.1612126618116; Sun, 31 Jan 2021 12:56:58 -0800 (PST)
Date:   Sun, 31 Jan 2021 12:56:53 -0800
Message-Id: <20210131205654.3379661-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v1] ARM: imx: avic: Convert to using IRQCHIP_DECLARE
From:   Saravana Kannan <saravanak@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Martin Kaiser <martin@kaiser.cx>, kernel-team@android.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a lot of boilerplate code. Also address boot issues on imx25 with
fw_devlink=on that were reported by Martin.

Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
Reported-by: Martin Kaiser <martin@kaiser.cx>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---

I've compile tested this for imx25 and imx27. But I don't have any
devices to test this on.

-Saravana

 arch/arm/mach-imx/avic.c       | 16 +++++++++++++++-
 arch/arm/mach-imx/common.h     |  1 -
 arch/arm/mach-imx/mach-imx1.c  | 11 -----------
 arch/arm/mach-imx/mach-imx25.c | 12 ------------
 arch/arm/mach-imx/mach-imx27.c | 12 ------------
 arch/arm/mach-imx/mach-imx31.c |  1 -
 arch/arm/mach-imx/mach-imx35.c |  1 -
 arch/arm/mach-imx/mm-imx3.c    | 24 ------------------------
 8 files changed, 15 insertions(+), 63 deletions(-)

diff --git a/arch/arm/mach-imx/avic.c b/arch/arm/mach-imx/avic.c
index 322caa21bcb3..e67e1c2799d1 100644
--- a/arch/arm/mach-imx/avic.c
+++ b/arch/arm/mach-imx/avic.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/irqchip.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -162,7 +163,7 @@ static void __exception_irq_entry avic_handle_irq(struct pt_regs *regs)
  * interrupts. It registers the interrupt enable and disable functions
  * to the kernel for each interrupt source.
  */
-void __init mxc_init_irq(void __iomem *irqbase)
+static void __init mxc_init_irq(void __iomem *irqbase)
 {
 	struct device_node *np;
 	int irq_base;
@@ -220,3 +221,16 @@ void __init mxc_init_irq(void __iomem *irqbase)
 
 	printk(KERN_INFO "MXC IRQ initialized\n");
 }
+
+static int __init imx_avic_init(struct device_node *node,
+			       struct device_node *parent)
+{
+	void __iomem *avic_base;
+
+	avic_base = of_iomap(node, 0);
+	BUG_ON(!avic_base);
+	mxc_init_irq(avic_base);
+	return 0;
+}
+
+IRQCHIP_DECLARE(imx_avic, "fsl,imx31-avic", imx_avic_init);
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 2d76e2c6c99e..e988b0978a42 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -22,7 +22,6 @@ void mx35_map_io(void);
 void imx21_init_early(void);
 void imx31_init_early(void);
 void imx35_init_early(void);
-void mxc_init_irq(void __iomem *);
 void mx31_init_irq(void);
 void mx35_init_irq(void);
 void mxc_set_cpu_type(unsigned int type);
diff --git a/arch/arm/mach-imx/mach-imx1.c b/arch/arm/mach-imx/mach-imx1.c
index 32df3b8012f9..8eca92d66a2e 100644
--- a/arch/arm/mach-imx/mach-imx1.c
+++ b/arch/arm/mach-imx/mach-imx1.c
@@ -17,16 +17,6 @@ static void __init imx1_init_early(void)
 	mxc_set_cpu_type(MXC_CPU_MX1);
 }
 
-static void __init imx1_init_irq(void)
-{
-	void __iomem *avic_addr;
-
-	avic_addr = ioremap(MX1_AVIC_ADDR, SZ_4K);
-	WARN_ON(!avic_addr);
-
-	mxc_init_irq(avic_addr);
-}
-
 static const char * const imx1_dt_board_compat[] __initconst = {
 	"fsl,imx1",
 	NULL
@@ -34,7 +24,6 @@ static const char * const imx1_dt_board_compat[] __initconst = {
 
 DT_MACHINE_START(IMX1_DT, "Freescale i.MX1 (Device Tree Support)")
 	.init_early	= imx1_init_early,
-	.init_irq	= imx1_init_irq,
 	.dt_compat	= imx1_dt_board_compat,
 	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx25.c b/arch/arm/mach-imx/mach-imx25.c
index 95de48a1aa7d..51927bd08aef 100644
--- a/arch/arm/mach-imx/mach-imx25.c
+++ b/arch/arm/mach-imx/mach-imx25.c
@@ -22,17 +22,6 @@ static void __init imx25_dt_init(void)
 	imx_aips_allow_unprivileged_access("fsl,imx25-aips");
 }
 
-static void __init mx25_init_irq(void)
-{
-	struct device_node *np;
-	void __iomem *avic_base;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,avic");
-	avic_base = of_iomap(np, 0);
-	BUG_ON(!avic_base);
-	mxc_init_irq(avic_base);
-}
-
 static const char * const imx25_dt_board_compat[] __initconst = {
 	"fsl,imx25",
 	NULL
@@ -42,6 +31,5 @@ DT_MACHINE_START(IMX25_DT, "Freescale i.MX25 (Device Tree Support)")
 	.init_early	= imx25_init_early,
 	.init_machine	= imx25_dt_init,
 	.init_late      = imx25_pm_init,
-	.init_irq	= mx25_init_irq,
 	.dt_compat	= imx25_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx27.c b/arch/arm/mach-imx/mach-imx27.c
index 262422a9c196..e325c9468105 100644
--- a/arch/arm/mach-imx/mach-imx27.c
+++ b/arch/arm/mach-imx/mach-imx27.c
@@ -56,17 +56,6 @@ static void __init imx27_init_early(void)
 	mxc_set_cpu_type(MXC_CPU_MX27);
 }
 
-static void __init mx27_init_irq(void)
-{
-	void __iomem *avic_base;
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,avic");
-	avic_base = of_iomap(np, 0);
-	BUG_ON(!avic_base);
-	mxc_init_irq(avic_base);
-}
-
 static const char * const imx27_dt_board_compat[] __initconst = {
 	"fsl,imx27",
 	NULL
@@ -75,7 +64,6 @@ static const char * const imx27_dt_board_compat[] __initconst = {
 DT_MACHINE_START(IMX27_DT, "Freescale i.MX27 (Device Tree Support)")
 	.map_io		= mx27_map_io,
 	.init_early	= imx27_init_early,
-	.init_irq	= mx27_init_irq,
 	.init_late	= imx27_pm_init,
 	.dt_compat	= imx27_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx31.c b/arch/arm/mach-imx/mach-imx31.c
index dc69dfe600df..e9a1092b6093 100644
--- a/arch/arm/mach-imx/mach-imx31.c
+++ b/arch/arm/mach-imx/mach-imx31.c
@@ -14,6 +14,5 @@ static const char * const imx31_dt_board_compat[] __initconst = {
 DT_MACHINE_START(IMX31_DT, "Freescale i.MX31 (Device Tree Support)")
 	.map_io		= mx31_map_io,
 	.init_early	= imx31_init_early,
-	.init_irq	= mx31_init_irq,
 	.dt_compat	= imx31_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx35.c b/arch/arm/mach-imx/mach-imx35.c
index ec5c3068715c..0fc08218b77d 100644
--- a/arch/arm/mach-imx/mach-imx35.c
+++ b/arch/arm/mach-imx/mach-imx35.c
@@ -27,6 +27,5 @@ DT_MACHINE_START(IMX35_DT, "Freescale i.MX35 (Device Tree Support)")
 	.l2c_aux_mask	= ~0,
 	.map_io		= mx35_map_io,
 	.init_early	= imx35_init_early,
-	.init_irq	= mx35_init_irq,
 	.dt_compat	= imx35_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 5056438e5b42..28db97289ee8 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -109,18 +109,6 @@ void __init imx31_init_early(void)
 	mx3_ccm_base = of_iomap(np, 0);
 	BUG_ON(!mx3_ccm_base);
 }
-
-void __init mx31_init_irq(void)
-{
-	void __iomem *avic_base;
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx31-avic");
-	avic_base = of_iomap(np, 0);
-	BUG_ON(!avic_base);
-
-	mxc_init_irq(avic_base);
-}
 #endif /* ifdef CONFIG_SOC_IMX31 */
 
 #ifdef CONFIG_SOC_IMX35
@@ -158,16 +146,4 @@ void __init imx35_init_early(void)
 	mx3_ccm_base = of_iomap(np, 0);
 	BUG_ON(!mx3_ccm_base);
 }
-
-void __init mx35_init_irq(void)
-{
-	void __iomem *avic_base;
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx35-avic");
-	avic_base = of_iomap(np, 0);
-	BUG_ON(!avic_base);
-
-	mxc_init_irq(avic_base);
-}
 #endif /* ifdef CONFIG_SOC_IMX35 */
-- 
2.30.0.365.g02bc693789-goog

