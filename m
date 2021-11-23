Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18476459D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 08:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhKWHxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 02:53:19 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:26351 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbhKWHxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 02:53:14 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hyx4b5rXzzbhmh;
        Tue, 23 Nov 2021 15:45:03 +0800 (CST)
Received: from shapctfsvr00001.huawei.com (100.106.52.157) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 15:50:03 +0800
From:   Zixuan Zhao <zhaozixuan2@huawei.com>
To:     <paul@paul-moore.com>, <eparis@redhat.com>
CC:     <linux-audit@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] audit: accelerate audit rule filter
Date:   Tue, 23 Nov 2021 15:50:01 +0800
Message-ID: <20211123075001.3676-1-zhaozixuan2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.106.52.157]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500023.china.huawei.com (7.185.36.83)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhaozixuan <zhaozixuan2@huawei.com>

Audit traverses rules when a syscall exits until it finds a matching rule.
 For syscalls not monitored by any rules, audit has to traverse all rules
 to know they are not interested. This process would be repeated many times
 and cause performance issues when a user adds many syscall rules. To solve
 this problem, we add an array to record the number of rules interested in
 a syscall. When a syscall exits, audit will check the array to decide
 whether to search syscall-rules or just quit. The complexity can be
 optimized from O(n) to O(1) for syscalls that are not monitored by rules.
 This patch does so with the following changes:

1. We define a global array audit_syscall_rules to record the number of
 rules interested in a syscall. For compatible architectures which may have
 two different syscall sets, we define one more array called
 audit_compat_syscall_rules.
2. When a rule is added/deleted by a user, we use the syscall_nr
 interested by the rule as the index of the global array and +1/-1 the
 corresponding value. Considering tree-type rules usually monitor many
 syscalls which may reduce the optimization effect, we move them from
 audit_filter_list[AUDIT_FILTER_EXIT] to a new rule list named
 audit_filter_dir_list, and add a new function audit_filter_dir to handle
 these rules.
3. Add a check in function audit_filter_syscall. If
 audit_syscall_rules[major] == 0 (or audit_compat_syscall_rules[major] == 0
 for compatible architecture), quit the function early.

We used lat_syscall of lmbench3 to test the performance impact of this
 patch. We changed the number of rules and run lat_syscall with 1000
 repetitions at each test. Syscalls measured by lat_syscall are not
 monitored by rules.

Before this optimization:

             null     read    write     stat    fstat      open
  0 rules  1.87ms   2.74ms   2.56ms   26.31ms  4.13ms   69.66ms
 10 rules  2.15ms   3.13ms   3.32ms   26.99ms  4.16ms   74.70ms
 20 rules  2.45ms   3.97ms   3.82ms   27.05ms  4.60ms   76.35ms
 30 rules  2.64ms   4.52ms   3.95ms   30.30ms  4.94ms   78.94ms
 40 rules  2.83ms   4.97ms   4.23ms   32.16ms  5.40ms   81.88ms
 50 rules  3.00ms   5.30ms   4.84ms   33.49ms  5.79ms   83.20ms
100 rules  4.24ms   9.75ms   7.42ms   37.68ms  6.55ms   93.70ms
160 rules  5.50ms   16.89ms  12.18ms  51.53ms  17.45ms  155.40ms

After this optimization:

             null     read    write     stat    fstat      open
  0 rules  1.81ms   2.84ms   2.42ms  27.70ms   4.15ms   69.10ms
 10 rules  1.97ms   2.83ms   2.69ms  27.70ms   4.15ms   69.30ms
 20 rules  1.72ms   2.91ms   2.41ms  26.49ms   3.91ms   71.19ms
 30 rules  1.85ms   2.94ms   2.48ms  26.27ms   3.97ms   71.43ms
 40 rules  1.88ms   2.94ms   2.78ms  26.85ms   4.08ms   69.79ms
 50 rules  1.86ms   3.17ms   3.08ms  26.25ms   4.03ms   72.32ms
100 rules  1.84ms   3.00ms   2.81ms  26.25ms   3.98ms   70.25ms
160 rules  1.92ms   3.32ms   3.06ms  26.81ms   4.57ms   71.41ms

As the result shown above, the syscall latencies increase as  the number
 of rules increases, while with the patch the latencies remain stable.
 This could help when a user adds many audit rules for purposes (such as
 attack tracing or process behavior recording) but suffers from low
 performance.

Signed-off-by: zhaozixuan <zhaozixuan2@huawei.com>
---
 include/linux/audit.h |  13 +++++
 kernel/audit.c        |  15 ++++++
 kernel/audit.h        |  12 +++++
 kernel/auditfilter.c  | 122 +++++++++++++++++++++++++++++++++++++++++-
 kernel/auditsc.c      |  48 ++++++++++++++++-
 5 files changed, 207 insertions(+), 3 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 82b7c1116a85..988b673ac66d 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -280,6 +280,19 @@ static inline int audit_signal_info(int sig, struct task_struct *t)
 #define AUDIT_INODE_HIDDEN	2	/* audit record should be hidden */
 #define AUDIT_INODE_NOEVAL	4	/* audit record incomplete */
 
