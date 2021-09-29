Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B060D41C3C8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 13:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245234AbhI2Lw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 07:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240310AbhI2Lwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:52:55 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FDEC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 04:51:14 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id k23so1498399pji.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 04:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S2OaPG8/7fF3rtmUVNXxWXTYqMoOF9a3XvSWYEuzZ0k=;
        b=DnnB6AbkA/raI5k7P4bPBvrM0ZkVDQFHG/OBCk6d8B46kcY0eo1PNsC6yhAAKwi6Gi
         vq0uv34rOs8CRG5nNJodTzzn//1gL5Sm1Lb7M/FJWORRlASQ4vP3Mu4LxCbFDOQlh7Gq
         6iuuVtuUWJmWAVeGWaZc+B2vzOsyCA183ABrbWrleLo/qj0sFOA++zieqGi7oKOmM7Fq
         c+11ejNfRQBxz1Q1AYezbPBKcAvcIgBvxYfyfIp/MnSUVXjAzMOl7RgMbgp0BLFNs/cz
         57EwNPv5h6D9qRxJm9ii8ZZNqHJ3w8yPX7OSdJJmy7Wsf4W/qeLVe/UJooFqQhcU8m+j
         HLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S2OaPG8/7fF3rtmUVNXxWXTYqMoOF9a3XvSWYEuzZ0k=;
        b=l/JEQXZs06G1kYWsEgrJ7HQtyHbjQgGjLvweL4UnfX4jyEibVPjbPCeP4g9xjmFsXK
         S3CYe/h4FrJkBHuEU5NAmVUadDGfGIWpV3F3gp1q+gu8zOIyqoF5pYzAufgXZfJ76m9o
         Wxm5+fntQjVHOAAlmpqmApgFoW44gemr5Ycj739o7Uo4fmYq8pMEJyeecQJnBZaKb20o
         0J562VVPQiEOBWh2YUxNLBnbv9Eqqax3z2rldRWT7dkVEp9EUr37n8+TQ1sQD9Fa9fQR
         S2MPaKmM1HMlFV/hvzqwG0pedJkNtahvKQzXwyu6w2nplK2w+0palxsYnzm5wPFI1hQS
         UwqQ==
X-Gm-Message-State: AOAM532S4aV7NegIx3e86fkGW9oyusmQZ8KEkZvmEuNwJIGZ4jrxXB4p
        jaZUpCepc48FPrKSDiHwdpY=
X-Google-Smtp-Source: ABdhPJz6XeBXecEwJibQs9iYUHjKyV8LNz98oSJ7S9pWabu/Z/e4v7BENd9rBjb4Z7T7GBHObDvEFw==
X-Received: by 2002:a17:90a:1a4c:: with SMTP id 12mr5997307pjl.89.1632916274331;
        Wed, 29 Sep 2021 04:51:14 -0700 (PDT)
Received: from localhost.localdomain ([144.202.123.152])
        by smtp.gmail.com with ESMTPSA id u12sm2403204pgi.21.2021.09.29.04.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 04:51:13 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     akpm@linux-foundation.org, pmladek@suse.com, peterz@infradead.org,
        valentin.schneider@arm.com, keescook@chromium.org,
        mathieu.desnoyers@efficios.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, viro@zeniv.linux.org.uk,
        christian@brauner.io, dietmar.eggemann@arm.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 1/5] kernel: replace sizeof(task->comm) with TASK_COMM_LEN
Date:   Wed, 29 Sep 2021 11:50:32 +0000
Message-Id: <20210929115036.4851-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210929115036.4851-1-laoar.shao@gmail.com>
References: <20210929115036.4851-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use TASK_COMM_LEN directly instread of sizeof(task->comm).

This patch also replace strlcpy with strscpy, to fix the warning by
checkpatch -
WARNING: Prefer strscpy over strlcpy - see: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 arch/ia64/kernel/mca.c         | 6 +++---
 drivers/block/drbd/drbd_main.c | 2 +-
 drivers/hwtracing/stm/core.c   | 2 +-
 drivers/tty/tty_audit.c        | 2 +-
 fs/exec.c                      | 2 +-
 kernel/audit.c                 | 4 ++--
 kernel/auditsc.c               | 4 ++--
 kernel/capability.c            | 4 ++--
 kernel/futex.c                 | 2 +-
 kernel/sys.c                   | 2 +-
 kernel/trace/blktrace.c        | 2 +-
 security/lsm_audit.c           | 4 ++--
 security/selinux/selinuxfs.c   | 2 +-
 security/yama/yama_lsm.c       | 2 +-
 sound/core/oss/pcm_oss.c       | 2 +-
 15 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index e628a88607bb..4ee86e91ff5e 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -875,7 +875,7 @@ copy_reg(const u64 *fr, u64 fnat, unsigned long *tr, unsigned long *tnat)
 static void
 ia64_mca_modify_comm(const struct task_struct *previous_current)
 {
-	char *p, comm[sizeof(current->comm)];
+	char *p, comm[TASK_COMM_LEN];
 	if (previous_current->pid)
 		snprintf(comm, sizeof(comm), "%s %d",
 			current->comm, previous_current->pid);
@@ -889,7 +889,7 @@ ia64_mca_modify_comm(const struct task_struct *previous_current)
 			current->comm, l, previous_current->comm,
 			task_thread_info(previous_current)->cpu);
 	}
