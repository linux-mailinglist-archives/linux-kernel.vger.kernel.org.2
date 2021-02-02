Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FA130CDF2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 22:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhBBVa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 16:30:28 -0500
Received: from alln-iport-2.cisco.com ([173.37.142.89]:53380 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbhBBVaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 16:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=6057; q=dns/txt; s=iport;
  t=1612301414; x=1613511014;
  h=from:to:cc:subject:date:message-id;
  bh=cU4a1znY1ukkTf/2iG9CGNc3UPh/DzBHLERaMKhtcQ4=;
  b=kax/TNw61Qzm717nHGGMkVhivOJmr/hihswLpZaa8zHseQbCxLNHLEBT
   jamndh8MRyAd9UYJTOjy5h+IhFVOGqLw1H4IRpJa9ttU6E3g+qymamwqx
   MXT+Exi0wsQetsxYIMeGlwlVjr9wnNmtmeHAZvAUe1Ib620oyZ8Na+yMs
   Q=;
X-IronPort-AV: E=Sophos;i="5.79,396,1602547200"; 
   d="scan'208";a="663080871"
Received: from rcdn-core-7.cisco.com ([173.37.93.143])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 02 Feb 2021 21:29:32 +0000
Received: from zorba.cisco.com ([10.24.3.200])
        by rcdn-core-7.cisco.com (8.15.2/8.15.2) with ESMTP id 112LTUJ7026870;
        Tue, 2 Feb 2021 21:29:31 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Cc:     Phil Zhang <xuanyzha@cisco.com>, xe-linux-external@cisco.com,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] audit: show (grand)parents information of an audit context
Date:   Tue,  2 Feb 2021 13:29:29 -0800
Message-Id: <20210202212930.18845-2-danielwa@cisco.com>
X-Mailer: git-send-email 2.17.1
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.3.200, [10.24.3.200]
X-Outbound-Node: rcdn-core-7.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Zhang <xuanyzha@cisco.com>

To ease the root cause analysis of SELinux AVCs, this new feature
traverses task structs to iteratively find all parent processes
starting with the denied process and ending at the kernel. Meanwhile,
it prints out the command lines and subject contexts of those parents.

This provides developers a clear view of how processes were spawned
and where transitions happened, without the need to reproduce the
issue and manually audit interesting events.

Example on bash over ssh:
    $ runcon -u system_u -r system_r -t polaris_hm_t ls
    ...
    type=PARENT msg=audit(1610548241.033:255): subj=root:unconfined_r:unconfined_t:s0-s0:c0.c1023  cmdline="-bash"
    type=PARENT msg=audit(1610548241.033:255): subj=system_u:system_r:sshd_t:s0-s0:c0.c1023        cmdline="sshd: root@pts/0"
    type=PARENT msg=audit(1610548241.033:255): subj=system_u:system_r:sshd_t:s0-s0:c0.c1023        cmdline="/tmp/sw/rp/0/0/rp_security/mount/usr/sbin/sshd
    type=PARENT msg=audit(1610548241.033:255): subj=system_u:system_r:init_t:s0                    cmdline="/init"
    type=PARENT msg=audit(1610548241.033:255): subj=system_u:system_r:kernel_t:s0
    ...

Cc: xe-linux-external@cisco.com
Signed-off-by: Phil Zhang <xuanyzha@cisco.com>
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 include/uapi/linux/audit.h |  5 ++-
 init/Kconfig               |  7 +++++
 kernel/audit.c             |  3 +-
 kernel/auditsc.c           | 64 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 7bea44b1c028..8f1a2880b198 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -119,6 +119,7 @@
 #define AUDIT_BPF		1334	/* BPF subsystem */
 #define AUDIT_EVENT_LISTENER	1335	/* Task joined multicast read socket */
 #define AUDIT_UBACKTRACE	1336	/* User land backtrace */
+#define AUDIT_PARENT		1340    /* Process Parent emit event */
 
 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
