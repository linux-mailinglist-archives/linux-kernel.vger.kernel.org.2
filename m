Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DA8459B76
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 06:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhKWFU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 00:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhKWFUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 00:20:18 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87ACC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 21:17:10 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 4-20020a621604000000b004a4ab765028so6226606pfw.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 21:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TQIf/OIUVwGkxbYI32rejLRLSDrVm5MLPR+mboxvR5U=;
        b=IyYqQYg4PxGSfKhIUCW7Qqb/DNY9bL7t85jnFiptJc/PIfBvsajpLCYGW/v6AGJDQH
         QerrpOLxdhCfzAG7MreMDfB/QIjytpjf4wAjAk49eGwGmH4Jte3FKnbu3x8DIv2kEKvc
         DtPARbNm04SIS3LvipxKb5tJCgGozzXoLrNfkUp1l8PPlj+CtnS2Xi5vnE6TxQs9xkCO
         xU7PEtR7PBCvc7tR9NTUiscw0Mzty6cNlHB/gVrW8QVu0X+ERlC15WHbYTClfbL1csmE
         bUUKMvA7WLt8hbX6SQGFL+w4sxjGpmCjMsgsWRZUTDS7E/fy+ptRbfBWxxurL/NDjSql
         HqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TQIf/OIUVwGkxbYI32rejLRLSDrVm5MLPR+mboxvR5U=;
        b=suBjusGTGEzS6s1i0uEMDvzeNfs4NJ34zjyC3jSWtAPbo6QVinPlfhTdQFhNR4T5a8
         QgnM+YlL6IRH7yqT+KITRGlW6eYdPXb0L23ykupCMqQXe5AswiCazuGC94YdqYEqryr+
         sAnnWndlKflbfCOSLeKQbt5neotEfoExFRMqJTtWUm1DKjWjJpbWy/tw22+3TsW6d64Q
         4afCBw5vS/HkAl152CKfaS+hgyITxrOphybMeuwf7kz8YtFhIFSbsInIJtbgcBRGC/PO
         V4aFSITCIpRLk/Uj2nzoI0Tm3iUmrnXNl0E7D8UHSFiZb5kHpeO+68M2chuZdsPxY0ui
         4OaQ==
X-Gm-Message-State: AOAM5318KF0+gDUM5fLQfYlTXIB6Lch1PTlirJjpkmYMnPUNhafWC5SU
        JcngosZDXkiRhY00iRCBQXBB4bc=
X-Google-Smtp-Source: ABdhPJwlLZKO/n9a2aoJ8uvvHMB0+nvlxyQ3QG3hLOgWLW5DUO4ylwv7GNhUmxqFZnNLsSzYO7Z4E5I=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:a876:2e6a:b5f:3d90])
 (user=pcc job=sendgmr) by 2002:a05:6a00:2181:b0:44c:f4bc:2f74 with SMTP id
 h1-20020a056a00218100b0044cf4bc2f74mr2505169pfi.68.1637644630354; Mon, 22 Nov
 2021 21:17:10 -0800 (PST)
Date:   Mon, 22 Nov 2021 21:16:55 -0800
In-Reply-To: <20211123051658.3195589-1-pcc@google.com>
Message-Id: <20211123051658.3195589-3-pcc@google.com>
Mime-Version: 1.0
References: <20211123051658.3195589-1-pcc@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v2 2/5] uaccess-buffer: add core code
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Colin Ian King <colin.king@canonical.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Peter Collingbourne <pcc@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the core code to support uaccess logging. Subsequent patches will
hook this up to the arch-specific kernel entry and exit code for
certain architectures.

Link: https://linux-review.googlesource.com/id/I6581765646501a5631b281d670903945ebadc57d
Signed-off-by: Peter Collingbourne <pcc@google.com>
---
v2:
- New interface that avoids multiple syscalls per real syscall and
  is arch-generic
