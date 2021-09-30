Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B19541DAD3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350911AbhI3NTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350913AbhI3NT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:19:28 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1637CC06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:17:46 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id m21so6132370pgu.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HXE3iOAOss3Z9oh0TZW0hIqzqp3k7bsAeW3PnBZvSKc=;
        b=JWSPYOzy0aJQVjxIgwrovYZ5SbArKquJMnCLOFV3OdxA5WB+aWwPjq4uGtnidzZKnj
         RLLYiU6FIz387VbJM4gLgGfe6KBe+BEVeI19+cSwLZVZUnrBa/TqMSbMG6msisG4Nss/
         GyoONpN8RHnpN9AmHRtV/lTfmU1fCymgs3viwO9W2rXWkE/dHAyvCSJuBoAl5ctoSPZc
         7KmWfSi6Dhx+4qKAoJtVEFeiXtTYijNtA8gbA1y6uUVrPEE+VqYyLApw/o0hdzlTJc+z
         l5dlHyZQcfb1/CtfBoODQDHWDjYBLy/DWpsDVxxC3xc8FOWBSG0HpXyUg7tlSqKHb9CA
         0cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HXE3iOAOss3Z9oh0TZW0hIqzqp3k7bsAeW3PnBZvSKc=;
        b=Cwpuar1xZtHFaSBBx2Hxtoo+21Z0pk8yWR1WL6vuZgIFFrxN3ADD2E65czZ5eCsgaP
         oTB47IIC0Rdqv6QB4igOduhzkmefENfd0/jl+CZa8P1bXLspspp0uOS+hcsY9OAQ6Vmc
         tKj8dgrlR3Vk3ouJHsljlsQB+cM2O6/zrm/5zanI7nbFlGvZeAA/Q/ij3y3+v4k41fmL
         h5WuArcR2mM1+2vkRn0AcVzrjIeVoy7U/V1t3Xt7RQUtk8X9yKKfRiLo4dPk9+H3tbRi
         sGpsoCTISqVrKfPjWRwEgll8Vsx613lNtU1S5oQg6E9t7D9WlZ1A2IS/b7KSaOIIRAL7
         tOSw==
X-Gm-Message-State: AOAM532J2puv1elbcIA1qPuVFlSjE3/60MOlK1GJaR+ey4RDsuWTsJTw
        8nc1Ol/HRCZiHT/qSdn8RIxaZQDmHg==
X-Google-Smtp-Source: ABdhPJwQBFLoAbju9IJNC8x90MSsuAFWCJ5Ag/k6yu0oTeZAR8k8qjBWlkrJ+GzpNqmBoEEMIZRBeQ==
X-Received: by 2002:a63:c101:: with SMTP id w1mr4856301pgf.53.1633007865645;
        Thu, 30 Sep 2021 06:17:45 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q3sm3083167pgf.18.2021.09.30.06.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:17:45 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCHv3 2/3] arm64: entry: refactor EL1 interrupt entry logic
Date:   Thu, 30 Sep 2021 21:17:07 +0800
Message-Id: <20210930131708.35328-3-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210930131708.35328-1-kernelfans@gmail.com>
References: <20210930131708.35328-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

Currently we distinguish IRQ and definitely-PNMI at entry/exit time
via the enter_el1_irq_or_nmi() and enter_el1_irq_or_nmi() helpers. In
subsequent patches we'll need to handle the two cases more distinctly
in the body of the exception handler.

To make this possible, this patch refactors el1_interrupt to be a
top-level dispatcher to separate handlers for the IRQ and PNMI cases,
removing the need for the enter_el1_irq_or_nmi() and
exit_el1_irq_or_nmi() helpers.

Note that since arm64_enter_nmi() calls __nmi_enter(), which
increments the preemt_count, we could never preempt when handling a
PNMI. We now only check for preemption in the IRQ case, which makes
this clearer.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/kernel/entry-common.c | 44 ++++++++++++++++----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 32f9796c4ffe..5f1473319fb0 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -219,22 +219,6 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
 		lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
-static void noinstr enter_el1_irq_or_nmi(struct pt_regs *regs)
-{
-	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
-		arm64_enter_nmi(regs);
-	else
-		enter_from_kernel_mode(regs);
-}
-
-static void noinstr exit_el1_irq_or_nmi(struct pt_regs *regs)
-{
-	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
-		arm64_exit_nmi(regs);
-	else
-		exit_to_kernel_mode(regs);
-}
-
 static void __sched arm64_preempt_schedule_irq(void)
 {
 	lockdep_assert_irqs_disabled();
@@ -432,14 +416,19 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
 	}
 }
 
-static void noinstr el1_interrupt(struct pt_regs *regs,
-				  void (*handler)(struct pt_regs *))
+static __always_inline void
+__el1_pnmi(struct pt_regs *regs, void (*handler)(struct pt_regs *))
 {
-	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
-
-	enter_el1_irq_or_nmi(regs);
+	arm64_enter_nmi(regs);
 	do_interrupt_handler(regs, handler);
+	arm64_exit_nmi(regs);
+}
 
+static __always_inline void
+__el1_interrupt(struct pt_regs *regs, void (*handler)(struct pt_regs *))
+{
+	enter_from_kernel_mode(regs);
+	do_interrupt_handler(regs, handler);
 	/*
 	 * Note: thread_info::preempt_count includes both thread_info::count
 	 * and thread_info::need_resched, and is not equivalent to
@@ -448,8 +437,19 @@ static void noinstr el1_interrupt(struct pt_regs *regs,
 	if (IS_ENABLED(CONFIG_PREEMPTION) &&
 	    READ_ONCE(current_thread_info()->preempt_count) == 0)
 		arm64_preempt_schedule_irq();
+	exit_to_kernel_mode(regs);
+}
+
+static void noinstr el1_interrupt(struct pt_regs *regs,
+				  void (*handler)(struct pt_regs *))
+{
+	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
+
+	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
+		__el1_pnmi(regs, handler);
+	else
+		__el1_interrupt(regs, handler);
 
-	exit_el1_irq_or_nmi(regs);
 }
 
 asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
-- 
2.31.1

