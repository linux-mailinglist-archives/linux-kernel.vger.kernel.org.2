Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D8830CDF1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 22:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhBBVaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 16:30:17 -0500
Received: from alln-iport-7.cisco.com ([173.37.142.94]:45062 "EHLO
        alln-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhBBVaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 16:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=7524; q=dns/txt; s=iport;
  t=1612301412; x=1613511012;
  h=from:to:cc:subject:date:message-id;
  bh=cwyA8Kb6bWWwQ4qJ9GJax7pdT06XlExyYprhdCyOZOQ=;
  b=LH9YRSoj1yY1KQTNiLXe7eHrUbgq4KWq9FTjIDmrVJsdDoWOcqyijFDz
   cjhfn+BF/YMACL0cv5RV2cPzt6YY3gmAk10de1TfAWy+Ec67Ui4sC5KuN
   Y7jno4Am9UCdFdC0jujwL3+Oc8nn+VwiG4V+60pzhjmrcc67rX7hIG90k
   Y=;
X-IronPort-AV: E=Sophos;i="5.79,396,1602547200"; 
   d="scan'208";a="639763896"
Received: from rcdn-core-7.cisco.com ([173.37.93.143])
  by alln-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 02 Feb 2021 21:29:31 +0000
Received: from zorba.cisco.com ([10.24.3.200])
        by rcdn-core-7.cisco.com (8.15.2/8.15.2) with ESMTP id 112LTUJ6026870;
        Tue, 2 Feb 2021 21:29:30 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Cc:     Victor Kamensky <kamensky@cisco.com>, xe-linux-external@cisco.com,
        Ruslan Bilovol <rbilovol@cisco.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] audit: show user land backtrace as part of audit context messages
Date:   Tue,  2 Feb 2021 13:29:28 -0800
Message-Id: <20210202212930.18845-1-danielwa@cisco.com>
X-Mailer: git-send-email 2.17.1
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.3.200, [10.24.3.200]
X-Outbound-Node: rcdn-core-7.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Kamensky <kamensky@cisco.com>

To efficiently find out where SELinux AVC denial is comming from
take backtrace of user land process and display it as type=UBACKTRACE
message that comes as audit context for SELinux AVC and other audit
messages.

By default UBACKTRACE context messages are off. Needs to be enabled
through audit AUDIT_FEATURE_UBACKTRACE_CONTEXT feature.

Context UBACKTRACE message example:
type=UBACKTRACE msg=audit(1574205625.557:30): backtrace=libc-2.30.so+0xc99ab:dmesg.util-linux+0x1483:libc-2.30.so+0x1e35:dmesg.util-linux+0x1e5a

I.e because of ASLR instead of absolute user land addresses, name
of executable or library captured and followed by offset from text
segment vma. To decode backtrace entry: find executable or library
symbol file, find its text segment vma and add offset to it; run
'addr2line -f -e symbol_file resulting_address'.

Note feature depends on PERF_EVENTS, from perf subsystem it uses
perf_callchain_user function on architectures where it is implemented.
And it has the same capturing restriction as 'perf -g': user land code
must be compiled with -fno-omit-frame-pointer option, otherwise kernel
is not capable walk user land stack frames.

Cc: xe-linux-external@cisco.com
Signed-off-by: Victor Kamensky <kamensky@cisco.com>
Signed-off-by: Ruslan Bilovol <rbilovol@cisco.com>
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 include/uapi/linux/audit.h |  6 ++-
 init/Kconfig               | 13 ++++++
 kernel/audit.c             |  3 +-
 kernel/auditsc.c           | 93 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index cd2d8279a5e4..7bea44b1c028 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -118,6 +118,7 @@
 #define AUDIT_TIME_ADJNTPVAL	1333	/* NTP value adjustment */
 #define AUDIT_BPF		1334	/* BPF subsystem */
 #define AUDIT_EVENT_LISTENER	1335	/* Task joined multicast read socket */
+#define AUDIT_UBACKTRACE	1336	/* User land backtrace */
 
 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
