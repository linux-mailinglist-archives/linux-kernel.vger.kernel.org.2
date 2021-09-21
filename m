Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914A541297A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 01:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244505AbhITXjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 19:39:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239762AbhITXhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 19:37:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA3E06128A;
        Mon, 20 Sep 2021 23:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632180765;
        bh=gPXBdc7K+aAZWKuOsG/via/0NZIAr5ZJxKuqPHHugBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BzOUvn/hjgodRRy3SASz5gXOpFolNILbWSio/H2BEnkkm3hMPK9ISX5Pmu6Cz4yqE
         ahkF0rUSSuW8eIwiFp/sqhUGGSy+nIaeIPxfmYl+6CCLQBrqI/PqIfBInZaznhOuCv
         m+HRLSG1F7ghd/GCg/5sd9LI/I2+15k6XxaLkk6umRD/1b98kiKbO4SQnztux9ypUi
         rzHjg4obeMtK0uNOpESKbrld5zb8UN2mAomMxKcBnM/koIawcbZ9pv3hs4qe9PZjgp
         B/bXAMKBMuF+Mi72BD4xqvll1Ko5tpTmRpWISh11lNKbMvcgqQDPEBnc9bWMerEdzC
         NCQAMjs8dDTXA==
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
Subject: [PATCH 1/4] sched/preempt: Prepare for supporting !CONFIG_GENERIC_ENTRY dynamic preemption
Date:   Tue, 21 Sep 2021 01:32:34 +0200
Message-Id: <20210920233237.90463-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210920233237.90463-1-frederic@kernel.org>
References: <20210920233237.90463-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to force dynamic preemption to depend on the generic
entry code. The latter is convenient but not mandatory. An architecture
that doesn't support it just need to provide a static call on its
kernel IRQ exit preemption path.

Prepare the preempt dynamic code to handle that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Quentin Perret <qperret@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
---
 arch/Kconfig                 | 1 -
 include/linux/entry-common.h | 3 ++-
 kernel/sched/core.c          | 6 ++++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8df1c7102643..9af493999d43 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1255,7 +1255,6 @@ config HAVE_STATIC_CALL_INLINE
 config HAVE_PREEMPT_DYNAMIC
 	bool
 	depends on HAVE_STATIC_CALL
-	depends on GENERIC_ENTRY
 	help
 	   Select this if the architecture support boot time preempt setting
 	   on top of static calls. It is strongly advised to support inline
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 2e2b8d6140ed..81166bbc0f22 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -456,7 +456,8 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
  */
 void irqentry_exit_cond_resched(void);
 #ifdef CONFIG_PREEMPT_DYNAMIC
-DECLARE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+#define __irqentry_exit_cond_resched_func irqentry_exit_cond_resched
+DECLARE_STATIC_CALL(irqentry_exit_cond_resched, __irqentry_exit_cond_resched_func);
 #endif
 
 /**
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index af2ca7ea7dda..51c81da33f23 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6553,7 +6553,9 @@ EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
+#ifdef CONFIG_GENERIC_ENTRY
 #include <linux/entry-common.h>
+#endif
 
 /*
  * SC:cond_resched
@@ -6618,7 +6620,7 @@ void sched_dynamic_update(int mode)
 	static_call_update(might_resched, __cond_resched);
 	static_call_update(preempt_schedule, __preempt_schedule_func);
 	static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-	static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+	static_call_update(irqentry_exit_cond_resched, __irqentry_exit_cond_resched_func);
 
 	switch (mode) {
 	case preempt_dynamic_none:
@@ -6644,7 +6646,7 @@ void sched_dynamic_update(int mode)
 		static_call_update(might_resched, (void *)&__static_call_return0);
 		static_call_update(preempt_schedule, __preempt_schedule_func);
 		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+		static_call_update(irqentry_exit_cond_resched, __irqentry_exit_cond_resched_func);
 		pr_info("Dynamic Preempt: full\n");
 		break;
 	}
-- 
2.25.1