@@ -485,7 +486,9 @@ struct audit_features {
 #define AUDIT_FEATURE_ONLY_UNSET_LOGINUID	0
 #define AUDIT_FEATURE_LOGINUID_IMMUTABLE	1
 #define AUDIT_FEATURE_UBACKTRACE_CONTEXT	2
-#define AUDIT_LAST_FEATURE			AUDIT_FEATURE_UBACKTRACE_CONTEXT
+#define AUDIT_FEATURE_LIST_PARENTS		3
+#define AUDIT_LAST_FEATURE			AUDIT_FEATURE_LIST_PARENTS
+
 
 #define audit_feature_valid(x)		((x) >= 0 && (x) <= AUDIT_LAST_FEATURE)
 #define AUDIT_FEATURE_TO_MASK(x)	(1 << ((x) & 31)) /* mask for __u32 */
diff --git a/init/Kconfig b/init/Kconfig
index 4327a8afb1f9..2dbc1c2aa833 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -446,6 +446,13 @@ config AUDIT_USER_BACKTRACE_SIZE
         depends on AUDIT_USER_BACKTRACE
         default 40
 
+config AUDIT_LIST_PARENTS
+	bool "Displaying parent processes in audit context messages"
+	def_bool n
+	depends on AUDITSYSCALL
+	help
+	  Capture contexts and cmdlines of parent processes when auditing syscalls
+
 source "kernel/irq/Kconfig"
 source "kernel/time/Kconfig"
 source "kernel/Kconfig.preempt"
diff --git a/kernel/audit.c b/kernel/audit.c
index 4608cddb4bb9..834adc462f47 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -165,10 +165,11 @@ static struct audit_features af = {.vers = AUDIT_FEATURE_VERSION,
 				   .features = 0,
 				   .lock = 0,};
 
-static char *audit_feature_names[3] = {
+static char *audit_feature_names[4] = {
 	"only_unset_loginuid",
 	"loginuid_immutable",
 	"ubacktrace_context",
+	"list_parents",
 };
 
 /**
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index d048b01345b8..c27e9f928bf1 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -96,6 +96,10 @@
 /* number of audit rules */
 int audit_n_rules;
 
+/* max length of per audit entry and max number of entries */
+#define MAX_PARENT_AUDIT_LEN 256
+#define MAX_PARENT_ENTRY_CNT 16
+
 /* determines whether we collect data for signals sent */
 int audit_signals;
 
@@ -1472,6 +1476,61 @@ static void audit_log_proctitle(void)
 	audit_log_end(ab);
 }
 
+static void audit_log_parents(void)
+{
+	int res, len, item_cnt;
+	u32 sid;
+	char *buf;
+	char *ctx = NULL;
+	struct audit_context *context = audit_context();
+	struct audit_buffer *ab;
+	struct task_struct *task_iter;
+
+	if (!context || context->dummy)
+		return;
+
+	buf = kmalloc(MAX_PARENT_AUDIT_LEN, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	rcu_read_lock();
+	task_iter = rcu_dereference(current->real_parent);
+	for (item_cnt = 0; item_cnt < MAX_PARENT_ENTRY_CNT; ++item_cnt) {
+		ab = audit_log_start(context, GFP_ATOMIC, AUDIT_PARENT);
+		if (!ab)
+			break;
+
+		// get subject context
+		security_task_getsecid(task_iter, &sid);
+		if (sid) {
+			res = security_secid_to_secctx(sid, &ctx, &len);
+			if (!res) {
+				audit_log_format(ab, "subj=%-60s", ctx);
+				security_release_secctx(ctx, len);
+			}
+		}
+
+		// get cmdline
+		res = get_cmdline(task_iter, buf, MAX_PARENT_AUDIT_LEN);
+		if (res) {
+			res = audit_proctitle_rtrim(buf, res);
+			if (res) {
+				audit_log_format(ab, " proctitle=");
+				audit_log_n_untrustedstring(ab, buf, res);
+			}
+		}
+
+		audit_log_end(ab);
+
+		if (task_iter == task_iter->real_parent)
+			break;
+		task_iter = rcu_dereference(task_iter->real_parent);
+	}
+	rcu_read_unlock();
+
+	kfree(buf);
+}
+
 #ifdef CONFIG_AUDIT_USER_BACKTRACE
 static void audit_log_print_backtrace(struct audit_buffer *ab,
 				      struct task_struct *tsk,
@@ -1682,6 +1741,11 @@ static void audit_log_exit(void)
 
 	audit_log_proctitle();
 
+#ifdef CONFIG_AUDIT_LIST_PARENTS
+	if (is_audit_feature_set(AUDIT_FEATURE_LIST_PARENTS))
+		audit_log_parents();
+#endif /* CONFIG_AUDIT_LIST_PARENTS */
+
 #ifdef CONFIG_AUDIT_USER_BACKTRACE
 	if (is_audit_feature_set(AUDIT_FEATURE_UBACKTRACE_CONTEXT))
 		audit_log_ubacktrace(current, context);
-- 
2.17.1

