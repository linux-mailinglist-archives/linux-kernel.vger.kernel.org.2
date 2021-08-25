Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E706B3F7995
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241618AbhHYQBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:01:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:15524 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241415AbhHYQB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:01:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="217271083"
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="217271083"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 09:00:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="494317214"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga008.fm.intel.com with ESMTP; 25 Aug 2021 09:00:41 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v10 03/28] x86/fpu/xstate: Modify state copy helpers to handle both static and dynamic buffers
Date:   Wed, 25 Aug 2021 08:53:48 -0700
Message-Id: <20210825155413.19673-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210825155413.19673-1-chang.seok.bae@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Have all the functions copying XSTATE take a struct fpu * pointer in
preparation for dynamic state buffer support.

No functional change.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v5:
* Adjusted function prototype changes to the recent renamed on the new
  base.

Changes from v3:
* Updated the changelog. (Borislav Petkov)

Changes from v2:
* Updated the changelog with task->fpu removed. (Borislav Petkov)
---
 arch/x86/include/asm/fpu/xstate.h |  4 ++--
 arch/x86/kernel/fpu/regset.c      |  2 +-
 arch/x86/kernel/fpu/signal.c      |  2 +-
 arch/x86/kernel/fpu/xstate.c      | 12 ++++++------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 109dfcc75299..ede166e9d3f2 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -136,8 +136,8 @@ extern void __init update_regset_xstate_info(unsigned int size,
 
 void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
 int xfeature_size(int xfeature_nr);
-int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
-int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
+int copy_uabi_from_kernel_to_xstate(struct fpu *fpu, const void *kbuf);
+int copy_sigframe_from_user_to_xstate(struct fpu *fpu, const void __user *ubuf);
 
 void xsaves(struct xregs_state *xsave, u64 mask);
 void xrstors(struct xregs_state *xsave, u64 mask);
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 66ed317ebc0d..49dd307003ec 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -164,7 +164,7 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 	}
 
 	fpu_force_restore(fpu);
-	ret = copy_uabi_from_kernel_to_xstate(&fpu->state.xsave, kbuf ?: tmpbuf);
+	ret = copy_uabi_from_kernel_to_xstate(fpu, kbuf ?: tmpbuf);
 
 out:
 	vfree(tmpbuf);
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 445c57c9c539..bec8c8046888 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -371,7 +371,7 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 	fpregs_unlock();
 
 	if (use_xsave() && !fx_only) {
-		ret = copy_sigframe_from_user_to_xstate(&fpu->state.xsave, buf_fx);
+		ret = copy_sigframe_from_user_to_xstate(fpu, buf_fx);
 		if (ret)
 			return ret;
 	} else {
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 0fed7fbcf2e8..df39085e9d05 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1089,10 +1089,10 @@ static int copy_from_buffer(void *dst, unsigned int offset, unsigned int size,
 	return 0;
 }
 
-
-static int copy_uabi_to_xstate(struct xregs_state *xsave, const void *kbuf,
+static int copy_uabi_to_xstate(struct fpu *fpu, const void *kbuf,
 			       const void __user *ubuf)
 {
+	struct xregs_state *xsave = &fpu->state.xsave;
 	unsigned int offset, size;
 	struct xstate_header hdr;
 	u64 mask;
@@ -1161,9 +1161,9 @@ static int copy_uabi_to_xstate(struct xregs_state *xsave, const void *kbuf,
  * format and copy to the target thread. This is called from
  * xstateregs_set().
  */
-int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
+int copy_uabi_from_kernel_to_xstate(struct fpu *fpu, const void *kbuf)
 {
-	return copy_uabi_to_xstate(xsave, kbuf, NULL);
+	return copy_uabi_to_xstate(fpu, kbuf, NULL);
 }
 
 /*
@@ -1171,10 +1171,10 @@ int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
  * XSAVE[S] format and copy to the target thread. This is called from the
  * sigreturn() and rt_sigreturn() system calls.
  */
-int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave,
+int copy_sigframe_from_user_to_xstate(struct fpu *fpu,
 				      const void __user *ubuf)
 {
-	return copy_uabi_to_xstate(xsave, NULL, ubuf);
+	return copy_uabi_to_xstate(fpu, NULL, ubuf);
 }
 
 static bool validate_xsaves_xrstors(u64 mask)
-- 
2.17.1

