Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DDD436DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhJUXHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:07:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:58064 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232139AbhJUXHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:07:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="315380037"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="315380037"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 16:02:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="445033310"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2021 16:02:23 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH 08/23] x86/signal: Use fpu::__state_user_size for sigalt stack validation
Date:   Thu, 21 Oct 2021 15:55:12 -0700
Message-Id: <20211021225527.10184-9-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021225527.10184-1-chang.seok.bae@intel.com>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Use the current->group_leader->fpu to check for pending permissions to use
extended features and validate against the resulting user space size which
is stored in the group leaders fpu struct as well.

This prevents a task to install a too small sized sigaltstack after
permissions to use dynamically enabled features has been granted, but the
task has not (yet) used a related instruction.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kernel/signal.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 0111a6ae6e60..ec71e06ae364 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -32,6 +32,7 @@
 #include <asm/processor.h>
 #include <asm/ucontext.h>
 #include <asm/fpu/signal.h>
+#include <asm/fpu/xstate.h>
 #include <asm/vdso.h>
 #include <asm/mce.h>
 #include <asm/sighandling.h>
@@ -720,12 +721,15 @@ SYSCALL_DEFINE0(rt_sigreturn)
 
 /* max_frame_size tells userspace the worst case signal stack size. */
 static unsigned long __ro_after_init max_frame_size;
+static unsigned int __ro_after_init fpu_default_state_size;
 
 void __init init_sigframe_size(void)
 {
+	fpu_default_state_size = fpu__get_fpstate_size();
+
 	max_frame_size = MAX_FRAME_SIGINFO_UCTXT_SIZE + MAX_FRAME_PADDING;
 
-	max_frame_size += fpu__get_fpstate_size() + MAX_XSAVE_PADDING;
+	max_frame_size += fpu_default_state_size + MAX_XSAVE_PADDING;
 
 	/* Userspace expects an aligned size. */
 	max_frame_size = round_up(max_frame_size, FRAME_ALIGNMENT);
@@ -928,15 +932,38 @@ __setup("strict_sas_size", strict_sas_size);
  * sigaltstack they just continued to work. While always checking against
  * the real size would be correct, this might be considered a regression.
  *
- * Therefore avoid the sanity check, unless enforced by kernel config or
- * command line option.
+ * Therefore avoid the sanity check, unless enforced by kernel
+ * configuration or command line option.
+ *
+ * When dynamic FPU features are supported, the check is also enforced when
+ * the task has permissions to use dynamic features. Tasks which have no
+ * permission are checked against the size of the non-dynamic feature set
+ * if strict checking is enabled. This avoids forcing all tasks on the
+ * system to allocate large sigaltstacks even if they are never going
+ * to use a dynamic feature. As this is serialized via sighand::siglock
+ * any permission request for a dynamic feature either happened already
+ * or will see the newly install sigaltstack size in the permission checks.
  */
 bool sigaltstack_size_valid(size_t ss_size)
 {
+	unsigned long fsize = max_frame_size - fpu_default_state_size;
+	u64 mask;
+
 	lockdep_assert_held(&current->sighand->siglock);
 
+	if (!fpu_state_size_dynamic() && !strict_sigaltstack_size)
+		return true;
+
+	fsize += current->group_leader->thread.fpu.perm.__user_state_size;
+	if (likely(ss_size > fsize))
+		return true;
+
 	if (strict_sigaltstack_size)
-		return ss_size > get_sigframe_size();
+		return ss_size > fsize;
+
+	mask = current->group_leader->thread.fpu.perm.__state_perm;
+	if (mask & XFEATURE_MASK_USER_DYNAMIC)
+		return ss_size > fsize;
 
 	return true;
 }
-- 
2.17.1

