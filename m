Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6993F79A4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbhHYQCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:02:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:32706 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241691AbhHYQBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:01:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="204685719"
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="204685719"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 09:00:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,351,1620716400"; 
   d="scan'208";a="494317258"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga008.fm.intel.com with ESMTP; 25 Aug 2021 09:00:43 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v10 11/28] x86/fpu/xstate: Update the XSTATE buffer address finder to support dynamic states
Date:   Wed, 25 Aug 2021 08:53:56 -0700
Message-Id: <20210825155413.19673-12-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210825155413.19673-1-chang.seok.bae@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__raw_xsave_addr() returns the requested component's pointer in an XSTATE
buffer, by simply looking up the offset table. The offset used to be fixed,
but, with dynamic user states, it becomes variable.

calculate_xstate_buf_size_from_mask() has a routine to find an offset at
runtime. Refactor to use it for the address finder.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v9:
* Update the function description. (Borislav Petkov)

Changes from v5:
* Updated for future proofed __raw_xsave_addr().

Changes from v3:
* Added the function description in the kernel-doc style. (Borislav Petkov)
* Removed 'no functional change' in the changelog. (Borislav Petkov)
---
 arch/x86/kernel/fpu/xstate.c | 68 ++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index f56db3f77282..6929db20be0a 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -139,6 +139,33 @@ static bool xfeature_is_supervisor(int xfeature_nr)
 	return ecx & 1;
 }
 
+/**
+ * get_xstate_comp_offset - Find the feature offset in the compacted format.
+ * @mask:	This bitmap tells which components to be saved in the
+ *		format.
+ * @feature_nr:	The feature number
+ *
+ * Returns:	The offset value
+ */
+static unsigned int get_xstate_comp_offset(u64 mask, int feature_nr)
+{
+	unsigned int next_offset, offset = 0;
+	int i;
+
+	if (feature_nr < FIRST_EXTENDED_XFEATURE)
+		return xstate_comp_offsets[feature_nr];
+
+	for (next_offset = FXSAVE_SIZE + XSAVE_HDR_SIZE, i = FIRST_EXTENDED_XFEATURE;
+	     i <= feature_nr; i++) {
+		if (!(mask & BIT_ULL(i)))
+			continue;
+
+		offset = xstate_64byte_aligned[i] ? ALIGN(next_offset, 64) : next_offset;
+		next_offset += xstate_sizes[i];
+	}
+	return offset;
+}
+
 /**
  * calculate_xstate_buf_size_from_mask - Calculate an xstate buffer size
  * @mask:	A bitmap to tell which components to be saved in the buffer.
@@ -150,8 +177,8 @@ static bool xfeature_is_supervisor(int xfeature_nr)
  */
 unsigned int calculate_xstate_buf_size_from_mask(u64 mask)
 {
-	unsigned int size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
-	int i, nr;
+	unsigned int offset;
+	int nr;
 
 	if (!mask)
 		return 0;
@@ -167,7 +194,7 @@ unsigned int calculate_xstate_buf_size_from_mask(u64 mask)
 
 	nr = fls64(mask) - 1;
 	if (nr < FIRST_EXTENDED_XFEATURE)
-		return size;
+		return FXSAVE_SIZE + XSAVE_HDR_SIZE;
 
 	/*
 	 * Each state offset in the non-compacted format is fixed. Take the
@@ -180,15 +207,8 @@ unsigned int calculate_xstate_buf_size_from_mask(u64 mask)
 	 * With the given mask, no relevant size is found so far. So,
 	 * calculate it by summing up each state size.
 	 */
-	for (i = FIRST_EXTENDED_XFEATURE; i <= nr; i++) {
-		if (!(mask & BIT_ULL(i)))
-			continue;
-
-		if (xstate_64byte_aligned[i])
-			size = ALIGN(size, 64);
-		size += xstate_sizes[i];
-	}
-	return size;
+	offset = get_xstate_comp_offset(mask, nr);
+	return offset + xstate_sizes[nr];
 }
 
 /*
@@ -941,19 +961,29 @@ void fpu__resume_cpu(void)
  */
 static void *__raw_xsave_addr(struct fpu *fpu, int xfeature_nr)
 {
+	unsigned int offset;
 	void *xsave;
 
 	if (!xfeature_enabled(xfeature_nr)) {
-		WARN_ON_FPU(1);
-		return NULL;
-	}
+		goto not_found;
+	} else if (!fpu) {
+		xsave = &init_fpstate.xsave;
 
-	if (fpu)
+		offset = get_xstate_comp_offset(xfeatures_mask_all, xfeature_nr);
+		if (offset > sizeof(init_fpstate))
+			goto not_found;
+	} else if (!(fpu->state_mask & BIT_ULL(xfeature_nr))) {
+		goto not_found;
+	} else {
 		xsave = &fpu->state->xsave;
-	else
-		xsave = &init_fpstate.xsave;
+		offset = get_xstate_comp_offset(fpu->state_mask, xfeature_nr);
+	}
+
+	return xsave + offset;
 
-	return xsave + xstate_comp_offsets[xfeature_nr];
+not_found:
+	WARN_ON_FPU(1);
+	return NULL;
 }
 /*
  * Given the xsave area and a state inside, this function returns the
-- 
2.17.1

