Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4175436DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhJUXHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:07:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:58059 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231206AbhJUXHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:07:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="315380001"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="315380001"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 16:02:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="445033221"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2021 16:02:19 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Oleg Nesterov <ole@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: [PATCH 01/23] signal: Add an optional check for altstack size
Date:   Thu, 21 Oct 2021 15:55:05 -0700
Message-Id: <20211021225527.10184-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021225527.10184-1-chang.seok.bae@intel.com>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The upcoming support for dynamically enabled FPU features on x86 requires
an architecture specific sanity check and serialization of the store to
task::sas_ss_size. The check is required to ensure that:

   - Enabling of a dynamic feature, which changes the sigframe size fits
     into an enabled sigaltstack

   - Installing a too small sigaltstack after a dynamic feature has been
     added is not possible.

It needs serialization to prevent race conditions of all sorts in the
feature enable code as that has to walk the thread list of the process.

Add the infrastructure in form of a config option and provide empty stubs
for architectures which do not need that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Oleg Nesterov <ole@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/Kconfig           |  3 +++
 include/linux/signal.h |  6 ++++++
 kernel/signal.c        | 35 +++++++++++++++++++++++++++++------
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8df1c7102643..af5cf3009b4f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1288,6 +1288,9 @@ config ARCH_HAS_ELFCORE_COMPAT
 config ARCH_HAS_PARANOID_L1D_FLUSH
 	bool
 
+config DYNAMIC_SIGFRAME
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 3f96a6374e4f..7d34105e20c6 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -464,6 +464,12 @@ int __save_altstack(stack_t __user *, unsigned long);
 	unsafe_put_user(t->sas_ss_size, &__uss->ss_size, label); \
 } while (0);
 
+#ifdef CONFIG_DYNAMIC_SIGFRAME
+bool sigaltstack_size_valid(size_t ss_size);
+#else
+static inline bool sigaltstack_size_valid(size_t size) { return true; }
+#endif /* !CONFIG_DYNAMIC_SIGFRAME */
+
 #ifdef CONFIG_PROC_FS
 struct seq_file;
 extern void render_sigset_t(struct seq_file *, const char *, sigset_t *);
diff --git a/kernel/signal.c b/kernel/signal.c
index 952741f6d0f9..9278f5291ed6 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4151,11 +4151,29 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
 	return 0;
 }
 
+#ifdef CONFIG_DYNAMIC_SIGFRAME
+static inline void sigaltstack_lock(void)
+	__acquires(&current->sighand->siglock)
+{
+	spin_lock_irq(&current->sighand->siglock);
+}
+
+static inline void sigaltstack_unlock(void)
+	__releases(&current->sighand->siglock)
+{
+	spin_unlock_irq(&current->sighand->siglock);
+}
+#else
+static inline void sigaltstack_lock(void) { }
+static inline void sigaltstack_unlock(void) { }
+#endif
+
 static int
 do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp,
 		size_t min_ss_size)
 {
 	struct task_struct *t = current;
+	int ret = 0;
 
 	if (oss) {
 		memset(oss, 0, sizeof(stack_t));
@@ -4179,19 +4197,24 @@ do_sigaltstack (const stack_t *ss, stack_t *oss, unsigned long sp,
 				ss_mode != 0))
 			return -EINVAL;
 
+		sigaltstack_lock();
 		if (ss_mode == SS_DISABLE) {
 			ss_size = 0;
 			ss_sp = NULL;
 		} else {
 			if (unlikely(ss_size < min_ss_size))
-				return -ENOMEM;
+				ret = -ENOMEM;
+			if (!sigaltstack_size_valid(ss_size))
+				ret = -ENOMEM;
 		}
-
-		t->sas_ss_sp = (unsigned long) ss_sp;
-		t->sas_ss_size = ss_size;
-		t->sas_ss_flags = ss_flags;
+		if (!ret) {
+			t->sas_ss_sp = (unsigned long) ss_sp;
+			t->sas_ss_size = ss_size;
+			t->sas_ss_flags = ss_flags;
+		}
+		sigaltstack_unlock();
 	}
-	return 0;
+	return ret;
 }
 
 SYSCALL_DEFINE2(sigaltstack,const stack_t __user *,uss, stack_t __user *,uoss)
-- 
2.17.1

