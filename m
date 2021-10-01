Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3073041EFDD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 16:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354621AbhJAOqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 10:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354616AbhJAOqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 10:46:15 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A9DC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 07:44:31 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id k26so8129345pfi.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 07:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TKjVR6/OIbtaDS2aKgtnt+zzA9GH3sGfYZy/bT0/UJQ=;
        b=qobJ08dRI10r2InHr8xeRxigYELnCvL0kdMhtx8j0neLGSvzqJzls+vCvxNrQtkvqD
         CMDy1MlMppe/J0lSWd8sCKS3TV7UrYj/I/YTgP9wO0785caWfgaaaPgh1LKOvorRVlNx
         QIyZlz08dvM2rUtknaTv8BzWJLjkyDvgLDNlEIlTZSnvlmhky4dZ5xIIn8r6CkrrL8va
         jRf85nBB0A6Zw7rkIHhWEENK01q0+uLSuS5it6WSYTujXZpG0wkZ8MwwBsgLcagqQOWj
         Oz+rtdZAsnfnTGMC5dsivqzImk78MXR7vmtkjreQDNLgqBrP10vDcyqmf6+vQaKXt5UM
         P21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TKjVR6/OIbtaDS2aKgtnt+zzA9GH3sGfYZy/bT0/UJQ=;
        b=who/vtOo4lNgrgo1832KemXYir7tBBTNfkB9pGtB9uYpcP3RCbifisMVyIIbwYDV4v
         EeJ2fOGhmKFM6IbEQ/onirj6PXh2MZmOuK2doVTETDQ/Fytu+6UwUyJAIdDsM7w4liMH
         ufgBYmb5kMj0iM7oiCir3XfY7i1ncPgDrX71MBCiVqgfcT8xAUkIDP7VPZyTJm7ebe8x
         S78nbVHcqNb15DQqIMyKgUO0E1qaPmZtJm3R63J/gZWrjcnAW0w65bqPbXZu8DOmHCB5
         I3FEBgXc7gd15Vj/VMuK38+JIMnGXdPd6YPASry+f3RTL7MdiyQh+4yxwVZQEWiNKtk7
         fNLg==
X-Gm-Message-State: AOAM530i2rpSZjqyiyM9T9R02E4JQPCCN5aFAr5IoFw7qZKLR1K4mURs
        Ms+MnQuodFG/0WdZnXBcqg==
X-Google-Smtp-Source: ABdhPJyvQsUwbRBCwjEBRRPxwgvVl9HSspJ8+/s3D+U6IrIIB6kJOG95/xHOOZZtvf6CpT9+fVX5nQ==
X-Received: by 2002:a63:fb18:: with SMTP id o24mr4857595pgh.8.1633099471003;
        Fri, 01 Oct 2021 07:44:31 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z12sm6766203pge.16.2021.10.01.07.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:44:30 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCHv4 2/3] arm64: entry: refactor EL1 interrupt entry logic
Date:   Fri,  1 Oct 2021 22:44:05 +0800
Message-Id: <20211001144406.7719-3-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211001144406.7719-1-kernelfans@gmail.com>
References: <20211001144406.7719-1-kernelfans@gmail.com>
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
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/kernel/entry-common.c | 43 ++++++++++++++++----------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 32f9796c4ffe..fecf046f0708 100644
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
@@ -448,8 +437,18 @@ static void noinstr el1_interrupt(struct pt_regs *regs,
 	if (IS_ENABLED(CONFIG_PREEMPTION) &&
 	    READ_ONCE(current_thread_info()->preempt_count) == 0)
 		arm64_preempt_schedule_irq();
+	exit_to_kernel_mode(regs);
+}
 
-	exit_el1_irq_or_nmi(regs);
+static void noinstr el1_interrupt(struct pt_regs *regs,
+				  void (*handler)(struct pt_regs *))
+{
+	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
+
+	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
+		__el1_pnmi(regs, handler);
+	else
+		__el1_interrupt(regs, handler);
 }
 
 asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
-- 
2.31.1

