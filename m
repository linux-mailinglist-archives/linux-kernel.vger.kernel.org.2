Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B239239CF1C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhFFMqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:46:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35034 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhFFMpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:40 -0400
Date:   Sun, 06 Jun 2021 12:43:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983430;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZiioGdbIEAlO2+h+w87TR8HN5HTO1nedt0DdsnchgmA=;
        b=lIRZyTjGaf2KhITK8UceEmaY2xvzqvJySr5c5/uYiuH1NRZ3ZanhdUJQfy/69PTfb5vLpA
        4q+b9/dF4Njiu3nE/3LmjjV2dS0zENBWoc+S2IzsI6a32g9n/u+w3owoVI/5Lyrf+N5+lp
        0fII8o2vrYAKPGOj2Sm6vDIpdqIEtMV0KNWVz7VlkSmM73bjQ1lVvOpdpJqFHCQPWOC+bo
        VQM6UZFHPlph1maJxz2qS/ae5bFGrzxcPWptjkYfqA0j+UEAdEthQUy03VDrwlPnBGrRVN
        9wg/4Qc7H4bUE5OVAGsb14UZItwc6UcpnlZAYyF5PYI7apZ7q7UQZ9Or3Ft3zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983430;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZiioGdbIEAlO2+h+w87TR8HN5HTO1nedt0DdsnchgmA=;
        b=ptH+nep8rclYbknEaNF4Dqj96Bk5nQfnrAnHWnhcms6RxD/BnBLXKUwnFbbQiKO9cLDC9o
        4VPXN0oPNnfslXBg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] powerpc: Move the use of
 irq_domain_add_nomap() behind a config option
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298342994.29796.9039891064935904143.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     4f9dcc2f17b7e3a522e028f75ccc3ce73c843dd5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/4f9dcc2f17b7e3a522e028f75ccc3ce73c843dd5
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 04 Apr 2021 13:06:39 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 14:34:48 +01:00

powerpc: Move the use of irq_domain_add_nomap() behind a config option

Only a handful of old PPC systems are still using the old 'nomap'
variant of the irqdomain library. Move the associated definitions
behind a configuration option, which will allow us to make some
more radical changes.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/powerpc/platforms/cell/Kconfig     | 1 +
 arch/powerpc/platforms/powermac/Kconfig | 1 +
 arch/powerpc/platforms/ps3/Kconfig      | 1 +
 arch/powerpc/sysdev/xive/Kconfig        | 1 +
 include/linux/irqdomain.h               | 8 ++++++--
 kernel/irq/Kconfig                      | 5 +++++
 kernel/irq/irqdomain.c                  | 2 ++
 7 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index e7c976b..cb70c5f 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -35,6 +35,7 @@ config PPC_IBM_CELL_BLADE
 config AXON_MSI
 	bool
 	depends on PPC_IBM_CELL_BLADE && PCI_MSI
+	select IRQ_DOMAIN_NOMAP
 	default y
 
 menu "Cell Broadband Engine options"
diff --git a/arch/powerpc/platforms/powermac/Kconfig b/arch/powerpc/platforms/powermac/Kconfig
index c02d8c5..b97bf12 100644
--- a/arch/powerpc/platforms/powermac/Kconfig
+++ b/arch/powerpc/platforms/powermac/Kconfig
@@ -24,6 +24,7 @@ config PPC_PMAC32_PSURGE
 	bool "Support for powersurge upgrade cards" if EXPERT
 	depends on SMP && PPC32 && PPC_PMAC
 	select PPC_SMP_MUXED_IPI
+	select IRQ_DOMAIN_NOMAP
 	default y
 	help
 	  The powersurge cpu boards can be used in the generation
diff --git a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms/ps3/Kconfig
index e32406e..4d0535c 100644
--- a/arch/powerpc/platforms/ps3/Kconfig
+++ b/arch/powerpc/platforms/ps3/Kconfig
@@ -7,6 +7,7 @@ config PPC_PS3
 	select USB_OHCI_BIG_ENDIAN_MMIO
 	select USB_EHCI_BIG_ENDIAN_MMIO
 	select HAVE_PCI
+	select IRQ_DOMAIN_NOMAP
 	help
 	  This option enables support for the Sony PS3 game console
 	  and other platforms using the PS3 hypervisor.  Enabling this
diff --git a/arch/powerpc/sysdev/xive/Kconfig b/arch/powerpc/sysdev/xive/Kconfig
index 785c292..97796c6 100644
--- a/arch/powerpc/sysdev/xive/Kconfig
+++ b/arch/powerpc/sysdev/xive/Kconfig
@@ -3,6 +3,7 @@ config PPC_XIVE
 	bool
 	select PPC_SMP_MUXED_IPI
 	select HARDIRQS_SW_RESEND
+	select IRQ_DOMAIN_NOMAP
 
 config PPC_XIVE_NATIVE
 	bool
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 42b3f7d..723495e 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -345,6 +345,8 @@ static inline struct irq_domain *irq_domain_add_linear(struct device_node *of_no
 {
 	return __irq_domain_add(of_node_to_fwnode(of_node), size, size, 0, ops, host_data);
 }
+
+#ifdef CONFIG_IRQ_DOMAIN_NOMAP
 static inline struct irq_domain *irq_domain_add_nomap(struct device_node *of_node,
 					 unsigned int max_irq,
 					 const struct irq_domain_ops *ops,
@@ -352,6 +354,10 @@ static inline struct irq_domain *irq_domain_add_nomap(struct device_node *of_nod
 {
 	return __irq_domain_add(of_node_to_fwnode(of_node), 0, max_irq, max_irq, ops, host_data);
 }
+
+extern unsigned int irq_create_direct_mapping(struct irq_domain *host);
+#endif
+
 static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
@@ -408,8 +414,6 @@ static inline unsigned int irq_linear_revmap(struct irq_domain *domain,
 	return irq_find_mapping(domain, hwirq);
 }
 
-extern unsigned int irq_create_direct_mapping(struct irq_domain *host);
-
 extern const struct irq_domain_ops irq_domain_simple_ops;
 
 /* stock xlate functions */
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index d79ef24..fbc54c2 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -70,6 +70,11 @@ config IRQ_DOMAIN_HIERARCHY
 	bool
 	select IRQ_DOMAIN
 
+# Support for obsolete non-mapping irq domains
+config IRQ_DOMAIN_NOMAP
+	bool
+	select IRQ_DOMAIN
+
 # Support for hierarchical fasteoi+edge and fasteoi+level handlers
 config IRQ_FASTEOI_HIERARCHY_HANDLERS
 	bool
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8bd0122..e0143e6 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -604,6 +604,7 @@ void irq_domain_associate_many(struct irq_domain *domain, unsigned int irq_base,
 }
 EXPORT_SYMBOL_GPL(irq_domain_associate_many);
 
+#ifdef CONFIG_IRQ_DOMAIN_NOMAP
 /**
  * irq_create_direct_mapping() - Allocate an irq for direct mapping
  * @domain: domain to allocate the irq for or NULL for default domain
@@ -644,6 +645,7 @@ unsigned int irq_create_direct_mapping(struct irq_domain *domain)
 	return virq;
 }
 EXPORT_SYMBOL_GPL(irq_create_direct_mapping);
+#endif
 
 /**
  * irq_create_mapping_affinity() - Map a hardware interrupt into linux irq space
