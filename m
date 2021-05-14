Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9927F38120D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhENUxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27822 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231614AbhENUxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621025518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=17xhX4pBJ800E/AMdbNxPITLVg9sshQ09lgu/ML4m6c=;
        b=BDXyfdx1kfJDr/3mRVeDA2mGhje+TQkZbE4vXonlANnG3JRwr66Kg4y/ANExzB9kXybPZH
        1qZirAqkldA9yclLs1ggmLJQMjz59zgxNgOR2IPWuZE5l2S/Kb68MHWRdrz7/Kh+cz8xuC
        4UGTPumFAhP3lZ61af6Gimu8ipDzhz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-m__6lELcNVqA-L1oYy2UUA-1; Fri, 14 May 2021 16:51:56 -0400
X-MC-Unique: m__6lELcNVqA-L1oYy2UUA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49FCF801B14;
        Fri, 14 May 2021 20:51:55 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (ovpn-113-210.rdu2.redhat.com [10.10.113.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F39131A868;
        Fri, 14 May 2021 20:51:44 +0000 (UTC)
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
Subject: [PATCH V3 3/9] tracing/hwlat: Switch disable_migrate to mode none
Date:   Fri, 14 May 2021 22:51:12 +0200
Message-Id: <4d341b4315013188685941d254ae94416bfa0512.1621024265.git.bristot@redhat.com>
In-Reply-To: <cover.1621024265.git.bristot@redhat.com>
References: <cover.1621024265.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
index 1f5d48830fd6..fecc3752d7da 100644
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

