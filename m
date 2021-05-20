Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D71538B4C3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbhETRAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:00:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234406AbhETQ67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:58:59 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91766613C1;
        Thu, 20 May 2021 16:57:36 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ljlgn-002d7b-6l; Thu, 20 May 2021 17:38:25 +0100
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
Subject: [PATCH 25/39] genirq: Add generic_handle_domain_irq() helper
Date:   Thu, 20 May 2021 17:37:37 +0100
Message-Id: <20210520163751.27325-26-maz@kernel.org>
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

Provide generic_handle_domain_irq() as a pendent to handle_domain_irq()
for non-root interrupt controllers

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdesc.h |  2 ++
 kernel/irq/irqdesc.c    | 19 ++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 2971eb7e65f1..0f226c6b0c70 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -170,6 +170,8 @@ int generic_handle_irq(unsigned int irq);
 int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
 			bool lookup, struct pt_regs *regs);
 
+int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq);
+
 static inline int handle_domain_irq(struct irq_domain *domain,
 				    unsigned int hwirq, struct pt_regs *regs)
 {
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 684c5b7b7832..6179d5bde88e 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -661,7 +661,24 @@ EXPORT_SYMBOL_GPL(generic_handle_irq);
 
 #ifdef CONFIG_HANDLE_DOMAIN_IRQ
 /**
- * __handle_domain_irq - Invoke the handler for a HW irq belonging to a domain
+ * generic_handle_domain_irq - Invoke the handler for a HW irq belonging
+ *                             to a domain, usually for a non-root interrupt
+ *                             controller
+ * @domain:	The domain where to perform the lookup
+ * @hwirq:	The HW irq number to convert to a logical one
+ *
+ * Returns:	0 on success, or -EINVAL if conversion has failed
+ *
+ */
+int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq)
+{
+	return handle_irq_desc(irq_resolve_mapping(domain, hwirq));
+}
+EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
+
+/**
+ * __handle_domain_irq - Invoke the handler for a HW irq belonging to a domain,
+ *                       usually for a root interrupt controller
  * @domain:	The domain where to perform the lookup
  * @hwirq:	The HW irq number to convert to a logical one
  * @lookup:	Whether to perform the domain lookup or not
-- 
2.30.2

