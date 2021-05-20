Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD97138B4BE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhETQ7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:59:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234205AbhETQ6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:58:52 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2682613AD;
        Thu, 20 May 2021 16:57:30 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ljlgh-002d7b-Vb; Thu, 20 May 2021 17:38:20 +0100
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
Subject: [PATCH 21/39] irqdomain: Introduce irq_resolve_mapping()
Date:   Thu, 20 May 2021 17:37:33 +0100
Message-Id: <20210520163751.27325-22-maz@kernel.org>
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

Rework irq_find_mapping() to return an irq_desc pointer, and
rename the result to irq_resolve_mapping().

irq_find_mapping() is then rewritten in terms of ir_resolve_mapping().

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdomain.h | 18 +++++++++++++++---
 kernel/irq/irqdomain.c    | 22 ++++++++++++++--------
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 2b696c9bcaaf..189f559fb26c 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -31,7 +31,8 @@
 #define _LINUX_IRQDOMAIN_H
 
 #include <linux/types.h>
-#include <linux/irqhandler.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
 #include <linux/of.h>
 #include <linux/mutex.h>
 #include <linux/radix-tree.h>
@@ -401,13 +402,24 @@ static inline unsigned int irq_create_mapping(struct irq_domain *host,
 	return irq_create_mapping_affinity(host, hwirq, NULL);
 }
 
+extern struct irq_desc *irq_resolve_mapping(struct irq_domain *domain,
+					    irq_hw_number_t hwirq);
+
 /**
  * irq_find_mapping() - Find a linux irq from a hw irq number.
  * @domain: domain owning this hardware interrupt
  * @hwirq: hardware irq number in that domain space
  */
-extern unsigned int irq_find_mapping(struct irq_domain *host,
-				     irq_hw_number_t hwirq);
+static inline unsigned int irq_find_mapping(struct irq_domain *domain,
+					    irq_hw_number_t hwirq)
+{
+	struct irq_desc *desc = irq_resolve_mapping(domain, hwirq);
+
+	if (unlikely(!desc))
+		return 0;
+
+	return irq_desc_get_irq(desc);
+}
 
 static inline unsigned int irq_linear_revmap(struct irq_domain *domain,
 					     irq_hw_number_t hwirq)
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8e55bb8c3073..13a3021e9370 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -876,29 +876,32 @@ void irq_dispose_mapping(unsigned int virq)
 EXPORT_SYMBOL_GPL(irq_dispose_mapping);
 
 /**
- * irq_find_mapping() - Find a linux irq from a hw irq number.
+ * irq_resolve_mapping() - Find a linux irq from a hw irq number.
  * @domain: domain owning this hardware interrupt
  * @hwirq: hardware irq number in that domain space
+ *
+ * Returns the interrupt descriptor.
  */
-unsigned int irq_find_mapping(struct irq_domain *domain,
-			      irq_hw_number_t hwirq)
+struct irq_desc *irq_resolve_mapping(struct irq_domain *domain,
+				     irq_hw_number_t hwirq)
 {
+	struct irq_desc *desc = NULL;
 	struct irq_data *data;
 
 	/* Look for default domain if necessary */
 	if (domain == NULL)
 		domain = irq_default_domain;
 	if (domain == NULL)
-		return 0;
+		return desc;
 
 	if (irq_domain_is_nomap(domain)) {
 		if (hwirq < domain->revmap_size) {
 			data = irq_domain_get_irq_data(domain, hwirq);
 			if (data && data->hwirq == hwirq)
-				return hwirq;
+				desc = irq_data_to_desc(data);
 		}
 
-		return 0;
+		return desc;
 	}
 
 	rcu_read_lock();
@@ -907,10 +910,13 @@ unsigned int irq_find_mapping(struct irq_domain *domain,
 		data = rcu_dereference(domain->revmap[hwirq]);
 	else
 		data = radix_tree_lookup(&domain->revmap_tree, hwirq);
+
+	if (likely(data))
+		desc = irq_data_to_desc(data);
 	rcu_read_unlock();
-	return data ? data->irq : 0;
+	return desc;
 }
-EXPORT_SYMBOL_GPL(irq_find_mapping);
+EXPORT_SYMBOL_GPL(irq_resolve_mapping);
 
 /**
  * irq_domain_xlate_onecell() - Generic xlate for direct one cell bindings
-- 
2.30.2

