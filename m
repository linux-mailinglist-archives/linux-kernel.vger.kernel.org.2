Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8200437F94
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbhJVUwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:52:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234412AbhJVUvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:51:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E2196138D;
        Fri, 22 Oct 2021 20:48:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1T1-000QQk-Ap;
        Fri, 22 Oct 2021 16:48:43 -0400
Message-ID: <20211022204843.174797288@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [for-next][PATCH 27/40] ftrace: Add multi direct register/unregister interface
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

Adding interface to register multiple direct functions
within single call. Adding following functions:

  register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
  unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)

The register_ftrace_direct_multi registers direct function (addr)
with all functions in ops filter. The ops filter can be updated
before with ftrace_set_filter_ip calls.

All requested functions must not have direct function currently
registered, otherwise register_ftrace_direct_multi will fail.

The unregister_ftrace_direct_multi unregisters ops related direct
functions.

Link: https://lkml.kernel.org/r/20211008091336.33616-7-jolsa@kernel.org

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h |  11 ++++
 kernel/trace/ftrace.c  | 142 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 153 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 16a7baaba702..0158261cac9f 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -324,7 +324,10 @@ int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
 				unsigned long old_addr,
 				unsigned long new_addr);
 unsigned long ftrace_find_rec_direct(unsigned long ip);
+int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
+int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
 #else
+struct ftrace_ops;
 # define ftrace_direct_func_count 0
 static inline int register_ftrace_direct(unsigned long ip, unsigned long addr)
 {
@@ -354,6 +357,14 @@ static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
 {
 	return 0;
 }
+static inline int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+{
+	return -ENODEV;
+}
+static inline int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ccbd8377e580..a05b25fb77d8 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5401,6 +5401,148 @@ int modify_ftrace_direct(unsigned long ip,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(modify_ftrace_direct);
+
+#define MULTI_FLAGS (FTRACE_OPS_FL_IPMODIFY | FTRACE_OPS_FL_DIRECT | \
+		     FTRACE_OPS_FL_SAVE_REGS)
+
+static int check_direct_multi(struct ftrace_ops *ops)
+{
+	if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED))
+		return -EINVAL;
+	if ((ops->flags & MULTI_FLAGS) != MULTI_FLAGS)
+		return -EINVAL;
+	return 0;
+}
+
+static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long addr)
+{
+	struct ftrace_func_entry *entry, *del;
+	int size, i;
+
+	size = 1 << hash->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
+			del = __ftrace_lookup_ip(direct_functions, entry->ip);
+			if (del && del->direct == addr) {
+				remove_hash_entry(direct_functions, del);
+				kfree(del);
+			}
+		}
+	}
+}
+
+/**
+ * register_ftrace_direct_multi - Call a custom trampoline directly
+ * for multiple functions registered in @ops
+ * @ops: The address of the struct ftrace_ops object
+ * @addr: The address of the trampoline to call at @ops functions
+ *
+ * This is used to connect a direct calls to @addr from the nop locations
+ * of the functions registered in @ops (with by ftrace_set_filter_ip
+ * function).
+ *
+ * The location that it calls (@addr) must be able to handle a direct call,
+ * and save the parameters of the function being traced, and restore them
+ * (or inject new ones if needed), before returning.
+ *
+ * Returns:
+ *  0 on success
+ *  -EINVAL  - The @ops object was already registered with this call or
+ *             when there are no functions in @ops object.
+ *  -EBUSY   - Another direct function is already attached (there can be only one)
+ *  -ENODEV  - @ip does not point to a ftrace nop location (or not supported)
+ *  -ENOMEM  - There was an allocation failure.
+ */
+int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+{
+	struct ftrace_hash *hash, *free_hash = NULL;
+	struct ftrace_func_entry *entry, *new;
+	int err = -EBUSY, size, i;
+
+	if (ops->func || ops->trampoline)
+		return -EINVAL;
+	if (!(ops->flags & FTRACE_OPS_FL_INITIALIZED))
+		return -EINVAL;
+	if (ops->flags & FTRACE_OPS_FL_ENABLED)
+		return -EINVAL;
+
+	hash = ops->func_hash->filter_hash;
+	if (ftrace_hash_empty(hash))
+		return -EINVAL;
+
+	mutex_lock(&direct_mutex);
+
+	/* Make sure requested entries are not already registered.. */
+	size = 1 << hash->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
+			if (ftrace_find_rec_direct(entry->ip))
+				goto out_unlock;
+		}
+	}
+
+	/* ... and insert them to direct_functions hash. */
+	err = -ENOMEM;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
+			new = ftrace_add_rec_direct(entry->ip, addr, &free_hash);
+			if (!new)
+				goto out_remove;
+			entry->direct = addr;
+		}
+	}
+
+	ops->func = call_direct_funcs;
+	ops->flags = MULTI_FLAGS;
+	ops->trampoline = FTRACE_REGS_ADDR;
+
+	err = register_ftrace_function(ops);
+
+ out_remove:
+	if (err)
+		remove_direct_functions_hash(hash, addr);
+
+ out_unlock:
+	mutex_unlock(&direct_mutex);
+
+	if (free_hash) {
+		synchronize_rcu_tasks();
+		free_ftrace_hash(free_hash);
+	}
+	return err;
+}
+EXPORT_SYMBOL_GPL(register_ftrace_direct_multi);
+
+/**
+ * unregister_ftrace_direct_multi - Remove calls to custom trampoline
+ * previously registered by register_ftrace_direct_multi for @ops object.
+ * @ops: The address of the struct ftrace_ops object
+ *
+ * This is used to remove a direct calls to @addr from the nop locations
+ * of the functions registered in @ops (with by ftrace_set_filter_ip
+ * function).
+ *
+ * Returns:
+ *  0 on success
+ *  -EINVAL - The @ops object was not properly registered.
+ */
+int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+{
+	struct ftrace_hash *hash = ops->func_hash->filter_hash;
+	int err;
+
+	if (check_direct_multi(ops))
+		return -EINVAL;
+	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
+		return -EINVAL;
+
+	mutex_lock(&direct_mutex);
+	err = unregister_ftrace_function(ops);
+	remove_direct_functions_hash(hash, addr);
+	mutex_unlock(&direct_mutex);
+	return err;
+}
+EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
-- 
2.33.0