-	memcpy(current->comm, comm, sizeof(current->comm));
+	memcpy(current->comm, comm, TASK_COMM_LEN);
 }
 
 static void
@@ -1794,7 +1794,7 @@ format_mca_init_stack(void *mca_data, unsigned long offset,
 	p->parent = p->real_parent = p->group_leader = p;
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
-	strncpy(p->comm, type, sizeof(p->comm)-1);
+	strncpy(p->comm, type, TASK_COMM_LEN-1);
 }
 
 /* Caller prevents this from being called after init */
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 55234a558e98..a7cf062e76ab 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -306,7 +306,7 @@ static int drbd_thread_setup(void *arg)
 	unsigned long flags;
 	int retval;
 
-	snprintf(current->comm, sizeof(current->comm), "drbd_%c_%s",
+	snprintf(current->comm, TASK_COMM_LEN, "drbd_%c_%s",
 		 thi->name[0],
 		 resource->name);
 
diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 2712e699ba08..8ec0a34a9ba6 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -631,7 +631,7 @@ static ssize_t stm_char_write(struct file *file, const char __user *buf,
 	 * point, try to use the task name and "default" policy entries.
 	 */
 	if (!stmf->output.nr_chans) {
-		char comm[sizeof(current->comm)];
+		char comm[TASK_COMM_LEN];
 		char *ids[] = { comm, "default", NULL };
 
 		get_task_comm(comm, current);
diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
index ca7afd7b2716..b98b1aef5f6f 100644
--- a/drivers/tty/tty_audit.c
+++ b/drivers/tty/tty_audit.c
@@ -69,7 +69,7 @@ static void tty_audit_log(const char *description, dev_t dev,
 
 	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_TTY);
 	if (ab) {
-		char name[sizeof(current->comm)];
+		char name[TASK_COMM_LEN];
 
 		audit_log_format(ab, "%s pid=%u uid=%u auid=%u ses=%u major=%d"
 				 " minor=%d comm=", description, pid, uid,
diff --git a/fs/exec.c b/fs/exec.c
index a098c133d8d7..021c9dc727bc 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1224,7 +1224,7 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
 {
 	task_lock(tsk);
 	trace_task_rename(tsk, buf);
-	strlcpy(tsk->comm, buf, sizeof(tsk->comm));
+	strscpy(tsk->comm, buf, TASK_COMM_LEN);
 	task_unlock(tsk);
 	perf_event_comm(tsk, exec);
 }
diff --git a/kernel/audit.c b/kernel/audit.c
index 121d37e700a6..1fbd036e77be 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1549,7 +1549,7 @@ static void audit_log_multicast(int group, const char *op, int err)
 {
 	const struct cred *cred;
 	struct tty_struct *tty;
-	char comm[sizeof(current->comm)];
+	char comm[TASK_COMM_LEN];
 	struct audit_buffer *ab;
 
 	if (!audit_enabled)
@@ -2192,7 +2192,7 @@ void audit_put_tty(struct tty_struct *tty)
 void audit_log_task_info(struct audit_buffer *ab)
 {
 	const struct cred *cred;
-	char comm[sizeof(current->comm)];
+	char comm[TASK_COMM_LEN];
 	struct tty_struct *tty;
 
 	if (!ab)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 8dd73a64f921..295376d7d926 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2595,7 +2595,7 @@ void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
 		       enum audit_nfcfgop op, gfp_t gfp)
 {
 	struct audit_buffer *ab;
-	char comm[sizeof(current->comm)];
+	char comm[TASK_COMM_LEN];
 
 	ab = audit_log_start(audit_context(), gfp, AUDIT_NETFILTER_CFG);
 	if (!ab)
@@ -2616,7 +2616,7 @@ static void audit_log_task(struct audit_buffer *ab)
 	kuid_t auid, uid;
 	kgid_t gid;
 	unsigned int sessionid;
-	char comm[sizeof(current->comm)];
+	char comm[TASK_COMM_LEN];
 
 	auid = audit_get_loginuid(current);
 	sessionid = audit_get_sessionid(current);
diff --git a/kernel/capability.c b/kernel/capability.c
index 46a361dde042..4033ee837f63 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -45,7 +45,7 @@ __setup("no_file_caps", file_caps_disable);
 
 static void warn_legacy_capability_use(void)
 {
-	char name[sizeof(current->comm)];
+	char name[TASK_COMM_LEN];
 
 	pr_info_once("warning: `%s' uses 32-bit capabilities (legacy support in use)\n",
 		     get_task_comm(name, current));
@@ -69,7 +69,7 @@ static void warn_legacy_capability_use(void)
 
 static void warn_deprecated_v2(void)
 {
-	char name[sizeof(current->comm)];
+	char name[TASK_COMM_LEN];
 
 	pr_info_once("warning: `%s' uses deprecated v2 capabilities in a way that may be insecure\n",
 		     get_task_comm(name, current));
diff --git a/kernel/futex.c b/kernel/futex.c
index c15ad276fd15..6cd08156611e 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1703,7 +1703,7 @@ static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
 
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28)) {
 		if (oparg < 0 || oparg > 31) {
-			char comm[sizeof(current->comm)];
+			char comm[TASK_COMM_LEN];
 			/*
 			 * kill this print and return -EINVAL when userspace
 			 * is sane again
diff --git a/kernel/sys.c b/kernel/sys.c
index 8fdac0d90504..bea1120c5579 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2265,7 +2265,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		unsigned long, arg4, unsigned long, arg5)
 {
 	struct task_struct *me = current;
-	unsigned char comm[sizeof(me->comm)];
+	unsigned char comm[TASK_COMM_LEN];
 	long error;
 
 	error = security_task_prctl(option, arg2, arg3, arg4, arg5);
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index c221e4c3f625..009f77ebda5a 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -124,7 +124,7 @@ static void trace_note_tsk(struct task_struct *tsk)
 	spin_lock_irqsave(&running_trace_lock, flags);
 	list_for_each_entry(bt, &running_trace_list, running_list) {
 		trace_note(bt, tsk->pid, BLK_TN_PROCESS, tsk->comm,
-			   sizeof(tsk->comm), 0);
+			   TASK_COMM_LEN, 0);
 	}
 	spin_unlock_irqrestore(&running_trace_lock, flags);
 }
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 5a5016ef43b0..eec54cb48845 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -208,7 +208,7 @@ static inline void print_ipv4_addr(struct audit_buffer *ab, __be32 addr,
 static void dump_common_audit_data(struct audit_buffer *ab,
 				   struct common_audit_data *a)
 {
-	char comm[sizeof(current->comm)];
+	char comm[TASK_COMM_LEN];
 
 	/*
 	 * To keep stack sizes in check force programers to notice if they
@@ -310,7 +310,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		if (tsk) {
 			pid_t pid = task_tgid_nr(tsk);
 			if (pid) {
-				char comm[sizeof(tsk->comm)];
+				char comm[TASK_COMM_LEN];
 				audit_log_format(ab, " opid=%d ocomm=", pid);
 				audit_log_untrustedstring(ab,
 				    memcpy(comm, tsk->comm, sizeof(comm)));
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index e4cd7cb856f3..e529db76502d 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -752,7 +752,7 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 		goto out;
 
 	if (new_value) {
-		char comm[sizeof(current->comm)];
+		char comm[TASK_COMM_LEN];
 
 		memcpy(comm, current->comm, sizeof(comm));
 		pr_warn_once("SELinux: %s (%d) set checkreqprot to 1. This is deprecated and will be rejected in a future kernel release.\n",
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 06e226166aab..178d7a138e98 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -75,7 +75,7 @@ static void report_access(const char *access, struct task_struct *target,
 				struct task_struct *agent)
 {
 	struct access_report_info *info;
-	char agent_comm[sizeof(agent->comm)];
+	char agent_comm[TASK_COMM_LEN];
 
 	assert_spin_locked(&target->alloc_lock); /* for target->comm */
 
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 82a818734a5f..d541530236e1 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -2460,7 +2460,7 @@ static int snd_task_name(struct task_struct *task, char *name, size_t size)
 
 	if (snd_BUG_ON(!task || !name || size < 2))
 		return -EINVAL;
-	for (idx = 0; idx < sizeof(task->comm) && idx + 1 < size; idx++)
+	for (idx = 0; idx < TASK_COMM_LEN && idx + 1 < size; idx++)
 		name[idx] = task->comm[idx];
 	name[idx] = '\0';
 	return 0;
-- 
2.17.1

