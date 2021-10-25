Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8CB439614
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhJYMXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233134AbhJYMXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:23:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44AD360C49;
        Mon, 25 Oct 2021 12:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635164478;
        bh=Tt/i7iD6xlaQxTtA4XyxsrDmMQUJyDa5EIEEzXszjC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NTs54pfLiCkVwnQBpW2gvPRcrw+reXceRHh+XizOkcA7+ilAmJtWE5PKLw7+/9OPi
         hpSPvRw4pNJPtFXEB6t/kOKOpMjeLko5aGHtLLFEQpoSLo4SUhRQRbKNO7NjMvVY46
         E6Qm40RARzphR+kRY2iPUvx2NvHI62Xx/sB5ePj+g0RWn83IXRbqmEtkv0wBOLNDUl
         AcUEx8Fo8+m1N33+Vyzil/Omj9daKxd7CaUEtudpVLq2haF+u4Q7zGIvFZTOX2Yi38
         lb/97MqQtS3c+5LG3TYmV/y1OZDxOoQIEiPsYs+esUPuJLFP9606YmY+dfXFFbe+N+
         sez4h2Di1NFdQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        James Morse <james.morse@arm.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4/4] arm64: Implement HAVE_PREEMPT_DYNAMIC
Date:   Mon, 25 Oct 2021 14:21:02 +0200
Message-Id: <20211025122102.46089-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025122102.46089-1-frederic@kernel.org>
References: <20211025122102.46089-1-frederic@kernel.org>
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
Cc: David Laight <David.Laight@ACULAB.COM>
---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/preempt.h | 20 +++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 34b175b1e247..24915ca7d6d5 100644
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

