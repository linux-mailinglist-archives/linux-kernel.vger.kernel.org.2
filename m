Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A383B07BB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhFVOqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232022AbhFVOqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624373035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wPQDo8D079dUGMyCxyfQNoqPlDR92XvC7RUcDbbW3hs=;
        b=X6aTAog6iVPMrValB+zutp2WL9tTrjNHxf++aajyvWG+m/0iUp2l5mXAhQ1bWSudxIskNK
        1psCA4PZLzL+XvWMiOADzdtQDARLWm3Y6fBbUNu3kGFS2YDmEuwb8558K3gxjIjpdX4hiQ
        CdaYCRtne+Dcqdyn7Rzsz+pJ8Go1OTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-8G5RJG0yP2i8vrDuQo9_Qg-1; Tue, 22 Jun 2021 10:43:53 -0400
X-MC-Unique: 8G5RJG0yP2i8vrDuQo9_Qg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9473119251A1;
        Tue, 22 Jun 2021 14:43:51 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (unknown [10.10.115.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5334A5D9F0;
        Tue, 22 Jun 2021 14:43:41 +0000 (UTC)
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
Subject: [PATCH V5 06/14] trace/hwlat: Use trace_min_max_param for width and window params
Date:   Tue, 22 Jun 2021 16:42:24 +0200
Message-Id: <b91accd5a7c6c14ea02d3379aae974ba22b47dd6.1624372313.git.bristot@redhat.com>
In-Reply-To: <cover.1624372313.git.bristot@redhat.com>
References: <cover.1624372313.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the trace_min_max_param to reduce code duplication.

No functional change.

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
 kernel/trace/trace_hwlat.c | 145 ++++++-------------------------------
 1 file changed, 24 insertions(+), 121 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 5a85d696a167..c3a41ba61052 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -527,115 +527,6 @@ static int start_per_cpu_kthreads(struct trace_array *tr)
 	return retval;
 }
 
-/*
- * hwlat_read - Wrapper read function for reading both window and width
- * @filp: The active open file structure
- * @ubuf: The userspace provided buffer to read value into
- * @cnt: The maximum number of bytes to read
- * @ppos: The current "file" position
- *
- * This function provides a generic read implementation for the global state
- * "hwlat_data" structure filesystem entries.
- */
-static ssize_t hwlat_read(struct file *filp, char __user *ubuf,
-			  size_t cnt, loff_t *ppos)
-{
-	char buf[U64STR_SIZE];
-	u64 *entry = filp->private_data;
-	u64 val;
-	int len;
-
-	if (!entry)
-		return -EFAULT;
-
-	if (cnt > sizeof(buf))
-		cnt = sizeof(buf);
-
-	val = *entry;
-
-	len = snprintf(buf, sizeof(buf), "%llu\n", val);
-
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);
-}
-
-/**
- * hwlat_width_write - Write function for "width" entry
- * @filp: The active open file structure
- * @ubuf: The user buffer that contains the value to write
- * @cnt: The maximum number of bytes to write to "file"
- * @ppos: The current position in @file
- *
- * This function provides a write implementation for the "width" interface
- * to the hardware latency detector. It can be used to configure
- * for how many us of the total window us we will actively sample for any
- * hardware-induced latency periods. Obviously, it is not possible to
- * sample constantly and have the system respond to a sample reader, or,
- * worse, without having the system appear to have gone out to lunch. It
- * is enforced that width is less that the total window size.
- */
-static ssize_t
-hwlat_width_write(struct file *filp, const char __user *ubuf,
-		  size_t cnt, loff_t *ppos)
-{
-	u64 val;
-	int err;
-
-	err = kstrtoull_from_user(ubuf, cnt, 10, &val);
-	if (err)
-		return err;
-
-	mutex_lock(&hwlat_data.lock);
-	if (val < hwlat_data.sample_window)
-		hwlat_data.sample_width = val;
-	else
-		err = -EINVAL;
-	mutex_unlock(&hwlat_data.lock);
-
-	if (err)
-		return err;
-
-	return cnt;
-}
-
-/**
- * hwlat_window_write - Write function for "window" entry
- * @filp: The active open file structure
- * @ubuf: The user buffer that contains the value to write
- * @cnt: The maximum number of bytes to write to "file"
- * @ppos: The current position in @file
- *
- * This function provides a write implementation for the "window" interface
- * to the hardware latency detector. The window is the total time
- * in us that will be considered one sample period. Conceptually, windows
- * occur back-to-back and contain a sample width period during which
- * actual sampling occurs. Can be used to write a new total window size. It
- * is enforced that any value written must be greater than the sample width
- * size, or an error results.
- */
-static ssize_t
-hwlat_window_write(struct file *filp, const char __user *ubuf,
-		   size_t cnt, loff_t *ppos)
-{
-	u64 val;
-	int err;
-
-	err = kstrtoull_from_user(ubuf, cnt, 10, &val);
-	if (err)
-		return err;
-
-	mutex_lock(&hwlat_data.lock);
-	if (hwlat_data.sample_width < val)
-		hwlat_data.sample_window = val;
-	else
-		err = -EINVAL;
-	mutex_unlock(&hwlat_data.lock);
-
-	if (err)
-		return err;
-
-	return cnt;
-}
-
 static void *s_mode_start(struct seq_file *s, loff_t *pos)
 {
 	int mode = *pos;
@@ -760,16 +651,28 @@ static ssize_t hwlat_mode_write(struct file *filp, const char __user *ubuf,
 	return ret;
 }
 
-static const struct file_operations width_fops = {
-	.open		= tracing_open_generic,
-	.read		= hwlat_read,
-	.write		= hwlat_width_write,
+/*
+ * The width parameter is read/write using the generic trace_min_max_param
+ * method. The *val is protected by the hwlat_data lock and is upper
+ * bounded by the window parameter.
+ */
+static struct trace_min_max_param hwlat_width = {
+	.lock		= &hwlat_data.lock,
+	.val		= &hwlat_data.sample_width,
+	.max		= &hwlat_data.sample_window,
+	.min		= NULL,
 };
 
-static const struct file_operations window_fops = {
-	.open		= tracing_open_generic,
-	.read		= hwlat_read,
-	.write		= hwlat_window_write,
+/*
+ * The window parameter is read/write using the generic trace_min_max_param
+ * method. The *val is protected by the hwlat_data lock and is lower
+ * bounded by the width parameter.
+ */
+static struct trace_min_max_param hwlat_window = {
+	.lock		= &hwlat_data.lock,
+	.val		= &hwlat_data.sample_window,
+	.max		= NULL,
+	.min		= &hwlat_data.sample_width,
 };
 
 static const struct file_operations thread_mode_fops = {
@@ -802,15 +705,15 @@ static int init_tracefs(void)
 
 	hwlat_sample_window = tracefs_create_file("window", 0640,
 						  top_dir,
-						  &hwlat_data.sample_window,
-						  &window_fops);
+						  &hwlat_window,
+						  &trace_min_max_fops);
 	if (!hwlat_sample_window)
 		goto err;
 
 	hwlat_sample_width = tracefs_create_file("width", 0644,
 						 top_dir,
-						 &hwlat_data.sample_width,
-						 &width_fops);
+						 &hwlat_width,
+						 &trace_min_max_fops);
 	if (!hwlat_sample_width)
 		goto err;
 
-- 
2.31.1