- Avoid logging uaccesses done by BPF programs
- Add documentation
- Split up into multiple patches
- Various code moves, renames etc as requested by Marco

 arch/Kconfig                             |   5 +
 fs/exec.c                                |   2 +
 include/linux/instrumented.h             |   5 +-
 include/linux/sched.h                    |   4 +
 include/linux/uaccess-buffer-log-hooks.h |  59 +++++++++++
 include/linux/uaccess-buffer.h           |  79 ++++++++++++++
 include/uapi/linux/prctl.h               |   3 +
 include/uapi/linux/uaccess-buffer.h      |  25 +++++
 kernel/Makefile                          |   1 +
 kernel/bpf/helpers.c                     |   6 +-
 kernel/fork.c                            |   3 +
 kernel/signal.c                          |   4 +-
 kernel/sys.c                             |   6 ++
 kernel/uaccess-buffer.c                  | 125 +++++++++++++++++++++++
 14 files changed, 324 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/uaccess-buffer-log-hooks.h
 create mode 100644 include/linux/uaccess-buffer.h
 create mode 100644 include/uapi/linux/uaccess-buffer.h
 create mode 100644 kernel/uaccess-buffer.c

diff --git a/arch/Kconfig b/arch/Kconfig
index 26b8ed11639d..6030298a7e9a 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1302,6 +1302,11 @@ config ARCH_HAS_PARANOID_L1D_FLUSH
 config DYNAMIC_SIGFRAME
 	bool
 
+config HAVE_ARCH_UACCESS_BUFFER
+	bool
+	help
+	  Select if the architecture's syscall entry/exit code supports uaccess buffers.
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/fs/exec.c b/fs/exec.c
index 537d92c41105..5f30314f3ec6 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -65,6 +65,7 @@
 #include <linux/vmalloc.h>
 #include <linux/io_uring.h>
 #include <linux/syscall_user_dispatch.h>
+#include <linux/uaccess-buffer.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1313,6 +1314,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	me->personality &= ~bprm->per_clear;
 
 	clear_syscall_work_syscall_user_dispatch(me);
+	uaccess_buffer_set_descriptor_addr_addr(0);
 
 	/*
 	 * We have to apply CLOEXEC before we change whether the process is
diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 42faebbaa202..c96be1695614 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -2,7 +2,7 @@
 
 /*
  * This header provides generic wrappers for memory access instrumentation that
- * the compiler cannot emit for: KASAN, KCSAN.
+ * the compiler cannot emit for: KASAN, KCSAN, uaccess buffers.
  */
 #ifndef _LINUX_INSTRUMENTED_H
 #define _LINUX_INSTRUMENTED_H
@@ -11,6 +11,7 @@
 #include <linux/kasan-checks.h>
 #include <linux/kcsan-checks.h>
 #include <linux/types.h>
