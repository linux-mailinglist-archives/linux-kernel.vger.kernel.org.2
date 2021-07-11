Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B233C3D0F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 15:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbhGKNnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 09:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbhGKNnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 09:43:20 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B06C0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 06:40:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id c17so27719264ejk.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 06:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HhngoEJSkbQEoJJyLEArTQq/2LlVlkBzYrfwiJJ+96A=;
        b=OtIsGU2VKjbh1hj9TV87ULh+UylJ0sxDnPKIRWkNXrY5yucEgKTS2v8rAk7D8H4RRF
         AIPYfamGibFBgp5iFpZGBWz64RgHJsuZLX1jQ62LmUehBbJsexYkW/45EMh8rIrcvFgU
         +rZHGBYVxfWUw5GafR62poyYN0KuZwpHlW3w02lODoC2CxewhKdvlERWVZLDNedw9Vlp
         lRIpGIAfuADOWAgAehPBbAIlhLoYmX6pMN6fX2QkRMbMworA3PZUVNctGFMrYw6rFboP
         hB53Hn4cVNYYphvPDYvQWcMKLDwK/J2MippZ5KOmt0YO7U7teFkMp2E+6H7J0efJ1p3A
         B2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=HhngoEJSkbQEoJJyLEArTQq/2LlVlkBzYrfwiJJ+96A=;
        b=pSK20rOZ0eiFhoYrvObCrs8UF0lUhYbFHP+KRUlZyiO+EzQ6GyjMTPWn+MmmuGBFrX
         DYQsF+jI3Cp4hpxe25f4PsTPkEwnUwnfWxrLohNvjlU50DCUzujqjCq0kxxTykVc+1G5
         phcCpjyYnPxMsKa/w7FZ0mmTFZzRBrY2erTqj6ZU7RiZWMhMpLLYHuRll5NGavrbvfML
         AwOklyQuY2wwBoO37TvRSk+SQDDd9y+WheDkWcrJNrhdLMDzr07LGOQLlz2GkcG6njGS
         QS7ZdHJAk53+PFeQCkG81Odm9pDSJKfUz537UvxCk5A84X8/y5ItGjNC5GZXlUDRrooG
         UZKA==
X-Gm-Message-State: AOAM531uW5QBa9q8VWUy75Hw5n35lWS0dGfDOP9k9Mwmt0/FTTwKHt4j
        gPEJ3k/sbTP6hOszLPBVxyplqkbgC5E=
X-Google-Smtp-Source: ABdhPJw+AQXIqgNKTU14ouku/kcoVDHwinG+mH/tstGQ0tqc3hXPa4/ytZ2GlFIVLThWqdW2jTxthg==
X-Received: by 2002:a17:907:7683:: with SMTP id jv3mr19699525ejc.272.1626010831952;
        Sun, 11 Jul 2021 06:40:31 -0700 (PDT)
Received: from gmail.com (77-234-64-154.pool.digikabel.hu. [77.234.64.154])
        by smtp.gmail.com with ESMTPSA id ze15sm5114146ejb.79.2021.07.11.06.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 06:40:31 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 11 Jul 2021 15:40:29 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] IRQ fixes
Message-ID: <YOr0zV5US6ajbTaM@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest irq/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-07-11

   # HEAD: 48400483565f0b7e633cbef94b139ff295b59de3 Merge tag 'irqchip-fixes-5.14-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Two fixes:

 - Fix a MIPS IRQ handling RCU bug
 - Remove a DocBook annotation for a parameter that doesn't exist anymore

 Thanks,

	Ingo

------------------>
Marc Zyngier (1):
      irqchip/mips: Fix RCU violation when using irqdomain lookup on interrupt entry

Randy Dunlap (1):
      genirq/irqdesc: Drop excess kernel-doc entry @lookup


 arch/mips/include/asm/irq.h      |  3 +++
 arch/mips/kernel/irq.c           | 16 ++++++++++++++++
 drivers/irqchip/irq-mips-cpu.c   | 10 ++++++----
 drivers/irqchip/irq-mips-gic.c   |  8 ++++----
 drivers/irqchip/irq-pic32-evic.c |  5 ++---
 kernel/irq/irqdesc.c             |  1 -
 6 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index d1477ecb1af9..57561e0e6e8d 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -57,6 +57,9 @@ asmlinkage void plat_irq_dispatch(void);
 
 extern void do_IRQ(unsigned int irq);
 
+struct irq_domain;
+extern void do_domain_IRQ(struct irq_domain *domain, unsigned int irq);
+
 extern void arch_init_irq(void);
 extern void spurious_interrupt(void);
 
diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index 85b6c60f285d..d20e002b3246 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -21,6 +21,7 @@
 #include <linux/kallsyms.h>
 #include <linux/kgdb.h>
 #include <linux/ftrace.h>
+#include <linux/irqdomain.h>
 
 #include <linux/atomic.h>
 #include <linux/uaccess.h>
@@ -107,3 +108,18 @@ void __irq_entry do_IRQ(unsigned int irq)
 	irq_exit();
 }
 
+#ifdef CONFIG_IRQ_DOMAIN
+void __irq_entry do_domain_IRQ(struct irq_domain *domain, unsigned int hwirq)
+{
+	struct irq_desc *desc;
+
+	irq_enter();
+	check_stack_overflow();
+
+	desc = irq_resolve_mapping(domain, hwirq);
+	if (likely(desc))
+		handle_irq_desc(desc);
+
+	irq_exit();
+}
+#endif
diff --git a/drivers/irqchip/irq-mips-cpu.c b/drivers/irqchip/irq-mips-cpu.c
index 0bbb0b2d0dd5..0c7ae71a0af0 100644
--- a/drivers/irqchip/irq-mips-cpu.c
+++ b/drivers/irqchip/irq-mips-cpu.c
@@ -127,7 +127,6 @@ static struct irq_chip mips_mt_cpu_irq_controller = {
 asmlinkage void __weak plat_irq_dispatch(void)
 {
 	unsigned long pending = read_c0_cause() & read_c0_status() & ST0_IM;
-	unsigned int virq;
 	int irq;
 
 	if (!pending) {
@@ -137,12 +136,15 @@ asmlinkage void __weak plat_irq_dispatch(void)
 
 	pending >>= CAUSEB_IP;
 	while (pending) {
+		struct irq_domain *d;
+
 		irq = fls(pending) - 1;
 		if (IS_ENABLED(CONFIG_GENERIC_IRQ_IPI) && irq < 2)
-			virq = irq_linear_revmap(ipi_domain, irq);
+			d = ipi_domain;
 		else
-			virq = irq_linear_revmap(irq_domain, irq);
-		do_IRQ(virq);
+			d = irq_domain;
+
+		do_domain_IRQ(d, irq);
 		pending &= ~BIT(irq);
 	}
 }
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index b146e069bf5b..54c7092cc61d 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -169,8 +169,8 @@ static void gic_handle_shared_int(bool chained)
 			generic_handle_domain_irq(gic_irq_domain,
 						  GIC_SHARED_TO_HWIRQ(intr));
 		else
-			do_IRQ(irq_find_mapping(gic_irq_domain,
-						GIC_SHARED_TO_HWIRQ(intr)));
+			do_domain_IRQ(gic_irq_domain,
+				      GIC_SHARED_TO_HWIRQ(intr));
 	}
 }
 
@@ -320,8 +320,8 @@ static void gic_handle_local_int(bool chained)
 			generic_handle_domain_irq(gic_irq_domain,
 						  GIC_LOCAL_TO_HWIRQ(intr));
 		else
-			do_IRQ(irq_find_mapping(gic_irq_domain,
-						GIC_LOCAL_TO_HWIRQ(intr)));
+			do_domain_IRQ(gic_irq_domain,
+				      GIC_LOCAL_TO_HWIRQ(intr));
 	}
 }
 
diff --git a/drivers/irqchip/irq-pic32-evic.c b/drivers/irqchip/irq-pic32-evic.c
index 34c4b4ffacd1..1d9bb28d13e5 100644
--- a/drivers/irqchip/irq-pic32-evic.c
+++ b/drivers/irqchip/irq-pic32-evic.c
@@ -42,11 +42,10 @@ static void __iomem *evic_base;
 
 asmlinkage void __weak plat_irq_dispatch(void)
 {
-	unsigned int irq, hwirq;
+	unsigned int hwirq;
 
 	hwirq = readl(evic_base + REG_INTSTAT) & 0xFF;
-	irq = irq_linear_revmap(evic_irq_domain, hwirq);
-	do_IRQ(irq);
+	do_domain_IRQ(evic_irq_domain, hwirq);
 }
 
 static struct evic_chip_data *irqd_to_priv(struct irq_data *data)
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index f4dd5186858a..fadb93766020 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -682,7 +682,6 @@ EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
  *                     usually for a root interrupt controller
  * @domain:	The domain where to perform the lookup
  * @hwirq:	The HW irq number to convert to a logical one
- * @lookup:	Whether to perform the domain lookup or not
  * @regs:	Register file coming from the low-level handling code
  *
  * Returns:	0 on success, or -EINVAL if conversion has failed
