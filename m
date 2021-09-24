Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8704175E1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346587AbhIXNei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346549AbhIXNe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:34:28 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0986CC08E8BB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:28:59 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h3so9862122pgb.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KM6OpafNDbs5gC7AhwUIhQlXXaIlZMI4KerHz+Wd/II=;
        b=W8dKLKjMyGZdP4ZKFty5vBxQDsRnRPYKTyDI3rKgGPBBIcDH+d3mwjYE5zUc2tIRBD
         cNN33F4x4VFcdRJz/H6V7SPtKnlFjfSND0dj5e1ia0E4QFNvkQ2BoJvwm/1P2hFLO7no
         C9rZjjbuxNfwojHLvsjiOzUMiE4kzb+ySCW02XPvAgVoezjyuVg02/TDJ1AX/4qOfOuD
         Gf6r3gwD2q5R4GJOKs5R1tYuc1wh7nWQ1YA/HZKYUUzqtGkY8uiUe9iF/b1C7HbQHADo
         FhMLwDtVb5gnPPV4K/jG7YhfMNJ/UPemcqBk5yd8qWbLZhKT0kOYzUgcWtcVWbAOt0rW
         DJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KM6OpafNDbs5gC7AhwUIhQlXXaIlZMI4KerHz+Wd/II=;
        b=aNt6DRSs+k18l1YkhDzpx4uXjPk3ZMX/ZgI2BlK/+pTgixgVj0IqWYy8rU/R058GCq
         FyWxlrKScoD8ZgoVMbzOBfr+TgmH6HL5pALmHZbCEJOh96kJCnIaGqt7rGE70Vh3jf60
         1kT868Ucm01B2Z06ssJrHDK+LVn1xm8CViOR0CHiAehMMml0Yai7yvaNClMN1OZBO2bG
         GkeLdBmKzuHVBxmIUqoJ/CJ3neigTKEXAw3iVjv60G5gYDcWDdKTe7YnCUJgZ5WmJlhG
         Xr2ZGoN315LquOV+5Ln1maCQwkdNObudtAKtMhfO7oHw8W5vDwSA6wvdbLepoRmSUz4a
         SMxw==
X-Gm-Message-State: AOAM5301ygGsj+lGlDC9JTAbQuMUBN5bcmeQeRxZbPX13D2uniMTnUVf
        3vtGkMAtsOLxqpreFK23VQ==
X-Google-Smtp-Source: ABdhPJwMVXMC/ZxnaF+ueP2XXMs36pJoqLmeGnmtD8aWkjTW+JtZpZTjYn8ik4EF9vAznSNty9fE3g==
X-Received: by 2002:a63:5902:: with SMTP id n2mr3787246pgb.305.1632490138549;
        Fri, 24 Sep 2021 06:28:58 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 26sm11756573pgx.72.2021.09.24.06.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:28:58 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCHv2 1/5] arm64/entry-common: push the judgement of nmi ahead
Date:   Fri, 24 Sep 2021 21:28:33 +0800
Message-Id: <20210924132837.45994-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924132837.45994-1-kernelfans@gmail.com>
References: <20210924132837.45994-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In enter_el1_irq_or_nmi(), it can be the case which NMI interrupts an
irq, which makes the condition !interrupts_enabled(regs) fail to detect
the NMI. This will cause a mistaken account for irq.

Introducing two interfaces: handle_arch_nmi and interrupt_is_nmi to
judge NMI at this stage.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/irq.h     |  5 ++++
 arch/arm64/kernel/entry-common.c | 45 ++++++++++++++++++++++----------
 arch/arm64/kernel/irq.c          | 29 ++++++++++++++++++++
 3 files changed, 65 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index fac08e18bcd5..a59b1745f458 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -12,6 +12,11 @@ int set_handle_irq(void (*handle_irq)(struct pt_regs *));
 #define set_handle_irq	set_handle_irq
 int set_handle_fiq(void (*handle_fiq)(struct pt_regs *));
 
+extern void (*handle_arch_irq)(struct pt_regs *regs);
+extern void (*handle_arch_fiq)(struct pt_regs *regs);
+extern void (*handle_arch_nmi)(struct pt_regs *regs);
+extern bool (*interrupt_is_nmi)(void);
+
 static inline int nr_legacy_irqs(void)
 {
 	return 0;
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 32f9796c4ffe..69a8cc082712 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -24,6 +24,7 @@
 #include <asm/stacktrace.h>
 #include <asm/sysreg.h>
 #include <asm/system_misc.h>
+#include <asm/irq.h>
 
 /*
  * Handle IRQ/context state management when entering from kernel mode.
@@ -219,17 +220,28 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
 		lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
-static void noinstr enter_el1_irq_or_nmi(struct pt_regs *regs)
+static inline bool arm64_in_nmi(struct pt_regs *regs)
 {
-	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
+	if (!interrupts_enabled(regs) || (*interrupt_is_nmi)())
+		return true;
+	return false;
+}
+
+/* return true if in irq, otherwise in nmi */
+static bool noinstr enter_el1_irq_or_nmi(struct pt_regs *regs)
+{
+	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && arm64_in_nmi(regs)) {
 		arm64_enter_nmi(regs);
-	else
+		return false;
+	} else {
 		enter_from_kernel_mode(regs);
+		return true;
+	}
 }
 