+#include <linux/uaccess-buffer-log-hooks.h>
 
 /**
  * instrument_read - instrument regular read access
@@ -117,6 +118,7 @@ instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	kasan_check_read(from, n);
 	kcsan_check_read(from, n);
+	uaccess_buffer_log_write(to, n);
 }
 
 /**
@@ -134,6 +136,7 @@ instrument_copy_from_user(const void *to, const void __user *from, unsigned long
 {
 	kasan_check_write(to, n);
 	kcsan_check_write(to, n);
+	uaccess_buffer_log_read(from, n);
 }
 
 #endif /* _LINUX_INSTRUMENTED_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 78c351e35fec..1f978deaa3f8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1484,6 +1484,10 @@ struct task_struct {
 	struct callback_head		l1d_flush_kill;
 #endif
 
+#ifdef CONFIG_HAVE_ARCH_UACCESS_BUFFER
+	struct uaccess_buffer_info	uaccess_buffer;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/include/linux/uaccess-buffer-log-hooks.h b/include/linux/uaccess-buffer-log-hooks.h
new file mode 100644
index 000000000000..bddc84ddce32
--- /dev/null
+++ b/include/linux/uaccess-buffer-log-hooks.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UACCESS_BUFFER_LOG_HOOKS_H
+#define _LINUX_UACCESS_BUFFER_LOG_HOOKS_H
+
+#ifdef CONFIG_HAVE_ARCH_UACCESS_BUFFER
+
+struct uaccess_buffer_info {
+	/*
+	 * The pointer to pointer to struct uaccess_descriptor. This is the
+	 * value controlled by prctl(PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR).
+	 */
+	struct uaccess_descriptor __user *__user *desc_ptr_ptr;
+
+	/*
+	 * The pointer to struct uaccess_descriptor read at syscall entry time.
+	 */
+	struct uaccess_descriptor __user *desc_ptr;
+
+	/*
+	 * A pointer to the kernel's temporary copy of the uaccess log for the
+	 * current syscall. We log to a kernel buffer in order to avoid leaking
+	 * timing information to userspace.
+	 */
+	struct uaccess_buffer_entry *kbegin;
+
+	/*
+	 * The position of the next uaccess buffer entry for the current
+	 * syscall.
+	 */
+	struct uaccess_buffer_entry *kcur;
+
+	/*
+	 * A pointer to the end of the kernel's uaccess log.
+	 */
+	struct uaccess_buffer_entry *kend;
+
+	/*
+	 * The pointer to the userspace uaccess log, as read from the
+	 * struct uaccess_descriptor.
+	 */
+	struct uaccess_buffer_entry __user *ubegin;
+};
+
+void uaccess_buffer_log_read(const void __user *from, unsigned long n);
+void uaccess_buffer_log_write(void __user *to, unsigned long n);
+
+#else
+
+static inline void uaccess_buffer_log_read(const void __user *from,
+					   unsigned long n)
+{
+}
+static inline void uaccess_buffer_log_write(void __user *to, unsigned long n)
+{
+}
+
+#endif
+
+#endif  /* _LINUX_UACCESS_BUFFER_LOG_HOOKS_H */
diff --git a/include/linux/uaccess-buffer.h b/include/linux/uaccess-buffer.h
new file mode 100644
index 000000000000..14261368d3a9
--- /dev/null
+++ b/include/linux/uaccess-buffer.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UACCESS_BUFFER_H
+#define _LINUX_UACCESS_BUFFER_H
+
+#include <linux/sched.h>
+#include <uapi/linux/uaccess-buffer.h>
+
+#include <asm-generic/errno-base.h>
+
+#ifdef CONFIG_HAVE_ARCH_UACCESS_BUFFER
+
+static inline bool uaccess_buffer_maybe_blocked(struct task_struct *tsk)
+{
+	return tsk->uaccess_buffer.desc_ptr_ptr;
+}
+
+void __uaccess_buffer_syscall_entry(void);
+static inline void uaccess_buffer_syscall_entry(void)
+{
+	if (uaccess_buffer_maybe_blocked(current))
+		__uaccess_buffer_syscall_entry();
+}
+
+void __uaccess_buffer_syscall_exit(void);
+static inline void uaccess_buffer_syscall_exit(void)
+{
+	if (uaccess_buffer_maybe_blocked(current))
+		__uaccess_buffer_syscall_exit();
+}
+
+bool __uaccess_buffer_pre_exit_loop(void);
+static inline bool uaccess_buffer_pre_exit_loop(void)
+{
+	if (!uaccess_buffer_maybe_blocked(current))
+		return false;
+	return __uaccess_buffer_pre_exit_loop();
+}
+
+void __uaccess_buffer_post_exit_loop(void);
+static inline void uaccess_buffer_post_exit_loop(bool pending)
+{
+	if (pending)
+		__uaccess_buffer_post_exit_loop();
+}
+
+void uaccess_buffer_cancel_log(struct task_struct *tsk);
+int uaccess_buffer_set_descriptor_addr_addr(unsigned long addr);
+
+#else
+
+static inline bool uaccess_buffer_maybe_blocked(struct task_struct *tsk)
+{
+	return false;
+}
+
+static inline void uaccess_buffer_syscall_entry(void)
+{
+}
+static inline void uaccess_buffer_syscall_exit(void)
+{
+}
+static inline bool uaccess_buffer_pre_exit_loop(void)
+{
+	return false;
+}
+static inline void uaccess_buffer_post_exit_loop(bool pending)
+{
+}
+static inline void uaccess_buffer_cancel_log(struct task_struct *tsk)
+{
+}
+
+static inline int uaccess_buffer_set_descriptor_addr_addr(unsigned long addr)
+{
+	return -EINVAL;
+}
+#endif
+
+#endif  /* _LINUX_UACCESS_BUFFER_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index bb73e9a0b24f..74b37469c7b3 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -272,4 +272,7 @@ struct prctl_mm_map {
 # define PR_SCHED_CORE_SCOPE_THREAD_GROUP	1
 # define PR_SCHED_CORE_SCOPE_PROCESS_GROUP	2
 
