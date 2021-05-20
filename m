Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB9038B4B7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhETQ66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:58:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234005AbhETQ6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:58:45 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CE64613B5;
        Thu, 20 May 2021 16:57:23 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ljlgz-002d7b-OB; Thu, 20 May 2021 17:38:37 +0100
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
Subject: [PATCH 35/39] mips: Bulk conversion to generic_handle_domain_irq()
Date:   Thu, 20 May 2021 17:37:47 +0100
Message-Id: <20210520163751.27325-36-maz@kernel.org>
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

Wherever possible, replace constructs that match either
generic_handle_irq(irq_find_mapping()) or
generic_handle_irq(irq_linear_revmap()) to a single call to
generic_handle_domain_irq().

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/mips/ath25/ar2315.c      | 14 +++++++-------
 arch/mips/ath25/ar5312.c      | 13 ++++++-------
 arch/mips/lantiq/irq.c        |  2 +-
 arch/mips/pci/pci-ar2315.c    |  8 +++-----
 arch/mips/pci/pci-rt3883.c    |  5 ++---
 arch/mips/ralink/irq.c        |  2 +-
 arch/mips/sgi-ip27/ip27-irq.c | 16 ++++++----------
 arch/mips/sgi-ip30/ip30-irq.c |  8 +++-----
 8 files changed, 29 insertions(+), 39 deletions(-)

diff --git a/arch/mips/ath25/ar2315.c b/arch/mips/ath25/ar2315.c
index 9dbed7b5ea76..76e43a73ba1b 100644
--- a/arch/mips/ath25/ar2315.c
+++ b/arch/mips/ath25/ar2315.c
@@ -69,24 +69,24 @@ static void ar2315_misc_irq_handler(struct irq_desc *desc)
 {
 	u32 pending = ar2315_rst_reg_read(AR2315_ISR) &
 		      ar2315_rst_reg_read(AR2315_IMR);
-	unsigned nr, misc_irq = 0;
+	unsigned nr;
+	int ret = 0;
 
 	if (pending) {
 		struct irq_domain *domain = irq_desc_get_handler_data(desc);
 
 		nr = __ffs(pending);
-		misc_irq = irq_find_mapping(domain, nr);
-	}
 
-	if (misc_irq) {
 		if (nr == AR2315_MISC_IRQ_GPIO)
 			ar2315_rst_reg_write(AR2315_ISR, AR2315_ISR_GPIO);
 		else if (nr == AR2315_MISC_IRQ_WATCHDOG)
 			ar2315_rst_reg_write(AR2315_ISR, AR2315_ISR_WD);
-		generic_handle_irq(misc_irq);
-	} else {
-		spurious_interrupt();
+
+		ret = generic_handle_domain_irq(domain, nr);
 	}
+
+	if (!pending || ret)
+		spurious_interrupt();
 }
 
 static void ar2315_misc_irq_unmask(struct irq_data *d)
diff --git a/arch/mips/ath25/ar5312.c b/arch/mips/ath25/ar5312.c
index 23c879f4b734..822b639dbd1e 100644
--- a/arch/mips/ath25/ar5312.c
+++ b/arch/mips/ath25/ar5312.c
@@ -73,22 +73,21 @@ static void ar5312_misc_irq_handler(struct irq_desc *desc)
 {
 	u32 pending = ar5312_rst_reg_read(AR5312_ISR) &
 		      ar5312_rst_reg_read(AR5312_IMR);
-	unsigned nr, misc_irq = 0;
+	unsigned nr;
+	int ret = 0;
 
 	if (pending) {
 		struct irq_domain *domain = irq_desc_get_handler_data(desc);
 
 		nr = __ffs(pending);
-		misc_irq = irq_find_mapping(domain, nr);
-	}
 
-	if (misc_irq) {
-		generic_handle_irq(misc_irq);
+		ret = generic_handle_domain_irq(domain, nr);
 		if (nr == AR5312_MISC_IRQ_TIMER)
 			ar5312_rst_reg_read(AR5312_TIMER);
-	} else {
-		spurious_interrupt();
 	}
+
+	if (!pending || ret)
+		spurious_interrupt();
 }
 
 /* Enable the specified AR5312_MISC_IRQ interrupt */
diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index acfbdc01b0ac..b732495f138a 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -300,7 +300,7 @@ static void ltq_hw_irq_handler(struct irq_desc *desc)
 	 */
 	irq = __fls(irq);
 	hwirq = irq + MIPS_CPU_IRQ_CASCADE + (INT_NUM_IM_OFFSET * module);
-	generic_handle_irq(irq_linear_revmap(ltq_domain, hwirq));
+	generic_handle_domain_irq(ltq_domain, hwirq);
 
 	/* if this is a EBU irq, we need to ack it or get a deadlock */
 	if (irq == LTQ_ICU_EBU_IRQ && !module && LTQ_EBU_PCC_ISTAT != 0)
