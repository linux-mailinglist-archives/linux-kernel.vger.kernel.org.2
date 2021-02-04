Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9C3310067
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 23:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBDW5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 17:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhBDW5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 17:57:39 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86746C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 14:56:59 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id m1so3488251qvp.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 14:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=1vEFRjhn7R4t0RkskY/TpQOgy28qEgllZsDHAnOCCOk=;
        b=P/1dpZWlCZUA5GXd6C7c6tVxa9B9hMo5PEZmyAKeOJDvWVtAyi6bKOIUNIpBoP8hjc
         OQA5gds7zER6uo9gpUJueeg8sGyUgvw2jg3reN0kCgL1mgTE+ag6JTrcknwQETfKTTdN
         84LgyrMFcAv3z4189UvQ3oD4WmRkz/amZTy0Wv8L8ta0TRKV1TnukMXLXzCIfb4DL7Bl
         PpFRlUMq32ChdsWcv4vCAXOJTKVi/8LI1Dn2/71gtRXt6e+7gCyy/KuedQLL2lELHN5C
         +7YCPrCAMgUinQlMxuAPLOd/I3/9/K1NRhHiMx3gMT+M2kh9mCdzp6/Qp3FVIIU4CJYG
         xMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=1vEFRjhn7R4t0RkskY/TpQOgy28qEgllZsDHAnOCCOk=;
        b=UPYNt5iGpEjnXItdVTAxNz85EBuVFC4lBkvsJavtZ83cc+qTStRlwmCFQG63JrA/ab
         QuZtX9cM2JlpHoKI7frIpej+d2W36jZG5kLvzavvcF2at6e+3fkEkauGzBGDWlAwwURL
         4uqM9WeCGarb7D0H7ztWcAsXMAKSA+bzgnPnNbDzrhVYRGUKLwvsk00RgjJjv+dwvBkM
         I+K1ct1jf+3T97xh+WuMaIPd5CDe41TqBVtP0L6QKvoFLmFFWqQhWTIAv/3yiroe6IWf
         aBUyOx6rMT4BaFQtdZf/q9TJemFzgsUjevYpg6LoEEc/t6P9myVZd06jfrRyKq2cFj0I
         WeDw==
X-Gm-Message-State: AOAM533r86OnqyO6g12beN2X07l7p8vFYqC16PoHZcyrQlkkaX6a90oH
        u78uIeYJGtZwGGtIndprIyagtqtaj0HIjxc=
X-Google-Smtp-Source: ABdhPJwWDezUlKLzaZQN6XNI8HqKkIgzyqWylRgteQVtKEEmMoolZVGAmyFwhqCdYa+Hxlzsmj9JZ4CV/BUMLFc=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:8475:2f1d:e8b4:f65a])
 (user=saravanak job=sendgmr) by 2002:a05:6214:2ee:: with SMTP id
 h14mr1841667qvu.34.1612479418748; Thu, 04 Feb 2021 14:56:58 -0800 (PST)
Date:   Thu,  4 Feb 2021 14:56:51 -0800
Message-Id: <20210204225652.1707066-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2] ARM: imx: avic: Convert to using IRQCHIP_DECLARE
From:   Saravana Kannan <saravanak@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Tested-by: Martin Kaiser <martin@kaiser.cx>
---

v1 -> v2:
- Fixed up the compatible string in IRQCHIP_DECLARE
- Added Tested-by (was tested with the fix above)

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
index 322caa21bcb3..21bce4049cec 100644
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
+IRQCHIP_DECLARE(imx_avic, "fsl,avic", imx_avic_init);
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

