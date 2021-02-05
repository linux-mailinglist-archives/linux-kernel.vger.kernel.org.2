Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D9231159F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 23:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhBEWgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 17:36:21 -0500
Received: from mga14.intel.com ([192.55.52.115]:7848 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232807AbhBEOyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:54:21 -0500
IronPort-SDR: ptJXR1pSBpuzil/MBxwE/tz/2JqtOcWtUGMP0s4UTsm56tFQT82eNIOp9ZLhxOU8ItqvR1HCf+
 3z4s6vnRJT+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="180679130"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="180679130"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 08:32:03 -0800
IronPort-SDR: glgTqKkWp62TU5ZtepZTDnsjqW229K7qF4sJ4A56n+GHeII9j8+6ASA7HzkGxaq4tgMowsQfOe
 kVakvuDiK9tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="393927332"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga008.jf.intel.com with ESMTP; 05 Feb 2021 08:31:56 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, x86@kernel.org
Cc:     luto@kernel.org, mingo@kernel.org, tglx@linutronix.de,
        len.brown@intel.com, dave.hansen@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2] x86/fpu: Use consistent test for X86_FEATURE_XSAVES
Date:   Fri,  5 Feb 2021 08:27:14 -0800
Message-Id: <20210205162714.5580-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When XSAVES is present, the kernel always takes advantage of it, and XSAVES
always uses the compacted format.

The helper function using_compacted_format() implies that using the
compacted format may be possible without XSAVES (say by using XSAVEC), but
that is not possible here, so delete that confusing helper and simply check
the feature in the first place -- if XSAVES is available or not.

Cleanup only. No functional change.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
---
Changes from v1:
* Added comments (Dave Hansen)
* Updated the changelog (Borislav Petkov)
---
 arch/x86/include/asm/fpu/xstate.h |  1 -
 arch/x86/kernel/fpu/regset.c      |  6 ++++--
 arch/x86/kernel/fpu/signal.c      |  3 ++-
 arch/x86/kernel/fpu/xstate.c      | 18 ++----------------
 4 files changed, 8 insertions(+), 20 deletions(-)

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
index c413756ba89f..c999b9e5b3a1 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -84,7 +84,8 @@ int xstateregs_get(struct task_struct *target, const struct user_regset *regset,
 
 	fpu__prepare_read(fpu);
 
-	if (using_compacted_format()) {
+	/* The XSAVES compacted format must be copied one state at a time. */
+	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
 		copy_xstate_to_kernel(to, xsave);
 		return 0;
 	} else {
@@ -124,7 +125,8 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 
 	fpu__prepare_write(fpu);
 
-	if (using_compacted_format()) {
+	/* The XSAVES compacted format must be copied one state at a time. */
+	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
 		if (kbuf)
 			ret = copy_kernel_to_xstate(xsave, kbuf);
 		else
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index a4ec65317a7f..761324a31e5c 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -405,7 +405,8 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 	if (use_xsave() && !fx_only) {
 		u64 init_bv = xfeatures_mask_user() & ~user_xfeatures;
 
-		if (using_compacted_format()) {
+		/* The XSAVES compacted format must be copied one state at a time. */
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