@@ -474,7 +475,7 @@ struct audit_status {
 };
 
 struct audit_features {
-#define AUDIT_FEATURE_VERSION	1
+#define AUDIT_FEATURE_VERSION	2
 	__u32	vers;
 	__u32	mask;		/* which bits we are dealing with */
 	__u32	features;	/* which feature to enable/disable */
@@ -483,7 +484,8 @@ struct audit_features {
 
 #define AUDIT_FEATURE_ONLY_UNSET_LOGINUID	0
 #define AUDIT_FEATURE_LOGINUID_IMMUTABLE	1
-#define AUDIT_LAST_FEATURE			AUDIT_FEATURE_LOGINUID_IMMUTABLE
+#define AUDIT_FEATURE_UBACKTRACE_CONTEXT	2
+#define AUDIT_LAST_FEATURE			AUDIT_FEATURE_UBACKTRACE_CONTEXT
 
 #define audit_feature_valid(x)		((x) >= 0 && (x) <= AUDIT_LAST_FEATURE)
 #define AUDIT_FEATURE_TO_MASK(x)	(1 << ((x) & 31)) /* mask for __u32 */
diff --git a/init/Kconfig b/init/Kconfig
index b77c60f8b963..4327a8afb1f9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -433,6 +433,19 @@ config AUDITSYSCALL
 	depends on AUDIT && HAVE_ARCH_AUDITSYSCALL
 	select FSNOTIFY
 
+config AUDIT_USER_BACKTRACE
+        bool "Enable user land backtrace in audit context messages"
+        def_bool n
+        depends on AUDITSYSCALL && PERF_EVENTS
+        help
+          Enable UBACKTRACE audit context messages, capturing backtrace of
+          user land process causing the message.
+
+config AUDIT_USER_BACKTRACE_SIZE
+        int "Maximum size of user land backtrace entries captured in UBACKTACE"
+        depends on AUDIT_USER_BACKTRACE
+        default 40
+
 source "kernel/irq/Kconfig"
 source "kernel/time/Kconfig"
 source "kernel/Kconfig.preempt"
diff --git a/kernel/audit.c b/kernel/audit.c
index 1ffc2e059027..4608cddb4bb9 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -165,9 +165,10 @@ static struct audit_features af = {.vers = AUDIT_FEATURE_VERSION,
 				   .features = 0,
 				   .lock = 0,};
 
-static char *audit_feature_names[2] = {
+static char *audit_feature_names[3] = {
 	"only_unset_loginuid",
 	"loginuid_immutable",
+	"ubacktrace_context",
 };
 
 /**
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ce8c9e2279ba..d048b01345b8 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -67,6 +67,7 @@
 #include <linux/highmem.h>
 #include <linux/syscalls.h>
 #include <asm/syscall.h>
+#include <linux/mmap_lock.h>
 #include <linux/capability.h>
 #include <linux/fs_struct.h>
 #include <linux/compat.h>
@@ -74,6 +75,7 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/fsnotify_backend.h>
+#include <linux/perf_event.h>
 #include <uapi/linux/limits.h>
 #include <uapi/linux/netfilter/nf_tables.h>
 
@@ -1470,6 +1472,92 @@ static void audit_log_proctitle(void)
 	audit_log_end(ab);
 }
 
+#ifdef CONFIG_AUDIT_USER_BACKTRACE
+static void audit_log_print_backtrace(struct audit_buffer *ab,
+				      struct task_struct *tsk,
+				      struct perf_callchain_entry *entry)
+{
+	struct mm_struct *mm;
+	const struct vm_area_struct *vma;
+	struct file *file;
+	const char *filename;
+	unsigned long vmstart;
+	int i;
+
+	audit_log_format(ab, "backtrace=");
+
+	mm = tsk->mm;
+	mmap_write_lock(mm);
+	for (i = 0; i < entry->nr; i++) {
+		vma = find_vma(mm, entry->ip[i]);
+		if (vma && (vma->vm_flags & VM_EXEC)) {
+			file = vma->vm_file;
+			vmstart = vma->vm_start;
+
+			if (file && file->f_path.dentry) {
+				filename = file->f_path.dentry->d_name.name;
+			} else {
+				filename = "";
+			}
+
+			if (i == 0) {
+				audit_log_format(ab, "%s+0x%llx",
+						 filename,
+						 entry->ip[i] - vmstart);
+			} else {
+				audit_log_format(ab, ":%s+0x%llx",
+						 filename,
+						 entry->ip[i] - vmstart);
+			}
+		} else {
+			/* No corresponding executable vma, assume garbage entry */
+			break;
+		}
+	}
+	mmap_write_unlock(mm);
+}
+
+static void audit_log_ubacktrace(struct task_struct *tsk,
+				 struct audit_context *context)
+{
+	struct audit_buffer *ab;
+	struct perf_callchain_entry_ctx ctx;
+	struct pt_regs *regs = NULL;
+
+	if  (tsk->mm)
+		regs = task_pt_regs(tsk);
+
+	if (regs) {
+		ctx.entry = kmalloc(sizeof(struct perf_callchain_entry) +
+				    CONFIG_AUDIT_USER_BACKTRACE_SIZE * sizeof(__u64),
+				    GFP_KERNEL);
+		if (ctx.entry) {
+			mm_segment_t fs;
+
+			ctx.max_stack = CONFIG_AUDIT_USER_BACKTRACE_SIZE;
+			ctx.nr = ctx.entry->nr = 0;
+			ctx.contexts = 0;
+			ctx.contexts_maxed = false;
+
+			fs = force_uaccess_begin();
+			perf_callchain_user(&ctx, regs);
+			force_uaccess_end(fs);
+
+			if (ctx.entry->nr) {
+				ab = audit_log_start(context, GFP_KERNEL, AUDIT_UBACKTRACE);
+
+				if (ab) {
+					audit_log_print_backtrace(ab, tsk, ctx.entry);
+					audit_log_end(ab);
+				}
+			}
+
+			kfree(ctx.entry);
+		}
+	}
+}
+#endif /* CONFIG_AUDIT_USER_BACKTRACE */
+
 static void audit_log_exit(void)
 {
 	int i, call_panic = 0;
@@ -1594,6 +1682,11 @@ static void audit_log_exit(void)
 
 	audit_log_proctitle();
 
+#ifdef CONFIG_AUDIT_USER_BACKTRACE
+	if (is_audit_feature_set(AUDIT_FEATURE_UBACKTRACE_CONTEXT))
+		audit_log_ubacktrace(current, context);
+#endif /* CONFIG_AUDIT_USER_BACKTRACE */
+
 	/* Send end of event record to help user space know we are finished */
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_EOE);
 	if (ab)
-- 
2.17.1

