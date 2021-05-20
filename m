Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC7138B4CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237998AbhETRAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:00:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238451AbhETQ7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:59:18 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9C1261363;
        Thu, 20 May 2021 16:57:56 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ljlga-002d7b-6F; Thu, 20 May 2021 17:38:12 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kernel-team@android.com
Subject: [PATCH 15/39] powerpc: Move the use of irq_domain_add_nomap() behind a config option
Date:   Thu, 20 May 2021 17:37:27 +0100
Message-Id: <20210520163751.27325-16-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520163751.27325-1-maz@kernel.org>
References: <20210520163751.27325-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, ley.foon.tan@intel.com, chris@zankel.net, jcmvbkbc@gmail.com, vgupta@synopsys.com, tsbogend@alpha.franken.de, robert.jarzmik@free.fr, linux@armlinux.org.uk, krzysztof.kozlowski@canonical.com, ysato@users.sourceforge.jp, dalias@libc.org, geert@linux-m68k.org, alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch, robdclark@gmail.com, linus.walleij@linaro.org, lee.jones@linaro.org, lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com, bgolaszewski@baylibre.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index e7c976bcadff..cb70c5f25bc6 100644
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
index c02d8c503b29..b97bf12801eb 100644
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
index e32406e918d0..4d0535cc7946 100644
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
index 785c292d104b..97796c6b63f0 100644
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
index 42b3f7d03a32..723495ec5a2f 100644
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
index d79ef2493a28..fbc54c2a7f23 100644
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
index 8bd012253989..e0143e640683 100644
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
-- 
2.30.2

