Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9F93B4EA3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 15:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhFZNIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 09:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhFZNIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 09:08:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CF9B61C43;
        Sat, 26 Jun 2021 13:05:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lx809-000El1-1h; Sat, 26 Jun 2021 09:05:37 -0400
Message-ID: <20210626130536.889613063@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 26 Jun 2021 09:04:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-doc@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [for-next][PATCH 13/24] trace/hwlat: Switch disable_migrate to mode none
References: <20210626130404.033700863@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@redhat.com>

When in the round-robin mode, if the tracer detects a change in the
hwlatd thread affinity by an external tool, e.g., taskset, the
round-robin logic is disabled. The disable_migrate variable currently
tracks this.

With the addition of the "mode" config and the mode "none," the
disable_migrate logic is equivalent to switch to the "none" mode.

Hence, instead of using a hidden variable to track this behavior,
switch the mode to none, informing the user about this change.

Link: https://lkml.kernel.org/r/a679af672458d6b1f62252605905c5214030f247.1624372313.git.bristot@redhat.com

Cc: Phil Auld <pauld@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Kate Carcia <kcarcia@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Clark Willaims <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_hwlat.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 43a436d85a01..bae74b95cf55 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -286,7 +286,6 @@ static int get_sample(void)
 }
 
 static struct cpumask save_cpumask;
-static bool disable_migrate;
 
 static void move_to_next_cpu(void)
 {
@@ -294,15 +293,13 @@ static void move_to_next_cpu(void)
 	struct trace_array *tr = hwlat_trace;
 	int next_cpu;
 
-	if (disable_migrate)
-		return;
 	/*
 	 * If for some reason the user modifies the CPU affinity
 	 * of this thread, then stop migrating for the duration
 	 * of the current test.
 	 */
 	if (!cpumask_equal(current_mask, current->cpus_ptr))
-		goto disable;
+		goto change_mode;
 
 	get_online_cpus();
 	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
@@ -313,7 +310,7 @@ static void move_to_next_cpu(void)
 		next_cpu = cpumask_first(current_mask);
 
 	if (next_cpu >= nr_cpu_ids) /* Shouldn't happen! */
-		goto disable;
+		goto change_mode;
 
 	cpumask_clear(current_mask);
 	cpumask_set_cpu(next_cpu, current_mask);
@@ -321,8 +318,9 @@ static void move_to_next_cpu(void)
 	sched_setaffinity(0, current_mask);
 	return;
 
- disable:
-	disable_migrate = true;
+ change_mode:
+	hwlat_data.thread_mode = MODE_NONE;
+	pr_info(BANNER "cpumask changed while in round-robin mode, switching to mode none\n");
 }
 
 /*
@@ -744,7 +742,6 @@ static int hwlat_tracer_init(struct trace_array *tr)
 
 	hwlat_trace = tr;
 
-	disable_migrate = false;
 	hwlat_data.count = 0;
 	tr->max_latency = 0;
 	save_tracing_thresh = tracing_thresh;
-- 
2.30.2
