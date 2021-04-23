Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B206369BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 23:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244137AbhDWVHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 17:07:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38375 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244083AbhDWVH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 17:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619212010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bf12E10qXY88Ef3Zfv3NCghKJLaHrxLUTgaFZlvjSnQ=;
        b=MhLPe6Q00GQVwvLaGXF6gAjSX9/WLtxp88CxAAYT0vWEBvUdcbeZ6A6mSYC2carDfr07kW
        3sBqBgfiJfItxbCoQ1rPT/3wfZceBaUZKHtuO6/nW+V/1btXvWspTytOmf2BDH9heQNhMo
        lOYY4+4fdFsBidnkExnIcZUOgrK8OoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-dISChYG6OLOGHkRAK0NT-w-1; Fri, 23 Apr 2021 17:06:49 -0400
X-MC-Unique: dISChYG6OLOGHkRAK0NT-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C01388030A0;
        Fri, 23 Apr 2021 21:06:47 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (ovpn-112-8.rdu2.redhat.com [10.10.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F9A660C21;
        Fri, 23 Apr 2021 21:06:36 +0000 (UTC)
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
Subject: [RFC PATCH V2 6/9] tracing/hwlat: Use the generic function to read/write width and window
Date:   Fri, 23 Apr 2021 23:05:41 +0200
Message-Id: <aa21dd7615a61241398df6ed09fd9b1e244aca94.1619210818.git.bristot@redhat.com>
In-Reply-To: <cover.1619210818.git.bristot@redhat.com>
References: <cover.1619210818.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the trace_ull_config generic implementation to reducing the code of
hwlat detector.

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
 kernel/trace/trace_hwlat.c | 135 ++++---------------------------------
 1 file changed, 14 insertions(+), 121 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 289ccd56064a..08a39f2e4e65 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -504,115 +504,6 @@ static int start_per_cpu_kthreads(struct trace_array *tr)
 	return 0;
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
@@ -733,16 +624,18 @@ static ssize_t hwlat_mode_write(struct file *filp, const char __user *ubuf,
 	return ret;
 }
 
-static const struct file_operations width_fops = {
-	.open		= tracing_open_generic,
-	.read		= hwlat_read,
-	.write		= hwlat_width_write,
+static struct trace_ull_config hwlat_width = {
+	.lock		= &hwlat_data.lock,
+	.val		= &hwlat_data.sample_width,
+	.max		= &hwlat_data.sample_window,
+	.min		= NULL,
 };
 
-static const struct file_operations window_fops = {
-	.open		= tracing_open_generic,
-	.read		= hwlat_read,
-	.write		= hwlat_window_write,
+static struct trace_ull_config hwlat_window = {
+	.lock		= &hwlat_data.lock,
+	.val		= &hwlat_data.sample_window,
+	.max		= NULL,
+	.min		= &hwlat_data.sample_width,
 };
 
 static const struct file_operations thread_mode_fops = {
@@ -775,15 +668,15 @@ static int init_tracefs(void)
 
 	hwlat_sample_window = tracefs_create_file("window", 0640,
 						  top_dir,
-						  &hwlat_data.sample_window,
-						  &window_fops);
+						  &hwlat_window,
+						  &trace_ull_config_fops);
 	if (!hwlat_sample_window)
 		goto err;
 
 	hwlat_sample_width = tracefs_create_file("width", 0644,
 						 top_dir,
-						 &hwlat_data.sample_width,
-						 &width_fops);
+						 &hwlat_width,
+						 &trace_ull_config_fops);
 	if (!hwlat_sample_width)
 		goto err;
 
-- 
2.26.3

