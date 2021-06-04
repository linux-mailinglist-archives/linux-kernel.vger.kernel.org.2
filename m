Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C41539B7D8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 13:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFDL2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 07:28:40 -0400
Received: from forward102p.mail.yandex.net ([77.88.28.102]:58921 "EHLO
        forward102p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229980AbhFDL2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:28:39 -0400
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jun 2021 07:28:39 EDT
Received: from myt6-22bd3499f8ff.qloud-c.yandex.net (myt6-22bd3499f8ff.qloud-c.yandex.net [IPv6:2a02:6b8:c12:239b:0:640:22bd:3499])
        by forward102p.mail.yandex.net (Yandex) with ESMTP id 96D4554C137D;
        Fri,  4 Jun 2021 14:21:33 +0300 (MSK)
Received: from myt5-aad1beefab42.qloud-c.yandex.net (myt5-aad1beefab42.qloud-c.yandex.net [2a02:6b8:c12:128:0:640:aad1:beef])
        by myt6-22bd3499f8ff.qloud-c.yandex.net (mxback/Yandex) with ESMTP id 6XSKJc0Nae-LXJCQrR4;
        Fri, 04 Jun 2021 14:21:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1622805693;
        bh=JKLhmQWnEKJ21xa8F2vcLR1FUuusP4GhUfA4vUdj76c=;
        h=Cc:To:From:Subject:Message-ID:Date;
        b=FMc6eluFgH/cRue3AMeBsLZ2Y69kqjZjyQ7jGY0TaqpQtfTEh/Jw/ahYhmkrvovJx
         g+ZbBr4aX+Cv8sJpDsWlSoFBrqA2wdH+8wh119+XK9RI4CD++/mvpj8CRZWGmcZhRU
         AGNBRZJDqn3SVU8FD+BvHnSpqGeU6fIAT1uy1Z8I=
Authentication-Results: myt6-22bd3499f8ff.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt5-aad1beefab42.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id APF8DOimYe-LWK8wb5l;
        Fri, 04 Jun 2021 14:21:32 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Message-ID: <ba47c2acb7bee9102bb6a85e9ba8b5918fa3610b.camel@yandex.ru>
Subject: [PATCH] audit: Rename enum audit_state constants to avoid
 AUDIT_DISABLED redefinition
From:   Sergey Nazarov <s-nazarov@yandex.ru>
To:     linux-kernel@vger.kernel.org
Cc:     linux-audit@redhat.com, eparis@redhat.com, paul@paul-moore.com
Date:   Fri, 04 Jun 2021 14:21:33 +0300
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AUDIT_DISABLED defined in kernel/audit.h as element of enum audit_state
and redefined in kernel/audit.c. This produces a warning when kernel builds
with syscalls audit disabled and brokes kernel build if -Werror used.
enum audit_state used in syscall audit code only. This patch changes
enum audit_state constants prefix AUDIT to AUDITSC to avoid AUDIT_DISABLED
redefinition.

Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
---
 kernel/audit.h   |  8 ++++----
 kernel/auditsc.c | 34 +++++++++++++++++-----------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 1522e10..ee81f20 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -21,16 +21,16 @@
    a per-task filter.  At syscall entry, the audit_state is augmented by
    the syscall filter. */
 enum audit_state {
-	AUDIT_DISABLED,		/* Do not create per-task audit_context.
+	AUDITSC_DISABLED,	/* Do not create per-task audit_context.
 				 * No syscall-specific audit records can
 				 * be generated. */
-	AUDIT_BUILD_CONTEXT,	/* Create the per-task audit_context,
+	AUDITSC_BUILD_CONTEXT,	/* Create the per-task audit_context,
 				 * and fill it in at syscall
 				 * entry time.  This makes a full
 				 * syscall record available if some
 				 * other part of the kernel decides it
 				 * should be recorded. */
-	AUDIT_RECORD_CONTEXT	/* Create the per-task audit_context,
+	AUDITSC_RECORD_CONTEXT	/* Create the per-task audit_context,
 				 * always fill it in at syscall entry
 				 * time, and always write out the audit
 				 * record at syscall exit time.  */
@@ -322,7 +322,7 @@ static inline int audit_signal_info_syscall(struct task_struct *t)
 	return 0;
 }
 
-#define audit_filter_inodes(t, c) AUDIT_DISABLED
+#define audit_filter_inodes(t, c) AUDITSC_DISABLED
 #endif /* CONFIG_AUDITSYSCALL */
 
 extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 175ef6f..ae6e305 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -231,7 +231,7 @@ static void audit_set_auditable(struct audit_context *ctx)
 {
 	if (!ctx->prio) {
 		ctx->prio = 1;
-		ctx->current_state = AUDIT_RECORD_CONTEXT;
+		ctx->current_state = AUDITSC_RECORD_CONTEXT;
 	}
 }
 
@@ -751,10 +751,10 @@ static int audit_filter_rules(struct task_struct *tsk,
 	}
 	switch (rule->action) {
 	case AUDIT_NEVER:
-		*state = AUDIT_DISABLED;
+		*state = AUDITSC_DISABLED;
 		break;
 	case AUDIT_ALWAYS:
-		*state = AUDIT_RECORD_CONTEXT;
+		*state = AUDITSC_RECORD_CONTEXT;
 		break;
 	}
 	return 1;
@@ -773,14 +773,14 @@ static enum audit_state audit_filter_task(struct task_struct *tsk, char **key)
 	list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_TASK], list) {
 		if (audit_filter_rules(tsk, &e->rule, NULL, NULL,
 				       &state, true)) {
-			if (state == AUDIT_RECORD_CONTEXT)
+			if (state == AUDITSC_RECORD_CONTEXT)
 				*key = kstrdup(e->rule.filterkey, GFP_ATOMIC);
 			rcu_read_unlock();
 			return state;
 		}
 	}
 	rcu_read_unlock();