-static void noinstr exit_el1_irq_or_nmi(struct pt_regs *regs)
+static void noinstr exit_el1_irq_or_nmi(struct pt_regs *regs, bool in_irq)
 {
-	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
+	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !in_irq)
 		arm64_exit_nmi(regs);
 	else
 		exit_to_kernel_mode(regs);
@@ -269,9 +281,6 @@ static void do_interrupt_handler(struct pt_regs *regs,
 		handler(regs);
 }
 
-extern void (*handle_arch_irq)(struct pt_regs *);
-extern void (*handle_arch_fiq)(struct pt_regs *);
-
 static void noinstr __panic_unhandled(struct pt_regs *regs, const char *vector,
 				      unsigned int esr)
 {
@@ -433,12 +442,20 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
 }
 
 static void noinstr el1_interrupt(struct pt_regs *regs,
-				  void (*handler)(struct pt_regs *))
+				  void (*handler)(struct pt_regs *),
+				  void (*nmi_handler)(struct pt_regs *))
 {
+	bool in_irq;
+	void (*h)(struct pt_regs *regs);
+
 	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
 
-	enter_el1_irq_or_nmi(regs);
-	do_interrupt_handler(regs, handler);
+	in_irq = enter_el1_irq_or_nmi(regs);
+	if (in_irq)
+		h = handler;
+	else
+		h = nmi_handler;
+	do_interrupt_handler(regs, h);
 
 	/*
 	 * Note: thread_info::preempt_count includes both thread_info::count
@@ -449,17 +466,17 @@ static void noinstr el1_interrupt(struct pt_regs *regs,
 	    READ_ONCE(current_thread_info()->preempt_count) == 0)
 		arm64_preempt_schedule_irq();
 
-	exit_el1_irq_or_nmi(regs);
+	exit_el1_irq_or_nmi(regs, in_irq);
 }
 
 asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
 {
-	el1_interrupt(regs, handle_arch_irq);
+	el1_interrupt(regs, handle_arch_irq, handle_arch_nmi);
 }
 
 asmlinkage void noinstr el1h_64_fiq_handler(struct pt_regs *regs)
 {
-	el1_interrupt(regs, handle_arch_fiq);
+	el1_interrupt(regs, handle_arch_fiq, handle_arch_nmi);
 }
 
 asmlinkage void noinstr el1h_64_error_handler(struct pt_regs *regs)
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index bda49430c9ea..e67435eb4cba 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -81,8 +81,19 @@ static void default_handle_fiq(struct pt_regs *regs)
 	panic("FIQ taken without a root FIQ handler\n");
 }
 
+static void default_handle_nmi(struct pt_regs *unused)
+{
+}
+
+static bool default_nmi_discriminator(void)
+{
+	return false;
+}
+
 void (*handle_arch_irq)(struct pt_regs *) __ro_after_init = default_handle_irq;
 void (*handle_arch_fiq)(struct pt_regs *) __ro_after_init = default_handle_fiq;
+void (*handle_arch_nmi)(struct pt_regs *) __ro_after_init = default_handle_nmi;
+bool (*interrupt_is_nmi)(void) __ro_after_init = default_nmi_discriminator;
 
 int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
 {
@@ -104,6 +115,24 @@ int __init set_handle_fiq(void (*handle_fiq)(struct pt_regs *))
 	return 0;
 }
 
+int __init set_handle_nmi(void (*handle_nmi)(struct pt_regs *))
+{
+	if (handle_arch_nmi != default_handle_nmi)
+		return -EBUSY;
+
+	handle_arch_nmi = handle_nmi;
+	return 0;
+}
+
+int __init set_nmi_discriminator(bool (*discriminator)(void))
+{
+	if (interrupt_is_nmi != default_nmi_discriminator)
+		return -EBUSY;
+
+	interrupt_is_nmi = discriminator;
+	return 0;
+}
+
 void __init init_IRQ(void)
 {
 	init_irq_stacks();
-- 
2.31.1