+#include <asm/seccomp.h>
+#define AUDIT_ARCH_NATIVE		SECCOMP_ARCH_NATIVE
+#define AUDIT_ARCH_NATIVE_NR	SECCOMP_ARCH_NATIVE_NR
+#ifdef SECCOMP_ARCH_COMPAT
+#define AUDIT_ARCH_COMPAT		SECCOMP_ARCH_COMPAT
+#define AUDIT_ARCH_COMPAT_NR	SECCOMP_ARCH_COMPAT_NR
+#define AUDIR_ARCH_MAX_NR		(SECCOMP_ARCH_NATIVE_NR > \
+					SECCOMP_ARCH_COMPAT_NR ? SECCOMP_ARCH_NATIVE_NR : \
+					SECCOMP_ARCH_COMPAT_NR)
+#else
+#define AUDIR_ARCH_MAX_NR		SECCOMP_ARCH_NATIVE_NR
+#endif
+
 #ifdef CONFIG_AUDITSYSCALL
 #include <asm/syscall.h> /* for syscall_get_arch() */
 
diff --git a/kernel/audit.c b/kernel/audit.c
index 121d37e700a6..813a69bbf81a 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1638,6 +1638,10 @@ static struct pernet_operations audit_net_ops __net_initdata = {
 static int __init audit_init(void)
 {
 	int i;
+	struct audit_rule_count *arc = NULL;
+#ifdef AUDIT_ARCH_COMPAT
+	struct audit_rule_count *compat_arc = NULL;
+#endif
 
 	if (audit_initialized == AUDIT_DISABLED)
 		return 0;
@@ -1668,6 +1672,17 @@ static int __init audit_init(void)
 		panic("audit: failed to start the kauditd thread (%d)\n", err);
 	}
 
+	arc = alloc_audit_rule_count(AUDIT_ARCH_NATIVE_NR);
+	if (!arc)
+		panic("audit: failed to initialize audit_syscall_rules\n");
+	rcu_assign_pointer(audit_syscall_rules, arc);
+#ifdef AUDIT_ARCH_COMPAT
+	compat_arc = alloc_audit_rule_count(AUDIT_ARCH_COMPAT_NR);
+	if (!compat_arc)
+		panic("audit: failed to initialize audit_compat_syscall_rules\n");
+	rcu_assign_pointer(audit_compat_syscall_rules, compat_arc);
+#endif
+
 	audit_log(NULL, GFP_KERNEL, AUDIT_KERNEL,
 		"state=initialized audit_enabled=%u res=1",
 		 audit_enabled);
diff --git a/kernel/audit.h b/kernel/audit.h
index d6a2c899a8db..7e452b9e2a30 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -199,6 +199,11 @@ struct audit_context {
 	struct audit_proctitle proctitle;
 };
 
+struct audit_rule_count {
+	struct rcu_head rcu;
+	int length;
+	unsigned int counts[0];
+};
 extern bool audit_ever_enabled;
 
 extern void audit_log_session_info(struct audit_buffer *ab);
@@ -216,6 +221,13 @@ static inline int audit_hash_ino(u32 ino)
 /* Indicates that audit should log the full pathname. */
 #define AUDIT_NAME_FULL -1
 
+extern struct audit_rule_count *audit_syscall_rules;
+#ifdef AUDIT_ARCH_COMPAT
+extern struct audit_rule_count *audit_compat_syscall_rules;
+#endif
+extern inline struct audit_rule_count *alloc_audit_rule_count(int length);
+extern struct list_head audit_filter_dir_list;
+extern int audit_in_mask(const struct audit_krule *rule, unsigned long val);
 extern int audit_match_class(int class, unsigned syscall);
 extern int audit_comparator(const u32 left, const u32 op, const u32 right);
 extern int audit_uid_comparator(kuid_t left, u32 op, kuid_t right);
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index db2c6b59dfc3..53da9cf99d29 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -60,6 +60,12 @@ static struct list_head audit_rules_list[AUDIT_NR_FILTERS] = {
 
 DEFINE_MUTEX(audit_filter_mutex);
 
+struct audit_rule_count *audit_syscall_rules;
+#ifdef AUDIT_ARCH_COMPAT
+struct audit_rule_count *audit_compat_syscall_rules;
+#endif
+LIST_HEAD(audit_filter_dir_list);
+
 static void audit_free_lsm_field(struct audit_field *f)
 {
 	switch (f->type) {
@@ -909,6 +915,8 @@ static struct audit_entry *audit_find_rule(struct audit_entry *entry,
 				}
 		}
 		goto out;
+	} else if (entry->rule.tree) {
+		*p = list = &audit_filter_dir_list;
 	} else {
 		*p = list = &audit_filter_list[entry->rule.listnr];
 	}
@@ -926,6 +934,105 @@ static struct audit_entry *audit_find_rule(struct audit_entry *entry,
 static u64 prio_low = ~0ULL/2;
 static u64 prio_high = ~0ULL/2 - 1;
 
+inline struct audit_rule_count *alloc_audit_rule_count(int length)
+{
+	struct audit_rule_count *arc = kzalloc(
+				sizeof(struct audit_rule_count) + sizeof(unsigned int) * length,
+				GFP_KERNEL);
+	if (arc)
+		arc->length = length;
+	return arc;
+}
+static int copy_rule_counts(int arch, struct audit_rule_count **old_counts,
+							struct audit_rule_count **new_counts)
+{
+	if (arch == AUDIT_ARCH_NATIVE)
+		*old_counts = rcu_dereference_protected(audit_syscall_rules,
+						lockdep_is_held(&audit_filter_mutex));
+#ifdef AUDIT_ARCH_COMPAT
+	else if (arch == AUDIT_ARCH_COMPAT)
+		*old_counts = rcu_dereference_protected(audit_compat_syscall_rules,
+						lockdep_is_held(&audit_filter_mutex));
+#endif
+	else
+		return -EINVAL;
+
+	*new_counts = alloc_audit_rule_count((*old_counts)->length);
+	if (!*new_counts)
+		return -ENOMEM;
+
+	memcpy((*new_counts)->counts,
+				(*old_counts)->counts,
+				sizeof(unsigned int) * (*old_counts)->length);
+
+	return 0;
+}
+
+static inline bool arch_monitored(struct audit_entry *entry, int arch)
+{
+	return (entry->rule.arch_f == NULL ||
+					audit_comparator(arch,
+								entry->rule.arch_f->op,
+								entry->rule.arch_f->val));
+}
+
+static int audit_update_syscall_rule(struct audit_entry *entry, int delt)
+{
+	int i = 0;
+	int err = 0;
+	struct audit_rule_count *new_counts = NULL;
+	struct audit_rule_count *old_counts = NULL;
+	bool update_native;
+#ifdef AUDIT_ARCH_COMPAT
+	struct audit_rule_count *new_compat_counts = NULL;
+	struct audit_rule_count *old_compat_counts = NULL;
+	bool update_compat;
+#endif
+	if (entry->rule.listnr != AUDIT_FILTER_EXIT || entry->rule.watch || entry->rule.tree)
+		return 0;
+
+	update_native = arch_monitored(entry, AUDIT_ARCH_NATIVE);
+	if (update_native) {
+		err = copy_rule_counts(AUDIT_ARCH_NATIVE, &old_counts, &new_counts);
+		if (err)
+			return err;
+	}
+
+#ifdef AUDIT_ARCH_COMPAT
+	update_compat = arch_monitored(entry, AUDIT_ARCH_COMPAT);
+	if (update_compat) {
+		err = copy_rule_counts(AUDIT_ARCH_COMPAT, &old_compat_counts, &new_compat_counts);
+		if (err) {
+			kfree(new_counts);
+			return err;
+		}
+	}
+#endif
+
+	for (i = 0; i < AUDIR_ARCH_MAX_NR; i++) {
+		if ((audit_in_mask(&entry->rule, i) == 0))
+			continue;
+		if (i < AUDIT_ARCH_NATIVE_NR && update_native)
+			new_counts->counts[i] += delt;
+#ifdef AUDIT_ARCH_COMPAT
+		if (i < AUDIT_ARCH_COMPAT_NR && update_compat)
+			new_compat_counts->counts[i] += delt;
+#endif
+	}
+
+	if (update_native) {
+		rcu_assign_pointer(audit_syscall_rules, new_counts);
+		kfree_rcu(old_counts, rcu);
+	}
+#ifdef AUDIT_ARCH_COMPAT
+	if (update_compat) {
+		rcu_assign_pointer(audit_compat_syscall_rules, new_counts);
+		kfree_rcu(old_compat_counts, rcu);
+	}
+#endif
+	return 0;
+}
+
 /* Add rule to given filterlist if not a duplicate. */
 static inline int audit_add_rule(struct audit_entry *entry)
 {
@@ -957,6 +1064,15 @@ static inline int audit_add_rule(struct audit_entry *entry)
 		return err;
 	}
 
+	err = audit_update_syscall_rule(entry, 1);
+	if (err) {
+		mutex_unlock(&audit_filter_mutex);
+		/* normally audit_add_tree_rule() will free it on failure */
+		if (tree)
+			audit_put_tree(tree);
+		return err;
+	}
+
 	if (watch) {
 		/* audit_filter_mutex is dropped and re-taken during this call */
 		err = audit_add_watch(&entry->rule, &list);
@@ -994,7 +1110,7 @@ static inline int audit_add_rule(struct audit_entry *entry)
 		entry->rule.flags &= ~AUDIT_FILTER_PREPEND;
 	} else {
 		list_add_tail(&entry->rule.list,
-			      &audit_rules_list[entry->rule.listnr]);
+				&audit_rules_list[entry->rule.listnr]);
 		list_add_tail_rcu(&entry->list, list);
 	}
 #ifdef CONFIG_AUDITSYSCALL
@@ -1035,6 +1151,10 @@ int audit_del_rule(struct audit_entry *entry)
 		goto out;
 	}
 
+	ret = audit_update_syscall_rule(e, -1);
+	if (ret)
+		goto out;
+
 	if (e->rule.watch)
 		audit_remove_watch_rule(&e->rule);
 
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index b1cb1dbf7417..da764328c3aa 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -789,7 +789,7 @@ static enum audit_state audit_filter_task(struct task_struct *tsk, char **key)
 	return AUDIT_STATE_BUILD;
 }
 
