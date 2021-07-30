Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05DF3DBB9D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 17:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbhG3PGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 11:06:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:52620 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239271AbhG3PGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:06:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="298699106"
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="298699106"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 08:06:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="508154898"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jul 2021 08:06:04 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v9 02/26] x86/fpu/xstate: Modify state copy helpers to handle both static and dynamic buffers
Date:   Fri, 30 Jul 2021 07:59:33 -0700
Message-Id: <20210730145957.7927-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210730145957.7927-1-chang.seok.bae@intel.com>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
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
index d4fdceb9a309..59f08953201c 100644
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
@@ -1158,9 +1158,9 @@ static int copy_uabi_to_xstate(struct xregs_state *xsave, const void *kbuf,
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
@@ -1168,10 +1168,10 @@ int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
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

