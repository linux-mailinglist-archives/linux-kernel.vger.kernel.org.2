Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAE238B4D1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbhETRBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239446AbhETQ7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:59:25 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5214C61353;
        Thu, 20 May 2021 16:58:04 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ljlgj-002d7b-JH; Thu, 20 May 2021 17:38:21 +0100
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
Subject: [PATCH 22/39] genirq: Use irq_resolve_mapping() to implement __handle_domain_irq() and co
Date:   Thu, 20 May 2021 17:37:34 +0100
Message-Id: <20210520163751.27325-23-maz@kernel.org>
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

In order to start reaping the benefits of irq_resolve_mapping(),
start using it in __handle_domain_irq() and handle_domain_nmi().

This involves splitting generic_handle_irq() to be able to directly
provide the irq_desc.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdesc.h |  1 +
 kernel/irq/irqdesc.c    | 60 ++++++++++++++++++++++++-----------------
 2 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index df4651250785..cdd1cf8207f6 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -158,6 +158,7 @@ static inline void generic_handle_irq_desc(struct irq_desc *desc)
 	desc->handle_irq(desc);
 }
 
+int handle_irq_desc(struct irq_desc *desc);
 int generic_handle_irq(unsigned int irq);
 
 #ifdef CONFIG_HANDLE_DOMAIN_IRQ
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 4a617d7312a4..684c5b7b7832 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -632,14 +632,8 @@ void irq_init_desc(unsigned int irq)
 
 #endif /* !CONFIG_SPARSE_IRQ */
 
-/**
- * generic_handle_irq - Invoke the handler for a particular irq
- * @irq:	The irq number to handle
- *
- */
-int generic_handle_irq(unsigned int irq)
+int handle_irq_desc(struct irq_desc *desc)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
 	struct irq_data *data;
 
 	if (!desc)
@@ -652,6 +646,17 @@ int generic_handle_irq(unsigned int irq)
 	generic_handle_irq_desc(desc);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(handle_irq_desc);
+
+/**
+ * generic_handle_irq - Invoke the handler for a particular irq
+ * @irq:	The irq number to handle
+ *
+ */
+int generic_handle_irq(unsigned int irq)
+{
+	return handle_irq_desc(irq_to_desc(irq));
+}
 EXPORT_SYMBOL_GPL(generic_handle_irq);
 
 #ifdef CONFIG_HANDLE_DOMAIN_IRQ
@@ -668,27 +673,32 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
 			bool lookup, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-	unsigned int irq = hwirq;
+	struct irq_desc *desc;
 	int ret = 0;
 
 	irq_enter();
 
-#ifdef CONFIG_IRQ_DOMAIN
-	if (lookup)
-		irq = irq_find_mapping(domain, hwirq);
-#endif
-
-	/*
-	 * Some hardware gives randomly wrong interrupts.  Rather
-	 * than crashing, do something sensible.
-	 */
-	if (unlikely(!irq || irq >= nr_irqs)) {
-		ack_bad_irq(irq);
-		ret = -EINVAL;
+	if (likely(IS_ENABLED(CONFIG_IRQ_DOMAIN) && lookup)) {
+		/* The irqdomain code provides boundary checks */
+		desc = irq_resolve_mapping(domain, hwirq);
 	} else {
-		generic_handle_irq(irq);
+		/*
+		 * Some hardware gives randomly wrong interrupts.  Rather
+		 * than crashing, do something sensible.
+		 */
+		if (unlikely(!hwirq || hwirq >= nr_irqs)) {
+			ack_bad_irq(hwirq);
+			desc = NULL;
+		} else {
+			desc = irq_to_desc(hwirq);
+		}
 	}
 
+	if (likely(desc))
+		handle_irq_desc(desc);
+	else
+		ret = -EINVAL;
+
 	irq_exit();
 	set_irq_regs(old_regs);
 	return ret;
@@ -709,7 +719,7 @@ int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
 		      struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-	unsigned int irq;
+	struct irq_desc *desc;
 	int ret = 0;
 
 	/*
@@ -717,14 +727,14 @@ int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
 	 */
 	WARN_ON(!in_nmi());
 
-	irq = irq_find_mapping(domain, hwirq);
+	desc = irq_resolve_mapping(domain, hwirq);
 
 	/*
 	 * ack_bad_irq is not NMI-safe, just report
 	 * an invalid interrupt.
 	 */
-	if (likely(irq))
-		generic_handle_irq(irq);
+	if (likely(desc))
+		handle_irq_desc(desc);
 	else
 		ret = -EINVAL;
 
-- 
2.30.2

