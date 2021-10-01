Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA29841F7A2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 00:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356122AbhJAWra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 18:47:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:20705 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356108AbhJAWrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 18:47:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="205090136"
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="205090136"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 15:44:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="565343992"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2021 15:44:16 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v11 12/29] x86/fpu/xstate: Update the XSTATE context copy function to support dynamic states
Date:   Fri,  1 Oct 2021 15:37:11 -0700
Message-Id: <20211001223728.9309-13-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211001223728.9309-1-chang.seok.bae@intel.com>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
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
index 2cb0d8c2eeeb..34cd131f5476 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1153,6 +1153,30 @@ static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
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
@@ -1254,10 +1278,7 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
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

