Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9AD3F79A5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242132AbhHYQCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:02:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:32697 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241781AbhHYQBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:01:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="204685724"
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="204685724"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 09:00:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="494317263"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga008.fm.intel.com with ESMTP; 25 Aug 2021 09:00:44 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v10 12/28] x86/fpu/xstate: Update the XSTATE context copy function to support dynamic states
Date:   Wed, 25 Aug 2021 08:53:57 -0700
Message-Id: <20210825155413.19673-13-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210825155413.19673-1-chang.seok.bae@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptrace() and signal return paths use XSTATE context copy functions. They
allow callers to read XSTATE values in the target's buffer. With dynamic
user states, a component's position in the buffer may vary and the init
fpstate is not always large enough to cover all the states.

Introduce a new helper to adjust to find the source address correctly.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v9:
* Refactor the new code in the loop. (Borislav Petkov)
* Move out the copy_uabi_to_xstate() changes (to Patch1,9). (Borislav
  Petkov)

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
 arch/x86/kernel/fpu/xstate.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 6929db20be0a..bd6a5c746d3f 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1152,6 +1152,30 @@ static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
 	membuf_write(to, from_xstate ? xstate : init_xstate, size);
 }
 
+static void copy_extended_feature(struct membuf *to, struct fpu *fpu,
+				  struct xstate_header *hdr,
+				  int feature_nr)
+{
+	unsigned int size = xstate_sizes[feature_nr];
+	u64 mask = BIT_ULL(feature_nr);
+	void *from = NULL;
+
+	/*
+	 * Copy from the XSTATE buffer if available. Otherwise, write the
+	 * init value as recorded for legacy states (FP and SSE) or as
+	 * zeros for others.
+	 */
+	if (hdr->xfeatures & mask) {
+		from = __raw_xsave_addr(fpu, feature_nr);
+		membuf_write(to, from, size);
+	} else if (XFEATURE_MASK_FPSSE & mask) {
+		from = __raw_xsave_addr(NULL, feature_nr);
+		membuf_write(to, from, size);
+	} else {
+		membuf_zero(to, size);
+	}
+}
+
 /**
  * copy_xstate_to_uabi_buf - Copy kernel saved xstate to a UABI buffer
  * @to:		membuf descriptor
@@ -1253,10 +1277,7 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 			pkru.pkru = tsk->thread.pkru;
 			membuf_write(&to, &pkru, sizeof(pkru));
 		} else {
-			copy_feature(header.xfeatures & BIT_ULL(i), &to,
-				     __raw_xsave_addr(&tsk->thread.fpu, i),
-				     __raw_xsave_addr(NULL, i),
-				     xstate_sizes[i]);
+			copy_extended_feature(&to, &tsk->thread.fpu, &header, i);
 		}
 		/*
 		 * Keep track of the last copied state in the non-compacted
-- 
2.17.1

