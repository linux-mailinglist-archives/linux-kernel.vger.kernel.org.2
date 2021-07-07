Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD303BF037
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 21:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhGGTZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 15:25:52 -0400
Received: from foss.arm.com ([217.140.110.172]:43716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhGGTZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 15:25:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1549DD6E;
        Wed,  7 Jul 2021 12:23:11 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E20E3F694;
        Wed,  7 Jul 2021 12:23:10 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] preempt: Allow CONFIG_DEBUG_PREEMPT for CONFIG_PREEMPT_VOLUNTARY
Date:   Wed,  7 Jul 2021 20:23:06 +0100
Message-Id: <20210707192306.2297497-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While recently staring at some preempt_count dumpster fire for a
CONFIG_PREEMPT_VOLUNTARY kernel, I wished I could turn on
CONFIG_DEBUG_PREEMPT on top of CONFIG_DEBUG_ATOMIC_SLEEP to see *where*
preemption had been disabled. It didn't take much to get that, and although
it didn't help my particular case, I think it can still be useful.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/core.c | 3 +--
 lib/Kconfig.debug   | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0c22cd026440..5673b85fa22d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5109,8 +5109,7 @@ static inline void sched_tick_start(int cpu) { }
 static inline void sched_tick_stop(int cpu) { }
 #endif
 
-#if defined(CONFIG_PREEMPTION) && (defined(CONFIG_DEBUG_PREEMPT) || \
-				defined(CONFIG_TRACE_PREEMPT_TOGGLE))
+#if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_TRACE_PREEMPT_TOGGLE)
 /*
  * If the value passed in is equal to the current preempt count
  * then we just disabled preemption. Start timing the latency.
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 678c13967580..7fdd45eee343 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1204,7 +1204,7 @@ config DEBUG_TIMEKEEPING
 
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
-	depends on DEBUG_KERNEL && PREEMPTION && TRACE_IRQFLAGS_SUPPORT
+	depends on DEBUG_KERNEL && PREEMPT_COUNT && TRACE_IRQFLAGS_SUPPORT
 	default y
 	help
 	  If you say Y here then the kernel will use a debug variant of the
-- 
2.25.1

