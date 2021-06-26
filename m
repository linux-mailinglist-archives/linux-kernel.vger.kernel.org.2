Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2423B4EA1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 15:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhFZNIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 09:08:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230093AbhFZNIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 09:08:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6085361C3C;
        Sat, 26 Jun 2021 13:05:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lx809-000Em9-Dq; Sat, 26 Jun 2021 09:05:37 -0400
Message-ID: <20210626130537.271428380@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 26 Jun 2021 09:04:19 -0400
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
Subject: [for-next][PATCH 15/24] trace: Add a generic function to read/write u64 values from tracefs
References: <20210626130404.033700863@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@redhat.com>

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

Link: https://lkml.kernel.org/r/3e35760a7c8b5c55f16ae5ad5fc54a0e71cbe647.1624372313.git.bristot@redhat.com

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
 kernel/trace/trace.c | 85 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace.h | 18 ++++++++++
 2 files changed, 103 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d352fb4b7709..27bf203ef05a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7583,6 +7583,91 @@ static const struct file_operations snapshot_raw_fops = {
 
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
+trace_min_max_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
+{
+	struct trace_min_max_param *param = filp->private_data;
+	char buf[U64_STR_SIZE];
+	int len;
+	u64 val;
+
+	if (!param)
+		return -EFAULT;
+
+	val = *param->val;
+
+	if (cnt > sizeof(buf))
+		cnt = sizeof(buf);
+
+	len = snprintf(buf, sizeof(buf), "%llu\n", val);
+
+	return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);
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
index cd80d046c7a5..22f8c652ef8b 100644
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
+#define U64_STR_SIZE		24	/* 20 digits max */
+
+extern const struct file_operations trace_min_max_fops;
+
 #endif /* _LINUX_KERNEL_TRACE_H */
-- 
2.30.2
