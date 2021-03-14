Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F03833A57D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 16:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbhCNPlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 11:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbhCNPk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 11:40:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383FBC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 08:40:28 -0700 (PDT)
Date:   Sun, 14 Mar 2021 15:40:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615736426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4srFtfXLVJxduNkmApPu6e5GK7WMk3Q5kUzmAZ3SF8E=;
        b=szVWNFo0s2KLZdmdyEV+W7+N47vp+X7z7dJ7lTdXCe7/40h7z6cbO9PRustJf/h4YbAd/C
        dUY+ZF4CgiSgKvGASWxKH3KN1nFWk+KENibBGuAxmxWcDXDZ+I85n2ptNa0nzAA+qcAaZQ
        p6b5Zqyz2j+V77D/3IisG3hIA/jJPSy06BlGeJ++9uytNlfo3sA1a2azLB6iGBckCMLYOL
        C9e0JoPBGRIlKhXRbkqecjc0z4ZwaHIGQ1s3pNs+ixN+EY1ktIcVrw/f09VisnYt5HIoIN
        krvbRXtCIpN6PiOwS3IRC3WZjaYGGvGD+D6FjTumA1t7DWI7bj/ZTFXxQL7FsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615736426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4srFtfXLVJxduNkmApPu6e5GK7WMk3Q5kUzmAZ3SF8E=;
        b=HzRxnCfp+OfSiVUp6hjULKcq9F7Hh6irV7v71bNhj6mkx+/rNsYXEPmJ7vMIZXgeurJidp
        vNwqV0k0W8DgWAAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v5.12-rc2
References: <161573639668.27979.17827928369874291298.tglx@nanos>
Message-ID: <161573640150.27979.5672484140896063253.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-03-14

up to:  b470ebc9e0e5: Merge tag 'irqchip-fixes-5.12-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent


A set of irqchip updates:

  - Make the GENERIC_IRQ_MULTI_HANDLER configuration correct

  - Add a missing DT compatible string fir tge Ingenic driver

  - Remove the pointless debugfs_file pointer from struct irqdomain

Thanks,

	tglx

------------------>
Greg Kroah-Hartman (1):
      irqdomain: Remove debugfs_file from struct irq_domain

Marc Zyngier (2):
      ARM: ep93xx: Select GENERIC_IRQ_MULTI_HANDLER directly
      irqchip: Do not blindly select CONFIG_GENERIC_IRQ_MULTI_HANDLER

Paul Cercueil (2):
      dt-bindings/irq: Add compatible string for the JZ4760B
      irqchip/ingenic: Add support for the JZ4760


 .../devicetree/bindings/interrupt-controller/ingenic,intc.yaml   | 1 +
 arch/arm/Kconfig                                                 | 1 +
 drivers/irqchip/Kconfig                                          | 9 ---------
 drivers/irqchip/irq-ingenic-tcu.c                                | 1 +
 drivers/irqchip/irq-ingenic.c                                    | 1 +
 include/linux/irqdomain.h                                        | 4 ----
 kernel/irq/irqdomain.c                                           | 9 ++++-----
 7 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.yaml
index 0a046be8d1cd..0358a7739c8e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.yaml
@@ -23,6 +23,7 @@ properties:
           - enum:
               - ingenic,jz4775-intc
               - ingenic,jz4770-intc
+              - ingenic,jz4760b-intc
           - const: ingenic,jz4760-intc
       - items:
           - const: ingenic,x1000-intc
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 853aab5ab327..5da96f5df48f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -348,6 +348,7 @@ config ARCH_EP93XX
 	select ARM_AMBA
 	imply ARM_PATCH_PHYS_VIRT
 	select ARM_VIC
+	select GENERIC_IRQ_MULTI_HANDLER
 	select AUTO_ZRELADDR
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e74fa206240a..15536e321df5 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -8,7 +8,6 @@ config IRQCHIP
 config ARM_GIC
 	bool
 	select IRQ_DOMAIN_HIERARCHY
-	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 
 config ARM_GIC_PM
@@ -33,7 +32,6 @@ config GIC_NON_BANKED
 
 config ARM_GIC_V3
 	bool
-	select GENERIC_IRQ_MULTI_HANDLER
 	select IRQ_DOMAIN_HIERARCHY
 	select PARTITION_PERCPU
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
@@ -64,7 +62,6 @@ config ARM_NVIC
 config ARM_VIC
 	bool
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_MULTI_HANDLER
 
 config ARM_VIC_NR
 	int
