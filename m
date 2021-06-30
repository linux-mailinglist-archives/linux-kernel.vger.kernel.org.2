Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8027A3B7D32
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 08:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhF3GLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 02:11:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:46946 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232358AbhF3GKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 02:10:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="195448566"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="195448566"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 23:08:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="455156523"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga008.jf.intel.com with ESMTP; 29 Jun 2021 23:08:17 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v6 11/26] x86/fpu/xstate: Update the XSTATE context copy function to support dynamic states
Date:   Tue, 29 Jun 2021 23:02:11 -0700
Message-Id: <20210630060226.24652-12-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210630060226.24652-1-chang.seok.bae@intel.com>
References: <20210630060226.24652-1-chang.seok.bae@intel.com>
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
index 58e7567dc3cc..8939345778a7 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1287,6 +1287,7 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 	zerofrom = offsetof(struct xregs_state, extended_state_area);
 
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
+		u64 mask = BIT_ULL(i);
 		/*
 		 * The ptrace buffer is in non-compacted XSAVE format.
 		 * In non-compacted format disabled features still occupy
@@ -1294,7 +1295,7 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 		 * compacted init_fpstate. The gap tracking will zero this
 		 * later.
 		 */
-		if (!(xfeatures_mask_uabi() & BIT_ULL(i)))
+		if (!(xfeatures_mask_uabi() & mask))
 			continue;
 
 		/*
@@ -1314,10 +1315,24 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
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
@@ -1359,6 +1374,8 @@ static int copy_uabi_to_xstate(struct fpu *fpu, const void *kbuf,
 	if (validate_user_xstate_header(&hdr))
 		return -EINVAL;
 
+	hdr.xfeatures &= fpu->state_mask;
+
 	/* Validate MXCSR when any of the related features is in use */
 	mask = XFEATURE_MASK_FP | XFEATURE_MASK_SSE | XFEATURE_MASK_YMM;
 	if (hdr.xfeatures & mask) {
@@ -1385,6 +1402,9 @@ static int copy_uabi_to_xstate(struct fpu *fpu, const void *kbuf,
 		if (hdr.xfeatures & mask) {
 			void *dst = __raw_xsave_addr(fpu, i);
 
+			if (!dst)
+				continue;
+
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
 
-- 
2.17.1

