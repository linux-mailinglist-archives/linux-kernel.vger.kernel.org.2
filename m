Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4B73A7A92
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhFOJbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:31:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55097 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231409AbhFOJbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623749378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BIponc5QGrcPAwb19nseDoFq0ahiW3+gw68JDK4N8z4=;
        b=R40bh22jDtL+NzCToXEq+vpASkLOF1JMgaJSV0L2vRupo720FN42bGFaFF0pE4WF9f1rMc
        O0tgJt5GQtxpjQ2OoJrsAzgfaCa0KBWejlwxwickENs8VPvXzCCnT/B8uyoT8IholePAvW
        uEe6tv0MKLm0ZECK/FSLdZLSc5fsM3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-I2ESP4TDPhG91f9ioXCEoQ-1; Tue, 15 Jun 2021 05:29:37 -0400
X-MC-Unique: I2ESP4TDPhG91f9ioXCEoQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 863F7101C8AE;
        Tue, 15 Jun 2021 09:29:35 +0000 (UTC)
Received: from x1.com (ovpn-113-40.rdu2.redhat.com [10.10.113.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 507235D6AD;
        Tue, 15 Jun 2021 09:29:31 +0000 (UTC)
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
Subject: [PATCH V4 06/12] trace: Add a generic function to read/write u64 values from tracefs
Date:   Tue, 15 Jun 2021 11:28:45 +0200
Message-Id: <681a2fb508b3dad2979ac705c3df633f14abb9b2.1623746916.git.bristot@redhat.com>
In-Reply-To: <cover.1623746916.git.bristot@redhat.com>
References: <cover.1623746916.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hwlat detector and (in preparation for) the osnoise/timerlat tracers
have a set of u64 parameters that the user can read/write via tracefs.
For instance, we have hwlat_detector's window and width.

To reduce the code duplication, hwlat's window and width share the same
read function. However, they do not share the write functions because
they do different parameter checks. For instance, the width needs to
be smaller than the window, while the window needs to be larger
than the window. The same pattern repeats on osnoise/timerlat, and
a large portion of the code was devoted to the write function.

Despite having different checks, the write functions have the same
structure:

   read a user-space buffer
   take the lock that protects the value
   check for minimum and maximum acceptable values
      save the value
   release the lock
   return success or error

To reduce the code duplication also in the write functions, this patch
provides a generic read and write implementation for u64 values that
need to be within some minimum and/or maximum parameters, while
(potentially) being protected by a lock.

To use this interface, the structure trace_min_max_param needs to be
filled:

 struct trace_min_max_param {
         struct mutex    *lock;
         u64             *val;
         u64             *min;
         u64             *max;
 };

The desired value is stored on the variable pointed by *val. If *min
points to a minimum acceptable value, it will be checked during the
write operation. Likewise, if *max points to a maximum allowable value,
it will be checked during the write operation. Finally, if *lock points
to a mutex, it will be taken at the beginning of the operation and
released at the end.

The definition of a trace_min_max_param needs to passed as the
(private) *data for tracefs_create_file(), and the trace_min_max_fops
(added by this patch) as the *fops file_operations.

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
 kernel/trace/trace.c | 86 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace.h | 18 ++++++++++
 2 files changed, 104 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c094865e2f71..e03343e8f332 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7545,6 +7545,92 @@ static const struct file_operations snapshot_raw_fops = {
 
 #endif /* CONFIG_TRACER_SNAPSHOT */
 
+/*
+ * trace_min_max_write - Write a u64 value to a trace_min_max_param struct
+ * @filp: The active open file structure
+ * @ubuf: The userspace provided buffer to read value into
+ * @cnt: The maximum number of bytes to read
+ * @ppos: The current "file" position
+ *
+ * This function implements the write interface for a struct trace_min_max_param.
+ * The filp->private_data must point to a trace_min_max_param structure that
+ * defines where to write the value, the min and the max acceptable values,
+ * and a lock to protect the write.
+ */
+static ssize_t
+trace_min_max_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t *ppos)
+{
+	struct trace_min_max_param *param = filp->private_data;
+	u64 val;
+	int err;
+
+	if (!param)
+		return -EFAULT;
+
+	err = kstrtoull_from_user(ubuf, cnt, 10, &val);
+	if (err)
+		return err;
+
+	if (param->lock)
+		mutex_lock(param->lock);
+
+	if (param->min && val < *param->min)
+		err = -EINVAL;
+
+	if (param->max && val > *param->max)
+		err = -EINVAL;
+
+	if (!err)
+		*param->val = val;
+
+	if (param->lock)
+		mutex_unlock(param->lock);
+
+	if (err)
+		return err;
+
+	return cnt;
+}
+
+/*
+ * trace_min_max_read - Read a u64 value from a trace_min_max_param struct
+ * @filp: The active open file structure
+ * @ubuf: The userspace provided buffer to read value into
+ * @cnt: The maximum number of bytes to read
+ * @ppos: The current "file" position
+ *
+ * This function implements the read interface for a struct trace_min_max_param.
+ * The filp->private_data must point to a trace_min_max_param struct with valid
+ * data.
+ */
+static ssize_t
+trace_min_max_read(struct file *filp, char __user *ubuf, size_t cnt,
+		      loff_t *ppos)
+{
+	struct trace_min_max_param *param = filp->private_data;
+	char buf[ULL_STR_SIZE];
+	u64 val;
+        int len;
+
+        if (!param)
+                return -EFAULT;
+
+	val = *param->val;
+
+        if (cnt > sizeof(buf))
+                cnt = sizeof(buf);
+
+        len = snprintf(buf, sizeof(buf), "%llu\n", val);
+
+        return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);
+}
+
+const struct file_operations trace_min_max_fops = {
+	.open		= tracing_open_generic,
+	.read		= trace_min_max_read,
+	.write		= trace_min_max_write,
+};
+
 #define TRACING_LOG_ERRS_MAX	8
 #define TRACING_LOG_LOC_MAX	128
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index cd80d046c7a5..7bfb50461d5e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1952,4 +1952,22 @@ static inline bool is_good_name(const char *name)
 	return true;
 }
 
+/*
+ * This is a generic way to read and write a u64 value from a file in tracefs.
+ *
+ * The value is stored on the variable pointed by *val. The value needs
+ * to be at least *min and at most *max. The write is protected by an
+ * existing *lock.
+ */
+struct trace_min_max_param {
+	struct mutex	*lock;
+	u64		*val;
+	u64		*min;
+	u64		*max;
+};
+
+#define ULL_STR_SIZE		22	/* 20 digits max */
+
+extern const struct file_operations trace_min_max_fops;
+
 #endif /* _LINUX_KERNEL_TRACE_H */
-- 
2.31.1

