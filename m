Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952B039EEC4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 08:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhFHGeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 02:34:04 -0400
Received: from forward102p.mail.yandex.net ([77.88.28.102]:60517 "EHLO
        forward102p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhFHGeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 02:34:03 -0400
Received: from sas1-e6291564df6f.qloud-c.yandex.net (sas1-e6291564df6f.qloud-c.yandex.net [IPv6:2a02:6b8:c08:1f2f:0:640:e629:1564])
        by forward102p.mail.yandex.net (Yandex) with ESMTP id B4E5554C2C18;
        Tue,  8 Jun 2021 09:32:09 +0300 (MSK)
Received: from sas1-37da021029ee.qloud-c.yandex.net (sas1-37da021029ee.qloud-c.yandex.net [2a02:6b8:c08:1612:0:640:37da:210])
        by sas1-e6291564df6f.qloud-c.yandex.net (mxback/Yandex) with ESMTP id AE2F0BRTOP-W9HeGqns;
        Tue, 08 Jun 2021 09:32:09 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1623133929;
        bh=LjwRoRtRKsKFTA1aw8ByWl0NLn9tabEE24zR2TV6+Ic=;
        h=In-Reply-To:Cc:To:From:Subject:Message-ID:References:Date;
        b=b1P8p6MhCRvNx488STtgn+ViFI6Swcy0uNqZS7xft7YYv8h443RGCxh2zQcO996nO
         obFIKn7Ms3IbFXSwMVMZJRTajElxfoxrTAfdtt0/MDgnGLJBqdJW33s9RTgdskfkWo
         G/NiZVbdzdC/HAYMlK+nNL1j/+ZA5A351nEP0Lac=
Authentication-Results: sas1-e6291564df6f.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas1-37da021029ee.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 3Lk4XWWBNf-W8L4vV3G;
        Tue, 08 Jun 2021 09:32:08 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Message-ID: <61bf645f5daec5f7096b0c23e5407edf4b3da8a1.camel@yandex.ru>
Subject: [PATCH v2] audit: Rename enum audit_state constants to avoid
 AUDIT_DISABLED redefinition
From:   Sergey Nazarov <s-nazarov@yandex.ru>
To:     Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Eric Paris <eparis@redhat.com>
Date:   Tue, 08 Jun 2021 09:32:06 +0300
In-Reply-To: <CAHC9VhS341s99jZ=rb90-hHmR2vfavhBANw_wL6oJp-hasST6Q@mail.gmail.com>
References: <ba47c2acb7bee9102bb6a85e9ba8b5918fa3610b.camel@yandex.ru>
         <CAHC9VhTvp3Z26JbXJdq8p4T7w3GZk-1CFWY328o75-AqqUbNTg@mail.gmail.com>
         <79d5bffd63b46bb7d54ebcef4765cfca28f76ff0.camel@yandex.ru>
         <CAHC9VhQfzx6xhZz+ghkRB2UKWHmsHKjLzz_7z3L47GHOoHLchw@mail.gmail.com>
         <20210607175058.GO447005@madcap2.tricolour.ca>
         <CAHC9VhS341s99jZ=rb90-hHmR2vfavhBANw_wL6oJp-hasST6Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
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
enum audit_state constants prefix AUDIT to AUDIT_STATE to avoid
AUDIT_DISABLED redefinition.

v2: the comments of Richard Guy Briggs and Paul Moore were taken into account

Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
---
 kernel/audit.h   |  8 ++++----
 kernel/auditsc.c | 34 +++++++++++++++++-----------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 1522e10..e518ad9 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -21,16 +21,16 @@
    a per-task filter.  At syscall entry, the audit_state is augmented by
    the syscall filter. */
 enum audit_state {
-	AUDIT_DISABLED,		/* Do not create per-task audit_context.
+	AUDIT_STATE_DISABLED,	/* Do not create per-task audit_context.
 				 * No syscall-specific audit records can
 				 * be generated. */
-	AUDIT_BUILD_CONTEXT,	/* Create the per-task audit_context,
+	AUDIT_STATE_BUILD,	/* Create the per-task audit_context,
 				 * and fill it in at syscall
 				 * entry time.  This makes a full
 				 * syscall record available if some
 				 * other part of the kernel decides it
 				 * should be recorded. */
-	AUDIT_RECORD_CONTEXT	/* Create the per-task audit_context,
+	AUDIT_STATE_RECORD	/* Create the per-task audit_context,
 				 * always fill it in at syscall entry
 				 * time, and always write out the audit
 				 * record at syscall exit time.  */
@@ -322,7 +322,7 @@ static inline int audit_signal_info_syscall(struct task_struct *t)
 	return 0;
 }
 
-#define audit_filter_inodes(t, c) AUDIT_DISABLED
+#define audit_filter_inodes(t, c) AUDIT_STATE_DISABLED
 #endif /* CONFIG_AUDITSYSCALL */
 
 extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 175ef6f..92ca5a2 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -231,7 +231,7 @@ static void audit_set_auditable(struct audit_context *ctx)
 {
 	if (!ctx->prio) {
 		ctx->prio = 1;
-		ctx->current_state = AUDIT_RECORD_CONTEXT;
+		ctx->current_state = AUDIT_STATE_RECORD;
 	}
 }
 
@@ -751,10 +751,10 @@ static int audit_filter_rules(struct task_struct *tsk,
 	}
 	switch (rule->action) {
 	case AUDIT_NEVER:
-		*state = AUDIT_DISABLED;
+		*state = AUDIT_STATE_DISABLED;
 		break;
 	case AUDIT_ALWAYS:
-		*state = AUDIT_RECORD_CONTEXT;
+		*state = AUDIT_STATE_RECORD;
 		break;
 	}
 	return 1;
@@ -773,14 +773,14 @@ static enum audit_state audit_filter_task(struct task_struct *tsk, char **key)
 	list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_TASK], list) {
 		if (audit_filter_rules(tsk, &e->rule, NULL, NULL,
 				       &state, true)) {
-			if (state == AUDIT_RECORD_CONTEXT)
+			if (state == AUDIT_STATE_RECORD)
 				*key = kstrdup(e->rule.filterkey, GFP_ATOMIC);
 			rcu_read_unlock();
 			return state;
 		}
 	}
 	rcu_read_unlock();
