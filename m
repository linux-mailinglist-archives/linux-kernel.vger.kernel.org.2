Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0604C3B8ADD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 01:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbhF3XVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 19:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236455AbhF3XUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 19:20:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0EF761469;
        Wed, 30 Jun 2021 23:18:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lyjTK-000ZEO-OO; Wed, 30 Jun 2021 19:18:22 -0400
Message-ID: <20210630231822.591734452@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 30 Jun 2021 19:18:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Austin Kim <austin.kim@lge.com>
Subject: [for-next][PATCH 4/5] tracing: Change variable type as bool for clean-up
References: <20210630231758.861158022@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Austin Kim <austin.kim@lge.com>

The wakeup_rt wakeup_dl, tracing_dl is only set to 0, 1.
So changing type of wakeup_rt wakeup_dl, tracing_dl as bool
makes relevant routine be more readable.

Link: https://lkml.kernel.org/r/20210629140548.GA1627@raspberrypi

Signed-off-by: Austin Kim <austin.kim@lge.com>
[ Removed unneeded initialization of static bool tracing_dl ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_sched_wakeup.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index e5778d1d7a5b..2402de520eca 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -26,9 +26,9 @@ static struct task_struct	*wakeup_task;
 static int			wakeup_cpu;
 static int			wakeup_current_cpu;
 static unsigned			wakeup_prio = -1;
-static int			wakeup_rt;
-static int			wakeup_dl;
-static int			tracing_dl = 0;
+static bool			wakeup_rt;
+static bool			wakeup_dl;
+static bool			tracing_dl;
 
 static arch_spinlock_t wakeup_lock =
 	(arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
@@ -498,7 +498,7 @@ static void __wakeup_reset(struct trace_array *tr)
 {
 	wakeup_cpu = -1;
 	wakeup_prio = -1;
-	tracing_dl = 0;
+	tracing_dl = false;
 
 	if (wakeup_task)
 		put_task_struct(wakeup_task);
@@ -572,9 +572,9 @@ probe_wakeup(void *ignore, struct task_struct *p)
 	 * another task until the first one wakes up.
 	 */
 	if (dl_task(p))
-		tracing_dl = 1;
+		tracing_dl = true;
 	else
-		tracing_dl = 0;
+		tracing_dl = false;
 
 	wakeup_task = get_task_struct(p);
 
@@ -685,8 +685,8 @@ static int wakeup_tracer_init(struct trace_array *tr)
 	if (wakeup_busy)
 		return -EBUSY;
 
-	wakeup_dl = 0;
-	wakeup_rt = 0;
+	wakeup_dl = false;
+	wakeup_rt = false;
 	return __wakeup_tracer_init(tr);
 }
 
@@ -695,8 +695,8 @@ static int wakeup_rt_tracer_init(struct trace_array *tr)
 	if (wakeup_busy)
 		return -EBUSY;
 
-	wakeup_dl = 0;
-	wakeup_rt = 1;
+	wakeup_dl = false;
+	wakeup_rt = true;
 	return __wakeup_tracer_init(tr);
 }
 
@@ -705,8 +705,8 @@ static int wakeup_dl_tracer_init(struct trace_array *tr)
 	if (wakeup_busy)
 		return -EBUSY;
 
-	wakeup_dl = 1;
-	wakeup_rt = 0;
+	wakeup_dl = true;
+	wakeup_rt = false;
 	return __wakeup_tracer_init(tr);
 }
 
-- 
2.30.2