@@ -99,14 +96,12 @@ config ATMEL_AIC_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 
 config ATMEL_AIC5_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 
 config I8259
@@ -153,7 +148,6 @@ config DW_APB_ICTL
 config FARADAY_FTINTC010
 	bool
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 
 config HISILICON_IRQ_MBIGEN
@@ -169,7 +163,6 @@ config IMGPDC_IRQ
 config IXP4XX_IRQ
 	bool
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 
 config MADERA_IRQ
@@ -186,7 +179,6 @@ config CLPS711X_IRQCHIP
 	bool
 	depends on ARCH_CLPS711X
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_MULTI_HANDLER
 	select SPARSE_IRQ
 	default y
 
@@ -205,7 +197,6 @@ config OMAP_IRQCHIP
 config ORION_IRQCHIP
 	bool
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_MULTI_HANDLER
 
 config PIC32_EVIC
 	bool
diff --git a/drivers/irqchip/irq-ingenic-tcu.c b/drivers/irqchip/irq-ingenic-tcu.c
index 7a7222d4c19c..b938d1d04d96 100644
--- a/drivers/irqchip/irq-ingenic-tcu.c
+++ b/drivers/irqchip/irq-ingenic-tcu.c
@@ -179,5 +179,6 @@ static int __init ingenic_tcu_irq_init(struct device_node *np,
 }
 IRQCHIP_DECLARE(jz4740_tcu_irq, "ingenic,jz4740-tcu", ingenic_tcu_irq_init);
 IRQCHIP_DECLARE(jz4725b_tcu_irq, "ingenic,jz4725b-tcu", ingenic_tcu_irq_init);
+IRQCHIP_DECLARE(jz4760_tcu_irq, "ingenic,jz4760-tcu", ingenic_tcu_irq_init);
 IRQCHIP_DECLARE(jz4770_tcu_irq, "ingenic,jz4770-tcu", ingenic_tcu_irq_init);
 IRQCHIP_DECLARE(x1000_tcu_irq, "ingenic,x1000-tcu", ingenic_tcu_irq_init);
diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index b61a8901ef72..ea36bb00be80 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -155,6 +155,7 @@ static int __init intc_2chip_of_init(struct device_node *node,
 {
 	return ingenic_intc_of_init(node, 2);
 }
+IRQCHIP_DECLARE(jz4760_intc, "ingenic,jz4760-intc", intc_2chip_of_init);
 IRQCHIP_DECLARE(jz4770_intc, "ingenic,jz4770-intc", intc_2chip_of_init);
 IRQCHIP_DECLARE(jz4775_intc, "ingenic,jz4775-intc", intc_2chip_of_init);
 IRQCHIP_DECLARE(jz4780_intc, "ingenic,jz4780-intc", intc_2chip_of_init);
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 42d196805f58..33cacc8af26d 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -150,7 +150,6 @@ struct irq_domain_chip_generic;
  *      setting up one or more generic chips for interrupt controllers
  *      drivers using the generic chip library which uses this pointer.
  * @parent: Pointer to parent irq_domain to support hierarchy irq_domains
- * @debugfs_file: dentry for the domain debugfs file
  *
  * Revmap data, used internally by irq_domain
  * @revmap_direct_max_irq: The largest hwirq that can be set for controllers that
@@ -174,9 +173,6 @@ struct irq_domain {
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	struct irq_domain *parent;
 #endif
-#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
-	struct dentry		*debugfs_file;
-#endif
 
 	/* reverse map data. The linear map gets appended to the irq_domain */
 	irq_hw_number_t hwirq_max;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 288151393a06..d10ab1d689d5 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1898,16 +1898,15 @@ DEFINE_SHOW_ATTRIBUTE(irq_domain_debug);
 
 static void debugfs_add_domain_dir(struct irq_domain *d)
 {
-	if (!d->name || !domain_dir || d->debugfs_file)
+	if (!d->name || !domain_dir)
 		return;
-	d->debugfs_file = debugfs_create_file(d->name, 0444, domain_dir, d,
-					      &irq_domain_debug_fops);
+	debugfs_create_file(d->name, 0444, domain_dir, d,
+			    &irq_domain_debug_fops);
 }
 
 static void debugfs_remove_domain_dir(struct irq_domain *d)
 {
-	debugfs_remove(d->debugfs_file);
-	d->debugfs_file = NULL;
+	debugfs_remove(debugfs_lookup(d->name, domain_dir));
 }
 
 void __init irq_domain_debugfs_init(struct dentry *root)

