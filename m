Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDF33B1011
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 00:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhFVW2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 18:28:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:18293 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230411AbhFVW2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 18:28:06 -0400
IronPort-SDR: gDRJFseJ/DIWHZVBXAhLPY7kuQXWAYx69zS2+ICLRHfHCkfuesRyjhH4zu2tjptoUFSLjXtnQl
 /6eA10nKqrLw==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="194459939"
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="194459939"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 15:25:49 -0700
IronPort-SDR: JbEyR7KJ/ldBklaL0PzCOkqiGNzYB5CUx4zRF5B5cbrxvRjFKnHGlLv6Pr0+9J0jlrj51QaGC6
 RosnMYr0Z0XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="555930353"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2021 15:25:49 -0700
Subject: [RFC][PATCH 5/8] x86/fpu: XSAVE buffer access routine rename
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, luto@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 22 Jun 2021 15:25:04 -0700
References: <20210622222455.E901B5AC@viggo.jf.intel.com>
In-Reply-To: <20210622222455.E901B5AC@viggo.jf.intel.com>
Message-Id: <20210622222504.E8874E6D@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

get_xsave_addr() sounds like it works on generic XSAVE buffers.  It
does not.  It only works on kernel XSAVE buffers which are part of the
FPU fpstate.

Give it a better name: get_fpstate_addr().  Also add warnings to it in
case non-fpstate features are requested (NULL should be returned for
these, but WARN() anyway).

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
---

 b/arch/x86/include/asm/fpu/xstate.h |    2 +-
 b/arch/x86/kernel/fpu/xstate.c      |   11 ++++++-----
 b/arch/x86/kvm/x86.c                |    8 ++++----
 3 files changed, 11 insertions(+), 10 deletions(-)

diff -puN arch/x86/include/asm/fpu/xstate.h~get_xsave_addr-warning arch/x86/include/asm/fpu/xstate.h
--- a/arch/x86/include/asm/fpu/xstate.h~get_xsave_addr-warning	2021-06-22 14:49:11.268051751 -0700
+++ b/arch/x86/include/asm/fpu/xstate.h	2021-06-22 14:49:11.279051751 -0700
@@ -134,7 +134,7 @@ extern u64 xstate_fx_sw_bytes[USER_XSTAT
 extern void __init update_regset_xstate_info(unsigned int size,
 					     u64 xstate_mask);
 
-void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
+void *get_fpstate_addr(struct xregs_state *xsave, int xfeature_nr);
 int xfeature_size(int xfeature_nr);
 int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
diff -puN arch/x86/kernel/fpu/xstate.c~get_xsave_addr-warning arch/x86/kernel/fpu/xstate.c
--- a/arch/x86/kernel/fpu/xstate.c~get_xsave_addr-warning	2021-06-22 14:49:11.270051751 -0700
+++ b/arch/x86/kernel/fpu/xstate.c	2021-06-22 14:49:11.279051751 -0700
@@ -878,7 +878,8 @@ static void *__raw_xsave_addr(struct xre
 }
 /*
  * Given the xsave area and a state inside, this function returns the
- * address of the state.
+ * address of the state.  This only works on kernel fpstate, not on
+ * generic buffers created with XSAVE*.
  *
  * This is the API that is called to get xstate address in either
  * standard format or compacted format of xsave area.
@@ -894,7 +895,7 @@ static void *__raw_xsave_addr(struct xre
  *	address of the state in the xsave area, or NULL if the
  *	field is not present in the xsave buffer.
  */
-void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
+void *get_fpstate_addr(struct xregs_state *xsave, int xfeature_nr)
 {
 	/*
 	 * Do we even *have* xsave state?
@@ -906,8 +907,8 @@ void *get_xsave_addr(struct xregs_state
 	 * We should not ever be requesting features that we
 	 * have not enabled.
 	 */
-	WARN_ONCE(!(xfeatures_mask_all & BIT_ULL(xfeature_nr)),
-		  "get of unsupported state");
+	WARN_ONCE(!(xfeatures_mask_fpstate() & BIT_ULL(xfeature_nr)),
+		  "get of unsupported fpstate");
 	/*
 	 * This assumes the last 'xsave*' instruction to
 	 * have requested that 'xfeature_nr' be saved.
@@ -924,7 +925,7 @@ void *get_xsave_addr(struct xregs_state
 
 	return __raw_xsave_addr(xsave, xfeature_nr);
 }
-EXPORT_SYMBOL_GPL(get_xsave_addr);
+EXPORT_SYMBOL_GPL(get_fpstate_addr);
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
 
diff -puN arch/x86/kvm/x86.c~get_xsave_addr-warning arch/x86/kvm/x86.c
--- a/arch/x86/kvm/x86.c~get_xsave_addr-warning	2021-06-22 14:49:11.274051751 -0700
+++ b/arch/x86/kvm/x86.c	2021-06-22 14:49:11.284051751 -0700
@@ -4602,7 +4602,7 @@ static void fill_xsave(u8 *dest, struct
 			memcpy(dest + offset, &vcpu->arch.pkru,
 			       sizeof(vcpu->arch.pkru));
 		} else {
-			src = get_xsave_addr(xsave, xfeature_nr);
+			src = get_fpstate_addr(xsave, xfeature_nr);
 			if (src)
 				memcpy(dest + offset, src, size);
 		}
@@ -4645,7 +4645,7 @@ static void load_xsave(struct kvm_vcpu *
 			memcpy(&vcpu->arch.pkru, src + offset,
 			       sizeof(vcpu->arch.pkru));
 		} else {
-			void *dest = get_xsave_addr(xsave, xfeature_nr);
+			void *dest = get_fpstate_addr(xsave, xfeature_nr);
 
 			if (dest)
 				memcpy(dest, src + offset, size);
@@ -10479,11 +10479,11 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcp
 		 */
 		if (init_event)
 			kvm_put_guest_fpu(vcpu);
-		mpx_state_buffer = get_xsave_addr(&vcpu->arch.guest_fpu->state.xsave,
+		mpx_state_buffer = get_fpstate_addr(&vcpu->arch.guest_fpu->state.xsave,
 					XFEATURE_BNDREGS);
 		if (mpx_state_buffer)
 			memset(mpx_state_buffer, 0, sizeof(struct mpx_bndreg_state));
-		mpx_state_buffer = get_xsave_addr(&vcpu->arch.guest_fpu->state.xsave,
+		mpx_state_buffer = get_fpstate_addr(&vcpu->arch.guest_fpu->state.xsave,
 					XFEATURE_BNDCSR);
 		if (mpx_state_buffer)
 			memset(mpx_state_buffer, 0, sizeof(struct mpx_bndcsr));
_
