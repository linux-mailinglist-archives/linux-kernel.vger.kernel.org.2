Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B920D32FDAD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 23:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCFWHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 17:07:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:38360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229642AbhCFWH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 17:07:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1C75AB8C;
        Sat,  6 Mar 2021 22:07:26 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de
Cc:     paulmck@kernel.org, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] tasklet: Remove tasklet_kill_immediate
Date:   Sat,  6 Mar 2021 13:36:58 -0800
Message-Id: <20210306213658.12862-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ever since RCU was converted to softirq, it has no users.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/interrupt.h |  1 -
 kernel/softirq.c          | 32 --------------------------------
 2 files changed, 33 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 967e25767153..36a2ac6baf9a 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -712,7 +712,6 @@ static inline void tasklet_enable(struct tasklet_struct *t)
 }
 
 extern void tasklet_kill(struct tasklet_struct *t);
-extern void tasklet_kill_immediate(struct tasklet_struct *t, unsigned int cpu);
 extern void tasklet_init(struct tasklet_struct *t,
 			 void (*func)(unsigned long), unsigned long data);
 extern void tasklet_setup(struct tasklet_struct *t,
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 9908ec4a9bfe..8b44ab9a2f69 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -658,38 +658,6 @@ static void run_ksoftirqd(unsigned int cpu)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-/*
- * tasklet_kill_immediate is called to remove a tasklet which can already be
- * scheduled for execution on @cpu.
- *
- * Unlike tasklet_kill, this function removes the tasklet
- * _immediately_, even if the tasklet is in TASKLET_STATE_SCHED state.
- *
- * When this function is called, @cpu must be in the CPU_DEAD state.
- */
-void tasklet_kill_immediate(struct tasklet_struct *t, unsigned int cpu)
-{
-	struct tasklet_struct **i;
-
-	BUG_ON(cpu_online(cpu));
-	BUG_ON(test_bit(TASKLET_STATE_RUN, &t->state));
-
-	if (!test_bit(TASKLET_STATE_SCHED, &t->state))
-		return;
-
-	/* CPU is dead, so no lock needed. */
-	for (i = &per_cpu(tasklet_vec, cpu).head; *i; i = &(*i)->next) {
-		if (*i == t) {
-			*i = t->next;
-			/* If this was the tail element, move the tail ptr */
-			if (*i == NULL)
-				per_cpu(tasklet_vec, cpu).tail = i;
-			return;
-		}
-	}
-	BUG();
-}
-
 static int takeover_tasklets(unsigned int cpu)
 {
 	/* CPU is dead, so no lock needed. */
-- 
2.26.2

