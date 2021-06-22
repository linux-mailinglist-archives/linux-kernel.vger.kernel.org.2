Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4F83B07C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhFVOrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232051AbhFVOrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624373088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ruJQZohtmXI8ibvkvPEZgBvMGI9Q8dQYJwDJojrU7o4=;
        b=Wdr/cvU0bkSI2sWrJ972Q4OtZdI4ZDZs3Jdme9jahyGHrIYfrFv+HWQI0ofwLlDQN/fob2
        zr0BretxpLjyfYllImKQhKb9KOH/fuokkBcEAFK4ugPMaiU5vyRv63lgLq5EQh7VZByv0W
        zON4g/G/htGkqDMUkKzNF91XBmriMA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-4njrTLKHOrW8o33ChHrKxw-1; Tue, 22 Jun 2021 10:44:46 -0400
X-MC-Unique: 4njrTLKHOrW8o33ChHrKxw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C478219251A0;
        Tue, 22 Jun 2021 14:44:44 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (unknown [10.10.115.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2515A5D9CA;
        Tue, 22 Jun 2021 14:44:36 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 11/14] trace/hwlat: Protect kdata->kthread with get/put_online_cpus
Date:   Tue, 22 Jun 2021 16:42:29 +0200
Message-Id: <8bdb2a56f46abfd301d6fffbf43448380c09a6f5.1624372313.git.bristot@redhat.com>
In-Reply-To: <cover.1624372313.git.bristot@redhat.com>
References: <cover.1624372313.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to the hotplug support, protect kdata->kthread
with get/put_online_cpus() to avoid concurrency with hotplug
operations.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
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
---
 kernel/trace/trace_hwlat.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 8756ab24c132..dc30b8a9bd5f 100644
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
2.31.1

