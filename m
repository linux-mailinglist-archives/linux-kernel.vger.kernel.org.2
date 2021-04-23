Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86407369BCF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 23:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244093AbhDWVH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 17:07:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36715 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244032AbhDWVHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 17:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619211991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gnr70mcmkd5BSJkvsRdj4qx0evb2+1NqWP5GKmtD9uA=;
        b=AOLjbO7q2sdsSRY6AqKHFlJdOiMF5lDOIEPcBjb3hqk6ya3oNgI6ENM7GfpqbuObYwB7Ar
        yhglVStDOA0JJ9zmdsBpF3SBD/kOUh91dKxR1JaLEHP123nHZlID0p2CcjE1NA8Dh5bY00
        dQSkPk10kAn0NrVlCSjQkQdwZWEH1r4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-QSME2AS3MZ2TEVyhTiFPMw-1; Fri, 23 Apr 2021 17:06:27 -0400
X-MC-Unique: QSME2AS3MZ2TEVyhTiFPMw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC86818397A6;
        Fri, 23 Apr 2021 21:06:25 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (ovpn-112-8.rdu2.redhat.com [10.10.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AB9A60C21;
        Fri, 23 Apr 2021 21:06:13 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
Subject: [RFC PATCH V2 3/9] tracing/hwlat: Switch disable_migrate to mode none
Date:   Fri, 23 Apr 2021 23:05:38 +0200
Message-Id: <812a79bf123c44f410fa260e1129713840281b11.1619210818.git.bristot@redhat.com>
In-Reply-To: <cover.1619210818.git.bristot@redhat.com>
References: <cover.1619210818.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When in the round-robin mode, if the tracer detects a change in the
hwlatd thread affinity by an external tool, e.g., taskset, the
round-robin logic is disabled. The disable_migrate variable currently
tracks this.

With the addition of the "mode" config and the mode "none," the
disable_migrate logic is equivalent to switch to the "none" mode.

Hence, instead of using a hidden variable to track this behavior,
switch the mode to none, informing the user about this change.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Clark Willaims <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 kernel/trace/trace_hwlat.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 293a969be269..d5daeac351e5 100644
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
@@ -740,7 +738,6 @@ static int hwlat_tracer_init(struct trace_array *tr)
 
 	hwlat_trace = tr;
 
-	disable_migrate = false;
 	hwlat_data.count = 0;
 	tr->max_latency = 0;
 	save_tracing_thresh = tracing_thresh;
-- 
2.26.3

