Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECFA436DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhJUXHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:07:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:58064 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231271AbhJUXHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:07:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="315380004"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="315380004"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 16:02:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="445033229"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2021 16:02:20 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH 02/23] x86/signal: Implement sigaltstack size validation
Date:   Thu, 21 Oct 2021 15:55:06 -0700
Message-Id: <20211021225527.10184-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021225527.10184-1-chang.seok.bae@intel.com>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

For historical reasons MINSIGSTKSZ is a constant which became already too
small with AVX512 support.

Add a mechanism to enforce strict checking of the sigaltstack size against
the real size of the FPU frame.

The strict check can be enabled via a config option and can also be
controlled via the kernel command line option 'strict_sas_size' independent
of the config switch.

Enabling it might break existing applications which allocate a too small
sigaltstack but 'work' because they never get a signal delivered. Though it
can be handy to filter out binaries which are not yet aware of
AT_MINSIGSTKSZ.

Also the upcoming support for dynamically enabled FPU features requires a
strict sanity check to ensure that:

   - Enabling of a dynamic feature, which changes the sigframe size fits
     into an enabled sigaltstack

   - Installing a too small sigaltstack after a dynamic feature has been
     added is not possible.

Implement the base check which is controlled by config and command line
options.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 .../admin-guide/kernel-parameters.txt         |  9 +++++
 arch/x86/Kconfig                              | 17 +++++++++
 arch/x86/kernel/signal.c                      | 35 +++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 91ba391f9b32..efb9512d0b14 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5497,6 +5497,15 @@
 	stifb=		[HW]
 			Format: bpp:<bpp1>[:<bpp2>[:<bpp3>...]]
 
+        strict_sas_size=
+			[X86]
+			Format: <bool>
+			Enable or disable strict sigaltstack size checks
+			against the required signal frame size which
+			depends on the supported FPU features. This can
+			be used to filter out binaries which have
+			not yet been made aware of AT_MINSIGSTKSZ.
+
 	sunrpc.min_resvport=
 	sunrpc.max_resvport=
 			[NFS,SUNRPC]
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8055da49f1c0..9b77b4af016b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -125,6 +125,7 @@ config X86
 	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
 	select CLOCKSOURCE_WATCHDOG
 	select DCACHE_WORD_ACCESS
+	select DYNAMIC_SIGFRAME
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
 	select GENERIC_CLOCKEVENTS_BROADCAST	if X86_64 || (X86_32 && X86_LOCAL_APIC)
@@ -2389,6 +2390,22 @@ config MODIFY_LDT_SYSCALL
 
 	  Saying 'N' here may make sense for embedded or server kernels.
 
+config STRICT_SIGALTSTACK_SIZE
+	bool "Enforce strict size checking for sigaltstack"
+	depends on DYNAMIC_SIGFRAME
+	help
+	  For historical reasons MINSIGSTKSZ is a constant which became
+	  already too small with AVX512 support. Add a mechanism to
+	  enforce strict checking of the sigaltstack size against the
+	  real size of the FPU frame. This option enables the check
+	  by default. It can also be controlled via the kernel command
+	  line option 'strict_sas_size' independent of this config
+	  switch. Enabling it might break existing applications which
+	  allocate a too small sigaltstack but 'work' because they
+	  never get a signal delivered.
+
+	  Say 'N' unless you want to really enforce this check.
+
 source "kernel/livepatch/Kconfig"
 
 endmenu
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 58bd07071d14..0111a6ae6e60 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -15,6 +15,7 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/errno.h>
 #include <linux/wait.h>
 #include <linux/tracehook.h>
@@ -40,6 +41,7 @@
 #include <linux/compat.h>
 #include <asm/proto.h>
 #include <asm/ia32_unistd.h>
+#include <asm/fpu/xstate.h>
 #endif /* CONFIG_X86_64 */
 
 #include <asm/syscall.h>
@@ -907,6 +909,39 @@ void signal_fault(struct pt_regs *regs, void __user *frame, char *where)
 	force_sig(SIGSEGV);
 }
 
+#ifdef CONFIG_DYNAMIC_SIGFRAME
+#ifdef CONFIG_STRICT_SIGALTSTACK_SIZE
+static bool strict_sigaltstack_size __ro_after_init = true;
+#else
+static bool strict_sigaltstack_size __ro_after_init = false;
+#endif
+
+static int __init strict_sas_size(char *arg)
+{
+	return kstrtobool(arg, &strict_sigaltstack_size);
+}
+__setup("strict_sas_size", strict_sas_size);
+
+/*
+ * MINSIGSTKSZ is 2048 and can't be changed despite the fact that AVX512
+ * exceeds that size already. As such programs might never use the
+ * sigaltstack they just continued to work. While always checking against
+ * the real size would be correct, this might be considered a regression.
+ *
+ * Therefore avoid the sanity check, unless enforced by kernel config or
+ * command line option.
+ */
+bool sigaltstack_size_valid(size_t ss_size)
+{
+	lockdep_assert_held(&current->sighand->siglock);
+
+	if (strict_sigaltstack_size)
+		return ss_size > get_sigframe_size();
+
+	return true;
+}
+#endif /* CONFIG_DYNAMIC_SIGFRAME */
+
 #ifdef CONFIG_X86_X32_ABI
 COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
 {
-- 
2.17.1