+/* Configure uaccess logging feature */
+#define PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR	63
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/include/uapi/linux/uaccess-buffer.h b/include/uapi/linux/uaccess-buffer.h
new file mode 100644
index 000000000000..619b17dc25c4
--- /dev/null
+++ b/include/uapi/linux/uaccess-buffer.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_UACCESS_BUFFER_H
+#define _UAPI_LINUX_UACCESS_BUFFER_H
+
+/* Location of the uaccess log. */
+struct uaccess_descriptor {
+	/* Address of the uaccess_buffer_entry array. */
+	__u64 addr;
+	/* Size of the uaccess_buffer_entry array in number of elements. */
+	__u64 size;
+};
+
+/* Format of the entries in the uaccess log. */
+struct uaccess_buffer_entry {
+	/* Address being accessed. */
+	__u64 addr;
+	/* Number of bytes that were accessed. */
+	__u64 size;
+	/* UACCESS_BUFFER_* flags. */
+	__u64 flags;
+};
+
+#define UACCESS_BUFFER_FLAG_WRITE	1 /* access was a write */
+
+#endif /* _UAPI_LINUX_UACCESS_BUFFER_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index 186c49582f45..d4d9be5146c3 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -114,6 +114,7 @@ obj-$(CONFIG_KCSAN) += kcsan/
 obj-$(CONFIG_SHADOW_CALL_STACK) += scs.o
 obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call.o
 obj-$(CONFIG_CFI_CLANG) += cfi.o
