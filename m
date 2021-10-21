Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DDD436DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbhJUXIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:08:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:4523 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232562AbhJUXID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:08:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="292634920"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="292634920"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 16:02:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="445033477"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2021 16:02:29 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH 22/23] x86/fpu: Add XFD handling for dynamic states
Date:   Thu, 21 Oct 2021 15:55:26 -0700
Message-Id: <20211021225527.10184-23-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021225527.10184-1-chang.seok.bae@intel.com>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To handle the dynamic sizing of buffers on first use the XFD MSR has to be
armed. Store the delta between the maximum available and the default
feature bits in init_fpstate where it can be retrieved for task creation.

If the delta is non zero then dynamic features are enabled. This needs also
to enable the static key which guards the XFD updates. This is delayed to
an initcall because the FPU setup runs before jump labels are initialized.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index dcc1dd2d8f2d..81b40f119ce7 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -835,6 +835,12 @@ static void __init fpu__init_disable_system_xstate(unsigned int legacy_size)
 	fpu_user_cfg.max_size = legacy_size;
 	fpu_user_cfg.default_size = legacy_size;
 
+	/*
+	 * Prevent enabling the static branch which enables writes to the
+	 * XFD MSR.
+	 */
+	init_fpstate.xfd = 0;
+
 	fpstate_reset(&current->thread.fpu);
 }
 
@@ -918,6 +924,14 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	/* Store it for paranoia check at the end */
 	xfeatures = fpu_kernel_cfg.max_features;
 
+	/*
+	 * Initialize the default XFD state in initfp_state and enable the
+	 * dynamic sizing mechanism if dynamic states are available.  The
+	 * static key cannot be enabled here because this runs before
+	 * jump_label_init(). This is delayed to an initcall.
+	 */
+	init_fpstate.xfd = fpu_user_cfg.max_features & XFEATURE_MASK_USER_DYNAMIC;
+
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
 	err = init_xstate_size();
@@ -1463,9 +1477,21 @@ void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor)
 }
 #endif /* CONFIG_X86_DEBUG_FPU */
 
+static int __init xfd_update_static_branch(void)
+{
+	/*
+	 * If init_fpstate.xfd has bits set then dynamic features are
+	 * available and the dynamic sizing must be enabled.
+	 */
+	if (init_fpstate.xfd)
+		static_branch_enable(&__fpu_state_size_dynamic);
+	return 0;
+}
+arch_initcall(xfd_update_static_branch)
+
 void fpstate_free(struct fpu *fpu)
 {
-	if (fpu->fpstate || fpu->fpstate != &fpu->__fpstate)
+	if (fpu->fpstate && fpu->fpstate != &fpu->__fpstate)
 		vfree(fpu->fpstate);
 }
 
-- 
2.17.1