diff --git a/arch/mips/pci/pci-ar2315.c b/arch/mips/pci/pci-ar2315.c
index c1a655aee599..9a4bfb4e63e3 100644
--- a/arch/mips/pci/pci-ar2315.c
+++ b/arch/mips/pci/pci-ar2315.c
@@ -337,14 +337,12 @@ static void ar2315_pci_irq_handler(struct irq_desc *desc)
 	struct ar2315_pci_ctrl *apc = irq_desc_get_handler_data(desc);
 	u32 pending = ar2315_pci_reg_read(apc, AR2315_PCI_ISR) &
 		      ar2315_pci_reg_read(apc, AR2315_PCI_IMR);
-	unsigned pci_irq = 0;
+	int ret = 0;
 
 	if (pending)
-		pci_irq = irq_find_mapping(apc->domain, __ffs(pending));
+		ret = generic_handle_domain_irq(apc->domain, __ffs(pending));
 
-	if (pci_irq)
-		generic_handle_irq(pci_irq);
-	else
+	if (!pending || ret)
 		spurious_interrupt();
 }
 
diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
index c48e23cf5b5e..d3c947fa2969 100644
--- a/arch/mips/pci/pci-rt3883.c
+++ b/arch/mips/pci/pci-rt3883.c
@@ -140,10 +140,9 @@ static void rt3883_pci_irq_handler(struct irq_desc *desc)
 	}
 
 	while (pending) {
-		unsigned irq, bit = __ffs(pending);
+		unsigned bit = __ffs(pending);
 
-		irq = irq_find_mapping(rpc->irq_domain, bit);
-		generic_handle_irq(irq);
+		generic_handle_domain_irq(rpc->irq_domain, bit);
 
 		pending &= ~BIT(bit);
 	}
diff --git a/arch/mips/ralink/irq.c b/arch/mips/ralink/irq.c
index 220ca0cd7945..fa353bc13947 100644
--- a/arch/mips/ralink/irq.c
+++ b/arch/mips/ralink/irq.c
@@ -100,7 +100,7 @@ static void ralink_intc_irq_handler(struct irq_desc *desc)
 
 	if (pending) {
 		struct irq_domain *domain = irq_desc_get_handler_data(desc);
-		generic_handle_irq(irq_find_mapping(domain, __ffs(pending)));
+		generic_handle_domain_irq(domain, __ffs(pending));
 	} else {
 		spurious_interrupt();
 	}
diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index 95c1bff1ab9f..a0dd3bd2b81b 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -190,7 +190,7 @@ static void ip27_do_irq_mask0(struct irq_desc *desc)
 	unsigned long *mask = per_cpu(irq_enable_mask, cpu);
 	struct irq_domain *domain;
 	u64 pend0;
-	int irq;
+	int ret;
 
 	/* copied from Irix intpend0() */
 	pend0 = LOCAL_HUB_L(PI_INT_PEND0);
@@ -216,10 +216,8 @@ static void ip27_do_irq_mask0(struct irq_desc *desc)
 #endif
 	{
 		domain = irq_desc_get_handler_data(desc);
-		irq = irq_linear_revmap(domain, __ffs(pend0));
-		if (irq)
-			generic_handle_irq(irq);
-		else
+		ret = generic_handle_domain_irq(domain, __ffs(pend0));
+		if (ret)
 			spurious_interrupt();
 	}
 
@@ -232,7 +230,7 @@ static void ip27_do_irq_mask1(struct irq_desc *desc)
 	unsigned long *mask = per_cpu(irq_enable_mask, cpu);
 	struct irq_domain *domain;
 	u64 pend1;
-	int irq;
+	int ret;
 
 	/* copied from Irix intpend0() */
 	pend1 = LOCAL_HUB_L(PI_INT_PEND1);
@@ -242,10 +240,8 @@ static void ip27_do_irq_mask1(struct irq_desc *desc)
 		return;
 
 	domain = irq_desc_get_handler_data(desc);
-	irq = irq_linear_revmap(domain, __ffs(pend1) + 64);
-	if (irq)
-		generic_handle_irq(irq);
-	else
+	ret = generic_handle_domain_irq(domain, __ffs(pend1) + 64);
+	if (ret)
 		spurious_interrupt();
 
 	LOCAL_HUB_L(PI_INT_PEND1);
diff --git a/arch/mips/sgi-ip30/ip30-irq.c b/arch/mips/sgi-ip30/ip30-irq.c
index ba87704073c8..423c32cb66ed 100644
--- a/arch/mips/sgi-ip30/ip30-irq.c
+++ b/arch/mips/sgi-ip30/ip30-irq.c
@@ -99,7 +99,7 @@ static void ip30_normal_irq(struct irq_desc *desc)
 	int cpu = smp_processor_id();
 	struct irq_domain *domain;
 	u64 pend, mask;
-	int irq;
+	int ret;
 
 	pend = heart_read(&heart_regs->isr);
 	mask = (heart_read(&heart_regs->imr[cpu]) &
@@ -130,10 +130,8 @@ static void ip30_normal_irq(struct irq_desc *desc)
 #endif
 	{
 		domain = irq_desc_get_handler_data(desc);
-		irq = irq_linear_revmap(domain, __ffs(pend));
-		if (irq)
-			generic_handle_irq(irq);
-		else
+		ret = generic_handle_domain_irq(domain, __ffs(pend));
+		if (ret)
 			spurious_interrupt();
 	}
 }
-- 
2.30.2