+obj-$(CONFIG_HAVE_ARCH_UACCESS_BUFFER) += uaccess-buffer.o
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 649f07623df6..167b50177066 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -637,7 +637,11 @@ const struct bpf_func_proto bpf_event_output_data_proto =  {
 BPF_CALL_3(bpf_copy_from_user, void *, dst, u32, size,
 	   const void __user *, user_ptr)
 {
-	int ret = copy_from_user(dst, user_ptr, size);
+	/*
+	 * Avoid copy_from_user() here as it may leak information about the BPF
+	 * program to userspace via the uaccess buffer.
+	 */
+	int ret = raw_copy_from_user(dst, user_ptr, size);
 
 	if (unlikely(ret)) {
 		memset(dst, 0, size);
diff --git a/kernel/fork.c b/kernel/fork.c
index 3244cc56b697..c7abe7e7c7cd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -96,6 +96,7 @@
 #include <linux/scs.h>
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
+#include <linux/uaccess-buffer.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -890,6 +891,8 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	if (memcg_charge_kernel_stack(tsk))
 		goto free_stack;
 
+	uaccess_buffer_cancel_log(tsk);
+
 	stack_vm_area = task_stack_vm_area(tsk);
 
 	err = arch_dup_task_struct(tsk, orig);
diff --git a/kernel/signal.c b/kernel/signal.c
index a629b11bf3e0..69bf21518bd0 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -45,6 +45,7 @@
 #include <linux/posix-timers.h>
 #include <linux/cgroup.h>
 #include <linux/audit.h>
+#include <linux/uaccess-buffer.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/signal.h>
@@ -1031,7 +1032,8 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
 	if (sig_fatal(p, sig) &&
 	    !(signal->flags & SIGNAL_GROUP_EXIT) &&
 	    !sigismember(&t->real_blocked, sig) &&
-	    (sig == SIGKILL || !p->ptrace)) {
+	    (sig == SIGKILL ||
+	     !(p->ptrace || uaccess_buffer_maybe_blocked(p)))) {
 		/*
 		 * This signal will be fatal to the whole group.
 		 */
diff --git a/kernel/sys.c b/kernel/sys.c
index 8fdac0d90504..c71a9a9c0f68 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -42,6 +42,7 @@
 #include <linux/version.h>
 #include <linux/ctype.h>
 #include <linux/syscall_user_dispatch.h>
+#include <linux/uaccess-buffer.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
@@ -2530,6 +2531,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = sched_core_share_pid(arg2, arg3, arg4, arg5);
 		break;
 #endif
+	case PR_SET_UACCESS_DESCRIPTOR_ADDR_ADDR:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = uaccess_buffer_set_descriptor_addr_addr(arg2);
+		break;
 	default:
 		error = -EINVAL;
 		break;
diff --git a/kernel/uaccess-buffer.c b/kernel/uaccess-buffer.c
new file mode 100644
index 000000000000..e1c6d6ab9af8
--- /dev/null
+++ b/kernel/uaccess-buffer.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Support for uaccess logging via uaccess buffers.
+ *
+ * Copyright (C) 2021, Google LLC.
+ */
+
+#include <linux/compat.h>
+#include <linux/mm.h>
+#include <linux/prctl.h>
+#include <linux/ptrace.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/uaccess-buffer.h>
+
+static void uaccess_buffer_log(unsigned long addr, unsigned long size,
+			      unsigned long flags)
+{
+	struct uaccess_buffer_info *buf = &current->uaccess_buffer;
+	struct uaccess_buffer_entry *entry = buf->kcur;
+
+	if (!entry || unlikely(uaccess_kernel()))
+		return;
+	entry->addr = addr;
+	entry->size = size;
+	entry->flags = flags;
+
+	++buf->kcur;
+	if (buf->kcur == buf->kend)
+		buf->kcur = 0;
+}
+
+void uaccess_buffer_log_read(const void __user *from, unsigned long n)
+{
+	uaccess_buffer_log((unsigned long)from, n, 0);
+}
+EXPORT_SYMBOL(uaccess_buffer_log_read);
+
+void uaccess_buffer_log_write(void __user *to, unsigned long n)
+{
+	uaccess_buffer_log((unsigned long)to, n, UACCESS_BUFFER_FLAG_WRITE);
+}
+EXPORT_SYMBOL(uaccess_buffer_log_write);
+
+int uaccess_buffer_set_descriptor_addr_addr(unsigned long addr)
+{
+	current->uaccess_buffer.desc_ptr_ptr =
+		(struct uaccess_descriptor __user * __user *)addr;
+	uaccess_buffer_cancel_log(current);
+	return 0;
+}
+
+bool __uaccess_buffer_pre_exit_loop(void)
+{
+	struct uaccess_buffer_info *buf = &current->uaccess_buffer;
+	struct uaccess_descriptor __user *desc_ptr;
+	sigset_t tmp_mask;
+
+	if (get_user(desc_ptr, buf->desc_ptr_ptr) || !desc_ptr)
+		return false;
+
+	current->real_blocked = current->blocked;
+	sigfillset(&tmp_mask);
+	set_current_blocked(&tmp_mask);
+	return true;
+}
+
+void __uaccess_buffer_post_exit_loop(void)
+{
+	spin_lock_irq(&current->sighand->siglock);
+	current->blocked = current->real_blocked;
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
+}
+
+void uaccess_buffer_cancel_log(struct task_struct *tsk)
+{
+	struct uaccess_buffer_info *buf = &tsk->uaccess_buffer;
+
+	if (buf->kcur) {
+		buf->kcur = 0;
+		kfree(buf->kbegin);
+	}
+}
+
+void __uaccess_buffer_syscall_entry(void)
+{
+	struct uaccess_buffer_info *buf = &current->uaccess_buffer;
+	struct uaccess_descriptor desc;
+
+	if (get_user(buf->desc_ptr, buf->desc_ptr_ptr) || !buf->desc_ptr ||
+	    put_user(0, buf->desc_ptr_ptr) ||
+	    copy_from_user(&desc, buf->desc_ptr, sizeof(desc)))
+		return;
+
+	if (desc.size > 1024)
+		desc.size = 1024;
+
+	buf->kbegin = kmalloc_array(
+		desc.size, sizeof(struct uaccess_buffer_entry), GFP_KERNEL);
+	buf->kcur = buf->kbegin;
+	buf->kend = buf->kbegin + desc.size;
+	buf->ubegin = (struct uaccess_buffer_entry __user *)desc.addr;
+}
+
+void __uaccess_buffer_syscall_exit(void)
+{
+	struct uaccess_buffer_info *buf = &current->uaccess_buffer;
+	u64 num_entries = buf->kcur - buf->kbegin;
+	struct uaccess_descriptor desc;
+
+	if (!buf->kcur)
+		return;
+
+	desc.addr = (u64)(buf->ubegin + num_entries);
+	desc.size = buf->kend - buf->kcur;
+	buf->kcur = 0;
+	if (copy_to_user(buf->ubegin, buf->kbegin,
+			 num_entries * sizeof(struct uaccess_buffer_entry)) == 0)
+		(void)copy_to_user(buf->desc_ptr, &desc, sizeof(desc));
+
+	kfree(buf->kbegin);
+}
-- 
2.34.0.rc2.393.gf8c9666880-goog

