Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E48F436DED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhJUXHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:07:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:4522 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232391AbhJUXHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:07:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="292634853"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="292634853"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 16:02:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="445033393"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2021 16:02:25 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH 14/23] x86/fpu: Add XFD state to fpstate
Date:   Thu, 21 Oct 2021 15:55:18 -0700
Message-Id: <20211021225527.10184-15-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021225527.10184-1-chang.seok.bae@intel.com>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add storage for XFD register state to struct fpstate. This will be used to
store the XFD MSR state. This will be used for switching the XFD MSR when
FPU content is restored.

Add a per-CPU variable to cache the current MSR value so the MSR has only
to be written when the values are different.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
Changes from the tglx tree:
* Add a missing #ifdeffery.
---
 arch/x86/include/asm/fpu/types.h | 3 +++
 arch/x86/kernel/fpu/core.c       | 2 ++
 arch/x86/kernel/fpu/xstate.h     | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index d27ad4842fa1..c956db14b011 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -322,6 +322,9 @@ struct fpstate {
 	/* @user_xfeatures:	xfeatures valid in UABI buffers */
 	u64			user_xfeatures;
 
+	/* @xfd:		xfeatures disabled to trap userspace use. */
+	u64			xfd;
+
 	/* @is_valloc:		Indicator for dynamically allocated state */
 	unsigned int		is_valloc	: 1;
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 073a8fc281d8..e92c9d79441c 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -27,6 +27,7 @@
 
 #ifdef CONFIG_X86_64
 DEFINE_STATIC_KEY_FALSE(__fpu_state_size_dynamic);
+DEFINE_PER_CPU(u64, xfd_state);
 #endif
 
 /* The FPU state configuration data for kernel and user space */
@@ -412,6 +413,7 @@ static void __fpstate_reset(struct fpstate *fpstate)
 	fpstate->user_size	= fpu_user_cfg.default_size;
 	fpstate->xfeatures	= fpu_kernel_cfg.default_features;
 	fpstate->user_xfeatures	= fpu_user_cfg.default_features;
+	fpstate->xfd		= init_fpstate.xfd;
 }
 
 void fpstate_reset(struct fpu *fpu)
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 4ce1dc030f38..32a4dee4de3b 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -5,6 +5,10 @@
 #include <asm/cpufeature.h>
 #include <asm/fpu/xstate.h>
 
+#ifdef CONFIG_X86_64
+DECLARE_PER_CPU(u64, xfd_state);
+#endif
+
 static inline void xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
 {
 	/*
-- 
2.17.1

