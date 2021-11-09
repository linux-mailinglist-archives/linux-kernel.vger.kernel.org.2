Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D67F44B1F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 18:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240989AbhKIR1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 12:27:20 -0500
Received: from foss.arm.com ([217.140.110.172]:36528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240971AbhKIR1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 12:27:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7823EED1;
        Tue,  9 Nov 2021 09:24:28 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 273BC3F800;
        Tue,  9 Nov 2021 09:24:27 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     ardb@kernel.org, catalin.marinas@arm.com, frederic@kernel.org,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org
Subject: [PATCH 4/6] sched/preempt: decouple HAVE_PREEMPT_DYNAMIC from GENERIC_ENTRY
Date:   Tue,  9 Nov 2021 17:24:06 +0000
Message-Id: <20211109172408.49641-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211109172408.49641-1-mark.rutland@arm.com>
References: <20211109172408.49641-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the enabled/disabled states for the preemption functions are
declared alongside their definitions, the core PREEMPT_DYNAMIC logic is
no longer tied to GENERIC_ENTRY, and can safely be selected so long as
an architecture provides enabled/disabled states for
irqentry_exit_cond_resched().

Make it possible to select HAVE_PREEMPT_DYNAMIC without GENERIC_ENTRY.

For existing users of HAVE_PREEMPT_DYNAMIC there should be no functional
change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/Kconfig        | 1 -
 kernel/sched/core.c | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 26b8ed11639d..f3fb543d5da0 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1266,7 +1266,6 @@ config HAVE_STATIC_CALL_INLINE
 config HAVE_PREEMPT_DYNAMIC
 	bool
 	depends on HAVE_STATIC_CALL
-	depends on GENERIC_ENTRY
 	help
 	   Select this if the architecture support boot time preempt setting
 	   on top of static calls. It is strongly advised to support inline
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3a1caa9a095a..ff28f4bd7192 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8102,7 +8102,9 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
+#ifdef CONFIG_GENERIC_ENTRY
 #include <linux/entry-common.h>
+#endif
 
 /*
  * SC:cond_resched
-- 
2.11.0

