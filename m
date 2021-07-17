Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339593CC427
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 17:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbhGQPil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:38:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:24192 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234977AbhGQPiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 11:38:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="210853841"
X-IronPort-AV: E=Sophos;i="5.84,248,1620716400"; 
   d="scan'208";a="210853841"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2021 08:35:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,248,1620716400"; 
   d="scan'208";a="631387009"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2021 08:35:06 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v8 11/26] x86/fpu/xstate: Update the XSTATE context copy function to support dynamic states
Date:   Sat, 17 Jul 2021 08:28:48 -0700
Message-Id: <20210717152903.7651-12-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210717152903.7651-1-chang.seok.bae@intel.com>
References: <20210717152903.7651-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptrace() and signal return paths use XSTATE context copy functions. They
allow callers to read (or write) XSTATE values in the target's buffer. With
dynamic user states, a component's position in the buffer may vary and the
init fpstate is not always large enough to cover all the states.

Adjust the helpers to find a component's offset correctly. Also, update the
copy loop in the ptrace read path to support dynamic states.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v5:
* Updated to ensure xstate_bv aligned with the target.
* Rewrote the xstate copy loop, for the ptrace() read path, in an open
  code.
* Adjusted the changelog.

Changes from v3:
* Cleaned up the code change with more comments.
* Removed 'no functional change' in the changelog. (Borislav Petkov)

Changes from v2:
* Updated the changelog with task->fpu removed. (Borislav Petkov)
---
 arch/x86/kernel/fpu/xstate.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 98ab10e4da3b..3b56e7612c45 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1273,6 +1273,7 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 	zerofrom = offsetof(struct xregs_state, extended_state_area);
 
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
+		u64 mask = BIT_ULL(i);
 		/*
 		 * The ptrace buffer is in non-compacted XSAVE format.
 		 * In non-compacted format disabled features still occupy
@@ -1280,7 +1281,7 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 		 * compacted init_fpstate. The gap tracking will zero this
 		 * later.
 		 */
-		if (!(xfeatures_mask_uabi() & BIT_ULL(i)))
+		if (!(xfeatures_mask_uabi() & mask))
 			continue;
 
 		/*
@@ -1300,10 +1301,24 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 			pkru.pkru = tsk->thread.pkru;
 			membuf_write(&to, &pkru, sizeof(pkru));
 		} else {
-			copy_feature(header.xfeatures & BIT_ULL(i), &to,
-				     __raw_xsave_addr(&tsk->thread.fpu, i),
-				     __raw_xsave_addr(NULL, i),
-				     xstate_sizes[i]);
+			unsigned int size = xstate_sizes[i];
+			void *from = NULL;
+
+			/*
+			 * Copy the xstate if available. Otherwise, copy the
+			 * non-zero init states for legacy states (FP and
+			 * SSE) or fill zeros.
+			 */
+
+			if (header.xfeatures & mask)
+				from = __raw_xsave_addr(&tsk->thread.fpu, i);
+			else if (XFEATURE_MASK_FPSSE & mask)
+				from = __raw_xsave_addr(NULL, i);
+
+			if (from)
+				membuf_write(&to, from, size);
+			else
+				membuf_zero(&to, size);
 		}
 		/*
 		 * Keep track of the last copied state in the non-compacted
@@ -1345,6 +1360,8 @@ static int copy_uabi_to_xstate(struct fpu *fpu, const void *kbuf,
 	if (validate_user_xstate_header(&hdr))
 		return -EINVAL;
 
+	hdr.xfeatures &= fpu->state_mask;
+
 	/* Validate MXCSR when any of the related features is in use */
 	mask = XFEATURE_MASK_FP | XFEATURE_MASK_SSE | XFEATURE_MASK_YMM;
 	if (hdr.xfeatures & mask) {
@@ -1371,6 +1388,9 @@ static int copy_uabi_to_xstate(struct fpu *fpu, const void *kbuf,
 		if (hdr.xfeatures & mask) {
 			void *dst = __raw_xsave_addr(fpu, i);
 
+			if (!dst)
+				continue;
+
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
 
-- 
2.17.1

