Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F74437F95
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbhJVUwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:52:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234413AbhJVUvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:51:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ABDA61391;
        Fri, 22 Oct 2021 20:48:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1T1-000QRJ-Gc;
        Fri, 22 Oct 2021 16:48:43 -0400
Message-ID: <20211022204843.355443318@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [for-next][PATCH 28/40] ftrace: Add multi direct modify interface
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

Adding interface to modify registered direct function
for ftrace_ops. Adding following function:

   modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)

The function changes the currently registered direct
function for all attached functions.

Link: https://lkml.kernel.org/r/20211008091336.33616-8-jolsa@kernel.org

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |  6 ++++
 kernel/trace/ftrace.c  | 62 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 0158261cac9f..9999e29187de 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -326,6 +326,8 @@ int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
 unsigned long ftrace_find_rec_direct(unsigned long ip);
 int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
 int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
+int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
+
 #else
 struct ftrace_ops;
 # define ftrace_direct_func_count 0
@@ -365,6 +367,10 @@ static inline int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigne
 {
 	return -ENODEV;
 }
+static inline int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a05b25fb77d8..30120342176e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5543,6 +5543,68 @@ int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 	return err;
 }
 EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
+
+/**
+ * modify_ftrace_direct_multi - Modify an existing direct 'multi' call
+ * to call something else
+ * @ops: The address of the struct ftrace_ops object
+ * @addr: The address of the new trampoline to call at @ops functions
+ *
+ * This is used to unregister currently registered direct caller and
+ * register new one @addr on functions registered in @ops object.
+ *
+ * Note there's window between ftrace_shutdown and ftrace_startup calls
+ * where there will be no callbacks called.
+ *
+ * Returns: zero on success. Non zero on error, which includes:
+ *  -EINVAL - The @ops object was not properly registered.
+ */
+int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+{
+	struct ftrace_hash *hash = ops->func_hash->filter_hash;
+	struct ftrace_func_entry *entry, *iter;
+	int i, size;
+	int err;
+
+	if (check_direct_multi(ops))
+		return -EINVAL;
+	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
+		return -EINVAL;
+
+	mutex_lock(&direct_mutex);
+	mutex_lock(&ftrace_lock);
+
+	/*
+	 * Shutdown the ops, change 'direct' pointer for each
+	 * ops entry in direct_functions hash and startup the
+	 * ops back again.
+	 *
+	 * Note there is no callback called for @ops object after
+	 * this ftrace_shutdown call until ftrace_startup is called
+	 * later on.
+	 */
+	err = ftrace_shutdown(ops, 0);
+	if (err)
+		goto out_unlock;
+
+	size = 1 << hash->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(iter, &hash->buckets[i], hlist) {
+			entry = __ftrace_lookup_ip(direct_functions, iter->ip);
+			if (!entry)
+				continue;
+			entry->direct = addr;
+		}
+	}
+
+	err = ftrace_startup(ops, 0);
+
+ out_unlock:
+	mutex_unlock(&ftrace_lock);
+	mutex_unlock(&direct_mutex);
+	return err;
+}
+EXPORT_SYMBOL_GPL(modify_ftrace_direct_multi);
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
-- 
2.33.0