-	return AUDIT_BUILD_CONTEXT;
+	return AUDIT_STATE_BUILD;
 }
 
 static int audit_in_mask(const struct audit_krule *rule, unsigned long val)
@@ -802,7 +802,7 @@ static int audit_in_mask(const struct audit_krule *rule, unsigned long val)
 /* At syscall exit time, this filter is called if the audit_state is
  * not low enough that auditing cannot take place, but is also not
  * high enough that we already know we have to write an audit record
- * (i.e., the state is AUDIT_SETUP_CONTEXT or AUDIT_BUILD_CONTEXT).
+ * (i.e., the state is AUDIT_STATE_BUILD).
  */
 static void audit_filter_syscall(struct task_struct *tsk,
 				 struct audit_context *ctx)
@@ -923,7 +923,7 @@ static inline struct audit_context *audit_alloc_context(enum audit_state state)
 	if (!context)
 		return NULL;
 	context->state = state;
-	context->prio = state == AUDIT_RECORD_CONTEXT ? ~0ULL : 0;
+	context->prio = state == AUDIT_STATE_RECORD ? ~0ULL : 0;
 	INIT_LIST_HEAD(&context->killed_trees);
 	INIT_LIST_HEAD(&context->names_list);
 	context->fds[0] = -1;
@@ -950,7 +950,7 @@ int audit_alloc(struct task_struct *tsk)
 		return 0; /* Return if not auditing. */
 
 	state = audit_filter_task(tsk, &key);
-	if (state == AUDIT_DISABLED) {
+	if (state == AUDIT_STATE_DISABLED) {
 		clear_task_syscall_work(tsk, SYSCALL_AUDIT);
 		return 0;
 	}
@@ -1628,7 +1628,7 @@ void __audit_free(struct task_struct *tsk)
 
 		audit_filter_syscall(tsk, context);
 		audit_filter_inodes(tsk, context);
-		if (context->current_state == AUDIT_RECORD_CONTEXT)
+		if (context->current_state == AUDIT_STATE_RECORD)
 			audit_log_exit();
 	}
 
@@ -1647,7 +1647,7 @@ void __audit_free(struct task_struct *tsk)
  * Fill in audit context at syscall entry.  This only happens if the
  * audit context was created when the task was created and the state or
  * filters demand the audit context be built.  If the state from the
- * per-task filter or from the per-syscall filter is AUDIT_RECORD_CONTEXT,
+ * per-task filter or from the per-syscall filter is AUDIT_STATE_RECORD,
  * then the record will be written at syscall exit time (otherwise, it
  * will only be written if another part of the kernel requests that it
  * be written).
@@ -1664,11 +1664,11 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
 	BUG_ON(context->in_syscall || context->name_count);
 
 	state = context->state;
-	if (state == AUDIT_DISABLED)
+	if (state == AUDIT_STATE_DISABLED)
 		return;
 
 	context->dummy = !audit_n_rules;
-	if (!context->dummy && state == AUDIT_BUILD_CONTEXT) {
+	if (!context->dummy && state == AUDIT_STATE_BUILD) {
 		context->prio = 0;
 		if (auditd_test_task(current))
 			return;
@@ -1693,7 +1693,7 @@ void __audit_syscall_entry(int major, unsigned long a1, unsigned long a2,
  * @return_code: return value of the syscall
  *
  * Tear down after system call.  If the audit context has been marked as
- * auditable (either because of the AUDIT_RECORD_CONTEXT state from
+ * auditable (either because of the AUDIT_STATE_RECORD state from
  * filtering, or because some other part of the kernel wrote an audit
  * message), then write out the syscall information.  In call cases,
  * free the names stored from getname().
@@ -1735,12 +1735,12 @@ void __audit_syscall_exit(int success, long return_code)
 
 		audit_filter_syscall(current, context);
 		audit_filter_inodes(current, context);
-		if (context->current_state == AUDIT_RECORD_CONTEXT)
+		if (context->current_state == AUDIT_STATE_RECORD)
 			audit_log_exit();
 	}
 
 	context->in_syscall = 0;
-	context->prio = context->state == AUDIT_RECORD_CONTEXT ? ~0ULL : 0;
+	context->prio = context->state == AUDIT_STATE_RECORD ? ~0ULL : 0;
 
 	audit_free_module(context);
 	audit_free_names(context);
@@ -1753,7 +1753,7 @@ void __audit_syscall_exit(int success, long return_code)
 	context->sockaddr_len = 0;
 	context->type = 0;
 	context->fds[0] = -1;
-	if (context->state != AUDIT_RECORD_CONTEXT) {
+	if (context->state != AUDIT_STATE_RECORD) {
 		kfree(context->filterkey);
 		context->filterkey = NULL;
 	}
@@ -2203,7 +2203,7 @@ int auditsc_get_stamp(struct audit_context *ctx,
 	*serial    = ctx->serial;
 	if (!ctx->prio) {
 		ctx->prio = 1;
-		ctx->current_state = AUDIT_RECORD_CONTEXT;
+		ctx->current_state = AUDIT_STATE_RECORD;
 	}
 	return 1;
 }
-- 
1.8.3.1


