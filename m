Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C5833132A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhCHQPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:15:42 -0500
Received: from foss.arm.com ([217.140.110.172]:40298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229701AbhCHQPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:15:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4DB713A1;
        Mon,  8 Mar 2021 08:15:09 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C33DB3F73C;
        Mon,  8 Mar 2021 08:15:07 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v14 7/8] arm64: mte: Report async tag faults before suspend
Date:   Mon,  8 Mar 2021 16:14:33 +0000
Message-Id: <20210308161434.33424-8-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210308161434.33424-1-vincenzo.frascino@arm.com>
References: <20210308161434.33424-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When MTE async mode is enabled TFSR_EL1 contains the accumulative
asynchronous tag check faults for EL1 and EL0.

During the suspend/resume operations the firmware might perform some
operations that could change the state of the register resulting in
a spurious tag check fault report.

Report asynchronous tag faults before suspend and clear the TFSR_EL1
register after resume to prevent this to happen.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/mte.h |  4 ++++
 arch/arm64/kernel/mte.c      | 16 ++++++++++++++++
 arch/arm64/kernel/suspend.c  |  3 +++
 3 files changed, 23 insertions(+)

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 43169b978cd3..33e88a470357 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -41,6 +41,7 @@ void mte_sync_tags(pte_t *ptep, pte_t pte);
 void mte_copy_page_tags(void *kto, const void *kfrom);
 void flush_mte_state(void);
 void mte_thread_switch(struct task_struct *next);
+void mte_suspend_enter(void);
 void mte_suspend_exit(void);
 long set_mte_ctrl(struct task_struct *task, unsigned long arg);
 long get_mte_ctrl(struct task_struct *task);
@@ -66,6 +67,9 @@ static inline void flush_mte_state(void)
 static inline void mte_thread_switch(struct task_struct *next)
 {
 }
+static inline void mte_suspend_enter(void)
+{
+}
 static inline void mte_suspend_exit(void)
 {
 }
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index d6456f2d2306..1979bd9ad09b 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -261,6 +261,22 @@ void mte_thread_switch(struct task_struct *next)
 	mte_check_tfsr_el1();
 }
 
+void mte_suspend_enter(void)
+{
+	if (!system_supports_mte())
+		return;
+
+	/*
+	 * The barriers are required to guarantee that the indirect writes
+	 * to TFSR_EL1 are synchronized before we report the state.
+	 */
+	dsb(nsh);
+	isb();
+
+	/* Report SYS_TFSR_EL1 before suspend entry */
+	mte_check_tfsr_el1();
+}
+
 void mte_suspend_exit(void)
 {
 	if (!system_supports_mte())
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index d7564891ffe1..6fdc8292b4f5 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -91,6 +91,9 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	unsigned long flags;
 	struct sleep_stack_data state;
 
+	/* Report any MTE async fault before going to suspend */
+	mte_suspend_enter();
+
 	/*
 	 * From this point debug exceptions are disabled to prevent
 	 * updates to mdscr register (saved and restored along with
-- 
2.30.0

