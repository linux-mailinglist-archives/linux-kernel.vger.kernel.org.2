Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4CA38B4C8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhETRAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237753AbhETQ7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:59:14 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E955861363;
        Thu, 20 May 2021 16:57:52 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ljlgo-002d7b-Nt; Thu, 20 May 2021 17:38:26 +0100
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
Subject: [PATCH 26/39] genirq: Move non-irqdomain handle_domain_irq() handling into ARM's handle_IRQ()
Date:   Thu, 20 May 2021 17:37:38 +0100
Message-Id: <20210520163751.27325-27-maz@kernel.org>
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

Despite the name, handle_domain_irq() deals with non-irqdomain
handling for the sake of a handful of legacy ARM platforms.

Move such handling into ARM's handle_IRQ(), allowing for better
code generation for everyone else. This allows us get rid of
some complexity, and to rearrange the guards on the various helpers
in a more logical way.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/kernel/irq.c   | 22 +++++++++++++++++++++-
 include/linux/irqdesc.h | 14 ++++----------
 kernel/irq/irqdesc.c    | 30 ++++++++----------------------
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 698b6f636156..20ab1e607522 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -63,7 +63,27 @@ int arch_show_interrupts(struct seq_file *p, int prec)
  */
 void handle_IRQ(unsigned int irq, struct pt_regs *regs)
 {
-	__handle_domain_irq(NULL, irq, false, regs);
+	struct pt_regs *old_regs = set_irq_regs(regs);
+	struct irq_desc *desc;
+
+	irq_enter();
+
+	/*
+	 * Some hardware gives randomly wrong interrupts.  Rather
+	 * than crashing, do something sensible.
+	 */
+	if (unlikely(!irq || irq >= nr_irqs))
+		desc = NULL;
+	else
+		desc = irq_to_desc(irq);
+
+	if (likely(desc))
+		handle_irq_desc(desc);
+	else
+		ack_bad_irq(irq);
+
+	irq_exit();
+	set_irq_regs(old_regs);
 }
 
 /*
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 0f226c6b0c70..59aea39785bf 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -161,24 +161,18 @@ static inline void generic_handle_irq_desc(struct irq_desc *desc)
 int handle_irq_desc(struct irq_desc *desc);
 int generic_handle_irq(unsigned int irq);
 
-#ifdef CONFIG_HANDLE_DOMAIN_IRQ
+#ifdef CONFIG_IRQ_DOMAIN
 /*
  * Convert a HW interrupt number to a logical one using a IRQ domain,
  * and handle the result interrupt number. Return -EINVAL if
  * conversion failed.
  */
-int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
-			bool lookup, struct pt_regs *regs);
-
 int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq);
 
-static inline int handle_domain_irq(struct irq_domain *domain,
-				    unsigned int hwirq, struct pt_regs *regs)
-{
-	return __handle_domain_irq(domain, hwirq, true, regs);
-}
+#ifdef CONFIG_HANDLE_DOMAIN_IRQ
+int handle_domain_irq(struct irq_domain *domain,
+		      unsigned int hwirq, struct pt_regs *regs);
 
-#ifdef CONFIG_IRQ_DOMAIN
 int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
 		      struct pt_regs *regs);
 #endif
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 6179d5bde88e..f4dd5186858a 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -659,7 +659,7 @@ int generic_handle_irq(unsigned int irq)
 }
 EXPORT_SYMBOL_GPL(generic_handle_irq);
 
-#ifdef CONFIG_HANDLE_DOMAIN_IRQ
+#ifdef CONFIG_IRQ_DOMAIN
 /**
  * generic_handle_domain_irq - Invoke the handler for a HW irq belonging
  *                             to a domain, usually for a non-root interrupt
@@ -676,9 +676,10 @@ int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq)
 }
 EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
 
+#ifdef CONFIG_HANDLE_DOMAIN_IRQ
 /**
- * __handle_domain_irq - Invoke the handler for a HW irq belonging to a domain,
- *                       usually for a root interrupt controller
+ * handle_domain_irq - Invoke the handler for a HW irq belonging to a domain,
+ *                     usually for a root interrupt controller
  * @domain:	The domain where to perform the lookup
  * @hwirq:	The HW irq number to convert to a logical one
  * @lookup:	Whether to perform the domain lookup or not
@@ -686,8 +687,8 @@ EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
  *
  * Returns:	0 on success, or -EINVAL if conversion has failed
  */
-int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
-			bool lookup, struct pt_regs *regs)
+int handle_domain_irq(struct irq_domain *domain,
+		      unsigned int hwirq, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	struct irq_desc *desc;
@@ -695,22 +696,8 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
 
 	irq_enter();
 
-	if (likely(IS_ENABLED(CONFIG_IRQ_DOMAIN) && lookup)) {
-		/* The irqdomain code provides boundary checks */
-		desc = irq_resolve_mapping(domain, hwirq);
-	} else {
-		/*
-		 * Some hardware gives randomly wrong interrupts.  Rather
-		 * than crashing, do something sensible.
-		 */
-		if (unlikely(!hwirq || hwirq >= nr_irqs)) {
-			ack_bad_irq(hwirq);
-			desc = NULL;
-		} else {
-			desc = irq_to_desc(hwirq);
-		}
-	}
-
+	/* The irqdomain code provides boundary checks */
+	desc = irq_resolve_mapping(domain, hwirq);
 	if (likely(desc))
 		handle_irq_desc(desc);
 	else
@@ -721,7 +708,6 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
 	return ret;
 }
 
-#ifdef CONFIG_IRQ_DOMAIN
 /**
  * handle_domain_nmi - Invoke the handler for a HW irq belonging to a domain
  * @domain:	The domain where to perform the lookup
-- 
2.30.2

