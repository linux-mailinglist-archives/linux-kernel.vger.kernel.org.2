Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8663CC434
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 17:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbhGQPja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:39:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:24186 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235053AbhGQPiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 11:38:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="210853850"
X-IronPort-AV: E=Sophos;i="5.84,248,1620716400"; 
   d="scan'208";a="210853850"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2021 08:35:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,248,1620716400"; 
   d="scan'208";a="631387018"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2021 08:35:07 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v8 13/26] x86/fpu/xstate: Support ptracer-induced XSTATE buffer expansion
Date:   Sat, 17 Jul 2021 08:28:50 -0700
Message-Id: <20210717152903.7651-14-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210717152903.7651-1-chang.seok.bae@intel.com>
References: <20210717152903.7651-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptrace() may update XSTATE data before the target task has taken an XFD
fault and expanded the XSTATE buffer. Detect this case and allocate a
sufficient buffer to support the request. Also, disable the (now
unnecessary) associated first-use fault.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v5:
* Adjusted to use 'tmpbuf' for the new base code.

Changes from v4:
* Improved the condition check for the expansion.
* Simplified the XSTATE_BV retrieval.
* Updated the code comment.

Changes from v3:
* Removed 'no functional changes' in the changelog. (Borislav Petkov)

Changes from v2:
* Updated the changelog with task->fpu removed. (Borislav Petkov)
* Updated the code comments.
---
 arch/x86/kernel/fpu/regset.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 73d7d7b489fe..244e672c3e3d 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -163,6 +163,30 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 		}
 	}
 
+	/*
+	 * When a ptracer attempts to write any dynamic user state in the
+	 * target buffer but not sufficiently allocated, it dynamically
+	 * expands the buffer.
+	 *
+	 * Check if the expansion is possibly needed.
+	 */
+	if (xfeatures_mask_user_dynamic &&
+	    ((fpu->state_mask & xfeatures_mask_user_dynamic) != xfeatures_mask_user_dynamic)) {
+		u64 state_mask;
+
+		/* Retrieve XSTATE_BV. */
+		memcpy(&state_mask, (kbuf ?: tmpbuf) + offsetof(struct xregs_state, header),
+		       sizeof(u64));
+
+		/* Expand the xstate buffer based on the XSTATE_BV. */
+		state_mask &= xfeatures_mask_user_dynamic;
+		if (state_mask) {
+			ret = alloc_xstate_buffer(fpu, state_mask);
+			if (ret)
+				goto out;
+		}
+	}
+
 	fpu_force_restore(fpu);
 	ret = copy_uabi_from_kernel_to_xstate(fpu, kbuf ?: tmpbuf);
 
-- 
2.17.1

