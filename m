Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFDB41297F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 01:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245601AbhITXjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 19:39:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239852AbhITXhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 19:37:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2D356128E;
        Mon, 20 Sep 2021 23:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632180772;
        bh=i26PstLc95ziXClQ5RoK+ExK60AsHTyUGJvC+QiRy/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GUfBxK5vCmL92p329EH00TPob+dL918GbcGmWQoa4Iga/S2QaGjEzyZihyR9hkFmT
         e3ZvxetMbvRBq/5/quYgesvqsB1d3XFM9MUR+4Ly5Naql9QZsHoQvXLjUFXIrbe/eZ
         086JtdOF20sl+XvmTuNQru0qzA7VLJchAv4HziAsifjIP3QCyanU+MFr4AFUC/ByPV
         n3X0UT0d3tAYMGmyzlJ286ZyeaMeoR9tNeFl23DbiPL1hz67W4FOo6VUHX6mqlNZdY
         dUxkFN36FiKYORjJQe6qVNLzT1NGGQ2DJkO6pOmr2q5EdMINZWmE/ytfblTvKFd0W5
         4huRF+Lr7UX2Q==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Quentin Perret <qperret@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4/4] arm64: Implement HAVE_PREEMPT_DYNAMIC
Date:   Tue, 21 Sep 2021 01:32:37 +0200
Message-Id: <20210920233237.90463-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210920233237.90463-1-frederic@kernel.org>
References: <20210920233237.90463-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the static calls for the common preemption points and report
arm64 ability to support dynamic preemption.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Quentin Perret <qperret@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/preempt.h | 20 +++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5b51b359ccda..e28bcca8954c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -191,6 +191,7 @@ config ARM64
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_PREEMPT_DYNAMIC
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_STATIC_CALL
 	select HAVE_FUNCTION_ARG_ACCESS_API
diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 4fbbe644532f..69d1cc491d3b 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -82,15 +82,29 @@ static inline bool should_resched(int preempt_offset)
 
 #ifdef CONFIG_PREEMPTION
 void preempt_schedule(void);
-#define __preempt_schedule() preempt_schedule()
 void preempt_schedule_notrace(void);
-#define __preempt_schedule_notrace() preempt_schedule_notrace()
-#endif /* CONFIG_PREEMPTION */
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
+
+#define __preempt_schedule_func preempt_schedule
+DECLARE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
+#define __preempt_schedule() static_call(preempt_schedule)()
+
+#define __preempt_schedule_notrace_func preempt_schedule_notrace
+DECLARE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
+#define __preempt_schedule_notrace() static_call(preempt_schedule_notrace)()
+
 void arm64_preempt_schedule_irq(void);
 #define __irqentry_exit_cond_resched_func arm64_preempt_schedule_irq
 DECLARE_STATIC_CALL(irqentry_exit_cond_resched, __irqentry_exit_cond_resched_func);
+
+#else /* !CONFIG_PREEMPT_DYNAMIC */
+
+#define __preempt_schedule() preempt_schedule()
+#define __preempt_schedule_notrace() preempt_schedule_notrace()
+
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
+#endif /* CONFIG_PREEMPTION */
+
 #endif /* __ASM_PREEMPT_H */
-- 
2.25.1

