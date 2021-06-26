Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9943B4EAD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 15:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhFZNIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 09:08:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhFZNIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 09:08:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7A2861C50;
        Sat, 26 Jun 2021 13:05:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lx80A-000Eq5-Po; Sat, 26 Jun 2021 09:05:38 -0400
Message-ID: <20210626130538.648729939@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 26 Jun 2021 09:04:26 -0400
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
Subject: [for-next][PATCH 22/24] trace/hwlat: Protect kdata->kthread with get/put_online_cpus
References: <20210626130404.033700863@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@redhat.com>

In preparation to the hotplug support, protect kdata->kthread
with get/put_online_cpus() to avoid concurrency with hotplug
operations.

Link: https://lore.kernel.org/linux-doc/20210621134636.5b332226@oasis.local.home/
Link: https://lkml.kernel.org/r/8bdb2a56f46abfd301d6fffbf43448380c09a6f5.1624372313.git.bristot@redhat.com

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
Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_hwlat.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index a625bfdb844e..20e31f79ebd9 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -396,13 +396,19 @@ static int kthread_fn(void *data)
 static void stop_single_kthread(void)
 {
 	struct hwlat_kthread_data *kdata = get_cpu_data();
-	struct task_struct *kthread = kdata->kthread;
+	struct task_struct *kthread;
+
+	get_online_cpus();
+	kthread = kdata->kthread;
 
 	if (!kthread)
-		return;
+		goto out_put_cpus;
 
 	kthread_stop(kthread);
 	kdata->kthread = NULL;
+
+out_put_cpus:
+	put_online_cpus();
 }
 
 
@@ -419,20 +425,19 @@ static int start_single_kthread(struct trace_array *tr)
 	struct task_struct *kthread;
 	int next_cpu;
 
+	get_online_cpus();
 	if (kdata->kthread)
-		return 0;
+		goto out_put_cpus;
 
 	kthread = kthread_create(kthread_fn, NULL, "hwlatd");
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
+		put_online_cpus();
 		return -ENOMEM;
 	}
 
-
 	/* Just pick the first CPU on first iteration */
-	get_online_cpus();
 	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
-	put_online_cpus();
 
 	if (hwlat_data.thread_mode == MODE_ROUND_ROBIN) {
 		next_cpu = cpumask_first(current_mask);
@@ -446,6 +451,8 @@ static int start_single_kthread(struct trace_array *tr)
 	kdata->kthread = kthread;
 	wake_up_process(kthread);
 
+out_put_cpus:
+	put_online_cpus();
 	return 0;
 }
 
-- 
2.30.2