-	return AUDIT_BUILD_CONTEXT;
+	return AUDITSC_BUILD_CONTEXT;
 }
 
 static int audit_in_mask(const struct audit_krule *rule, unsigned long val)
@@ -802,7 +802,7 @@ static int audit_in_mask(const struct audit_krule *rule, unsigned long val)
 /* At syscall exit time, this filter is called if the audit_state is
  * not low enough that auditing cannot take place, but is also not
  * high enough that we already know we have to write an audit record
- * (i.e., the state is AUDIT_SETUP_CONTEXT or AUDIT_BUILD_CONTEXT).
+ * (i.e., the state is AUDIT_SETUP_CONTEXT or AUDITSC_BUILD_CONTEXT).
  */
 static void audit_filter_syscall(struct task_struct *tsk,
 				 struct audit_context *ctx)
@@ -923,7 +923,7 @@ static inline struct audit_context *audit_alloc_context(enum audit_state state)
 	if (!context)
 		return NULL;
 	context->state = state;
-	context->prio = state == AUDIT_RECORD_CONTEXT ? ~0ULL : 0;
+	context->prio = state == AUDITSC_RECORD_CONTEXT ? ~0ULL : 0;
 	INIT_LIST_HEAD(&context->killed_trees);
 	INIT_LIST_HEAD(&context->names_list);
 	context->fds[0] = -1;
@@ -950,7 +950,7 @@ int audit_alloc(struct task_struct *tsk)
 		return 0; /* Return if not auditing. */
 
 	state = audit_filter_task(tsk, &key);
-	if (state == AUDIT_DISABLED) {
+	if (state == AUDITSC_DISABLED) {
 		clear_task_syscall_work(tsk, SYSCALL_AUDIT);
 		return 0;
 	}
@@ -1628,7 +1628,7 @@ void __audit_free(struct task_struct *tsk)
 
 		audit_filter_syscall(tsk, context);
 		audit_filter_inodes(tsk, context);
-		if (context->current_state == AUDIT_RECORD_CONTEXT)
+		if (context->current_state == AUDITSC_RECORD_CONTEXT)
 			audit_log_exit();
 	}
 
@@ -1647,7 +1647,7 @@ void __audit_free(struct task_struct *tsk)
  * Fill in audit context at syscall entry.  This only happens if the
  * audit context was created when the task was created and the state or
  * filters demand the audit context be built.  If the state from the
- * per-task filter or from the per-syscall filter is AUDIT_RECORD_CONTEXT,
+ * per-task filter or from the per-syscall filter is AUDITSC_RECORD_CONTEXT,
  * then the record will be written at syscall exit time (otherwise, it
  * will only be written if another part of the kernel requests that it
  * be written).
@@ -1664,11 +1664,11 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 	BUG_ON(context->in_syscall || context->name_count);
 
 	state = context->state;
-	if (state == AUDIT_DISABLED)
+	if (state == AUDITSC_DISABLED)
 		return;
 
 	context->dummy = !audit_n_rules;
-	if (!context->dummy && state == AUDIT_BUILD_CONTEXT) {
+	if (!context->dummy && state == AUDITSC_BUILD_CONTEXT) {
 		context->prio = 0;
 		if (auditd_test_task(current))
 			return;
@@ -1693,7 +1693,7 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
  * @return_code: return value of the syscall
  *
  * Tear down after system call.  If the audit context has been marked as
- * auditable (either because of the AUDIT_RECORD_CONTEXT state from
+ * auditable (either because of the AUDITSC_RECORD_CONTEXT state from
  * filtering, or because some other part of the kernel wrote an audit
  * message), then write out the syscall information.  In call cases,
  * free the names stored from getname().
@@ -1735,12 +1735,12 @@ void __audit_syscall_exit(int success, long return_code)
 
 		audit_filter_syscall(current, context);
 		audit_filter_inodes(current, context);
-		if (context->current_state == AUDIT_RECORD_CONTEXT)
+		if (context->current_state == AUDITSC_RECORD_CONTEXT)
 			audit_log_exit();
 	}
 
 	context->in_syscall = 0;
-	context->prio = context->state == AUDIT_RECORD_CONTEXT ? ~0ULL : 0;
+	context->prio = context->state == AUDITSC_RECORD_CONTEXT ? ~0ULL : 0;
 
 	audit_free_module(context);
 	audit_free_names(context);
@@ -1753,7 +1753,7 @@ void __audit_syscall_exit(int success, long return_code)
 	context->sockaddr_len = 0;
 	context->type = 0;
 	context->fds[0] = -1;
-	if (context->state != AUDIT_RECORD_CONTEXT) {
+	if (context->state != AUDITSC_RECORD_CONTEXT) {
 		kfree(context->filterkey);
 		context->filterkey = NULL;
 	}
@@ -2203,7 +2203,7 @@ int auditsc_get_stamp(struct audit_context *ctx,
 	*serial    = ctx->serial;
 	if (!ctx->prio) {
 		ctx->prio = 1;
-		ctx->current_state = AUDIT_RECORD_CONTEXT;
+		ctx->current_state = AUDITSC_RECORD_CONTEXT;
 	}
 	return 1;
 }
-- 
1.8.3.1


