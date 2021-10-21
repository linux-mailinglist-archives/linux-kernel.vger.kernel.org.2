Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106A7436DE1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhJUXHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:07:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:58064 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231961AbhJUXHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:07:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="315380016"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="315380016"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 16:02:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="445033252"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2021 16:02:21 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH 04/23] x86/fpu: Add members to struct fpu to cache permission information
Date:   Thu, 21 Oct 2021 15:55:08 -0700
Message-Id: <20211021225527.10184-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021225527.10184-1-chang.seok.bae@intel.com>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Dynamically enabled features can be requested by any thread of a running
process at any time. The request does neither enable the feature nor
allocate larger buffers. It just stores the permission to use the feature
by adding the features to the permission bitmap and by calculating the
required sizes for kernel and user space.

The reallocation of the kernel buffer happens when the feature is used for
the first time which is caught by an exception. The permission bitmap is
then checked and if the feature is permitted, then it becomes fully
enabled. If not, the task dies similar to a task which uses an undefined
instruction.

The size information is precomputed to allow proper sigaltstack size checks
once the feature is permitted, but not yet in use because otherwise this
would open race windows where too small stacks could be installed causing
a later fail on signal delivery.

Initialize them to the default feature set and sizes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/include/asm/fpu/types.h | 46 ++++++++++++++++++++++++++++++++
 arch/x86/kernel/fpu/core.c       |  5 ++++
 2 files changed, 51 insertions(+)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 81a01de1fec2..d8b59e45dc25 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -352,6 +352,45 @@ struct fpstate {
 	/* @regs is dynamically sized! Don't add anything after @regs! */
 } __attribute__ ((aligned (64)));
 
+struct fpu_state_perm {
+	/*
+	 * @__state_perm:
+	 *
+	 * This bitmap indicates the permission for state components, which
+	 * are available to a thread group. The permission prctl() sets the
+	 * enabled state bits in thread_group_leader()->thread.fpu.
+	 *
+	 * All run time operations use the per thread information in the
+	 * currently active fpu.fpstate which contains the xfeature masks
+	 * and sizes for kernel and user space.
+	 *
+	 * This master permission field is only to be used when
+	 * task.fpu.fpstate based checks fail to validate whether the task
+	 * is allowed to expand it's xfeatures set which requires to
+	 * allocate a larger sized fpstate buffer.
+	 *
+	 * Do not access this field directly.  Use the provided helper
+	 * function. Unlocked access is possible for quick checks.
+	 */
+	u64				__state_perm;
+
+	/*
+	 * @__state_size:
+	 *
+	 * The size required for @__state_perm. Only valid to access
+	 * with sighand locked.
+	 */
+	unsigned int			__state_size;
+
+	/*
+	 * @__user_state_size:
+	 *
+	 * The size required for @__state_perm user part. Only valid to
+	 * access with sighand locked.
+	 */
+	unsigned int			__user_state_size;
+};
+
 /*
  * Highest level per task FPU state data structure that
  * contains the FPU register state plus various FPU
@@ -395,6 +434,13 @@ struct fpu {
 	 */
 	struct fpstate			*__task_fpstate;
 
+	/*
+	 * @perm:
+	 *
+	 * Permission related information
+	 */
+	struct fpu_state_perm		perm;
+
 	/*
 	 * @__fpstate:
 	 *
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 4b09f0f70082..eb911c843386 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -415,6 +415,11 @@ void fpstate_reset(struct fpu *fpu)
 	/* Set the fpstate pointer to the default fpstate */
 	fpu->fpstate = &fpu->__fpstate;
 	__fpstate_reset(fpu->fpstate);
+
+	/* Initialize the permission related info in fpu */
+	fpu->perm.__state_perm		= fpu_kernel_cfg.default_features;
+	fpu->perm.__state_size		= fpu_kernel_cfg.default_size;
+	fpu->perm.__user_state_size	= fpu_user_cfg.default_size;
 }
 
 /* Clone current's FPU state on fork */
-- 
2.17.1

