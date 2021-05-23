Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B5C38DCAC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 21:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhEWTkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 15:40:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:12053 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231969AbhEWTj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 15:39:56 -0400
IronPort-SDR: oriGPYUyip2yFoO1ugPEO0iIaZS2krlQDc3os+LqVfEdGWP4YQRGs/hONDvikiudtpK8gt+n4Z
 PggevCrHExIQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="265703535"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="265703535"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 12:38:29 -0700
IronPort-SDR: 3TCUgX2DjyCPD+FsGe69of2mdiaD/R7Y55z9Tmj4xMyJHXWW0CrABiw+/OH652H9Qkm1iwtzGF
 ZfKFQIZfAoJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="407467108"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2021 12:38:28 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v5 16/28] x86/fpu/xstate: Support ptracer-induced xstate buffer expansion
Date:   Sun, 23 May 2021 12:32:47 -0700
Message-Id: <20210523193259.26200-17-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210523193259.26200-1-chang.seok.bae@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptrace() may update xstate data before the target task has taken an XFD
fault and expanded the xstate buffer. Detect this case and allocate a
sufficient buffer to support the request. Also, disable the (now
unnecessary) associated first-use fault.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
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
 arch/x86/kernel/fpu/regset.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index ee27df4caed6..b2fac4b5e483 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -122,6 +122,38 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 
 	xsave = &fpu->state->xsave;
 
+	/*
+	 * When a ptracer attempts to write any dynamic user state in the target buffer but not
+	 * sufficiently allocated, it dynamically expands the buffer.
+	 *
+	 * Check if the expansion is possibly needed.
+	 */
+	if (xfeatures_mask_user_dynamic &&
+	    ((fpu->state_mask & xfeatures_mask_user_dynamic) != xfeatures_mask_user_dynamic)) {
+		unsigned int offset, size;
+		u64 state_mask;
+
+		offset = offsetof(struct xregs_state, header);
+		size = sizeof(u64);
+
+		/* Retrieve XSTATE_BV. */
+		if (kbuf) {
+			memcpy(&state_mask, kbuf + offset, size);
+		} else {
+			ret = __copy_from_user(&state_mask, ubuf + offset, size);
+			if (ret)
+				return ret;
+		}
+
+		/* Expand the xstate buffer based on the XSTATE_BV. */
+		state_mask &= xfeatures_mask_user_dynamic;
+		if (state_mask) {
+			ret = alloc_xstate_buffer(fpu, state_mask);
+			if (ret)
+				return ret;
+		}
+	}
+
 	fpu__prepare_write(fpu);
 
 	if (using_compacted_format()) {
-- 
2.17.1