-static int audit_in_mask(const struct audit_krule *rule, unsigned long val)
+int audit_in_mask(const struct audit_krule *rule, unsigned long val)
 {
 	int word, bit;
 
@@ -805,6 +805,25 @@ static int audit_in_mask(const struct audit_krule *rule, unsigned long val)
 	return rule->mask[word] & bit;
 }
 
+static bool audit_syscall_monitored(int arch, int major)
+{
+	struct audit_rule_count *arc = NULL;
+
+	if (arch == AUDIT_ARCH_NATIVE)
+		arc = rcu_dereference(audit_syscall_rules);
+#ifdef AUDIT_ARCH_COMPAT
+	else if (arch == AUDIT_ARCH_COMPAT)
+		arc = rcu_dereference(audit_compat_syscall_rules);
+#endif
+	else
+		return false;
+
+	if (major < arc->length)
+		return arc->counts[major] != 0;
+
+	return false;
+}
+
 /* At syscall exit time, this filter is called if the audit_state is
  * not low enough that auditing cannot take place, but is also not
  * high enough that we already know we have to write an audit record
@@ -820,6 +839,11 @@ static void audit_filter_syscall(struct task_struct *tsk,
 		return;
 
 	rcu_read_lock();
+	if (likely(!audit_syscall_monitored(ctx->arch, ctx->major))) {
+		rcu_read_unlock();
+		return;
+	}
+
 	list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_EXIT], list) {
 		if (audit_in_mask(&e->rule, ctx->major) &&
 		    audit_filter_rules(tsk, &e->rule, ctx, NULL,
@@ -833,6 +857,25 @@ static void audit_filter_syscall(struct task_struct *tsk,
 	return;
 }
 
+static void audit_filter_dir(struct task_struct *tsk,
+				 struct audit_context *ctx)
+{
+	struct audit_entry *e;
+	enum audit_state state;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(e, &audit_filter_dir_list, list) {
+		if (audit_in_mask(&e->rule, ctx->major) &&
+			audit_filter_rules(tsk, &e->rule, ctx, NULL,
+				       &state, false)) {
+			rcu_read_unlock();
+			ctx->current_state = state;
+			return;
+		}
+	}
+	rcu_read_unlock();
+}
+
 /*
  * Given an audit_name check the inode hash table to see if they match.
  * Called holding the rcu read lock to protect the use of audit_inode_hash
@@ -1638,6 +1681,7 @@ void __audit_free(struct task_struct *tsk)
 		context->return_code = 0;
 
 		audit_filter_syscall(tsk, context);
+		audit_filter_dir(tsk, context);
 		audit_filter_inodes(tsk, context);
 		if (context->current_state == AUDIT_STATE_RECORD)
 			audit_log_exit();
@@ -1719,7 +1763,6 @@ void __audit_syscall_exit(int success, long return_code)
 
 	if (!list_empty(&context->killed_trees))
 		audit_kill_trees(context);
-
 	if (!context->dummy && context->in_syscall) {
 		if (success)
 			context->return_valid = AUDITSC_SUCCESS;
@@ -1745,6 +1788,7 @@ void __audit_syscall_exit(int success, long return_code)
 			context->return_code  = return_code;
 
 		audit_filter_syscall(current, context);
+		audit_filter_dir(current, context);
 		audit_filter_inodes(current, context);
 		if (context->current_state == AUDIT_STATE_RECORD)
 			audit_log_exit();
-- 
2.17.1

