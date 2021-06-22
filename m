Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DBA3B100F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 00:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFVW2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 18:28:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:61015 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230377AbhFVW2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 18:28:05 -0400
IronPort-SDR: VhztBwRu0I7v4BkYilq/kNuqJMyym5yGQe8AhbctXp65Fb/oCjEQRYGXG84mAOxcbjyhPr98aq
 yFVKLwxTTxiQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="292779523"
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="292779523"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 15:25:47 -0700
IronPort-SDR: OvEfGTHKrvcznJEOTWglAbmLt6y7j8CFBFu+hvM0nq4uUgoziE1rtMms5F+9Fvb60+RO1bzDiO
 P2fhww5pESSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="454430987"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jun 2021 15:25:47 -0700
Subject: [RFC][PATCH 4/8] x86/fpu: remove PKRU from FPU user state clearing
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, luto@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 22 Jun 2021 15:25:02 -0700
References: <20210622222455.E901B5AC@viggo.jf.intel.com>
In-Reply-To: <20210622222455.E901B5AC@viggo.jf.intel.com>
Message-Id: <20210622222502.EA11BE12@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

The signal code has a few points where it initializes user FPU state.
Remove PKRU from the set of features which are initialized in the FPU
code.  Use write_pkru() to explicitly initialize PKRU instead of using
the fpstate/XSAVE infrastructure.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
---

 b/arch/x86/kernel/fpu/core.c   |    8 +++++---
 b/arch/x86/kernel/fpu/signal.c |    5 ++++-
 b/arch/x86/kernel/signal.c     |    1 +
 3 files changed, 10 insertions(+), 4 deletions(-)

diff -puN arch/x86/kernel/fpu/core.c~no-pkru-in-fpu__clear_user_states arch/x86/kernel/fpu/core.c
--- a/arch/x86/kernel/fpu/core.c~no-pkru-in-fpu__clear_user_states	2021-06-22 14:49:10.026051754 -0700
+++ b/arch/x86/kernel/fpu/core.c	2021-06-22 14:49:10.039051754 -0700
@@ -209,7 +209,8 @@ static inline void fpstate_init_xstate(s
 	 * XRSTORS requires these bits set in xcomp_bv, or it will
 	 * trigger #GP:
 	 */
-	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT | xfeatures_mask_all;
+	xsave->header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT |
+				 xfeatures_mask_fpstate();
 }
 
 static inline void fpstate_init_fxstate(struct fxregs_state *fx)
@@ -389,8 +390,9 @@ void fpu__clear_user_states(struct fpu *
 		os_xrstor(&fpu->state.xsave, xfeatures_mask_supervisor());
 	}
 
-	/* Reset user states in registers. */
-	load_fpregs_from_init_fpstate(xfeatures_mask_restore_user());
+	/* Reset user registers maintained in fpstate. */
+	load_fpregs_from_init_fpstate(xfeatures_mask_fpstate() &
+				      xfeatures_mask_restore_user());
 
 	/*
 	 * Now all FPU registers have their desired values.  Inform the FPU
diff -puN arch/x86/kernel/fpu/signal.c~no-pkru-in-fpu__clear_user_states arch/x86/kernel/fpu/signal.c
--- a/arch/x86/kernel/fpu/signal.c~no-pkru-in-fpu__clear_user_states	2021-06-22 14:49:10.031051754 -0700
+++ b/arch/x86/kernel/fpu/signal.c	2021-06-22 14:49:10.040051754 -0700
@@ -437,6 +437,7 @@ int fpu__restore_sig(void __user *buf, i
 	int ret;
 
 	if (unlikely(!buf)) {
+		write_pkru(pkru_get_init_value());
 		fpu__clear_user_states(&current->thread.fpu);
 		return 0;
 	}
@@ -468,8 +469,10 @@ int fpu__restore_sig(void __user *buf, i
 	ret = __fpu_restore_sig(buf, buf_fx, ia32_fxstate);
 
 out:
-	if (unlikely(ret))
+	if (unlikely(ret)) {
+		write_pkru(pkru_get_init_value());
 		fpu__clear_user_states(&current->thread.fpu);
+	}
 
 	return ret;
 }
diff -puN arch/x86/kernel/signal.c~no-pkru-in-fpu__clear_user_states arch/x86/kernel/signal.c
--- a/arch/x86/kernel/signal.c~no-pkru-in-fpu__clear_user_states	2021-06-22 14:49:10.033051754 -0700
+++ b/arch/x86/kernel/signal.c	2021-06-22 14:49:10.043051754 -0700
@@ -835,6 +835,7 @@ handle_signal(struct ksignal *ksig, stru
 		/*
 		 * Ensure the signal handler starts with the new fpu state.
 		 */
+		write_pkru(pkru_get_init_value());
 		fpu__clear_user_states(fpu);
 	}
 	signal_setup_done(failed, ksig, stepping);
_
