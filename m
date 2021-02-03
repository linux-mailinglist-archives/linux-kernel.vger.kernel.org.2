Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB8830D1C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 03:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhBCCqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 21:46:24 -0500
Received: from mga09.intel.com ([134.134.136.24]:52276 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231783AbhBCCqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 21:46:21 -0500
IronPort-SDR: 3R1QzBgUt2OXR61T19wKXl2yuwo7Aw6FMNJK2WJOTK1b3sS4KvNSUWiDNdWygNU+owCQB5FLOb
 b7CPUpuezV1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="181120772"
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="181120772"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 18:45:40 -0800
IronPort-SDR: ZB3172/65L4gYS8peiPCAjZRpG4zEUkMlYqUAUcS9eohKTJzV5ZHj2jyeSZXN+vMgBoZgLZ4k5
 tT3CGJ8DmUMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="392134244"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga008.jf.intel.com with ESMTP; 02 Feb 2021 18:45:40 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, x86@kernel.org
Cc:     luto@kernel.org, mingo@kernel.org, tglx@linutronix.de,
        len.brown@intel.com, dave.hansen@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH] x86/fpu: Use consistent test for X86_FEATURE_XSAVES
Date:   Tue,  2 Feb 2021 18:40:52 -0800
Message-Id: <20210203024052.15789-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When XSAVES is present, the kernel always takes advantage of it, and XSAVES
always uses compacted format.

The macro using_compacted_format() implies that using compacted format may
be possible without XSAVES (say by using XSAVEC), but that is not possible
here, so delete that confusing macro and simply test for what we want to
know in the first place -- if we have XSAVES or not.

Cleanup only. No functional change.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
---
 arch/x86/include/asm/fpu/xstate.h |  1 -
 arch/x86/kernel/fpu/regset.c      |  4 ++--
 arch/x86/kernel/fpu/signal.c      |  2 +-
 arch/x86/kernel/fpu/xstate.c      | 18 ++----------------
 4 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 47a92232d595..96c43380b8c2 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -102,7 +102,6 @@ extern void __init update_regset_xstate_info(unsigned int size,
 
 void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
 const void *get_xsave_field_ptr(int xfeature_nr);
-int using_compacted_format(void);
 int xfeature_size(int xfeature_nr);
 struct membuf;
 void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave);
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index c413756ba89f..3e52e15a4891 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -84,7 +84,7 @@ int xstateregs_get(struct task_struct *target, const struct user_regset *regset,
 
 	fpu__prepare_read(fpu);
 
-	if (using_compacted_format()) {
+	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
 		copy_xstate_to_kernel(to, xsave);
 		return 0;
 	} else {
@@ -124,7 +124,7 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 
 	fpu__prepare_write(fpu);
 
-	if (using_compacted_format()) {
+	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
 		if (kbuf)
 			ret = copy_kernel_to_xstate(xsave, kbuf);
 		else
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index a4ec65317a7f..2d0efb9a27c1 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -405,7 +405,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	if (use_xsave() && !fx_only) {
 		u64 init_bv = xfeatures_mask_user() & ~user_xfeatures;
 
-		if (using_compacted_format()) {
+		if (boot_cpu_has(X86_FEATURE_XSAVES)) {
 			ret = copy_user_to_xstate(&fpu->state.xsave, buf_fx);
 		} else {
 			ret = __copy_from_user(&fpu->state.xsave, buf_fx, state_size);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 683749b80ae2..0e5fa511f0a1 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -500,20 +500,6 @@ int xfeature_size(int xfeature_nr)
 	return eax;
 }
 
-/*
- * 'XSAVES' implies two different things:
- * 1. saving of supervisor/system state
- * 2. using the compacted format
- *
- * Use this function when dealing with the compacted format so
- * that it is obvious which aspect of 'XSAVES' is being handled
- * by the calling code.
- */
-int using_compacted_format(void)
-{
-	return boot_cpu_has(X86_FEATURE_XSAVES);
-}
-
 /* Validate an xstate header supplied by userspace (ptrace or sigreturn) */
 int validate_user_xstate_header(const struct xstate_header *hdr)
 {
@@ -634,7 +620,7 @@ static void do_extra_xstate_size_checks(void)
 		 * Supervisor state components can be managed only by
 		 * XSAVES, which is compacted-format only.
 		 */
-		if (!using_compacted_format())
+		if (!boot_cpu_has(X86_FEATURE_XSAVES))
 			XSTATE_WARN_ON(xfeature_is_supervisor(i));
 
 		/* Align from the end of the previous feature */
@@ -646,7 +632,7 @@ static void do_extra_xstate_size_checks(void)
 		 * them for being ordered (increasing offsets) in
 		 * setup_xstate_features().
 		 */
-		if (!using_compacted_format())
+		if (!boot_cpu_has(X86_FEATURE_XSAVES))
 			paranoid_xstate_size = xfeature_uncompacted_offset(i);
 		/*
 		 * The compacted-format offset always depends on where
-- 
2.17.1

